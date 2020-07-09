Return-Path: <SRS0=8wH5=AU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9C2AC433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 14:41:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B41392073A
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 14:41:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727907AbgGIOlq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jul 2020 10:41:46 -0400
Received: from mx2.suse.de ([195.135.220.15]:39798 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726819AbgGIOlq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jul 2020 10:41:46 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 16E0BAB7D;
        Thu,  9 Jul 2020 14:41:45 +0000 (UTC)
Date:   Thu, 9 Jul 2020 16:41:44 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Cc:     John Ogness <john.ogness@linutronix.de>,
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
Message-ID: <20200709144144.GL4751@alley>
References: <20200707145932.8752-5-john.ogness@linutronix.de>
 <20200709071411.GR3874@shao2-debian>
 <20200709083323.GA572@jagdpanzerIV.localdomain>
 <874kqhm1v8.fsf@jogness.linutronix.de>
 <20200709105906.GC11164@alley>
 <20200709111310.GD11164@alley>
 <87zh89kkek.fsf@jogness.linutronix.de>
 <20200709122448.GJ4751@alley>
 <20200709130758.GB4380@jagdpanzerIV.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200709130758.GB4380@jagdpanzerIV.localdomain>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 2020-07-09 22:07:58, Sergey Senozhatsky wrote:
> On (20/07/09 14:25), Petr Mladek wrote:
> > On Thu 2020-07-09 13:23:07, John Ogness wrote:
> > > On 2020-07-09, Petr Mladek <pmladek@suse.com> wrote:
> > > > I though more about it. IMHO, it will be better to modify
> > > > prb_first_seq() to do the same cycle as prb_next_seq()
> > > > and return seq number of the first valid entry.
> > > 
> > > Exactly!
> > > 
> > > Here is a patch that does just that. I added a prb_first_valid_seq()
> > > function and made prb_first_seq() static. (The ringbuffer still needs
> > > prb_first_seq() for itself.)
> > 
> > The fix looks fine to me:
> 
> Yeah, looks right to me as well.
> 
> > It means that we have two fixes on top of the original patchset. Could
> > you please send v5 with the two fixes integrated? I would just squash
> > them into the 4th patch.
> 
> I'd prefer v5, if possible.

Ah, my paragraph was confusing. I'd prefer v5 as well.

Best Regards,
Petr
