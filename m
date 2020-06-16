Return-Path: <SRS0=dgGg=75=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84C5FC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 09:20:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6988C20776
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 09:20:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728125AbgFPJUe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jun 2020 05:20:34 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:55440 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726052AbgFPJUa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 05:20:30 -0400
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 0DB4DAF247A6438F2798;
        Tue, 16 Jun 2020 17:20:28 +0800 (CST)
Received: from linux-ibm.site (10.175.102.37) by
 DGGEMS409-HUB.china.huawei.com (10.3.19.209) with Microsoft SMTP Server id
 14.3.487.0; Tue, 16 Jun 2020 17:20:17 +0800
From:   Xiongfeng Wang <wangxiongfeng2@huawei.com>
To:     <rjw@rjwysocki.net>, <lenb@kernel.org>
CC:     <linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <guohanjun@huawei.com>, <wangxiongfeng2@huawei.com>
Subject: [PATCH 2/2] ACPI: sysfs: add missing newlines when printing module parameters
Date:   Tue, 16 Jun 2020 17:14:09 +0800
Message-ID: <1592298849-41530-3-git-send-email-wangxiongfeng2@huawei.com>
X-Mailer: git-send-email 1.7.12.4
In-Reply-To: <1592298849-41530-1-git-send-email-wangxiongfeng2@huawei.com>
References: <1592298849-41530-1-git-send-email-wangxiongfeng2@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.102.37]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add newlines for several module parameters printed by sysfs.

Signed-off-by: Xiongfeng Wang <wangxiongfeng2@huawei.com>
---
 drivers/acpi/sysfs.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/acpi/sysfs.c b/drivers/acpi/sysfs.c
index 3a89909..6ad142d 100644
--- a/drivers/acpi/sysfs.c
+++ b/drivers/acpi/sysfs.c
@@ -214,7 +214,7 @@ static int param_set_trace_method_name(const char *val,
 
 static int param_get_trace_method_name(char *buffer, const struct kernel_param *kp)
 {
-	return scnprintf(buffer, PAGE_SIZE, "%s", acpi_gbl_trace_method_name);
+	return scnprintf(buffer, PAGE_SIZE, "%s\n", acpi_gbl_trace_method_name);
 }
 
 static const struct kernel_param_ops param_ops_trace_method = {
@@ -271,15 +271,15 @@ static int param_set_trace_state(const char *val,
 static int param_get_trace_state(char *buffer, const struct kernel_param *kp)
 {
 	if (!(acpi_gbl_trace_flags & ACPI_TRACE_ENABLED))
-		return sprintf(buffer, "disable");
+		return sprintf(buffer, "disable\n");
 	else {
 		if (acpi_gbl_trace_method_name) {
 			if (acpi_gbl_trace_flags & ACPI_TRACE_ONESHOT)
-				return sprintf(buffer, "method-once");
+				return sprintf(buffer, "method-once\n");
 			else
-				return sprintf(buffer, "method");
+				return sprintf(buffer, "method\n");
 		} else
-			return sprintf(buffer, "enable");
+			return sprintf(buffer, "enable\n");
 	}
 	return 0;
 }
@@ -302,7 +302,7 @@ static int param_get_acpica_version(char *buffer,
 {
 	int result;
 
-	result = sprintf(buffer, "%x", ACPI_CA_VERSION);
+	result = sprintf(buffer, "%x\n", ACPI_CA_VERSION);
 
 	return result;
 }
-- 
1.7.12.4

