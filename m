Return-Path: <SRS0=KEJG=BY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D3C4C433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Aug 2020 17:30:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E84232078D
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Aug 2020 17:30:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VBd8Y8/0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728901AbgHNRaD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Aug 2020 13:30:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728709AbgHNR2R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Aug 2020 13:28:17 -0400
Received: from mail-qv1-xf49.google.com (mail-qv1-xf49.google.com [IPv6:2607:f8b0:4864:20::f49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4D06C061384
        for <linux-kernel@vger.kernel.org>; Fri, 14 Aug 2020 10:28:16 -0700 (PDT)
Received: by mail-qv1-xf49.google.com with SMTP id c4so6503331qvq.15
        for <linux-kernel@vger.kernel.org>; Fri, 14 Aug 2020 10:28:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=LewkbAtBTS3fxa2ioFCrxocMUQLUBlN7d9swTrdmfVk=;
        b=VBd8Y8/0sCJNp9OLxtpbP3YFD0V7v4ivH9Cj8L45fMKAxsbpM/7wFGcDUQeyy72z7+
         0+83oUrkvXL/wVWdOLiGRPDkN9cxYy25dwFuY6WlobJRoBw5Hv9a+2zjxhhnyquGKy9S
         2EZU9tkO5wLg8/RgIx9m7DsZYXR3314Znfr6vJ3MNxMoELwXKZlF+NlGBiOEjdt+YbH/
         M8jvnzzivlTluFx2uqs4r137zk+fAgcIbSEWAReQBWWz/UFUwoH8b3I68Z73ieYmMigU
         ntrskJrbnmV1HFKyooD68AjgyDl3B/zvkVc8r7dyFNQz5HrEOh+GjWU5ZP9+NGOy7Czk
         g76Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=LewkbAtBTS3fxa2ioFCrxocMUQLUBlN7d9swTrdmfVk=;
        b=gYxEsHaW+Xpx6kJFcTftc9XOLR16gbdvBw66t8gMw0CYH0OTTatYNv658YtmTNtfJB
         QbiUm0hlnS53ppfg/WQ6uAS0HluJPUqKL9MjiLzFBhXG9Ipnkx+A/pRS9UVe6pPuYhaG
         iOT3WHdF6ZOoBSXei3Y5a1vhxbLlLxu2O6JJ+61JJqqP4DRUFdLayOXqVOhcpIj3oB4D
         Ga0toLUw4uMupDMMnWK3EmfdsteONX5mNui3FqrOvpcSyVXUM3LuiZr0k1BLkvZGwAyV
         n49gvIm1sQkyxdAB9HfzrJdH/T9C74mbdwIylFDv4qCX7l31QNLqF5s4OnTJKTOFyfXP
         G0mw==
X-Gm-Message-State: AOAM530k1YCZvHiGYiHgwZ5CexoH33THsTRkCiVMB/mRRkSdNIBtlFlN
        H5I5XAEzdkuU3bA3XsL1rXI+HdRWAUuQn7xo
X-Google-Smtp-Source: ABdhPJwkBrAQ8GyLssKpf9q7VKymTxaofLqPPbiLmDAQiv3UZOFrLINHymedM0M36JyCRp99bnQq9F+T3nsH6DvR
X-Received: by 2002:ad4:4b0b:: with SMTP id r11mr3633062qvw.94.1597426095910;
 Fri, 14 Aug 2020 10:28:15 -0700 (PDT)
Date:   Fri, 14 Aug 2020 19:27:04 +0200
In-Reply-To: <cover.1597425745.git.andreyknvl@google.com>
Message-Id: <6a83a47d9954935d37a654978e96c951cc56a2f6.1597425745.git.andreyknvl@google.com>
Mime-Version: 1.0
References: <cover.1597425745.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.28.0.220.ged08abb693-goog
Subject: [PATCH 22/35] arm64: mte: Enable in-kernel MTE
From:   Andrey Konovalov <andreyknvl@google.com>
To:     Dmitry Vyukov <dvyukov@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        kasan-dev@googlegroups.com
Cc:     Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Elena Petrova <lenaptr@google.com>,
        Branislav Rankov <Branislav.Rankov@arm.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vincenzo Frascino <vincenzo.frascino@arm.com>

The Tag Checking operation causes a synchronous data abort as
a consequence of a tag check fault when MTE is configured in
synchronous mode.

Enable MTE in Synchronous mode in EL1 to provide a more immediate
way of tag check failure detection in the kernel.

As part of this change enable match-all tag for EL1 to allow the
kernel to access user pages without faulting. This is required because
the kernel does not have knowledge of the tags set by the user in a
page.

Note: For MTE, the TCF bit field in SCTLR_EL1 affects only EL1 in a
similar way as TCF0 affects EL0.

Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
---
 arch/arm64/kernel/cpufeature.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index 4d3abb51f7d4..4d94af19d8f6 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -1670,6 +1670,9 @@ static void cpu_enable_mte(struct arm64_cpu_capabilities const *cap)
 	write_sysreg_s(0, SYS_TFSR_EL1);
 	write_sysreg_s(0, SYS_TFSRE0_EL1);
 
+	/* Enable Match-All at EL1 */
+	sysreg_clear_set(tcr_el1, 0, SYS_TCR_EL1_TCMA1);
+
 	/*
 	 * CnP must be enabled only after the MAIR_EL1 register has been set
 	 * up. Inconsistent MAIR_EL1 between CPUs sharing the same TLB may
@@ -1687,6 +1690,9 @@ static void cpu_enable_mte(struct arm64_cpu_capabilities const *cap)
 	mair &= ~MAIR_ATTRIDX(MAIR_ATTR_MASK, MT_NORMAL_TAGGED);
 	mair |= MAIR_ATTRIDX(MAIR_ATTR_NORMAL_TAGGED, MT_NORMAL_TAGGED);
 	write_sysreg_s(mair, SYS_MAIR_EL1);
+
+	/* Enable MTE Sync Mode for EL1 */
+	sysreg_clear_set(sctlr_el1, SCTLR_ELx_TCF_MASK, SCTLR_ELx_TCF_SYNC);
 	isb();
 
 	local_flush_tlb_all();
-- 
2.28.0.220.ged08abb693-goog

