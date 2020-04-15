Return-Path: <SRS0=pNjS=57=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95CBCC2BB85
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 08:23:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7D02320784
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 08:23:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2635890AbgDOIXY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Apr 2020 04:23:24 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:2376 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2635867AbgDOIXS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 04:23:18 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 1DF0D655974E4098D7B1;
        Wed, 15 Apr 2020 16:23:16 +0800 (CST)
Received: from huawei.com (10.175.124.28) by DGGEMS408-HUB.china.huawei.com
 (10.3.19.208) with Microsoft SMTP Server id 14.3.487.0; Wed, 15 Apr 2020
 16:23:05 +0800
From:   Jason Yan <yanaijie@huawei.com>
To:     <robert.moore@intel.com>, <erik.kaneda@intel.com>,
        <rafael.j.wysocki@intel.com>, <lenb@kernel.org>,
        <linux-acpi@vger.kernel.org>, <devel@acpica.org>,
        <linux-kernel@vger.kernel.org>
CC:     Jason Yan <yanaijie@huawei.com>, Hulk Robot <hulkci@huawei.com>
Subject: [PATCH] ACPICA: make acpi_protocol_lengths static
Date:   Wed, 15 Apr 2020 16:49:33 +0800
Message-ID: <20200415084933.6251-1-yanaijie@huawei.com>
X-Mailer: git-send-email 2.21.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.124.28]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the following sparse warning:

drivers/acpi/acpica/exfield.c:25:10: warning: symbol
'acpi_protocol_lengths' was not declared. Should it be static?

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Jason Yan <yanaijie@huawei.com>
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
2.21.1

