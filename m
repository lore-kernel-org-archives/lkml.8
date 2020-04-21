Return-Path: <SRS0=8uoY=6F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E658C54FC9
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 08:17:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E62A72073A
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 08:17:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="VzMHbZmG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728567AbgDUIRo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Apr 2020 04:17:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728497AbgDUIRh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Apr 2020 04:17:37 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F95EC061A10
        for <linux-kernel@vger.kernel.org>; Tue, 21 Apr 2020 01:17:37 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id p25so6271515pfn.11
        for <linux-kernel@vger.kernel.org>; Tue, 21 Apr 2020 01:17:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=R51EKoGdprYIzq4mz86f7ksK2LhT5dJfZ4/kQMPqWXU=;
        b=VzMHbZmGtC1cli7/MzDUNjXVYWUl1NxixqtpJm0/9P/EzaLVRa8g8WgYud0Qm6Rchk
         /0trL5SM2/Zrj2mYcg8pq0A+qXdeLRNhfMiAZsy5X8Q7FkKkUcxE3FT4l8B0EtAmdA+a
         qWQTbQU8+OIZBMPZCnCgj1bgpLATeorKYHYYWZhPAzfAJg7qSDI1mvGlLkPsXDXc0xmQ
         nHxUsek7TS8kNEMxedKCaVU/PPk6efmG7yA1N7bxrcxILkRxr4XHk7vAf799he9GgfVg
         ZXr8nDGGsq+0uBoSEWHxoMPWrO9TNXqLg4+rs5s/lfX6Mf18km5fSJ2iKKhhbu7/Mopp
         enAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=R51EKoGdprYIzq4mz86f7ksK2LhT5dJfZ4/kQMPqWXU=;
        b=Ya77saszxe2EG8M8sTlc+Ra5JZWWyksbjLA0QJx/ZBhCF0H/N9xtglsE2Oc1JVvMG9
         peKYfZyH9JHfpxZwGU8LN1PCiEN0l4+FPKrOXZA/9yLhRMLr/4c+MJiarnXXsRQh1mSy
         nahZlMtEkK53BFCBof8V/jvDrCWnZ8ZrD9vK+Gt+96AxE41tO3BUr9yCHL9CrMfHybCB
         2N2kEHB9Q66BrWiYrOZ1wpf87Tod3+TOrsiE+V0yD4LNnhERWkjMRVilx4lTyDEgdKic
         +bml1FDwInCQwOzwjJTJdk6TW5UxovbDC7HFpPnXcF5Gpb8T9lBqCzZj24HA1KYNN9gI
         kK6g==
X-Gm-Message-State: AGi0PuYVBNMjDvRtfq2Nfiv5T0Bn3lcDx/LWeVrakSAfKWriWqp0b5bm
        U559ReZ3Yywo4U/+2kknX7Tq2g==
X-Google-Smtp-Source: APiQypJD+fzqoCjmoNF33zw6GUvSp1zVm+GJEMjBcSfH6XjMDUyeBTOm2mgFujSrzxWUd3wuELt89Q==
X-Received: by 2002:a63:4e21:: with SMTP id c33mr21379911pgb.305.1587457056828;
        Tue, 21 Apr 2020 01:17:36 -0700 (PDT)
Received: from hsinchu02.internal.sifive.com (114-34-229-221.HINET-IP.hinet.net. [114.34.229.221])
        by smtp.gmail.com with ESMTPSA id v9sm1610067pju.3.2020.04.21.01.17.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2020 01:17:36 -0700 (PDT)
From:   Zong Li <zong.li@sifive.com>
To:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, paul.walmsley@sifive.com,
        palmer@dabbelt.com, linux-riscv@lists.infradead.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, x86@kernel.org,
        hpa@zytor.com, catalin.marinas@arm.com, will@kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     Zong Li <zong.li@sifive.com>
Subject: [PATCH 4/4] arm64: mm: use ARCH_HAS_DEBUG_WX instead of arch defined
Date:   Tue, 21 Apr 2020 16:17:15 +0800
Message-Id: <e19709e7576f65e303245fe520cad5f7bae72763.1587455584.git.zong.li@sifive.com>
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
 arch/arm64/Kconfig       |  1 +
 arch/arm64/Kconfig.debug | 29 -----------------------------
 2 files changed, 1 insertion(+), 29 deletions(-)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 40fb05d96c60..a16e2ce80854 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -9,6 +9,7 @@ config ARM64
 	select ACPI_MCFG if (ACPI && PCI)
 	select ACPI_SPCR_TABLE if ACPI
 	select ACPI_PPTT if ACPI
+	select ARCH_HAS_DEBUG_WX
 	select ARCH_HAS_DEBUG_VIRTUAL
 	select ARCH_HAS_DEVMEM_IS_ALLOWED
 	select ARCH_HAS_DMA_PREP_COHERENT
diff --git a/arch/arm64/Kconfig.debug b/arch/arm64/Kconfig.debug
index a1efa246c9ed..cdf7ec0b975e 100644
--- a/arch/arm64/Kconfig.debug
+++ b/arch/arm64/Kconfig.debug
@@ -23,35 +23,6 @@ config ARM64_RANDOMIZE_TEXT_OFFSET
 	  of TEXT_OFFSET and platforms must not require a specific
 	  value.
 
-config DEBUG_WX
-	bool "Warn on W+X mappings at boot"
-	select PTDUMP_CORE
-	---help---
-	  Generate a warning if any W+X mappings are found at boot.
-
-	  This is useful for discovering cases where the kernel is leaving
-	  W+X mappings after applying NX, as such mappings are a security risk.
-	  This check also includes UXN, which should be set on all kernel
-	  mappings.
-
-	  Look for a message in dmesg output like this:
-
-	    arm64/mm: Checked W+X mappings: passed, no W+X pages found.
-
-	  or like this, if the check failed:
-
-	    arm64/mm: Checked W+X mappings: FAILED, <N> W+X pages found.
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
 config DEBUG_EFI
 	depends on EFI && DEBUG_INFO
 	bool "UEFI debugging"
-- 
2.26.1

