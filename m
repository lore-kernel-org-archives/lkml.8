Return-Path: <SRS0=ltrd=5B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40C06C10DCE
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 02:41:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 09559206EB
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 02:41:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584326473;
	bh=jM7Fews3e1MESegyezgjrz7anoNSo3IuYP4oG7HKigc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=NXoEaL14O/rVXSMECr3j8OhWUJlA5SA94obyoFPNbG0BD8zD3/sN+jCo93zIQNErX
	 BN8K//hsnzLazdVmRT16S7VUbR7own+2hdEQKEa3SN724K4TcqClpvxopXIXAo/DiJ
	 WK3uFJihl6IEHcgtQiiwoMC82MdmX9VKumxhCNXU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729841AbgCPClL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 15 Mar 2020 22:41:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:36686 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729627AbgCPCdr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Mar 2020 22:33:47 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D4BF82074E;
        Mon, 16 Mar 2020 02:33:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584326026;
        bh=jM7Fews3e1MESegyezgjrz7anoNSo3IuYP4oG7HKigc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mxLr179Nz4iiGBVtCrwbXmmq9XOLdUwTGXhrY6DiwY0j86IX2ISUf6CmIoGUSwV72
         8lPwmvWgGRLkT1NTpdpnHD3dNQ7Lqy6J2xKY0C9J4rUqNOIEZ64BeOA1Da7XQaMZam
         XUPGHW2nLYbSAwug3WOmKy2KWFQ0BQRdo9r4mwVU=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     luanshi <zhangliguang@linux.alibaba.com>,
        Will Deacon <will@kernel.org>, Sasha Levin <sashal@kernel.org>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH AUTOSEL 5.5 22/41] drivers/perf: arm_pmu_acpi: Fix incorrect checking of gicc pointer
Date:   Sun, 15 Mar 2020 22:33:00 -0400
Message-Id: <20200316023319.749-22-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200316023319.749-1-sashal@kernel.org>
References: <20200316023319.749-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
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
index acce8781c456c..f5c7a845cd7bf 100644
--- a/drivers/perf/arm_pmu_acpi.c
+++ b/drivers/perf/arm_pmu_acpi.c
@@ -24,8 +24,6 @@ static int arm_pmu_acpi_register_irq(int cpu)
 	int gsi, trigger;
 
 	gicc = acpi_cpu_get_madt_gicc(cpu);
-	if (WARN_ON(!gicc))
-		return -EINVAL;
 
 	gsi = gicc->performance_interrupt;
 
@@ -64,11 +62,10 @@ static void arm_pmu_acpi_unregister_irq(int cpu)
 	int gsi;
 
 	gicc = acpi_cpu_get_madt_gicc(cpu);
-	if (!gicc)
-		return;
 
 	gsi = gicc->performance_interrupt;
-	acpi_unregister_gsi(gsi);
+	if (gsi)
+		acpi_unregister_gsi(gsi);
 }
 
 #if IS_ENABLED(CONFIG_ARM_SPE_PMU)
-- 
2.20.1

