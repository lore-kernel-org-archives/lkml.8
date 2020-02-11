Return-Path: <SRS0=PxPh=37=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51809C352A3
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 13:13:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2516320870
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 13:13:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=monstr-eu.20150623.gappssmtp.com header.i=@monstr-eu.20150623.gappssmtp.com header.b="AhDcWTYs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729139AbgBKNNf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Feb 2020 08:13:35 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:40941 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728604AbgBKNNe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Feb 2020 08:13:34 -0500
Received: by mail-wm1-f65.google.com with SMTP id t14so3519661wmi.5
        for <linux-kernel@vger.kernel.org>; Tue, 11 Feb 2020 05:13:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=monstr-eu.20150623.gappssmtp.com; s=20150623;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TM3D5gJmLNcWVrpmlMmrLPvgDmF2FwGOuN5DI7d3s1Q=;
        b=AhDcWTYsyh0N+Ep8GLiV9XmWq4Rj+NQC5sqjSOU5PxOAHfnwDML0cTkwS0SZgftZR9
         SoCNDybhZ7GW4bCi9AIJEOKj8d1hAZWjTEfmOi37ybqt/YnUgdOeKLSCmdPqC4+3LN8B
         3FQtAvk4bI7F4NN29FsGgjUe8ncwyh7RTaSJiyEToYQBQrfHusokHwwGsaOgr9e+qUFR
         mjPGWm7OthZhnV6HZ9/IBq61MNVubH2MaMUNr2N/myYiIeTuB4SXZZ183bhXRKO5ZMG9
         kMfgeWeBVx/oUP3aCKcg0ctSFUtEr7CGeD6g7pl+1BwA1NGxCPB+1k4DrStgOucxEXRu
         hWxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=TM3D5gJmLNcWVrpmlMmrLPvgDmF2FwGOuN5DI7d3s1Q=;
        b=rK39psfu3rvRrnleKBz4uuqiQvqczBnxVSyj4g9+TpHGPn2lg2fexuJKG1+QHJf70w
         G6sGnO90HfaNDTTNwFeVEA3lGPQE3hFy13TPSSRoUIYxMfLV6lgwrS0zubCqOLis+40F
         krTw0Ma4nKTKHOtsH0lVDLZdbz71qR3VFQ+9ATabrpO2jJHgK1NlY/oOofKQ6WX4WCke
         W1rtTuLsceFRk+6LaRGcoIjP9+aA4QtbnQ6OUegTclWd4lAZ6SX6StlSZEZE9hHe+woZ
         RGHIsDHTRf6rxmKA+Vgh4MKMtpTOxKhzhg7eaeJVG+AacoepRCymPV0OkiEQOCePu2uQ
         OpgA==
X-Gm-Message-State: APjAAAVDY/PTppIDsq56leW2fZ6wYwuiC5m1zG8Ut9d4+SHLKQekExqL
        V+Hbnj+LUnGyRKaWAfUaJR9ykeXG2ChK6g==
X-Google-Smtp-Source: APXvYqwt34ByPAzkvLONxky/4m1GSJHbBoG+a20VJ1gEoN/FcP62d54Rj6Dq3OuTU/gFq9p6qtHZ2g==
X-Received: by 2002:a1c:66d6:: with SMTP id a205mr5620935wmc.10.1581426812372;
        Tue, 11 Feb 2020 05:13:32 -0800 (PST)
Received: from localhost (nat-35.starnet.cz. [178.255.168.35])
        by smtp.gmail.com with ESMTPSA id x11sm3694490wmg.46.2020.02.11.05.13.31
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 11 Feb 2020 05:13:31 -0800 (PST)
From:   Michal Simek <michal.simek@xilinx.com>
To:     linux-kernel@vger.kernel.org, monstr@monstr.eu,
        michal.simek@xilinx.com, git@xilinx.com
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
Subject: [PATCH v2] microblaze: Kernel parameters should be parsed earlier
Date:   Tue, 11 Feb 2020 14:13:30 +0100
Message-Id: <06e23d4a305d87bb1f3403b3130f130d784399c1.1581426806.git.michal.simek@xilinx.com>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kernel command line should be parsed before cma initialization to be able
to get cma sizes from command line. That's why call parse_early_param()
before dma_continugous_reserve().

Unfortunately it can't be called earlier in machine_early_init() because
if earlycon is passed in the command line the parse_early_param() attempts
an ioremap which fails as the memory params are not set yet.

Signed-off-by: Michal Simek <michal.simek@xilinx.com>
Signed-off-by: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
---

Changes in v2:
- Fix case with earlycon

 arch/microblaze/kernel/setup.c | 1 -
 arch/microblaze/mm/init.c      | 2 ++
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/microblaze/kernel/setup.c b/arch/microblaze/kernel/setup.c
index 511c1ab7f57f..a8fc15ac4291 100644
--- a/arch/microblaze/kernel/setup.c
+++ b/arch/microblaze/kernel/setup.c
@@ -54,7 +54,6 @@ void __init setup_arch(char **cmdline_p)
 	*cmdline_p = boot_command_line;
 
 	setup_memory();
-	parse_early_param();
 
 	console_verbose();
 
diff --git a/arch/microblaze/mm/init.c b/arch/microblaze/mm/init.c
index 1056f1674065..9899ff2ef9b6 100644
--- a/arch/microblaze/mm/init.c
+++ b/arch/microblaze/mm/init.c
@@ -347,6 +347,8 @@ asmlinkage void __init mmu_init(void)
 	 * inside 768MB limit */
 	memblock_set_current_limit(memory_start + lowmem_size - 1);
 
+	parse_early_param();
+
 	/* CMA initialization */
 	dma_contiguous_reserve(memory_start + lowmem_size - 1);
 }
-- 
2.25.0

