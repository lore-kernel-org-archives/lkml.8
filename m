Return-Path: <SRS0=PfNx=4F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FE64C34021
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 15:40:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E6D4208C4
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 15:40:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729052AbgBQPk3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Feb 2020 10:40:29 -0500
Received: from mx2.suse.de ([195.135.220.15]:37328 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728292AbgBQPk3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Feb 2020 10:40:29 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 7242BADD9;
        Mon, 17 Feb 2020 15:40:27 +0000 (UTC)
Date:   Mon, 17 Feb 2020 16:40:26 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     lijiang <lijiang@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrea Parri <parri.andrea@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        kexec@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: crashdump: Re: [PATCH 2/2] printk: use the lockless ringbuffer
Message-ID: <20200217154026.7x2xyrklprgql4if@pathway.suse.cz>
References: <20200128161948.8524-1-john.ogness@linutronix.de>
 <20200128161948.8524-3-john.ogness@linutronix.de>
 <ccbe1383-a4a4-41f8-3330-972f03c97429@redhat.com>
 <87zhdle0s5.fsf@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87zhdle0s5.fsf@linutronix.de>
User-Agent: NeoMutt/20170912 (1.9.0)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 2020-02-14 14:50:02, John Ogness wrote:
> Hi Lianbo,
> 
> On 2020-02-14, lijiang <lijiang@redhat.com> wrote:
> >> diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
> >> index 1ef6f75d92f1..d0d24ee1d1f4 100644
> >> --- a/kernel/printk/printk.c
> >> +++ b/kernel/printk/printk.c
> >> @@ -1062,21 +928,16 @@ void log_buf_vmcoreinfo_setup(void)
> >>  {
> >>  	VMCOREINFO_SYMBOL(log_buf);
> >>  	VMCOREINFO_SYMBOL(log_buf_len);
> >
> > I notice that the "prb"(printk tb static) symbol is not exported into
> > vmcoreinfo as follows:
> >
> > +	VMCOREINFO_SYMBOL(prb);
> >
> > Should the "prb"(printk tb static) symbol be exported into vmcoreinfo?
> > Otherwise, do you happen to know how to walk through the log_buf and
> > get all kernel logs from vmcore?
> 
> You are correct. This will need to be exported as well so that the
> descriptors can be accessed. (log_buf is only the pure human-readable
> text.) I am currently hacking the crash tool to see exactly what needs
> to be made available in order to access all the data of the ringbuffer.

I am not sure which parts you are working on. Are you going to provide
also patch for makedumpfile, please? I get the following failure when
creating the crashdump using:

    echo c >/proc/sysrq-trigger


The kernel version is not supported.
The makedumpfile operation may be incomplete.
dump_dmesg: Can't find variable-length record symbols
makedumpfile Failed.
Running makedumpfile --dump-dmesg /proc/vmcore failed (1).


Best Regards,
Petr
