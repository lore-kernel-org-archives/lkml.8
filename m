Return-Path: <SRS0=Oudi=B7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D7A9C433E3
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 13:58:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3AA8E20720
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 13:58:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728803AbgHUN6b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Aug 2020 09:58:31 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:10303 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728723AbgHUN6S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Aug 2020 09:58:18 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 1382B9333EB0FF14B947;
        Fri, 21 Aug 2020 21:58:15 +0800 (CST)
Received: from localhost.localdomain (10.69.192.58) by
 DGGEMS411-HUB.china.huawei.com (10.3.19.211) with Microsoft SMTP Server id
 14.3.487.0; Fri, 21 Aug 2020 21:58:04 +0800
From:   John Garry <john.garry@huawei.com>
To:     <will@kernel.org>, <robin.murphy@arm.com>
CC:     <joro@8bytes.org>, <linux-arm-kernel@lists.infradead.org>,
        <iommu@lists.linux-foundation.org>, <maz@kernel.org>,
        <linuxarm@huawei.com>, <linux-kernel@vger.kernel.org>,
        John Garry <john.garry@huawei.com>
Subject: [PATCH v2 0/2] iommu/arm-smmu-v3: Improve cmdq lock efficiency
Date:   Fri, 21 Aug 2020 21:54:20 +0800
Message-ID: <1598018062-175608-1-git-send-email-john.garry@huawei.com>
X-Mailer: git-send-email 2.8.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.58]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As mentioned in [0], the CPU may consume many cycles processing
arm_smmu_cmdq_issue_cmdlist(). One issue we find is the cmpxchg() loop to
get space on the queue takes a lot of time once we start getting many
CPUs contending - from experiment, for 64 CPUs contending the cmdq,
success rate is ~ 1 in 12, which is poor, but not totally awful.

This series removes that cmpxchg() and replaces with an atomic_add,
same as how the actual cmdq deals with maintaining the prod pointer.

For my NVMe test with 3x NVMe SSDs, I'm getting a ~24% throughput
increase:
Before: 1250K IOPs
After: 1550K IOPs

I also have a test harness to check the rate of DMA map+unmaps we can
achieve:

CPU count	8	16	32	64
Before:		282K	115K	36K	11K
After:		302K	193K	80K	30K

(unit is map+unmaps per CPU per second)

[0] https://lore.kernel.org/linux-iommu/B926444035E5E2439431908E3842AFD24B86DB@DGGEMI525-MBS.china.huawei.com/T/#ma02e301c38c3e94b7725e685757c27e39c7cbde3

Differences to v1:
- Simplify by dropping patch to always issue a CMD_SYNC
- Use 64b atomic add, keeping prod in a separate 32b field

John Garry (2):
  iommu/arm-smmu-v3: Calculate max commands per batch
  iommu/arm-smmu-v3: Remove cmpxchg() in arm_smmu_cmdq_issue_cmdlist()

 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 166 ++++++++++++++------
 1 file changed, 114 insertions(+), 52 deletions(-)

-- 
2.26.2

