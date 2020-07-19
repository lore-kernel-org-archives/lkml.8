Return-Path: <SRS0=EKp2=A6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 490C1C433DF
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Jul 2020 04:45:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1EAFA2064C
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Jul 2020 04:45:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=dabbelt-com.20150623.gappssmtp.com header.i=@dabbelt-com.20150623.gappssmtp.com header.b="hrJ7LWeC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726049AbgGSEpZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 Jul 2020 00:45:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725440AbgGSEpZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jul 2020 00:45:25 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C9B6C0619D2
        for <linux-kernel@vger.kernel.org>; Sat, 18 Jul 2020 21:45:25 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id t15so8299138pjq.5
        for <linux-kernel@vger.kernel.org>; Sat, 18 Jul 2020 21:45:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=FEoJHD8hLAwDISEozbsWN4K8QUnQ9MVeLY2tTbYM424=;
        b=hrJ7LWeCm+YQ69Xb47AIhO5dpMNdzPX71K6khpcnhJMpjt0trlngYgwgk7hGYbZ/qZ
         l2n93XcHxwCsQ3CEtTMuWHZRUN5wTr1T/kGZK38Pi+NyXKpk3wPoQ2HUzYn1CvcXEipU
         0tzFrzapWEUm/GDHl3EeieMfjwEILRTlcg7n/hc3j56TQgZbVvzy1fDB5ZmheEEOxI+Q
         vfGaCjd5xUuKG9iAPSIJ5K5rrsL0ZKAXU+erh+mzEpQSb3oINWYA/iSIX1bIxJxqgkcM
         OWm/B1jFz7muRwkqUQxmc0W0kIGdd7hETLOIYpJx4xtI2S5SLgNY+VTJNSTIyw1qv0BH
         IA/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=FEoJHD8hLAwDISEozbsWN4K8QUnQ9MVeLY2tTbYM424=;
        b=UuHZ3Esxw/gtjl5B06L7aXD7V6ajYsl4KJzGUMTJuiKuaUVGQT70Hs8YvhXPBksjDF
         mehCM5NVNQcTPJUk8H7jwtoaluIB7bi7vlOMQpcWIA2A2BeHHFDwmsAKBk6EzzwgKb8V
         eXTdvgCvDRpsCG8l2gWc1JL4kr2Q3/sg30tyaK3yDmU8RKHCL5aZdc4AvgGwwCgilWqy
         LHpHEm52vxZdyQh2efX0R2s03+UNuam1Lt2DtFUK1dVYCLpmR9CExwPrhgqrEIxQs19C
         lQdnYG4juDLlbWLPMRSpg6jTYO9lHAqlA9AjymdvsPF99Agb6wiawu67hDBxcN64dLza
         QLJQ==
X-Gm-Message-State: AOAM532TLv5SkfRR6OchLbtZMHnyOW8+amhPFvjVzkNXrBEGU71wtzCM
        lBEuItQf4cZgxolQJgZI/IvH4g==
X-Google-Smtp-Source: ABdhPJySzpejiPW0r9WWYNVbeaCmq3CLZqSUN2F55p6OiLGs3a/e8F6Qog9L2sHgvhtzgEE7Ph4Tyg==
X-Received: by 2002:a17:90a:21c3:: with SMTP id q61mr17252158pjc.207.1595133924391;
        Sat, 18 Jul 2020 21:45:24 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id i66sm11639093pfc.12.2020.07.18.21.45.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Jul 2020 21:45:23 -0700 (PDT)
Date:   Sat, 18 Jul 2020 21:45:23 -0700 (PDT)
X-Google-Original-Date: Sat, 18 Jul 2020 21:45:20 PDT (-0700)
Subject:     Re: [PATCH 1/1] riscv: Enable compiler optimizations
In-Reply-To: <20200708054354.25283-1-maochenxi@eswin.com>
CC:     Paul Walmsley <paul.walmsley@sifive.com>, aou@eecs.berkeley.edu,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        chenxi.mao2013@gmail.com, maochenxi@eswin.com
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     maochenxi@eswin.com, ardb@kernel.org
Message-ID: <mhng-8695bbb1-2ef2-409f-a458-3eb68d87495f@palmerdabbelt-glaptop1>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 07 Jul 2020 22:43:54 PDT (-0700), maochenxi@eswin.com wrote:
> Enable ARCH_HAS_FAST_MULTIPLIER and ARCH_SUPPORTS_INT128 for better
> code generation.
> These 2 configurations works fine on GCC-9.3 and GCC-10.1
>
> Signed-off-by: Chenxi Mao <maochenxi@eswin.com>
> ---
>  arch/riscv/Kconfig | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> index 128192e14ff2..f21b7e5188ca 100644
> --- a/arch/riscv/Kconfig
> +++ b/arch/riscv/Kconfig
> @@ -26,6 +26,8 @@ config RISCV
>  	select ARCH_WANT_DEFAULT_TOPDOWN_MMAP_LAYOUT if MMU
>  	select ARCH_WANT_FRAME_POINTERS
>  	select ARCH_WANT_HUGE_PMD_SHARE if 64BIT
> +	select ARCH_HAS_FAST_MULTIPLIER
> +	select ARCH_SUPPORTS_INT128 if GCC_VERSION >= 50000 || CC_IS_CLANG

IIRC int128 is only supported on 64-bit targets, and we already have this under
RV64I but with a different set of requirements.  It looks like everyone has a
different set of requirements, but I feel like CC_HAS_INT128 is the right way
to go.  I'm not sure why we have the version check there.  Ard: do you know why
we would need both?

The fast multiplier one looks fine to me.  They're supposed to stay
alphabetical, though.

>  	select CLONE_BACKWARDS
>  	select COMMON_CLK
>  	select EDAC_SUPPORT
