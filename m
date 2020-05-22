Return-Path: <SRS0=AA2M=7E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A23FC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 07:51:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CC85720812
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 07:51:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728871AbgEVHvl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 May 2020 03:51:41 -0400
Received: from mail.loongson.cn ([114.242.206.163]:36194 "EHLO loongson.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728152AbgEVHvk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 May 2020 03:51:40 -0400
Received: from linux.localdomain (unknown [113.200.148.30])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9Dx72plhMdeCME3AA--.75S4;
        Fri, 22 May 2020 15:51:03 +0800 (CST)
From:   Tiezhu Yang <yangtiezhu@loongson.cn>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     linux-kernel@vger.kernel.org, Xuefeng Li <lixuefeng@loongson.cn>,
        Tiezhu Yang <yangtiezhu@loongson.cn>
Subject: [PATCH 2/2] MAINTAINERS: Add git tree for NVMEM FRAMEWORK
Date:   Fri, 22 May 2020 15:51:01 +0800
Message-Id: <1590133861-25515-3-git-send-email-yangtiezhu@loongson.cn>
X-Mailer: git-send-email 2.1.0
In-Reply-To: <1590133861-25515-1-git-send-email-yangtiezhu@loongson.cn>
References: <1590133861-25515-1-git-send-email-yangtiezhu@loongson.cn>
X-CM-TRANSID: AQAAf9Dx72plhMdeCME3AA--.75S4
X-Coremail-Antispam: 1UD129KBjvdXoW7XF18Kw48tr4kKr1UtF43Wrg_yoWxCwbEkF
        4UXa1fXFyrGr4UK3ykCFsrXFyYqr43GF4Sy3ZFqwsxA34UXrZ8KrnIywn2kw1UCr4fWrsF
        qFWxJr9a9rW29jkaLaAFLSUrUUUUbb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUbSAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
        6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUXwA2048vs2IY02
        0Ec7CjxVAFwI0_JFI_Gr1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xv
        wVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVWxJVW8Jr1l84
        ACjcxK6I8E87Iv67AKxVWxJr0_GcWl84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0DM2AI
        xVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20x
        vE14v26r126r1DMcIj6I8E87Iv67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xv
        r2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7MxkIecxEwVAFwVW8CwCF04k20x
        vY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I
        3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIx
        AIcVC0I7IYx2IY67AKxVWUCVW8JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAI
        cVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j6F4UMIIF0xvEx4A2js
        IEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUx-BiUUUUU=
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is no git tree for NVMEM FRAMEWORK in MAINTAINERS, it is not
convinent to rebase, add it.

Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 7b58ca2..bd268978 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -12100,6 +12100,7 @@ F:	drivers/nvme/target/
 NVMEM FRAMEWORK
 M:	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
 S:	Maintained
+T:	git git://git.kernel.org/pub/scm/linux/kernel/git/srini/nvmem.git
 F:	Documentation/ABI/stable/sysfs-bus-nvmem
 F:	Documentation/devicetree/bindings/nvmem/
 F:	drivers/nvmem/
-- 
2.1.0

