Return-Path: <SRS0=jZ1s=BH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6CFAC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 21:20:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AC0EA20714
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 21:20:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729405AbgG1VU2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jul 2020 17:20:28 -0400
Received: from asavdk3.altibox.net ([109.247.116.14]:38510 "EHLO
        asavdk3.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728149AbgG1VU1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jul 2020 17:20:27 -0400
Received: from ravnborg.org (unknown [188.228.123.71])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by asavdk3.altibox.net (Postfix) with ESMTPS id AB69A20039;
        Tue, 28 Jul 2020 23:20:23 +0200 (CEST)
Date:   Tue, 28 Jul 2020 23:20:22 +0200
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Kevin Tang <kevin3.tang@gmail.com>
Cc:     maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        sean@poorly.run, airlied@linux.ie, daniel@ffwll.ch,
        robh+dt@kernel.org, mark.rutland@arm.com, orsonzhai@gmail.com,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        zhang.lyra@gmail.com
Subject: Re: [PATCH RFC v6 0/6] Add Unisoc's drm kms module
Message-ID: <20200728212022.GF1277651@ravnborg.org>
References: <1595930879-2478-1-git-send-email-kevin3.tang@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1595930879-2478-1-git-send-email-kevin3.tang@gmail.com>
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=f+hm+t6M c=1 sm=1 tr=0
        a=S6zTFyMACwkrwXSdXUNehg==:117 a=S6zTFyMACwkrwXSdXUNehg==:17
        a=kj9zAlcOel0A:10 a=icsG72s9AAAA:8 a=e5mUnYsNAAAA:8
        a=uycXCgnwi_-2LEUYQMgA:9 a=CjuIK1q_8ugA:10 a=T89tl0cgrjxRNoSN2Dv0:22
        a=Vxmtnl_E_bksehYqCbjh:22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kevin.

Thanks for submitting this set of drivers.

To better review the pataches can you please give some kind of high
level overview.

An ascii block diagram that identifies all the relevant blocks and how
they relate would be great.

This makes it easier to verify if the right modelling is used.

	Sam

On Tue, Jul 28, 2020 at 06:07:53PM +0800, Kevin Tang wrote:
> From: Kevin Tang <kevin.tang@unisoc.com>
> 
> ChangeList:
> v1:
> 1. only upstream modeset and atomic at first commit. 
> 2. remove some unused code;
> 3. use alpha and blend_mode properties;
> 3. add yaml support;
> 4. remove auto-adaptive panel driver;
> 5. bugfix
> 
> v2:
> 1. add sprd crtc and plane module for KMS, preparing for multi crtc&encoder
> 2. remove gem drivers, use generic CMA handlers
> 3. remove redundant "module_init", all the sub modules loading by KMS
> 
> v3:
> 1. multi crtc&encoder design have problem, so rollback to v1
> 
> v4:
> 1. update to gcc-linaro-7.5.0
> 2. update to Linux 5.6-rc3
> 3. remove pm_runtime support
> 4. add COMPILE_TEST, remove unused kconfig
> 5. "drm_dev_put" on drm_unbind
> 6. fix some naming convention issue
> 7. remove semaphore lock for crtc flip
> 8. remove static variables
> 
> v5:
> 1. optimize encoder and connector code implementation
> 2. use "platform_get_irq" and "platform_get_resource"
> 3. drop useless function return type, drop unless debug log
> 4. custom properties should be separate, so drop it
> 5. use DRM_XXX replase pr_xxx
> 6. drop dsi&dphy hal callback ops
> 7. drop unless callback ops checking
> 8. add comments for sprd dpu structure
> 
> v6:
> 1. Access registers via readl/writel
> 2. Checking for unsupported KMS properties (format, rotation, blend_mode, etc) on plane_check ops
> 3. Remove always true checks for dpu core ops
> 
> Kevin Tang (6):
>   dt-bindings: display: add Unisoc's drm master bindings
>   drm/sprd: add Unisoc's drm kms master
>   dt-bindings: display: add Unisoc's dpu bindings
>   drm/sprd: add Unisoc's drm display controller driver
>   dt-bindings: display: add Unisoc's mipi dsi&dphy bindings
>   drm/sprd: add Unisoc's drm mipi dsi&dphy driver
> 
>  .../devicetree/bindings/display/sprd/dphy.yaml     |   75 +
>  .../devicetree/bindings/display/sprd/dpu.yaml      |   82 ++
>  .../devicetree/bindings/display/sprd/drm.yaml      |   36 +
>  .../devicetree/bindings/display/sprd/dsi.yaml      |   98 ++
>  drivers/gpu/drm/Kconfig                            |    2 +
>  drivers/gpu/drm/Makefile                           |    1 +
>  drivers/gpu/drm/sprd/Kconfig                       |   12 +
>  drivers/gpu/drm/sprd/Makefile                      |   13 +
>  drivers/gpu/drm/sprd/disp_lib.c                    |   57 +
>  drivers/gpu/drm/sprd/disp_lib.h                    |   16 +
>  drivers/gpu/drm/sprd/dphy/Makefile                 |    7 +
>  drivers/gpu/drm/sprd/dphy/pll/Makefile             |    3 +
>  drivers/gpu/drm/sprd/dphy/pll/megacores_sharkle.c  |  473 +++++++
>  drivers/gpu/drm/sprd/dphy/sprd_dphy_api.c          |  201 +++
>  drivers/gpu/drm/sprd/dphy/sprd_dphy_api.h          |   22 +
>  drivers/gpu/drm/sprd/dpu/Makefile                  |    3 +
>  drivers/gpu/drm/sprd/dpu/dpu_r2p0.c                |  503 +++++++
>  drivers/gpu/drm/sprd/dsi/Makefile                  |    8 +
>  drivers/gpu/drm/sprd/dsi/core/Makefile             |    4 +
>  drivers/gpu/drm/sprd/dsi/core/dsi_ctrl_r1p0.c      |  964 +++++++++++++
>  drivers/gpu/drm/sprd/dsi/core/dsi_ctrl_r1p0.h      | 1477 ++++++++++++++++++++
>  drivers/gpu/drm/sprd/dsi/core/dsi_ctrl_r1p0_ppi.c  |  328 +++++
>  drivers/gpu/drm/sprd/dsi/core/dsi_ctrl_r1p0_ppi.h  |   32 +
>  drivers/gpu/drm/sprd/dsi/sprd_dsi_api.c            |  590 ++++++++
>  drivers/gpu/drm/sprd/dsi/sprd_dsi_api.h            |   26 +
>  drivers/gpu/drm/sprd/sprd_dphy.c                   |  209 +++
>  drivers/gpu/drm/sprd/sprd_dphy.h                   |   50 +
>  drivers/gpu/drm/sprd/sprd_dpu.c                    |  668 +++++++++
>  drivers/gpu/drm/sprd/sprd_dpu.h                    |  190 +++
>  drivers/gpu/drm/sprd/sprd_drm.c                    |  227 +++
>  drivers/gpu/drm/sprd/sprd_drm.h                    |   18 +
>  drivers/gpu/drm/sprd/sprd_dsi.c                    |  571 ++++++++
>  drivers/gpu/drm/sprd/sprd_dsi.h                    |  108 ++
>  33 files changed, 7074 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/sprd/dphy.yaml
>  create mode 100644 Documentation/devicetree/bindings/display/sprd/dpu.yaml
>  create mode 100644 Documentation/devicetree/bindings/display/sprd/drm.yaml
>  create mode 100644 Documentation/devicetree/bindings/display/sprd/dsi.yaml
>  create mode 100644 drivers/gpu/drm/sprd/Kconfig
>  create mode 100644 drivers/gpu/drm/sprd/Makefile
>  create mode 100644 drivers/gpu/drm/sprd/disp_lib.c
>  create mode 100644 drivers/gpu/drm/sprd/disp_lib.h
>  create mode 100644 drivers/gpu/drm/sprd/dphy/Makefile
>  create mode 100644 drivers/gpu/drm/sprd/dphy/pll/Makefile
>  create mode 100644 drivers/gpu/drm/sprd/dphy/pll/megacores_sharkle.c
>  create mode 100644 drivers/gpu/drm/sprd/dphy/sprd_dphy_api.c
>  create mode 100644 drivers/gpu/drm/sprd/dphy/sprd_dphy_api.h
>  create mode 100644 drivers/gpu/drm/sprd/dpu/Makefile
>  create mode 100644 drivers/gpu/drm/sprd/dpu/dpu_r2p0.c
>  create mode 100644 drivers/gpu/drm/sprd/dsi/Makefile
>  create mode 100644 drivers/gpu/drm/sprd/dsi/core/Makefile
>  create mode 100644 drivers/gpu/drm/sprd/dsi/core/dsi_ctrl_r1p0.c
>  create mode 100644 drivers/gpu/drm/sprd/dsi/core/dsi_ctrl_r1p0.h
>  create mode 100644 drivers/gpu/drm/sprd/dsi/core/dsi_ctrl_r1p0_ppi.c
>  create mode 100644 drivers/gpu/drm/sprd/dsi/core/dsi_ctrl_r1p0_ppi.h
>  create mode 100644 drivers/gpu/drm/sprd/dsi/sprd_dsi_api.c
>  create mode 100644 drivers/gpu/drm/sprd/dsi/sprd_dsi_api.h
>  create mode 100644 drivers/gpu/drm/sprd/sprd_dphy.c
>  create mode 100644 drivers/gpu/drm/sprd/sprd_dphy.h
>  create mode 100644 drivers/gpu/drm/sprd/sprd_dpu.c
>  create mode 100644 drivers/gpu/drm/sprd/sprd_dpu.h
>  create mode 100644 drivers/gpu/drm/sprd/sprd_drm.c
>  create mode 100644 drivers/gpu/drm/sprd/sprd_drm.h
>  create mode 100644 drivers/gpu/drm/sprd/sprd_dsi.c
>  create mode 100644 drivers/gpu/drm/sprd/sprd_dsi.h
> 
> -- 
> 2.7.4
> 
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
