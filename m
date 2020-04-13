Return-Path: <SRS0=sVLE=55=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0E7FC2BA19
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 18:29:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AD074206DA
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 18:29:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KzdcNdOF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732996AbgDMS3P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Apr 2020 14:29:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727904AbgDMS3O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Apr 2020 14:29:14 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B760C0A3BDC
        for <linux-kernel@vger.kernel.org>; Mon, 13 Apr 2020 11:29:13 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id r14so4863762pfl.12
        for <linux-kernel@vger.kernel.org>; Mon, 13 Apr 2020 11:29:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=okqkFQ9Y/XR2Uylj/PBU9rQT9Y97Xsyzid6BJbXKYDw=;
        b=KzdcNdOFkQ4motYzQSbGGZfva4sm/AvLEBRZ8iVoHUscDTl2KSZZLZF38aM21c80eF
         2M+VUMpt5cmZayLcn5RmWrIO1Q5VeY+inACc6T245VKjcekv+5pcZkKD1dlxl79ki4P3
         KucTeTdL6EsEZGiRjXw3Uqr6TSgHGjHmZe2vXVnHPTOQYjPON50cT9frLsN2S7lYmfn7
         RxXQJqrvGGR4m2CzunPl5iiJoU72wbIil7j6aiNi6zQf3ofEOd8RKklFYpX604zp6lTi
         Y6OGtTn8lFuhozNA+rRtLEk4CbGC+43aBvo/QcBPiijapOM5KxkVCbqLp70ZTEfNkL/c
         ueNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=okqkFQ9Y/XR2Uylj/PBU9rQT9Y97Xsyzid6BJbXKYDw=;
        b=uAVgfw6AUX2yYGtHYqu6IULvFJzNy4krELT90dJcKAzS75u4TpBl63UNq0S/QxstbK
         tgORGfhLTb2QHoFCihoLQunjlT65kABPg0t7caQVKyNBlzNGvu8YAqjQDmtzZv4VxULb
         ROx8LcyV85XhkMGARiWoeGXaiziX00ELyhr6HAijIJlp9vC+0PkM0mY3oI0QhgFSHuaK
         TsQo1ywaRX7cb4fXsnnlO6348gWdl8fvQLg05/2IBXH4iy4y1JKPVIbFW8H7RypBoGpZ
         mi6madqXPyFSWrJzi2/DJPdgL5jUE7q3ZnZCTdmt/2SOEAy62GSUbQuaqpAAUSkLQiQF
         28CA==
X-Gm-Message-State: AGi0PuY5ZU4XTX+oDPAxPUrzWWeReGmZjUr74ZJQAy5jq5UZlNUpW16G
        JWx2K9GfLuZkVzYTGEHPK7EhnW/rHDHJuoHCDQqUmg==
X-Google-Smtp-Source: APiQypIP1E33hhfznbi9NfC4v99qr7cXozR2upGUjMkfZgNyiN/IFEhI7vX+kNy3Q1FyTJmBJ46GRNxuOfW4kqDvvd0=
X-Received: by 2002:aa7:919a:: with SMTP id x26mr18865698pfa.39.1586802552376;
 Mon, 13 Apr 2020 11:29:12 -0700 (PDT)
MIME-Version: 1.0
References: <20200407190558.196865-1-caij2003@gmail.com>
In-Reply-To: <20200407190558.196865-1-caij2003@gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 13 Apr 2020 11:29:00 -0700
Message-ID: <CAKwvOdk3YG5TFD71E-9vPqssFZW1U3umCR+AWLLp8RZK2zHGsw@mail.gmail.com>
Subject: Re: [PATCH] ARM: replace the sole use of a symbol with its definition
To:     Jian Cai <caij2003@gmail.com>
Cc:     Manoj Gupta <manojgupta@google.com>,
        Stefan Agner <stefan@agner.ch>,
        Russell King <linux@armlinux.org.uk>,
        Enrico Weigelt <info@metux.net>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 7, 2020 at 12:09 PM Jian Cai <caij2003@gmail.com> wrote:
>
> ALT_UP_B macro sets symbol up_b_offset via .equ to an expression
> involving another symbol. The macro gets expanded twice when
> arch/arm/kernel/sleep.S is assembled, creating a scenario where
> up_b_offset is set to another expression involving symbols while its
> current value is based on symbols. LLVM integrated assembler does not
> allow such cases, and based on the documentation of binutils, "Values
> that are based on expressions involving other symbols are allowed, but
> some targets may restrict this to only being done once per assembly", so
> it may be better to avoid such cases as it is not clearly stated which
> targets should support or disallow them. The fix in this case is simple,
> as up_b_offset has only one use, so we can replace the use with the
> definition and get rid of up_b_offset.
>
> Signed-off-by: Jian Cai <caij2003@gmail.com>

Probably didn't need the extra parens, but it's fine (unless another
reviewer would like a v2).  Maybe Stefan has some thoughts?
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

Please add Link tags if these correspond to issues in our link
tracker, they help us track when and where patches land.
Link: https://github.com/ClangBuiltLinux/linux/issues/920

> ---
>  arch/arm/include/asm/assembler.h | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/arch/arm/include/asm/assembler.h b/arch/arm/include/asm/assembler.h
> index 99929122dad7..adee13126c62 100644
> --- a/arch/arm/include/asm/assembler.h
> +++ b/arch/arm/include/asm/assembler.h
> @@ -269,10 +269,9 @@
>         .endif                                                  ;\
>         .popsection
>  #define ALT_UP_B(label)                                        \
> -       .equ    up_b_offset, label - 9998b                      ;\
>         .pushsection ".alt.smp.init", "a"                       ;\
>         .long   9998b                                           ;\
> -       W(b)    . + up_b_offset                                 ;\
> +       W(b)    . + (label - 9998b)                                     ;\
>         .popsection
>  #else
>  #define ALT_SMP(instr...)
> --
> 2.26.0.292.g33ef6b2f38-goog
>


-- 
Thanks,
~Nick Desaulniers
