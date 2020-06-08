Return-Path: <SRS0=Cjtw=7V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0A06C433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 19:28:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8BC3B20760
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 19:28:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EhpM/xsx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726718AbgFHT2d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jun 2020 15:28:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726410AbgFHT2c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jun 2020 15:28:32 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92DEDC08C5C2
        for <linux-kernel@vger.kernel.org>; Mon,  8 Jun 2020 12:28:32 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id r7so18743874wro.1
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jun 2020 12:28:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=nNfoDipJXnYq7VJ5hMTMW93JkoBjEN3XF2dENorzijs=;
        b=EhpM/xsxL6PmflZhqLC1Kz1772OJH/9mtEZ9xvB5MG7h4Ta7W8GwdjMKzhPwwup78R
         x3NA7CMImhUeJzDJe9tz2HDD/hiYzRWRRaKGwDP8i+/GAq80GTqev0yKjj1z05GzJxnI
         XQzU5YBbvUTu+7LTSog2YHO4eGxNjwO0t4X5IugL9GgaXjArxsvt4eEncBh8F5yg753d
         V2ViUW1FvckLJChRrKKE6sPjS9fQKVOTbxH7pszf+DYjMfBM+1Hc5KsGKFzXoRuMCHdq
         qcIog949KsxfTcnLMEjp/n5ZzR92+H2nxE/UzteEtxPNVswUgdyHEkmFQJO9wL+foEcN
         CXXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=nNfoDipJXnYq7VJ5hMTMW93JkoBjEN3XF2dENorzijs=;
        b=WE+3yfjheVU9X9UbC/uA7tftvLiQ+fEx9gk3k2p1FnSAup5ClknQRs2/J3zZOdyckg
         7S7W3rGXNpHXr+Z17rIm+doAaLbCImAp5mn6c3F4weKVDByMSOrXr4lBSKIBfEgdFLel
         hjnvv3XLz6s+/6qN9NOlIvhw+N3iEqEX4r23veJ+Ysubaj91NOYLBvoj5bLargoYJ1jc
         PMdsV8eZ/W2NFQOCJ9yYoOL7d7z6qYS18JZvPao779yXnWIbIfHb8f9NA/+HkPBCTO/C
         My+2P++ePuEgO9xFKMUrMQHtkvWXtUdNvU1+0zyktDDqIFiKWthjyLLwyREsK4xmJ8ni
         zKaQ==
X-Gm-Message-State: AOAM531LhaMIYN0IZiD6uyOltoosP8HQYOx4quRPCmsyAmSGs+4X+nTR
        cOH4yrmpMQtzoPyAt7RlvVuxYA==
X-Google-Smtp-Source: ABdhPJwFT/4AGR1g3XBLbVOb2Lb1zJ42emgmqdFC7+HcborRvYs9taXcrKFmaFuvTjXIcnZBJadnAA==
X-Received: by 2002:adf:9d8e:: with SMTP id p14mr347943wre.236.1591644511323;
        Mon, 08 Jun 2020 12:28:31 -0700 (PDT)
Received: from dell ([95.147.198.92])
        by smtp.gmail.com with ESMTPSA id c70sm473889wme.32.2020.06.08.12.28.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2020 12:28:30 -0700 (PDT)
Date:   Mon, 8 Jun 2020 20:28:29 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Gene Chen <gene.chen.richtek@gmail.com>
Cc:     matthias.bgg@gmail.com, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        gene_chen@richtek.com, Wilma.Wu@mediatek.com,
        shufan_lee@richtek.com, cy_huang@richtek.com
Subject: Re: [PATCH] mfd: mt6360: Fix register driver NULL pointer by add
 driver name
Message-ID: <20200608192829.GG4106@dell>
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

How did this driver ever work for you?

> Signed-off-by: Gene Chen <gene_chen@richtek.com>
> ---
>  drivers/mfd/mt6360-core.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/mfd/mt6360-core.c b/drivers/mfd/mt6360-core.c
> index db8cdf5..e9cacc2 100644
> --- a/drivers/mfd/mt6360-core.c
> +++ b/drivers/mfd/mt6360-core.c
> @@ -412,6 +412,7 @@ MODULE_DEVICE_TABLE(of, mt6360_pmu_of_id);
>  
>  static struct i2c_driver mt6360_pmu_driver = {
>  	.driver = {
> +		.name = "mt6360_pmu",
>  		.pm = &mt6360_pmu_pm_ops,
>  		.of_match_table = of_match_ptr(mt6360_pmu_of_id),
>  	},

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
