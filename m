Return-Path: <SRS0=eGSO=AR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC61BC433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 01:19:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BA38420786
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 01:19:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728553AbgGFBTi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 Jul 2020 21:19:38 -0400
Received: from mail.loongson.cn ([114.242.206.163]:46926 "EHLO loongson.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728280AbgGFBTh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Jul 2020 21:19:37 -0400
Received: from linux.localdomain (unknown [113.200.148.30])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9Dxn2oefAJfl2VQAA--.1722S2;
        Mon, 06 Jul 2020 09:19:27 +0800 (CST)
From:   Tiezhu Yang <yangtiezhu@loongson.cn>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <maz@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Markus Elfring <Markus.Elfring@web.de>
Subject: [PATCH v5 00/14] irqchip: Fix potential resource leaks
Date:   Mon,  6 Jul 2020 09:19:11 +0800
Message-Id: <1593998365-25910-1-git-send-email-yangtiezhu@loongson.cn>
X-Mailer: git-send-email 2.1.0
X-CM-TRANSID: AQAAf9Dxn2oefAJfl2VQAA--.1722S2
X-Coremail-Antispam: 1UD129KBjvJXoW7AFy5GF48uFW8Wr4xCryxGrg_yoW8tw1rpF
        4xta9Ivr48Cay3JrnxAw1jyFy3ZwnYyay7K3s3A343Xwn5uryDGF1UAw1rXryUWayfG3Wj
        kr4FyFyUC3WDAFUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUkYb7Iv0xC_Kw4lb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I2
        0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
        A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xII
        jxv20xvEc7CjxVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4
        A2jsIEc7CjxVAFwI0_Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI
        64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r106r15McIj6I8E87Iv67AKxVWUJVW8Jw
        Am72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lc2xSY4AK67AK6w4l42xK82IY
        c2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s
        026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF
        0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0x
        vE42xK8VAvwI8IcIk0rVWrZr1j6s0DMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2
        jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU56MNUUUUUU==
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When I test the irqchip code of Loongson, I read the related code of other
chips in drivers/irqchip and I find some potential resource leaks in the
error path, I think it is better to fix them.

v2:
  - Split the first patch into a new patch series which
    includes small patches and add "Fixes" tag
  - Use "goto" label to handle error path in some patches

v3:
  - Add missed variable "ret" in the patch #5 and #13

v4:
  - Modify the commit message of each patch suggested by Markus Elfring
  - Make "irq_domain_remove(root_domain)" under CONFIG_SMP in patch #3
  - Add a return statement before goto label in patch #4

v5:
  - Modify the commit messages and do some code cleanups

Tiezhu Yang (14):
  irqchip/ath79-misc: Fix potential resource leaks
  irqchip/csky-apb-intc: Fix potential resource leaks
  irqchip/csky-mpintc: Fix potential resource leaks
  irqchip/davinci-aintc: Fix potential resource leaks
  irqchip/davinci-cp-intc: Fix potential resource leaks
  irqchip/digicolor: Fix potential resource leaks
  irqchip/dw-apb-ictl: Fix potential resource leaks
  irqchip/ls1x: Fix potential resource leaks
  irqchip/mscc-ocelot: Fix potential resource leaks
  irqchip/nvic: Fix potential resource leaks
  irqchip/omap-intc: Fix potential resource leak
  irqchip/riscv-intc: Fix potential resource leak
  irqchip/s3c24xx: Fix potential resource leaks
  irqchip/xilinx-intc: Fix potential resource leak

 drivers/irqchip/irq-ath79-misc.c      | 14 +++++++++++---
 drivers/irqchip/irq-csky-apb-intc.c   | 11 +++++++++--
 drivers/irqchip/irq-csky-mpintc.c     | 31 ++++++++++++++++++++++---------
 drivers/irqchip/irq-davinci-aintc.c   | 18 ++++++++++++++----
 drivers/irqchip/irq-davinci-cp-intc.c | 18 +++++++++++++++---
 drivers/irqchip/irq-digicolor.c       | 14 +++++++++++---
 drivers/irqchip/irq-dw-apb-ictl.c     | 11 ++++++++---
 drivers/irqchip/irq-ls1x.c            |  4 +++-
 drivers/irqchip/irq-mscc-ocelot.c     |  6 ++++--
 drivers/irqchip/irq-nvic.c            | 12 +++++++++---
 drivers/irqchip/irq-omap-intc.c       |  4 +++-
 drivers/irqchip/irq-riscv-intc.c      |  1 +
 drivers/irqchip/irq-s3c24xx.c         | 23 +++++++++++++++++------
 drivers/irqchip/irq-xilinx-intc.c     | 11 ++++++-----
 14 files changed, 133 insertions(+), 45 deletions(-)

-- 
2.1.0

