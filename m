Return-Path: <SRS0=zXkI=7F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F5CCC433E1
	for <linux-kernel@archiver.kernel.org>; Sat, 23 May 2020 07:23:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3ACA720723
	for <linux-kernel@archiver.kernel.org>; Sat, 23 May 2020 07:23:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="b98PVWiN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387716AbgEWHX1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 May 2020 03:23:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387622AbgEWHXZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 May 2020 03:23:25 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3BADC061A0E
        for <linux-kernel@vger.kernel.org>; Sat, 23 May 2020 00:23:24 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id n18so6249890pfa.2
        for <linux-kernel@vger.kernel.org>; Sat, 23 May 2020 00:23:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=rkQjo00JjFI2fAC/o/2WCC1p0oPD9CQpCRaJecUJgjw=;
        b=b98PVWiNaivm9ZiyZan+DVPHGPcXBj6ewOabjJD+9e81ibdAoRXx4l1oTj7FbChlUo
         4vPZhqxfy3UFwAkN8iNMTU7mFc+4fqlw8LHjxRBRdJdZFHnf7zqxGgFEi2T5SBcbb9AM
         iAyhRHC8v2NHCBOlf79Ml00dVLBUmD7oBCb7hrXdBea8jfX+T2jJLOi+5pdD2raTJR+2
         t7u09a29UrI7myl6xPmDuhz3VyNhSXP3TYJRsYgsM28p76SyQLE3Pm4A+K2XJ5kI6/OK
         fPvX3fMuFpy9kYRIupb4Y7HO/CUxtfxZ6+SKnOhjUiAHsuUyiDudOxjjns4AT8Yd9yex
         UHPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=rkQjo00JjFI2fAC/o/2WCC1p0oPD9CQpCRaJecUJgjw=;
        b=N10p8hxyxYV1OztnK/ys2/FFFj0q62Ofp/rRwu6uuUgrmfG1FTyz/Nyxz3eyaB9qjS
         X68cFh49VBrIamW4ym2zEGFrHaQYh/ex0xvG7uzfaMBmcy1SeB6i8rvIr60H5pVuG3nF
         5iuB/IZ7F2MuGFVZdUHOKIdfMeW9KX6rlWQIiLLmIhTB50TpUNn56HYbgawWmIxf2086
         ByHfCUjg++LTSl8Oyg17vemCtd4gOFiU3yCG1yb9OCFcq1EdT3U1SLkoGpXVzE3DKNGV
         /H794BJm/mAQf/2uaSnDPbzKcp/6gGFqP56dkEd7CTxTJNFkHPa1Su8HQc5kqiCbQsQX
         hZyA==
X-Gm-Message-State: AOAM531j4euXZUtliWWFZlDK5xRRnWEa0aNofFitWw+VIwtnQvVg18em
        gS4r5Y9Zup2BxLD280MQUwuBYA==
X-Google-Smtp-Source: ABdhPJwBXAYthcc94MlJNYar0cK8NQ0m6fDRrV1047IEGn1lJ7oVpxn+yl5bbg5BfOkLu2OAiW8nvA==
X-Received: by 2002:a65:51c1:: with SMTP id i1mr17010704pgq.272.1590218604234;
        Sat, 23 May 2020 00:23:24 -0700 (PDT)
Received: from dragon ([80.251.214.228])
        by smtp.gmail.com with ESMTPSA id h4sm9368364pje.29.2020.05.23.00.23.11
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 23 May 2020 00:23:23 -0700 (PDT)
Date:   Sat, 23 May 2020 15:23:02 +0800
From:   Shawn Guo <shawn.guo@linaro.org>
To:     Jordan Crouse <jcrouse@codeaurora.org>
Cc:     linux-arm-msm@vger.kernel.org,
        AngeloGioacchino Del Regno <kholk11@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Drew Davenport <ddavenport@chromium.org>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jeffrey Hugo <jeffrey.l.hugo@gmail.com>,
        Kalyan Thota <kalyan_t@codeaurora.org>,
        Rob Clark <robdclark@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>, Sean Paul <sean@poorly.run>,
        Thomas Gleixner <tglx@linutronix.de>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Wambui Karuga <wambui.karugax@gmail.com>,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, tongtiangen <tongtiangen@huawei.com>
Subject: Re: [PATCH v1 1/3] drm/msm: Attach the IOMMU device during
 initialization
