Return-Path: <SRS0=kGB5=CE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A040FC433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 08:37:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 58C902071E
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 08:37:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727056AbgHZIhP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Aug 2020 04:37:15 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:36558 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726999AbgHZIhO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Aug 2020 04:37:14 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id B55F077C5FBBBBBAB866;
        Wed, 26 Aug 2020 16:37:10 +0800 (CST)
Received: from linux-ibm.site (10.175.102.37) by
 DGGEMS406-HUB.china.huawei.com (10.3.19.206) with Microsoft SMTP Server id
 14.3.487.0; Wed, 26 Aug 2020 16:37:00 +0800
From:   Hanjun Guo <guohanjun@huawei.com>
To:     Felix Kuehling <Felix.Kuehling@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
CC:     <linux-kernel@vger.kernel.org>, Hanjun Guo <guohanjun@huawei.com>
Subject: [PATCH v2 1/2] drm/amdkfd: Move the ignore_crat check before the CRAT table get
Date:   Wed, 26 Aug 2020 16:29:15 +0800
Message-ID: <1598430556-18788-1-git-send-email-guohanjun@huawei.com>
X-Mailer: git-send-email 1.7.12.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.102.37]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the ignore_crat is set to non-zero value, it's no point getting
the CRAT table, so just move the ignore_crat check before we get the
CRAT table.

Signed-off-by: Hanjun Guo <guohanjun@huawei.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_crat.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
index 6a250f8..ed77b109 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
@@ -764,6 +764,11 @@ int kfd_create_crat_image_acpi(void **crat_image, size_t *size)
 
 	*crat_image = NULL;
 
+	if (ignore_crat) {
+		pr_info("CRAT table disabled by module option\n");
+		return -ENODATA;
+	}
+
 	/* Fetch the CRAT table from ACPI */
 	status = acpi_get_table(CRAT_SIGNATURE, 0, &crat_table);
 	if (status == AE_NOT_FOUND) {
@@ -776,11 +781,6 @@ int kfd_create_crat_image_acpi(void **crat_image, size_t *size)
 		return -EINVAL;
 	}
 
-	if (ignore_crat) {
-		pr_info("CRAT table disabled by module option\n");
-		return -ENODATA;
-	}
-
 	pcrat_image = kmemdup(crat_table, crat_table->length, GFP_KERNEL);
 	if (!pcrat_image)
 		return -ENOMEM;
-- 
1.7.12.4

