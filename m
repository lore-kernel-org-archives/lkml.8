Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BFDDC47409
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 16:17:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4603224694
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 16:17:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581697062;
	bh=WKeqSySH9aIG09sch9PE7HMHhM0Qp6oU8B87iJeSRZo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=luWKXdcvKDKyzghow5T9OYHQUlgaTDq2xXfmqH4c0bAwAEWBXTA898OR+sDpKHUvp
	 Pi5PO4GvHGFs6Bsmb7O8S4pV2wadnwEM8WE6KCXR8z0yhUIJ9C2EWmAYjDvZFoaii8
	 RfTaTMmOtIxtWMqlKBll8EPJ6huSYtlZEbgTOC5w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404537AbgBNQRl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Feb 2020 11:17:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:47502 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404317AbgBNQQj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 11:16:39 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A33C224694;
        Fri, 14 Feb 2020 16:16:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581696998;
        bh=WKeqSySH9aIG09sch9PE7HMHhM0Qp6oU8B87iJeSRZo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=L8FHbSXARbUn9hEnqtosaIKl9wdsH95KiissZVC2rMo/3wpmuchLKUf74O4P7lUDl
         pA9YXbAZqyN47s7zUm3XkTtwsPgBFpoqtVIuUXtHmRBJq4VKT8YGehNv+3O3AtTcOL
         9VX7bwsOWkPlCvpGrrTaaMzyKulKNyGTEUA3EY64=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Marc Zyngier <maz@kernel.org>, Heyi Guo <guoheyi@huawei.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.19 231/252] irqchip/gic-v3: Only provision redistributors that are enabled in ACPI
Date:   Fri, 14 Feb 2020 11:11:26 -0500
Message-Id: <20200214161147.15842-231-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200214161147.15842-1-sashal@kernel.org>
References: <20200214161147.15842-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marc Zyngier <maz@kernel.org>

[ Upstream commit 926b5dfa6b8dc666ff398044af6906b156e1d949 ]

We currently allocate redistributor region structures for
individual redistributors when ACPI doesn't present us with
compact MMIO regions covering multiple redistributors.

It turns out that we allocate these structures even when
the redistributor is flagged as disabled by ACPI. It works
fine until someone actually tries to tarse one of these
structures, and access the corresponding MMIO region.

Instead, track the number of enabled redistributors, and
only allocate what is required. This makes sure that there
is no invalid data to misuse.

Signed-off-by: Marc Zyngier <maz@kernel.org>
Reported-by: Heyi Guo <guoheyi@huawei.com>
Tested-by: Heyi Guo <guoheyi@huawei.com>
Link: https://lore.kernel.org/r/20191216062745.63397-1-guoheyi@huawei.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/irqchip/irq-gic-v3.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
index d5912f1ec8848..ac888d7a0b00a 100644
--- a/drivers/irqchip/irq-gic-v3.c
+++ b/drivers/irqchip/irq-gic-v3.c
@@ -1347,6 +1347,7 @@ static struct
 	struct redist_region *redist_regs;
 	u32 nr_redist_regions;
 	bool single_redist;
+	int enabled_rdists;
 	u32 maint_irq;
 	int maint_irq_mode;
 	phys_addr_t vcpu_base;
@@ -1441,8 +1442,10 @@ static int __init gic_acpi_match_gicc(struct acpi_subtable_header *header,
 	 * If GICC is enabled and has valid gicr base address, then it means
 	 * GICR base is presented via GICC
 	 */
-	if ((gicc->flags & ACPI_MADT_ENABLED) && gicc->gicr_base_address)
+	if ((gicc->flags & ACPI_MADT_ENABLED) && gicc->gicr_base_address) {
+		acpi_data.enabled_rdists++;
 		return 0;
+	}
 
 	/*
 	 * It's perfectly valid firmware can pass disabled GICC entry, driver
@@ -1472,8 +1475,10 @@ static int __init gic_acpi_count_gicr_regions(void)
 
 	count = acpi_table_parse_madt(ACPI_MADT_TYPE_GENERIC_INTERRUPT,
 				      gic_acpi_match_gicc, 0);
-	if (count > 0)
+	if (count > 0) {
 		acpi_data.single_redist = true;
+		count = acpi_data.enabled_rdists;
+	}
 
 	return count;
 }
-- 
2.20.1

