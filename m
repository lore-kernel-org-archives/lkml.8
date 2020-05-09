Return-Path: <SRS0=dqcu=6X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39518C54E4A
	for <linux-kernel@archiver.kernel.org>; Sat,  9 May 2020 21:07:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1A3C420A8B
	for <linux-kernel@archiver.kernel.org>; Sat,  9 May 2020 21:07:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728385AbgEIVHL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 May 2020 17:07:11 -0400
Received: from asavdk3.altibox.net ([109.247.116.14]:45222 "EHLO
        asavdk3.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728187AbgEIVHK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 May 2020 17:07:10 -0400
Received: from ravnborg.org (unknown [158.248.194.18])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by asavdk3.altibox.net (Postfix) with ESMTPS id 61EBE2003E;
        Sat,  9 May 2020 23:07:07 +0200 (CEST)
Date:   Sat, 9 May 2020 23:07:00 +0200
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Samuel Zou <zou_wei@huawei.com>,
        Russell King <linux@armlinux.org.uk>
Cc:     linux@armlinux.org.uk, airlied@linux.ie, daniel@ffwll.ch,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH -next] drm/i2c/tda998x: Make tda998x_audio_digital_mute
 static
Message-ID: <20200509210700.GA12666@ravnborg.org>
References: <1588819768-11818-1-git-send-email-zou_wei@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1588819768-11818-1-git-send-email-zou_wei@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=ULXz4hXy c=1 sm=1 tr=0
        a=UWs3HLbX/2nnQ3s7vZ42gw==:117 a=UWs3HLbX/2nnQ3s7vZ42gw==:17
        a=kj9zAlcOel0A:10 a=i0EeH86SAAAA:8 a=e5mUnYsNAAAA:8
        a=Vsz2rQJ-eejM4GXTEzYA:9 a=CjuIK1q_8ugA:10 a=Vxmtnl_E_bksehYqCbjh:22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 07, 2020 at 10:49:28AM +0800, Samuel Zou wrote:
> Fix the following sparse warning:
> 
> drivers/gpu/drm/i2c/tda998x_drv.c:1136:5: warning:
> symbol 'tda998x_audio_digital_mute' was not declared. Should it be static?
> 
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Samuel Zou <zou_wei@huawei.com>

Thanks.

Pushed to drm-misc-next, so it will appear in next merge window.

	Sam

> ---
>  drivers/gpu/drm/i2c/tda998x_drv.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/i2c/tda998x_drv.c b/drivers/gpu/drm/i2c/tda998x_drv.c
> index 3c90d7a..9517f52 100644
> --- a/drivers/gpu/drm/i2c/tda998x_drv.c
> +++ b/drivers/gpu/drm/i2c/tda998x_drv.c
> @@ -1133,7 +1133,8 @@ static void tda998x_audio_shutdown(struct device *dev, void *data)
>  	mutex_unlock(&priv->audio_mutex);
>  }
>  
> -int tda998x_audio_digital_mute(struct device *dev, void *data, bool enable)
> +static int tda998x_audio_digital_mute(struct device *dev, void *data,
> +				      bool enable)
>  {
>  	struct tda998x_priv *priv = dev_get_drvdata(dev);
>  
> -- 
> 2.6.2
> 
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
