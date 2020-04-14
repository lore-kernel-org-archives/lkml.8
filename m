Return-Path: <SRS0=4xmc=56=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D5CDC2BA19
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 11:31:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6402D206D5
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 11:31:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439194AbgDNLa6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Apr 2020 07:30:58 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:2315 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2439124AbgDNL3E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 07:29:04 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 44DE362D7C198D4FE206;
        Tue, 14 Apr 2020 19:28:57 +0800 (CST)
Received: from DESKTOP-KKJBAGG.china.huawei.com (10.173.220.25) by
 DGGEMS408-HUB.china.huawei.com (10.3.19.208) with Microsoft SMTP Server id
 14.3.487.0; Tue, 14 Apr 2020 19:28:46 +0800
From:   Zhenyu Ye <yezhenyu2@huawei.com>
To:     <will@kernel.org>, <catalin.marinas@arm.com>,
        <suzuki.poulose@arm.com>, <maz@kernel.org>, <steven.price@arm.com>,
        <guohanjun@huawei.com>, <olof@lixom.net>
CC:     <yezhenyu2@huawei.com>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-arch@vger.kernel.org>,
        <linux-mm@kvack.org>, <arm@kernel.org>, <xiexiangyou@huawei.com>,
        <prime.zeng@hisilicon.com>, <zhangshaokun@hisilicon.com>,
        <kuhn.chenqun@huawei.com>
Subject: [RFC PATCH v3 0/2] arm64: tlb: add support for TLBI RANGE instructions
Date:   Tue, 14 Apr 2020 19:28:33 +0800
Message-ID: <20200414112835.1121-1-yezhenyu2@huawei.com>
X-Mailer: git-send-email 2.22.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.173.220.25]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ARMv8.4-TLBI provides TLBI invalidation instruction that apply to a
range of input addresses. This series add support for this feature.

--
ChangeList:
v3:
rebase this series on Linux 5.7-rc1.

v2:
Link: https://lkml.org/lkml/2019/11/11/348

Zhenyu Ye (2):
  arm64: tlb: Detect the ARMv8.4 TLBI RANGE feature
  arm64: tlb: Use the TLBI RANGE feature in arm64

 arch/arm64/include/asm/cpucaps.h  |   3 +-
 arch/arm64/include/asm/sysreg.h   |   4 ++
 arch/arm64/include/asm/tlbflush.h | 108 +++++++++++++++++++++++++++++-
 arch/arm64/kernel/cpufeature.c    |  11 +++
 4 files changed, 124 insertions(+), 2 deletions(-)

-- 
2.19.1


