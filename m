Return-Path: <SRS0=fZJt=4U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 932CBC3F2D1
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 17:46:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 702B32146E
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 17:46:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583257574;
	bh=AoBF/zOnnLMyVG+meZIVZEnucbOTG14LwbwVcYWVL14=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Xqx6xptRer32cH/B1UPnql7e5VRa2P83qBgC5JEXZvyBYNeoLUK1NiUcrhFa7NWW8
	 axXWoKTi+m4h/iG16OwpQqVVaCz6N+Ego/FDUPbBHx5Gs+I6jhUvl1FlhrDtAA8vTM
	 IlQfRL99y6sbz9OZScVJoa5mr8SOHhzIe2BzJ9YA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731080AbgCCRqN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Mar 2020 12:46:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:52676 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727894AbgCCRqL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Mar 2020 12:46:11 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 630F9208C3;
        Tue,  3 Mar 2020 17:46:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583257570;
        bh=AoBF/zOnnLMyVG+meZIVZEnucbOTG14LwbwVcYWVL14=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QLDdVJWabhIIvQ/eG08WspCctF7QmmzxYmaOFtAlbq0DYwF3jD9Ug8eeWmgTshWcz
         hhEHAA8naT6g7aXMCBF7hhopAh0Wk9COW+mp6rIaZVg40aXabmw20+H5Iuk2pcN0b2
         fdMCBqSLMPjHv3jllgqutHoMpBpgDRMQmqHhtYyY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Robin Murphy <robin.murphy@arm.com>,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.5 038/176] perf/smmuv3: Use platform_get_irq_optional() for wired interrupt
Date:   Tue,  3 Mar 2020 18:41:42 +0100
Message-Id: <20200303174308.917792016@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200303174304.593872177@linuxfoundation.org>
References: <20200303174304.593872177@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: John Garry <john.garry@huawei.com>

[ Upstream commit 0ca2c0319a7bce0e152b51b866979d62dc261e48 ]

Even though a SMMUv3 PMCG implementation may use an MSI as the form of
interrupt source, the kernel would still complain that it does not find
the wired (GSIV) interrupt in this case:

root@(none)$ dmesg | grep arm-smmu-v3-pmcg | grep "not found"
[   59.237219] arm-smmu-v3-pmcg arm-smmu-v3-pmcg.8.auto: IRQ index 0 not found
[   59.322841] arm-smmu-v3-pmcg arm-smmu-v3-pmcg.9.auto: IRQ index 0 not found
[   59.422155] arm-smmu-v3-pmcg arm-smmu-v3-pmcg.10.auto: IRQ index 0 not found
[   59.539014] arm-smmu-v3-pmcg arm-smmu-v3-pmcg.11.auto: IRQ index 0 not found
[   59.640329] arm-smmu-v3-pmcg arm-smmu-v3-pmcg.12.auto: IRQ index 0 not found
[   59.743112] arm-smmu-v3-pmcg arm-smmu-v3-pmcg.13.auto: IRQ index 0 not found
[   59.880577] arm-smmu-v3-pmcg arm-smmu-v3-pmcg.14.auto: IRQ index 0 not found
[   60.017528] arm-smmu-v3-pmcg arm-smmu-v3-pmcg.15.auto: IRQ index 0 not found

Use platform_get_irq_optional() to silence the warning.

If neither interrupt source is found, then the driver will still warn that
IRQ setup errored and the probe will fail.

Reviewed-by: Robin Murphy <robin.murphy@arm.com>
Signed-off-by: John Garry <john.garry@huawei.com>
Signed-off-by: Will Deacon <will@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/perf/arm_smmuv3_pmu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/perf/arm_smmuv3_pmu.c b/drivers/perf/arm_smmuv3_pmu.c
index d704eccc548f6..f01a57e5a5f35 100644
--- a/drivers/perf/arm_smmuv3_pmu.c
+++ b/drivers/perf/arm_smmuv3_pmu.c
@@ -771,7 +771,7 @@ static int smmu_pmu_probe(struct platform_device *pdev)
 		smmu_pmu->reloc_base = smmu_pmu->reg_base;
 	}
 
-	irq = platform_get_irq(pdev, 0);
+	irq = platform_get_irq_optional(pdev, 0);
 	if (irq > 0)
 		smmu_pmu->irq = irq;
 
-- 
2.20.1



