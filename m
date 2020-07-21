Return-Path: <SRS0=jpuI=BA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 261E1C433E2
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 01:17:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0381620658
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 01:17:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=dabbelt-com.20150623.gappssmtp.com header.i=@dabbelt-com.20150623.gappssmtp.com header.b="Kd2f1DpQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728335AbgGUBRr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 21:17:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726046AbgGUBRq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 21:17:46 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64BEFC061794
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jul 2020 18:17:45 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id gc9so747047pjb.2
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jul 2020 18:17:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=/n872cM2M3CLkRHUgVO55nk5U5BBIV7BrPLcG211bhQ=;
        b=Kd2f1DpQAICU8hxcTKxIt59+qYM3UA0c492sd8XUrW/ph+nhKdOyCFFtJUT4wgoemm
         7Xu6UZtnu/A9GUS8HmPZEHyMXYnE0l77ZrZDvmRHWFURz48wW3Txed71f+K2Xd4O/s4v
         J7RblJMknVcIeTYRZZzesbWmF1qTJ5F7R8mjGjC3hPFe31HJdxYyEmR+AaRi9VsvYgNj
         fbOQWXDCwtBcI2R+POQ1SDx18v9wAxcc6vn+EGsHuXbQ/UXxQMvNf6HrgduKQdyxnnGi
         PDSWiZNqoIeGptGSzIR2yfmp27Qk+aq80JP1S/+jaccP0uII5jlI7yjzEkuvYuGc4PFe
         Eawg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=/n872cM2M3CLkRHUgVO55nk5U5BBIV7BrPLcG211bhQ=;
        b=DX3UBSP9KpITqPLC3piFO9pRD0VbYWpcox699IjF5gjKVFw0YjdIuCv6bzvD3aKfhs
         ETwmNZ90k0zgwYJdV2FWAjTjEuT8+bVf48Rl25TI/9iqaozHGcucl/vJFYpKsfu3HOii
         dfOs6E1rbcMVeOBcYgM0HUNL2WyfvYL5xKAb6o18rMK81mazwk+/BNl0cS6RAfSG1QFM
         JKqynK4NVga3MmVM17HSihavkdetJi2qZN5ny/0inuKF0qyXt7DjTP1VnYCGKKZtibGC
         IA0Bj1MIcNDgJ0jyNZIxoQeSIAFAoePfLp3FXNgrR4eGWBI+ppqfU4ZSbGz36Zv4Wjzq
         DvBw==
X-Gm-Message-State: AOAM531x9t6e7epwuR1/yZDdqiinhwZRMBpFGbWCyi5FyTOSjCdjkE9k
        g+ty36K8cRG2OoLcsbcoKCf6kQ==
X-Google-Smtp-Source: ABdhPJyZDnF0IgmpupMMlaGLLmbAiAkmqi/pDJEdE7GNxD7OYpkKqAPoSVxXLay5KCsO4CZQXtsokw==
X-Received: by 2002:a17:90a:784b:: with SMTP id y11mr2144112pjl.51.1595294264663;
        Mon, 20 Jul 2020 18:17:44 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id o23sm18965104pfd.126.2020.07.20.18.17.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2020 18:17:44 -0700 (PDT)
Date:   Mon, 20 Jul 2020 18:17:44 -0700 (PDT)
X-Google-Original-Date: Mon, 20 Jul 2020 18:17:42 PDT (-0700)
Subject:     Re: [PATCH 1/1] riscv: Enable ARCH_HAS_FAST_MULTIPLIER for RV64I
In-Reply-To: <20200709051922.13110-1-maochenxi@eswin.com>
CC:     Paul Walmsley <paul.walmsley@sifive.com>, aou@eecs.berkeley.edu,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        chenxi.mao2013@gmail.com, maochenxi@eswin.com
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     maochenxi@eswin.com
Message-ID: <mhng-e8fe18f0-e6d7-4ee2-8a9b-a00dbf0b338b@palmerdabbelt-glaptop1>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 08 Jul 2020 22:19:22 PDT (-0700), maochenxi@eswin.com wrote:
> Enable ARCH_HAS_FAST_MULTIPLIER on RV64I
> which works fine on GCC-9.3 and GCC-10.1
>
> PS2: remove ARCH_SUPPORTS_INT128 because of RV64I already enabled.
>
> Signed-off-by: Chenxi Mao <maochenxi@eswin.com>
> ---
>  arch/riscv/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> index 128192e14ff2..84e6777fecad 100644
> --- a/arch/riscv/Kconfig
> +++ b/arch/riscv/Kconfig
> @@ -202,6 +202,7 @@ config ARCH_RV64I
>  	bool "RV64I"
>  	select 64BIT
>  	select ARCH_SUPPORTS_INT128 if CC_HAS_INT128 && GCC_VERSION >= 50000
> +	select ARCH_HAS_FAST_MULTIPLIER
>  	select HAVE_DYNAMIC_FTRACE if MMU
>  	select HAVE_DYNAMIC_FTRACE_WITH_REGS if HAVE_DYNAMIC_FTRACE
>  	select HAVE_FTRACE_MCOUNT_RECORD

Ah, thanks -- this one didn't show up when I was looking at the last one.  I
think we can put the fast multiplier on rv32 and rv64, there shouldn't be any
difference there.  I guess in theory we should be sticking this all in some
sort of "platform type" optimization flags, but that's probably bit much for
now.
