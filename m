Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 482AAC433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 07:43:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2DB952081A
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 07:43:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731217AbgF3HnT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 03:43:19 -0400
Received: from smtp25.cstnet.cn ([159.226.251.25]:43078 "EHLO cstnet.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731198AbgF3HnQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 03:43:16 -0400
Received: from localhost (unknown [159.226.5.99])
        by APP-05 (Coremail) with SMTP id zQCowADHFCQD7fpeXVqiAQ--.32278S2;
        Tue, 30 Jun 2020 15:42:59 +0800 (CST)
From:   Chen Ni <vulab@iscas.ac.cn>
To:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@redhat.com, namhyung@kernel.org
Cc:     linux-kernel@vger.kernel.org, Xu Wang <vulab@iscas.ac.cn>
Subject: [PATCH] kernel: events: use offset_in_page macro
Date:   Tue, 30 Jun 2020 07:42:58 +0000
Message-Id: <20200630074258.8301-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID: zQCowADHFCQD7fpeXVqiAQ--.32278S2
X-Coremail-Antispam: 1UD129KBjvJXoWxJrWfCF47KFy3KF1ftFWxtFb_yoW8JFWfpF
        45Ja98tw43K3W8Ka47Ar1kuw15twn7KrW8ta42k34F9r1vgw1rZ3WxGr47XFWFg392gr4U
        ta1DWr98Aa1kZ3JanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUkm14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26r1I6r4UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
        6F4UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s
        0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xII
        jxv20xvE14v26r1q6rW5McIj6I8E87Iv67AKxVWaoVW8JcWlOx8S6xCaFVCjc4AY6r1j6r
        4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCY02Avz4vE14v_GF4l
        42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJV
        WUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAK
        I48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r
        4UMIIF0xvE42xK8VAvwI8IcIk0rVWrJr0_WFyUJwCI42IY6I8E87Iv67AKxVWUJVW8JwCI
        42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfUFID7DUUUU
X-Originating-IP: [159.226.5.99]
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiCAIDA102YPg8PQAAs4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Xu Wang <vulab@iscas.ac.cn>

Use offset_in_page macro instead of (addr & ~PAGE_MASK).

Signed-off-by: Xu Wang <vulab@iscas.ac.cn>
---
 kernel/events/uprobes.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
index bb0862873dba..44d175d81ed6 100644
--- a/kernel/events/uprobes.c
+++ b/kernel/events/uprobes.c
@@ -244,14 +244,14 @@ bool __weak is_trap_insn(uprobe_opcode_t *insn)
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
 
@@ -387,7 +387,7 @@ __update_ref_ctr(struct mm_struct *mm, unsigned long vaddr, short d)
 	}
 
 	kaddr = kmap_atomic(page);
-	ptr = kaddr + (vaddr & ~PAGE_MASK);
+	ptr = kaddr + offset_in_page(vaddr);
 
 	if (unlikely(*ptr + d < 0)) {
 		pr_warn("ref_ctr going negative. vaddr: 0x%lx, "
-- 
2.17.1

