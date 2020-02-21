Return-Path: <SRS0=1210=4J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6EB1C35646
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 10:44:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90F2520722
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 10:44:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728032AbgBUKob (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Feb 2020 05:44:31 -0500
Received: from smtp21.cstnet.cn ([159.226.251.21]:52974 "EHLO cstnet.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726325AbgBUKob (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Feb 2020 05:44:31 -0500
Received: from ubuntu.localdomain (unknown [183.131.110.113])
        by APP-01 (Coremail) with SMTP id qwCowACXdzCQsU9eDiW+BA--.42124S2;
        Fri, 21 Feb 2020 18:31:47 +0800 (CST)
From:   Xu Wang <vulab@iscas.ac.cn>
To:     alex@digriz.org.uk, jason@lakedaemon.net, andrew@lunn.ch
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] ARM: orion5x: ts78xx: Remove unneeded variable ret
Date:   Fri, 21 Feb 2020 18:31:41 +0800
Message-Id: <20200221103141.3633-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID: qwCowACXdzCQsU9eDiW+BA--.42124S2
X-Coremail-Antispam: 1UD129KBjvdXoW7JFW3uFWUAFykJrWUuF1DGFg_yoWfArcE9r
        4Sgwn7WryfAF4j9r15G3Z3Gr17Ka4vqFs0gryqqwsxAr17Zw13urWDZwnxGry8WFy8Gr4S
        qrZ7Ja4ak3ZrGjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUbwkYjsxI4VWkKwAYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I
        6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM2
        8CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW5JVW7JwA2z4x0Y4vE2Ix0
        cI8IcVCY1x0267AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv67AKxVWxJr0_GcWl84ACjcxK6I
        8E87Iv6xkF7I0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI
        64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVW8Jr0_Cr
        1UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwCF04k20xvY0x0EwIxGrwCF
        x2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14
        v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY
        67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2
        IYs7xG6rWUJVWrZr1UMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAF
        wI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU59jjPUUUUU==
X-Originating-IP: [183.131.110.113]
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiDAMNA1z4ixYqcgADsj
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove unneeded variable ret used to store return value,just return 0.

Signed-off-by: Xu Wang <vulab@iscas.ac.cn>
---
 arch/arm/mach-orion5x/ts78xx-setup.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/arm/mach-orion5x/ts78xx-setup.c b/arch/arm/mach-orion5x/ts78xx-setup.c
index fda9b75c3a33..a39764faf2a0 100644
--- a/arch/arm/mach-orion5x/ts78xx-setup.c
+++ b/arch/arm/mach-orion5x/ts78xx-setup.c
@@ -398,7 +398,6 @@ static int ts78xx_fpga_load_devices(void)
 
 static int ts78xx_fpga_unload_devices(void)
 {
-	int ret = 0;
 
 	if (ts78xx_fpga.supports.ts_rtc.present == 1)
 		ts78xx_ts_rtc_unload();
@@ -407,7 +406,7 @@ static int ts78xx_fpga_unload_devices(void)
 	if (ts78xx_fpga.supports.ts_rng.present == 1)
 		ts78xx_ts_rng_unload();
 
-	return ret;
+	return 0;
 }
 
 static int ts78xx_fpga_load(void)
-- 
2.17.1

