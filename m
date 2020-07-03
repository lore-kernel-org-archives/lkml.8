Return-Path: <SRS0=gItQ=AO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00EBBC433DF
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 09:19:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CD38120836
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 09:19:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=semihalf-com.20150623.gappssmtp.com header.i=@semihalf-com.20150623.gappssmtp.com header.b="iN+u8c82"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726111AbgGCJTQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jul 2020 05:19:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725810AbgGCJTP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jul 2020 05:19:15 -0400
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FDC8C08C5DD
        for <linux-kernel@vger.kernel.org>; Fri,  3 Jul 2020 02:19:15 -0700 (PDT)
Received: by mail-lf1-x142.google.com with SMTP id g139so18071179lfd.10
        for <linux-kernel@vger.kernel.org>; Fri, 03 Jul 2020 02:19:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=semihalf-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=nBEfPe/18tEPqv7wv+Zics2+xxXlbthMHh4xvAE4N6c=;
        b=iN+u8c82kyQTkD6qOwBzf2wXqDKCRPBKxcOCnTN1IP8NjDKNt1RvjFw39caeUdcQ9c
         MxdOcNt2hIZbdIIsX3Cfyjt1pXfZGJ3hpaHB8Eq01Oaa21f3Nd1QxMynf8ODKaZo59E5
         XB68y8p7PnSLi7Nuc9TTqR2Iwz3ijSDKD6Z/m3HouzfUicS2VOdfu2BSvHdGHWLRoPUw
         wjv4MNMR2Kt9UhPO6lHw+sjOdAtD5CryaNj3srQTkgnSzIunVzBb9F0qlhJFx8M633DG
         cMzS9Da/rgfWLG5kIOo9Mfq2FsYx0MflYn3yVMr5SoJhIFsOln3VYoYjmejdcc5lFWV2
         HC9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=nBEfPe/18tEPqv7wv+Zics2+xxXlbthMHh4xvAE4N6c=;
        b=LEIbatVnURiLltMIIU+Nu4TJvUJ9bNWYisXkpPIsgQ4z2h3kw19G+yI2Dz32hHiKtd
         wHdU7HxkEhxvmuOkYCimqcXwHbXdJd0KLF1xqVqI/bM1JTdeUwpp8IBWm49oBE35R3xy
         wLQijwxXTmYZVWTJWwjJhADhhSzIjtQL9u6pYp7SWCDAmu9AQorbQLNKws8X7w5e496c
         y1yE4WoFnqiWKDDXRlxYw8onrW1oPCsO1JkNad4fDyY76PVqFpYf/kPNsrD9taAm9OFi
         u0OxzAeBGFfb6Z+/qababQC6ZFua38A030rG/LSS92VtGC0ms6T91NuKNzOF+DRHoNvk
         n37g==
X-Gm-Message-State: AOAM533SSdULGcp0Te0IKvbSOsx39xOta2RzZWJosI2FN0aeELgBm9Yc
        WMmy29oqrfwRXPNXyCW0c5cTHQ==
X-Google-Smtp-Source: ABdhPJwv3Zh9Xqtx9KorLCkbf9g75bpoTeify56dMQego4mY0vfZGL/WPV7E3TjABV7tOwc1voofsQ==
X-Received: by 2002:ac2:5629:: with SMTP id b9mr21258845lff.208.1593767953441;
        Fri, 03 Jul 2020 02:19:13 -0700 (PDT)
Received: from [192.168.1.9] ([83.68.95.66])
        by smtp.googlemail.com with ESMTPSA id u15sm3904281ljh.56.2020.07.03.02.19.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Jul 2020 02:19:12 -0700 (PDT)
Subject: Re: [PATCH v3 1/4] iommu/arm-smmu: Add SMMU ID2 register fixup hook
To:     Robin Murphy <robin.murphy@arm.com>, will@kernel.org,
        joro@8bytes.org, gregory.clement@bootlin.com, robh+dt@kernel.org,
        hannah@marvell.com
