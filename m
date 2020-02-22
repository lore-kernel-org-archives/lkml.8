Return-Path: <SRS0=8jYG=4K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D610FC35669
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Feb 2020 23:59:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC56A20707
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Feb 2020 23:59:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uI78GAmG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727108AbgBVX5O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Feb 2020 18:57:14 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:39294 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726865AbgBVX5N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Feb 2020 18:57:13 -0500
Received: by mail-qk1-f195.google.com with SMTP id e16so2744664qkl.6
        for <linux-kernel@vger.kernel.org>; Sat, 22 Feb 2020 15:57:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=x3kNv1Qo240QfKiRXPHrXVP2xwNuaSo/ZPmgca9G6zk=;
        b=uI78GAmGOCdbULOlC+/g+i08hNp2OlgSgaGnHvs01r4HehJ0GPr61JHC/dvRK6UZbE
         odgsNZCScJbd/v6Xzrn+5l2/FjC7M0Sd+DzD4oKsCZRh80NJvNLbrwkoPNPLvc2rxR1Y
         O/GninOVEFOfwC9qOIR3ytdnsmuhwt4PL89Zp2TebcvPbIUvJk14wvbyEcs6joJ8OmUL
         CeVchfd/mkvoTacyDyMXnWXVhx9Ci08RNr3+7XBaWwJ03iOMunv5jhxQ8lPUKcQKpUIf
         Psj/UWz/KEk3MvevIZ5FxLcssPe2oOJofulQkwNXZZi9lp2Q4ZNtZAmKZ7TVeWoUfc0g
         MqDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:date:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=x3kNv1Qo240QfKiRXPHrXVP2xwNuaSo/ZPmgca9G6zk=;
        b=RxUB+pYj8zcnDSBJZ/dBlUHtHi8A2xB3E0SRPMip8k0AIwi+fqpBH9wkG5Y/KIX17/
         3zGcy4JvVG7GLRDW0BsITQoviTtDWgDwTOCaERwLBpJGvG0yHKZYleIQg3sYxUzu/mrQ
         KpOOHc71CIRxWd1ej12t+PPGr8NSLn5PW7MNuP2zexKvRI0m/MnAAVFWLSLkUTw1FhTg
         QaSBmGzXDhklh997W7BWAcUW8pLgUDp7lEQntuHiTupy6GPwAJJltZr7jOasl/vNRnZY
         wI8xpt2nBLWG9egNrK0pHOVFS+vsBAM5HeKOKpGMARgu5XoWdLAEmSZfXITAo3MDtqhw
         G9Yg==
X-Gm-Message-State: APjAAAU+K5yQo5VN1gJS0mOCVmT1ODbgwVletugl4TWOkVb8+dPGSlYX
        inmjywLIUPLK4e3W0z92e5I=
X-Google-Smtp-Source: APXvYqwNiN9O2wYZSCOb0Hl7BHpnlRomDDawwk/27k2zInDHWUT/mh47f0i0Q+HicW2AQ9szw6uEXg==
X-Received: by 2002:a37:4a46:: with SMTP id x67mr36506139qka.160.1582415832601;
        Sat, 22 Feb 2020 15:57:12 -0800 (PST)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id o7sm3800660qkd.119.2020.02.22.15.57.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Feb 2020 15:57:12 -0800 (PST)
From:   Arvind Sankar <nivedita@alum.mit.edu>
X-Google-Original-From: Arvind Sankar <arvind@rani.riverdale.lan>
Date:   Sat, 22 Feb 2020 18:57:10 -0500
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Arvind Sankar <nivedita@alum.mit.edu>,
        Borislav Petkov <bp@alien8.de>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Michael Matz <matz@suse.de>, Fangrui Song <maskray@google.com>,
        Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH] x86/boot/compressed: Fix compressed kernel linking with
 lld
Message-ID: <20200222235709.GA3786197@rani.riverdale.lan>
References: <20200222164419.GB3326744@rani.riverdale.lan>
 <20200222171859.3594058-1-nivedita@alum.mit.edu>
 <20200222181413.GA22627@ubuntu-m2-xlarge-x86>
 <20200222185806.ywnqhfqmy67akfsa@google.com>
 <20200222201715.GA3674682@rani.riverdale.lan>
 <20200222210101.diqw4zt6lz42ekgx@google.com>
 <CAKwvOdn2pmRqJ+Rs+dhAPJy3hOb4VNn70XB40jcVgTeM8XmeFQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAKwvOdn2pmRqJ+Rs+dhAPJy3hOb4VNn70XB40jcVgTeM8XmeFQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 22, 2020 at 03:33:20PM -0800, Nick Desaulniers wrote:
> 
> Ah, yikes.  For reference, please see my commit:
> 
> commit b059f801a937 ("x86/purgatory: Use CFLAGS_REMOVE rather than
> reset KBUILD_CFLAGS")
> 
> I'm of the conviction that reassigning KBUILD_CFLAGS via `:=`, as
> opposed to strictly filtering flags out of it or appending to it, is
> an antipattern.  We very very carefully construct KBUILD_CFLAGS in top
> level and arch/ Makefiles, and it's very easy to miss a flag or to
> when you "reset" KBUILD_CFLAGS.
> 
> *Boom* Case in point.
> 
> I meant to audit the rest of the places we do this in the kernel, but
> haven't had the time to revisit arch/x86/boot/compressed/Makefile.
> 
> For now, I suggest:
> 1. revert `Commit TBD ("x86/boot/compressed: Remove unnecessary
> sections from bzImage")` as it runs afoul differences in `*` for
> `DISCARD` sections between linkers, as the intent was to remove
> .eh_frame, of which it's less work to not generate them in the first
> place via compiler flag, rather than generate then discard via linker.
> 2. simply add `KBUILD_CFLAGS += -fno-asynchronous-unwind-tables` to
> arch/x86/boot/compressed/Makefile with Fangrui's Sugguested-by tag.
> 3. Remind me to revisit my proposed cleanup of
> arch/x86/boot/compressed/Makefile (which eventually will undo #2). ;)
> 4. tglx to remind me that my compiler is broken and that I should fix it. :P

Ok. For reference, note that arch/x86/boot/Makefile also redefines
KBUILD_CFLAGS and missed this option, which is why commit 163159aad74d
("x86/boot: Discard .eh_frame sections") was necessary.

There's also arch/x86/realmode/rm/Makefile as well.

There's also a bunch of places where the CFLAGS_REMOVE have fallen
behind the times -- they remove only -pg rather than CC_FLAGS_FTRACE.
Probably harmless currently since the other flags should be ineffective
without the -pg but might want to clean this up as well.
