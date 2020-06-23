Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D380DC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 09:30:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A054720706
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 09:30:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mMJEyAB+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732099AbgFWJaR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 05:30:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731968AbgFWJaQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 05:30:16 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEE45C061573
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jun 2020 02:30:16 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id y20so2453944wmi.2
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jun 2020 02:30:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=138EdQ9tD73hqhAQhhUeFc0AgFbCmv6nnkdTEfVd45k=;
        b=mMJEyAB+LFQN3ToRiyP/JtJNSf9T1UstlfCcwLHDMD82oN0KpRI+CF6UnSkoxE+68w
         B2HlUbJc6QwV2x+uAP5hTddYX9pe7jygQ96AhD7Xl/ndmRWvJNq2yueWlJw5CQMrvo0V
         zpbnheffHDA/OT2Q3itFxrHzsjtGCFoe7wM0VJGZ1zk/L9fpEsUzPL7qYdueex0vp6BC
         gDawZbD9kC4nH0pgpjJQSmbPLQ5YCXo3tviuc+UJJKm9hTnbJV+XxS6YNA9Xjtr3VU6v
         yTKjOfilP+U9Smby6LUCY2ByoCcNlF8cyEZE/ZtjFVU8O/Bc1rRtTxexoWxDJh0qx9SI
         qhyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=138EdQ9tD73hqhAQhhUeFc0AgFbCmv6nnkdTEfVd45k=;
        b=ACyAm3fE1BjFkO2NAmhEi9iHOyZuBIgSeLJt4merlzhXIRCSrfVgcrfxQN0pXVBAjG
         9qneoakAqRah7LwcrxDVBy0+O7eX6PrZ1LRu0M4citUDChAg7Ddtfg/zDHQTDAAmFr14
         EQfrcExtSvJj5mqbEcm4qL27IkSWQIDuSIHuAkx/f7NbvalSk+gVHwqTN030/q0M/Puv
         OCSA7a+PaT9PQhbxSd8xg3MDI2zGni9ZE800CfjZ9V1tJ79kPcGbK36dDOqSBV95dl/1
         E3KvA92SK4FMd7h5Tp/B4/m6IQnLnPpLiRY/gh6c3a8Twvxt5b90u52HT1wFq5cEPNsE
         xfEg==
X-Gm-Message-State: AOAM532fq80b6oSbr1A1qboMJsfii6hE1ABcJsqQZbVPBRC9TvXb0uJS
        g/nEh8vnpEvTIdFzuhP6Qy2aew==
X-Google-Smtp-Source: ABdhPJwgw03gDJ5Ohajmfthys3AESGOTmn7GKM+DNAWmBfPQXgWJQzFjF8IkdgWH1p07rCtuGP9bjw==
X-Received: by 2002:a7b:cc8b:: with SMTP id p11mr13326998wma.180.1592904615280;
        Tue, 23 Jun 2020 02:30:15 -0700 (PDT)
