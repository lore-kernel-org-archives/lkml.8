Return-Path: <SRS0=QAx1=7P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB94FC433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 17:24:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AE2322068D
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 17:24:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726962AbgFBRYk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jun 2020 13:24:40 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:45762 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726630AbgFBRYj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jun 2020 13:24:39 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <colin.king@canonical.com>)
        id 1jgAeS-0006h8-08; Tue, 02 Jun 2020 17:24:36 +0000
From:   Colin King <colin.king@canonical.com>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        linux-clk@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] clk: baikal-t1: remove redundant assignment to variable 'divider'
Date:   Tue,  2 Jun 2020 18:24:35 +0100
Message-Id: <20200602172435.70282-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

The variable divider is being initialized with a value that is never read
and it is being updated later with a new value.  The initialization is
redundant and can be removed.

Addresses-Coverity: ("Unused value")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/clk/baikal-t1/ccu-div.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/baikal-t1/ccu-div.c b/drivers/clk/baikal-t1/ccu-div.c
index bd40f5936f08..4062092d67f9 100644
--- a/drivers/clk/baikal-t1/ccu-div.c
+++ b/drivers/clk/baikal-t1/ccu-div.c
@@ -248,7 +248,7 @@ static int ccu_div_var_set_rate_fast(struct clk_hw *hw, unsigned long rate,
 				     unsigned long parent_rate)
 {
 	struct ccu_div *div = to_ccu_div(hw);
-	unsigned long flags, divider = 1;
+	unsigned long flags, divider;
 	u32 val;
 
 	divider = ccu_div_var_calc_divider(rate, parent_rate, div->mask);
-- 
2.25.1

