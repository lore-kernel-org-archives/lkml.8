Return-Path: <SRS0=8uoY=6F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 346E8C54FC9
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 08:17:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0EA3A2098B
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 08:17:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="d1EGEWeH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727911AbgDUIRk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Apr 2020 04:17:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728513AbgDUIRf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Apr 2020 04:17:35 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6518BC061A0F
        for <linux-kernel@vger.kernel.org>; Tue, 21 Apr 2020 01:17:34 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id t9so1062408pjw.0
        for <linux-kernel@vger.kernel.org>; Tue, 21 Apr 2020 01:17:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ESIASWIVcw318N0kQ2X0Oi3Z+uroC+zqbTtsgDKDwxc=;
        b=d1EGEWeHYHIQOJqJjvQeV7F5XbEP5dKBW7WEsc7KqFePlpur3HEhURVt2nLAxU8R+t
         LZja7jNyrv/MqDehV+bIv3O2awu6Vc6wo5ja/99Fg3/zkOA/b8rUd12iwLrEVBqYNlL8
         LTf7evXymEDmOXlZdm6r9x20Y2/6tY/73gMtdIWA1Ts91bYya8o7iZL7Qbyo1a9l5cHq
         Mb2NIZKnrqizgtSPU1Euc0ALQsGOdKx8TVzUdXCIOumRJtoGHAnWec62IkND8QTrmOQM
         nPH12sz33bLqzDbK623zAsgvXfGv/SPO4JkjRvc6iRfRE03SIsd9LDw4+o2qcXqrSP8N
         SPpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ESIASWIVcw318N0kQ2X0Oi3Z+uroC+zqbTtsgDKDwxc=;
        b=OlfhIPL6giXaFW6BT7szYRIT4ZFvjBF534y27PH+cd3QMWMXWDxR+k9SXAtZ2jSvJx
         qTITndsn6/oRxzrkdOhOTzeVXxn5ozg3LrKZR2H8p793m1GFejpiWscILDg5bRGvZZ9l
         QUFyh82x+x9xEQI/ImGPG/dOaPDz6qCcGHD7RqJJnFnr+61A7RYcVdomLUD8aUn4mecV
         6HpuLiFv4INHCpOLWjK9+iEyLatCSpcyFAKS5/VpcQ5e6reXP1JmwqZxNCn2QTNrfZ8C
         ZxgMBYWXIUBqMlRdaV8+M2H81qbm0XzICk+bBtnaFY2LlvppFoXbBi/0rImeJmWaiwDa
         TUIw==
X-Gm-Message-State: AGi0PuaVn4FKkNkKnyCLzNeBUEmI/jrIVAghYyzWEJ/UndQvDj1yw5Ag
        Ol9KBGzX6SuvO7gOqvv6WmtJOQ==
X-Google-Smtp-Source: APiQypI7y+F6n5TeayUTsoUy+jp+f5r/1IV7aARGN/1mj8/tNHv7iVWTrDqjni/i9mOVUg3YAWeuFQ==
X-Received: by 2002:a17:90a:7e4:: with SMTP id m91mr4322055pjm.155.1587457053972;
        Tue, 21 Apr 2020 01:17:33 -0700 (PDT)
Received: from hsinchu02.internal.sifive.com (114-34-229-221.HINET-IP.hinet.net. [114.34.229.221])
        by smtp.gmail.com with ESMTPSA id v9sm1610067pju.3.2020.04.21.01.17.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2020 01:17:33 -0700 (PDT)
From:   Zong Li <zong.li@sifive.com>
To:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, paul.walmsley@sifive.com,
        palmer@dabbelt.com, linux-riscv@lists.infradead.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, x86@kernel.org,
        hpa@zytor.com, catalin.marinas@arm.com, will@kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     Zong Li <zong.li@sifive.com>
Subject: [PATCH 3/4] x86: mm: use ARCH_HAS_DEBUG_WX instead of arch defined
Date:   Tue, 21 Apr 2020 16:17:14 +0800
Message-Id: <430736828d149df3f5b462d291e845ec690e0141.1587455584.git.zong.li@sifive.com>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <cover.1587455584.git.zong.li@sifive.com>
References: <cover.1587455584.git.zong.li@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Extract DEBUG_WX to mm/Kconfig.debug for shared use. Change to use
ARCH_HAS_DEBUG_WX instead of DEBUG_WX defined by arch port.

Signed-off-by: Zong Li <zong.li@sifive.com>
---
 arch/x86/Kconfig       |  1 +
 arch/x86/Kconfig.debug | 27 ---------------------------
 2 files changed, 1 insertion(+), 27 deletions(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 1d6104ea8af0..310a49ee3c25 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -80,6 +80,7 @@ config X86
 	select ARCH_HAS_SYNC_CORE_BEFORE_USERMODE
 	select ARCH_HAS_SYSCALL_WRAPPER
 	select ARCH_HAS_UBSAN_SANITIZE_ALL
+	select ARCH_HAS_DEBUG_WX
 	select ARCH_HAVE_NMI_SAFE_CMPXCHG
 	select ARCH_MIGHT_HAVE_ACPI_PDC		if ACPI
 	select ARCH_MIGHT_HAVE_PC_PARPORT
diff --git a/arch/x86/Kconfig.debug b/arch/x86/Kconfig.debug
index 2e74690b028a..de1846ed41b3 100644
--- a/arch/x86/Kconfig.debug
+++ b/arch/x86/Kconfig.debug
@@ -72,33 +72,6 @@ config EFI_PGT_DUMP
 	  issues with the mapping of the EFI runtime regions into that
 	  table.
 
-config DEBUG_WX
-	bool "Warn on W+X mappings at boot"
-	select PTDUMP_CORE
-	---help---
-	  Generate a warning if any W+X mappings are found at boot.
-
-	  This is useful for discovering cases where the kernel is leaving
-	  W+X mappings after applying NX, as such mappings are a security risk.
-
-	  Look for a message in dmesg output like this:
-
-	    x86/mm: Checked W+X mappings: passed, no W+X pages found.
-
-	  or like this, if the check failed:
-
-	    x86/mm: Checked W+X mappings: FAILED, <N> W+X pages found.
-
-	  Note that even if the check fails, your kernel is possibly
-	  still fine, as W+X mappings are not a security hole in
-	  themselves, what they do is that they make the exploitation
-	  of other unfixed kernel bugs easier.
-
-	  There is no runtime or memory usage effect of this option
-	  once the kernel has booted up - it's a one time check.
-
-	  If in doubt, say "Y".
-
 config DOUBLEFAULT
 	default y
 	bool "Enable doublefault exception handler" if EXPERT && X86_32
-- 
2.26.1

