Return-Path: <SRS0=dqcu=6X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30857C47247
	for <linux-kernel@archiver.kernel.org>; Sat,  9 May 2020 11:27:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 09F5521473
	for <linux-kernel@archiver.kernel.org>; Sat,  9 May 2020 11:27:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=48.io header.i=@48.io header.b="UOHMEZ4E"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728495AbgEIL1F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 May 2020 07:27:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728364AbgEIL1B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 May 2020 07:27:01 -0400
Received: from pruto.48.io (48.io [IPv6:2a01:430:17:1::ffff:361])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AEBDC05BD09;
        Sat,  9 May 2020 04:27:01 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by pruto.48.io (Postfix) with ESMTPSA id 1E3A7941C2;
        Sat,  9 May 2020 13:18:43 +0200 (CEST)
DMARC-Filter: OpenDMARC Filter v1.3.2 pruto.48.io 1E3A7941C2
Authentication-Results: pruto.48.io; dmarc=none (p=none dis=none) header.from=48.io
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=48.io; s=default;
        t=1589023123; bh=c/MY7PZoZwLslGs8HMBVxVE+62NvRyMuHVjPYAPKs+4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=UOHMEZ4ERL7FOTpdQ/a7y4abmo73w5zIovWv3NyjKeb9jxio79BKN4Pz+v/adwQ1u
         DKiYVlOVvKpZpLbPXtKcmOjTXPEnszBHPyN4cqv8bvMjzBBOG1YPjHNnPE9eZJkhmo
         OSQ+ndRqlXibrITPqlb3kUxfKqWRCNUSOwnnoXjE=
From:   srk@48.io
To:     Andrzej Hajda <a.hajda@samsung.com>
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Lubomir Rintel <lkundrak@v3.sk>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Sean Cross <xobs@kosagi.com>,
        Richard Marko <srk@48.io>, Shawn Guo <shawnguo@kernel.org>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Thierry Reding <thierry.reding@gmail.com>
Subject: [PATCH 1/2] dt-bindings: n133hse-ea1: Add Innolux N133HSE panel
Date:   Sat,  9 May 2020 13:18:33 +0200
Message-Id: <20200509111834.26335-2-srk@48.io>
In-Reply-To: <20200509111834.26335-1-srk@48.io>
References: <20200509111834.26335-1-srk@48.io>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sean Cross <xobs@kosagi.com>

The Innolux N133HSE panel is a 13.3" 1920x1080 panel that contains an
integrated backlight, and connects via eDP.

It is used in the Kosagi Novena.

Signed-off-by: Sean Cross <xobs@kosagi.com>
Signed-off-by: Richard Marko <srk@48.io>
Cc: Shawn Guo <shawnguo@kernel.org>
Cc: Fabio Estevam <fabio.estevam@nxp.com>
Cc: Thierry Reding <thierry.reding@gmail.com>
To: dri-devel@lists.freedesktop.org
---
 .../devicetree/bindings/display/panel/panel-simple.yaml         | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/panel/panel-simple.yaml b/Documentation/devicetree/bindings/display/panel/panel-simple.yaml
index 393ffc6acbba..756bf6a48e8d 100644
--- a/Documentation/devicetree/bindings/display/panel/panel-simple.yaml
+++ b/Documentation/devicetree/bindings/display/panel/panel-simple.yaml
@@ -139,6 +139,8 @@ properties:
       - innolux,g121i1-l01
         # Innolux Corporation 12.1" G121X1-L03 XGA (1024x768) TFT LCD panel
       - innolux,g121x1-l03
+        # Innolux Corporation 13.3" FHD (1920x1080) TFT LCD panel
+      - innolux,n133hse-ea1
         # Innolux Corporation 11.6" WXGA (1366x768) TFT LCD panel
       - innolux,n116bge
         # InnoLux 15.6" WXGA TFT LCD panel
-- 
2.25.1

