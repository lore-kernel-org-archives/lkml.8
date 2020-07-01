Return-Path: <SRS0=SbvM=AM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C2D2C433E1
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 02:16:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 68B7B2078B
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 02:16:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726862AbgGACQq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 22:16:46 -0400
Received: from mail.loongson.cn ([114.242.206.163]:47700 "EHLO loongson.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726752AbgGACQh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 22:16:37 -0400
Received: from linux.localdomain (unknown [113.200.148.30])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9Dxz2r68fteU2dNAA--.5801S2;
        Wed, 01 Jul 2020 10:16:27 +0800 (CST)
From:   Tiezhu Yang <yangtiezhu@loongson.cn>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <maz@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Markus Elfring <Markus.Elfring@web.de>
Subject: [PATCH v4 00/14] irqchip: Fix potential resource leaks
Date:   Wed,  1 Jul 2020 10:16:12 +0800
Message-Id: <1593569786-11500-1-git-send-email-yangtiezhu@loongson.cn>
X-Mailer: git-send-email 2.1.0
X-CM-TRANSID: AQAAf9Dxz2r68fteU2dNAA--.5801S2
X-Coremail-Antispam: 1UD129KBjvJXoW7AFy5GF48uFW8Wr4xCryxGrg_yoW8trW8pF
        4xta9Ivr48Cay3JrnxAr1jyF9xXwnYyay7K3s3A343Xwn5WryDGF1UAw1rXryUWayfGF1j
        kr1rtFyUC3WDAFUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUkqb7Iv0xC_Kw4lb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I2
        0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
        A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xII
        jxv20xvEc7CjxVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4
        vEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40E
        FcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Gr
        0_Cr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JMxkIecxEwVAFwVW8JwCF
        04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r
        18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vI
        r41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr
        1lIxAIcVCF04k26cxKx2IYs7xG6rWUJVWrZr1UMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF
        0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU5AKs5UUUUU==
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
 drivers/irqchip/irq-csky-apb-intc.c   | 12 ++++++++++--
 drivers/irqchip/irq-csky-mpintc.c     | 34 +++++++++++++++++++++++++---------
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
 drivers/irqchip/irq-xilinx-intc.c     |  4 +++-
 14 files changed, 134 insertions(+), 41 deletions(-)

-- 
2.1.0

