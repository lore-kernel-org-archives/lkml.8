Return-Path: <SRS0=QAx1=7P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F6F2C433E1
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 12:10:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 308DE205CB
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 12:10:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727769AbgFBMKg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jun 2020 08:10:36 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:33283 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725921AbgFBMKf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jun 2020 08:10:35 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <colin.king@canonical.com>)
        id 1jg5kV-00033L-08; Tue, 02 Jun 2020 12:10:31 +0000
From:   Colin King <colin.king@canonical.com>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org
Subject: [PATCH][next] clk: baikal-t1: fix spelling mistake "Uncompatible" -> "Incompatible"
Date:   Tue,  2 Jun 2020 13:10:30 +0100
Message-Id: <20200602121030.39132-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

There is a spelling mistake in a pr_err error message. Fix it.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/clk/baikal-t1/clk-ccu-div.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/baikal-t1/clk-ccu-div.c b/drivers/clk/baikal-t1/clk-ccu-div.c
index b479156e5e9b..f141fda12b09 100644
--- a/drivers/clk/baikal-t1/clk-ccu-div.c
+++ b/drivers/clk/baikal-t1/clk-ccu-div.c
@@ -316,7 +316,7 @@ static struct ccu_div_data *ccu_div_create_data(struct device_node *np)
 		data->rst_num = ARRAY_SIZE(sys_rst_map);
 		data->rst_map = sys_rst_map;
 	} else {
-		pr_err("Uncompatible DT node '%s' specified\n",
+		pr_err("Incompatible DT node '%s' specified\n",
 			of_node_full_name(np));
 		ret = -EINVAL;
 		goto err_kfree_data;
-- 
2.25.1

