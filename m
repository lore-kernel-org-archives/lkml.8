Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83BBCC433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 02:13:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5BD99206E6
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 02:13:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727094AbgGGCNF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jul 2020 22:13:05 -0400
Received: from mail.loongson.cn ([114.242.206.163]:33908 "EHLO loongson.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726825AbgGGCNF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jul 2020 22:13:05 -0400
Received: from linux.localdomain (unknown [113.200.148.30])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9Dxfesl2gNfyABRAA--.2533S2;
        Tue, 07 Jul 2020 10:12:53 +0800 (CST)
From:   Tiezhu Yang <yangtiezhu@loongson.cn>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <maz@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: [PATCH v3 0/8] irqchip: Fix some issues and do some code cleanups about Loongson
Date:   Tue,  7 Jul 2020 10:12:44 +0800
Message-Id: <1594087972-21715-1-git-send-email-yangtiezhu@loongson.cn>
X-Mailer: git-send-email 2.1.0
X-CM-TRANSID: AQAAf9Dxfesl2gNfyABRAA--.2533S2
X-Coremail-Antispam: 1UD129KBjvJXoW7tF1rGw1DWr4rGFykZryDGFg_yoW8XryfpF
        4fC3sIgr4UCrW7ZryfAry8Ary3Aryrt39rta9rt343XF95X34DuF13AFykurZ7CrWxWF1j
        vry0grW8C3WDCF7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUkSb7Iv0xC_tr1lb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I2
        0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
        A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xII
        jxv20xvEc7CjxVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4
        vEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40E
        FcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr
        0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JMxkIecxEwVAFwVW8JwCF
        04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r
        18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vI
        r41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr
        1lIxAIcVCF04k26cxKx2IYs7xG6rW3Jr0E3s1lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAI
        cVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxU27KsUUUUU
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Check the return value of irq_domain_translate_onecell() and
irq_domain_translate_twocell(), fix potential resource leak
and dead lock, do some code cleanups about Loongson to make
it more clean and readable.

v2:
  - In order to avoid git send-email failed, make the related patches
    about Loongson into a new patch series and add "Fixes" tag
v3:
  - Add a new patch "irqchip/loongson-liointc: Fix potential dead lock"
  - Fix another typo in loongson,liointc.yaml

Tiezhu Yang (8):
  irqchip/loongson-htpic: Remove redundant kfree operation
  irqchip/loongson-htpic: Remove unneeded select of I8259
  irqchip/loongson-htvec: Fix potential resource leak
  irqchip/loongson-htvec: Check return value of
    irq_domain_translate_onecell()
  irqchip/loongson-pch-pic: Check return value of
    irq_domain_translate_twocell()
  irqchip/loongson-pch-msi: Remove unneeded variable
  irqchip/loongson-liointc: Fix potential dead lock
  dt-bindings: interrupt-controller: Fix typos in loongson,liointc.yaml

 .../bindings/interrupt-controller/loongson,liointc.yaml   |  4 ++--
 drivers/irqchip/Kconfig                                   |  1 -
 drivers/irqchip/irq-loongson-htpic.c                      |  6 ++----
 drivers/irqchip/irq-loongson-htvec.c                      | 10 ++++++++--
 drivers/irqchip/irq-loongson-liointc.c                    |  1 +
 drivers/irqchip/irq-loongson-pch-msi.c                    |  7 +------
 drivers/irqchip/irq-loongson-pch-pic.c                    | 15 +++++++++------
 7 files changed, 23 insertions(+), 21 deletions(-)

-- 
2.1.0