Received: from [192.168.86.34] (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.googlemail.com with ESMTPSA id v5sm1517824wre.87.2020.06.23.02.30.13
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 Jun 2020 02:30:14 -0700 (PDT)
Subject: Re: [PATCH v2 27/29] nvmem: core: Grammar fixes for help text
To:     =?UTF-8?Q?Andreas_F=c3=a4rber?= <afaerber@suse.de>,
        linux-realtek-soc@lists.infradead.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        =?UTF-8?B?SmFtZXMgVGFpIFvmiLTlv5fls7Bd?= <james.tai@realtek.com>,
        =?UTF-8?B?U3RhbmxleSBDaGFuZyBb5piM6IKy5b63XQ==?= 
        <stanley_chang@realtek.com>, Edgar Lee <cylee12@realtek.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Yangtao Li <tiny.windzz@gmail.com>,
        Fabrice Gasnier <fabrice.gasnier@st.com>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Andrey Smirnov <andrew.smirnov@gmail.com>,
        Maxime Ripard <mripard@kernel.org>
References: <20200623025106.31273-1-afaerber@suse.de>
 <20200623025106.31273-28-afaerber@suse.de>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <47b9a567-cdb7-c4af-5766-959a4ec5a77b@linaro.org>
Date:   Tue, 23 Jun 2020 10:30:13 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20200623025106.31273-28-afaerber@suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 23/06/2020 03:51, Andreas Färber wrote:
> It's "an unsigned" but "a U".
> Similarly, "an entry" but "a binary entry".
> 
> While at it, also drop superfluous articles for negative and zero.
> 
> Fixes: 8b977c5498b8 ("nvmem: core: add nvmem_cell_read_u64")
> Fixes: 0a9b2d1ce422 ("nvmem: core: add nvmem_cell_read_u16")
> Fixes: d026d70a2e94 ("nvmem: core: Add nvmem_cell_read_u32")
> Fixes: f1f50eca5f90 ("nvmem: Introduce devm_nvmem_(un)register()")
> Fixes: eace75cfdcf7 ("nvmem: Add a simple NVMEM framework for nvmem providers")
> Signed-off-by: Andreas Färber <afaerber@suse.de>
> ---
>   In theory, for clean backports this would need to be split into 5 pieces...
>   Not sure whether anyone would actually do that for help text?
>   Dropping the Fixes headers might be an alternative.

TBH, it adds lot of confusion while automatically back-porting these 
patches! For now I have removed these Fixes tags and applied.

As I do not feel this is going to add any value in back-porting this 
grammar fixes!!

--srini
>   
>   v2: New
>   
>   drivers/nvmem/core.c | 12 ++++++------
>   1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
> index fc480d636be2..95bed31391cd 100644
> --- a/drivers/nvmem/core.c
> +++ b/drivers/nvmem/core.c
> @@ -573,7 +573,7 @@ static int nvmem_add_cells_from_of(struct nvmem_device *nvmem)
>   
>   /**
>    * nvmem_register() - Register a nvmem device for given nvmem_config.
> - * Also creates an binary entry in /sys/bus/nvmem/devices/dev-name/nvmem
> + * Also creates a binary entry in /sys/bus/nvmem/devices/dev-name/nvmem
>    *
>    * @config: nvmem device configuration with which nvmem device is created.
>    *
> @@ -728,7 +728,7 @@ static void devm_nvmem_release(struct device *dev, void *res)
>   /**
>    * devm_nvmem_register() - Register a managed nvmem device for given
>    * nvmem_config.
> - * Also creates an binary entry in /sys/bus/nvmem/devices/dev-name/nvmem
> + * Also creates a binary entry in /sys/bus/nvmem/devices/dev-name/nvmem
>    *
>    * @dev: Device that uses the nvmem device.
>    * @config: nvmem device configuration with which nvmem device is created.
> @@ -772,7 +772,7 @@ static int devm_nvmem_match(struct device *dev, void *res, void *data)
>    * @dev: Device that uses the nvmem device.
>    * @nvmem: Pointer to previously registered nvmem device.
>    *
> - * Return: Will be an negative on error or a zero on success.
> + * Return: Will be negative on error or zero on success.
>    */
>   int devm_nvmem_unregister(struct device *dev, struct nvmem_device *nvmem)
>   {
> @@ -1375,7 +1375,7 @@ static int nvmem_cell_read_common(struct device *dev, const char *cell_id,
>   }
>   
>   /**
> - * nvmem_cell_read_u16() - Read a cell value as an u16
> + * nvmem_cell_read_u16() - Read a cell value as a u16
>    *
>    * @dev: Device that requests the nvmem cell.
>    * @cell_id: Name of nvmem cell to read.
> @@ -1390,7 +1390,7 @@ int nvmem_cell_read_u16(struct device *dev, const char *cell_id, u16 *val)
>   EXPORT_SYMBOL_GPL(nvmem_cell_read_u16);
>   
>   /**
> - * nvmem_cell_read_u32() - Read a cell value as an u32
> + * nvmem_cell_read_u32() - Read a cell value as a u32
>    *
>    * @dev: Device that requests the nvmem cell.
>    * @cell_id: Name of nvmem cell to read.
> @@ -1405,7 +1405,7 @@ int nvmem_cell_read_u32(struct device *dev, const char *cell_id, u32 *val)
>   EXPORT_SYMBOL_GPL(nvmem_cell_read_u32);
>   
>   /**
> - * nvmem_cell_read_u64() - Read a cell value as an u64
> + * nvmem_cell_read_u64() - Read a cell value as a u64
>    *
>    * @dev: Device that requests the nvmem cell.
>    * @cell_id: Name of nvmem cell to read.
> 
