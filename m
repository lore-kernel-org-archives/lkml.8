Return-Path: <SRS0=IaiW=7B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E946C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 22:42:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 34252205CB
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 22:42:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728402AbgESWmk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 May 2020 18:42:40 -0400
Received: from v6.sk ([167.172.42.174]:58664 "EHLO v6.sk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728347AbgESWmd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 18:42:33 -0400
Received: from localhost (v6.sk [IPv6:::1])
        by v6.sk (Postfix) with ESMTP id C95D7610D9;
        Tue, 19 May 2020 22:42:01 +0000 (UTC)
From:   Lubomir Rintel <lkundrak@v3.sk>
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Lubomir Rintel <lkundrak@v3.sk>, Rob Herring <robh@kernel.org>
Subject: [PATCH v3 04/13] dt-bindings: marvell,mmp2: Add clock id for the Audio clock
Date:   Wed, 20 May 2020 00:41:42 +0200
Message-Id: <20200519224151.2074597-5-lkundrak@v3.sk>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200519224151.2074597-1-lkundrak@v3.sk>
References: <20200519224151.2074597-1-lkundrak@v3.sk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This clocks the Audio block.

Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
Acked-by: Rob Herring <robh@kernel.org>

---
Changes since v1:
- Rob's ack

 include/dt-bindings/clock/marvell,mmp2.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/dt-bindings/clock/marvell,mmp2.h b/include/dt-bindings/clock/marvell,mmp2.h
index 5b083f42811e..87f5ad5df72f 100644
--- a/include/dt-bindings/clock/marvell,mmp2.h
+++ b/include/dt-bindings/clock/marvell,mmp2.h
@@ -89,6 +89,7 @@
 #define MMP3_CLK_GPU_3D			MMP2_CLK_GPU_3D
 #define MMP3_CLK_GPU_2D			125
 #define MMP3_CLK_SDH4			126
+#define MMP2_CLK_AUDIO			127
 
 #define MMP2_NR_CLKS			200
 #endif
-- 
2.26.2

