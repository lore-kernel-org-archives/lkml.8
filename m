Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15972C33CB6
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 22:56:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DAF112072B
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 22:56:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390153AbgAPW4g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 17:56:36 -0500
Received: from mx2.freebsd.org ([96.47.72.81]:32330 "EHLO mx2.freebsd.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729638AbgAPW4f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 17:56:35 -0500
Received: from mx1.freebsd.org (mx1.freebsd.org [IPv6:2610:1c1:1:606c::19:1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "mx1.freebsd.org", Issuer "Let's Encrypt Authority X3" (verified OK))
        by mx2.freebsd.org (Postfix) with ESMTPS id 4A9B28813E;
        Thu, 16 Jan 2020 22:56:34 +0000 (UTC)
        (envelope-from manu@freebsd.org)
Received: from smtp.freebsd.org (smtp.freebsd.org [IPv6:2610:1c1:1:606c::24b:4])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         server-signature RSA-PSS (4096 bits)
         client-signature RSA-PSS (4096 bits) client-digest SHA256)
        (Client CN "smtp.freebsd.org", Issuer "Let's Encrypt Authority X3" (verified OK))
        by mx1.freebsd.org (Postfix) with ESMTPS id 47zKLp0HJkz3Fx2;
        Thu, 16 Jan 2020 22:56:34 +0000 (UTC)
        (envelope-from manu@freebsd.org)
Received: from localhost.localdomain (lfbn-idf2-1-1164-130.w90-92.abo.wanadoo.fr [90.92.223.130])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client did not present a certificate)
        (Authenticated sender: manu)
        by smtp.freebsd.org (Postfix) with ESMTPSA id 2C9476056;
        Thu, 16 Jan 2020 22:56:32 +0000 (UTC)
        (envelope-from manu@freebsd.org)
From:   Emmanuel Vadot <manu@freebsd.org>
To:     robh+dt@kernel.org, mark.rutland@arm.com, heiko@sntech.de,
        dianders@chromium.org, andy.yan@rock-chips.com,
        robin.murphy@arm.com, mka@chromium.org, jagan@amarulasolutions.com,
        nick@khadas.com, kever.yang@rock-chips.com, m.reichl@fivetechno.de,
        aballier@gentoo.org, pbrobinson@gmail.com, vicencb@gmail.com
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        Emmanuel Vadot <manu@freebsd.org>
Subject: [PATCH 1/2] dt-bindings: Add doc for Pine64 Pinebook Pro
Date:   Thu, 16 Jan 2020 23:56:16 +0100
Message-Id: <20200116225617.6318-1-manu@freebsd.org>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a compatible for Pine64 Pinebook Pro

Signed-off-by: Emmanuel Vadot <manu@freebsd.org>
---
 Documentation/devicetree/bindings/arm/rockchip.yaml | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/rockchip.yaml b/Documentation/devicetree/bindings/arm/rockchip.yaml
index d9847b306b83..2f6b72b084a4 100644
--- a/Documentation/devicetree/bindings/arm/rockchip.yaml
+++ b/Documentation/devicetree/bindings/arm/rockchip.yaml
@@ -412,6 +412,11 @@ properties:
           - const: pine64,rockpro64
           - const: rockchip,rk3399
 
+      - description: Pine64 PinebookPro
+        items:
+          - const: pine64,pinebook-pro
+          - const: rockchip,rk3399
+
       - description: Radxa Rock
         items:
           - const: radxa,rock
-- 
2.24.1

