Return-Path: <SRS0=rw9U=6H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAF6BC54FD0
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 15:26:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C2332206EC
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 15:26:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="Z/qlnvbc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729199AbgDWP0I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Apr 2020 11:26:08 -0400
Received: from mail27.static.mailgun.info ([104.130.122.27]:35290 "EHLO
        mail27.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728990AbgDWP0I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Apr 2020 11:26:08 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1587655567; h=In-Reply-To: Content-Type: MIME-Version:
 References: Message-ID: Subject: Cc: To: From: Date: Sender;
 bh=9wQ2DyfHn0zQSPKWH0MRTyykuPGkgNXnO6TKfK9XPEc=; b=Z/qlnvbcwiBfdDvEwGlUw0O0huETxxo8SIBay5J8Dvm/5Tf5sGio1ne8RvEO+vvws0UvI0Sx
 CaFbIWqEEL8b0m6TW9m8GfLJ3PXgZPpbSFaQGV4lbv3rqq6636knzWh3zzuYvDhZn2+5dATA
 Ai5BdmWV9I7/i9iu7vS1QqUiHmE=
X-Mailgun-Sending-Ip: 104.130.122.27
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5ea1b388.7f79f553e810-smtp-out-n01;
 Thu, 23 Apr 2020 15:26:00 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 5C528C432C2; Thu, 23 Apr 2020 15:25:59 +0000 (UTC)
Received: from jcrouse1-lnx.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: jcrouse)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 04D96C433F2;
        Thu, 23 Apr 2020 15:25:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 04D96C433F2
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=jcrouse@codeaurora.org
Date:   Thu, 23 Apr 2020 09:25:55 -0600
From:   Jordan Crouse <jcrouse@codeaurora.org>
To:     Jonathan Marek <jonathan@marek.ca>
Cc:     freedreno@lists.freedesktop.org, David Airlie <airlied@linux.ie>,
        "open list:DRM DRIVER FOR MSM ADRENO GPU" 
        <linux-arm-msm@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:DRM DRIVER FOR MSM ADRENO GPU" 
        <dri-devel@lists.freedesktop.org>, Rob Clark <robdclark@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>, Sean Paul <sean@poorly.run>
Subject: Re: [Freedreno] [PATCH v2 2/9] drm/msm: add internal MSM_BO_MAP_PRIV
 flag
Message-ID: <20200423152555.GA32401@jcrouse1-lnx.qualcomm.com>
Mail-Followup-To: Jonathan Marek <jonathan@marek.ca>,
        freedreno@lists.freedesktop.org, David Airlie <airlied@linux.ie>,
        "open list:DRM DRIVER FOR MSM ADRENO GPU" <linux-arm-msm@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:DRM DRIVER FOR MSM ADRENO GPU" <dri-devel@lists.freedesktop.org>,
        Rob Clark <robdclark@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
        Sean Paul <sean@poorly.run>
References: <20200421234127.27965-1-jonathan@marek.ca>
 <20200421234127.27965-3-jonathan@marek.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200421234127.27965-3-jonathan@marek.ca>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 21, 2020 at 07:41:20PM -0400, Jonathan Marek wrote:
> This flag sets IOMMU_PRIV, which is required for some a6xx GMU objects.

The GMU doesn't _need_  privileged surfaces, but it sure is a good idea.
As a bonus with the APRIV bit on some a6xx targets we can set all of the
global buffers as privileged so people can't go out and overwrite the memstore
any more.

Reviewed-by: Jordan Crouse <jcrouse@codeauorora.org>

> Signed-off-by: Jonathan Marek <jonathan@marek.ca>
> ---
>  drivers/gpu/drm/msm/msm_gem.c | 3 +++
>  drivers/gpu/drm/msm/msm_gem.h | 1 +
>  2 files changed, 4 insertions(+)
> 
> diff --git a/drivers/gpu/drm/msm/msm_gem.c b/drivers/gpu/drm/msm/msm_gem.c
> index d8f56a34c117..6277fde13df9 100644
> --- a/drivers/gpu/drm/msm/msm_gem.c
> +++ b/drivers/gpu/drm/msm/msm_gem.c
> @@ -428,6 +428,9 @@ static int msm_gem_pin_iova(struct drm_gem_object *obj,
>  	if (!(msm_obj->flags & MSM_BO_GPU_READONLY))
>  		prot |= IOMMU_WRITE;
>  
> +	if (msm_obj->flags & MSM_BO_MAP_PRIV)
> +		prot |= IOMMU_PRIV;
> +
>  	WARN_ON(!mutex_is_locked(&msm_obj->lock));
>  
>  	if (WARN_ON(msm_obj->madv != MSM_MADV_WILLNEED))
> diff --git a/drivers/gpu/drm/msm/msm_gem.h b/drivers/gpu/drm/msm/msm_gem.h
> index 30584eaf8cc8..972490b14ba5 100644
> --- a/drivers/gpu/drm/msm/msm_gem.h
> +++ b/drivers/gpu/drm/msm/msm_gem.h
> @@ -13,6 +13,7 @@
>  
>  /* Additional internal-use only BO flags: */
>  #define MSM_BO_STOLEN        0x10000000    /* try to use stolen/splash memory */
> +#define MSM_BO_MAP_PRIV      0x20000000    /* use IOMMU_PRIV when mapping */
>  
>  struct msm_gem_address_space {
>  	const char *name;
> -- 
> 2.26.1
> 
> _______________________________________________
> Freedreno mailing list
> Freedreno@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/freedreno

-- 
The Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
