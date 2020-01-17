Return-Path: <SRS0=N8G3=3G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB873C3F68F
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 18:31:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9BE8B214AF
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 18:31:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729259AbgAQSbu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jan 2020 13:31:50 -0500
Received: from asavdk3.altibox.net ([109.247.116.14]:36638 "EHLO
        asavdk3.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726761AbgAQSbu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jan 2020 13:31:50 -0500
Received: from ravnborg.org (unknown [158.248.194.18])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by asavdk3.altibox.net (Postfix) with ESMTPS id 8CDEC20026;
        Fri, 17 Jan 2020 19:31:47 +0100 (CET)
Date:   Fri, 17 Jan 2020 19:31:46 +0100
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Jitao Shi <jitao.shi@mediatek.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        srv_heupstream@mediatek.com, stonea168@163.com,
        cawa.cheng@mediatek.com, linux-mediatek@lists.infradead.org,
        yingjoe.chen@mediatek.com, eddie.huang@mediatek.com
Subject: Re: [PATCH v9 0/5] add driver for "boe, tv101wum-nl6", "boe,
 tv101wum-n53", "auo, kd101n80-45na" and "auo, b101uan08.3" panels
Message-ID: <20200117183146.GB14298@ravnborg.org>
References: <20200116021511.22675-1-jitao.shi@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200116021511.22675-1-jitao.shi@mediatek.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=eMA9ckh1 c=1 sm=1 tr=0
        a=UWs3HLbX/2nnQ3s7vZ42gw==:117 a=UWs3HLbX/2nnQ3s7vZ42gw==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=kj9zAlcOel0A:10 a=e5mUnYsNAAAA:8
        a=3tjGstHQEWMJ4ujXvacA:9 a=CjuIK1q_8ugA:10 a=Vxmtnl_E_bksehYqCbjh:22
        a=pHzHmUro8NiASowvMSCR:22 a=xoEH_sTeL_Rfw54TyV31:22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jitao.

Thanks for your perseverance on this.
With the minor issue on the binding file resolved everything is now fine
and patches are all applied to drm-misc-next.

Thanks,

	Sam

On Thu, Jan 16, 2020 at 10:15:06AM +0800, Jitao Shi wrote:
> Changes since v8:
>  - merge the panel documents to one.
>  - delay move the drm_panel_of_backlight after drm_panel_init
> 
> Changes since v7:
>  - base drm-misc-next branch
>  - fix document pass dt_binding_check
>  - remove backlight from panel driver
> 
> Changes since v6:
>  - fix boe_panel_init err uninit.
>  - adjust the delay of backlight on.
> 
> Changes since v5:
>  - covert the documents to yaml
>  - fine tune boe, tv101wum-n53 panel video timine
> 
> Changes since v4:
>  - add auo,b101uan08.3 panel for this driver.
>  - add boe,tv101wum-n53 panel for this driver.
> 
> Changes since v3:
>  - remove check enable_gpio.
>  - fine tune the auo,kd101n80-45na panel's power on timing.
> 
> Changes since v2:
>  - correct the panel size
>  - remove blank line in Kconfig
>  - move auo,kd101n80-45na panel driver in this series.
> 
> Changes since v1:
>  - update typo nl6 -> n16.
>  - update new panel config and makefile are added in alphabetically order.
>  - add the panel mode and panel info in driver data.
>  - merge auo,kd101n80-45a and boe,tv101wum-nl6 in one driver
> 
> Jitao Shi (5):
>   dt-bindings: display: panel: Add boe tv101wum-n16 panel bindings
>   drm/panel: support for boe tv101wum-nl6 wuxga dsi video mode panel
>   drm/panel: support for auo,kd101n80-45na wuxga dsi video mode panel
>   drm/panel: support for boe,tv101wum-n53 wuxga dsi video mode panel
>   drm/panel: support for auo,b101uan08.3 wuxga dsi video mode panel
> 
>  .../display/panel/boe,tv101wum-nl6.yaml       |  81 ++
>  drivers/gpu/drm/panel/Kconfig                 |   9 +
>  drivers/gpu/drm/panel/Makefile                |   1 +
>  .../gpu/drm/panel/panel-boe-tv101wum-nl6.c    | 854 ++++++++++++++++++
>  4 files changed, 945 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/panel/boe,tv101wum-nl6.yaml
>  create mode 100644 drivers/gpu/drm/panel/panel-boe-tv101wum-nl6.c
> 
> -- 
> 2.21.0
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
