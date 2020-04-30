Return-Path: <SRS0=SogR=6O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEDC1C8300C
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 07:16:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C316820784
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 07:16:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726837AbgD3HQ5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Apr 2020 03:16:57 -0400
Received: from mga01.intel.com ([192.55.52.88]:42627 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726760AbgD3HQt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Apr 2020 03:16:49 -0400
IronPort-SDR: W8O4w+i/uImYNjq6eJet3JnhZGB4/+9oc+sTX+/ZLSFFFBQ0iNypqTzgC84JqyrIWHpVuQ0PN2
 VEPphaXEL85w==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2020 00:16:48 -0700
IronPort-SDR: t7CTa3zxMsIjNQl3lp6hIbYiNcXF1gftXhI7rL7twoaUoiCQXRz0nQBap68p7VThqVCTVxlC0A
 60Qhgu/EYu5Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,334,1583222400"; 
   d="scan'208";a="294421099"
Received: from sgsxdev004.isng.intel.com (HELO localhost) ([10.226.88.13])
  by orsmga008.jf.intel.com with ESMTP; 30 Apr 2020 00:16:45 -0700
From:   Dilip Kota <eswara.kota@linux.intel.com>
To:     linux-kernel@vger.kernel.org, kishon@ti.com, vkoul@kernel.org,
        devicetree@vger.kernel.org, lee.jones@linaro.org, arnd@arndb.de
Cc:     robh@kernel.org, andriy.shevchenko@intel.com,
        cheol.yong.kim@intel.com, chuanhua.lei@linux.intel.com,
        qi-ming.wu@intel.com, yixin.zhu@intel.com,
        Dilip Kota <eswara.kota@linux.intel.com>
Subject: [PATCH v7 1/3] dt-bindings: phy: Add PHY_TYPE_XPCS definition
Date:   Thu, 30 Apr 2020 15:15:27 +0800
Message-Id: <6091f0d2a1046f1e3656d9e33b6cc433d5465eaf.1588230494.git.eswara.kota@linux.intel.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <cover.1588230494.git.eswara.kota@linux.intel.com>
References: <cover.1588230494.git.eswara.kota@linux.intel.com>
In-Reply-To: <cover.1588230494.git.eswara.kota@linux.intel.com>
References: <cover.1588230494.git.eswara.kota@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add definition for Ethernet PCS phy type.

Signed-off-by: Dilip Kota <eswara.kota@linux.intel.com>
Acked-by: Rob Herring <robh@kernel.org>
---
Changes on v7:
  No Change

Changes on v6:
  Add Acked-by: Rob Herring <robh@kernel.org>

 include/dt-bindings/phy/phy.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/dt-bindings/phy/phy.h b/include/dt-bindings/phy/phy.h
index 1f3f866fae7b..3727ef72138b 100644
--- a/include/dt-bindings/phy/phy.h
+++ b/include/dt-bindings/phy/phy.h
@@ -17,5 +17,6 @@
 #define PHY_TYPE_USB3		4
 #define PHY_TYPE_UFS		5
 #define PHY_TYPE_DP		6
+#define PHY_TYPE_XPCS		7
 
 #endif /* _DT_BINDINGS_PHY */
-- 
2.11.0

