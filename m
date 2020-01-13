Return-Path: <SRS0=WByN=3C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE84BC33CA9
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 23:38:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE5032080D
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 23:38:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aeXyjC0I"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729085AbgAMXid (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jan 2020 18:38:33 -0500
Received: from mail-qv1-f68.google.com ([209.85.219.68]:40086 "EHLO
        mail-qv1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728769AbgAMXid (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jan 2020 18:38:33 -0500
Received: by mail-qv1-f68.google.com with SMTP id dp13so4861683qvb.7
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jan 2020 15:38:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=SvvC5/J9xQahIMTC+riQHl1QpQjv6jCMZ1dJFy4P8xc=;
        b=aeXyjC0ISSVaDLyhH85V9ZPYGGZPEqTz8eY1Dz43DjlN87H8nj0a4L5BNcgHVv/heK
         Wg2N5oQdR33gnkKZ6e6Vfh4XN3oWcWqkOdHY3/B6m7FGU3XrhuXI1WSRLT+vskX1pt1M
         ozCoPlqlfLpENW0sgK+T96RNUAjr3xw6g2YvagIonnj5ATDumoxXQD57mF40wC1mRfQm
         Vb7Lm/DTILuCHjShFl4S1bkcpwmkt+1qguCJJpIYF8ZdEDWeQQbHWTkJKnvnUD0G3/ha
         eSJgRHitVq46jhXbjhXDE0rgY8zn3NvMlfw8KKfroBHp21NiudWdq6JuearcbfQH8WM6
         3hKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:date:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=SvvC5/J9xQahIMTC+riQHl1QpQjv6jCMZ1dJFy4P8xc=;
        b=fCLsAn05jDAyZyrVqsJFLHkLW4r3lt927NODB2m+Le8DKOwxoPFm2UOhcqKJO4beYK
         CQwbRAqMmnjKe5j7FpTB1NQvtDjSMPWmtz/8mm7qZAy+ezGwS3U0POf1dstBhja2yiqH
         JZ4rsroBlajwfWETwg+JuJFf5I1K61tc4cjKNxCwkTBqQlalbNWI3Rzg33x1E+0HX4i3
         lRO8IYE54nljRTgXBtrHdAb6rECnVXqLLHJleke2JFR32Ua7JbLNgQNYABf4ov0PqSde
         vdOPm0n03gH2sxirR7b0Ls2wF3LaJPRfRPlYO93q6WK2BFRFY/Fu7j8DE0LVaypog5xK
         Q4mA==
X-Gm-Message-State: APjAAAWoXJiBGg+Ot+l7zKf9elVmVtflcNZOeHjiyEQujK3DSfZnKn/3
        6nKUIy4wHq0Q61uSUG6d5U0=
X-Google-Smtp-Source: APXvYqyT23I9GBW3yOrOJKDsclepwXNGXPMNRq+cujYGQz62QAyr3kFRutpp+AMF0kyc+U8MMr3SWQ==
X-Received: by 2002:a05:6214:3e7:: with SMTP id cf7mr13990133qvb.129.1578958712235;
        Mon, 13 Jan 2020 15:38:32 -0800 (PST)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id k22sm5828768qkg.80.2020.01.13.15.38.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jan 2020 15:38:32 -0800 (PST)
From:   Arvind Sankar <nivedita@alum.mit.edu>
X-Google-Original-From: Arvind Sankar <arvind@rani.riverdale.lan>
Date:   Mon, 13 Jan 2020 18:38:29 -0500
To:     Borislav Petkov <bp@alien8.de>
Cc:     Arvind Sankar <nivedita@alum.mit.edu>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, Kees Cook <keescook@chromium.org>,
        Thomas Lendacky <Thomas.Lendacky@amd.com>
Subject: Re: [PATCH] x86/tools/relocs: Add _etext and __end_of_kernel_reserve
 to S_REL
Message-ID: <20200113233829.GB2000869@rani.riverdale.lan>
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

I tried out OpenSUSE 12.1 in a VM, and this one seems to be related to
something that changes in the build when libelf-devel is installed.
Deleting that package and switching UNWINDER_ORC (which says it requires
libelf-devel) to UNWINDER_FRAME_POINTER builds without the file format
errors.

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
> -- 
> Regards/Gruss,
>     Boris.
> 
> https://people.kernel.org/tglx/notes-about-netiquette
