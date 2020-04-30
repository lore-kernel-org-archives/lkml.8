Return-Path: <SRS0=SogR=6O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5F7FC83001
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 07:12:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8C6BF214D8
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 07:12:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726669AbgD3HM0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Apr 2020 03:12:26 -0400
Received: from smtp25.cstnet.cn ([159.226.251.25]:42868 "EHLO cstnet.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726337AbgD3HM0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Apr 2020 03:12:26 -0400
Received: from ubuntu.localdomain (unknown [223.104.3.134])
        by APP-05 (Coremail) with SMTP id zQCowADnh_FPeqpeDU+oAA--.9471S2;
        Thu, 30 Apr 2020 15:12:16 +0800 (CST)
From:   Xu Wang <vulab@iscas.ac.cn>
To:     linux@armlinux.org.uk, michal.simek@xilinx.com,
        linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] ZYNQ: platsmp: fix ioremap return value
Date:   Thu, 30 Apr 2020 15:12:15 +0800
Message-Id: <20200430071215.13448-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID: zQCowADnh_FPeqpeDU+oAA--.9471S2
X-Coremail-Antispam: 1UD129KBjvdXoW7GF48ZFWxGFyktryDZr1DJrb_yoWxurg_Aw
        1xtanrW3sYqF1v9w4rCa18Crsrt348Cr1Fgry2yF92k3yUWr17Cryvya9aqw4xX3ZagrZ8
        GrWxGryayw15JjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUbwxYjsxI4VWkCwAYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I
        6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM2
        8CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW8JVW5JwA2z4x0Y4vE2Ix0
        cI8IcVCY1x0267AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwV
        C2z280aVCY1x0267AKxVWxJr0_GcWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xv
        F2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r
        4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwCF04k20xvY0x0EwIxGrwCF
        x2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14
        v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY
        67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2
        IYs7xG6rW3Jr0E3s1lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AK
        xVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxUcDDGUUUUU
X-Originating-IP: [223.104.3.134]
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiCgECA1z4i0Q2CAAAsf
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In ioremap we should return -ENOMEM when it reports an
memory allocation failure.

Signed-off-by: Xu Wang <vulab@iscas.ac.cn>
---
 arch/arm/mach-zynq/platsmp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-zynq/platsmp.c b/arch/arm/mach-zynq/platsmp.c
index 68ec303fa278..308f74f9b4f9 100644
--- a/arch/arm/mach-zynq/platsmp.c
+++ b/arch/arm/mach-zynq/platsmp.c
@@ -47,7 +47,7 @@ int zynq_cpun_start(u32 address, int cpu)
 				zero = ioremap(0, trampoline_code_size);
 				if (!zero) {
 					pr_warn("BOOTUP jump vectors not accessible\n");
-					return -1;
+					return -ENOMEM;
 				}
 			} else {
 				zero = (__force u8 __iomem *)PAGE_OFFSET;
-- 
2.17.1

