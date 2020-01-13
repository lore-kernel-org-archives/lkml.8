Return-Path: <SRS0=WByN=3C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFB28C33CA9
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 18:45:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0F57214AF
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 18:45:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oGUwSjjs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728903AbgAMSpz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jan 2020 13:45:55 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:43544 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728679AbgAMSpy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jan 2020 13:45:54 -0500
Received: by mail-pl1-f195.google.com with SMTP id p27so4145461pli.10
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jan 2020 10:45:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=TRPXa/X1Mc7UsbFtxb3zNyLDA7j12ID+Zjq7lbcmmkk=;
        b=oGUwSjjsO4Vl87AgYtTvHpWWrbUyrWHbiD9ePlNH7Ulh4V1z95rtqNvDPUVJhG1RoE
         rzpNKMiYj/oabZuPdZLbpVW4zISIAGyzY4YI0s6a1LPm1ZSojYpLjS0pBLiLBequ3p2A
         DQ4pgyjVXzyTHvSosqJBdtdlXGytXdt1P8L7GPygwnkbsYq5D6MxJMllKuS7aAo336IZ
         ZZzwGocvwdYMI18zCm29pX/afEz7En6nq4SSaHEtbRHeiFW1oNuX3Flo8zJ5kSQ/rgHm
         XS/XbbdRddwCnQKQrwC4i2S9Pz1FcNp3ttTy8sRwIx8cCC0zoIRRCC8xCGTfzHfgQzdb
         P+iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=TRPXa/X1Mc7UsbFtxb3zNyLDA7j12ID+Zjq7lbcmmkk=;
        b=Ibg5AKWBaqwSXX56l+2RBKP9hmgryF+Zrvhy9JCQo6pB9IfOZlAeOZ9YtS0FU1iUH7
         wuUJKKr4q30J2JyKodrQuIw6oPVazLlhBEuV3Oz/IpKziHdh9+PXEc5qYk16LorzO6Wy
         W/b9ic4n67TRN9LyL4DUQymsX5V0uFdDcdd6VhHwb6W8+m5UnhJ80TkX6BtTpKZKYN8p
         oZoyGA32ERBLXTRPIS5ab/2srk4OHi18AlKj+h6lfqK2yhcbMYseQ6KaMWj5kbcmRQRu
         JhCcx/uXhebnfCEw9npqAln0n2cfO78Y4k5ign04xLsbZNa7aOfmU8GJmVUaH3HSuNt4
         +ZlQ==
X-Gm-Message-State: APjAAAUAozFN7rVSvLvWDWpaeTwIGpD1l9qcapOx1bLZNrdZ/2S/a1Nn
        KnMwI0CfNnFgAJ0Td0mEIqnI8A==
X-Google-Smtp-Source: APXvYqxBBleDnBHycO1RtJCKMDtjbqTGZuiZXIov6MJMxK2XiiFFVzBdNS0dPqd4OtvpBNqLhBrY7g==
X-Received: by 2002:a17:90a:950b:: with SMTP id t11mr9450982pjo.79.1578941153872;
        Mon, 13 Jan 2020 10:45:53 -0800 (PST)
Received: from yoga (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id m3sm14191638pgp.32.2020.01.13.10.45.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jan 2020 10:45:53 -0800 (PST)
Date:   Mon, 13 Jan 2020 10:45:50 -0800
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Rob Clark <robdclark@gmail.com>
Cc:     dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        linux-arm-msm@vger.kernel.org,
        Jordan Crouse <jcrouse@codeaurora.org>,
        Sharat Masetty <smasetty@codeaurora.org>,
        Rob Clark <robdclark@chromium.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Brian Masney <masneyb@onstation.org>,
        Douglas Anderson <dianders@chromium.org>,
        Fabio Estevam <festevam@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/4] drm/msm: support firmware-name for zap fw (v2)
Message-ID: <20200113184550.GC1511@yoga>
References: <20200112195405.1132288-1-robdclark@gmail.com>
 <20200112195405.1132288-2-robdclark@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200112195405.1132288-2-robdclark@gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun 12 Jan 11:53 PST 2020, Rob Clark wrote:

> From: Rob Clark <robdclark@chromium.org>
> 
> Since zap firmware can be device specific, allow for a firmware-name
> property in the zap node to specify which firmware to load, similarly to
> the scheme used for dsp/wifi/etc.
> 
> v2: only need a single error msg when we can't load from firmware-name
>     specified path, and fix comment [Bjorn A.]
> 

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

> Signed-off-by: Rob Clark <robdclark@chromium.org>
> ---
>  drivers/gpu/drm/msm/adreno/adreno_gpu.c | 30 ++++++++++++++++++++++---
>  1 file changed, 27 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/msm/adreno/adreno_gpu.c b/drivers/gpu/drm/msm/adreno/adreno_gpu.c
> index 112e8b8a261e..456bb5af1717 100644
> --- a/drivers/gpu/drm/msm/adreno/adreno_gpu.c
> +++ b/drivers/gpu/drm/msm/adreno/adreno_gpu.c
> @@ -26,6 +26,7 @@ static int zap_shader_load_mdt(struct msm_gpu *gpu, const char *fwname,
>  {
>  	struct device *dev = &gpu->pdev->dev;
>  	const struct firmware *fw;
> +	const char *signed_fwname = NULL;
>  	struct device_node *np, *mem_np;
>  	struct resource r;
>  	phys_addr_t mem_phys;
> @@ -58,8 +59,31 @@ static int zap_shader_load_mdt(struct msm_gpu *gpu, const char *fwname,
>  
>  	mem_phys = r.start;
>  
> -	/* Request the MDT file for the firmware */
> -	fw = adreno_request_fw(to_adreno_gpu(gpu), fwname);
> +	/*
> +	 * Check for a firmware-name property.  This is the new scheme
> +	 * to handle firmware that may be signed with device specific
> +	 * keys, allowing us to have a different zap fw path for different
> +	 * devices.
> +	 *
> +	 * If the firmware-name property is found, we bypass the
> +	 * adreno_request_fw() mechanism, because we don't need to handle
> +	 * the /lib/firmware/qcom/* vs /lib/firmware/* case.
> +	 *
> +	 * If the firmware-name property is not found, for backwards
> +	 * compatibility we fall back to the fwname from the gpulist
> +	 * table.
> +	 */
> +	of_property_read_string_index(np, "firmware-name", 0, &signed_fwname);
> +	if (signed_fwname) {
> +		fwname = signed_fwname;
> +		ret = request_firmware_direct(&fw, fwname, gpu->dev->dev);
> +		if (ret)
> +			fw = ERR_PTR(ret);
> +	} else {
> +		/* Request the MDT file from the default location: */
> +		fw = adreno_request_fw(to_adreno_gpu(gpu), fwname);
> +	}
> +
>  	if (IS_ERR(fw)) {
>  		DRM_DEV_ERROR(dev, "Unable to load %s\n", fwname);
>  		return PTR_ERR(fw);
> @@ -95,7 +119,7 @@ static int zap_shader_load_mdt(struct msm_gpu *gpu, const char *fwname,
>  	 * not.  But since we've already gotten through adreno_request_fw()
>  	 * we know which of the two cases it is:
>  	 */
> -	if (to_adreno_gpu(gpu)->fwloc == FW_LOCATION_LEGACY) {
> +	if (signed_fwname || (to_adreno_gpu(gpu)->fwloc == FW_LOCATION_LEGACY)) {
>  		ret = qcom_mdt_load(dev, fw, fwname, pasid,
>  				mem_region, mem_phys, mem_size, NULL);
>  	} else {
> -- 
> 2.24.1
> 