Message-ID: <20200523072300.GB28198@dragon>
References: <20200522220316.23772-1-jcrouse@codeaurora.org>
 <20200522220316.23772-2-jcrouse@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200522220316.23772-2-jcrouse@codeaurora.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 22, 2020 at 04:03:14PM -0600, Jordan Crouse wrote:
> diff --git a/drivers/gpu/drm/msm/msm_gpummu.c b/drivers/gpu/drm/msm/msm_gpummu.c
> index 34980d8eb7ad..0ad0f848560a 100644
> --- a/drivers/gpu/drm/msm/msm_gpummu.c
> +++ b/drivers/gpu/drm/msm/msm_gpummu.c
> @@ -21,11 +21,6 @@ struct msm_gpummu {
>  #define GPUMMU_PAGE_SIZE SZ_4K
>  #define TABLE_SIZE (sizeof(uint32_t) * GPUMMU_VA_RANGE / GPUMMU_PAGE_SIZE)
>  
> -static int msm_gpummu_attach(struct msm_mmu *mmu)
> -{
> -	return 0;
> -}
> -
>  static void msm_gpummu_detach(struct msm_mmu *mmu)
>  {
>  }
> @@ -85,7 +80,6 @@ static void msm_gpummu_destroy(struct msm_mmu *mmu)
>  }
>  
>  static const struct msm_mmu_funcs funcs = {
> -		.attach = msm_gpummu_attach,
>  		.detach = msm_gpummu_detach,
>  		.map = msm_gpummu_map,
>  		.unmap = msm_gpummu_unmap,
> diff --git a/drivers/gpu/drm/msm/msm_iommu.c b/drivers/gpu/drm/msm/msm_iommu.c
> index ad58cfe5998e..e35dab5792cf 100644
> --- a/drivers/gpu/drm/msm/msm_iommu.c
> +++ b/drivers/gpu/drm/msm/msm_iommu.c
> @@ -66,7 +66,6 @@ static void msm_iommu_destroy(struct msm_mmu *mmu)
>  }
>  
>  static const struct msm_mmu_funcs funcs = {
> -		.attach = msm_iommu_attach,

It causes an unused function warning as below.

drivers/gpu/drm/msm/msm_iommu.c:26:12: warning: ‘msm_iommu_attach’ defined but not used [-Wunused-function]
 static int msm_iommu_attach(struct msm_mmu *mmu)
            ^~~~~~~~~~~~~~~~

Not sure if you will use it again in future patches though.

Shawn

>  		.detach = msm_iommu_detach,
>  		.map = msm_iommu_map,
>  		.unmap = msm_iommu_unmap,
> @@ -76,6 +75,7 @@ static const struct msm_mmu_funcs funcs = {
>  struct msm_mmu *msm_iommu_new(struct device *dev, struct iommu_domain *domain)
>  {
>  	struct msm_iommu *iommu;
> +	int ret;
>  
>  	iommu = kzalloc(sizeof(*iommu), GFP_KERNEL);
>  	if (!iommu)
> @@ -85,5 +85,11 @@ struct msm_mmu *msm_iommu_new(struct device *dev, struct iommu_domain *domain)
>  	msm_mmu_init(&iommu->base, dev, &funcs);
>  	iommu_set_fault_handler(domain, msm_fault_handler, iommu);
>  
> +	ret = iommu_attach_device(iommu->domain, dev);
> +	if (ret) {
> +		kfree(iommu);
> +		return ERR_PTR(ret);
> +	}
> +
>  	return &iommu->base;
>  }
> diff --git a/drivers/gpu/drm/msm/msm_mmu.h b/drivers/gpu/drm/msm/msm_mmu.h
> index 67a623f14319..bae9e8e67ec1 100644
> --- a/drivers/gpu/drm/msm/msm_mmu.h
> +++ b/drivers/gpu/drm/msm/msm_mmu.h
> @@ -10,7 +10,6 @@
>  #include <linux/iommu.h>
>  
>  struct msm_mmu_funcs {
> -	int (*attach)(struct msm_mmu *mmu);
>  	void (*detach)(struct msm_mmu *mmu);
>  	int (*map)(struct msm_mmu *mmu, uint64_t iova, struct sg_table *sgt,
>  			unsigned len, int prot);
> -- 
> 2.17.1
> 
