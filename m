Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF9EEC433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 19:44:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BEA8220842
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 19:44:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="oByy/EXs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387925AbgF2ToD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 15:44:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387966AbgF2Tmm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 15:42:42 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2945FC0307BA
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 09:06:09 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id 207so7906258pfu.3
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 09:06:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Hd2ztXk1vCQk2wKYG462cRN4nuwUe31pLKUP0eS2DPs=;
        b=oByy/EXs3Sua6IxFhmLKuu1yCt1mraiv5y8rkvS2ofpAw6W5y2hcFRMu1fzsyV7kIe
         AkmJIkwLYYjKcr0yNXy0Gh0fkHuhpqMZ6UxG7olLFBcM7PrBakbHwVvnZHcNEPwLYh1z
         iFcf75y1DRs8b03UeSX2DWhmxCwKrYAM+WnP8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Hd2ztXk1vCQk2wKYG462cRN4nuwUe31pLKUP0eS2DPs=;
        b=WqBW59d+7bhuqkgcegheEJ0iy7YK1RcSHUV1hdtoPHS5ZEFHXQ062hMub/QDNTm2i5
         AauNAWa4ElhveJah0dLRd4qg3R9rSLc0M88OMYmFhiOEn2VW1S/D4dZdIcyZPkxpiI+s
         uutnyWoIpblseFi96dDpxEavFIscKor9VhBuuomWicje95oEdQUlditmZq9wjf3DCiJ6
         MEPJqxtnZLKW7B0eOyySYoBl1ILKp/OdVuIIKD9qKiMvmFpbT5FFtswi9y52e7cFpov0
         ZjIPgeJNxVSh0KNK/IQywASRN403IJJaP3qelRXXyKfjSRvuCwAZjn1AnBHU2UeRAmYe
         PYmw==
X-Gm-Message-State: AOAM533mXWCUJ2WDL93iUgDD7G1vny5OY81Tj/mMqV994H34XMS5yc+b
        viB0avaMyqO9Iaf204XH/1TDDw==
X-Google-Smtp-Source: ABdhPJy9noqH+1qN4YXU+pVP49CfNJCdlJxq5gFL48QPyB9J6qBJ1eK5ra4BIxq+7K6YiI08/a/kkw==
X-Received: by 2002:a63:6dc1:: with SMTP id i184mr10942111pgc.345.1593446768762;
        Mon, 29 Jun 2020 09:06:08 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id gk5sm62829pjb.4.2020.06.29.09.06.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2020 09:06:07 -0700 (PDT)
Date:   Mon, 29 Jun 2020 09:06:07 -0700
From:   Kees Cook <keescook@chromium.org>
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
        Daniel Kiper <daniel.kiper@oracle.com>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        "H . J . Lu" <hjl@sourceware.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 6/7] x86/boot: Remove runtime relocations from
 head_{32,64}.S
Message-ID: <202006290905.7531731A@keescook>
References: <20200629140928.858507-1-nivedita@alum.mit.edu>
 <20200629140928.858507-7-nivedita@alum.mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200629140928.858507-7-nivedita@alum.mit.edu>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 29, 2020 at 10:09:27AM -0400, Arvind Sankar wrote:
> The BFD linker generates runtime relocations for z_input_len and
> z_output_len, even though they are absolute symbols.
> 
> This is fixed for binutils-2.35 [1]. Work around this for earlier
> versions by defining two variables input_len and output_len in addition
> to the symbols, and use them via position-independent references.
> 
> This eliminates the last two runtime relocations in the head code and
> allows us to drop the -z noreloc-overflow flag to the linker.
> 
> [1] https://sourceware.org/bugzilla/show_bug.cgi?id=25754
> 
> Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>
> Reviewed-by: Ard Biesheuvel <ardb@kernel.org>
> Reviewed-by: Fangrui Song <maskray@google.com>
> ---
>  arch/x86/boot/compressed/Makefile  |  8 --------
>  arch/x86/boot/compressed/head_32.S | 17 ++++++++---------
>  arch/x86/boot/compressed/head_64.S |  4 ++--
>  arch/x86/boot/compressed/mkpiggy.c |  6 ++++++
>  4 files changed, 16 insertions(+), 19 deletions(-)

I continue to really enjoy the smaller code. Anything that makes
mkpiggy.c smaller is a win. :)

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
