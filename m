Return-Path: <SRS0=fR4S=7I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2957EC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 17:13:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 06AF2207FB
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 17:13:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Oo5M/TaH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730092AbgEZRNt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 May 2020 13:13:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728138AbgEZRNr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 May 2020 13:13:47 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34C29C03E96D
        for <linux-kernel@vger.kernel.org>; Tue, 26 May 2020 10:13:47 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id t16so8922072plo.7
        for <linux-kernel@vger.kernel.org>; Tue, 26 May 2020 10:13:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Q2tb1AeXDG23hGcjPRVLc3Ey0WPkny9sKX+WHXY3/jE=;
        b=Oo5M/TaH3pNzpNedOe2MYvvOmsz2XJ84O5UlH4IlnyLsYMHsQ6bgeG7Q/WNWoSRWq1
         2OJlzomHtoAWDBvswVFFuexScHm5Fa/cQ/YraURXCayL3QB6c8VuweasdqaDaFoOx1nX
         BBQJuKDRuiyho3y4Doe0y4gAVgl/7WznfZcZK4PRpNyU1MXmCaBF+o6Tsm+KOdFKeXhO
         D5JU+mimzwLXKI/Yb7ODL5Cr9psd/pL4PEY7johaMnR3hqIFE35G3ki5ScjutK2XLjR1
         s1s+qOMAXpDBX/FzjSAKfYYajcPLruR5YvEpbLsMMKk+0ApEcK9nAD/kvrfzf2Sqzuth
         JQbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Q2tb1AeXDG23hGcjPRVLc3Ey0WPkny9sKX+WHXY3/jE=;
        b=nX1AkEYmqS8yYdqYkRxDOEA46kQdHds7jtRYleQ+WCVsLc4U3OQwJ0mRj/Ja2hTTNz
         bf3azB4up2RTKtJD/fND5ngnuOcA6/GG7+WPOz/j63iwVXH+aTQ/rUmA6t+EEKkZNhE+
         NyB82ArG2kftOFSqW8o6e91/NDX+BH2mp524EGyX4WiIhk9UWiEDQaZ2X1CH0ETGSzY5
         dwLcuwQqbU9XIQvVIwVgVHlfxDulprALlnYW9cNd1q27boYr2H6ONQbmJqw8U0K+zVMs
         W3v3i09gXhJGrkxMZruworNlUznEmCy9cpNqEVDIKbf2ee4+igHuMIbyEvEnHH0RNM2g
         GVag==
X-Gm-Message-State: AOAM530+OcO0RPhHoLZrAsECjXRGKU1iIacVAoqMHGgfdgv9V4+r4Z7c
        4Y6N7Ft9lhjGBbA2aCX0cmFBV9l84CvzfA==
X-Google-Smtp-Source: ABdhPJwoUaqy5Bl8ODQ3VUb6GKBRHOl8j5ZMl6fP/mhF/NAKEj5ubdbjbyZwMoacoCaw5JXdeK3DTA==
X-Received: by 2002:a17:90a:34cc:: with SMTP id m12mr238695pjf.123.1590513226563;
        Tue, 26 May 2020 10:13:46 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:0:9efe:9f1:9267:2b27])
        by smtp.gmail.com with ESMTPSA id g7sm55515pjs.48.2020.05.26.10.13.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2020 10:13:45 -0700 (PDT)
Date:   Tue, 26 May 2020 10:13:40 -0700
From:   Fangrui Song <maskray@google.com>
To:     Arvind Sankar <nivedita@alum.mit.edu>
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, X86 ML <x86@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Dmitry Golovin <dima@golovin.in>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Daniel Kiper <daniel.kiper@oracle.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 4/4] x86/boot: Check that there are no runtime
 relocations
Message-ID: <20200526171340.pdbautbix5ygdvgp@google.com>
References: <20200524212816.243139-1-nivedita@alum.mit.edu>
 <20200525225918.1624470-5-nivedita@alum.mit.edu>
 <CAMj1kXHc4o91VkaChoyVzr4w-HOaashMPtkCKLaszMGCxhR_2A@mail.gmail.com>
 <20200526151623.GB2190602@rani.riverdale.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20200526151623.GB2190602@rani.riverdale.lan>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2020-05-26, Arvind Sankar wrote:
>On Tue, May 26, 2020 at 08:11:56AM +0200, Ard Biesheuvel wrote:
>> On Tue, 26 May 2020 at 00:59, Arvind Sankar <nivedita@alum.mit.edu> wrote:
>> >  # Compressed kernel should be built as PIE since it may be loaded at any
>> >  # address by the bootloader.
>> > -KBUILD_LDFLAGS += $(call ld-option, -pie) $(call ld-option, --no-dynamic-linker)
>> > +KBUILD_LDFLAGS += -pie $(call ld-option, --no-dynamic-linker)
>>
>> Do we still need -pie linking with these changes applied?
>>
>
>I think it's currently not strictly necessary -- eg the 64bit kernel
>doesn't get linked as pie right now with LLD or old binutils. However,
>it is safer to do so to ensure that the result remains PIC with future
>versions of the linker. There are linker optimizations that can convert
>certain PIC instructions when PIE is disabled. While I think they
>currently all focus on eliminating indirection through the GOT (and thus
>wouldn't be applicable any more),

There are 3 forms described by x86-64 psABI B.2 Optimize GOTPCRELX Relocations

(1) movq foo@GOTPCREL(%rip), %reg -> leaq foo(%rip), %reg
(2) call *foo@GOTPCREL(%rip) -> nop; call foo
(3) jmp *foo@GOTPCREL(%rip) -> jmp foo; nop

ld.bfd and gold perform (1) even for R_X86_64_GOTPCREL. LLD requires R_X86_64_[REX_]GOTPCRELX

>it's easy to imagine that they could
>get extended to, for eg, convert
>	leaq	foo(%rip), %rax
>to
>	movl	$foo, %eax
>with some nop padding, etc.

Not with NOP padding, but probably with instruction prefixes. It is
unclear the rewriting will be beneficial. Rewriting instructions definitely requires a
dedicated relocation type like R_X86_64_[REX_]GOTPCRELX.

>Also, the relocation check that's being added here would only work with
>PIE linking.
