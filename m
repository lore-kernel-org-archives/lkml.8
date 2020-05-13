Return-Path: <SRS0=g10L=63=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A0E0C2D0F6
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 02:29:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5E628206A5
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 02:29:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728228AbgEMC3B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 May 2020 22:29:01 -0400
Received: from smtp23.cstnet.cn ([159.226.251.23]:38394 "EHLO cstnet.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727082AbgEMC3A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 May 2020 22:29:00 -0400
Received: from localhost.localdomain (unknown [159.226.5.100])
        by APP-03 (Coremail) with SMTP id rQCowABHmEpZW7teqs9zAQ--.28316S3;
        Wed, 13 May 2020 10:28:42 +0800 (CST)
From:   Xu Wang <vulab@iscas.ac.cn>
To:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@redhat.com, amhyung@kernel.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] kernel: events: use offset_in_page macro
Date:   Wed, 13 May 2020 02:28:39 +0000
Message-Id: <1589336919-1706-1-git-send-email-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.7.4
X-CM-TRANSID: rQCowABHmEpZW7teqs9zAQ--.28316S3
X-Coremail-Antispam: 1UD129KBjvJXoW7Wr1ftr4rKryxuFy3uF4DArb_yoW8JrW3pF
        45Ja45tw4fK3WUK347Jrykuw15Jw1kGrW8ta42k3yF9rn7Ww15A3WxWr42qFWFqrZ2gr4U
        ta1UWFyqva1kZ3JanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUyvb7Iv0xC_Zr1lb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I2
        0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
        A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xII
        jxv20xvEc7CjxVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwV
        C2z280aVCY1x0267AKxVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVAC
        Y4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJV
        W8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41l42xK82IYc2Ij64vIr41l
        4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67
        AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8I
        cVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI
        8IcIk0rVWrZr1j6s0DMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAF
        wI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU8fwIDUUUUU==
X-Originating-IP: [159.226.5.100]
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiDAMPA1z4i9-2vgAAs7
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use offset_in_page macro instead of (addr & ~PAGE_MASK).

Signed-off-by: Xu Wang <vulab@iscas.ac.cn>
---
 kernel/events/uprobes.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
index ece7e13..1552ef1 100644
--- a/kernel/events/uprobes.c
+++ b/kernel/events/uprobes.c
@@ -250,14 +250,14 @@ bool __weak is_trap_insn(uprobe_opcode_t *insn)
 static void copy_from_page(struct page *page, unsigned long vaddr, void *dst, int len)
 {
 	void *kaddr = kmap_atomic(page);
-	memcpy(dst, kaddr + (vaddr & ~PAGE_MASK), len);
+	memcpy(dst, kaddr + offset_in_page(vaddr), len);
 	kunmap_atomic(kaddr);
 }
 
 static void copy_to_page(struct page *page, unsigned long vaddr, const void *src, int len)
 {
 	void *kaddr = kmap_atomic(page);
-	memcpy(kaddr + (vaddr & ~PAGE_MASK), src, len);
+	memcpy(kaddr + offset_in_page(vaddr), src, len);
 	kunmap_atomic(kaddr);
 }
 
@@ -393,7 +393,7 @@ __update_ref_ctr(struct mm_struct *mm, unsigned long vaddr, short d)
 	}
 
 	kaddr = kmap_atomic(page);
-	ptr = kaddr + (vaddr & ~PAGE_MASK);
+	ptr = kaddr + offset_in_page(vaddr);
 
 	if (unlikely(*ptr + d < 0)) {
 		pr_warn("ref_ctr going negative. vaddr: 0x%lx, "
-- 
2.7.4