Cc:     linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
        devicetree@vger.kernel.org, catalin.marinas@arm.com,
        nadavh@marvell.com, linux-arm-kernel@lists.infradead.org,
        mw@semihalf.com
References: <20200702201633.22693-1-tn@semihalf.com>
 <20200702201633.22693-2-tn@semihalf.com>
 <d3540512-09c7-0fa5-2b35-6f1112a575a9@arm.com>
From:   Tomasz Nowicki <tn@semihalf.com>
Message-ID: <8758046a-9e11-8d21-26ff-2f02a315f3d4@semihalf.com>
Date:   Fri, 3 Jul 2020 11:19:11 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <d3540512-09c7-0fa5-2b35-6f1112a575a9@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03.07.2020 10:24, Robin Murphy wrote:
> On 2020-07-02 21:16, Tomasz Nowicki wrote:
>> We already have 'cfg_probe' hook which meant to override and apply
>> workarounds while probing ID registers. However, 'cfg_probe' is called
>> at the very end and therefore for some cases fixing up things becomes 
>> complex
>> or requires exporting of SMMU driver structures. Hence, seems it is 
>> better and
>> cleaner to do ID fixup right away. In preparation for adding Marvell
>> errata add an extra ID2 fixup hook.
> 
> Hmm, the intent of ->cfg_probe was very much to give impl a chance to 
> adjust the detected features before we start consuming them, with this 
> exact case in mind. Since the Cavium quirk isn't actually doing that - 
> it just needs to run *anywhere* in the whole probe process - I'm under 
> no illusion that I put the hook in exactly the right place first time 
> around ;)
> 
> The diff below should be more on the mark...
> 
> Robin.
> 
> ----->8-----
> diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
> index 243bc4cb2705..884ffca5b1eb 100644
> --- a/drivers/iommu/arm-smmu.c
> +++ b/drivers/iommu/arm-smmu.c
> @@ -1891,6 +1891,9 @@ static int arm_smmu_device_cfg_probe(struct 
> arm_smmu_device *smmu)
>               smmu->features |= ARM_SMMU_FEAT_FMT_AARCH64_64K;
>       }
> 
> +    if (smmu->impl && smmu->impl->cfg_probe)
> +        return smmu->impl->cfg_probe(smmu);
> +
>       /* Now we've corralled the various formats, what'll it do? */
>       if (smmu->features & ARM_SMMU_FEAT_FMT_AARCH32_S)
>           smmu->pgsize_bitmap |= SZ_4K | SZ_64K | SZ_1M | SZ_16M;
> @@ -1909,7 +1912,6 @@ static int arm_smmu_device_cfg_probe(struct 
> arm_smmu_device *smmu)
>       dev_notice(smmu->dev, "\tSupported page sizes: 0x%08lx\n",
>              smmu->pgsize_bitmap);
> 
> -
>       if (smmu->features & ARM_SMMU_FEAT_TRANS_S1)
>           dev_notice(smmu->dev, "\tStage-1: %lu-bit VA -> %lu-bit IPA\n",
>                  smmu->va_size, smmu->ipa_size);
> @@ -1918,9 +1920,6 @@ static int arm_smmu_device_cfg_probe(struct 
> arm_smmu_device *smmu)
>           dev_notice(smmu->dev, "\tStage-2: %lu-bit IPA -> %lu-bit PA\n",
>                  smmu->ipa_size, smmu->pa_size);
> 
> -    if (smmu->impl && smmu->impl->cfg_probe)
> -        return smmu->impl->cfg_probe(smmu);
> -
>       return 0;
>   }
> 

I was under impression that ->cfg_probe was meant for Cavium alike 
errata (position independent). Then I will move ->cfg_probe as you 
suggested. I prefer not to add yet another impl hook too :)

Thanks,
Tomasz
