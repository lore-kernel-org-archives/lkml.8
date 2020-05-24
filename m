Return-Path: <SRS0=XgUW=7G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F768C433DF
	for <linux-kernel@archiver.kernel.org>; Sun, 24 May 2020 23:59:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 69BC82075D
	for <linux-kernel@archiver.kernel.org>; Sun, 24 May 2020 23:59:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mi1T6Zts"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388334AbgEXX7B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 May 2020 19:59:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388149AbgEXX7A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 May 2020 19:59:00 -0400
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3B62C061A0E
        for <linux-kernel@vger.kernel.org>; Sun, 24 May 2020 16:58:59 -0700 (PDT)
Received: by mail-qt1-x842.google.com with SMTP id e16so6866405qtg.0
        for <linux-kernel@vger.kernel.org>; Sun, 24 May 2020 16:58:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=X1mIyAkwbgWoxrz90REt4fG4bY063H1i6zQ27Un6aao=;
        b=mi1T6ZtsPlzDI7d/PdTXk4g8yQZEgVkLNKOEnFBZihPx6fpvuA8BvsSHJbrcknvSAX
         z5E4IhiN9r9b699JVm0os30Sco7Y1fzQdSt1ASba9x6IwpaRGb9XAPTto9TcVXsJxxbp
         vG81GEguGTYbe2C9EqaZ6mDZbi9f0pUTRuJlBzExybQG5L9NYdzIlm71MzWVG/XIe9Hm
         U2Nw9LOwzh47smCgn2QQzpjd3/rlNnTqtBAozPx6c510c8BAumkWHBTzzATEo6WiVhef
         N+qIHE0drnc+mdIQOA1yVDR0AHbiCr8tftA7FF93pmcU/Wl7o+Dia5xrDy7aPjazFdUL
         g08w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:date:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=X1mIyAkwbgWoxrz90REt4fG4bY063H1i6zQ27Un6aao=;
        b=HpUkqrj62LMxvHkENUlQTc6/iqvGdcU1yUQPTTOSQ5Y7uD/1c0CFAdMao9r65Wi1il
         ZCn/w11QLKs/liNAPgRwmi9ktn95qTtv9UJP1mDlFcNIwNNpdQmnp/IUpwkx+VCypxQl
         90slUxVPRnT/ostxXuQ/DmJsFmv2/b6haWo+n3lU2jyL1PjX1UN4lyB3iCUBJg3Zq1Fb
         NqeqShc/3npgD6XlW8MmHo6eBr1YvF2HAF4EwjIGmiZ9sBf6D8QIVGmRWuc/J0Kvy0d+
         ktxbUvxVYnzmWQWo06NCqgusPPFDasdTaJDH23WfzKjqCcy+BaTPEKyjIHTVngMxIrRD
         aVSg==
X-Gm-Message-State: AOAM530MrKbU3imUJvWo4Da9NoWPbi0XXizFCPCMlI1dgQnkRKGtO35b
        j93pjy5G2P83eUA/YCugdtc=
X-Google-Smtp-Source: ABdhPJyG+IeYxC6ELrcfCrNo9CnT7YthlMBgdgORz0LWSUWtXprZvhBrVl2YHQYRQlFA7bYIMObQDQ==
X-Received: by 2002:ac8:6a1a:: with SMTP id t26mr24668127qtr.331.1590364738911;
        Sun, 24 May 2020 16:58:58 -0700 (PDT)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id u3sm14638550qtk.63.2020.05.24.16.58.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 May 2020 16:58:58 -0700 (PDT)
From:   Arvind Sankar <nivedita@alum.mit.edu>
X-Google-Original-From: Arvind Sankar <arvind@rani.riverdale.lan>
Date:   Sun, 24 May 2020 19:58:56 -0400
To:     Fangrui Song <maskray@google.com>
Cc:     Arvind Sankar <nivedita@alum.mit.edu>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>,
        Dmitry Golovin <dima@golovin.in>,
        clang-built-linux@googlegroups.com,
        Ard Biesheuvel <ardb@kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Daniel Kiper <daniel.kiper@oracle.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/4] x86/boot: Remove runtime relocations from
 head_{32,64}.S
Message-ID: <20200524235856.GD280334@rani.riverdale.lan>
References: <CAKwvOd=qB+EoJwfAYUA9Hg7f9op4Q4W+TDnht8pLRG5bPX=29Q@mail.gmail.com>
 <20200524212816.243139-4-nivedita@alum.mit.edu>
 <20200524232214.i7rfpdzoam6tpt6n@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200524232214.i7rfpdzoam6tpt6n@google.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 24, 2020 at 04:22:14PM -0700, Fangrui Song wrote:
> 
> Probably worth mentioning that this works around GNU ld<2.35

Thanks, I'll add that in v2.

> 
> 
> This commit fixing https://sourceware.org/bugzilla/show_bug.cgi?id=25754
> also fixed the bug. (Just verified that both 2.24 and 2.34 have the bug. binutils-gdb HEAD (future 2.35) is good.)
> 
> % cat a.s
> pushl $z_input_len
> % cat b.s
> .globl z_input_len
> z_input_len = 0xb612
> % gcc -m32 -c a.s b.s
> % ld.bfd -m elf_i386 -pie a.o b.o  # has an incorrect R_386_RELATIVE before binutils 2.35
> 
> 
> Reviewed-by: Fangrui Song <maskray@google.com>
