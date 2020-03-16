Return-Path: <SRS0=ltrd=5B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A16DC0044D
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 20:14:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF24B20658
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 20:14:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="mVM25MR7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732524AbgCPUOw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Mar 2020 16:14:52 -0400
Received: from mail26.static.mailgun.info ([104.130.122.26]:56559 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732486AbgCPUOw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Mar 2020 16:14:52 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1584389691; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=kFghqr0ZrR/IOj3V3EhBLNTYMa8w7BS109LPhT7qitM=; b=mVM25MR7MrCCpF5gMbr0RucGbE00TlgA7Of8GixcE4cIvuPUZnfwE300fexkQ5yxDwUaTka+
 L/rQ9V+DNTPt6nh1553bznrHGgsWxd1dp5JJaDEzL0HdwYJWBQh1OjJy/RRse1V8xjfqrQBB
 CCJCD5RKFkUDj8h2hILRv5L0Tnw=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e6fde2d.7f35ca500960-smtp-out-n01;
 Mon, 16 Mar 2020 20:14:37 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 6D79DC432C2; Mon, 16 Mar 2020 20:14:37 +0000 (UTC)
Received: from mrana-linux1.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: mrana)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id B08A7C433D2;
        Mon, 16 Mar 2020 20:14:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org B08A7C433D2
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=mrana@codeaurora.org
From:   Mayank Rana <mrana@codeaurora.org>
To:     myungjoo.ham@samsung.com, cw00.choi@samsung.com
Cc:     Mayank Rana <mrana@codeaurora.org>, linux-kernel@vger.kernel.org,
        jackp@codeaurora.org
Subject: [PATCH] extcon: Mark extcon_get_edev_name() function as exported symbol
Date:   Mon, 16 Mar 2020 13:14:32 -0700
Message-Id: <1584389672-9195-1-git-send-email-mrana@codeaurora.org>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

extcon_get_edev_name() function provides client driver to request
extcon dev's name. If extcon driver and client driver are compiled
as loadable modules, extcon_get_edev_name() function symbol is not
visible to client driver. Hence mark extcon_find_edev_name() function
as exported symbol.

Signed-off-by: Mayank Rana <mrana@codeaurora.org>
---
 drivers/extcon/extcon.c | 1 +
 include/linux/extcon.h  | 5 +++++
 2 files changed, 6 insertions(+)

diff --git a/drivers/extcon/extcon.c b/drivers/extcon/extcon.c
index e055893..2dfbfec 100644
--- a/drivers/extcon/extcon.c
+++ b/drivers/extcon/extcon.c
@@ -1406,6 +1406,7 @@ const char *extcon_get_edev_name(struct extcon_dev *edev)
 {
 	return !edev ? NULL : edev->name;
 }
+EXPORT_SYMBOL_GPL(extcon_get_edev_name);
 
 static int __init extcon_class_init(void)
 {
diff --git a/include/linux/extcon.h b/include/linux/extcon.h
index 1b1d77e..fd183fb 100644
--- a/include/linux/extcon.h
+++ b/include/linux/extcon.h
@@ -286,6 +286,11 @@ static inline struct extcon_dev *extcon_get_edev_by_phandle(struct device *dev,
 {
 	return ERR_PTR(-ENODEV);
 }
+
+static inline const char *extcon_get_edev_name(struct extcon_dev *edev)
+{
+	return NULL;
+}
 #endif /* CONFIG_EXTCON */
 
 /*
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
