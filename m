Return-Path: <SRS0=NZ+o=5N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A730C2D0ED
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Mar 2020 03:47:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A86D20717
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Mar 2020 03:47:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727151AbgC1Drq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Mar 2020 23:47:46 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:32976 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726661AbgC1Drq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Mar 2020 23:47:46 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 81677976AAF51413EE47;
        Sat, 28 Mar 2020 11:47:30 +0800 (CST)
Received: from localhost (10.173.223.234) by DGGEMS413-HUB.china.huawei.com
 (10.3.19.213) with Microsoft SMTP Server id 14.3.487.0; Sat, 28 Mar 2020
 11:47:23 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <robert.moore@intel.com>, <erik.kaneda@intel.com>,
        <rafael.j.wysocki@intel.com>, <lenb@kernel.org>
CC:     <linux-acpi@vger.kernel.org>, <devel@acpica.org>,
        <linux-kernel@vger.kernel.org>, YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH -next] ACPICA: Make acpi_protocol_lengths static
Date:   Sat, 28 Mar 2020 11:47:06 +0800
Message-ID: <20200328034706.17840-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.173.223.234]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix sparse warning:

drivers/acpi/acpica/exfield.c:25:10: warning:
 symbol 'acpi_protocol_lengths' was not declared. Should it be static?

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/acpi/acpica/exfield.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/acpica/exfield.c b/drivers/acpi/acpica/exfield.c
index e85eb31e5075..3323a2ba6a31 100644
--- a/drivers/acpi/acpica/exfield.c
+++ b/drivers/acpi/acpica/exfield.c
@@ -22,7 +22,7 @@ ACPI_MODULE_NAME("exfield")
  */
 #define ACPI_INVALID_PROTOCOL_ID        0x80
 #define ACPI_MAX_PROTOCOL_ID            0x0F
-const u8 acpi_protocol_lengths[] = {
+static const u8 acpi_protocol_lengths[] = {
 	ACPI_INVALID_PROTOCOL_ID,	/* 0 - reserved */
 	ACPI_INVALID_PROTOCOL_ID,	/* 1 - reserved */
 	0x00,			/* 2 - ATTRIB_QUICK */
-- 
2.17.1


