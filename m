Return-Path: <SRS0=GvTR=3A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61146C33CA3
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jan 2020 10:31:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E0DD2146E
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jan 2020 10:31:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578738670;
	bh=iHG4J45p5lrv/0wCGpDECBEmG+GyhGGCV0bLDnMTYL4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Q5vAyMkK39c+qYBSNxWjy60BXqozI5GJ3Wk4HM8pPOf3feLffPJQlaQBwdZ/IOIeR
	 hn0qO0L5nY7hf7nnSmXEoigvlz6q+7J4+wmH7d+6jxxbJYqN62j/R5DKxMKGD/d/Dk
	 XgBoF8p6LtQ2CLfb6+Pmxjtx1DQo90jbK6CApm0w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731509AbgAKKbJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Jan 2020 05:31:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:42386 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728905AbgAKKbH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Jan 2020 05:31:07 -0500
Received: from localhost (unknown [62.119.166.9])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1B6CB20880;
        Sat, 11 Jan 2020 10:31:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578738667;
        bh=iHG4J45p5lrv/0wCGpDECBEmG+GyhGGCV0bLDnMTYL4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ysZ6KUsFgen3EPK7NxM9LDIO7Y4coN6OK+rzVNY7+GXCS+PIzAuVxKT1ueqmLk/vS
         3wLz9wa4SSV0xARQCGtMAatjzobOk/B1N7ffltIQwDoBJz8wrp31eHIAUNPa/0IyUO
         OfXnyiAWjYE9CAE4jpEHfH/6BDIIod+WooviQL6o=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Robin Murphy <robin.murphy@arm.com>,
        Will Deacon <will@kernel.org>,
        Hanjun Guo <guohanjun@huawei.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 106/165] perf/smmuv3: Remove the leftover put_cpu() in error path
Date:   Sat, 11 Jan 2020 10:50:25 +0100
Message-Id: <20200111094930.982724766@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200111094921.347491861@linuxfoundation.org>
References: <20200111094921.347491861@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hanjun Guo <guohanjun@huawei.com>

[ Upstream commit 8ae4bcf4821c18a8fbfa0b2c1df26c1085e9d923 ]

In smmu_pmu_probe(), there is put_cpu() in the error path,
which is wrong because we use raw_smp_processor_id() to
get the cpu ID, not get_cpu(), remove it.

While we are at it, kill 'out_cpuhp_err' altogether and
just return err if we fail to add the hotplug instance.

Acked-by: Robin Murphy <robin.murphy@arm.com>
Acked-by: Will Deacon <will@kernel.org>
Signed-off-by: Hanjun Guo <guohanjun@huawei.com>
Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/perf/arm_smmuv3_pmu.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/perf/arm_smmuv3_pmu.c b/drivers/perf/arm_smmuv3_pmu.c
index abcf54f7d19c..191f410cf35c 100644
--- a/drivers/perf/arm_smmuv3_pmu.c
+++ b/drivers/perf/arm_smmuv3_pmu.c
@@ -815,7 +815,7 @@ static int smmu_pmu_probe(struct platform_device *pdev)
 	if (err) {
 		dev_err(dev, "Error %d registering hotplug, PMU @%pa\n",
 			err, &res_0->start);
-		goto out_cpuhp_err;
+		return err;
 	}
 
 	err = perf_pmu_register(&smmu_pmu->pmu, name, -1);
@@ -834,8 +834,6 @@ static int smmu_pmu_probe(struct platform_device *pdev)
 
 out_unregister:
 	cpuhp_state_remove_instance_nocalls(cpuhp_state_num, &smmu_pmu->node);
-out_cpuhp_err:
-	put_cpu();
 	return err;
 }
 
-- 
2.20.1



