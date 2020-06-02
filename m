Return-Path: <SRS0=QAx1=7P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F748C433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 04:57:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3705D206C3
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 04:57:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726569AbgFBE5V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jun 2020 00:57:21 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:5837 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726260AbgFBE5V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jun 2020 00:57:21 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 3ED267344A69E034F02C;
        Tue,  2 Jun 2020 12:57:18 +0800 (CST)
Received: from SWX921481.china.huawei.com (10.126.201.14) by
 DGGEMS401-HUB.china.huawei.com (10.3.19.201) with Microsoft SMTP Server id
 14.3.487.0; Tue, 2 Jun 2020 12:57:10 +0800
From:   Barry Song <song.bao.hua@hisilicon.com>
To:     <gregkh@linuxfoundation.org>, <rafael@kernel.org>
CC:     <linux-kernel@vger.kernel.org>,
        Barry Song <song.bao.hua@hisilicon.com>
Subject: [PATCH v2] driver core: platform: need consistent spacing around '-'
Date:   Tue, 2 Jun 2020 16:55:56 +1200
Message-ID: <20200602045556.66948-1-song.bao.hua@hisilicon.com>
X-Mailer: git-send-email 2.21.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.126.201.14]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the below checkpatch issue:

ERROR: need consistent spacing around '-' (ctx:WxV)
FILE: drivers/base/platform.c:1008:
+       len = acpi_device_modalias(dev, buf, PAGE_SIZE -1);
                                                       ^

Signed-off-by: Barry Song <song.bao.hua@hisilicon.com>
---
 -v2:  specify a description of the patch in the email body

 drivers/base/platform.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/base/platform.c b/drivers/base/platform.c
index b27d0f6c18c9..ab9408182a0d 100644
--- a/drivers/base/platform.c
+++ b/drivers/base/platform.c
@@ -1005,7 +1005,7 @@ static ssize_t modalias_show(struct device *dev, struct device_attribute *a,
 	if (len != -ENODEV)
 		return len;
 
-	len = acpi_device_modalias(dev, buf, PAGE_SIZE -1);
+	len = acpi_device_modalias(dev, buf, PAGE_SIZE - 1);
 	if (len != -ENODEV)
 		return len;
 
-- 
2.23.0


