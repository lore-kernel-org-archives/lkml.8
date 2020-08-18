Return-Path: <SRS0=faA3=B4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46A62C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 10:51:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2E4DE2078B
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 10:51:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726809AbgHRKvh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Aug 2020 06:51:37 -0400
Received: from asavdk3.altibox.net ([109.247.116.14]:58646 "EHLO
        asavdk3.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726203AbgHRKve (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Aug 2020 06:51:34 -0400
Received: from ravnborg.org (unknown [188.228.123.71])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by asavdk3.altibox.net (Postfix) with ESMTPS id E132420024;
        Tue, 18 Aug 2020 12:51:29 +0200 (CEST)
Date:   Tue, 18 Aug 2020 12:51:27 +0200
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Tian Tao <tiantao6@hisilicon.com>
Cc:     airlied@linux.ie, daniel@ffwll.ch, tzimmermann@suse.de,
        kraxel@redhat.com, alexander.deucher@amd.com, tglx@linutronix.de,
        dri-devel@lists.freedesktop.org, xinliang.liu@linaro.org,
        linux-kernel@vger.kernel.org, linuxarm@huawei.com
Subject: Re: [PATCH drm/hisilicon 0/4] Use drv_err instead of DRM_ERROR in
 hibmc driver
Message-ID: <20200818105127.GA2017472@ravnborg.org>
References: <1597733504-30812-1-git-send-email-tiantao6@hisilicon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1597733504-30812-1-git-send-email-tiantao6@hisilicon.com>
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=f+hm+t6M c=1 sm=1 tr=0
        a=S6zTFyMACwkrwXSdXUNehg==:117 a=S6zTFyMACwkrwXSdXUNehg==:17
        a=kj9zAlcOel0A:10 a=e5mUnYsNAAAA:8 a=p9VVrILX5DuZkMnRgawA:9
        a=CjuIK1q_8ugA:10 a=Vxmtnl_E_bksehYqCbjh:22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 18, 2020 at 02:51:40PM +0800, Tian Tao wrote:
> patch #1 is using the drv_err instead of DRM_ERROR in hibmc_ttm.c
> patch #2 is using the drv_err instead of DRM_ERROR in hibmc_drm_vdac.c
> patch #3 is using the drv_err and drm_dbg_atomic  instead of DRM_ERROR
> and DRM_DEBUG_ATOMIC  in hibmc_drm_de.c
> patch #4 is using the drv_err and drm_warn instead of DRM_ERROR and
> DRM_WARN in hibmc_drm_drv.c
> 
> Tian Tao (4):
>   drm/hisilicon: Use drv_err instead of DRM_ERROR in hibmc_ttm
>   drm/hisilicon: Use drv_err instead of DRM_ERROR in hibmc_drm_vdac
>   drm/hisilicon: Use drv_err instead of DRM_ERROR in hibmc_drm_de
>   drm/hisilicon: Use drv_err instead of DRM_ERROR in hibmc_drm_drv

Hi Tian.

Code looks fine, but subjects says "drv_err", where code uses "drm_err".
This confused me, mind fixing the $subject before applying

	Sam

> 
>  drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_de.c   | 14 +++++++-------
>  drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c  | 24 ++++++++++++------------
>  drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_vdac.c |  4 ++--
>  drivers/gpu/drm/hisilicon/hibmc/hibmc_ttm.c      |  2 +-
>  4 files changed, 22 insertions(+), 22 deletions(-)
> 
> -- 
> 2.7.4
> 
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
