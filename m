Return-Path: <SRS0=GvTR=3A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2FD1C282DD
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jan 2020 17:20:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A52B12084D
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jan 2020 17:20:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O8W2kT8S"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730591AbgAKRUv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Jan 2020 12:20:51 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:47029 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730519AbgAKRUv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Jan 2020 12:20:51 -0500
Received: by mail-qt1-f196.google.com with SMTP id g1so5082300qtr.13
        for <linux-kernel@vger.kernel.org>; Sat, 11 Jan 2020 09:20:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=TAr5OK9nYYr6KPzytVTTj/GP8wLPVsT/jCkjRteOAkU=;
        b=O8W2kT8SOx19v+19A/C+AcDBh/FhX6z5VriorQFDMEZcnoi5Tet7IdI2bw5BMOR9EF
         ZCoV5kyUP4L9W9OAYEsfW7b6OnTHCQ1nDRYbX22msxD6cljwazHyAPNgwu4NUYAm7KG/
         6nheoLEb+QockYF74HAQjxFezhfLkiRFaPYW99vnD+b22ODx5F3xqlYiKhX7RMHFLY2t
         BqaTKn1cL3gsH+g9mEwtZtTXrnBHoL8eqpv0yZ5dAenQqXlNYdWKO8uPUgM06bkIee62
         q/V5tKltz+gAQFSMqLSGF29JMYv1ei/Ww2SQGGPZx0SBQu8/Vhm1Rp4yTRRpxW5aGQIh
         xq+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:date:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=TAr5OK9nYYr6KPzytVTTj/GP8wLPVsT/jCkjRteOAkU=;
        b=tsw7fvBON+1dlWYTHVO7Icba4bNNGbntB3BqjKunBHglgrjymYIpdoQA3fpHNWWnU3
         CfIymy5CWBxK1rQk/DzNPY4+07dCuCuf5JqSFqKtv6a8c64Sh1y80QJBY5PFse0L1hOY
         LxWnZrNgXxQDe2jWG1gvoL5ggSIZFWaQayqAiZxM6ilK8fKCDz8u0rrz1xHOGGBLp0OA
         GSUchG0nJTXo3rJ51Ktul67+g9Tc4XMobDd0gJHSeJ3pM8rjmypqGfsU54HJBJWkkdvy
         SYopSS7F1B0tTpSEE8dzpVEB3nXdewdZf1NaW2R70QroELgRmPvY9WP9+b+pmoUc2J3t
         tNhw==
X-Gm-Message-State: APjAAAUjK4WLZ6rE6ZJRC1+7um1YagwWrXDLLmDqgRXLS8eODqevUN6p
        esJBXecbz8yBI8FjTf2kbe8=
X-Google-Smtp-Source: APXvYqz8ylDO2U6dDvIUNFaNKDnjjA8WiIyQkYSfmJM9vJQfD3R856oyQ2fHMJSJKdR4OYjIYUWcOw==
X-Received: by 2002:ac8:2bcd:: with SMTP id n13mr3779069qtn.21.1578763250270;
        Sat, 11 Jan 2020 09:20:50 -0800 (PST)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id 65sm2866876qtf.95.2020.01.11.09.20.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Jan 2020 09:20:49 -0800 (PST)
From:   Arvind Sankar <nivedita@alum.mit.edu>
X-Google-Original-From: Arvind Sankar <arvind@rani.riverdale.lan>
Date:   Sat, 11 Jan 2020 12:20:48 -0500
To:     Borislav Petkov <bp@alien8.de>
Cc:     Arvind Sankar <nivedita@alum.mit.edu>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, Kees Cook <keescook@chromium.org>,
        Thomas Lendacky <Thomas.Lendacky@amd.com>
Subject: Re: [PATCH] x86/tools/relocs: Add _etext and __end_of_kernel_reserve
 to S_REL
Message-ID: <20200111172047.GA2688392@rani.riverdale.lan>
References: <20200110202349.1881840-1-nivedita@alum.mit.edu>
 <20200110203828.GK19453@zn.tnic>
 <20200110205028.GA2012059@rani.riverdale.lan>
 <20200111130243.GA23583@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200111130243.GA23583@zn.tnic>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 11, 2020 at 02:02:43PM +0100, Borislav Petkov wrote:
> On Fri, Jan 10, 2020 at 03:50:29PM -0500, Arvind Sankar wrote:
> > On Fri, Jan 10, 2020 at 09:38:28PM +0100, Borislav Petkov wrote:
> > > On Fri, Jan 10, 2020 at 03:23:49PM -0500, Arvind Sankar wrote:
> > > > Pre-2.23 binutils makes symbols defined outside sections absolute, so
> > > > these two symbols break the build on old linkers.
> > > 
> > > -ENOTENOUGHINFO
> > > 
> > > Which old linkers, how exactly do they break the build, etc etc?
> > > 
> > > Please give exact reproduction steps.
> > > 
> > > Thx.
> > > 
> > 
> > binutils-2.21 and -2.22. An x86-64 defconfig will fail with
> > 	Invalid absolute R_X86_64_32S relocation: _etext
> > and after fixing that one, with
> > 	Invalid absolute R_X86_64_32S relocation: __end_of_kernel_reserve
> 
> I'm still not clear as to why this happens. I tried reproducing on
> openSUSE 12.1 which has
> 
> Repository: openSUSE-12.1-Oss
> Name: binutils
> Version: 2.21.1-12.1.4
> 
> and the build there fails with:
> 
> objdump: arch/x86/lib/clear_page_64.o: File format not recognized
> objdump: arch/x86/lib/cmdline.o: File format not recognized
> objdump: arch/x86/lib/cmpxchg16b_emu.o: File format not recognized
> objdump: arch/x86/lib/copy_page_64.o: File format not recognized
> objdump: arch/x86/lib/copy_user_64.o: File format not recognized
> objdump: arch/x86/lib/cpu.o: File format not recognized
> ...
> 
> and objdump is part of binutils.
> 
> Now, this looks like another symptom of what you're reporting but what
> we're missing is the rootcause about *why* this happens.
> 
> Because if the issue is hard to fix or similar, then we probably should
> raise the minimum supported binutils version from 2.21 to something
> newer and not do this fix.
> 
> But before we do that, we need a proper analysis as to why it happens.
> 
> Also, what distro are you using to reproduce it on?
> 
> Thx.
> 

I'm not sure if that's the same issue. The root cause for the one I
reported is described in more detail in [1], and the change that makes
these symbols no longer absolute is commit d2667025dd30 in binutils-gdb
(sourceware.org seems to be taking too long to respond from here so I
don't have the web link).

I'm running gentoo, but building the kernel using binutils-2.21.1
compiled from the GNU source tarball, and gcc-4.6.4 again compiled from
source. (It's not something I normally need but I was investigating
something else to see what exactly happens with older toolchains.)

I used the below to compile the kernel (I added in
readelf/objdump/objcopy just now, and it does build until the relocs
error). The config is x86-64 defconfig with CONFIG_RETPOLINE overridden
to n (since gcc 4.6.4 doesn't support retpoline).

make O=~/kernel64 -j LD=~/old/bin/ld AS=~/old/bin/as READELF=~/old/bin/readelf \
	OBJDUMP=~/old/bin/objdump OBJCOPY=~/old/bin/objcopy GCC=~/old/bin/gcc

[1] https://lore.kernel.org/lkml/20200110215005.2164353-1-nivedita@alum.mit.edu/
