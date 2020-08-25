Return-Path: <SRS0=mfLo=CD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92C39C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 14:45:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 551ED20706
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 14:45:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YJEnGzyO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726542AbgHYOpg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Aug 2020 10:45:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725893AbgHYOpa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Aug 2020 10:45:30 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 285CBC061574
        for <linux-kernel@vger.kernel.org>; Tue, 25 Aug 2020 07:45:30 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id g26so11131382qka.3
        for <linux-kernel@vger.kernel.org>; Tue, 25 Aug 2020 07:45:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=MPpWQLw9NIuZJvTlALTJWYW9Nw81sbkBJZTeK4RABJ8=;
        b=YJEnGzyOUTJ2Ct0o8mN3BVXaeYGxT++pDQeyljd8s7awH9Xxd455J+lBM8nuFJe1kT
         p2NWpzC88SN//p4tSMBnQ2UdjSNzW1QPoZfpAZ+S4VnPcHE9DzXZezSrbwqmkQNMpvkh
         4tdTbfDtE6S0PuXj80A0pTHf/qPCinH0Ce9T099l6BMqWdQbm5v2SPKgnablxAfyTTIR
         /8tv0cAQQ347Z6nYU2JUgFjjYYuERrAnJhld5V2nZr2LeqXQXyYDyHNir0pLE3LME/FU
         c3b4nf3VtOq2U4ZUVmYMsx5cj9SHiBjINQkCgnx8UxLKGy1F451Vagmd7tvPi8ZH58EY
         oCnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=MPpWQLw9NIuZJvTlALTJWYW9Nw81sbkBJZTeK4RABJ8=;
        b=HcFlFKcSLJ0OQM3t6xhofVo9MImB11f8WasRJsSj08AtTOb+SgwGxbFo7VuvkVrkLa
         rT5I19Es1Uen5+iS6brUbSP2s+18kg0/qRp5Kh5FInhkhYay6OFZWQJtr5ZhINS07Ndh
         MTOOmwFKUoeMN80mr76noqOw7DkCS8w2is26+3A9uZeF5BThuZHtg/dmwVAQITxzJRY1
         CyvwLcxXMmru+Dfx/UgnNfbLuL2mAuaEjRSLXv09Q050zeq5D9NQn4eV8nK+V+gcFcw8
         uCgWZkgz7nYpxccdkrVXQFqyzNujqf2AESRco86mqdoFGSjUQOxZjO1CskoofkLFD9Z4
         vL8A==
X-Gm-Message-State: AOAM533X6qGtGxt7lfsmhU/C3p35XkO9Ih6UgL0qTpc+im8Rg3rcpV/6
        8Lqptf5YTrc3opCt8/7OOVc=
X-Google-Smtp-Source: ABdhPJyOtqt/8cXWRZeg2Boep1yu8UY6RaOkppNvWh9B0kzSr14Z8upUmVYA18EQdnJHcMN7Pzyyjw==
X-Received: by 2002:a05:620a:22b4:: with SMTP id p20mr9194663qkh.340.1598366728168;
        Tue, 25 Aug 2020 07:45:28 -0700 (PDT)
Received: from ubuntu-n2-xlarge-x86 ([2604:1380:45d1:2600::1])
        by smtp.gmail.com with ESMTPSA id r6sm11551337qkc.43.2020.08.25.07.45.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Aug 2020 07:45:27 -0700 (PDT)
Date:   Tue, 25 Aug 2020 07:45:25 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        clang-built-linux@googlegroups.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: add LLVM maintainers
Message-ID: <20200825144525.GA128234@ubuntu-n2-xlarge-x86>
References: <20200825143540.2948637-1-ndesaulniers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200825143540.2948637-1-ndesaulniers@google.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 25, 2020 at 07:35:40AM -0700, Nick Desaulniers wrote:
> Nominate Nathan and myself to be point of contact for clang/LLVM related
> support, after a poll at the LLVM BoF at Linux Plumbers Conf 2020.
> 
> While corporate sponsorship is beneficial, its important to not entrust
> the keys to the nukes with any one entity. Should Nathan and I find
> ourselves at the same employer, I would gladly step down.
> 
> Cc: clang-built-linux@googlegroups.com
> Cc: Nathan Chancellor <natechancellor@gmail.com>
> Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>

Acked-by: Nathan Chancellor <natechancellor@gmail.com>

Thanks for sending the patch!

> ---
>  MAINTAINERS | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 33aab0c88118..0cbb24753153 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -4249,6 +4249,8 @@ S:	Maintained
>  F:	.clang-format
>  
>  CLANG/LLVM BUILD SUPPORT
> +M:	Nathan Chancellor <natechancellor@gmail.com>
> +M:	Nick Desaulniers <ndesaulniers@google.com>
>  L:	clang-built-linux@googlegroups.com
>  S:	Supported
>  W:	https://clangbuiltlinux.github.io/
> -- 
> 2.28.0.297.g1956fa8f8d-goog
> 
