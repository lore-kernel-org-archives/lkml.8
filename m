Return-Path: <SRS0=ro3C=3X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70E7FC35247
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 22:37:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3DBF820720
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 22:37:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727164AbgBCWhl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Feb 2020 17:37:41 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:56231 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726331AbgBCWhl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Feb 2020 17:37:41 -0500
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <colin.king@canonical.com>)
        id 1iykLZ-0001K0-1D; Mon, 03 Feb 2020 22:37:37 +0000
From:   Colin King <colin.king@canonical.com>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Wen He <wen.he_1@nxp.com>,
        Michael Walle <michael@walle.cc>, linux-clk@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] clk: ls1028a: fix a dereference of pointer 'parent' before a null check
Date:   Mon,  3 Feb 2020 22:37:36 +0000
Message-Id: <20200203223736.99645-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Currently the pointer 'parent' is being dereferenced before it is
being null checked. Fix this by performing the null check before
it is dereferenced.

Addresses-Coverity: ("Dereference before null check")
Fixes: d37010a3c162 ("clk: ls1028a: Add clock driver for Display output interface")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/clk/clk-plldig.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/clk-plldig.c b/drivers/clk/clk-plldig.c
index a5da08f98d01..f7c349d9c2dc 100644
--- a/drivers/clk/clk-plldig.c
+++ b/drivers/clk/clk-plldig.c
@@ -187,7 +187,7 @@ static int plldig_init(struct clk_hw *hw)
 {
 	struct clk_plldig *data = to_clk_plldig(hw);
 	struct clk_hw *parent = clk_hw_get_parent(hw);
-	unsigned long parent_rate = clk_hw_get_rate(parent);
+	unsigned long parent_rate;
 	unsigned long val;
 	unsigned long long lltmp;
 	unsigned int mfd, fracdiv = 0;
@@ -195,6 +195,8 @@ static int plldig_init(struct clk_hw *hw)
 	if (!parent)
 		return -EINVAL;
 
+	parent_rate = clk_hw_get_rate(parent);
+
 	if (data->vco_freq) {
 		mfd = data->vco_freq / parent_rate;
 		lltmp = data->vco_freq % parent_rate;
-- 
2.24.0

