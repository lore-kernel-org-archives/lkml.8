Return-Path: <SRS0=faA3=B4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69E7AC433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 06:57:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4470520639
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 06:57:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726688AbgHRG5s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Aug 2020 02:57:48 -0400
Received: from mga05.intel.com ([192.55.52.43]:4412 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726590AbgHRG5p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Aug 2020 02:57:45 -0400
IronPort-SDR: f73Y/Z8NG6PbtBGZqkpvZAXohplwqRfhwSCPq9U+p8e11Xbm1+Vtu0flsvtv/kydGWe/qk/d/D
 JprWkkFAihUQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9716"; a="239677793"
X-IronPort-AV: E=Sophos;i="5.76,326,1592895600"; 
   d="scan'208";a="239677793"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2020 23:57:45 -0700
IronPort-SDR: enmSBXYiwrUo5ugLSw12B5LZtZOla0iz9hfjVDpAavsLWaaafUFxSzHhkAXASqGgCpm73cqE+T
 RMqn6RkTsk4w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,326,1592895600"; 
   d="scan'208";a="296741577"
Received: from sgsxdev004.isng.intel.com (HELO localhost) ([10.226.88.13])
  by orsmga006.jf.intel.com with ESMTP; 17 Aug 2020 23:57:42 -0700
From:   "Ramuthevar,Vadivel MuruganX" 
        <vadivel.muruganx.ramuthevar@linux.intel.com>
To:     linux-kernel@vger.kernel.org, myungjoo.ham@samsung.com,
        cw00.choi@samsung.com
Cc:     andriy.shevchenko@intel.com, thomas.langer@intel.com,
        cheol.yong.kim@intel.com, qi-ming.wu@intel.com, yin1.li@intel.com,
        Ramuthevar Vadivel Murugan 
        <vadivel.muruganx.ramuthevar@linux.intel.com>
Subject: [PATCH v1 4/9] extcon: extcon-ptn5150: Switch to BIT() for cable detach macro
Date:   Tue, 18 Aug 2020 14:57:22 +0800
Message-Id: <20200818065727.50520-5-vadivel.muruganx.ramuthevar@linux.intel.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20200818065727.50520-1-vadivel.muruganx.ramuthevar@linux.intel.com>
References: <20200818065727.50520-1-vadivel.muruganx.ramuthevar@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ramuthevar Vadivel Murugan <vadivel.muruganx.ramuthevar@linux.intel.com>

Switch to BIT() macro for the cable detach.

Signed-off-by: Ramuthevar Vadivel Murugan <vadivel.muruganx.ramuthevar@linux.intel.com>
---
 drivers/extcon/extcon-ptn5150.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/extcon/extcon-ptn5150.c b/drivers/extcon/extcon-ptn5150.c
index fab862d9aad8..50fff148b772 100644
--- a/drivers/extcon/extcon-ptn5150.c
+++ b/drivers/extcon/extcon-ptn5150.c
@@ -45,10 +45,7 @@ enum ptn5150_reg {
 #define PTN5150_REG_CC_VBUS_DETECTION		BIT(7)
 
 #define PTN5150_REG_INT_CABLE_ATTACH_MASK	BIT(0)
-
-#define PTN5150_REG_INT_CABLE_DETACH_SHIFT	1
-#define PTN5150_REG_INT_CABLE_DETACH_MASK	\
-	(0x1 << PTN5150_REG_CC_CABLE_DETACH_SHIFT)
+#define PTN5150_REG_INT_CABLE_DETACH_MASK	BIT(1)
 
 struct ptn5150_info {
 	struct device *dev;
-- 
2.11.0

