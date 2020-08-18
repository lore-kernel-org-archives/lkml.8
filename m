Return-Path: <SRS0=faA3=B4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80A68C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 06:57:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5FB642075B
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 06:57:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726673AbgHRG5o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Aug 2020 02:57:44 -0400
Received: from mga18.intel.com ([134.134.136.126]:54543 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726590AbgHRG5m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Aug 2020 02:57:42 -0400
IronPort-SDR: cVL5Nf+J0tNr4prb0QSDdkaThRoCGUwIk3KBJ5NLzOM0Nl03UN/17iA9fHszrw8RPSyDBPhs7R
 J2IE06lJ7Yxw==
X-IronPort-AV: E=McAfee;i="6000,8403,9716"; a="142480939"
X-IronPort-AV: E=Sophos;i="5.76,326,1592895600"; 
   d="scan'208";a="142480939"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2020 23:57:41 -0700
IronPort-SDR: OKsPklPW3i6XarwNKIN6IbyYmjAXrqyVgQCViEljuHt9nmbEz7I4QbGO3arhrhgXwjYRlrqu6V
 cgkAYvNbhH1g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,326,1592895600"; 
   d="scan'208";a="497277485"
Received: from sgsxdev004.isng.intel.com (HELO localhost) ([10.226.88.13])
  by fmsmga005.fm.intel.com with ESMTP; 17 Aug 2020 23:57:38 -0700
From:   "Ramuthevar,Vadivel MuruganX" 
        <vadivel.muruganx.ramuthevar@linux.intel.com>
To:     linux-kernel@vger.kernel.org, myungjoo.ham@samsung.com,
        cw00.choi@samsung.com
Cc:     andriy.shevchenko@intel.com, thomas.langer@intel.com,
        cheol.yong.kim@intel.com, qi-ming.wu@intel.com, yin1.li@intel.com,
        Ramuthevar Vadivel Murugan 
        <vadivel.muruganx.ramuthevar@linux.intel.com>
Subject: [PATCH v1 3/9] extcon: extcon-ptn5150: Switch to BIT() macro for cable attach
Date:   Tue, 18 Aug 2020 14:57:21 +0800
Message-Id: <20200818065727.50520-4-vadivel.muruganx.ramuthevar@linux.intel.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20200818065727.50520-1-vadivel.muruganx.ramuthevar@linux.intel.com>
References: <20200818065727.50520-1-vadivel.muruganx.ramuthevar@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ramuthevar Vadivel Murugan <vadivel.muruganx.ramuthevar@linux.intel.com>

Switch to BIT() macro for the cable attach.

Signed-off-by: Ramuthevar Vadivel Murugan <vadivel.muruganx.ramuthevar@linux.intel.com>
---
 drivers/extcon/extcon-ptn5150.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/extcon/extcon-ptn5150.c b/drivers/extcon/extcon-ptn5150.c
index c816a6c1e05c..fab862d9aad8 100644
--- a/drivers/extcon/extcon-ptn5150.c
+++ b/drivers/extcon/extcon-ptn5150.c
@@ -44,9 +44,7 @@ enum ptn5150_reg {
 
 #define PTN5150_REG_CC_VBUS_DETECTION		BIT(7)
 
-#define PTN5150_REG_INT_CABLE_ATTACH_SHIFT	0
-#define PTN5150_REG_INT_CABLE_ATTACH_MASK	\
-	(0x1 << PTN5150_REG_INT_CABLE_ATTACH_SHIFT)
+#define PTN5150_REG_INT_CABLE_ATTACH_MASK	BIT(0)
 
 #define PTN5150_REG_INT_CABLE_DETACH_SHIFT	1
 #define PTN5150_REG_INT_CABLE_DETACH_MASK	\
-- 
2.11.0

