Return-Path: <SRS0=ABJN=6Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 455F2C47255
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 19:25:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 317C720752
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 19:25:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731527AbgEKTZi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 May 2020 15:25:38 -0400
Received: from v6.sk ([167.172.42.174]:52348 "EHLO v6.sk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731506AbgEKTZg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 15:25:36 -0400
Received: from localhost (v6.sk [IPv6:::1])
        by v6.sk (Postfix) with ESMTP id 417ED610A9;
        Mon, 11 May 2020 19:25:35 +0000 (UTC)
From:   Lubomir Rintel <lkundrak@v3.sk>
To:     Michael Turquette <mturquette@baylibre.com>
Cc:     Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Lubomir Rintel <lkundrak@v3.sk>
Subject: [PATCH v2 05/10] clk: mmp2: Move thermal register defines up a bit
Date:   Mon, 11 May 2020 21:25:12 +0200
Message-Id: <20200511192517.1206442-6-lkundrak@v3.sk>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200511192517.1206442-1-lkundrak@v3.sk>
References: <20200511192517.1206442-1-lkundrak@v3.sk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A trivial change to keep the sorting sane. The APBC registers are happier
when they are grouped together, instead of mixed with the APMU ones.

Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
---
 drivers/clk/mmp/clk-of-mmp2.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/clk/mmp/clk-of-mmp2.c b/drivers/clk/mmp/clk-of-mmp2.c
index 52dc8b43acd9..524574187c17 100644
--- a/drivers/clk/mmp/clk-of-mmp2.c
+++ b/drivers/clk/mmp/clk-of-mmp2.c
@@ -45,6 +45,10 @@
 #define APBC_SSP1	0x54
 #define APBC_SSP2	0x58
 #define APBC_SSP3	0x5c
+#define APBC_THERMAL0	0x90
+#define APBC_THERMAL1	0x98
+#define APBC_THERMAL2	0x9c
+#define APBC_THERMAL3	0xa0
 #define APMU_SDH0	0x54
 #define APMU_SDH1	0x58
 #define APMU_SDH2	0xe8
@@ -55,10 +59,6 @@
 #define APMU_DISP1	0x110
 #define APMU_CCIC0	0x50
 #define APMU_CCIC1	0xf4
-#define APBC_THERMAL0	0x90
-#define APBC_THERMAL1	0x98
-#define APBC_THERMAL2	0x9c
-#define APBC_THERMAL3	0xa0
 #define APMU_USBHSIC0	0xf8
 #define APMU_USBHSIC1	0xfc
 #define APMU_GPU	0xcc
-- 
2.26.2

