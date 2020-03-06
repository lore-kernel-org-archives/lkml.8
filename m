Return-Path: <SRS0=glOU=4X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E53D3C3F2C6
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 03:18:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B97AD2073D
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 03:18:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="I0bxC8pL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726650AbgCFDRw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Mar 2020 22:17:52 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:50394 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726162AbgCFDRw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Mar 2020 22:17:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:MIME-Version:Date:Message-ID:Subject:Cc:From:To:Sender:Reply-To:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=o08bZPm/RS6A9C1jh4GWQzSm+/n79bG6xV2CG+lU8+w=; b=I0bxC8pLrA+EH6gd/iaXIZyDdE
        VbHS7Ag0gperjDyalKKLEcJ/Pup74p9O36tpqgFzJXHl89k8pDwdxCyOSdsCs88TbDgbeSN917Izv
        F93CsnajQFN7nQSgjmYitC3B4UloMvN2uzMxiFBjLi01V55cEZoqL0iveUJc4OWz720TINdo3V55P
        Xj4Bsz8Euok8q49KS5QCJNjouANuuh3nbi2hy+eGoDFJGnPzY3gjzckADF3BA/A2tUddsekEXe1Ar
        fwt4vV72TEdInyU1CC0TeT790zvZnhhndudq6Nd+nWTPBfip0RschhVSgRdeZIjux01++ZxUiGyj6
        vRnTnAJQ==;
Received: from [2601:1c0:6280:3f0:897c:6038:c71d:ecac]
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jA3Uk-0003vv-65; Fri, 06 Mar 2020 03:17:50 +0000
To:     dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
From:   Randy Dunlap <rdunlap@infradead.org>
Cc:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Kieran Bingham <kieran.bingham@ideasonboard.com>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Koji Matsuoka <koji.matsuoka.xm@renesas.com>,
        David Airlie <airlied@linux.ie>
Subject: [RFC PATCH] drm: rcar-du: make all sub-symbols depend on DRM_RCAR_DU
Message-ID: <4b50cc9f-1434-b78a-d56a-fadfd030f002@infradead.org>
Date:   Thu, 5 Mar 2020 19:17:49 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <rdunlap@infradead.org>

DRM_RCAR_CMM depends on DRM_RCAR_DU. Since the following Kconfig
symbols do not depend on DRM_RCAR_DU, the menu presentation is
broken for these and following non-R-Car Kconfig symbols.

Is it safe/appropriate to make all of these symbols depend on
DRM_RCAR_DU?  It make the kconfig menu presentation much cleaner.

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
Cc: dri-devel@lists.freedesktop.org
Cc: linux-renesas-soc@vger.kernel.org
Cc: Koji Matsuoka <koji.matsuoka.xm@renesas.com>
Cc: Dave Airlie <airlied@linux.ie>
---
 drivers/gpu/drm/rcar-du/Kconfig |    3 +++
 1 file changed, 3 insertions(+)

--- linux-next-20200305.orig/drivers/gpu/drm/rcar-du/Kconfig
+++ linux-next-20200305/drivers/gpu/drm/rcar-du/Kconfig
@@ -24,6 +24,7 @@ config DRM_RCAR_CMM
 config DRM_RCAR_DW_HDMI
 	tristate "R-Car DU Gen3 HDMI Encoder Support"
 	depends on DRM && OF
+	depends on DRM_RCAR_DU
 	select DRM_DW_HDMI
 	help
 	  Enable support for R-Car Gen3 internal HDMI encoder.
@@ -31,6 +32,7 @@ config DRM_RCAR_DW_HDMI
 config DRM_RCAR_LVDS
 	tristate "R-Car DU LVDS Encoder Support"
 	depends on DRM && DRM_BRIDGE && OF
+	depends on DRM_RCAR_DU
 	select DRM_PANEL
 	select OF_FLATTREE
 	select OF_OVERLAY
@@ -47,4 +49,5 @@ config DRM_RCAR_VSP
 
 config DRM_RCAR_WRITEBACK
 	bool
+	depends on DRM_RCAR_DU
 	default y if ARM64

