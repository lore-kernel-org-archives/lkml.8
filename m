Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2D9FC433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 17:27:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A242020657
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 17:27:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="U56gbUPa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389901AbgHQR07 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 13:26:59 -0400
Received: from mail29.static.mailgun.info ([104.130.122.29]:11740 "EHLO
        mail29.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2389856AbgHQR0w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 13:26:52 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1597685211; h=In-Reply-To: Content-Type: MIME-Version:
 References: Message-ID: Subject: Cc: To: From: Date: Sender;
 bh=JmxeOCVIHQVo+Zeifx/78oNUHBmLeZEDsBLUSMTLYlo=; b=U56gbUPa0GWFDKbxHNpMqOZST2HcTKpU7fL4+ohQppKIYxI4et1ez4lPTyAu5P+Q3PDUZ9ke
 A6nK2XTIojoXQELJF/HuHTM7coWcvdOwT+cunqQcRx9DiCB5ZL499jM3s//nTwfHLUSfK7yd
 Xt3WW8n4zWDAER5jUP6sK/aD+bI=
X-Mailgun-Sending-Ip: 104.130.122.29
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n07.prod.us-east-1.postgun.com with SMTP id
 5f3abdd4cbcd42bdeef6dfe9 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 17 Aug 2020 17:26:44
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id AB694C433B1; Mon, 17 Aug 2020 17:26:42 +0000 (UTC)
Received: from jcrouse1-lnx.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: jcrouse)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id A1FCAC433CA;
        Mon, 17 Aug 2020 17:26:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org A1FCAC433CA
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=jcrouse@codeaurora.org
Date:   Mon, 17 Aug 2020 11:26:36 -0600
From:   Jordan Crouse <jcrouse@codeaurora.org>
To:     Bernard Zhao <bernard@vivo.com>
Cc:     Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Sam Ravnborg <sam@ravnborg.org>,
        Wambui Karuga <wambui.karugax@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Emil Velikov <emil.velikov@collabora.com>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        opensource.kernel@vivo.com
Subject: Re: [Freedreno] [PATCH] drm/msm/adreno: remove return value of
 function XX_print
Message-ID: <20200817172636.GC7438@jcrouse1-lnx.qualcomm.com>
Mail-Followup-To: Bernard Zhao <bernard@vivo.com>,
        Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>,
        David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Sam Ravnborg <sam@ravnborg.org>,
        Wambui Karuga <wambui.karugax@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Emil Velikov <emil.velikov@collabora.com>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        opensource.kernel@vivo.com
References: <20200814081747.8624-1-bernard@vivo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200814081747.8624-1-bernard@vivo.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 14, 2020 at 01:17:44AM -0700, Bernard Zhao wrote:
> XX_print like pfp_print/me_print/meq_print/roq_print are just
> used in file a5xx_debugfs.c. And these function always return
> 0, this return value is meaningless.
> This change is to make the code a bit more readable.

This is reasonable.  I'm always for negative lines.

Reviewed-by: Jordan Crouse <jcrouse@codeaurora.org>

> Signed-off-by: Bernard Zhao <bernard@vivo.com>
> ---
>  drivers/gpu/drm/msm/adreno/a5xx_debugfs.c | 21 +++++++--------------
>  1 file changed, 7 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/gpu/drm/msm/adreno/a5xx_debugfs.c b/drivers/gpu/drm/msm/adreno/a5xx_debugfs.c
> index 68eddac7771c..fc2c905b6c9e 100644
> --- a/drivers/gpu/drm/msm/adreno/a5xx_debugfs.c
> +++ b/drivers/gpu/drm/msm/adreno/a5xx_debugfs.c
> @@ -11,7 +11,7 @@
>  
>  #include "a5xx_gpu.h"
>  
> -static int pfp_print(struct msm_gpu *gpu, struct drm_printer *p)
> +static void pfp_print(struct msm_gpu *gpu, struct drm_printer *p)
>  {
>  	int i;
>  
> @@ -22,11 +22,9 @@ static int pfp_print(struct msm_gpu *gpu, struct drm_printer *p)
>  		drm_printf(p, "  %02x: %08x\n", i,
>  			gpu_read(gpu, REG_A5XX_CP_PFP_STAT_DATA));
>  	}
> -
> -	return 0;
>  }
>  
> -static int me_print(struct msm_gpu *gpu, struct drm_printer *p)
> +static void me_print(struct msm_gpu *gpu, struct drm_printer *p)
>  {
>  	int i;
>  
> @@ -37,11 +35,9 @@ static int me_print(struct msm_gpu *gpu, struct drm_printer *p)
>  		drm_printf(p, "  %02x: %08x\n", i,
>  			gpu_read(gpu, REG_A5XX_CP_ME_STAT_DATA));
>  	}
> -
> -	return 0;
>  }
>  
> -static int meq_print(struct msm_gpu *gpu, struct drm_printer *p)
> +static void meq_print(struct msm_gpu *gpu, struct drm_printer *p)
>  {
>  	int i;
>  
> @@ -52,11 +48,9 @@ static int meq_print(struct msm_gpu *gpu, struct drm_printer *p)
>  		drm_printf(p, "  %02x: %08x\n", i,
>  			gpu_read(gpu, REG_A5XX_CP_MEQ_DBG_DATA));
>  	}
> -
> -	return 0;
>  }
>  
> -static int roq_print(struct msm_gpu *gpu, struct drm_printer *p)
> +static void roq_print(struct msm_gpu *gpu, struct drm_printer *p)
>  {
>  	int i;
>  
> @@ -71,8 +65,6 @@ static int roq_print(struct msm_gpu *gpu, struct drm_printer *p)
>  		drm_printf(p, "  %02x: %08x %08x %08x %08x\n", i,
>  			val[0], val[1], val[2], val[3]);
>  	}
> -
> -	return 0;
>  }
>  
>  static int show(struct seq_file *m, void *arg)
> @@ -81,10 +73,11 @@ static int show(struct seq_file *m, void *arg)
>  	struct drm_device *dev = node->minor->dev;
>  	struct msm_drm_private *priv = dev->dev_private;
>  	struct drm_printer p = drm_seq_file_printer(m);
> -	int (*show)(struct msm_gpu *gpu, struct drm_printer *p) =
> +	void (*show)(struct msm_gpu *gpu, struct drm_printer *p) =
>  		node->info_ent->data;
>  
> -	return show(priv->gpu, &p);
> +	show(priv->gpu, &p);
> +	return 0;
>  }
>  
>  #define ENT(n) { .name = #n, .show = show, .data = n ##_print }
> -- 
> 2.26.2
> 
> _______________________________________________
> Freedreno mailing list
> Freedreno@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/freedreno

-- 
The Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
