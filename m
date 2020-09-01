Return-Path: <SRS0=b2Mh=CK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55447C433E6
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 02:35:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 31E1420578
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 02:35:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="X7VDKvWu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726764AbgIACfZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 31 Aug 2020 22:35:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726173AbgIACfX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Aug 2020 22:35:23 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 212D2C06136D
        for <linux-kernel@vger.kernel.org>; Mon, 31 Aug 2020 19:35:22 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id p4so8237991qkf.0
        for <linux-kernel@vger.kernel.org>; Mon, 31 Aug 2020 19:35:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=sAkSksCshNCD0adm0PWVHtppOopUbUnVb4Kv/b5sxpQ=;
        b=X7VDKvWuVcCm6d71WbRGDBPl2PRAA3caYAsvX9a0iQnhlqUGnVr+3lTD9uiPKrGseV
         wvPYn+EjmvIw6hkJcskfTKPfWbrPa7yIAcqVY2uT5fcssTxk0ZIs53cKvafxjTE5fNpQ
         jK16OSHp6Y65G+bHCw/vFEXPKBFsH6Lb1UgMPJaaDUpwVy5tgHc+2vAabhmoMBNYb5NJ
         b5jDpAsGaWNATCkGPINy9jYFeTjF/zBU9R25CFrPGzRlE+Y75c1hBeJcPbcYDWBu8zvo
         vt0AzczXlEUBbhTgQp6yM7xku5oqHjQl9CDobdE8t5xv2S3t5FLTki5btvB1VzQiRAiy
         RkRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=sAkSksCshNCD0adm0PWVHtppOopUbUnVb4Kv/b5sxpQ=;
        b=r2W5RBGdnOQlilmqJJyWnQEyzf9s+nN6/xmzuIFd+IL4yEcnvZqR07U39D0HIETfeO
         pa1x3coKcAwgr/wTmO1kWK8YfqxtKfYDb4neAhZN+WLpLb35xfVc99wNB8o2ZqWr3kUl
         Sl3MuXTMkgdDAqT5+xabudOdnzO7wYkki890ybR/hrV411P0bZpIkFLkMYFpg3EHOCXF
         QcfBf0LdlRNd/YW5ctqLURw/a3F0nBs+rynkdngYjEtIm/08I7kZRgga1AEMUlara1pQ
         UuMAEJPOB/PwM1SjIAWpY5q2ScyDutV79CFV3+ap/ny4yrzgq7kq6cE9mURmdoJK3Dvh
         7zkg==
X-Gm-Message-State: AOAM5332icmr87Wnsn4OIet1bX6x6F2H3NCLLhsZ7Sk6ghpNxRGPOfJE
        LfR/iJOm86zbpHzws3G+nvjKVA==
X-Google-Smtp-Source: ABdhPJx7BeaFp2dnidck1oOhhHfYj6kzJNHKwcvWvxlyJU5srYROFYeR2ubg0/k9FzuVLaIx3C+6Xg==
X-Received: by 2002:a05:620a:567:: with SMTP id p7mr4710228qkp.164.1598927720041;
        Mon, 31 Aug 2020 19:35:20 -0700 (PDT)
Received: from uller (ec2-34-197-84-77.compute-1.amazonaws.com. [34.197.84.77])
        by smtp.gmail.com with ESMTPSA id f22sm3589377qtq.64.2020.08.31.19.35.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Aug 2020 19:35:19 -0700 (PDT)
Date:   Tue, 1 Sep 2020 02:35:17 +0000
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Rob Clark <robdclark@gmail.com>
Cc:     dri-devel@lists.freedesktop.org, iommu@lists.linux-foundation.org,
        linux-arm-msm@vger.kernel.org,
        Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>,
        Will Deacon <will@kernel.org>, freedreno@lists.freedesktop.org,
        Sibi Sankar <sibis@codeaurora.org>,
        Vivek Gautam <vivek.gautam@codeaurora.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        linux-arm-kernel@lists.infradead.org,
        Rob Clark <robdclark@chromium.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 01/19] drm/msm: remove dangling submitqueue references
Message-ID: <20200901023517.GA54956@uller>
References: <20200810222657.1841322-1-jcrouse@codeaurora.org>
 <20200814024114.1177553-2-robdclark@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200814024114.1177553-2-robdclark@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 14 Aug 02:40 UTC 2020, Rob Clark wrote:

> From: Rob Clark <robdclark@chromium.org>
> 
> Currently it doesn't matter, since we free the ctx immediately.  But
> when we start refcnt'ing the ctx, we don't want old dangling list
> entries to hang around.
> 
> Signed-off-by: Rob Clark <robdclark@chromium.org>
> ---
>  drivers/gpu/drm/msm/msm_submitqueue.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/msm/msm_submitqueue.c b/drivers/gpu/drm/msm/msm_submitqueue.c
> index a1d94be7883a..90c9d84e6155 100644
> --- a/drivers/gpu/drm/msm/msm_submitqueue.c
> +++ b/drivers/gpu/drm/msm/msm_submitqueue.c
> @@ -49,8 +49,10 @@ void msm_submitqueue_close(struct msm_file_private *ctx)
>  	 * No lock needed in close and there won't
>  	 * be any more user ioctls coming our way
>  	 */
> -	list_for_each_entry_safe(entry, tmp, &ctx->submitqueues, node)
> +	list_for_each_entry_safe(entry, tmp, &ctx->submitqueues, node) {
> +		list_del(&entry->node);

If you refcount ctx, what does that do for the entries in the submit
queue?

"entry" here is kref'ed, but you're popping it off the list regardless
of the put ends up freeing the object or not - which afaict would mean
leaking the object.


On the other hand, with the current implementation an object with higher
refcount with adjacent objects of single refcount would end up with
dangling pointers after the put. So in itself this change seems like a
net gain, but I'm wondering about the plan described in the commit
message.

Regards,
Bjorn

>  		msm_submitqueue_put(entry);
> +	}
>  }
>  
>  int msm_submitqueue_create(struct drm_device *drm, struct msm_file_private *ctx,
> -- 
> 2.26.2
> 
