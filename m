Return-Path: <SRS0=y5Sx=A3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D07ABC4345E
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 03:18:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A85B120791
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 03:18:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728406AbgGPDSM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jul 2020 23:18:12 -0400
Received: from mail.loongson.cn ([114.242.206.163]:48524 "EHLO loongson.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726998AbgGPDQl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jul 2020 23:16:41 -0400
Received: from linux.localdomain (unknown [113.200.148.30])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9Dx7x+Pxg9f1GoFAA--.6749S2;
        Thu, 16 Jul 2020 11:16:32 +0800 (CST)
From:   Tiezhu Yang <yangtiezhu@loongson.cn>
To:     Marc Zyngier <maz@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>
Cc:     Huacai Chen <chenhc@lemote.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 0/8] irqchip: Fix some issues and do some code cleanups about Loongson
Date:   Thu, 16 Jul 2020 11:16:22 +0800
Message-Id: <1594869390-21053-1-git-send-email-yangtiezhu@loongson.cn>
X-Mailer: git-send-email 2.1.0
X-CM-TRANSID: AQAAf9Dx7x+Pxg9f1GoFAA--.6749S2
X-Coremail-Antispam: 1UD129KBjvJXoW7tF1rGw1DWr4rGFykZryDGFg_yoW8Xw18pa
        1fC3sIgr4UCrW7ZryfAry8Ary3Aryrt39rta9rt343XF95X34DZF13AFykurZ3CrWxWF1j
        9ry0grW0k3WDCaUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUkqb7Iv0xC_tr1lb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I2
        0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
        A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xII
        jxv20xvEc7CjxVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwV
        C2z280aVCY1x0267AKxVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVAC
        Y4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1Y6r17McIj6I8E87Iv67AKxVW8JV
        WxJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lc2xSY4AK67AK6r48MxAI
        w28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr
        4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxG
        rwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8Jw
        CI42IY6xAIw20EY4v20xvaj40_Wr1j6rW3Jr1lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAI
        cVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU0-_-PUUUUU==
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

v4:
  - Fix another typo in loongson,liointc.yaml reviewed by Rob

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

