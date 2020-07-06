Return-Path: <SRS0=eGSO=AR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66ACEC433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 12:32:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4B59E206E6
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 12:32:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729121AbgGFMc2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jul 2020 08:32:28 -0400
Received: from mx2.suse.de ([195.135.220.15]:57772 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728414AbgGFMc1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jul 2020 08:32:27 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 1C59DAC46;
        Mon,  6 Jul 2020 12:32:27 +0000 (UTC)
From:   Andreas Schwab <schwab@suse.de>
To:     linux-riscv@lists.infradead.org
Subject: [PATCH] riscv: use 16KB kernel stack on 64-bit
CC:     linux-kernel@vger.kernel.org
X-Yow:  There's a lot of BIG MONEY in MISERY if you have an AGENT!!
Date:   Mon, 06 Jul 2020 14:32:26 +0200
Message-ID: <mvmeepoddt1.fsf@suse.de>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.0.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With the current 8KB stack size there are frequent overflows in a 64-bit
configuration.

Signed-off-by: Andreas Schwab <schwab@suse.de>
---
 arch/riscv/include/asm/thread_info.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/riscv/include/asm/thread_info.h b/arch/riscv/include/asm/thread_info.h
index 1dd12a0cbb2b..464a2bbc97ea 100644
--- a/arch/riscv/include/asm/thread_info.h
+++ b/arch/riscv/include/asm/thread_info.h
@@ -12,7 +12,11 @@
 #include <linux/const.h>
 
 /* thread information allocation */
+#ifdef CONFIG_64BIT
+#define THREAD_SIZE_ORDER	(2)
+#else
 #define THREAD_SIZE_ORDER	(1)
+#endif
 #define THREAD_SIZE		(PAGE_SIZE << THREAD_SIZE_ORDER)
 
 #ifndef __ASSEMBLY__
-- 
2.26.2


-- 
Andreas Schwab, SUSE Labs, schwab@suse.de
GPG Key fingerprint = 0196 BAD8 1CE9 1970 F4BE  1748 E4D4 88E3 0EEA B9D7
"And now for something completely different."
