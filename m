Return-Path: <SRS0=1210=4J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4087BC35656
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 15:28:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 13559208E4
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 15:28:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729153AbgBUP2q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Feb 2020 10:28:46 -0500
Received: from isilmar-4.linta.de ([136.243.71.142]:43828 "EHLO
        isilmar-4.linta.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727851AbgBUP2p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Feb 2020 10:28:45 -0500
Received: by isilmar-4.linta.de (Postfix, from userid 1000)
        id 19552200B44; Fri, 21 Feb 2020 15:28:44 +0000 (UTC)
Date:   Fri, 21 Feb 2020 16:28:44 +0100
From:   Dominik Brodowski <linux@dominikbrodowski.net>
To:     Brian Gerst <brgerst@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Andy Lutomirski <luto@kernel.org>
Subject: Re: [PATCH 0/5] Enable pt_regs based syscalls for x86-32 native
Message-ID: <20200221152843.rxz4ptfi5lh3udud@isilmar-4.linta.de>
References: <20200221050934.719152-1-brgerst@gmail.com>
 <20200221060756.GA3368@light.dominikbrodowski.net>
 <CAMzpN2iQuaNdTdL6G1rGbUFo+r16iRFo1zbiD_VMrrjtGf0acw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMzpN2iQuaNdTdL6G1rGbUFo+r16iRFo1zbiD_VMrrjtGf0acw@mail.gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 21, 2020 at 08:15:19AM -0500, Brian Gerst wrote:
> On Fri, Feb 21, 2020 at 2:07 AM Dominik Brodowski
> <linux@dominikbrodowski.net> wrote:
> >
> > Brian,
> >
> > On Fri, Feb 21, 2020 at 12:09:29AM -0500, Brian Gerst wrote:
> > > This patch series cleans up the x86 syscall wrapper code and converts
> > > the 32-bit native kernel over to pt_regs based syscalls.
> >
> > thanks for your patchset. Could you explain a bit more what the rationale
> > is. Due to asmlinkage, it doesn't leak "random user-provided register
> > content down the call chain" (as was the case for x86-64). But it may be
> > cleaner, and you mention in patch 5/5 that the new way is "a bit more
> > efficient" -- do you have numbers?
> 
> The main rationale for this patch set is to make the 32-bit native
> kernel consistent with the 64-bit kernel.  It's also slightly more
> efficient because the old code pushed all 6 arguments onto the stack
> whereas the new code only reads the args the syscall needs, with the
> pt_regs pointer passed in through a register.  By efficient I mean
> that it uses fewer instructions and stack accesses, not that it will
> actually have a significant difference on a benchmark.

OK, could you add such an explanation to the patchset then, please? Thanks,
Dominik
