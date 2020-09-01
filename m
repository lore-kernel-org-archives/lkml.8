Return-Path: <SRS0=b2Mh=CK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E1E5C433E7
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 05:42:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2AF32208CA
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 05:42:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OAbWCK0Y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726800AbgIAFmt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Sep 2020 01:42:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726301AbgIAFmq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 01:42:46 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75EB2C0612A3
        for <linux-kernel@vger.kernel.org>; Mon, 31 Aug 2020 22:42:45 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id n129so8458767qkd.6
        for <linux-kernel@vger.kernel.org>; Mon, 31 Aug 2020 22:42:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=TjPySNIpD++R3nIfiDfbAnLHmr0c9i/LGC5Y9ogD0v8=;
        b=OAbWCK0Yezbsh/mzcgeE7sC/EeQQhZZ8WSfMp/Fmv/B7Lk2xTWpDZL7ez5bf5UDPWK
         4Tue7VtzfuaCr5qUWiEay3FADaV89uAXqiEQ2f0UU/LKgixPCrQhkFXl83SKtXawRPug
         3VswzBVU7BhUiPiBt4EI5sghR0SBrIxLZku0fNksghFQsFPBBSKTndX/FfB6TpJMrVJJ
         TE/FJhQHMSxivxBOC5CwlJvVL2inpaqTLLxgpXo2oLYU/jPdXYGaBWizv/c5P/4Twm4n
         oUcO4KIExFshItVD3J8hb+p6lpoDxm4JTY8Saz2oGC55/ChiWAPX6WIBTSDYFkqzsCAo
         81SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=TjPySNIpD++R3nIfiDfbAnLHmr0c9i/LGC5Y9ogD0v8=;
        b=tZfb4q10oBoLkQGOOEcCaTb9Fl8laeaRnv9bNvE+9g6zCjXTAd1ctTfYujUMSITJN4
         94t8En2CnXafvthsxWgpvVGAFsPULepXS31/Zo0YfGPhOKyA86C0Z00GtMctfEy8lF03
         CvN0kIFvyuVkylohQ2klVAOvmb/kaeZvlIIXmvYdqATR5FD9y1HB08KeQuDkuiDhMdJ1
         kjLOnYzNy4p5pwYVzQxxr6d4/SVCts01NtQ9/LoCSmN9GQN13QCgZ1JgCeIE/mTImeQ6
         TGFS1Eyay+8PSYbKZQtm+sQf8r1zG3jpPC2lbliLO8/NTH+bMIRucYnmwQPRv9LrUF2D
         qJ/w==
X-Gm-Message-State: AOAM5323sTgIUACsEQMcVPL7CddtfeGbvA/kji3IEJK9GqKmiFb565Cb
        cg6O94hYl3T5dxHuPrI/ccQ48A==
X-Google-Smtp-Source: ABdhPJzptDekz3V1QxRTxrgjsN9RM1EoaAMnK6eUWK4D92iBVLom/mgdEqgNNG4GBVYJ/DvH3YX36g==
X-Received: by 2002:a37:b307:: with SMTP id c7mr270811qkf.33.1598938964675;
        Mon, 31 Aug 2020 22:42:44 -0700 (PDT)
Received: from uller (ec2-34-197-84-77.compute-1.amazonaws.com. [34.197.84.77])
        by smtp.gmail.com with ESMTPSA id s20sm354299qkg.65.2020.08.31.22.42.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Aug 2020 22:42:44 -0700 (PDT)
Date:   Tue, 1 Sep 2020 05:42:42 +0000
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
Message-ID: <20200901054242.GC54956@uller>
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

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

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
>  		msm_submitqueue_put(entry);
> +	}
>  }
>  
>  int msm_submitqueue_create(struct drm_device *drm, struct msm_file_private *ctx,
> -- 
> 2.26.2
> 
