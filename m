Return-Path: <SRS0=Mt+e=5P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1D71C43331
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 10:06:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7CAAC20732
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 10:06:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728843AbgC3KGW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Mar 2020 06:06:22 -0400
Received: from cmccmta2.chinamobile.com ([221.176.66.80]:3986 "EHLO
        cmccmta2.chinamobile.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728257AbgC3KGW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Mar 2020 06:06:22 -0400
Received: from spf.mail.chinamobile.com (unknown[172.16.121.17]) by rmmx-syy-dmz-app05-12005 (RichMail) with SMTP id 2ee55e81c491eb5-0eefa; Mon, 30 Mar 2020 18:06:09 +0800 (CST)
X-RM-TRANSID: 2ee55e81c491eb5-0eefa
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG: 00000000
Received: from localhost.localdomain (unknown[223.105.0.243])
        by rmsmtp-syy-appsvr09-12009 (RichMail) with SMTP id 2ee95e81c48e035-47731;
        Mon, 30 Mar 2020 18:06:09 +0800 (CST)
X-RM-TRANSID: 2ee95e81c48e035-47731
From:   Ding Xiang <dingxiang@cmss.chinamobile.com>
To:     robh+dt@kernel.org, frowand.list@gmail.com
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] of: remove unneeded variable
Date:   Mon, 30 Mar 2020 18:05:02 +0800
Message-Id: <1585562702-360-1-git-send-email-dingxiang@cmss.chinamobile.com>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

rc is unneeded, just return 0.

Signed-off-by: Ding Xiang <dingxiang@cmss.chinamobile.com>
---
 drivers/of/dynamic.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/of/dynamic.c b/drivers/of/dynamic.c
index 08fd823..fe64430 100644
--- a/drivers/of/dynamic.c
+++ b/drivers/of/dynamic.c
@@ -286,7 +286,6 @@ int of_detach_node(struct device_node *np)
 {
 	struct of_reconfig_data rd;
 	unsigned long flags;
-	int rc = 0;
 
 	memset(&rd, 0, sizeof(rd));
 	rd.dn = np;
@@ -301,7 +300,7 @@ int of_detach_node(struct device_node *np)
 
 	of_reconfig_notify(OF_RECONFIG_DETACH_NODE, &rd);
 
-	return rc;
+	return 0;
 }
 EXPORT_SYMBOL_GPL(of_detach_node);
 
-- 
1.9.1



