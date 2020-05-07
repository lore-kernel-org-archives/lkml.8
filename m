Return-Path: <SRS0=0sZ+=6V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBE36C38A2A
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 12:03:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 997752073A
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 12:03:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726712AbgEGMDu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 May 2020 08:03:50 -0400
Received: from mail.loongson.cn ([114.242.206.163]:33052 "EHLO loongson.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725848AbgEGMDt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 08:03:49 -0400
Received: from linux.localdomain (unknown [113.200.148.30])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9DxP9wX+bNeTLUxAA--.1S2;
        Thu, 07 May 2020 20:03:35 +0800 (CST)
From:   Tiezhu Yang <yangtiezhu@loongson.cn>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>
Cc:     linux-kernel@vger.kernel.org, Xuefeng Li <lixuefeng@loongson.cn>
Subject: [PATCH] serial: Remove duplicated macro definition of port type
Date:   Thu,  7 May 2020 20:03:35 +0800
Message-Id: <1588853015-28392-1-git-send-email-yangtiezhu@loongson.cn>
X-Mailer: git-send-email 2.1.0
X-CM-TRANSID: AQAAf9DxP9wX+bNeTLUxAA--.1S2
X-Coremail-Antispam: 1UD129KBjvdXoW7XrWfCw48uF43uF1xJw1DJrb_yoWkXrc_A3
        sruFWDGF18uF4xKr4fA345JF1YgrykAF9aqF1rKr4jyr9rtFsrG34fGr9rXFs8Ww4DWr98
        Jw1a9r9Yvw1fGjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUbc8FF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2IYs7xG
        6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
        A2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr0_
        Cr1l84ACjcxK6I8E87Iv67AKxVWxJr0_GcWl84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s
        0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xII
        jxv20xvE14v26r106r15McIj6I8E87Iv67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr
        1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7MxkIecxEwVAFwVW5JwCF
        04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r
        18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vI
        r41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr
        1lIxAIcVCF04k26cxKx2IYs7xG6Fyj6rWUJwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY
        6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfU0fHUDUUUU
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There exists the same macro definition of port type from 0 to 13
in include/uapi/linux/serial.h, remove these duplicated code in
include/uapi/linux/serial_core.h which includes the former header.

Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
---
 include/uapi/linux/serial_core.h | 14 --------------
 1 file changed, 14 deletions(-)

diff --git a/include/uapi/linux/serial_core.h b/include/uapi/linux/serial_core.h
index 8ec3dd7..851b982 100644
--- a/include/uapi/linux/serial_core.h
+++ b/include/uapi/linux/serial_core.h
@@ -26,20 +26,6 @@
 /*
  * The type definitions.  These are from Ted Ts'o's serial.h
  */
-#define PORT_UNKNOWN	0
-#define PORT_8250	1
-#define PORT_16450	2
-#define PORT_16550	3
-#define PORT_16550A	4
-#define PORT_CIRRUS	5
-#define PORT_16650	6
-#define PORT_16650V2	7
-#define PORT_16750	8
-#define PORT_STARTECH	9
-#define PORT_16C950	10
-#define PORT_16654	11
-#define PORT_16850	12
-#define PORT_RSA	13
 #define PORT_NS16550A	14
 #define PORT_XSCALE	15
 #define PORT_RM9000	16	/* PMC-Sierra RM9xxx internal UART */
-- 
2.1.0

