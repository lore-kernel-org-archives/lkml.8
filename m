Return-Path: <SRS0=OCv1=CF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D63C6C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 08:23:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C085520738
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 08:23:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728303AbgH0IX5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Aug 2020 04:23:57 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:45806 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728265AbgH0IXy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Aug 2020 04:23:54 -0400
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 5C70C129FCFD88B23E96;
        Thu, 27 Aug 2020 16:23:48 +0800 (CST)
Received: from huawei.com (10.174.187.31) by DGGEMS402-HUB.china.huawei.com
 (10.3.19.202) with Microsoft SMTP Server id 14.3.487.0; Thu, 27 Aug 2020
 16:23:41 +0800
From:   Yifei Jiang <jiangyifei@huawei.com>
To:     <paul.walmsley@sifive.com>, <palmer@dabbelt.com>,
        <aou@eecs.berkeley.edu>, <anup.patel@wdc.com>,
        <alistair.francis@wdc.com>, <atish.patra@wdc.com>,
        <deepa.kernel@gmail.com>
CC:     <kvm-riscv@lists.infradead.org>, <kvm@vger.kernel.org>,
        <linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <victor.zhangxiaofeng@huawei.com>, <wu.wubin@huawei.com>,
        <zhang.zhanghailiang@huawei.com>, <dengkai1@huawei.com>,
        <yinyipeng1@huawei.com>, Yifei Jiang <jiangyifei@huawei.com>
Subject: [PATCH RFC 0/2] Add log dirty support
Date:   Thu, 27 Aug 2020 16:22:49 +0800
Message-ID: <20200827082251.1591-1-jiangyifei@huawei.com>
X-Mailer: git-send-email 2.26.2.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain
X-Originating-IP: [10.174.187.31]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series supports log dirty for migration in RISC-V KVM. Two interfaces
are added for kvm_main.c, and some bugs are fixed.

We have implemented the vm migration in Qemu. So these patches have been
tested.

This series is implemented based on https://github.com/avpatel/linux/tree/riscv_kvm_v13.

Yifei Jiang (2):
  riscv/kvm: Fix use VSIP_VALID_MASK mask HIP register
  target/kvm: Add interfaces needed for log dirty

 arch/riscv/configs/defconfig |  1 +
 arch/riscv/kvm/Kconfig       |  1 +
 arch/riscv/kvm/mmu.c         | 43 ++++++++++++++++++++++++++++++++++++
 arch/riscv/kvm/vcpu.c        |  2 +-
 arch/riscv/kvm/vm.c          |  6 -----
 5 files changed, 46 insertions(+), 7 deletions(-)

-- 
2.19.1


