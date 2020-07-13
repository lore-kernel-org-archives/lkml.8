Return-Path: <SRS0=gGKB=AY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E66A3C433F7
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 15:59:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BE2FC2084C
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 15:59:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730319AbgGMP7f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jul 2020 11:59:35 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:2467 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730221AbgGMP7e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jul 2020 11:59:34 -0400
Received: from lhreml710-chm.china.huawei.com (unknown [172.18.7.106])
        by Forcepoint Email with ESMTP id ABC87638E661CC79765E;
        Mon, 13 Jul 2020 16:59:33 +0100 (IST)
Received: from lhrphicprd00229.huawei.com (10.123.41.22) by
 lhreml710-chm.china.huawei.com (10.201.108.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1913.5; Mon, 13 Jul 2020 16:59:33 +0100
From:   Jonathan Cameron <Jonathan.Cameron@huawei.com>
To:     <linux-mm@kvack.org>, <linux-acpi@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <x86@kernel.org>
CC:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>, <rafael@kernel.org>,
        <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>, <linuxarm@huawei.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Brice Goglin <Brice.Goglin@inria.fr>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v7 4/6] ACPI: HMAT: Fix handling of changes from ACPI 6.2 to ACPI 6.3
Date:   Mon, 13 Jul 2020 23:55:58 +0800
Message-ID: <20200713155600.2272743-5-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20200713155600.2272743-1-Jonathan.Cameron@huawei.com>
References: <20200713155600.2272743-1-Jonathan.Cameron@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.123.41.22]
X-ClientProxiedBy: lhreml745-chm.china.huawei.com (10.201.108.195) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In ACPI 6.3, the Memory Proximity Domain Attributes Structure
changed substantially.  One of those changes was that the flag
for "Memory Proximity Domain field is valid" was deprecated.

This was because the field "Proximity Domain for the Memory"
became a required field and hence having a validity flag makes
no sense.

So the correct logic is to always assume the field is there.
Current code assumes it never is.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/acpi/numa/hmat.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/numa/hmat.c b/drivers/acpi/numa/hmat.c
index 3c0414816772..7ad2d5882a7d 100644
--- a/drivers/acpi/numa/hmat.c
+++ b/drivers/acpi/numa/hmat.c
@@ -424,7 +424,7 @@ static int __init hmat_parse_proximity_domain(union acpi_subtable_headers *heade
 		pr_info("HMAT: Memory Flags:%04x Processor Domain:%u Memory Domain:%u\n",
 			p->flags, p->processor_PD, p->memory_PD);
 
-	if (p->flags & ACPI_HMAT_MEMORY_PD_VALID && hmat_revision == 1) {
+	if ((p->flags & ACPI_HMAT_MEMORY_PD_VALID && hmat_revision == 1) || hmat_revision == 2) {
 		target = find_mem_target(p->memory_PD);
 		if (!target) {
 			pr_debug("HMAT: Memory Domain missing from SRAT\n");
-- 
2.19.1

