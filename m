Return-Path: <SRS0=flzY=3U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4065DC2D0DB
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jan 2020 13:34:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 179BA20707
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jan 2020 13:34:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="kldBf1Jq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728809AbgAaNe4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jan 2020 08:34:56 -0500
Received: from pegase1.c-s.fr ([93.17.236.30]:15039 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728566AbgAaNey (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jan 2020 08:34:54 -0500
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 488J9k41Hxz9vCRl;
        Fri, 31 Jan 2020 14:34:50 +0100 (CET)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=kldBf1Jq; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id 7Doksu1MUFue; Fri, 31 Jan 2020 14:34:50 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 488J9k2CS5z9vCRQ;
        Fri, 31 Jan 2020 14:34:50 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1580477690; bh=yjeOkkdnIAVzvXbPQKtmCdezfzfrmvbeUsnidR8x8lU=;
        h=In-Reply-To:References:From:Subject:To:Cc:Date:From;
        b=kldBf1Jq8brlzteB+o+MvnYVYrdIsuR/Z6QUzREWfJMhi02gAqDgie153URDEP2Aa
         6MqRxIlcvHbQ/RmrFKRWR8ZSySH13TkUtkZXx0P+xZGHaRuVBCDM5LGSWYf/YYATqg
         /YJX8459OVGO6h2b4RI2tGFVGPJW4rICogcDTEhE=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 793B98B8AA;
        Fri, 31 Jan 2020 14:34:51 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id D5Zvce7c_cPs; Fri, 31 Jan 2020 14:34:51 +0100 (CET)
Received: from po14934vm.idsi0.si.c-s.fr (po15451.idsi0.si.c-s.fr [172.25.230.105])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 587D28B8A2;
        Fri, 31 Jan 2020 14:34:51 +0100 (CET)
Received: by po14934vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id 51EA765288; Fri, 31 Jan 2020 13:34:51 +0000 (UTC)
Message-Id: <84bae382f67269837d3b68300c8cb26e8c3b9055.1580477672.git.christophe.leroy@c-s.fr>
In-Reply-To: <84be5ad6a996adf5693260749dcb4d8c69182073.1580477672.git.christophe.leroy@c-s.fr>
References: <84be5ad6a996adf5693260749dcb4d8c69182073.1580477672.git.christophe.leroy@c-s.fr>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v2 3/7] powerpc/mm/ptdump: debugfs handler for W+X checks at
 runtime
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>, ruscur@russell.cc
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Fri, 31 Jan 2020 13:34:51 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Russell Currey <ruscur@russell.cc>

Very rudimentary, just

	echo 1 > [debugfs]/check_wx_pages

and check the kernel log.  Useful for testing strict module RWX.

Updated the Kconfig entry to reflect this.

Also fixed a typo.

Signed-off-by: Russell Currey <ruscur@russell.cc>
---
v2: no change
Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/Kconfig.debug      |  6 ++++--
 arch/powerpc/mm/ptdump/ptdump.c | 21 ++++++++++++++++++++-
 2 files changed, 24 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/Kconfig.debug b/arch/powerpc/Kconfig.debug
index 0b063830eea8..e37960ef68c6 100644
--- a/arch/powerpc/Kconfig.debug
+++ b/arch/powerpc/Kconfig.debug
@@ -370,7 +370,7 @@ config PPC_PTDUMP
 	  If you are unsure, say N.
 
 config PPC_DEBUG_WX
-	bool "Warn on W+X mappings at boot"
+	bool "Warn on W+X mappings at boot & enable manual checks at runtime"
 	depends on PPC_PTDUMP && STRICT_KERNEL_RWX
 	help
 	  Generate a warning if any W+X mappings are found at boot.
@@ -384,7 +384,9 @@ config PPC_DEBUG_WX
 	  of other unfixed kernel bugs easier.
 
 	  There is no runtime or memory usage effect of this option
-	  once the kernel has booted up - it's a one time check.
+	  once the kernel has booted up, it only automatically checks once.
+
+	  Enables the "check_wx_pages" debugfs entry for checking at runtime.
 
 	  If in doubt, say "Y".
 
diff --git a/arch/powerpc/mm/ptdump/ptdump.c b/arch/powerpc/mm/ptdump/ptdump.c
index 206156255247..a15e19a3b14e 100644
--- a/arch/powerpc/mm/ptdump/ptdump.c
+++ b/arch/powerpc/mm/ptdump/ptdump.c
@@ -4,7 +4,7 @@
  *
  * This traverses the kernel pagetables and dumps the
  * information about the used sections of memory to
- * /sys/kernel/debug/kernel_pagetables.
+ * /sys/kernel/debug/kernel_page_tables.
  *
  * Derived from the arm64 implementation:
  * Copyright (c) 2014, The Linux Foundation, Laura Abbott.
@@ -413,6 +413,25 @@ void ptdump_check_wx(void)
 	else
 		pr_info("Checked W+X mappings: passed, no W+X pages found\n");
 }
+
+static int check_wx_debugfs_set(void *data, u64 val)
+{
+	if (val != 1ULL)
+		return -EINVAL;
+
+	ptdump_check_wx();
+
+	return 0;
+}
+
+DEFINE_SIMPLE_ATTRIBUTE(check_wx_fops, NULL, check_wx_debugfs_set, "%llu\n");
+
+static int ptdump_check_wx_init(void)
+{
+	return debugfs_create_file("check_wx_pages", 0200, NULL,
+				   NULL, &check_wx_fops) ? 0 : -ENOMEM;
+}
+device_initcall(ptdump_check_wx_init);
 #endif
 
 static int ptdump_init(void)
-- 
2.25.0

