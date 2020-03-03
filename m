Return-Path: <SRS0=fZJt=4U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB951C3F2D1
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 17:53:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7D26215A4
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 17:53:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583258010;
	bh=7owaZk17bIn9LmORoSnigHfR+cQw1OAbEYXdXpklBJg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=aZ0ZdHaJmKsjZBSnSdrktk3ukAMtnAGhVhQC3r1/BuIA9V/T3mlKTpz/39+MvsOg0
	 tu8QNlNsYc5b5Qca+PfisR7E9FpJvnmfvNnYBriHzoFo1BvdAuOCo5cZScDazYg4wS
	 UdMSg4J5RiG5eBIgHjXTqqvg2qm4sB6s8Eq4/op4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732383AbgCCRx3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Mar 2020 12:53:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:33946 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732369AbgCCRx1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Mar 2020 12:53:27 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2034E2072D;
        Tue,  3 Mar 2020 17:53:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583258005;
        bh=7owaZk17bIn9LmORoSnigHfR+cQw1OAbEYXdXpklBJg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FpoV67nfaUVkL0F3+udYbB8Hg/Qd3qoBhK7ZMP+7R12VHf1wnWfWIHTfReAfeJbGA
         Y9mPFUmQr1ag1V0Th4Fd3gdB5D3zQM90+lDBW6qqxuxZJPt1QRSJEoIFWyjFT1vxYa
         Fiq4XOx5aYfYJS7bAZ73SKFioUACcHPkB0jxP7gw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Robin Murphy <robin.murphy@arm.com>,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 034/152] perf/smmuv3: Use platform_get_irq_optional() for wired interrupt
Date:   Tue,  3 Mar 2020 18:42:12 +0100
Message-Id: <20200303174306.327208240@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200303174302.523080016@linuxfoundation.org>
References: <20200303174302.523080016@linuxfoundation.org>
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
index 191f410cf35cd..2f8787276d9b8 100644
--- a/drivers/perf/arm_smmuv3_pmu.c
+++ b/drivers/perf/arm_smmuv3_pmu.c
@@ -772,7 +772,7 @@ static int smmu_pmu_probe(struct platform_device *pdev)
 		smmu_pmu->reloc_base = smmu_pmu->reg_base;
 	}
 
-	irq = platform_get_irq(pdev, 0);
+	irq = platform_get_irq_optional(pdev, 0);
 	if (irq > 0)
 		smmu_pmu->irq = irq;
 
-- 
2.20.1



