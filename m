Return-Path: <SRS0=2Lxt=AV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44D95C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 09:44:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 23943206F4
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 09:44:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726920AbgGJJoj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jul 2020 05:44:39 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:50678 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726664AbgGJJoj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jul 2020 05:44:39 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 03EB55182AF4C852C05C;
        Fri, 10 Jul 2020 17:44:38 +0800 (CST)
Received: from DESKTOP-KKJBAGG.china.huawei.com (10.174.186.75) by
 DGGEMS413-HUB.china.huawei.com (10.3.19.213) with Microsoft SMTP Server id
 14.3.487.0; Fri, 10 Jul 2020 17:44:29 +0800
From:   Zhenyu Ye <yezhenyu2@huawei.com>
To:     <catalin.marinas@arm.com>, <will@kernel.org>,
        <suzuki.poulose@arm.com>, <maz@kernel.org>, <steven.price@arm.com>,
        <guohanjun@huawei.com>, <olof@lixom.net>
CC:     <yezhenyu2@huawei.com>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-arch@vger.kernel.org>,
        <linux-mm@kvack.org>, <arm@kernel.org>, <xiexiangyou@huawei.com>,
        <prime.zeng@hisilicon.com>, <zhangshaokun@hisilicon.com>,
        <kuhn.chenqun@huawei.com>
Subject: [PATCH v2 0/2] arm64: tlb: add support for TLBI RANGE instructions
Date:   Fri, 10 Jul 2020 17:44:18 +0800
Message-ID: <20200710094420.517-1-yezhenyu2@huawei.com>
X-Mailer: git-send-email 2.22.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.174.186.75]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

NOTICE: this series are based on the arm64 for-next/tlbi branch:
git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-next/tlbi

--
ARMv8.4-TLBI provides TLBI invalidation instruction that apply to a
range of input addresses. This series add support for this feature.

--
ChangeList:
v2:
- remove the __tlbi_last_level() macro.
- add check for parameters in __TLBI_VADDR_RANGE macro.

RFC patches:
- Link: https://lore.kernel.org/linux-arm-kernel/20200708124031.1414-1-yezhenyu2@huawei.com/

Zhenyu Ye (2):
  arm64: tlb: Detect the ARMv8.4 TLBI RANGE feature
  arm64: tlb: Use the TLBI RANGE feature in arm64

 arch/arm64/include/asm/cpucaps.h  |   3 +-
 arch/arm64/include/asm/sysreg.h   |   3 +
 arch/arm64/include/asm/tlbflush.h | 138 +++++++++++++++++++++++-------
 arch/arm64/kernel/cpufeature.c    |  10 +++
 4 files changed, 124 insertions(+), 30 deletions(-)

-- 
2.19.1


