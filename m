Return-Path: <SRS0=QAx1=7P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66254C433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 08:07:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3E8E420772
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 08:07:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726630AbgFBIH0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jun 2020 04:07:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726496AbgFBIHW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jun 2020 04:07:22 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 387FEC061A0E;
        Tue,  2 Jun 2020 01:07:22 -0700 (PDT)
Received: from ni.home (unknown [IPv6:2a01:cb19:8092:cf00:aaa1:59ff:fe08:91d5])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: myjosserand)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 9AADB2A2ADE;
        Tue,  2 Jun 2020 09:07:18 +0100 (BST)
From:   =?UTF-8?q?Myl=C3=A8ne=20Josserand?= 
        <mylene.josserand@collabora.com>
To:     mturquette@baylibre.com, sboyd@kernel.org, heiko@sntech.de,
        robh+dt@kernel.org
Cc:     linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, mylene.josserand@collabora.com,
        kernel@collabora.com
Subject: [PATCH v4 2/2] dt-bindings: clocks: rk3288: add rk3288w compatible
Date:   Tue,  2 Jun 2020 10:06:44 +0200
Message-Id: <20200602080644.11333-3-mylene.josserand@collabora.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200602080644.11333-1-mylene.josserand@collabora.com>
References: <20200602080644.11333-1-mylene.josserand@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the possible compatible "rockchip,rk3288w-cru" that handles
the difference between the rk3288 and the new revision rk3288w.

This compatible will be added by bootloaders.

Signed-off-by: Mylène Josserand <mylene.josserand@collabora.com>
---
 .../devicetree/bindings/clock/rockchip,rk3288-cru.txt     | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/clock/rockchip,rk3288-cru.txt b/Documentation/devicetree/bindings/clock/rockchip,rk3288-cru.txt
index 8cb47c39ba53..bf3a9ec19241 100644
--- a/Documentation/devicetree/bindings/clock/rockchip,rk3288-cru.txt
+++ b/Documentation/devicetree/bindings/clock/rockchip,rk3288-cru.txt
@@ -4,9 +4,15 @@ The RK3288 clock controller generates and supplies clock to various
 controllers within the SoC and also implements a reset controller for SoC
 peripherals.
 
+A revision of this SoC is available: rk3288w. The clock tree is a bit
+different so another dt-compatible is available. Noticed that it is only
+setting the difference but there is no automatic revision detection. This
+should be performed by bootloaders.
+
 Required Properties:
 
-- compatible: should be "rockchip,rk3288-cru"
+- compatible: should be "rockchip,rk3288-cru" or "rockchip,rk3288w-cru" in
+  case of this revision of Rockchip rk3288.
 - reg: physical base address of the controller and length of memory mapped
   region.
 - #clock-cells: should be 1.
-- 
2.26.2

