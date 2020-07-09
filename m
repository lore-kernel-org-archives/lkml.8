Return-Path: <SRS0=8wH5=AU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2D3EC433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 10:59:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BC6602077D
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 10:59:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727059AbgGIK7J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jul 2020 06:59:09 -0400
Received: from mx2.suse.de ([195.135.220.15]:59602 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726387AbgGIK7J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jul 2020 06:59:09 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id AE140AE2D;
        Thu,  9 Jul 2020 10:59:06 +0000 (UTC)
Date:   Thu, 9 Jul 2020 12:59:06 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        kernel test robot <rong.a.chen@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrea Parri <parri.andrea@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Paul McKenney <paulmck@kernel.org>, kexec@lists.infradead.org,
        linux-kernel@vger.kernel.org, lkp@lists.01.org
Subject: Re: [printk] 18a2dc6982: ltp.kmsg01.fail
Message-ID: <20200709105906.GC11164@alley>
References: <20200707145932.8752-5-john.ogness@linutronix.de>
 <20200709071411.GR3874@shao2-debian>
 <20200709083323.GA572@jagdpanzerIV.localdomain>
 <874kqhm1v8.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <874kqhm1v8.fsf@jogness.linutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 2020-07-09 12:20:35, John Ogness wrote:
> On 2020-07-09, Sergey Senozhatsky <sergey.senozhatsky@gmail.com> wrote:
> > On (20/07/09 15:14), kernel test robot wrote:
> > [..]
> >
> > Took me a while to find the FAIL-ed test:
> >
> >> kmsg01.c:393: INFO: TEST: read returns EPIPE when messages get overwritten
> >> kmsg01.c:398: INFO: first seqno: 0
> >> kmsg01.c:411: INFO: first seqno now: 881
> >> kmsg01.c:425: FAIL: read returned: 77: SUCCESS (0)
> >
> > So this is seq number related
> > https://github.com/linux-test-project/ltp/blob/master/testcases/kernel/logging/kmsg/kmsg01.c#L383
> 
> Excellent test.
> 
> Since the messages are above the expected average size, the dataring is
> wrapping before the descriptor ring. This means that the initial
> descriptors are still there, but their data is gone. Initially I would
> generate an EPIPE for this, but it was changed. Here is the thread [0]
> we had about this.

I see. IMHO, the following should do the job. The check is done only
when the above prb_read_valid() succeeded. Therefore the printk_record
has to include a valid value. And it must be the first valid record
when some messages were lost.

diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 62fc1abd9c4d..5d4760b5c671 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -775,9 +775,9 @@ static ssize_t devkmsg_read(struct file *file, char __user *buf,
 		logbuf_lock_irq();
 	}
 
-	if (user->seq < prb_first_seq(prb)) {
+	if (user->seq < r->info->seq) {
 		/* our last seen message is gone, return error and reset */
-		user->seq = prb_first_seq(prb);
+		user->seq = r->info->seq;
 		ret = -EPIPE;
 		logbuf_unlock_irq();
 		goto out;


Best Regards,
Petr
