Return-Path: <SRS0=SnAt=4L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30D75C35671
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Feb 2020 02:33:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 08D742071E
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Feb 2020 02:33:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582425209;
	bh=7owaZk17bIn9LmORoSnigHfR+cQw1OAbEYXdXpklBJg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=oDz7gtN9R46Djf4oR+vzzJMnzlfaCsTkPj5qv7iMPNGI/Paxtn7ltMIzj0GJnYsnH
	 Q246T2ZYD8fP9A8UlM59Ve7XWV1mIYcIIRleltwV1YxZ2j/pVfMVsJ32rhBTu1L6H9
	 tQVSytS53B6+c0wV5oEZ0JfoD0TM0mF+9HauH0CE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727895AbgBWCd1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Feb 2020 21:33:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:52030 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728346AbgBWCWw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Feb 2020 21:22:52 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7679021D56;
        Sun, 23 Feb 2020 02:22:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582424572;
        bh=7owaZk17bIn9LmORoSnigHfR+cQw1OAbEYXdXpklBJg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=0J+wMWPkn8G8rKtCTmYRrifk5Sm7U90kl5uUWDiPrJjdcI32TL63Z2+qajCC72Tzd
         ul5pucBDGjirJNB/tpOa6jdE+p+hhfm3WxvDwh8411CmyfVzgIUlSUHDb0+RfURUJ0
         zrW0epau1T2AjIDuhqWQ1RHTIc0iGOm41MTZDPrY=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     John Garry <john.garry@huawei.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Will Deacon <will@kernel.org>, Sasha Levin <sashal@kernel.org>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH AUTOSEL 5.4 13/50] perf/smmuv3: Use platform_get_irq_optional() for wired interrupt
Date:   Sat, 22 Feb 2020 21:21:58 -0500
Message-Id: <20200223022235.1404-13-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200223022235.1404-1-sashal@kernel.org>
References: <20200223022235.1404-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
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

