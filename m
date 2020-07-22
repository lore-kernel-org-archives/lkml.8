Return-Path: <SRS0=5pK+=BB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B7F6C433E2
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 09:55:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 223B820714
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 09:55:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731838AbgGVJzd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jul 2020 05:55:33 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:8352 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727819AbgGVJzd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jul 2020 05:55:33 -0400
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 760F26FDE627CFC50EAB;
        Wed, 22 Jul 2020 17:55:28 +0800 (CST)
Received: from linux-ibm.site (10.175.102.37) by
 DGGEMS410-HUB.china.huawei.com (10.3.19.210) with Microsoft SMTP Server id
 14.3.487.0; Wed, 22 Jul 2020 17:55:17 +0800
From:   Hanjun Guo <guohanjun@huawei.com>
To:     Felix Kuehling <Felix.Kuehling@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
CC:     <linux-kernel@vger.kernel.org>, Hanjun Guo <guohanjun@huawei.com>
Subject: [PATCH] drm/amdkfd: Put ACPI table after using it
Date:   Wed, 22 Jul 2020 17:48:28 +0800
Message-ID: <1595411308-15654-1-git-send-email-guohanjun@huawei.com>
X-Mailer: git-send-email 1.7.12.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.102.37]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The acpi_get_table() should be coupled with acpi_put_table() if
the mapped table is not used at runtime to release the table
mapping.

In kfd_create_crat_image_acpi(), crat_table is copied to pcrat_image,
and in kfd_create_vcrat_image_cpu(), the acpi_table is only used to
get the OEM info, so those table mappings need to be release after
using it.

Signed-off-by: Hanjun Guo <guohanjun@huawei.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_crat.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
index 1009a3b..d378e61 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
@@ -756,6 +756,7 @@ int kfd_create_crat_image_acpi(void **crat_image, size_t *size)
 	struct acpi_table_header *crat_table;
 	acpi_status status;
 	void *pcrat_image;
+	int rc = 0;
 
 	if (!crat_image)
 		return -EINVAL;
@@ -776,17 +777,21 @@ int kfd_create_crat_image_acpi(void **crat_image, size_t *size)
 
 	if (ignore_crat) {
 		pr_info("CRAT table disabled by module option\n");
-		return -ENODATA;
+		rc = -ENODATA;
+		goto out;
 	}
 
 	pcrat_image = kmemdup(crat_table, crat_table->length, GFP_KERNEL);
-	if (!pcrat_image)
-		return -ENOMEM;
+	if (!pcrat_image) {
+		rc = -ENOMEM;
+		goto out;
+	}
 
 	*crat_image = pcrat_image;
 	*size = crat_table->length;
-
-	return 0;
+out:
+	acpi_put_table(crat_table);
+	return rc;
 }
 
 /* Memory required to create Virtual CRAT.
@@ -970,6 +975,7 @@ static int kfd_create_vcrat_image_cpu(void *pcrat_image, size_t *size)
 				CRAT_OEMID_LENGTH);
 		memcpy(crat_table->oem_table_id, acpi_table->oem_table_id,
 				CRAT_OEMTABLEID_LENGTH);
+		acpi_put_table(acpi_table);
 	}
 	crat_table->total_entries = 0;
 	crat_table->num_domains = 0;
-- 
1.7.12.4

