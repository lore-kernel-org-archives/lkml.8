Return-Path: <SRS0=ne2O=7T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A753AC433DF
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Jun 2020 09:50:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 90A122073E
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Jun 2020 09:50:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728731AbgFFJun (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 6 Jun 2020 05:50:43 -0400
Received: from mail.loongson.cn ([114.242.206.163]:60216 "EHLO loongson.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728651AbgFFJuk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Jun 2020 05:50:40 -0400
Received: from linux.localdomain (unknown [113.200.148.30])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9Dxz2nZZtteMWk+AA--.1096S2;
        Sat, 06 Jun 2020 17:50:18 +0800 (CST)
From:   Tiezhu Yang <yangtiezhu@loongson.cn>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <maz@kernel.org>, Nishanth Menon <nm@ti.com>,
        Tero Kristo <t-kristo@ti.com>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Lokesh Vutla <lokeshvutla@ti.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Xuefeng Li <lixuefeng@loongson.cn>
Subject: [PATCH 1/3] irqchip/ti-sci-inta: Remove dead code in ti_sci_inta_set_type()
Date:   Sat,  6 Jun 2020 17:50:15 +0800
Message-Id: <1591437017-5295-1-git-send-email-yangtiezhu@loongson.cn>
X-Mailer: git-send-email 2.1.0
X-CM-TRANSID: AQAAf9Dxz2nZZtteMWk+AA--.1096S2
X-Coremail-Antispam: 1UD129KBjvdXoWrKrW5try7Ar17tF1kArWDurg_yoWxZFg_u3
        WjqwnxJrW0gFs8Cr17Kw48ZFy0vay5Ww1vga15tasxtwnagwn5ArW7Xws5AFs3WaykArZ7
        KrW5Zr18Cr17ujkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUb3kFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
        6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
        A2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr0_
        Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AKxVW8Jr
        0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj
        6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr
        0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E
        8cxan2IY04v7MxkIecxEwVAFwVW8uwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbV
        WUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF
        67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42
        IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6rWUJVWrZr1U
        MIIF0xvEx4A2jsIE14v26r4j6F4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIda
        VFxhVjvjDU0xZFpf9x0JU4BT5UUUUU=
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the function ti_sci_inta_set_type(), the statement "return -EINVAL;"
out of switch case is dead code, remove it.

Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
---
 drivers/irqchip/irq-ti-sci-inta.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/irqchip/irq-ti-sci-inta.c b/drivers/irqchip/irq-ti-sci-inta.c
index 7e3ebf6..c20c9f7 100644
--- a/drivers/irqchip/irq-ti-sci-inta.c
+++ b/drivers/irqchip/irq-ti-sci-inta.c
@@ -433,8 +433,6 @@ static int ti_sci_inta_set_type(struct irq_data *data, unsigned int type)
 	default:
 		return -EINVAL;
 	}
-
-	return -EINVAL;
 }
 
 static struct irq_chip ti_sci_inta_irq_chip = {
-- 
2.1.0

