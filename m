Return-Path: <SRS0=y5Sx=A3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 836A6C433E6
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 06:30:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6A5982067D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 06:30:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728162AbgGPGav (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jul 2020 02:30:51 -0400
Received: from mga14.intel.com ([192.55.52.115]:24842 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728146AbgGPGat (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jul 2020 02:30:49 -0400
IronPort-SDR: 5hBZWjTGUzeR9qnNkEqaHGZZVHTOTrXwdf5gQ3jHGJ1Giqp8TYlYFjN1Io+8nHmSInxKL8Jumw
 qjTBI09CyMAQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9683"; a="148477556"
X-IronPort-AV: E=Sophos;i="5.75,358,1589266800"; 
   d="scan'208";a="148477556"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2020 23:30:48 -0700
IronPort-SDR: IXfBYcJ4VYSqSdGo8dunD4PiIUt7RfnjhdDq6U4jmS7cf+LPEc6GdkJY81Zl6enggmgV3qBMIR
 3Gl+OG+FS8hg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,358,1589266800"; 
   d="scan'208";a="269162527"
Received: from sgsxdev001.isng.intel.com (HELO localhost) ([10.226.88.11])
  by fmsmga007.fm.intel.com with ESMTP; 15 Jul 2020 23:30:46 -0700
From:   Rahul Tanwar <rahul.tanwar@linux.intel.com>
To:     sboyd@kernel.org, mturquette@baylibre.com,
        linux-clk@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, andriy.shevchenko@intel.com,
        qi-ming.wu@intel.com, yixin.zhu@linux.intel.com,
        cheol.yong.kim@intel.com, rahul.tanwar.linux@gmail.com,
        Rahul Tanwar <rahul.tanwar@linux.intel.com>
Subject: [PATCH v2 3/3] clk: intel: Avoid unnecessary memset by improving code
Date:   Thu, 16 Jul 2020 14:30:32 +0800
Message-Id: <26624b65d0e6b958c4765a406b9929d1a9ce1c2c.1594880946.git.rahul.tanwar@linux.intel.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <7ef7009b4e9f986fd6dfbf487c0e85de68a4ba9b.1594880946.git.rahul.tanwar@linux.intel.com>
References: <7ef7009b4e9f986fd6dfbf487c0e85de68a4ba9b.1594880946.git.rahul.tanwar@linux.intel.com>
In-Reply-To: <7ef7009b4e9f986fd6dfbf487c0e85de68a4ba9b.1594880946.git.rahul.tanwar@linux.intel.com>
References: <7ef7009b4e9f986fd6dfbf487c0e85de68a4ba9b.1594880946.git.rahul.tanwar@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

memset can be avoided in a loop if the variables used are declared
inside the loop. Move such variables declaration inside the loop
to avoid memset.

Signed-off-by: Rahul Tanwar <rahul.tanwar@linux.intel.com>
---
 drivers/clk/x86/clk-cgu.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/clk/x86/clk-cgu.c b/drivers/clk/x86/clk-cgu.c
index c379fedfb9f2..9a1be7035fd0 100644
--- a/drivers/clk/x86/clk-cgu.c
+++ b/drivers/clk/x86/clk-cgu.c
@@ -581,19 +581,18 @@ int lgm_clk_register_ddiv(struct lgm_clk_provider *ctx,
 			  unsigned int nr_clk)
 {
 	struct device *dev = ctx->dev;
-	struct clk_init_data init = {};
-	struct lgm_clk_ddiv *ddiv;
 	struct clk_hw *hw;
 	unsigned int idx;
 	int ret;
 
 	for (idx = 0; idx < nr_clk; idx++, list++) {
-		ddiv = NULL;
+		struct clk_init_data init = {};
+		struct lgm_clk_ddiv *ddiv = NULL;
+
 		ddiv = devm_kzalloc(dev, sizeof(*ddiv), GFP_KERNEL);
 		if (!ddiv)
 			return -ENOMEM;
 
-		memset(&init, 0, sizeof(init));
 		init.name = list->name;
 		init.ops = &lgm_clk_ddiv_ops;
 		init.flags = list->flags;
-- 
2.11.0

