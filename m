Return-Path: <SRS0=jZ1s=BH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BFDEC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 22:37:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 117422070A
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 22:37:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="dg0KJ5bH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729875AbgG1Whu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jul 2020 18:37:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729223AbgG1Whu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jul 2020 18:37:50 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD172C061794;
        Tue, 28 Jul 2020 15:37:49 -0700 (PDT)
Received: from pendragon.ideasonboard.com (81-175-216-236.bb.dnainternet.fi [81.175.216.236])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 1B12A563;
        Wed, 29 Jul 2020 00:37:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1595975868;
        bh=87O/ZO51dVt0In3u/HQSQIRpyT0KiserorvlrdcFFps=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dg0KJ5bHUVbTFQ5Zs8EhtcLfr5rW0piy9rJ6XQKjki0ugcYH6HtXeewMl55T8V7xm
         yQd8CX18Lk+37Ammu1YtOy8nZN6WOZnOGRZA3Bx3cKMnaha+UOo4yU0N7h3QF9L/5H
         lC8/RB0vvaZOr/Cnb+M5naHmcBSm6v3yoHR2T+iY=
Date:   Wed, 29 Jul 2020 01:37:39 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Colin King <colin.king@canonical.com>
Cc:     Hyun Kwon <hyun.kwon@xilinx.com>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Michal Simek <michal.simek@xilinx.com>,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] drm: xln: fix spelling mistake "failes" -> "failed"
Message-ID: <20200728223739.GV13753@pendragon.ideasonboard.com>
References: <20200724111258.14762-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200724111258.14762-1-colin.king@canonical.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Colin,

Thank you for the patch.

On Fri, Jul 24, 2020 at 12:12:58PM +0100, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> There is a spelling mistake in a dev_dbg messages. Fix it.

There is a spelling mistake in the commit message, s/xln/xlnx/ ;-)

> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> ---
>  drivers/gpu/drm/xlnx/zynqmp_dp.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/xlnx/zynqmp_dp.c b/drivers/gpu/drm/xlnx/zynqmp_dp.c
> index 821f7a71e182..0e1c818746eb 100644
> --- a/drivers/gpu/drm/xlnx/zynqmp_dp.c
> +++ b/drivers/gpu/drm/xlnx/zynqmp_dp.c
> @@ -1308,7 +1308,7 @@ zynqmp_dp_connector_detect(struct drm_connector *connector, bool force)
>  		ret = drm_dp_dpcd_read(&dp->aux, 0x0, dp->dpcd,
>  				       sizeof(dp->dpcd));
>  		if (ret < 0) {
> -			dev_dbg(dp->dev, "DPCD read failes");
> +			dev_dbg(dp->dev, "DPCD read failed");
>  			goto disconnected;
>  		}
>  

-- 
Regards,

Laurent Pinchart
