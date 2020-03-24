Return-Path: <SRS0=tn8d=5J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75F8EC43331
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 13:13:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C32C208E4
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 13:13:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585055638;
	bh=2hY2yy0nVV7zzzENxHxzh6cBEDGz8r3oejDRBC2kBmU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=pVhHRHmYtoBQnyzof0hXCfS9WyfEfuRgnsY9vWxEzkcEwjfWevTfoHNGt/NKL+McT
	 4uENHTikyCW13SMlapQX6FeMy1wlYQ1jk55PZGYa5dnm34JkNENjFTA57DvIwYYjsc
	 YYKeeUz99S8aIqva9zzy0twDxZtQJ3kDEtomL/z8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727969AbgCXNN4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Mar 2020 09:13:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:60286 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727314AbgCXNNx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 09:13:53 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2D7B920B1F;
        Tue, 24 Mar 2020 13:13:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585055633;
        bh=2hY2yy0nVV7zzzENxHxzh6cBEDGz8r3oejDRBC2kBmU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YAtEBASNZL5d8YzCA35GR0duvIh4iLbggiBLof4Uttsurs6IV4a1QEX82M5vHXkNW
         laiYhV7t5VusVbeXefkSKqfkUBKuIKRlblP2tuzd0NtQnX48538o14XL5Ve54j7jTh
         Pu6Wq2l61YuDbjn9ER2QmU3XHYtiZ7YQHU2Do3ho=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Liguang Zhang <zhangliguang@linux.alibaba.com>,
        Will Deacon <will@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 09/65] drivers/perf: arm_pmu_acpi: Fix incorrect checking of gicc pointer
Date:   Tue, 24 Mar 2020 14:10:30 +0100
Message-Id: <20200324130757.904549373@linuxfoundation.org>
X-Mailer: git-send-email 2.25.2
In-Reply-To: <20200324130756.679112147@linuxfoundation.org>
References: <20200324130756.679112147@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: luanshi <zhangliguang@linux.alibaba.com>

[ Upstream commit 3ba52ad55b533760a1f65836aa0ec9d35e36bb4f ]

Fix bogus NULL checks on the return value of acpi_cpu_get_madt_gicc()
by checking for a 0 'gicc->performance_interrupt' value instead.

Signed-off-by: Liguang Zhang <zhangliguang@linux.alibaba.com>
Signed-off-by: Will Deacon <will@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/perf/arm_pmu_acpi.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/perf/arm_pmu_acpi.c b/drivers/perf/arm_pmu_acpi.c
index 0f197516d7089..9a6f7f822566f 100644
--- a/drivers/perf/arm_pmu_acpi.c
+++ b/drivers/perf/arm_pmu_acpi.c
@@ -27,8 +27,6 @@ static int arm_pmu_acpi_register_irq(int cpu)
 	int gsi, trigger;
 
 	gicc = acpi_cpu_get_madt_gicc(cpu);
-	if (WARN_ON(!gicc))
-		return -EINVAL;
 
 	gsi = gicc->performance_interrupt;
 
@@ -67,11 +65,10 @@ static void arm_pmu_acpi_unregister_irq(int cpu)
 	int gsi;
 
 	gicc = acpi_cpu_get_madt_gicc(cpu);
-	if (!gicc)
-		return;
 
 	gsi = gicc->performance_interrupt;
-	acpi_unregister_gsi(gsi);
+	if (gsi)
+		acpi_unregister_gsi(gsi);
 }
 
 static int arm_pmu_acpi_parse_irqs(void)
-- 
2.20.1



