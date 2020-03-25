Return-Path: <SRS0=vy7l=5K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 702E6C1975A
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 09:00:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5221D20722
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 09:00:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727559AbgCYJAQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Mar 2020 05:00:16 -0400
Received: from mga05.intel.com ([192.55.52.43]:44483 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726105AbgCYJAO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Mar 2020 05:00:14 -0400
IronPort-SDR: RExQxfJtLHKzfvQKRDB0qfKSt9UTsFBAaGbe4g+Wg3035+k91XvSzKloUpttaTklCE1gi4eY9Q
 qQn4IlWI1Tbw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2020 02:00:14 -0700
IronPort-SDR: XEHpQPfrGyqwrT9EbpPHX6aQCp3dAFGMZ9+ZA/6j8/8/ixnh/Byrgt+T3vGEHDmVkBobSK2VP8
 Ks66DiglTElQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,303,1580803200"; 
   d="scan'208";a="238475157"
Received: from sgsxdev004.isng.intel.com (HELO localhost) ([10.226.88.13])
  by fmsmga007.fm.intel.com with ESMTP; 25 Mar 2020 02:00:12 -0700
From:   Dilip Kota <eswara.kota@linux.intel.com>
To:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Cc:     kishon@ti.com, robh@kernel.org, andriy.shevchenko@intel.com,
        cheol.yong.kim@intel.com, chuanhua.lei@linux.intel.com,
        qi-ming.wu@intel.com, yixin.zhu@intel.com,
        Dilip Kota <eswara.kota@linux.intel.com>
Subject: [PATCH v5 2/4] dt-bindings: phy: Add PHY_TYPE_XPCS definition
Date:   Wed, 25 Mar 2020 16:59:38 +0800
Message-Id: <a7177dcd027539e0fc39611b9dce6725611b6cca.1585103753.git.eswara.kota@linux.intel.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <cover.1585103753.git.eswara.kota@linux.intel.com>
References: <cover.1585103753.git.eswara.kota@linux.intel.com>
In-Reply-To: <cover.1585103753.git.eswara.kota@linux.intel.com>
References: <cover.1585103753.git.eswara.kota@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add definition for Ethernet PCS phy type.

Signed-off-by: Dilip Kota <eswara.kota@linux.intel.com>
---
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

