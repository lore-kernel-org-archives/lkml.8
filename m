Return-Path: <SRS0=fR4S=7I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10A7EC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 22:41:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E3CC8208E4
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 22:41:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392185AbgEZWlX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 May 2020 18:41:23 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:34517 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389755AbgEZWlW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 May 2020 18:41:22 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <colin.king@canonical.com>)
        id 1jdiG4-0002VP-Iz; Tue, 26 May 2020 22:41:16 +0000
From:   Colin King <colin.king@canonical.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] clk: versatile: remove redundant assignment to pointer clk
Date:   Tue, 26 May 2020 23:41:16 +0100
Message-Id: <20200526224116.63549-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

The pointer clk is being initialized with a value that is never read
and is being updated with a new value later on. The initialization
is redundant and can be removed.

Addresses-Coverity: ("Unused value")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/clk/versatile/clk-versatile.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/versatile/clk-versatile.c b/drivers/clk/versatile/clk-versatile.c
index fd54d5c0251c..8ed7a179f651 100644
--- a/drivers/clk/versatile/clk-versatile.c
+++ b/drivers/clk/versatile/clk-versatile.c
@@ -56,7 +56,7 @@ static const struct clk_icst_desc versatile_auxosc_desc __initconst = {
 static void __init cm_osc_setup(struct device_node *np,
 				const struct clk_icst_desc *desc)
 {
-	struct clk *clk = ERR_PTR(-EINVAL);
+	struct clk *clk;
 	const char *clk_name = np->name;
 	const char *parent_name;
 
-- 
2.25.1

