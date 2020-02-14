Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64F4BC2BA83
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 16:37:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 399E82187F
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 16:37:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581698227;
	bh=HbAn6k20+yu3zZgzeEFmtlXzxSAT9wm5pIPskitcQIo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=fAUsLLJEfw4nPgmhvDTvt6zeQ1nSuw40E9xmxQzvn3zahWUtx1Zc6pP7JrOLqt9Cy
	 H4G2raDofYQnQ5myqHn/1lprRTBvPx8byW8iA2D8UIMRGtEPoyrxYJkIPnwc3Tvb3D
	 m8rMWTqxXIMP/K9v5yHWVoh1ypqDGz9lNCrFUlts=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393760AbgBNQhG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Feb 2020 11:37:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:60566 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405784AbgBNQYB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 11:24:01 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EAB162476A;
        Fri, 14 Feb 2020 16:23:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581697440;
        bh=HbAn6k20+yu3zZgzeEFmtlXzxSAT9wm5pIPskitcQIo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fSp49Vh/i6mfPH2WxxLaGNMjXCs/DL82T/vwhR+YxSwt/8cVKTyaJzFWucWp43Ici
         zC/pLNW545Vsv/+oNLnwLaHj7698lKRxbKZ/d+4MzC44tK+BD/zZkWRRx9Rg+ssC+H
         AV+r0PVPKRadlK/5MaL2lX+t06QUnzpVSR/ndNy4=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Marc Zyngier <maz@kernel.org>, Heyi Guo <guoheyi@huawei.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.9 126/141] irqchip/gic-v3: Only provision redistributors that are enabled in ACPI
Date:   Fri, 14 Feb 2020 11:21:06 -0500
Message-Id: <20200214162122.19794-126-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200214162122.19794-1-sashal@kernel.org>
References: <20200214162122.19794-1-sashal@kernel.org>
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
index f7b8681aed3f4..2ab6060031a43 100644
--- a/drivers/irqchip/irq-gic-v3.c
+++ b/drivers/irqchip/irq-gic-v3.c
@@ -1195,6 +1195,7 @@ static struct
 	struct redist_region *redist_regs;
 	u32 nr_redist_regions;
 	bool single_redist;
+	int enabled_rdists;
 	u32 maint_irq;
 	int maint_irq_mode;
 	phys_addr_t vcpu_base;
@@ -1289,8 +1290,10 @@ static int __init gic_acpi_match_gicc(struct acpi_subtable_header *header,
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
@@ -1320,8 +1323,10 @@ static int __init gic_acpi_count_gicr_regions(void)
 
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

