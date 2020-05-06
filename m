Return-Path: <SRS0=F+sq=6U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B5DDC47259
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 07:15:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4B97720747
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 07:15:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="eweeDNwq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728290AbgEFHP3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 May 2020 03:15:29 -0400
Received: from mail.skyhub.de ([5.9.137.197]:33178 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727872AbgEFHP1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 May 2020 03:15:27 -0400
Received: from zn.tnic (p200300EC2F069600BCEB9C28D5742179.dip0.t-ipconnect.de [IPv6:2003:ec:2f06:9600:bceb:9c28:d574:2179])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 665441EC034D;
        Wed,  6 May 2020 09:15:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1588749325;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5Y1LKdIe6AwRk77dYxxaTqOxnCcHgugdRw6EHw3KhTc=;
        b=eweeDNwqDpZYaBwopJZuyJ8687QOQIO387q9fxgULSpZv+hrovXk6wO8Z4TzeXbINv5nl5
        Rzk/r2VnS/uzZTy3iQa4aQFpWFjtmwezPvWAYxvkgHmIu/5CFVIIk8krHYjNHxQdX98jiH
        K8i4t73CR2D7OB6RsEvh49hgOXmxxfM=
From:   Borislav Petkov <bp@alien8.de>
To:     X86 ML <x86@kernel.org>
Cc:     Mark Gross <mgross@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH 3/3] x86/apic: Convert the TSC deadline timer matching to steppings macro
Date:   Wed,  6 May 2020 09:15:16 +0200
Message-Id: <20200506071516.25445-4-bp@alien8.de>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200506071516.25445-1-bp@alien8.de>
References: <20200506071516.25445-1-bp@alien8.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Borislav Petkov <bp@suse.de>

... and get rid of the function pointers which would spit out the
microcode revision based on the CPU stepping.

Signed-off-by: Borislav Petkov <bp@suse.de>
Cc: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/kernel/apic/apic.c | 57 ++++++++-----------------------------
 1 file changed, 12 insertions(+), 45 deletions(-)

diff --git a/arch/x86/kernel/apic/apic.c b/arch/x86/kernel/apic/apic.c
index e53dda210cd7..4b1d31be50b4 100644
--- a/arch/x86/kernel/apic/apic.c
+++ b/arch/x86/kernel/apic/apic.c
@@ -544,46 +544,20 @@ static struct clock_event_device lapic_clockevent = {
 };
 static DEFINE_PER_CPU(struct clock_event_device, lapic_events);
 
-static __init u32 hsx_deadline_rev(void)
-{
-	switch (boot_cpu_data.x86_stepping) {
-	case 0x02: return 0x3a; /* EP */
-	case 0x04: return 0x0f; /* EX */
-	}
-
-	return ~0U;
-}
-
-static __init u32 bdx_deadline_rev(void)
-{
-	switch (boot_cpu_data.x86_stepping) {
-	case 0x02: return 0x00000011;
-	case 0x03: return 0x0700000e;
-	case 0x04: return 0x0f00000c;
-	case 0x05: return 0x0e000003;
-	}
-
-	return ~0U;
-}
-
-static __init u32 skx_deadline_rev(void)
-{
-	switch (boot_cpu_data.x86_stepping) {
-	case 0x03: return 0x01000136;
-	case 0x04: return 0x02000014;
-	}
+static const struct x86_cpu_id deadline_match[] __initconst = {
+	X86_MATCH_INTEL_FAM6_MODEL_STEPPINGS(HASWELL_X, X86_STEPPINGS(0x2, 0x2), 0x3a), /* EP */
+	X86_MATCH_INTEL_FAM6_MODEL_STEPPINGS(HASWELL_X, X86_STEPPINGS(0x4, 0x4), 0x0f), /* EX */
 
-	if (boot_cpu_data.x86_stepping > 4)
-		return 0;
+	X86_MATCH_INTEL_FAM6_MODEL( BROADWELL_X,	0x0b000020),
 
-	return ~0U;
-}
+	X86_MATCH_INTEL_FAM6_MODEL_STEPPINGS(BROADWELL_D, X86_STEPPINGS(0x2, 0x2), 0x00000011),
+	X86_MATCH_INTEL_FAM6_MODEL_STEPPINGS(BROADWELL_D, X86_STEPPINGS(0x3, 0x3), 0x0700000e),
+	X86_MATCH_INTEL_FAM6_MODEL_STEPPINGS(BROADWELL_D, X86_STEPPINGS(0x4, 0x4), 0x0f00000c),
+	X86_MATCH_INTEL_FAM6_MODEL_STEPPINGS(BROADWELL_D, X86_STEPPINGS(0x5, 0x5), 0x0e000003),
 
-static const struct x86_cpu_id deadline_match[] __initconst = {
-	X86_MATCH_INTEL_FAM6_MODEL( HASWELL_X,		&hsx_deadline_rev),
-	X86_MATCH_INTEL_FAM6_MODEL( BROADWELL_X,	0x0b000020),
-	X86_MATCH_INTEL_FAM6_MODEL( BROADWELL_D,	&bdx_deadline_rev),
-	X86_MATCH_INTEL_FAM6_MODEL( SKYLAKE_X,		&skx_deadline_rev),
+	X86_MATCH_INTEL_FAM6_MODEL_STEPPINGS(SKYLAKE_X, X86_STEPPINGS(0x3, 0x3), 0x01000136),
+	X86_MATCH_INTEL_FAM6_MODEL_STEPPINGS(SKYLAKE_X, X86_STEPPINGS(0x4, 0x4), 0x02000014),
+	X86_MATCH_INTEL_FAM6_MODEL_STEPPINGS(SKYLAKE_X, X86_STEPPINGS(0x5, 0xf), 0),
 
 	X86_MATCH_INTEL_FAM6_MODEL( HASWELL,		0x22),
 	X86_MATCH_INTEL_FAM6_MODEL( HASWELL_L,		0x20),
@@ -615,14 +589,7 @@ static __init bool apic_validate_deadline_timer(void)
 	if (!m)
 		return true;
 
-	/*
-	 * Function pointers will have the MSB set due to address layout,
-	 * immediate revisions will not.
-	 */
-	if ((long)m->driver_data < 0)
-		rev = ((u32 (*)(void))(m->driver_data))();
-	else
-		rev = (u32)m->driver_data;
+	rev = (u32)m->driver_data;
 
 	if (boot_cpu_data.microcode >= rev)
 		return true;
-- 
2.21.0

