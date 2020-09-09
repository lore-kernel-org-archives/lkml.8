Return-Path: <SRS0=iZCi=CS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD986C2D0A8
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 06:59:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7719021741
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 06:59:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727782AbgIIG7X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Sep 2020 02:59:23 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:55160 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726169AbgIIG7V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Sep 2020 02:59:21 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 512BF7CACEB8EFD54234;
        Wed,  9 Sep 2020 14:59:17 +0800 (CST)
Received: from thunder-town.china.huawei.com (10.174.177.253) by
 DGGEMS406-HUB.china.huawei.com (10.3.19.206) with Microsoft SMTP Server id
 14.3.487.0; Wed, 9 Sep 2020 14:59:06 +0800
From:   Zhen Lei <thunder.leizhen@huawei.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
CC:     Zhen Lei <thunder.leizhen@huawei.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Haoyu Lv <lvhaoyu@huawei.com>, Libin <huawei.libin@huawei.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: [PATCH v3 0/3] irqchip: dw-apb-ictl: support hierarchy irq domain
Date:   Wed, 9 Sep 2020 14:58:33 +0800
Message-ID: <20200909065836.2631-1-thunder.leizhen@huawei.com>
X-Mailer: git-send-email 2.26.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.174.177.253]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

v2 --> v3:
1. change (1 << hwirq) to BIT(hwirq).
2. change __exception_irq_entry to __irq_entry, so we can "#include <linux/interrupt.h>"
   instead of "#include <asm/exception.h>". Ohterwise, an compilation error will be
   reported on arch/csky.
   drivers/irqchip/irq-dw-apb-ictl.c:20:10: fatal error: asm/exception.h: No such file or directory
3. use "if (!parent || (np == parent))" to determine whether it is primary interrupt controller.
4. make the primary interrupt controller case also use function handle_level_irq(), I used 
   handle_fasteoi_irq() as flow_handler before.
5. Other minor changes are not detailed.

v1 --> v2:
According to Marc Zyngier's suggestion, discard adding an independent SD5203-VIC
driver, but make the dw-apb-ictl irqchip driver to support hierarchy irq domain.
It was originally available only for secondary interrupt controller, now it can
also be used as primary interrupt controller. The related dt-bindings is updated
appropriately.

Add "Suggested-by: Marc Zyngier <maz@kernel.org>".
Add "Tested-by: Haoyu Lv <lvhaoyu@huawei.com>".


v1:
The interrupt controller of SD5203 SoC is VIC(vector interrupt controller), it's
based on Synopsys DesignWare APB interrupt controller (dw_apb_ictl) IP, but it
can not directly use dw_apb_ictl driver. The main reason is that VIC is used as
primary interrupt controller and dw_apb_ictl driver worked for secondary
interrupt controller. So add a new driver: "hisilicon,sd5203-vic".

Zhen Lei (3):
  irqchip: dw-apb-ictl: prepare for support hierarchy irq domain
  irqchip: dw-apb-ictl: support hierarchy irq domain
  dt-bindings: dw-apb-ictl: support hierarchy irq domain

 .../interrupt-controller/snps,dw-apb-ictl.txt | 14 ++-
 drivers/irqchip/Kconfig                       |  2 +-
 drivers/irqchip/irq-dw-apb-ictl.c             | 85 ++++++++++++++++---
 3 files changed, 87 insertions(+), 14 deletions(-)

-- 
2.26.0.106.g9fadedd


