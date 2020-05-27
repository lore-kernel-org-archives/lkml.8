Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E67C1C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 01:01:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C682620888
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 01:01:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590541264;
	bh=wGQJIPZAKWK2xPvtTcKd1UuwUntCA2nsRt2k35SxbjI=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=f6gQ/wI4OZGXaXQIfRfWlc++mpf/0E5Lxun88jsJhpFuxFOqHwYdM3NcOlrEMOuia
	 fQKTfwnLaAv1NNa4kG4T2mzdNhPmD+j9LcSLV75X/mqD08Gob5iOiq9Dg4A/7h2i5e
	 z6LdQi7eeWVJan7IabKATzu3qAkYkwYtQ4iqmMJY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727072AbgE0BBE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 May 2020 21:01:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:60916 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727906AbgE0BA6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 May 2020 21:00:58 -0400
Received: from mail.kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 97D9D20888;
        Wed, 27 May 2020 01:00:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590541257;
        bh=wGQJIPZAKWK2xPvtTcKd1UuwUntCA2nsRt2k35SxbjI=;
        h=From:To:Cc:Subject:Date:From;
        b=qy/fdoBlUxMwAIlmlNWCFWc5HxjEjJaLY4Qfify10DipEjc11cuWqrlTLJ+z+2wcw
         UlEvw5UXS1rPPQVPcipGR+v3Ha7OWvgyGjDDk2osc2QpTMNaBPWWvcKcYbPQy2GQJZ
         qSr/NSQ6Ka18VqtPAXQm23xcZq9s3D8MDPlfGWBw=
From:   Stephen Boyd <sboyd@kernel.org>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        Jolly Shah <jolly.shah@xilinx.com>
Subject: [PATCH] clk: zynqmp: Mark zynqmp_clk_get_max_divisor() static
Date:   Tue, 26 May 2020 18:00:57 -0700
Message-Id: <20200527010057.57877-1-sboyd@kernel.org>
X-Mailer: git-send-email 2.27.0.rc0.183.gde8f92d652-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This function isn't used outside this file. Mark it static to silence
sparse.

Cc: Jolly Shah <jolly.shah@xilinx.com>
Signed-off-by: Stephen Boyd <sboyd@kernel.org>
---
 drivers/clk/zynqmp/divider.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/zynqmp/divider.c b/drivers/clk/zynqmp/divider.c
index 79a294488e84..b22ca33e40c0 100644
--- a/drivers/clk/zynqmp/divider.c
+++ b/drivers/clk/zynqmp/divider.c
@@ -266,7 +266,7 @@ static const struct clk_ops zynqmp_clk_divider_ops = {
  * Return: Maximum divisor of a clock if query data is successful
  *	   U16_MAX in case of query data is not success
  */
-u32 zynqmp_clk_get_max_divisor(u32 clk_id, u32 type)
+static u32 zynqmp_clk_get_max_divisor(u32 clk_id, u32 type)
 {
 	const struct zynqmp_eemi_ops *eemi_ops = zynqmp_pm_get_eemi_ops();
 	struct zynqmp_pm_query_data qdata = {0};

base-commit: 2ce7e495dab4647055f6cf300bc66870dc8a7cab
-- 
Sent by a computer, using git, on the internet

