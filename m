Return-Path: <SRS0=j27y=4W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B990C3F2D2
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 18:42:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D1E5207FD
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 18:42:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726259AbgCESm6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Mar 2020 13:42:58 -0500
Received: from foss.arm.com ([217.140.110.172]:52442 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725946AbgCESm6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Mar 2020 13:42:58 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 30B7830E;
        Thu,  5 Mar 2020 10:42:57 -0800 (PST)
Received: from e110455-lin.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 10DE03F6CF;
        Thu,  5 Mar 2020 10:42:57 -0800 (PST)
Received: by e110455-lin.cambridge.arm.com (Postfix, from userid 1000)
        id C241F682F35; Thu,  5 Mar 2020 18:42:55 +0000 (GMT)
Date:   Thu, 5 Mar 2020 18:42:55 +0000
From:   Liviu Dudau <liviu.dudau@arm.com>
To:     Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        "James (Qian) Wang" <james.qian.wang@arm.com>,
        Mihail Atanassov <mihail.atanassov@arm.com>,
        Brian Starkey <brian.starkey@arm.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Subject: Re: [PATCH] drm: komeda: Make rt_pm_ops dependent on CONFIG_PM
Message-ID: <20200305184255.GH364558@e110455-lin.cambridge.arm.com>
References: <20200304145412.33936-1-vincenzo.frascino@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200304145412.33936-1-vincenzo.frascino@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 04, 2020 at 02:54:12PM +0000, Vincenzo Frascino wrote:
> komeda_rt_pm_suspend() and komeda_rt_pm_resume() are compiled only when
> CONFIG_PM is enabled. Having it disabled triggers the following warning
> at compile time:
> 
> linux/drivers/gpu/drm/arm/display/komeda/komeda_drv.c:156:12:
> warning: ‘komeda_rt_pm_resume’ defined but not used [-Wunused-function]
>  static int komeda_rt_pm_resume(struct device *dev)
>             ^~~~~~~~~~~~~~~~~~~
> linux/drivers/gpu/drm/arm/display/komeda/komeda_drv.c:149:12:
> warning: ‘komeda_rt_pm_suspend’ defined but not used [-Wunused-function]
>  static int komeda_rt_pm_suspend(struct device *dev)
> 
> Make komeda_rt_pm_suspend() and komeda_rt_pm_resume() dependent on
> CONFIG_PM to address the issue.
> 
> Cc: "James (Qian) Wang" <james.qian.wang@arm.com>
> Cc: Liviu Dudau <liviu.dudau@arm.com>
> Cc: Mihail Atanassov <mihail.atanassov@arm.com>
> Cc: Brian Starkey <brian.starkey@arm.com>
> Cc: David Airlie <airlied@linux.ie>
> Cc: Daniel Vetter <daniel@ffwll.ch>
> Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>

Acked-by: Liviu Dudau <liviu.dudau@arm.com>

Thanks for the patch, I will push it into drm-misc-fixes tomorrow.

Best regards,
Liviu

> ---
>  drivers/gpu/drm/arm/display/komeda/komeda_drv.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_drv.c b/drivers/gpu/drm/arm/display/komeda/komeda_drv.c
> index ea5cd1e17304..dd3ae3d88687 100644
> --- a/drivers/gpu/drm/arm/display/komeda/komeda_drv.c
> +++ b/drivers/gpu/drm/arm/display/komeda/komeda_drv.c
> @@ -146,6 +146,7 @@ static const struct of_device_id komeda_of_match[] = {
>  
>  MODULE_DEVICE_TABLE(of, komeda_of_match);
>  
> +#ifdef CONFIG_PM
>  static int komeda_rt_pm_suspend(struct device *dev)
>  {
>  	struct komeda_drv *mdrv = dev_get_drvdata(dev);
> @@ -159,6 +160,7 @@ static int komeda_rt_pm_resume(struct device *dev)
>  
>  	return komeda_dev_resume(mdrv->mdev);
>  }
> +#endif /* CONFIG_PM */
>  
>  static int __maybe_unused komeda_pm_suspend(struct device *dev)
>  {
> -- 
> 2.25.1
> 

-- 
====================
| I would like to |
| fix the world,  |
| but they're not |
| giving me the   |
 \ source code!  /
  ---------------
    ¯\_(ツ)_/¯
