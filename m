Return-Path: <SRS0=CUu6=46=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F42EC10DCE
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 15:05:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 09D182074A
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 15:05:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726930AbgCMPFS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Mar 2020 11:05:18 -0400
Received: from m176115.mail.qiye.163.com ([59.111.176.115]:46360 "EHLO
        m176115.mail.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726591AbgCMPFR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Mar 2020 11:05:17 -0400
X-Greylist: delayed 650 seconds by postgrey-1.27 at vger.kernel.org; Fri, 13 Mar 2020 11:05:14 EDT
Received: from localhost.localdomain (unknown [58.251.74.227])
        by m176115.mail.qiye.163.com (Hmail) with ESMTPA id 975B066499B;
        Fri, 13 Mar 2020 22:54:19 +0800 (CST)
From:   Zheng Wei <wei.zheng@vivo.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Hanjun Guo <guohanjun@huawei.com>,
        Enrico Weigelt <info@metux.net>,
        Allison Randal <allison@lohutok.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Zheng Wei <wei.zheng@vivo.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Yunfeng Ye <yeyunfeng@huawei.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     kernel@vivo.com, wenhu.wang@vivo.com
Subject: [PATCH] arm64: add blank after 'if'
Date:   Fri, 13 Mar 2020 22:54:02 +0800
Message-Id: <20200313145403.6395-1-wei.zheng@vivo.com>
X-Mailer: git-send-email 2.17.1
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgYFAkeWUFZT1VCTktCQkJMSE1MQ05DQllXWShZQU
        hPN1dZLVlBSVdZCQ4XHghZQVk1NCk2OjckKS43PlkG
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6ME06SQw5Lzg0MDArFipCUVY4
        SjcwCh9VSlVKTkNPSkpKSU1LSkJKVTMWGhIXVQweElUBEx4VHDsNEg0UVRgUFkVZV1kSC1lBWU5D
        VUlOSlVMT1VJSUxZV1kIAVlBSUpPSjcG
X-HM-Tid: 0a70d46391c29373kuws975b066499b
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

add blank after 'if' for armv8_deprecated_init()
to make it comply with kernel coding style.

Signed-off-by: Zheng Wei <wei.zheng@vivo.com>
---
 arch/arm64/kernel/armv8_deprecated.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/kernel/armv8_deprecated.c b/arch/arm64/kernel/armv8_deprecated.c
index 7832b3216370..4cc581af2d96 100644
--- a/arch/arm64/kernel/armv8_deprecated.c
+++ b/arch/arm64/kernel/armv8_deprecated.c
@@ -630,7 +630,7 @@ static int __init armv8_deprecated_init(void)
 		register_insn_emulation(&cp15_barrier_ops);
 
 	if (IS_ENABLED(CONFIG_SETEND_EMULATION)) {
-		if(system_supports_mixed_endian_el0())
+		if (system_supports_mixed_endian_el0())
 			register_insn_emulation(&setend_ops);
 		else
 			pr_info("setend instruction emulation is not supported on this system\n");
-- 
2.17.1

