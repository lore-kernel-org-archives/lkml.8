Return-Path: <SRS0=KEJG=BY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BD68C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Aug 2020 04:13:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 696EC20855
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Aug 2020 04:13:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726270AbgHNEM5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Aug 2020 00:12:57 -0400
Received: from mail.loongson.cn ([114.242.206.163]:54726 "EHLO loongson.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725989AbgHNEM4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Aug 2020 00:12:56 -0400
Received: from bogon.localdomain (unknown [113.200.148.30])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9DxGMY3DzZfsL4IAA--.6S2;
        Fri, 14 Aug 2020 12:12:41 +0800 (CST)
From:   Xingxing Su <suxingxing@loongson.cn>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH v2] seqlock: Fix build errors
Date:   Fri, 14 Aug 2020 12:12:38 +0800
Message-Id: <1597378358-2546-1-git-send-email-suxingxing@loongson.cn>
X-Mailer: git-send-email 2.1.0
MIME-Version: 1.0
Content-Type: text/plain; charset=y
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf9DxGMY3DzZfsL4IAA--.6S2
X-Coremail-Antispam: 1UD129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
        VFW2AGmfu7bjvjm3AaLaJ3UjIYCTnIWjp_UUUYD7k0a2IF6FyUM7kC6x804xWl14x267AK
        xVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AKwVWUJVWUGw
        A2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjxv20xvE14v26r1j
        6r1xM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j6F4UM28EF7xvwVC2z280aVAFwI0_Gr
        1j6F4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Cr1j6rxdM2AIxVAIcxkEcVAq07x20xvE
        ncxIr21le4C262xC7I0v67AEwI8IwI1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjx
        v20xvE14v26r1j6r18McIj6I8E87Iv67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr1l
        F7xvr2IYc2Ij64vIr41lw4CEx2IqxVAFz4v204v26I0v724l42xK82IYc2Ij64vIr41l4I
        8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AK
        xVWUJVWUGwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcV
        AFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8I
        cIk0rVWrJr0_WFyUJwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14
        v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07j2T5dUUUUU=
X-CM-SenderInfo: pvx0x0xj0l0wo6or00hjvr0hdfq/1tbiAQAIC13QvMMNMwAEsK
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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


Signed-off-by: Xingxing Su <suxingxing@loongson.cn>
---
 v2:  update the commit message

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

