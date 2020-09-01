Return-Path: <SRS0=b2Mh=CK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D950C433E2
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 05:00:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 36CCC2087D
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 05:00:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CdYzAnvh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726489AbgIAFAO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Sep 2020 01:00:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725930AbgIAFAN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 01:00:13 -0400
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB49AC061290
        for <linux-kernel@vger.kernel.org>; Mon, 31 Aug 2020 22:00:11 -0700 (PDT)
Received: by mail-qt1-x842.google.com with SMTP id e5so36139qth.5
        for <linux-kernel@vger.kernel.org>; Mon, 31 Aug 2020 22:00:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=vk2gX1BCYqANDPcxvPWahORASUA72oVkRN2etYZLoxY=;
        b=CdYzAnvhWX8nYBRq2qCXFeiO70PtxuBsxqeCyA4Vmg8Z9X2ix7thWvu/Ru17kvw68j
         qHlWIOUDBtajBSoHMQnpAYwFfOCZ3QXplC4/93okBATrHM8f9Cqz2JiC2oZu2HVLdZcI
         /65QBkat90twIYVUhyQZjYKdT4K80eJekaFrMOlA6g0y5+4EhoOjJCvGSb20QR00PP2d
         mZZXPzpiBEqkMe3c8vjAVSJpiTBbDiXHsA7AvAYo6bJS6XLhNDr7Fm3ec8MUKvSTKcHr
         +RMMF0u0P9P76Y2nUM+LLEZtDsOoSDbNk5VqTvmJAXgHWk1LpLMqXIjsoIH1l2CvVfIq
         u5Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=vk2gX1BCYqANDPcxvPWahORASUA72oVkRN2etYZLoxY=;
        b=c2k6tCuOa4XJ7/SG7QGQzQ2udg5NGbj6oJ3b7hr6vbxff3NzfAdoKQGuyDrVMDUcfL
         PF6iKNVTLstQnUHZk++eUeOQBosOEBSmwyDxb3nrTA+mYYmTvb2rIbQ1L7DrSl5124CF
         jpeBqXLGZVIBfCccf/oOVe3ucKkBfWmKv5FVFBQ3jEKdxIRdbo9CFy/K2hHSp3w4X3ha
         rirPrCcpA7nbZv3i/3ABbAj2ttRh6V9BkKZXv92yWGpXzYygYt4SnpRSrLuiaubf4OBO
         KpVaevOhghJ08DbaAV+XYOUHSzCAnvTGv7qVn1yZTyQRph2EkvuPfaprl2O5zrx8q5Qo
         wjZA==
X-Gm-Message-State: AOAM533vTusoYp2caPDxvpyG8c/QWqd62FVrSjLzaucDsX3o8WPo4ss/
        5QzdUbI/hlkYCTYgo/rYjLo=
X-Google-Smtp-Source: ABdhPJw+Q4GpmO2lyqyu6IUUeqTk4snwQI9ancHvevFOgJWYXNK9Bnzmb/vcvXBC52oErS6Zqntu5w==
X-Received: by 2002:ac8:4f4e:: with SMTP id i14mr4487917qtw.213.1598936411151;
        Mon, 31 Aug 2020 22:00:11 -0700 (PDT)
Received: from ubuntu-n2-xlarge-x86 ([2604:1380:45d1:2600::1])
        by smtp.gmail.com with ESMTPSA id z14sm12392131qtn.92.2020.08.31.22.00.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Aug 2020 22:00:10 -0700 (PDT)
Date:   Mon, 31 Aug 2020 22:00:09 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        Marco Elver <elver@google.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        clang-built-linux@googlegroups.com,
        Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Will Deacon <will@kernel.org>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 7/7] compiler-gcc: improve version error
Message-ID: <20200901050009.GF1561318@ubuntu-n2-xlarge-x86>
References: <20200901002326.1137289-1-ndesaulniers@google.com>
 <20200901002326.1137289-8-ndesaulniers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200901002326.1137289-8-ndesaulniers@google.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 31, 2020 at 05:23:26PM -0700, Nick Desaulniers wrote:
> As Kees suggests, do so provides developers with two useful pieces of
> information:
> - The kernel build was attempting to use GCC.
>   (Maybe they accidentally poked the wrong configs in a CI.)
> - They need 4.9 or better.
>   ("Upgrade to what version?" doesn't need to be dug out of documentation,
>    headers, etc.)
> 
> Suggested-by: Kees Cook <keescook@chromium.org>
> Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>

Reviewed-by: Nathan Chancellor <natechancellor@gmail.com>

It would be nice if there was some easy way to link the documentation
here so that patches like commit 0bddd227f3dc ("Documentation: update
for gcc 4.9 requirement") did not need to happen or be remembered.

> ---
>  include/linux/compiler-gcc.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/linux/compiler-gcc.h b/include/linux/compiler-gcc.h
> index 7a3769040d7d..d1e3c6896b71 100644
> --- a/include/linux/compiler-gcc.h
> +++ b/include/linux/compiler-gcc.h
> @@ -12,7 +12,7 @@
>  
>  /* https://gcc.gnu.org/bugzilla/show_bug.cgi?id=58145 */
>  #if GCC_VERSION < 40900
> -# error Sorry, your compiler is too old - please upgrade it.
> +# error Sorry, your version of GCC is too old - please use 4.9 or newer.
>  #endif
>  
>  /* Optimization barrier */
> -- 
> 2.28.0.402.g5ffc5be6b7-goog
> 
