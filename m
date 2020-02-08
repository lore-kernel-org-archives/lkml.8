Return-Path: <SRS0=BhYR=34=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74E42C35250
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Feb 2020 09:15:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4518E217BA
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Feb 2020 09:15:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fdZgQqcZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727162AbgBHJPU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Feb 2020 04:15:20 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:37450 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726714AbgBHJPU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Feb 2020 04:15:20 -0500
Received: by mail-wr1-f68.google.com with SMTP id w15so1637466wru.4
        for <linux-kernel@vger.kernel.org>; Sat, 08 Feb 2020 01:15:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CoHhfIwiDbvtPfDFAwUN8VuBCX0irygnRTD29jqnMLs=;
        b=fdZgQqcZxmWzLEywyxQLKlw29+4QaJ1bzSivk5HBUO7egEfuX5HAFMx4KSmaDKzLRD
         KnohDr9N4uRL57Tx3dadfWDNg6PLGnh+4bhEuGeGTO7c91mnXHDifMmsjrxwxzrlMZAI
         Hm7vlybOLMEg0DPAVsO/DJUPr03IP6Fk0OoYH80E9WMniMr1bWgDT9wCOI+GQ4iDwznH
         pmWq8c5a7d0e0ya9DCL/gyIHCtgr4CeLjrfbnIghQQGuMD/KVBN7szH3L4P1SVj6LQI2
         4jjstFccFZCw4jbUqJASLYxna/InQh2nwbGdOHUZPKBN6yenp7/8rMmd9fPaiah9nKSe
         3qZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CoHhfIwiDbvtPfDFAwUN8VuBCX0irygnRTD29jqnMLs=;
        b=huM8GAlX/KHQth+gYGT7gtIpOPHHg1/L3ExpsP5DRRZ9aregABQi6dPkLVTL+oQlaW
         IwMy9kzKhIN7QMKBs3w7kautOShyJgogmDvL/DLbh9QM14cQUv0WpLa1UcPRUHk/n2qo
         tuXbP4VbRLiXjvfzgwo6FgeMV7SE9VjijglVS5RFgT7lBL3Rw6AMhGbMSPpKlg+oIFnO
         CiuyfQEpe1f9qvop4LtjPPQwxpbUAjVBLLVBBbXRevui232SoNGiFePeprNXvjYpCOBA
         D1so8jGW8/abzTfkAG8HbdtpPG0PQMvbkWelio2TR8pAXHIqmLtpkPxVFMXvesnIoccj
         dEeQ==
X-Gm-Message-State: APjAAAXC52TLGUD9GzmtZYf4oQfWZN8hXLS6gPFw26a3W9We/B+h80q6
        pln1XftAjTw+F8hrZK5C11Zsg13faIc85lBmsxjbZmyDE3P4Pu6i
X-Google-Smtp-Source: APXvYqwkIXj1ldYkHsCnfd5+LUx60zOCDZ0PQlqfpFQFHulcVrLK7i8LKrMk+4fRhyWOFSUu1LclVFwUH3h55G/5iA8=
X-Received: by 2002:adf:8564:: with SMTP id 91mr4637019wrh.252.1581153316892;
 Sat, 08 Feb 2020 01:15:16 -0800 (PST)
MIME-Version: 1.0
References: <202002080058.FD1DDB1@keescook>
In-Reply-To: <202002080058.FD1DDB1@keescook>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Sat, 8 Feb 2020 09:15:05 +0000
Message-ID: <CAKv+Gu805nMtsXCLPhTpk7hPCb+Lad6fHgauaq1-G0Lq2xL1+Q@mail.gmail.com>
Subject: Re: [PATCH] ARM: Remove unused .fixup section in boot stub
To:     Kees Cook <keescook@chromium.org>
Cc:     Nicolas Pitre <nico@fluxnic.net>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Manoj Gupta <manojgupta@google.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 8 Feb 2020 at 09:04, Kees Cook <keescook@chromium.org> wrote:
>
> The boot stub does not emit a .fixup section at all anymore, so remove
> it.
>
> Suggested-by: Nick Desaulniers <ndesaulniers@google.com>
> Link: https://lore.kernel.org/lkml/CAKwvOdnRhx=SgtcUCyX2ZOGATM8OzG6hSOY9wGQZcwtp+P5WBQ@mail.gmail.com
> Signed-off-by: Kees Cook <keescook@chromium.org>

Reviewed-by: Ard Biesheuvel <ardb@kernel.org>

I'd assume these are uncontroversial enough to go straight into the
patch system.

> ---
>  arch/arm/boot/compressed/vmlinux.lds.S | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/arch/arm/boot/compressed/vmlinux.lds.S b/arch/arm/boot/compressed/vmlinux.lds.S
> index fc7ed03d8b93..b247f399de71 100644
> --- a/arch/arm/boot/compressed/vmlinux.lds.S
> +++ b/arch/arm/boot/compressed/vmlinux.lds.S
> @@ -36,7 +36,6 @@ SECTIONS
>      *(.start)
>      *(.text)
>      *(.text.*)
> -    *(.fixup)
>      *(.gnu.warning)
>      *(.glue_7t)
>      *(.glue_7)
> --
> 2.20.1
>
>
> --
> Kees Cook
