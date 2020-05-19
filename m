Return-Path: <SRS0=IaiW=7B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2461BC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 21:03:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E95242075F
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 21:03:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=walle.cc header.i=@walle.cc header.b="jyLgBnLe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726651AbgESVDj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 May 2020 17:03:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725998AbgESVDi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 17:03:38 -0400
Received: from ssl.serverraum.org (ssl.serverraum.org [IPv6:2a01:4f8:151:8464::1:2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 868B0C08C5C0
        for <linux-kernel@vger.kernel.org>; Tue, 19 May 2020 14:03:38 -0700 (PDT)
Received: from apollo.fritz.box (unknown [IPv6:2a02:810c:c200:2e91:6257:18ff:fec4:ca34])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 3DFAC23058;
        Tue, 19 May 2020 23:03:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1589922214;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=e2AvKo/uy0nGZFQzGAIkim8WVx0YkRWQq0QMlwGjDV0=;
        b=jyLgBnLeF7AbW2U7DkKUB57uyY/BtwIuUShn+R/KherCvtJ2KLyrxAviLzpp8abhDU35pf
        lzscAb2vu4lcC7Hh/sd/FVvtTBixWQqscgrXABXXCwJUSgbid7chhXjVVy+WB2zdKBquMG
        Dhlm+gXxtbOzP07pHu4w0cAfDfwN0q0=
From:   Michael Walle <michael@walle.cc>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     Shawn Guo <shawnguo@kernel.org>, Michael Walle <michael@walle.cc>
Subject: [PATCH] arm64: dts: ls1028a: sl28: keep switch port names consistent
Date:   Tue, 19 May 2020 23:03:19 +0200
Message-Id: <20200519210319.21319-1-michael@walle.cc>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Keep the switch port labels consistent across the different board
variants. If the user wants to rename them, it should be done in
user-space.

Fixes: ab43f0307449 ("arm64: dts: ls1028a: sl28: add support for variant 2")
Signed-off-by: Michael Walle <michael@walle.cc>
---
 .../boot/dts/freescale/fsl-ls1028a-kontron-sl28-var2.dts      | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-sl28-var2.dts b/arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-sl28-var2.dts
index 901b5b161def..dd764b720fb0 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-sl28-var2.dts
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-sl28-var2.dts
@@ -53,14 +53,14 @@
 };
 
 &mscc_felix_port0 {
-	label = "gbe0";
+	label = "swp0";
 	phy-handle = <&phy0>;
 	phy-mode = "sgmii";
 	status = "okay";
 };
 
 &mscc_felix_port1 {
-	label = "gbe1";
+	label = "swp1";
 	phy-handle = <&phy1>;
 	phy-mode = "sgmii";
 	status = "okay";
-- 
2.20.1

