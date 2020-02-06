Return-Path: <SRS0=za8s=32=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A703C2D0B1
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 07:58:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DEDC721D7D
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 07:58:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728132AbgBFH6j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Feb 2020 02:58:39 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:43872 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728085AbgBFH6f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Feb 2020 02:58:35 -0500
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 08269D722A8D21FE9BA8;
        Thu,  6 Feb 2020 15:58:33 +0800 (CST)
Received: from DESKTOP-8RFUVS3.china.huawei.com (10.173.222.27) by
 DGGEMS409-HUB.china.huawei.com (10.3.19.209) with Microsoft SMTP Server id
 14.3.439.0; Thu, 6 Feb 2020 15:58:23 +0800
From:   Zenghui Yu <yuzenghui@huawei.com>
To:     <linux-kernel@vger.kernel.org>, <maz@kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <kvmarm@lists.cs.columbia.edu>, <tglx@linutronix.de>,
        <jason@lakedaemon.net>, <wanghaibin.wang@huawei.com>,
        Zenghui Yu <yuzenghui@huawei.com>
Subject: [PATCH v2 0/6] irqchip/gic-v4.1: Cleanup and fixes for GICv4.1
Date:   Thu, 6 Feb 2020 15:57:05 +0800
Message-ID: <20200206075711.1275-1-yuzenghui@huawei.com>
X-Mailer: git-send-email 2.23.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.173.222.27]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This series contains some cleanups, VPROPBASER field programming fix
and level2 vPE table allocation enhancement, collected while looking
through the GICv4.1 driver one more time.

Hope they will help, thanks!

v1 -> v2:
 - Take into account Marc's comments on patch#3
 - Add one more patch to rename V{PEND,PROP}BASER accessors

Zenghui Yu (6):
  irqchip/gic-v4.1: Fix programming of GICR_VPROPBASER_4_1_SIZE
  irqchip/gic-v4.1: Set vpe_l1_base for all redistributors
  irqchip/gic-v4.1: Ensure L2 vPE table is allocated at RD level
  irqchip/gic-v4.1: Drop 'tmp' in inherit_vpe_l1_table_from_rd()
  irqchip/gic-v3-its: Remove superfluous WARN_ON
  irqchip/gic-v3-its: Rename VPENDBASER/VPROPBASER accessors

 arch/arm/include/asm/arch_gicv3.h   |  12 +--
 arch/arm64/include/asm/arch_gicv3.h |   8 +-
 drivers/irqchip/irq-gic-v3-its.c    | 118 +++++++++++++++++++++++-----
 include/linux/irqchip/arm-gic-v3.h  |   2 +-
 4 files changed, 110 insertions(+), 30 deletions(-)

-- 
2.19.1


