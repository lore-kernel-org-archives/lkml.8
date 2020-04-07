Return-Path: <SRS0=z/zp=5X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3965C2BABC
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 03:35:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C6AF220748
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 03:35:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726680AbgDGDfV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Apr 2020 23:35:21 -0400
Received: from mail.loongson.cn ([114.242.206.163]:54254 "EHLO loongson.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726329AbgDGDfU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Apr 2020 23:35:20 -0400
Received: from linux.localdomain (unknown [113.200.148.30])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9Dxz97x9Ite6MAkAA--.35S2;
        Tue, 07 Apr 2020 11:35:13 +0800 (CST)
From:   Tiezhu Yang <yangtiezhu@loongson.cn>
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Xuefeng Li <lixuefeng@loongson.cn>
Subject: [PATCH] spi: spidev_test: Remove hidden temporary file when make clean
Date:   Tue,  7 Apr 2020 11:35:12 +0800
Message-Id: <1586230512-5507-1-git-send-email-yangtiezhu@loongson.cn>
X-Mailer: git-send-email 2.1.0
X-CM-TRANSID: AQAAf9Dxz97x9Ite6MAkAA--.35S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Zr18urWruw1rCr4rAF48Crg_yoW8JFyxpa
        yFv3WkCF4UXryUWr1kW395uFy7Jry7Jr1kJayYgwn5t343Zw1jgFyF9rWjkr4UCasYqasx
        Xr47Kr1j9F1vya7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUkv14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
        6F4UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Cr
        1j6rxdM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj
        6xIIjxv20xvE14v26r1Y6r17McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr
        0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7MxkIecxEwVAFwVW8
        GwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r
        1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij
        64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr
        0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6Fyj6rWUJwCI42IY6I8E87Iv67AKxVWUJVW8JwCI
        42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x0JUxb18UUUUU=
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the current code, it only removes *.o and .*.o.d file when make clean,
there still exists useless .*.o.cmd file, just remove it.

Without this patch:

[yangtiezhu@linux spi]$ make
[yangtiezhu@linux spi]$ make clean
[yangtiezhu@linux spi]$ ls -1 .*.o.cmd
.spidev_fdx-in.o.cmd
.spidev_fdx.o.cmd
.spidev_test-in.o.cmd
.spidev_test.o.cmd

With this patch:

[yangtiezhu@linux spi]$ make
[yangtiezhu@linux spi]$ make clean
[yangtiezhu@linux spi]$ ls -1 .*.o.cmd
ls: cannot access .*.o.cmd: No such file or directory

Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
---
 tools/spi/Makefile | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tools/spi/Makefile b/tools/spi/Makefile
index 2249a15..ada881a 100644
--- a/tools/spi/Makefile
+++ b/tools/spi/Makefile
@@ -52,7 +52,9 @@ $(OUTPUT)spidev_fdx: $(SPIDEV_FDX_IN)
 clean:
 	rm -f $(ALL_PROGRAMS)
 	rm -rf $(OUTPUT)include/
-	find $(if $(OUTPUT),$(OUTPUT),.) -name '*.o' -delete -o -name '\.*.d' -delete
+	find $(if $(OUTPUT),$(OUTPUT),.) -name '*.o' -delete
+	find $(if $(OUTPUT),$(OUTPUT),.) -name '\.*.o.d' -delete
+	find $(if $(OUTPUT),$(OUTPUT),.) -name '\.*.o.cmd' -delete
 
 install: $(ALL_PROGRAMS)
 	install -d -m 755 $(DESTDIR)$(bindir);		\
-- 
2.1.0

