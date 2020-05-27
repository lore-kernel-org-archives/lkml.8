Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DE1CC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 14:40:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EB1C2207D8
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 14:40:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389388AbgE0Okj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 10:40:39 -0400
Received: from mail.loongson.cn ([114.242.206.163]:42650 "EHLO loongson.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2389198AbgE0Oki (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 10:40:38 -0400
Received: from linux.localdomain (unknown [113.200.148.30])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9Ax9umae85e9bA5AA--.593S3;
        Wed, 27 May 2020 22:39:23 +0800 (CST)
From:   Tiezhu Yang <yangtiezhu@loongson.cn>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Tiezhu Yang <yangtiezhu@loongson.cn>
Subject: [PATCH v4 2/2] clk: Allow COMPILE_TEST for subdir hisilicon in Makefile
Date:   Wed, 27 May 2020 22:39:22 +0800
Message-Id: <1590590362-11570-2-git-send-email-yangtiezhu@loongson.cn>
X-Mailer: git-send-email 2.1.0
In-Reply-To: <1590590362-11570-1-git-send-email-yangtiezhu@loongson.cn>
References: <1590590362-11570-1-git-send-email-yangtiezhu@loongson.cn>
X-CM-TRANSID: AQAAf9Ax9umae85e9bA5AA--.593S3
X-Coremail-Antispam: 1UD129KBjvJXoW7Zw45JFWxJw45Ww48Xr47Jwb_yoW8uF17pa
        n5JrW7trykXF47KFZ7ArW29FyYqanaqFWqkFy8Z3WYvr98JFWFvr4Ig348tF4UWr18Gay3
        Xa97u343CF1Yk37anT9S1TB71UUUUUJqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUmI14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jr4l82xGYIkIc2
        x26xkF7I0E14v26r1I6r4UM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
        Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1l84
        ACjcxK6I8E87Iv67AKxVWxJr0_GcWl84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0DM2kK
        e7AKxVWUXVWUAwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I
        80ewAv7VC0I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCj
        c4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCY1x0262
        kKe7AKxVWUAVWUtwCY02Avz4vE14v_Xryl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Y
        z7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zV
        AF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4l
        IxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCw
        CI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnI
        WIevJa73UjIFyTuYvjfU8TmhDUUUU
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If CONFIG_ARCH_HISI is not set but COMPILE_TEST is set, some files
in the subdir hisilicon can not be built due to CONFIG_ARCH_HISI
check in drivers/clk/Makefile.

Since the related configs in drivers/clk/hisilicon/Kconfig depend
on ARCH_HISI, so remove CONFIG_ARCH_HISI check for subdir hisilicon
in drivers/clk/Makefile.

At the same time, we should add CONFIG_ARCH_HISI and COMPILE_TEST
(for better compile testing coverage) check for the common files
in drivers/clk/hisilicon/Makefile, otherwise there exists build
failure about undefined reference.

Reported-by: kbuild test robot <lkp@intel.com>
Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
---

v2:
  - Add CONFIG_ARCH_HISI check for the common files
    to fix the build failure

v3:
  - Add CONFIG_COMPILE_TEST check for the common files
    for better compile testing coverage

v4:
  - Modify the patch subject to reflect the reality

 drivers/clk/Makefile           | 2 +-
 drivers/clk/hisilicon/Makefile | 3 ++-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/Makefile b/drivers/clk/Makefile
index f4169cc..81045ec 100644
--- a/drivers/clk/Makefile
+++ b/drivers/clk/Makefile
@@ -79,7 +79,7 @@ obj-y					+= bcm/
 obj-$(CONFIG_ARCH_BERLIN)		+= berlin/
 obj-$(CONFIG_ARCH_DAVINCI)		+= davinci/
 obj-$(CONFIG_H8300)			+= h8300/
-obj-$(CONFIG_ARCH_HISI)			+= hisilicon/
+obj-y					+= hisilicon/
 obj-y					+= imgtec/
 obj-y					+= imx/
 obj-y					+= ingenic/
diff --git a/drivers/clk/hisilicon/Makefile b/drivers/clk/hisilicon/Makefile
index b2441b9..e58104d 100644
--- a/drivers/clk/hisilicon/Makefile
+++ b/drivers/clk/hisilicon/Makefile
@@ -3,7 +3,8 @@
 # Hisilicon Clock specific Makefile
 #
 
-obj-y	+= clk.o clkgate-separated.o clkdivider-hi6220.o clk-hisi-phase.o
+obj-$(CONFIG_ARCH_HISI)		+= clk.o clkgate-separated.o clkdivider-hi6220.o clk-hisi-phase.o
+obj-$(CONFIG_COMPILE_TEST)	+= clk.o clkgate-separated.o clkdivider-hi6220.o clk-hisi-phase.o
 
 obj-$(CONFIG_ARCH_HI3xxx)	+= clk-hi3620.o
 obj-$(CONFIG_ARCH_HIP04)	+= clk-hip04.o
-- 
2.1.0

