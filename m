Return-Path: <SRS0=4xmc=56=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12993C2BB86
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 03:04:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F07782072D
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 03:04:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404392AbgDNDE2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Apr 2020 23:04:28 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:2313 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2404366AbgDNDEU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Apr 2020 23:04:20 -0400
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 3826CD28A6A4E787588D;
        Tue, 14 Apr 2020 11:04:16 +0800 (CST)
Received: from DESKTOP-8RFUVS3.china.huawei.com (10.173.222.27) by
 DGGEMS402-HUB.china.huawei.com (10.3.19.202) with Microsoft SMTP Server id
 14.3.487.0; Tue, 14 Apr 2020 11:04:08 +0800
From:   Zenghui Yu <yuzenghui@huawei.com>
To:     <kvmarm@lists.cs.columbia.edu>
CC:     <maz@kernel.org>, <james.morse@arm.com>,
        <julien.thierry.kdev@gmail.com>, <suzuki.poulose@arm.com>,
        <wanghaibin.wang@huawei.com>, <yezengruan@huawei.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Zenghui Yu <yuzenghui@huawei.com>
Subject: [PATCH 0/2] KVM: arm64: vgic_irq: Fix memory leaks
Date:   Tue, 14 Apr 2020 11:03:46 +0800
Message-ID: <20200414030349.625-1-yuzenghui@huawei.com>
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

A memory leak on vgic_irq structure was recently reported by kmemleak
on the guest destroy (or shutdown). It turned out that there're still
pending interrupts (LPI) staying in the vcpu's ap_list during destroy
so that KVM can't free the vgic_irq structure due to an extra refcount.

Patch #1 is intended to fix this issue. Patch #2 is a memory leak fix
on the error path, noticed while debugging.

Zenghui Yu (2):
  KVM: arm64: vgic-v3: Retire all pending LPIs on vcpu destroy
  KVM: arm64: vgic-its: Fix memory leak on the error path of
    vgic_add_lpi()

 virt/kvm/arm/vgic/vgic-init.c | 6 ++++++
 virt/kvm/arm/vgic/vgic-its.c  | 8 ++++++--
 2 files changed, 12 insertions(+), 2 deletions(-)

-- 
2.19.1


