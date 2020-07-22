Return-Path: <SRS0=5pK+=BB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 417E0C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 04:46:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0DA6E20792
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 04:46:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=dabbelt-com.20150623.gappssmtp.com header.i=@dabbelt-com.20150623.gappssmtp.com header.b="gCf//hqr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726623AbgGVEqb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jul 2020 00:46:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725862AbgGVEqb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jul 2020 00:46:31 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50071C061794
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jul 2020 21:46:31 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id t15so516886pjq.5
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jul 2020 21:46:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=p+1Zg+rcxW9W9uDo4bgbPd44JqLnl98/h6B7hdCMtAk=;
        b=gCf//hqrs62GJkXJuGGad1rarIOGvqn3r37DEoNV/vZtFeyKNDeLfQk70kHP3nTyro
         38KQBw4dK2Y/BWKSpLg1xYhnDPnUZtUjd7a2Ha37fC2bD6tzeRjv+LPApWyZGM/kMwkd
         gh3TsqQTgXrqJN1AaPSIWgunV8vIKH6OXSQJWhSbqLEpxDa+1RNtwDogGUYWBLK5T0/1
         k1JeyZDWt3f0Bo7qokEE1wDW/CLMPv/pFOm9V1V3b1/q1IsAX4WPu75JBd+2rbccpajn
         r5DE4EF/PgI3FZkyiqH48N0BZhS8MnxTlxWu26zEiKIS3uX11Db0Ta26Itli29LCvuix
         XF/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=p+1Zg+rcxW9W9uDo4bgbPd44JqLnl98/h6B7hdCMtAk=;
        b=tC65e1CCiiNaB1RTIE+fDHp6lkN5IaAYz8zrmz9e+ljVfO1PcOLTLLLvxj5IwhWGMn
         3FyLP1o0RGxQnraw7CA1SSR1+WOLkLNPIMmlK3rEerIy7aEGoR3Gocd0KUjfSojLdzHp
         NdHqkGi9CE1lN+Le8a7z6l4hJj3PtZzTyJ2qBs77EiVo/TsJ5XNzgPSBSCXBGCxOHAFJ
         CqwjX3pIV5mGO3Rnd6zkyLgAuIK8CsoPkoI47L2D9g1AyKBkTx2IxEkwHsvZCT1hV1kU
         cW/zmUVaSuL2h6mMbeXav0Q5eCr3rljp3hno41pBj9AlCIWuuUm/HuHYtLKSxU2emG+j
         qGOQ==
X-Gm-Message-State: AOAM531i79riDLZ7bdk/WSa3PfVI54ueAQocmK149L9xREmauhnAfR2c
        n8zH67a7BbkS6dauYr28VkFutQ==
X-Google-Smtp-Source: ABdhPJx9RXCa2cd2bkgXO7d6w24bQWdI88P7ZrINXX0REFMfx/nbF2LCD4l4X2VAacAmHXbe+VusPg==
X-Received: by 2002:a17:90a:1342:: with SMTP id y2mr8133192pjf.98.1595393189642;
        Tue, 21 Jul 2020 21:46:29 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id 9sm21710120pfx.131.2020.07.21.21.46.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jul 2020 21:46:28 -0700 (PDT)
Date:   Tue, 21 Jul 2020 21:46:28 -0700 (PDT)
X-Google-Original-Date: Tue, 21 Jul 2020 21:46:22 PDT (-0700)
Subject:     Re: [PATCH] riscv: Select ARCH_HAS_DEBUG_VM_PGTABLE
In-Reply-To: <20200714212611.19692-1-kernel@esmil.dk>
CC:     linux-riscv@lists.infradead.org, kernel@esmil.dk,
        Paul Walmsley <paul.walmsley@sifive.com>,
        anshuman.khandual@arm.com, linux-kernel@vger.kernel.org
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     kernel@esmil.dk
Message-ID: <mhng-23ad157f-d2c5-4948-88dd-176b8be99cf1@palmerdabbelt-glaptop1>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 14 Jul 2020 14:26:11 PDT (-0700), kernel@esmil.dk wrote:
> This allows the pgtable tests to be built.
>
> Signed-off-by: Emil Renner Berthing <kernel@esmil.dk>
> ---
>
> The tests seem to succeed both in Qemu and on the HiFive Unleashed
>
> Both with and without the recent additions in
> https://lore.kernel.org/linux-riscv/1594610587-4172-1-git-send-email-anshuman.khandual@arm.com/
>
>  Documentation/features/debug/debug-vm-pgtable/arch-support.txt | 2 +-
>  arch/riscv/Kconfig                                             | 1 +
>  2 files changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/features/debug/debug-vm-pgtable/arch-support.txt b/Documentation/features/debug/debug-vm-pgtable/arch-support.txt
> index c527d05c0459..c9a764c3c795 100644
> --- a/Documentation/features/debug/debug-vm-pgtable/arch-support.txt
> +++ b/Documentation/features/debug/debug-vm-pgtable/arch-support.txt
> @@ -23,7 +23,7 @@
>      |    openrisc: | TODO |
>      |      parisc: | TODO |
>      |     powerpc: |  ok  |
> -    |       riscv: | TODO |
> +    |       riscv: |  ok  |
>      |        s390: |  ok  |
>      |          sh: | TODO |
>      |       sparc: | TODO |
> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> index 3230c1d48562..b4e674b1e857 100644
> --- a/arch/riscv/Kconfig
> +++ b/arch/riscv/Kconfig
> @@ -15,6 +15,7 @@ config RISCV
>  	select ARCH_CLOCKSOURCE_INIT
>  	select ARCH_HAS_BINFMT_FLAT
>  	select ARCH_HAS_DEBUG_VIRTUAL if MMU
> +	select ARCH_HAS_DEBUG_VM_PGTABLE
>  	select ARCH_HAS_DEBUG_WX
>  	select ARCH_HAS_GCOV_PROFILE_ALL
>  	select ARCH_HAS_GIGANTIC_PAGE

This is on for-next.  Thanks!
