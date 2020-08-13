Return-Path: <SRS0=dFdc=BX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EA3FC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Aug 2020 10:23:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 63A7020768
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Aug 2020 10:23:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726224AbgHMKXF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Aug 2020 06:23:05 -0400
Received: from mx2.suse.de ([195.135.220.15]:39220 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726048AbgHMKXB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Aug 2020 06:23:01 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id E8798AE16;
        Thu, 13 Aug 2020 10:23:21 +0000 (UTC)
Date:   Thu, 13 Aug 2020 12:22:58 +0200
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
Message-ID: <20200813102258.GL12903@alley>
References: <1597120822-11999-1-git-send-email-orsonzhai@gmail.com>
 <20200811094413.GA12903@alley>
 <87zh7175hj.fsf@nanos.tec.linutronix.de>
 <20200811130218.GI6215@alley>
 <20200813015500.GC2020879@jagdpanzerIV.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200813015500.GC2020879@jagdpanzerIV.localdomain>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 2020-08-13 10:55:00, Sergey Senozhatsky wrote:
> On (20/08/11 15:02), Petr Mladek wrote:
> > On Tue 2020-08-11 14:05:12, Thomas Gleixner wrote:
> > > Petr Mladek <pmladek@suse.com> writes:
> > > > At least "crash" tool would need an update anyway. AFAIK, it checks
> > > > the size of struct printk_log and refuses to read it when it changes.
> > > >
> > > > It means that the hack with VMCOREINFO_FIELD_OFFSET probably is not
> > > > needed because we would need to update the crashdump-related tools anyway.
> > > >
> > > > Well, the timing is good. We are about to switch the printk ring
> > > > buffer into a lockless one. It requires updating the crashdump tools
> > > > as well. We could do this at the same time. The lockless ring buffer
> > > > already is in linux-next. It is aimed for 5.10 or 5.11.
> > > ...
> > > > It would be great to synchronize all these changes changes of the
> > > > printk log buffer structures.
> > > 
> > > I agree that having one update is a good thing, but pretty please can we
> > > finally make progress with this and not create yet another dependency?
> > 
> > To make it clear. I definitely do not want to block lockless printk by
> > this.
> > 
> > BTW: I am not 100% convinced that storing all three timestamps is
> > worth it. It increases the code complexity, metadata size. It needs
> > an interface with the userspace that has to stay backward compatible.
> 
> Can we, perhaps, store those various "alternative" timestamps in dict so
> then whoever wants to read them can just parse the dict key:value pairs
> attach to each printk message?

Interesting idea. It might be a way how to add optional metadata
without breaking compatibility with crashdump tools.

Well, I have bad feeling about it. Some of the reasons might be:

  + would take more space (prefix + text vs. binary representation)
  + not reliable because dict is currently dropped when no space
  + it would make the controversial dictionary feature more important


I would prefer to solve this by storing the timestamps in the
structure with metadata.

Best Regards,
Petr
