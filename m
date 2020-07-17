Return-Path: <SRS0=w5GM=A4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88381C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 13:47:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 62B9A2076A
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 13:47:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YW3OQKQA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726399AbgGQNq6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jul 2020 09:46:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726079AbgGQNq6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jul 2020 09:46:58 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64895C061755
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jul 2020 06:46:58 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id l23so933871qkk.0
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jul 2020 06:46:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=5P4OIwY9QUK4h9roSSRi0+Ffy4n0VXQDJm6kBXWOS4s=;
        b=YW3OQKQAfKVqT1Egb+B5MNUYPBtYtlKNXMwuYmzLvdi7fy6reGmedSDwvvnOfy47cM
         d0jaSw2R5WUXi6fRuqRDCZnOh3YRmXZSczGb3nih0o4OjKD9hoAq9Bi/3z5SwN7JtrpO
         2SPm12xa2vVkKe7nCOflLjYArXFFSX1EumnABmBUypo04a+VitxcEzcNb9yeTIj5+WI+
         +p/YUjHNAKU9DqXMWdMxknux94s/t7PRJ+q2JLkLcwiM7AMrFtfxXgtUVGUqQAueOdWP
         6mJzjZHOqK3wS+ub16E4Ur+zPSNKw5EkRno0o864Saa0TxlYhUfaQ02l08SBp4wz6sSc
         sBZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:date:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=5P4OIwY9QUK4h9roSSRi0+Ffy4n0VXQDJm6kBXWOS4s=;
        b=gpIostEjoxyO2Yw2RbzTI8jPkpAqFzljBzzxQVFXWKmvkkHkBR4pflRrlyLAGJ5+k3
         95jA8uHmn2LV2EGoGFZQtMxOfs+QiyxnlfRPMlPqqZ7ZRd1pxHHIvus7xfpyQ8NvmRBu
         j03yewbuz3Hd92Ei5y+fdutYbo7Xcp0KpyjU0O+4nEmxJjzf8BqzetREJsorGBSpqx+v
         CHAz20oRGh7KpK6/FVCllp3JBLTza4dpBv88OPmTBDSHgpBlmm1BhhxEkgpWxjSkPMdM
         Zagb+S+VDTXmJ/fA4dMpub5Qdh3egwomWZj/pJUPUUGA6yLMLbX8ZEP+40d/JnFFSeBu
         BZlg==
X-Gm-Message-State: AOAM530FZptZNrMmU12TmzLce5qVrxIm8vU6m8eNTk4X5z1u7roj1NCg
        omi3OTa6EwDUk89LQMLRTgbKo13dGmc=
X-Google-Smtp-Source: ABdhPJzXknVXEJjneVcxfIJvL2dOl6s/d14Cum6dyvI7mkbXB9HDOq3h0XdtY3AXjRjBotB2EKUiIg==
X-Received: by 2002:a05:620a:a56:: with SMTP id j22mr8716602qka.193.1594993617582;
        Fri, 17 Jul 2020 06:46:57 -0700 (PDT)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id d8sm10497586qkl.118.2020.07.17.06.46.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2020 06:46:56 -0700 (PDT)
From:   Arvind Sankar <nivedita@alum.mit.edu>
X-Google-Original-From: Arvind Sankar <arvind@rani.riverdale.lan>
Date:   Fri, 17 Jul 2020 09:46:54 -0400
To:     Arvind Sankar <nivedita@alum.mit.edu>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>,
        Fangrui Song <maskray@google.com>,
        Dmitry Golovin <dima@golovin.in>,
        clang-built-linux@googlegroups.com,
        Ard Biesheuvel <ardb@kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        "H . J . Lu" <hjl@sourceware.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 0/7] x86/boot: Remove run-time relocations from
 compressed kernel
Message-ID: <20200717134654.GA3187880@rani.riverdale.lan>
References: <20200714023836.2310569-1-nivedita@alum.mit.edu>
 <20200715004133.1430068-1-nivedita@alum.mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200715004133.1430068-1-nivedita@alum.mit.edu>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 14, 2020 at 08:41:26PM -0400, Arvind Sankar wrote:
> The compressed kernel currently contains bogus run-time relocations in
> the startup code in head_{32,64}.S, which are generated by the linker,
> but must not actually be processed at run-time.
> 
> This generates warnings when linking with the BFD linker, and errors
> with LLD, which defaults to erroring on run-time relocations in read-only
> sections. It also requires the -z noreloc-overflow hack for the 64-bit
> kernel, which prevents us from linking it as -pie on an older BFD linker
> (<= 2.26) or on LLD, because the locations that are to be apparently
> relocated are only 32-bits in size and so cannot really have
> R_X86_64_RELATIVE relocations.
> 
> This series aims to get rid of these relocations. I've build- and
> boot-tested with combinations of clang/gcc-10 with lld/bfd-2.34, and
> gcc-4.9.0 with bfd-2.24, skipping clang on 32-bit because it currently
> has other issues [0].
> 

Hi Thomas, Ingo, Borislav, would you be able to take a look over this
series in time for 5.9?

Thanks.
