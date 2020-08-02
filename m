Return-Path: <SRS0=HA/2=BM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0697DC433E0
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Aug 2020 11:02:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D7D1320738
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Aug 2020 11:02:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727994AbgHBLCA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Aug 2020 07:02:00 -0400
Received: from smtp21.cstnet.cn ([159.226.251.21]:56806 "EHLO cstnet.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726578AbgHBLBz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Aug 2020 07:01:55 -0400
Received: from localhost.localdomain (unknown [117.135.91.130])
        by APP-01 (Coremail) with SMTP id qwCowABHKAEDnSZfitNOAA--.18741S3;
        Sun, 02 Aug 2020 19:01:44 +0800 (CST)
From:   leesagacious <lizhe@cpu-os.ac.cn>
To:     linux-kernel@vger.kernel.org
Cc:     leesagacious <lizhe@cpu-os.ac.cn>
Subject: [PATCH] include: Modify parameters that are not used in __local_bh_disable_ip()
Date:   Sun,  2 Aug 2020 04:01:01 -0700
Message-Id: <1596366061-20929-1-git-send-email-lizhe@cpu-os.ac.cn>
X-Mailer: git-send-email 2.7.4
X-CM-TRANSID: qwCowABHKAEDnSZfitNOAA--.18741S3
X-Coremail-Antispam: 1UD129KBjvdXoWrKr45tF4kZr4fGr17tF45Awb_yoWxtwb_Aa
        1IqF4j9r1rZr9avw17tF1DAa1Sq34fXF4DWFn5Xa1fZ3Wqva15J3WfJ347Ww1Y9wsxCFy3
        Za48WryxXr42gjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUbwAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2IYs7xG
        6r1S6rWUM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
        A2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Jr0_
        Gr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gr0_Gr
        1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xII
        jxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr
        1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7MxAIw28IcxkI7VAKI48J
        MxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwV
        AFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUXVWUAwCIc40Y0x0EwIxGrwCI42IY6xIIjxv2
        0xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4
        v20xvaj40_WFyUJVCq3wCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E
        14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x0JUywZ7UUUUU=
X-Originating-IP: [117.135.91.130]
X-CM-SenderInfo: xol2xv46fs3g1rvotugofq/
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: leesagacious <lizhe@cpu-os.ac.cn>
---
 include/linux/bottom_half.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/bottom_half.h b/include/linux/bottom_half.h
index ab54f34..edcdf3fa 100644
--- a/include/linux/bottom_half.h
+++ b/include/linux/bottom_half.h
@@ -7,7 +7,7 @@
 #ifdef CONFIG_TRACE_IRQFLAGS
 extern void __local_bh_disable_ip(unsigned long ip, unsigned int cnt);
 #else
-static __always_inline void __local_bh_disable_ip(unsigned long __unused ip,
+static __always_inline void __local_bh_disable_ip(__attribute__((unused)) unsigned long ip,
 					unsigned int cnt)
 {
 	preempt_count_add(cnt);
-- 
2.7.4

