Return-Path: <SRS0=t9Lj=3Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4BDAC3524F
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Feb 2020 09:11:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5F5621744
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Feb 2020 09:11:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727159AbgBDJL4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Feb 2020 04:11:56 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:9693 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726406AbgBDJLq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Feb 2020 04:11:46 -0500
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id DA2F72ABEF3214DF7FDC;
        Tue,  4 Feb 2020 17:11:43 +0800 (CST)
Received: from DESKTOP-8RFUVS3.china.huawei.com (10.173.222.27) by
 DGGEMS403-HUB.china.huawei.com (10.3.19.203) with Microsoft SMTP Server id
 14.3.439.0; Tue, 4 Feb 2020 17:11:34 +0800
From:   Zenghui Yu <yuzenghui@huawei.com>
To:     <linux-kernel@vger.kernel.org>, <maz@kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <kvmarm@lists.cs.columbia.edu>, <tglx@linutronix.de>,
        <jason@lakedaemon.net>, <wanghaibin.wang@huawei.com>,
        Zenghui Yu <yuzenghui@huawei.com>
Subject: [PATCH 0/5] irqchip/gic-v4.1: Cleanup and fixes for GICv4.1
Date:   Tue, 4 Feb 2020 17:09:35 +0800
Message-ID: <20200204090940.1225-1-yuzenghui@huawei.com>
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

Zenghui Yu (5):
  irqchip/gic-v4.1: Fix programming of GICR_VPROPBASER_4_1_SIZE
  irqchip/gic-v4.1: Set vpe_l1_base for all redistributors
  irqchip/gic-v4.1: Ensure L2 vPE table is allocated at RD level
  irqchip/gic-v4.1: Drop 'tmp' in inherit_vpe_l1_table_from_rd()
  irqchip/gic-v3-its: Remove superfluous WARN_ON

 drivers/irqchip/irq-gic-v3-its.c   | 80 +++++++++++++++++++++++++++---
 include/linux/irqchip/arm-gic-v3.h |  2 +-
 2 files changed, 75 insertions(+), 7 deletions(-)

-- 
2.19.1


