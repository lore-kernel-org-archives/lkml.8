Return-Path: <SRS0=NqQd=7Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CE6AC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 07:58:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D4CD7204EA
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 07:58:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726805AbgFKH6X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jun 2020 03:58:23 -0400
Received: from mx2.suse.de ([195.135.220.15]:52810 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726694AbgFKH6X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jun 2020 03:58:23 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id D33BBACF9;
        Thu, 11 Jun 2020 07:58:23 +0000 (UTC)
Date:   Thu, 11 Jun 2020 09:58:18 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Daniel Thompson <daniel.thompson@linaro.org>
Cc:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Sumit Garg <sumit.garg@linaro.org>,
        Jason Wessel <jason.wessel@windriver.com>,
        Douglas Anderson <dianders@chromium.org>,
        kgdb-bugreport@lists.sourceforge.net,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        John Ogness <john.ogness@linutronix.de>
Subject: Re: [PATCH] printk/kdb: Redirect printk messages into kdb in any
 context
Message-ID: <20200611075818.GC6581@linux-b0ei>
References: <1589273314-12060-1-git-send-email-sumit.garg@linaro.org>
 <20200512142533.ta4uejwmq5gchtlx@holly.lan>
 <CAFA6WYOV7oPbYE=9fXueYMacb5wv0r9T6F8tmECt-Eafe-fctw@mail.gmail.com>
 <20200514084230.GO17734@linux-b0ei>
 <CAFA6WYPSsgdAB-wJC0e2YkVkW0XsqQsu5wrn4iB4M-cwvS7z2g@mail.gmail.com>
 <20200515085021.GS17734@linux-b0ei>
 <20200515103308.GD42471@jagdpanzerIV.localdomain>
 <CAFA6WYOBsimP1j8Fwq4OcePEug4MGoaY3wTTTVydHtTphZ-FTw@mail.gmail.com>
 <20200515163638.GI42471@jagdpanzerIV.localdomain>
 <20200610164140.tgzcn5oip2gzgmze@holly.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200610164140.tgzcn5oip2gzgmze@holly.lan>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 2020-06-10 17:41:40, Daniel Thompson wrote:
> On Sat, May 16, 2020 at 01:36:38AM +0900, Sergey Senozhatsky wrote:
> > On (20/05/15 17:32), Sumit Garg wrote:
> > > > Can I please have some context what problem does this solve?
> > > 
> > > You can find the problem description here [1] which leads to this fix.
> > 
> > [..]
> > 
> > > [1] https://lkml.org/lkml/2020/5/12/213
> > 
> > Thanks for the link. I'm slightly surprised it took so many years
> > to notice the addition of printk_nmi/printk_safe :)
> 
> Rather by coincidence (at least I think its a coincidence) the problem
> has recently become much more obvious.
> 
> 0d00449c7a28 ("x86: Replace ist_enter() with nmi_enter()") just brought
> this to the surface by treating debug traps as NMIs. This means the CPU
> that takes a breakpoint, and where almost all of the kdb printk() calls
> take place, will now unconditionally have printk() interception enabled.

Mea culpa. I have marked this patch as proceed by mistake. It has got
enough acks and is ready for 5.8.

I have just commited the patch into printk/linux.git,
branch for-5.8-kdb-nmi.

I am going to push it to Linus when it passes linux-next integration,
hopefully tomorrow.

Thanks a lot for poking me.

Best Regards,
Petr
