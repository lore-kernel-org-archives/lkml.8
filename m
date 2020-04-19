Return-Path: <SRS0=L1Qp=6D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26320C54F70
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Apr 2020 17:27:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 10156206D6
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Apr 2020 17:27:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726632AbgDSR14 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 Apr 2020 13:27:56 -0400
Received: from v6.sk ([167.172.42.174]:44480 "EHLO v6.sk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725932AbgDSR1z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Apr 2020 13:27:55 -0400
Received: from localhost (v6.sk [IPv6:::1])
        by v6.sk (Postfix) with ESMTP id AC32D610C2;
        Sun, 19 Apr 2020 17:27:54 +0000 (UTC)
From:   Lubomir Rintel <lkundrak@v3.sk>
To:     Michael Turquette <mturquette@baylibre.com>
Cc:     Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Lubomir Rintel <lkundrak@v3.sk>
Subject: [PATCH 03/10] dt-bindings: marvell,mmp2: Add clock id for the I2S clocks
Date:   Sun, 19 Apr 2020 19:27:35 +0200
Message-Id: <20200419172742.674717-4-lkundrak@v3.sk>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200419172742.674717-1-lkundrak@v3.sk>
References: <20200419172742.674717-1-lkundrak@v3.sk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are two of these on a MMP2.

Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
---
 include/dt-bindings/clock/marvell,mmp2.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/dt-bindings/clock/marvell,mmp2.h b/include/dt-bindings/clock/marvell,mmp2.h
index 06bb7fe4c62f4..5b083f42811e5 100644
--- a/include/dt-bindings/clock/marvell,mmp2.h
+++ b/include/dt-bindings/clock/marvell,mmp2.h
@@ -29,6 +29,8 @@
 #define MMP3_CLK_PLL1_P			28
 #define MMP3_CLK_PLL2_P			29
 #define MMP3_CLK_PLL3			30
+#define MMP2_CLK_I2S0			31
+#define MMP2_CLK_I2S1			32
 
 /* apb periphrals */
 #define MMP2_CLK_TWSI0			60
-- 
2.26.0

