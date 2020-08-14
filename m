Return-Path: <SRS0=KEJG=BY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83B9AC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Aug 2020 09:51:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6866C204EA
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Aug 2020 09:51:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726923AbgHNJuf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Aug 2020 05:50:35 -0400
Received: from mx2.suse.de ([195.135.220.15]:33078 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726064AbgHNJue (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Aug 2020 05:50:34 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id DD077AD1B;
        Fri, 14 Aug 2020 09:50:55 +0000 (UTC)
Date:   Fri, 14 Aug 2020 11:50:31 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Orson Zhai <orsonzhai@gmail.com>,
        Prarit Bhargava <prarit@redhat.com>,
        Dave Young <dyoung@redhat.com>, Baoquan He <bhe@redhat.com>,
        Vivek Goyal <vgoyal@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        John Stultz <john.stultz@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>, kexec@lists.infradead.org,
        linux-kernel@vger.kernel.org, zhang.lyra@gmail.com,
        ruifeng.zhang1@unisoc.com, cixi.geng1@unisoc.com,
        Orson Zhai <orson.zhai@unisoc.com>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Steven Sistare <steven.sistare@oracle.com>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Jon DeVree <nuxi@vault24.org>,
        Salvatore Bonaccorso <carnil@debian.org>,
        John Ogness <john.ogness@linutronix.de>
Subject: Re: [RFC PATCH] printk: Change timestamp to triplet as mono, boot
 and real
Message-ID: <20200814095031.GM6215@alley>
References: <1597120822-11999-1-git-send-email-orsonzhai@gmail.com>
 <20200811094413.GA12903@alley>
 <87zh7175hj.fsf@nanos.tec.linutronix.de>
 <20200811130218.GI6215@alley>
 <20200813015500.GC2020879@jagdpanzerIV.localdomain>
 <20200813102258.GL12903@alley>
 <20200813113155.GA483@jagdpanzerIV.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200813113155.GA483@jagdpanzerIV.localdomain>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 2020-08-13 20:31:55, Sergey Senozhatsky wrote:
> On (20/08/13 12:22), Petr Mladek wrote:
> >
> >   + would take more space (prefix + text vs. binary representation)
> 
> Dict buffer is allocated regardless of how we use it, and only printks
> from drivers/* (dev_printk*) add dict payload. It might be the case
> that on some (if not most) systems dict pages are not used 90% of times
> (if not 99%).
> 
> >   + not reliable because dict is currently dropped when no space
> 
> Well, in the perfect world this is a problem, but "maybe not having
> alternative timestamps sometimes" can be OK approach for people who
> wants to use those triplet timestamps.

I am afraid the people would see missing timestamps as a bug.
They want it because they want to corelate kernel and userspace logs.
The timestamps from realtime clock are supposed to make it
straightforward.

More importantly. I do not see a reasonable way how to handle it.
No timestamp is worse than timestamps from non-synchronized clock.
Mixing timestamps from different clocks (as fallback) would cause
a lot of confusion (more harm than good).

> But, in general, how real this problem is? What I sae so far (on my boxes)
> was that printk messages are longer than dict payload.

Yeah, I think that dict are less used on normal systems. But it might
be very different when a driver gets more verbose during debugging
and the amount of dev_printk() calls is much higher.

Best Regards,
Petr
