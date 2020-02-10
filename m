Return-Path: <SRS0=Vo5z=36=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62D5FC352A3
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 17:07:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 45E8B214DB
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 17:07:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728002AbgBJRHR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Feb 2020 12:07:17 -0500
Received: from mailoutvs11.siol.net ([185.57.226.202]:47083 "EHLO
        mail.siol.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727967AbgBJRHP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 12:07:15 -0500
Received: from localhost (localhost [127.0.0.1])
        by mail.siol.net (Postfix) with ESMTP id 40B16521467;
        Mon, 10 Feb 2020 18:07:13 +0100 (CET)
X-Virus-Scanned: amavisd-new at psrvmta09.zcs-production.pri
Received: from mail.siol.net ([127.0.0.1])
        by localhost (psrvmta09.zcs-production.pri [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id 11MVvfihKa4a; Mon, 10 Feb 2020 18:07:13 +0100 (CET)
Received: from mail.siol.net (localhost [127.0.0.1])
        by mail.siol.net (Postfix) with ESMTPS id E8D34521845;
        Mon, 10 Feb 2020 18:07:12 +0100 (CET)
Received: from localhost.localdomain (cpe-194-152-20-232.static.triera.net [194.152.20.232])
        (Authenticated sender: 031275009)
        by mail.siol.net (Postfix) with ESMTPSA id 00F92521467;
        Mon, 10 Feb 2020 18:07:09 +0100 (CET)
From:   Jernej Skrabec <jernej.skrabec@siol.net>
To:     mripard@kernel.org, wens@csie.org
Cc:     mchehab@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com, Rob Herring <robh@kernel.org>
Subject: [PATCH v2 1/5] dt-bindings: interconnect: sunxi: Add A64 MBUS compatible
Date:   Mon, 10 Feb 2020 18:06:52 +0100
Message-Id: <20200210170656.82265-2-jernej.skrabec@siol.net>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200210170656.82265-1-jernej.skrabec@siol.net>
References: <20200210170656.82265-1-jernej.skrabec@siol.net>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A64 contains MBUS controller. Add a compatible for it.

Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
---
 .../devicetree/bindings/arm/sunxi/allwinner,sun4i-a10-mbus.yaml  | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/sunxi/allwinner,sun4i-=
a10-mbus.yaml b/Documentation/devicetree/bindings/arm/sunxi/allwinner,sun=
4i-a10-mbus.yaml
index 9370e64992dd..aa0738b4d534 100644
--- a/Documentation/devicetree/bindings/arm/sunxi/allwinner,sun4i-a10-mbu=
s.yaml
+++ b/Documentation/devicetree/bindings/arm/sunxi/allwinner,sun4i-a10-mbu=
s.yaml
@@ -30,6 +30,7 @@ properties:
     enum:
       - allwinner,sun5i-a13-mbus
       - allwinner,sun8i-h3-mbus
+      - allwinner,sun50i-a64-mbus
=20
   reg:
     maxItems: 1
--=20
2.25.0

