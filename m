Return-Path: <SRS0=2Lxt=AV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44CE2C433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 09:28:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2B19620725
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 09:28:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727839AbgGJJ2h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jul 2020 05:28:37 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:55768 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726787AbgGJJ2f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jul 2020 05:28:35 -0400
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 0DD457E1C9EE707D370B;
        Fri, 10 Jul 2020 17:28:33 +0800 (CST)
Received: from huawei.com (10.175.104.57) by DGGEMS402-HUB.china.huawei.com
 (10.3.19.202) with Microsoft SMTP Server id 14.3.487.0; Fri, 10 Jul 2020
 17:28:26 +0800
From:   Lu Wei <luwei32@huawei.com>
To:     <alex.hung@canonical.com>, <dvhart@infradead.org>,
        <andy@infradead.org>, <platform-driver-x86@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <acelan.kao@canonical.com>,
        <andy.shevchenko@gmail.com>, <luwei32@huawei.com>
Subject: [PATCH v3 1/2] intel-hid: Fix return value check in check_acpi_dev()
Date:   Fri, 10 Jul 2020 17:30:17 +0800
Message-ID: <1594373418-24833-2-git-send-email-luwei32@huawei.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1594373418-24833-1-git-send-email-luwei32@huawei.com>
References: <1594373418-24833-1-git-send-email-luwei32@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.104.57]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the function check_acpi_dev(), if it fails to create
platform device, the return value is ERR_PTR() or NULL.
Thus it must use IS_ERR_OR_NULL to check return value.

Fixes: ecc83e52b28c ("intel-hid: new hid event driver for hotkeys")
Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Lu Wei <luwei32@huawei.com>
---

 drivers/platform/x86/intel-hid.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/platform/x86/intel-hid.c b/drivers/platform/x86/intel-hid.c
index cc7dd4d..c45250c 100644
--- a/drivers/platform/x86/intel-hid.c
+++ b/drivers/platform/x86/intel-hid.c
@@ -564,7 +564,7 @@ check_acpi_dev(acpi_handle handle, u32 lvl, void *context, void **rv)
 		return AE_OK;

 	if (acpi_match_device_ids(dev, ids) == 0)
-		if (acpi_create_platform_device(dev, NULL))
+		if (!IS_ERR_OR_NULL(acpi_create_platform_device(dev, NULL)))
 			dev_info(&dev->dev,
 				 "intel-hid: created platform device\n");

--
2.7.4

