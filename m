Return-Path: <SRS0=IaiW=7B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCA34C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 22:42:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C1473205CB
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 22:42:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728356AbgESWme (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 May 2020 18:42:34 -0400
Received: from v6.sk ([167.172.42.174]:58564 "EHLO v6.sk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728209AbgESWmM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 18:42:12 -0400
Received: from localhost (v6.sk [IPv6:::1])
        by v6.sk (Postfix) with ESMTP id 6FF4B612FB;
        Tue, 19 May 2020 22:42:11 +0000 (UTC)
From:   Lubomir Rintel <lkundrak@v3.sk>
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Lubomir Rintel <lkundrak@v3.sk>, Rob Herring <robh@kernel.org>
Subject: [PATCH v3 10/13] dt-bindings: marvell,mmp2: Add ids for the power domains
Date:   Wed, 20 May 2020 00:41:48 +0200
Message-Id: <20200519224151.2074597-11-lkundrak@v3.sk>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200519224151.2074597-1-lkundrak@v3.sk>
References: <20200519224151.2074597-1-lkundrak@v3.sk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On MMP2 the audio and GPU blocks are on separate power islands. On MMP3
the camera block's power is also controlled separately.

Add the numbers that we could use to refer to the power domains for
respective power islands from the device tree.

Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
Acked-by: Rob Herring <robh@kernel.org>

---
Changes since v1:
- Rob's ack

 include/dt-bindings/power/marvell,mmp2.h | 11 +++++++++++
 1 file changed, 11 insertions(+)
 create mode 100644 include/dt-bindings/power/marvell,mmp2.h

diff --git a/include/dt-bindings/power/marvell,mmp2.h b/include/dt-bindings/power/marvell,mmp2.h
new file mode 100644
index 000000000000..c53d2b3e1057
--- /dev/null
+++ b/include/dt-bindings/power/marvell,mmp2.h
@@ -0,0 +1,11 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __DTS_MARVELL_MMP2_POWER_H
+#define __DTS_MARVELL_MMP2_POWER_H
+
+#define MMP2_POWER_DOMAIN_GPU		0
+#define MMP2_POWER_DOMAIN_AUDIO		1
+#define MMP3_POWER_DOMAIN_CAMERA	2
+
+#define MMP2_NR_POWER_DOMAINS		3
+
+#endif
-- 
2.26.2

