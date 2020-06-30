Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F431C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 00:30:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F2AF920781
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 00:30:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="qpX4P9Gh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728721AbgF3Aa6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 20:30:58 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:50175 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728514AbgF3Aa5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 20:30:57 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1593477056; h=Content-Transfer-Encoding: MIME-Version:
 Message-Id: Date: Subject: Cc: To: From: Sender;
 bh=YGZplpevsAJGqU+ves7XOl3Kq4U+OLQbZO9OWSW49L4=; b=qpX4P9Gh5OkYtb3R9AsBj6nDFNxnyjGSN4pHVzOuZXVozG2+c9wqbtq7LENRfAt38yFYzXch
 XTzxPPETZRUT1bRee36gXJ8/eMQ/NDbOLnPbOKIVifROaooyrnLv6fOWGvO3Kzc8dzE9HuhQ
 MV2uuEa7TtzWNZpL1lY4eeFiCmE=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n01.prod.us-east-1.postgun.com with SMTP id
 5efa87baa6e154319f357ad5 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 30 Jun 2020 00:30:50
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id A2745C433AD; Tue, 30 Jun 2020 00:30:49 +0000 (UTC)
Received: from mdtipton-linux.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: mdtipton)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id F111FC433C6;
        Tue, 30 Jun 2020 00:30:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org F111FC433C6
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=mdtipton@codeaurora.org
From:   Mike Tipton <mdtipton@codeaurora.org>
To:     sboyd@kernel.org, mturquette@baylibre.com
Cc:     linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        tdas@codeaurora.org, Mike Tipton <mdtipton@codeaurora.org>
Subject: [PATCH] clk: Add support for enabling/disabling clocks from debugfs
Date:   Mon, 29 Jun 2020 17:30:24 -0700
Message-Id: <20200630003024.6282-1-mdtipton@codeaurora.org>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For test and debug purposes, it's often necessary to enable or disable
clocks from shell. Add a new debugfs file (clk_prepare_enable) that
calls clk_prepare_enable() when writing "1" and clk_disable_unprepare()
when writing "0".

This can have security implications, so only support it when the code
has been modified to #define CLOCK_ALLOW_WRITE_DEBUGS.

Signed-off-by: Mike Tipton <mdtipton@codeaurora.org>
---
 drivers/clk/clk.c | 38 ++++++++++++++++++++++++++++++++++----
 1 file changed, 34 insertions(+), 4 deletions(-)

diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
index 236923b25543..3640bbc56870 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -3034,13 +3034,14 @@ static int clk_dump_show(struct seq_file *s, void *data)
 }
 DEFINE_SHOW_ATTRIBUTE(clk_dump);
 
-#undef CLOCK_ALLOW_WRITE_DEBUGFS
-#ifdef CLOCK_ALLOW_WRITE_DEBUGFS
 /*
- * This can be dangerous, therefore don't provide any real compile time
- * configuration option for this feature.
+ * These features can be dangerous, therefore don't provide any real compile
+ * time configuration option for them.
  * People who want to use this will need to modify the source code directly.
  */
+#undef CLOCK_ALLOW_WRITE_DEBUGFS
+#ifdef CLOCK_ALLOW_WRITE_DEBUGFS
+
 static int clk_rate_set(void *data, u64 val)
 {
 	struct clk_core *core = data;
@@ -3054,6 +3055,31 @@ static int clk_rate_set(void *data, u64 val)
 }
 
 #define clk_rate_mode	0644
+
+static int clk_prepare_enable_set(void *data, u64 val)
+{
+	struct clk_core *core = data;
+	int ret = 0;
+
+	if (val)
+		ret = clk_prepare_enable(core->hw->clk);
+	else
+		clk_disable_unprepare(core->hw->clk);
+
+	return ret;
+}
+
+static int clk_prepare_enable_get(void *data, u64 *val)
+{
+	struct clk_core *core = data;
+
+	*val = core->enable_count && core->prepare_count;
+	return 0;
+}
+
+DEFINE_DEBUGFS_ATTRIBUTE(clk_prepare_enable_fops, clk_prepare_enable_get,
+			 clk_prepare_enable_set, "%llu\n");
+
 #else
 #define clk_rate_set	NULL
 #define clk_rate_mode	0444
@@ -3231,6 +3257,10 @@ static void clk_debug_create_one(struct clk_core *core, struct dentry *pdentry)
 	debugfs_create_u32("clk_notifier_count", 0444, root, &core->notifier_count);
 	debugfs_create_file("clk_duty_cycle", 0444, root, core,
 			    &clk_duty_cycle_fops);
+#ifdef CLOCK_ALLOW_WRITE_DEBUGFS
+	debugfs_create_file("clk_prepare_enable", 0644, root, core,
+			    &clk_prepare_enable_fops);
+#endif
 
 	if (core->num_parents > 0)
 		debugfs_create_file("clk_parent", 0444, root, core,
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

