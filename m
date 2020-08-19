Return-Path: <SRS0=EnQK=B5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2C04C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 11:56:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8ABE92072D
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 11:56:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="f5TRPH6X"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728040AbgHSL4A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Aug 2020 07:56:00 -0400
Received: from perceval.ideasonboard.com ([213.167.242.64]:56292 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728002AbgHSLzj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Aug 2020 07:55:39 -0400
Received: from pendragon.ideasonboard.com (62-78-145-57.bb.dnainternet.fi [62.78.145.57])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 4277629E;
        Wed, 19 Aug 2020 13:55:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1597838133;
        bh=KzVb1fFBrc4D3CpXPB/y2PaHs6HIL9FLa7DoMoLBT1U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=f5TRPH6XyEUfU9v55IuMb7bltOPaw4Ibt5/GPJo6QJNs+bqUAhG+I7+3Hu7UYx1CK
         TkntTuAVp7BwXttNIS5Q0GiIn9r60HWD6uDdXzi0bdUUfdbMYlQAYMYinsg6lHgOHO
         35juPps5e2lCkmHrmPjGUjLqjDZYAGVk4nLnzXyA=
Date:   Wed, 19 Aug 2020 14:55:15 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Dinghao Liu <dinghao.liu@zju.edu.cn>
Cc:     kjlu@umn.edu,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Leo Li <sunpeng.li@amd.com>,
        Mahesh Kumar <mahesh1.kumar@intel.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/crc-debugfs: Fix memleak in crc_control_write
Message-ID: <20200819115515.GC6049@pendragon.ideasonboard.com>
References: <20200819082228.26847-1-dinghao.liu@zju.edu.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200819082228.26847-1-dinghao.liu@zju.edu.cn>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dinghao,

Thank you for the patch.

On Wed, Aug 19, 2020 at 04:22:28PM +0800, Dinghao Liu wrote:
> When verify_crc_source() fails, source needs to be freed.
> However, current code is returning directly and ends up
> leaking memory.
> 
> Fixes: c0811a7d5befe ("drm/crc: Cleanup crtc_crc_open function")

I think the issue was introduced in d5cc15a0c66e ("drm: crc: Introduce
verify_crc_source callback"). Apart from that,

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> Signed-off-by: Dinghao Liu <dinghao.liu@zju.edu.cn>
> ---
>  drivers/gpu/drm/drm_debugfs_crc.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/drm_debugfs_crc.c b/drivers/gpu/drm/drm_debugfs_crc.c
> index 5d67a41f7c3a..3dd70d813f69 100644
> --- a/drivers/gpu/drm/drm_debugfs_crc.c
> +++ b/drivers/gpu/drm/drm_debugfs_crc.c
> @@ -144,8 +144,10 @@ static ssize_t crc_control_write(struct file *file, const char __user *ubuf,
>  		source[len - 1] = '\0';
>  
>  	ret = crtc->funcs->verify_crc_source(crtc, source, &values_cnt);
> -	if (ret)
> +	if (ret) {
> +		kfree(source);
>  		return ret;
> +	}
>  
>  	spin_lock_irq(&crc->lock);
>  

-- 
Regards,

Laurent Pinchart
