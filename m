Return-Path: <SRS0=LKJ9=BU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73A70C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 20:35:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 588D520656
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 20:35:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726654AbgHJUfz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Aug 2020 16:35:55 -0400
Received: from asavdk3.altibox.net ([109.247.116.14]:37944 "EHLO
        asavdk3.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726637AbgHJUfx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Aug 2020 16:35:53 -0400
Received: from ravnborg.org (unknown [188.228.123.71])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by asavdk3.altibox.net (Postfix) with ESMTPS id 176D920023;
        Mon, 10 Aug 2020 22:35:47 +0200 (CEST)
Date:   Mon, 10 Aug 2020 22:35:46 +0200
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Xin Ji <xji@analogixsemi.com>
Cc:     devel@driverdev.osuosl.org,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Nicolas Boichat <drinkcat@google.com>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Nicolas Boichat <drinkcat@chromium.org>,
        Pi-Hsun Shih <pihsun@chromium.org>,
        Jonas Karlman <jonas@kwiboo.se>,
        David Airlie <airlied@linux.ie>,
        Neil Armstrong <narmstrong@baylibre.com>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Sheng Pan <span@analogixsemi.com>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [PATCH v14 0/2] Add initial support for slimport anx7625
Message-ID: <20200810203546.GA421906@ravnborg.org>
References: <cover.1594283160.git.xji@analogixsemi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1594283160.git.xji@analogixsemi.com>
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=f+hm+t6M c=1 sm=1 tr=0
        a=S6zTFyMACwkrwXSdXUNehg==:117 a=S6zTFyMACwkrwXSdXUNehg==:17
        a=kj9zAlcOel0A:10 a=e5mUnYsNAAAA:8 a=Q7Y_AtYsOxiy2qtOLeEA:9
        a=CjuIK1q_8ugA:10 a=Vxmtnl_E_bksehYqCbjh:22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Xin Ji.

On Thu, Jul 09, 2020 at 04:31:09PM +0800, Xin Ji wrote:
> Hi all,
> 
> The following series add support for the Slimport ANX7625 transmitter, a
> ultra-low power Full-HD 4K MIPI to DP transmitter designed for portable device.
> 
> 
> This is the v14 version, any mistakes, please let me know, I will fix it in
> the next series.
> 
> Change history:
> v14: Fix comments from Sam and Nicolas
>  - Check flags at drm_bridge_attach
>  - Use panel_bridge instead of drm_panel
>  - Fix not correct return value

Sorry for ignoring this for so long time.
The patch applies but no longer builds.

I could fix it locally but wanted to know if you have a later version to
be applied?

	Sam


> 
> v13: Fix comments from Launrent Pinchart and Rob Herring
>  - Picked up Rob's Reviewed-By
>  - Add .detect and .get_edid interface in bridge funcs.
> 
> v12: Fix comments from Hsin-Yi Wang
>  - Rebase the code on kernel 5.7, fix DRM interface not match issue.
> 
> v11: Fix comments from Rob Herring
>  - Update commit message.
>  - Remove unused label.
> 
> v10: Fix comments from Rob Herring, Daniel.
>  - Fix dt_binding_check warning.
>  - Update description.
> 
> v9: Fix comments from Sam, Nicolas, Daniel
>  - Remove extcon interface.
>  - Remove DPI support.
>  - Fix dt_binding_check complains.
>  - Code clean up and update description.
> 
> v8: Fix comments from Nicolas.
>  - Fix several coding format.
>  - Update description.
> 
> v7:
>  - Fix critical timing(eg:odd hfp/hbp) in "mode_fixup" interface,
>    enhance MIPI RX tolerance by setting register MIPI_DIGITAL_ADJ_1 to 0x3D.
> 
> 
> Xin Ji (2):
>   dt-bindings: drm/bridge: anx7625: MIPI to DP transmitter DT schema
>   drm/bridge: anx7625: Add anx7625 MIPI DSI/DPI to DP
> 
>  .../bindings/display/bridge/analogix,anx7625.yaml  |   95 +
>  drivers/gpu/drm/bridge/analogix/Kconfig            |    9 +
>  drivers/gpu/drm/bridge/analogix/Makefile           |    1 +
>  drivers/gpu/drm/bridge/analogix/anx7625.c          | 1939 ++++++++++++++++++++
>  drivers/gpu/drm/bridge/analogix/anx7625.h          |  391 ++++
>  5 files changed, 2435 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/bridge/analogix,anx7625.yaml
>  create mode 100644 drivers/gpu/drm/bridge/analogix/anx7625.c
>  create mode 100644 drivers/gpu/drm/bridge/analogix/anx7625.h
> 
> -- 
> 2.7.4
> 
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
