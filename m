Return-Path: <SRS0=vr6t=BV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27F75C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 01:57:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0536120716
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 01:57:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728096AbgHKB5r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Aug 2020 21:57:47 -0400
Received: from mail.loongson.cn ([114.242.206.163]:33512 "EHLO loongson.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727985AbgHKB5r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Aug 2020 21:57:47 -0400
Received: from bogon.localdomain (unknown [113.200.148.30])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9BxK+QS+zFf+ikHAA--.3177S2;
        Tue, 11 Aug 2020 09:57:38 +0800 (CST)
From:   Xingxing Su <suxingxing@loongson.cn>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>
Cc:     linux-kernel@vger.kernel.org, XingxingSu <suxingxing@loongson.cn>
Subject: [PATCH] seqlock: Fix build errors
Date:   Tue, 11 Aug 2020 09:57:29 +0800
Message-Id: <1597111049-1950-1-git-send-email-suxingxing@loongson.cn>
X-Mailer: git-send-email 2.1.0
MIME-Version: 1.0
Content-Type: text/plain; charset=y
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf9BxK+QS+zFf+ikHAA--.3177S2
X-Coremail-Antispam: 1UD129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
        VFW2AGmfu7bjvjm3AaLaJ3UjIYCTnIWjp_UUUYA7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E
        6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28Cjx
        kF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW5JVW7JwA2z4x0Y4vE2Ix0cI8I
        cVCY1x0267AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4
        A2jsIEc7CjxVAFwI0_Gr1j6F4UJwAS0I0E0xvYzxvE52x082IY62kv0487M2AExVAIFx02
        aVAFz4v204v7Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUtVWrXw
        Av7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48J
        M4x0x7Aq67IIx4CEVc8vx2IErcIFxwAKzVC20s0267AEwI8IwI0ExsIj0wCY02Avz4vE14
        v_KwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v2
        6r1j6r18MI8I3I0E7480Y4vE14v26r1j6r18MI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2
        Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_
        Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6rWUJVWrZr1UMIIF0xvEx4A2jsIE14v26r1j6r
        4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7VUj3rc3UU
        UUU==
X-CM-SenderInfo: pvx0x0xj0l0wo6or00hjvr0hdfq/1tbiAQAFC13QvMLgmQACsH
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: XingxingSu <suxingxing@loongson.cn>

Fix the following build errors:

In file included from ./include/linux/time.h:6:0,
                 from ./include/linux/compat.h:10,
                 from arch/mips/kernel/asm-offsets.c:12:
./include/linux/seqlock.h: In function ‘write_seqcount_begin_nested’:
./include/linux/seqlock.h:286:2: error: implicit declaration of function 
 ‘raw_smp_processor_id’ [-Werror=implicit-function-declaration]
  lockdep_assert_preemption_disabled();
  ^
./arch/mips/include/asm/smp.h: At top level:
./arch/mips/include/asm/smp.h:28:19: error: static declaration of 
 ‘raw_smp_processor_id’ follows non-static declaration
 static inline int raw_smp_processor_id(void)
                 ^
cc1: some warnings being treated as errors
scripts/Makefile.build:117: recipe for target 'arch/mips/kernel/asm-offsets.s' failed
make[1]: *** [arch/mips/kernel/asm-offsets.s] Error 1
arch/mips/Makefile:396: recipe for target 'archprepare' failed
make: *** [archprepare] Error 2


Signed-off-by: XingxingSu <suxingxing@loongson.cn>
---
 include/linux/seqlock.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/seqlock.h b/include/linux/seqlock.h
index 54bc204..4763c13 100644
--- a/include/linux/seqlock.h
+++ b/include/linux/seqlock.h
@@ -17,6 +17,7 @@
 #include <linux/lockdep.h>
 #include <linux/compiler.h>
 #include <linux/kcsan-checks.h>
+#include <linux/smp.h>
 #include <asm/processor.h>
 
 /*
-- 
2.1.0

