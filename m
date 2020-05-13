Return-Path: <SRS0=g10L=63=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94C6AC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 21:15:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8EE3F20675
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 21:15:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=dabbelt-com.20150623.gappssmtp.com header.i=@dabbelt-com.20150623.gappssmtp.com header.b="IyJE95cx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728145AbgEMVOq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 May 2020 17:14:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725943AbgEMVOp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 May 2020 17:14:45 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E099C061A0C
        for <linux-kernel@vger.kernel.org>; Wed, 13 May 2020 14:14:44 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id x15so303454pfa.1
        for <linux-kernel@vger.kernel.org>; Wed, 13 May 2020 14:14:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=fQPXZp+IVSxbapxw+qChW71ug0twA5FFI0kmAhQ2wws=;
        b=IyJE95cx6fUjoUOtxi6G5B/lxWB5ibznMc114jMJGxspQQTGQMUcGMrMk2WtlJjWo0
         PkRMLu26n1UYSg4ZJQzWfqJ7zaU37jmlYr/pp1WY9YN3N2QmTNX47nlFsvKEEE/wBay8
         E6TU1Q/GiETUSfOG/ZfMVMaD6Dvu9KtwGVkG1DCZYtv3pZqp5HvJoZSzp8JP5RlNJdb2
         bXsgJwh1TPDAOXoNLeaq4xzFVxEPgO0msB9kSO5M7GB4uS6DMJfG0V0yZvUnApB37FMx
         gxZHaUdedYhJVo8ph2WaPlX+DJveMWvERWXTuEIBk/MtuSJSF2JAupOFOBmsFoTOB6H/
         q0Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=fQPXZp+IVSxbapxw+qChW71ug0twA5FFI0kmAhQ2wws=;
        b=UC1B8RRiro2yobOvENVSHl3F2xGYbaF53VVhq3DVkVK3zksFj7i71q6tVEzp1/eZKM
         9wBoYXYef00FaQhgPul+8fHe/sT3xWsce4btWRfvqmfrtarHO/g6oxqLDApoOnnPCFnD
         931v6GrgnLw1G5Vj7C+Uj91Qv7bejh8X77AAVjx/8tQVCKSCPxSOz2Dq7wYPWD6EmnkV
         04ebwq2AiTlMmk5a4LrQjD1G2jNbL2+zYZoclvewYWUiixlzUcPjCP9PuJLvb1sKVzkZ
         KMa6GQqNAVhDwp/Ia7Zt5vjCbP1pdIYC+DkdWubPM/PY6G6KDhwFMlY0gT6sT6am86Vh
         fV6Q==
X-Gm-Message-State: AOAM530e6vHO3n3gfSAUHV+ZZrodZ4BVJE1ApoEpHFKzMut6BRCzuifO
        jIwIywcpsWP/8G06KVmm/75oav01bEQ=
X-Google-Smtp-Source: ABdhPJzdTa0U9kp2niBnjnx175RKaHvwsebr/DnTI6hq6UVnAjjZVxFFrmMdl9SIIYoqxiJIPtOgJg==
X-Received: by 2002:a62:1d48:: with SMTP id d69mr1161543pfd.102.1589404483317;
        Wed, 13 May 2020 14:14:43 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id q134sm407114pfc.143.2020.05.13.14.14.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2020 14:14:42 -0700 (PDT)
Date:   Wed, 13 May 2020 14:14:42 -0700 (PDT)
X-Google-Original-Date: Tue, 12 May 2020 16:33:48 PDT (-0700)
Subject:     Re: [PATCH 01/10] riscv: Fix unmet direct dependencies built based on SOC_VIRT
In-Reply-To: <20200511022001.179767-2-wangkefeng.wang@huawei.com>
CC:     Paul Walmsley <paul.walmsley@sifive.com>, aou@eecs.berkeley.edu,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        wangkefeng.wang@huawei.com, hulkci@huawei.com
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     wangkefeng.wang@huawei.com
Message-ID: <mhng-a9830a3c-320d-4a7a-8792-85d436b32182@palmerdabbelt-glaptop1>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 10 May 2020 19:19:52 PDT (-0700), wangkefeng.wang@huawei.com wrote:
> Fix unmet direct dependencies Warning and fix Kconfig indent.
>
> WARNING: unmet direct dependencies detected for POWER_RESET_SYSCON
>   Depends on [n]: POWER_RESET [=n] && OF [=y] && HAS_IOMEM [=y]
>   Selected by [y]:
>   - SOC_VIRT [=y]
>
> WARNING: unmet direct dependencies detected for POWER_RESET_SYSCON_POWEROFF
>   Depends on [n]: POWER_RESET [=n] && OF [=y] && HAS_IOMEM [=y]
>   Selected by [y]:
>   - SOC_VIRT [=y]
>
> WARNING: unmet direct dependencies detected for RTC_DRV_GOLDFISH
>   Depends on [n]: RTC_CLASS [=n] && OF [=y] && HAS_IOMEM [=y] && (GOLDFISH [=y] || COMPILE_TEST [=n])
>   Selected by [y]:
>   - SOC_VIRT [=y]
>
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
> ---
>  arch/riscv/Kconfig.socs | 17 +++++++++--------
>  1 file changed, 9 insertions(+), 8 deletions(-)
>
> diff --git a/arch/riscv/Kconfig.socs b/arch/riscv/Kconfig.socs
> index 4b2303ca20b9..6c88148f1b9b 100644
> --- a/arch/riscv/Kconfig.socs
> +++ b/arch/riscv/Kconfig.socs
> @@ -11,14 +11,15 @@ config SOC_SIFIVE
>  	  This enables support for SiFive SoC platform hardware.
>
>  config SOC_VIRT
> -       bool "QEMU Virt Machine"
> -       select POWER_RESET_SYSCON
> -       select POWER_RESET_SYSCON_POWEROFF
> -       select GOLDFISH
> -       select RTC_DRV_GOLDFISH
> -       select SIFIVE_PLIC
> -       help
> -         This enables support for QEMU Virt Machine.
> +	bool "QEMU Virt Machine"
> +	select POWER_RESET
> +	select POWER_RESET_SYSCON
> +	select POWER_RESET_SYSCON_POWEROFF
> +	select GOLDFISH
> +	select RTC_DRV_GOLDFISH if RTC_CLASS
> +	select SIFIVE_PLIC
> +	help
> +	  This enables support for QEMU Virt Machine.
>
>  config SOC_KENDRYTE
>  	bool "Kendryte K210 SoC"

This is another area we need to clean up (maybe converting from select to
imply?), but given this fixes likely build errors I'm going to take it onto
fixes.

Thanks!
