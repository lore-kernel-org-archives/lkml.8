Return-Path: <SRS0=ObIu=6N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FDD8C83001
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 03:14:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E584020730
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 03:14:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726691AbgD2DO1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Apr 2020 23:14:27 -0400
Received: from mail-m17613.qiye.163.com ([59.111.176.13]:27962 "EHLO
        mail-m17613.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726560AbgD2DO0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 23:14:26 -0400
Received: from ubuntu.localdomain (unknown [157.0.31.122])
        by mail-m17613.qiye.163.com (Hmail) with ESMTPA id 52F79481854;
        Wed, 29 Apr 2020 11:14:23 +0800 (CST)
From:   Bernard Zhao <bernard@vivo.com>
To:     Neil Armstrong <narmstrong@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Kevin Hilman <khilman@baylibre.com>,
        linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     opensource.kernel@vivo.com, Bernard Zhao <bernard@vivo.com>
Subject: [PATCH] clk/meson: fixes memleak issue in init err branch
Date:   Tue, 28 Apr 2020 20:14:15 -0700
Message-Id: <20200429031416.3900-1-bernard@vivo.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgYFAkeWUFZT1VPTkpLS0tJSkhNSUhLTllXWShZQU
        hPN1dZLVlBSVdZCQ4XHghZQVk1NCk2OjckKS43PlkG
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6MC46Lyo5DTg*ME5WDTA0OSwr
        SRAaCzNVSlVKTkNDSkhLS01ITk1NVTMWGhIXVRkeCRUaCR87DRINFFUYFBZFWVdZEgtZQVlKTkxV
        S1VISlVKSUlZV1kIAVlBSUxCQjcG
X-HM-Tid: 0a71c3eda48f93bakuws52f79481854
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In common init function, when run into err branch, we didn`t
use kfree to release kzmalloc area, this may bring in memleak

Signed-off-by: Bernard Zhao <bernard@vivo.com>
---
 drivers/clk/meson/meson8b.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/meson/meson8b.c b/drivers/clk/meson/meson8b.c
index 34a70c4b4899..0f07d5a4cd16 100644
--- a/drivers/clk/meson/meson8b.c
+++ b/drivers/clk/meson/meson8b.c
@@ -3687,6 +3687,7 @@ static void __init meson8b_clkc_init_common(struct device_node *np,
 	if (ret) {
 		pr_err("%s: Failed to register clkc reset controller: %d\n",
 		       __func__, ret);
+		kfree(rstc);
 		return;
 	}
 
@@ -3710,8 +3711,10 @@ static void __init meson8b_clkc_init_common(struct device_node *np,
 			continue;
 
 		ret = of_clk_hw_register(np, clk_hw_onecell_data->hws[i]);
-		if (ret)
+		if (ret) {
+			kfree(rstc);
 			return;
+		}
 	}
 
 	meson8b_cpu_nb_data.cpu_clk = clk_hw_onecell_data->hws[CLKID_CPUCLK];
@@ -3727,13 +3730,16 @@ static void __init meson8b_clkc_init_common(struct device_node *np,
 	if (ret) {
 		pr_err("%s: failed to register the CPU clock notifier\n",
 		       __func__);
+		kfree(rstc);
 		return;
 	}
 
 	ret = of_clk_add_hw_provider(np, of_clk_hw_onecell_get,
 				     clk_hw_onecell_data);
-	if (ret)
+	if (ret) {
 		pr_err("%s: failed to register clock provider\n", __func__);
+		kfree(rstc);
+	}
 }
 
 static void __init meson8_clkc_init(struct device_node *np)
-- 
2.26.2

