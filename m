Return-Path: <SRS0=dgGg=75=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E160C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 08:28:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2A77220767
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 08:28:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gLakXFsI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727946AbgFPI2H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jun 2020 04:28:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725911AbgFPI2G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 04:28:06 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5117C05BD43
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jun 2020 01:28:05 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id x13so19775998wrv.4
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jun 2020 01:28:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=B3Zvc0+WkJWTmHdueBto0Q5WGj5wxL8G3qgASoBVzNY=;
        b=gLakXFsIC8xZtNwr+XfHP1wnr5SDo5nHecQ4brNe+lN2ChBIsKPXALQeHsIYYaLTXb
         wsvothXzTvUtQKDoSSHmDdiny1LJSckLfw1XnhXhiPAKw/TnCVbjH9L2P5IOgnxLahvD
         5kajvazyTYkm4UxG9dIxiqA2FO1wwGkvejOnt/oVT7h13AdfGubQVmi2NieFR0lX/NIZ
         8YFNuHCvlY3mexZYqrHcvNt2LtxuvNyr43qnliRLp+9Q2uLMZLwNvzMlnLOYbGGjAtXk
         LUUwyneBgVZaLmTSdxo2Gk03Mj5BJVjRjoHyK1UcuXPm70vAq+YgSNDHi9gCE+VEavB+
         5zLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=B3Zvc0+WkJWTmHdueBto0Q5WGj5wxL8G3qgASoBVzNY=;
        b=aGBi9f4fjlt01inFnkH3rnsFw2lQqF0JwYCw8YBqsXJo895nrMbqgnSqZeHd6wdhsk
         erzlvLj/NfNC+YUzTWFQokOjJYeHTIJg5gwXgMe8qSIRltsLUu0eu2XNIvTGH4jHmPWa
         9nSGAb+1TS+RnulOo1SW9dWq2EZ4Fjm2dPRHNGaaTxS6C8q7Ve5pFFbtnpTNUtlW3BVT
         OGU8T98GW8mU0cehHyzMyX2O+qtzrWm6XJaaJ0+rSeFJyk/tYBCCfu5bhkyPnvKhFkyf
         gbc4avfyYP14MAj2xvGPNrGxY5HSaGEzg/81QIgvUowb6Esngr1YCNk/B5yQ/V144DhR
         gnFA==
X-Gm-Message-State: AOAM533iFjP64ZJTvOVFzLnyHpFf7lBoyJxup8XMHm1xwGUlo2E2ICKX
        2su5kTd2U+j8hCxUcCMTsl3FSw==
X-Google-Smtp-Source: ABdhPJzAvCk0ui/vMtJ+dz/ehjMGM1fOixVzM29fYWpKqQN1QryV19KiL93HTiApPkKVxsAzR5Xljg==
X-Received: by 2002:adf:ea11:: with SMTP id q17mr1748627wrm.75.1592296084603;
        Tue, 16 Jun 2020 01:28:04 -0700 (PDT)
Received: from dell ([109.180.115.156])
        by smtp.gmail.com with ESMTPSA id z16sm28111508wrm.70.2020.06.16.01.28.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2020 01:28:03 -0700 (PDT)
Date:   Tue, 16 Jun 2020 09:28:02 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Gene Chen <gene.chen.richtek@gmail.com>
Cc:     matthias.bgg@gmail.com, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        gene_chen@richtek.com, Wilma.Wu@mediatek.com,
        shufan_lee@richtek.com, cy_huang@richtek.com
Subject: Re: [PATCH] mfd: mt6360: Fix register driver NULL pointer by add
 driver name
Message-ID: <20200616082802.GM2608702@dell>
References: <1591609125-3761-1-git-send-email-gene.chen.richtek@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1591609125-3761-1-git-send-email-gene.chen.richtek@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 08 Jun 2020, Gene Chen wrote:

> From: Gene Chen <gene_chen@richtek.com>
> 
> accidentally remove driver name when
> replace probe by probe_new in add mt6360 mfd driver patch v4
> 
> [  121.243012] EAX: c2a8bc64 EBX: 00000000 ECX: 00000000 EDX: 00000000
> [  121.243012] ESI: c2a8bc79 EDI: 00000000 EBP: e54bdea8 ESP: e54bdea0
> [  121.243012] DS: 007b ES: 007b FS: 0000 GS: 0000 SS: 0068 EFLAGS: 00010286
> [  121.243012] CR0: 80050033 CR2: 00000000 CR3: 02ec3000 CR4: 000006b0
> [  121.243012] Call Trace:
> [  121.243012]  kset_find_obj+0x3d/0xc0
> [  121.243012]  driver_find+0x16/0x40
> [  121.243012]  driver_register+0x49/0x100
> [  121.243012]  ? i2c_for_each_dev+0x39/0x50
> [  121.243012]  ? __process_new_adapter+0x20/0x20
> [  121.243012]  ? cht_wc_driver_init+0x11/0x11
> [  121.243012]  i2c_register_driver+0x30/0x80
> [  121.243012]  ? intel_lpss_pci_driver_init+0x16/0x16
> [  121.243012]  mt6360_pmu_driver_init+0xf/0x11
> [  121.243012]  do_one_initcall+0x33/0x1a0
> [  121.243012]  ? parse_args+0x1eb/0x3d0
> [  121.243012]  ? __might_sleep+0x31/0x90
> [  121.243012]  ? kernel_init_freeable+0x10a/0x17f
> [  121.243012]  kernel_init_freeable+0x12c/0x17f
> [  121.243012]  ? rest_init+0x110/0x110
> [  121.243012]  kernel_init+0xb/0x100
> [  121.243012]  ? schedule_tail_wrapper+0x9/0xc
> [  121.243012]  ret_from_fork+0x19/0x24
> [  121.243012] Modules linked in:
> [  121.243012] CR2: 0000000000000000
> [  121.243012] random: get_random_bytes called from init_oops_id+0x3a/0x40 with crng_init=0
> [  121.243012] ---[ end trace 38a803400f1a2bee ]---
> [  121.243012] EIP: strcmp+0x11/0x30
> 
> Signed-off-by: Gene Chen <gene_chen@richtek.com>
> ---
>  drivers/mfd/mt6360-core.c | 1 +
>  1 file changed, 1 insertion(+)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
