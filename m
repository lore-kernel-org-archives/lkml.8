Return-Path: <SRS0=5pK+=BB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2047C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 11:41:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B820620792
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 11:41:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730142AbgGVLlD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jul 2020 07:41:03 -0400
Received: from mga09.intel.com ([134.134.136.24]:26583 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726146AbgGVLlD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jul 2020 07:41:03 -0400
IronPort-SDR: W3uosYy0zq5VsE5Tup2fXoMN8ZU/sqPNuvYD2OZaPlcvyzOVtR/Sl9Q3EPZUNbclDkdryUBZ/1
 udaoL0rzEXBA==
X-IronPort-AV: E=McAfee;i="6000,8403,9689"; a="151636767"
X-IronPort-AV: E=Sophos;i="5.75,381,1589266800"; 
   d="scan'208";a="151636767"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2020 04:41:02 -0700
IronPort-SDR: CPRDPXyTLrGTxqjHXK+hY6q+J6I6HCj+cKvlgtwwTIOVjegRPEfmanoT9nQFTbYBYprvy/jDpt
 bTDCPu0pAJGA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,381,1589266800"; 
   d="scan'208";a="328188473"
Received: from stinkbox.fi.intel.com (HELO stinkbox) ([10.237.72.174])
  by orsmga007.jf.intel.com with SMTP; 22 Jul 2020 04:40:57 -0700
Received: by stinkbox (sSMTP sendmail emulation); Wed, 22 Jul 2020 14:40:56 +0300
Date:   Wed, 22 Jul 2020 14:40:56 +0300
From:   Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
To:     Xu Qiang <xuqiang36@huawei.com>
Cc:     maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        tzimmermann@suse.de, airlied@linux.ie, daniel@ffwll.ch,
        rui.xiang@huawei.com, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Subject: Re: [PATCH -next] gpu: drm: Fix spinlock vblank_time_lock use error.
Message-ID: <20200722114056.GB6112@intel.com>
References: <20200722010527.52293-1-xuqiang36@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200722010527.52293-1-xuqiang36@huawei.com>
X-Patchwork-Hint: comment
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 22, 2020 at 01:05:27AM +0000, Xu Qiang wrote:
> The drm_handle_vblank function is in the interrupt context.
> Therefore, the spin lock vblank_time_lock is obtained
> from the interrupt context.
> 
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Xu Qiang <xuqiang36@huawei.com>
> ---
>  drivers/gpu/drm/drm_vblank.c | 17 ++++++++++-------
>  1 file changed, 10 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/gpu/drm/drm_vblank.c b/drivers/gpu/drm/drm_vblank.c
> index f402c75b9d34..4ca63ff33a43 100644
> --- a/drivers/gpu/drm/drm_vblank.c
> +++ b/drivers/gpu/drm/drm_vblank.c
> @@ -229,10 +229,11 @@ static void drm_reset_vblank_timestamp(struct drm_device *dev, unsigned int pipe
>  {
>  	u32 cur_vblank;
>  	bool rc;
> +	unsigned long irqflags;
>  	ktime_t t_vblank;
>  	int count = DRM_TIMESTAMP_MAXRETRIES;
>  
> -	spin_lock(&dev->vblank_time_lock);
> +	spin_lock_irqsave(&dev->vblank_time_lock, irqflags);

Nak. This is always called with interrupts off, so no point on wasting
time saving/restoring the flags. And it's the same situation for all the
other cases you have below.

>  
>  	/*
>  	 * sample the current counter to avoid random jumps
> @@ -257,7 +258,7 @@ static void drm_reset_vblank_timestamp(struct drm_device *dev, unsigned int pipe
>  	 */
>  	store_vblank(dev, pipe, 1, t_vblank, cur_vblank);
>  
> -	spin_unlock(&dev->vblank_time_lock);
> +	spin_unlock_irqrestore(&dev->vblank_time_lock, irqflags);
>  }
>  
>  /*
> @@ -1106,11 +1107,12 @@ static int __enable_vblank(struct drm_device *dev, unsigned int pipe)
>  static int drm_vblank_enable(struct drm_device *dev, unsigned int pipe)
>  {
>  	struct drm_vblank_crtc *vblank = &dev->vblank[pipe];
> +	unsigned long irqflags;
>  	int ret = 0;
>  
>  	assert_spin_locked(&dev->vbl_lock);
>  
> -	spin_lock(&dev->vblank_time_lock);
> +	spin_lock_irqsave(&dev->vblank_time_lock, irqflags);
>  
>  	if (!vblank->enabled) {
>  		/*
> @@ -1136,7 +1138,7 @@ static int drm_vblank_enable(struct drm_device *dev, unsigned int pipe)
>  		}
>  	}
>  
> -	spin_unlock(&dev->vblank_time_lock);
> +	spin_unlock_irqrestore(&dev->vblank_time_lock, irqflags);
>  
>  	return ret;
>  }
> @@ -1917,6 +1919,7 @@ bool drm_handle_vblank(struct drm_device *dev, unsigned int pipe)
>  {
>  	struct drm_vblank_crtc *vblank = &dev->vblank[pipe];
>  	unsigned long irqflags;
> +	unsigned long irqflags_vblank;
>  	bool disable_irq;
>  
>  	if (drm_WARN_ON_ONCE(dev, !drm_dev_has_vblank(dev)))
> @@ -1931,18 +1934,18 @@ bool drm_handle_vblank(struct drm_device *dev, unsigned int pipe)
>  	 * vblank enable/disable, as this would cause inconsistent
>  	 * or corrupted timestamps and vblank counts.
>  	 */
> -	spin_lock(&dev->vblank_time_lock);
> +	spin_lock_irqsave(&dev->vblank_time_lock, irqflags_vblank);
>  
>  	/* Vblank irq handling disabled. Nothing to do. */
>  	if (!vblank->enabled) {
> -		spin_unlock(&dev->vblank_time_lock);
> +		spin_unlock_irqrestore(&dev->vblank_time_lock, irqflags_vblank);
>  		spin_unlock_irqrestore(&dev->event_lock, irqflags);
>  		return false;
>  	}
>  
>  	drm_update_vblank_count(dev, pipe, true);
>  
> -	spin_unlock(&dev->vblank_time_lock);
> +	spin_unlock_irqrestore(&dev->vblank_time_lock, irqflags_vblank);
>  
>  	wake_up(&vblank->queue);
>  
> -- 
> 2.25.0
> 
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel

-- 
Ville Syrjälä
Intel
