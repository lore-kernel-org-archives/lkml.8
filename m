Return-Path: <SRS0=fsZL=42=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 142D1C10F25
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 19:43:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F04E524656
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 19:43:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726979AbgCITny (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Mar 2020 15:43:54 -0400
Received: from v6.sk ([167.172.42.174]:34736 "EHLO v6.sk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726169AbgCITnw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Mar 2020 15:43:52 -0400
Received: from localhost (v6.sk [IPv6:::1])
        by v6.sk (Postfix) with ESMTP id 7B4546130B;
        Mon,  9 Mar 2020 19:43:51 +0000 (UTC)
From:   Lubomir Rintel <lkundrak@v3.sk>
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Lubomir Rintel <lkundrak@v3.sk>
Subject: [PATCH v2 13/17] dt-bindings: marvell,mmp2: Add clock ids for the thermal sensors
Date:   Mon,  9 Mar 2020 20:42:50 +0100
Message-Id: <20200309194254.29009-14-lkundrak@v3.sk>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200309194254.29009-1-lkundrak@v3.sk>
References: <20200309194254.29009-1-lkundrak@v3.sk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There seems to be a single thermal sensor block on MMP2 and a couple
more on MMP3. Add definitions for their respective clocks.

Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>

---
Changes since v1:
- Added this patch

 include/dt-bindings/clock/marvell,mmp2.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/dt-bindings/clock/marvell,mmp2.h b/include/dt-bindings/clock/marvell,mmp2.h
index dd5067bd92f22..2793fdf300066 100644
--- a/include/dt-bindings/clock/marvell,mmp2.h
+++ b/include/dt-bindings/clock/marvell,mmp2.h
@@ -53,6 +53,10 @@
 #define MMP2_CLK_SSP2			79
 #define MMP2_CLK_SSP3			80
 #define MMP2_CLK_TIMER			81
+#define MMP2_CLK_THERMAL0		82
+#define MMP3_CLK_THERMAL1		83
+#define MMP3_CLK_THERMAL2		84
+#define MMP3_CLK_THERMAL3		85
 
 /* axi periphrals */
 #define MMP2_CLK_SDH0			101
-- 
2.25.1

