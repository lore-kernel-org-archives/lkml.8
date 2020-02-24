Return-Path: <SRS0=7TUr=4M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD37DC35679
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 06:06:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F9EC20675
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 06:06:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ot+AvKO5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727197AbgBXGGZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Feb 2020 01:06:25 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:41214 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725895AbgBXGGZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Feb 2020 01:06:25 -0500
Received: by mail-pg1-f193.google.com with SMTP id 70so4557428pgf.8
        for <linux-kernel@vger.kernel.org>; Sun, 23 Feb 2020 22:06:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=OdpQqb2kq8nuRm39p8jYjh1NSdHdQem6gWj0Q4UrJjo=;
        b=Ot+AvKO5cJ/E19Gq7m3m2R0cMzvnC3yV5VU1R7NMipqEjTWmHa1wDX0xfkyt8qxOaN
         FrSUW8vV/IYd/8nXbJypv/S6V6gRToRy5M1rRcZnZGc4s0r0B9c8XSvxAvMU+m9pQDSU
         M1m2Q9k0lud7y+kUkk1vmdMSq+C/eTg/u9rzGIq9IFPObirWhVWShzgRYCVH3Xe8bcx1
         1RnD64wf6O2R2PFsFGCWUHi2JPI2EpjsL3d6813OI9uSODVzGTvbluSPjmIoJ8uHenaB
         lviwGO2sAADa2CC+OFcBCGc7A5f+Ex5I37Soo5rPAgZvEQmHLIpM5PcS8im1VUhIcXJv
         Nozw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=OdpQqb2kq8nuRm39p8jYjh1NSdHdQem6gWj0Q4UrJjo=;
        b=FNrs3M6W0rshXqPU7eNmqFBV9R9sNFeQe9HcsHqC2x4jfCDSL4z4Ef7fwsVbBuxjRu
         OS4gGNX7gmXcbg+CLaFZvc2YFeDYybENxgezVdf/p/sGhFQrsh/iTGaK7H2s4QMcYi21
         +Yw8sWCr3AcuFs48dZ/keRqtsjeGE+TfHmuJC/oiR5td+P6Sddmp8nB6wELXbivKTgyV
         L3vqQ/s0xcayb8ZyhAdovnzavDo+BqR4R8WgAklrE6CYt4w27Jh928E0FFpIpzA6NCrH
         YcqYcL7WYX/hz4GdIGqUJQOJW3JmVawwnCAuSpNQGTvSWGf+PjZowffNL0YBwwOBXZjz
         CdSA==
X-Gm-Message-State: APjAAAV8ynQYa+KGe70UbuaetiSOJWML0a0/0fL1SfSBS4xG7MDPWJ+y
        gsoGpUk7fKYCLs3stUpDDpcJHQ==
X-Google-Smtp-Source: APXvYqzP3sz0sfOybVHLMLGRXkpMQDbc6F4NJfyORdHrTi73nrL5VCz0TVPIPQigbNxCbXUUuJNU2w==
X-Received: by 2002:a63:e755:: with SMTP id j21mr51725951pgk.330.1582524382689;
        Sun, 23 Feb 2020 22:06:22 -0800 (PST)
Received: from google.com ([2620:15c:2ce:0:9efe:9f1:9267:2b27])
        by smtp.gmail.com with ESMTPSA id z19sm10910717pfn.49.2020.02.23.22.06.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Feb 2020 22:06:22 -0800 (PST)
Date:   Sun, 23 Feb 2020 22:06:18 -0800
From:   Fangrui Song <maskray@google.com>
To:     Kees Cook <keescook@chromium.org>,
        Arvind Sankar <nivedita@alum.mit.edu>
Cc:     Borislav Petkov <bp@alien8.de>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, X86 ML <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux@googlegroups.com, Michael Matz <matz@suse.de>
Subject: Re: [PATCH] x86/boot/compressed: Fix compressed kernel linking with
 lld
Message-ID: <20200224060618.blsbhilbmm6b23a2@google.com>
References: <20200222164419.GB3326744@rani.riverdale.lan>
 <20200222171859.3594058-1-nivedita@alum.mit.edu>
 <20200222181413.GA22627@ubuntu-m2-xlarge-x86>
 <20200222185806.ywnqhfqmy67akfsa@google.com>
 <20200222201715.GA3674682@rani.riverdale.lan>
 <20200222210101.diqw4zt6lz42ekgx@google.com>
 <CAGXu5jJQRnPQDq6ZLrtCB-i0A_+AifY2me-BinuKz7LJU8=ePQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <CAGXu5jJQRnPQDq6ZLrtCB-i0A_+AifY2me-BinuKz7LJU8=ePQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-02-23, Kees Cook wrote:
>On Sat, Feb 22, 2020 at 1:01 PM 'Fangrui Song' via Clang Built Linux
><clang-built-linux@googlegroups.com> wrote:
>> https://github.com/torvalds/linux/commit/83a092cf95f28696ddc36c8add0cf03ac034897f
>> added -Wl,--orphan-handling=warn to arch/powerpc/Makefile .
>> x86 can follow if that is appropriate.
>
>I've been playing with a series to do this, here:
>
>https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git/log/?h=linker/orphans/x86-arm
>
>There's some work to be done still...

Thanks for investigating this! There are a number of compiler options
which can add ad-hoc sections. They may need caution.


I just filed https://sourceware.org/bugzilla/show_bug.cgi?id=25591 "Should /DISCARD/ : { *(.symtab) *(.strtab) } work?"
Let's see what GNU ld will do...

Note that * can be refined to SHF_ALLOC sections
(https://sourceware.org/binutils/docs/ld/Input-Section-Basics.html):

   SECTIONS {
     .text : { *(.text) }
     /* This excludes .strtab / .symtab / .shstrtab */
     /* https://reviews.llvm.org/D72756 implemented INPUT_SECTION_FLAGS. Not included in LLVM release/10.* */
     /DISCARD/ : { INPUT_SECTION_FLAGS(SHF_ALLOC) *(*) }
   }


Just realized that this was reported as https://bugs.llvm.org/show_bug.cgi?id=44452
Looks like we will probably close it as wontfix.
