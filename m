Return-Path: <SRS0=GvTR=3A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF218C33C9E
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jan 2020 13:02:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8C932072E
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jan 2020 13:02:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="grjv1YrP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729573AbgAKNCw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Jan 2020 08:02:52 -0500
Received: from mail.skyhub.de ([5.9.137.197]:51436 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729468AbgAKNCw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Jan 2020 08:02:52 -0500
Received: from zn.tnic (p200300EC2F1E140059EC870F21D98201.dip0.t-ipconnect.de [IPv6:2003:ec:2f1e:1400:59ec:870f:21d9:8201])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id E49F71EC02A3;
        Sat, 11 Jan 2020 14:02:50 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1578747771;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=3EhS3rlRKioZcKfKMZ9vFXvnyxSNnulC/kahqWIylC0=;
        b=grjv1YrPTLradsLrAe4U65/skQdlInUnF0dTxHdSaGrQd5hRRQmNPGQlnNKhKkv0vPOg8G
        QnHSWo/aWnG97nXdM0sKnsqFoOcFcRPX/9GdgINg4FUkOzLvCx3qlUhHEcPvCZEZ9Z/VFM
        6384B1Wm0r2j3zM12aDPnR9I07W/d38=
Date:   Sat, 11 Jan 2020 14:02:43 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Arvind Sankar <nivedita@alum.mit.edu>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, Kees Cook <keescook@chromium.org>,
        Thomas Lendacky <Thomas.Lendacky@amd.com>
Subject: Re: [PATCH] x86/tools/relocs: Add _etext and __end_of_kernel_reserve
 to S_REL
Message-ID: <20200111130243.GA23583@zn.tnic>
References: <20200110202349.1881840-1-nivedita@alum.mit.edu>
 <20200110203828.GK19453@zn.tnic>
 <20200110205028.GA2012059@rani.riverdale.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200110205028.GA2012059@rani.riverdale.lan>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 10, 2020 at 03:50:29PM -0500, Arvind Sankar wrote:
> On Fri, Jan 10, 2020 at 09:38:28PM +0100, Borislav Petkov wrote:
> > On Fri, Jan 10, 2020 at 03:23:49PM -0500, Arvind Sankar wrote:
> > > Pre-2.23 binutils makes symbols defined outside sections absolute, so
> > > these two symbols break the build on old linkers.
> > 
> > -ENOTENOUGHINFO
> > 
> > Which old linkers, how exactly do they break the build, etc etc?
> > 
> > Please give exact reproduction steps.
> > 
> > Thx.
> > 
> 
> binutils-2.21 and -2.22. An x86-64 defconfig will fail with
> 	Invalid absolute R_X86_64_32S relocation: _etext
> and after fixing that one, with
> 	Invalid absolute R_X86_64_32S relocation: __end_of_kernel_reserve

I'm still not clear as to why this happens. I tried reproducing on
openSUSE 12.1 which has

Repository: openSUSE-12.1-Oss
Name: binutils
Version: 2.21.1-12.1.4

and the build there fails with:

objdump: arch/x86/lib/clear_page_64.o: File format not recognized
objdump: arch/x86/lib/cmdline.o: File format not recognized
objdump: arch/x86/lib/cmpxchg16b_emu.o: File format not recognized
objdump: arch/x86/lib/copy_page_64.o: File format not recognized
objdump: arch/x86/lib/copy_user_64.o: File format not recognized
objdump: arch/x86/lib/cpu.o: File format not recognized
...

and objdump is part of binutils.

Now, this looks like another symptom of what you're reporting but what
we're missing is the rootcause about *why* this happens.

Because if the issue is hard to fix or similar, then we probably should
raise the minimum supported binutils version from 2.21 to something
newer and not do this fix.

But before we do that, we need a proper analysis as to why it happens.

Also, what distro are you using to reproduce it on?

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
