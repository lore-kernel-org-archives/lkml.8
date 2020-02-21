Return-Path: <SRS0=1210=4J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B824FC35646
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 15:29:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8FDF92073A
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 15:29:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729286AbgBUP3Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Feb 2020 10:29:24 -0500
Received: from isilmar-4.linta.de ([136.243.71.142]:43904 "EHLO
        isilmar-4.linta.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727053AbgBUP3Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Feb 2020 10:29:24 -0500
Received: by isilmar-4.linta.de (Postfix, from userid 1000)
        id CA5E9200B44; Fri, 21 Feb 2020 15:29:22 +0000 (UTC)
Date:   Fri, 21 Feb 2020 16:29:22 +0100
From:   Dominik Brodowski <linux@dominikbrodowski.net>
To:     Brian Gerst <brgerst@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Andy Lutomirski <luto@kernel.org>
Subject: Re: [PATCH 2/5] x86: Move 32-bit compat syscalls to common location
Message-ID: <20200221152922.4okzakixvlz5mpoh@isilmar-4.linta.de>
References: <20200221050934.719152-1-brgerst@gmail.com>
 <20200221050934.719152-3-brgerst@gmail.com>
 <20200221070704.GF3368@light.dominikbrodowski.net>
 <CAMzpN2hL=K9GVg91esHQwm+3LdG00X164k4qFn=HOwSev56DUg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMzpN2hL=K9GVg91esHQwm+3LdG00X164k4qFn=HOwSev56DUg@mail.gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 21, 2020 at 08:41:23AM -0500, Brian Gerst wrote:
> On Fri, Feb 21, 2020 at 2:07 AM Dominik Brodowski
> <linux@dominikbrodowski.net> wrote:
> >
> > On Fri, Feb 21, 2020 at 12:09:31AM -0500, Brian Gerst wrote:
> > > --- a/arch/x86/kernel/Makefile
> > > +++ b/arch/x86/kernel/Makefile
> > > @@ -57,6 +57,8 @@ obj-y                       += setup.o x86_init.o i8259.o irqinit.o
> > >  obj-$(CONFIG_JUMP_LABEL)     += jump_label.o
> > >  obj-$(CONFIG_IRQ_WORK)  += irq_work.o
> > >  obj-y                        += probe_roms.o
> > > +obj-$(CONFIG_X86_32) += sys_ia32.o
> > > +obj-$(CONFIG_IA32_EMULATION) += sys_ia32.o
> >
> > That doesn't look nicely...
> 
> Do you have a better suggestion?  That's similar to how tls.o is
> already handled.

Besides modifying Kconfig? No, unfortunately not.

Thanks,
	Dominik
