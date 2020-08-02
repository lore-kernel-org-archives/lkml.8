Return-Path: <SRS0=HA/2=BM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B71BC433DF
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Aug 2020 04:00:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 169D4206D4
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Aug 2020 04:00:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727794AbgHBD7Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Aug 2020 23:59:16 -0400
Received: from smtp21.cstnet.cn ([159.226.251.21]:45718 "EHLO cstnet.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726387AbgHBD7Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Aug 2020 23:59:16 -0400
Received: from localhost.localdomain (unknown [117.135.91.130])
        by APP-01 (Coremail) with SMTP id qwCowACnhwChNiZfP2pCAA--.6673S3;
        Sun, 02 Aug 2020 11:45:16 +0800 (CST)
From:   leesagacious <lizhe@cpu-os.ac.cn>
To:     linux-kernel@vger.kernel.org
Cc:     leesagacious <lizhe@cpu-os.ac.cn>
Subject: [PATCH] Modify the parameters that are not used
Date:   Sat,  1 Aug 2020 20:44:12 -0700
Message-Id: <1596339852-41875-1-git-send-email-lizhe@cpu-os.ac.cn>
X-Mailer: git-send-email 2.7.4
X-CM-TRANSID: qwCowACnhwChNiZfP2pCAA--.6673S3
X-Coremail-Antispam: 1UD129KBjvdXoWrtr1xKr4kJr4rJr15Wry8Krg_yoWxKrg_Ga
        1IqF4Uur15Zrn3Zw17Jr1DAayS934xX3W0gFn5Ka1fZ3Wqvw45J3WfJ347Ww1Y9wsxCFy3
        Zas7WryxWr17KjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUbwAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2IYs7xG
        6r1S6rWUM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
        A2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Jr0_
        Gr1l84ACjcxK6I8E87Iv67AKxVWUJVW8JwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gr0_Gr
        1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xII
        jxv20xvE14v26r1Y6r17McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr
        1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7MxAIw28IcxkI7VAKI48J
        MxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwV
        AFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUXVWUAwCIc40Y0x0EwIxGrwCI42IY6xIIjxv2
        0xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4
        v20xvaj40_WFyUJVCq3wCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E
        14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x0JU9189UUUUU=
X-Originating-IP: [117.135.91.130]
X-CM-SenderInfo: xol2xv46fs3g1rvotugofq/
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: leesagacious <lizhe@cpu-os.ac.cn>
---
 include/linux/bottom_half.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/linux/bottom_half.h b/include/linux/bottom_half.h
index a19519f..ab54f34 100644
--- a/include/linux/bottom_half.h
+++ b/include/linux/bottom_half.h
@@ -7,7 +7,8 @@
 #ifdef CONFIG_TRACE_IRQFLAGS
 extern void __local_bh_disable_ip(unsigned long ip, unsigned int cnt);
 #else
-static __always_inline void __local_bh_disable_ip(unsigned long ip, unsigned int cnt)
+static __always_inline void __local_bh_disable_ip(unsigned long __unused ip,
+					unsigned int cnt)
 {
 	preempt_count_add(cnt);
 	barrier();
-- 
2.7.4

