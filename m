Return-Path: <SRS0=0vny=62=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14887C54E8B
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 05:41:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E9B2A20736
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 05:41:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Pwq8HShO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727910AbgELFll (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 May 2020 01:41:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725892AbgELFlk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 May 2020 01:41:40 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DDFFC061A0C
        for <linux-kernel@vger.kernel.org>; Mon, 11 May 2020 22:41:40 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id w65so5822563pfc.12
        for <linux-kernel@vger.kernel.org>; Mon, 11 May 2020 22:41:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=d3pM/Dyxuk8f8jV5C8y4lxDkycZGVCo+a29+hT7GDn8=;
        b=Pwq8HShOoEzwpj3h4Z2GIyav26gGErQQ5WACO+rZuY1f7UHBsSeweImNHvFTmwUu+3
         RtPex/zc6nGXKFOSDhiPYBQvoO8wzf3lrrZ4Q0mekaNJs/8CR6xLPZh+wLHp0Gyd9Pvx
         QRQj8wnuoP0fKCg5vPmAFKsJIziKrif1enlKLHaH1vkudYaKCzVmNlgcree26/ynY7d7
         rWZG0Fp9p2lsh3xcVB5/waAsty2XByE5+mW9SrW9SzIXcj10imYgrlhwXa4tJyFg0hh5
         rR3XtQtcDHcO+jVEbcqSUd0K55s74l1VokXaBhfFgthdrnHEqTRknjqB21L3NUEKk/vY
         hCog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=d3pM/Dyxuk8f8jV5C8y4lxDkycZGVCo+a29+hT7GDn8=;
        b=YWzfzDN59TejB/zuPag2apwtSEe1bEU8wGLNPoc7HON88EnnhF/9Oz2uFgmBJ+gtp9
         PL/u8gNpL3KESMIn3q2KQONHJHVNxYy4YMD9fujkilpuXhFOqCBO8nBcJXUACKkMLINZ
         pcuFUHUrhD/ucQlmwsJVZxJgSnALjNbv0hBL4SJD/ZrW40KRGxZwkODdhD08mFAJsNui
         mHZ38iYOxVyqzshAQ38iyXhOOZbSx0qQwpVhKGUMTBjffNVbz4u15QUiwrIEP4c2amj2
         0Vtg1Z0HkftmJ00z960FvCI09A51meI6xBGAkwIpwifrQDvDUq2T0WZYmEaYf9ZhGLVq
         KIHQ==
X-Gm-Message-State: AGi0Puba+SxLhQCIP/5oGc7Ealf3SWGlJvWy7EnOsEezCOs3Xd8uyYoR
        ZZoAL4xcjq+KWP+aEtXjhe1zRQ==
X-Google-Smtp-Source: APiQypJKtsy5n1xHuqBuAnAZAju4AgPcTdVCfwg0NsY3d395BxTqYBF2Ss/gmJPySFaJazTsGI45gA==
X-Received: by 2002:a62:808d:: with SMTP id j135mr18779432pfd.53.1589262099940;
        Mon, 11 May 2020 22:41:39 -0700 (PDT)
Received: from yoga (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id h11sm10684616pfo.120.2020.05.11.22.41.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2020 22:41:39 -0700 (PDT)
Date:   Mon, 11 May 2020 22:41:37 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Samuel Zou <zou_wei@huawei.com>
Cc:     agross@kernel.org, joro@8bytes.org, linux-arm-msm@vger.kernel.org,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] iommu/msm: Make msm_iommu_lock static
Message-ID: <20200512054137.GI1302550@yoga>
References: <1589249839-105820-1-git-send-email-zou_wei@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1589249839-105820-1-git-send-email-zou_wei@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 11 May 19:17 PDT 2020, Samuel Zou wrote:

> Fix the following sparse warning:
> 
> drivers/iommu/msm_iommu.c:37:1: warning: symbol 'msm_iommu_lock' was not declared.
> 
> The msm_iommu_lock has only call site within msm_iommu.c
> It should be static
> 

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Regards,
Bjorn

> Fixes: 0720d1f052dc ("msm: Add MSM IOMMU support")
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Samuel Zou <zou_wei@huawei.com>
> ---
>  drivers/iommu/msm_iommu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/msm_iommu.c b/drivers/iommu/msm_iommu.c
> index 10cd4db..3d8a635 100644
> --- a/drivers/iommu/msm_iommu.c
> +++ b/drivers/iommu/msm_iommu.c
> @@ -34,7 +34,7 @@ __asm__ __volatile__ (							\
>  /* bitmap of the page sizes currently supported */
>  #define MSM_IOMMU_PGSIZES	(SZ_4K | SZ_64K | SZ_1M | SZ_16M)
>  
> -DEFINE_SPINLOCK(msm_iommu_lock);
> +static DEFINE_SPINLOCK(msm_iommu_lock);
>  static LIST_HEAD(qcom_iommu_devices);
>  static struct iommu_ops msm_iommu_ops;
>  
> -- 
> 2.6.2
> 
