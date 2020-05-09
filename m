Return-Path: <SRS0=dqcu=6X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96F5AC28CBC
	for <linux-kernel@archiver.kernel.org>; Sat,  9 May 2020 09:35:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7E9E9217BA
	for <linux-kernel@archiver.kernel.org>; Sat,  9 May 2020 09:35:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728058AbgEIJfb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 May 2020 05:35:31 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:4380 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726885AbgEIJfa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 May 2020 05:35:30 -0400
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id EA937558DBD66083D1BF;
        Sat,  9 May 2020 17:35:25 +0800 (CST)
Received: from DESKTOP-8RFUVS3.china.huawei.com (10.173.222.27) by
 DGGEMS402-HUB.china.huawei.com (10.3.19.202) with Microsoft SMTP Server id
 14.3.487.0; Sat, 9 May 2020 17:35:18 +0800
From:   Zenghui Yu <yuzenghui@huawei.com>
To:     <lorenzo.pieralisi@arm.com>, <guohanjun@huawei.com>,
        <sudeep.holla@arm.com>
CC:     <rjw@rjwysocki.net>, <lenb@kernel.org>,
        <linux-acpi@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <wanghaibin.wang@huawei.com>,
        Zenghui Yu <yuzenghui@huawei.com>
Subject: [PATCH] ACPI/IORT: Remove the unused __get_pci_rid()
Date:   Sat, 9 May 2020 17:34:30 +0800
Message-ID: <20200509093430.1983-1-yuzenghui@huawei.com>
X-Mailer: git-send-email 2.23.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.173.222.27]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit bc8648d49a95 ("ACPI/IORT: Handle PCI aliases properly for
IOMMUs"), __get_pci_rid() has become actually unused and can be removed.

Signed-off-by: Zenghui Yu <yuzenghui@huawei.com>
---
 drivers/acpi/arm64/iort.c | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/drivers/acpi/arm64/iort.c b/drivers/acpi/arm64/iort.c
index 7d04424189df..ec94dbb60c7a 100644
--- a/drivers/acpi/arm64/iort.c
+++ b/drivers/acpi/arm64/iort.c
@@ -789,15 +789,6 @@ void acpi_configure_pmsi_domain(struct device *dev)
 		dev_set_msi_domain(dev, msi_domain);
 }
 
-static int __maybe_unused __get_pci_rid(struct pci_dev *pdev, u16 alias,
-					void *data)
-{
-	u32 *rid = data;
-
-	*rid = alias;
-	return 0;
-}
-
 #ifdef CONFIG_IOMMU_API
 static struct acpi_iort_node *iort_get_msi_resv_iommu(struct device *dev)
 {
-- 
2.19.1

