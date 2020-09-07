Return-Path: <SRS0=/EmK=CQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6B1BC43461
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 10:40:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7855920768
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 10:40:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="WoQItoRI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728932AbgIGKki (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Sep 2020 06:40:38 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:58238 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728706AbgIGKif (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Sep 2020 06:38:35 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 087AcH0l055804;
        Mon, 7 Sep 2020 05:38:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1599475097;
        bh=cn0ZDzFNb0SY1yTr43W1hUscMK7BwXd+r6eaJcDHw9o=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=WoQItoRIEUAdX7RmCUBv5PFIxVielBEFMwP/CzKAVvgIG5UVLBlvR/d1MbECFc/LX
         xNiHLV6l3GtMjfPdcc/1oVeurFx9nWhoWvteTNslJRSfQS0mktof5ObsL8eYaU0zVY
         i6NNm48Nz7dv58sykF75k8ITIKosJDbxL545yPLg=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 087AcHee111789
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 7 Sep 2020 05:38:17 -0500
Received: from DFLE104.ent.ti.com (10.64.6.25) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Mon, 7 Sep
 2020 05:38:17 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Mon, 7 Sep 2020 05:38:17 -0500
Received: from lta0400828a.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 087AcCOp085251;
        Mon, 7 Sep 2020 05:38:15 -0500
From:   Roger Quadros <rogerq@ti.com>
To:     <t-kristo@ti.com>, <nm@ti.com>
CC:     <robh+dt@kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <nsekhar@ti.com>,
        <kishon@ti.com>, Roger Quadros <rogerq@ti.com>
Subject: [PATCH 1/6] dt-bindings: mux-j7200-wiz: Add lane function defines
Date:   Mon, 7 Sep 2020 13:38:05 +0300
Message-ID: <20200907103810.9870-2-rogerq@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200907103810.9870-1-rogerq@ti.com>
References: <20200907103810.9870-1-rogerq@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Each SERDES lane mux can select upto 4 different IPs.
There are 4 lanes in each J7200 SERDES. Define all
the possible functions in this file.

Signed-off-by: Roger Quadros <rogerq@ti.com>
---
 include/dt-bindings/mux/mux-j7200-wiz.h | 29 +++++++++++++++++++++++++
 1 file changed, 29 insertions(+)
 create mode 100644 include/dt-bindings/mux/mux-j7200-wiz.h

diff --git a/include/dt-bindings/mux/mux-j7200-wiz.h b/include/dt-bindings/mux/mux-j7200-wiz.h
new file mode 100644
index 000000000000..b091b1185a36
--- /dev/null
+++ b/include/dt-bindings/mux/mux-j7200-wiz.h
@@ -0,0 +1,29 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * This header provides constants for J7200 WIZ.
+ */
+
+#ifndef _DT_BINDINGS_J7200_WIZ
+#define _DT_BINDINGS_J7200_WIZ
+
+#define SERDES0_LANE0_QSGMII_LANE3	0x0
+#define SERDES0_LANE0_PCIE1_LANE0	0x1
+#define SERDES0_LANE0_IP3_UNUSED	0x2
+#define SERDES0_LANE0_IP4_UNUSED	0x3
+
+#define SERDES0_LANE1_QSGMII_LANE4	0x0
+#define SERDES0_LANE1_PCIE1_LANE1	0x1
+#define SERDES0_LANE1_IP3_UNUSED	0x2
+#define SERDES0_LANE1_IP4_UNUSED	0x3
+
+#define SERDES0_LANE2_QSGMII_LANE1	0x0
+#define SERDES0_LANE2_PCIE1_LANE2	0x1
+#define SERDES0_LANE2_IP3_UNUSED	0x2
+#define SERDES0_LANE2_IP4_UNUSED	0x3
+
+#define SERDES0_LANE3_QSGMII_LANE2	0x0
+#define SERDES0_LANE3_PCIE1_LANE3	0x1
+#define SERDES0_LANE3_USB		0x2
+#define SERDES0_LANE3_IP4_UNUSED	0x3
+
+#endif /* _DT_BINDINGS_J7200_WIZ */
-- 
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

