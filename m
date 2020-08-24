Return-Path: <SRS0=wYIT=CC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03D80C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 15:05:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D405E206F0
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 15:05:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726799AbgHXPFv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Aug 2020 11:05:51 -0400
Received: from mailoutvs49.siol.net ([185.57.226.240]:58240 "EHLO
        mail.siol.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726519AbgHXPEx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Aug 2020 11:04:53 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.siol.net (Postfix) with ESMTP id 64E9E525762;
        Mon, 24 Aug 2020 17:04:50 +0200 (CEST)
X-Virus-Scanned: amavisd-new at psrvmta10.zcs-production.pri
Received: from mail.siol.net ([127.0.0.1])
        by localhost (psrvmta10.zcs-production.pri [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id SoJTlRNGNgBS; Mon, 24 Aug 2020 17:04:50 +0200 (CEST)
Received: from mail.siol.net (localhost [127.0.0.1])
        by mail.siol.net (Postfix) with ESMTPS id 1DB8252576D;
        Mon, 24 Aug 2020 17:04:50 +0200 (CEST)
Received: from localhost.localdomain (89-212-178-211.dynamic.t-2.net [89.212.178.211])
        (Authenticated sender: 031275009)
        by mail.siol.net (Postfix) with ESMTPSA id 79D1452576C;
        Mon, 24 Aug 2020 17:04:47 +0200 (CEST)
From:   Jernej Skrabec <jernej.skrabec@siol.net>
To:     mripard@kernel.org, wens@csie.org, robh+dt@kernel.org
Cc:     airlied@linux.ie, daniel@ffwll.ch, heiko@sntech.de,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@googlegroups.com
Subject: [PATCH 1/2] dt-bindings: gpu: mali-utgard: Add Allwinner R40 compatible
Date:   Mon, 24 Aug 2020 17:04:33 +0200
Message-Id: <20200824150434.951693-2-jernej.skrabec@siol.net>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200824150434.951693-1-jernej.skrabec@siol.net>
References: <20200824150434.951693-1-jernej.skrabec@siol.net>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allwinner R40 SoC contains Mali400, so add its specific compatible to
bindings.

Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
---
 Documentation/devicetree/bindings/gpu/arm,mali-utgard.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/gpu/arm,mali-utgard.yaml b=
/Documentation/devicetree/bindings/gpu/arm,mali-utgard.yaml
index 6226d31ec4b7..d4d785790eaa 100644
--- a/Documentation/devicetree/bindings/gpu/arm,mali-utgard.yaml
+++ b/Documentation/devicetree/bindings/gpu/arm,mali-utgard.yaml
@@ -25,6 +25,7 @@ properties:
               - allwinner,sun4i-a10-mali
               - allwinner,sun7i-a20-mali
               - allwinner,sun8i-h3-mali
+              - allwinner,sun8i-r40-mali
               - allwinner,sun50i-a64-mali
               - rockchip,rk3036-mali
               - rockchip,rk3066-mali
@@ -129,6 +130,7 @@ allOf:
             enum:
               - allwinner,sun4i-a10-mali
               - allwinner,sun7i-a20-mali
+              - allwinner,sun8i-r40-mali
               - allwinner,sun50i-a64-mali
               - allwinner,sun50i-h5-mali
               - amlogic,meson8-mali
--=20
2.28.0

