Return-Path: <SRS0=glOU=4X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDCC8C10DCE
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 13:41:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BCEF12072D
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 13:41:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727089AbgCFNls (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Mar 2020 08:41:48 -0500
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:6182 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726498AbgCFNls (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Mar 2020 08:41:48 -0500
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 026DYTEA011765;
        Fri, 6 Mar 2020 08:41:44 -0500
Received: from nwd2mta4.analog.com ([137.71.173.58])
        by mx0a-00128a01.pphosted.com with ESMTP id 2ygm52k7v5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 06 Mar 2020 08:41:44 -0500
Received: from SCSQMBX10.ad.analog.com (scsqmbx10.ad.analog.com [10.77.17.5])
        by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 026DfgAI065008
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Fri, 6 Mar 2020 08:41:42 -0500
Received: from SCSQCASHYB6.ad.analog.com (10.77.17.132) by
 SCSQMBX10.ad.analog.com (10.77.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Fri, 6 Mar 2020 05:41:41 -0800
Received: from SCSQMBX11.ad.analog.com (10.77.17.10) by
 SCSQCASHYB6.ad.analog.com (10.77.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Fri, 6 Mar 2020 05:41:08 -0800
Received: from zeus.spd.analog.com (10.64.82.11) by SCSQMBX11.ad.analog.com
 (10.77.17.10) with Microsoft SMTP Server id 15.1.1779.2 via Frontend
 Transport; Fri, 6 Mar 2020 05:41:40 -0800
Received: from ben-Latitude-E6540.ad.analog.com ([10.48.65.231])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 026DfbYm025629;
        Fri, 6 Mar 2020 08:41:38 -0500
From:   Beniamin Bia <beniamin.bia@analog.com>
To:     <nios2-dev@lists.rocketboards.org>
CC:     <ley.foon.tan@intel.com>, <biabeniamin@outlook.com>,
        <linux-kernel@vger.kernel.org>,
        Dragos Bogdan <dragos.bogdan@analog.com>,
        Beniamin Bia <beniamin.bia@analog.com>
Subject: [PATCH] arch: nios2: Enable the common clk subsystem on Nios2
Date:   Fri, 6 Mar 2020 15:44:27 +0200
Message-ID: <20200306134427.7487-1-beniamin.bia@analog.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-03-06_04:2020-03-06,2020-03-06 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 mlxlogscore=999 mlxscore=0 lowpriorityscore=0 clxscore=1011 adultscore=0
 impostorscore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2003060098
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dragos Bogdan <dragos.bogdan@analog.com>

This patch adds support for common clock framework on Nios2. Clock
framework is commonly used in many drivers, and this patch makes it
available for the entire architecture, not just on a per-driver basis.

Signed-off-by: Beniamin Bia <beniamin.bia@analog.com>
Signed-off-by: Dragos Bogdan <dragos.bogdan@analog.com>
---
 arch/nios2/Kconfig             | 1 +
 arch/nios2/platform/platform.c | 8 ++++++++
 2 files changed, 9 insertions(+)

diff --git a/arch/nios2/Kconfig b/arch/nios2/Kconfig
index 44b5da37e8bd..4b7c951e80e2 100644
--- a/arch/nios2/Kconfig
+++ b/arch/nios2/Kconfig
@@ -6,6 +6,7 @@ config NIOS2
 	select ARCH_HAS_SYNC_DMA_FOR_DEVICE
 	select ARCH_HAS_UNCACHED_SEGMENT
 	select ARCH_NO_SWAP
+	select COMMON_CLK
 	select TIMER_OF
 	select GENERIC_ATOMIC64
 	select GENERIC_CLOCKEVENTS
diff --git a/arch/nios2/platform/platform.c b/arch/nios2/platform/platform.c
index 2a35154ca153..9737a87121fa 100644
--- a/arch/nios2/platform/platform.c
+++ b/arch/nios2/platform/platform.c
@@ -15,6 +15,12 @@
 #include <linux/slab.h>
 #include <linux/sys_soc.h>
 #include <linux/io.h>
+#include <linux/clk-provider.h>
+
+static const struct of_device_id clk_match[] __initconst = {
+	{ .compatible = "fixed-clock", .data = of_fixed_clk_setup, },
+	{}
+};
 
 static int __init nios2_soc_device_init(void)
 {
@@ -38,6 +44,8 @@ static int __init nios2_soc_device_init(void)
 		}
 	}
 
+	of_clk_init(clk_match);
+
 	return 0;
 }
 
-- 
2.17.1

