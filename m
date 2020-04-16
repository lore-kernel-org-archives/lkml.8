Return-Path: <SRS0=1dCa=6A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C75D4C2BB55
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 14:11:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 971BB2076D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 14:11:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587046296;
	bh=wI3rSj/W6AYF4oDxg5zKimwVW/fNHbKwmR8ewd1vzIg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=NisTG+Y/fMLeQSi1DSmxnXn3xO8bEt5WGhwh1WCwruk9QuuyRwHc0Bag47aa3gs5+
	 MWfj6Hik9XTe5iDrVdewr8PdKcx+oRz0/su8IUp4SrCUCNwrr0OfkdUMqBjo+Yeook
	 jEHT1oXSpEc6Wdb26zkmcNAi4zrXj72JC7dEJZjw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393692AbgDPOLe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Apr 2020 10:11:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:33350 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2898639AbgDPNrS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 09:47:18 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CD36621744;
        Thu, 16 Apr 2020 13:47:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587044838;
        bh=wI3rSj/W6AYF4oDxg5zKimwVW/fNHbKwmR8ewd1vzIg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kvwV4+V0/ue1Ujw5PBgfYWIOn2lcweMXogzlRDieOIyOdm490WKudfWzbp4peikPV
         s9Le8pL+xubHxH5v+4K3eaHYhbOT+9T/bBW5Ihr2VLKjmZAThn9r8tzYYxbPJeC7Tl
         yKcekEAZ0Onq4uqbwV9BBs9opXoUzoBTY3I2zsAk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH 5.4 121/232] x86/tsc_msr: Fix MSR_FSB_FREQ mask for Cherry Trail devices
Date:   Thu, 16 Apr 2020 15:23:35 +0200
Message-Id: <20200416131330.241076312@linuxfoundation.org>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20200416131316.640996080@linuxfoundation.org>
References: <20200416131316.640996080@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hans de Goede <hdegoede@redhat.com>

commit c8810e2ffc30c7e1577f9c057c4b85d984bbc35a upstream.

According to the "Intel 64 and IA-32 Architectures Software Developer's
Manual Volume 4: Model-Specific Registers" on Cherry Trail (Airmont)
devices the 4 lowest bits of the MSR_FSB_FREQ mask indicate the bus freq
unlike on e.g. Bay Trail where only the lowest 3 bits are used.

This is also the reason why MAX_NUM_FREQS is defined as 9, since Cherry
Trail SoCs have 9 possible frequencies, so the lo value from the MSR needs
to be masked with 0x0f, not with 0x07 otherwise the 9th frequency will get
interpreted as the 1st.

Bump MAX_NUM_FREQS to 16 to avoid any possibility of addressing the array
out of bounds and makes the mask part of the cpufreq struct so it can be
set it per model.

While at it also log an error when the index points to an uninitialized
part of the freqs lookup-table.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: stable@vger.kernel.org
Link: https://lkml.kernel.org/r/20200223140610.59612-2-hdegoede@redhat.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/kernel/tsc_msr.c |   17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

--- a/arch/x86/kernel/tsc_msr.c
+++ b/arch/x86/kernel/tsc_msr.c
@@ -15,7 +15,7 @@
 #include <asm/param.h>
 #include <asm/tsc.h>
 
-#define MAX_NUM_FREQS	9
+#define MAX_NUM_FREQS	16 /* 4 bits to select the frequency */
 
 /*
  * If MSR_PERF_STAT[31] is set, the maximum resolved bus ratio can be
@@ -27,6 +27,7 @@
 struct freq_desc {
 	bool use_msr_plat;
 	u32 freqs[MAX_NUM_FREQS];
+	u32 mask;
 };
 
 /*
@@ -37,37 +38,44 @@ struct freq_desc {
 static const struct freq_desc freq_desc_pnw = {
 	.use_msr_plat = false,
 	.freqs = { 0, 0, 0, 0, 0, 99840, 0, 83200 },
+	.mask = 0x07,
 };
 
 static const struct freq_desc freq_desc_clv = {
 	.use_msr_plat = false,
 	.freqs = { 0, 133200, 0, 0, 0, 99840, 0, 83200 },
+	.mask = 0x07,
 };
 
 static const struct freq_desc freq_desc_byt = {
 	.use_msr_plat = true,
 	.freqs = { 83300, 100000, 133300, 116700, 80000, 0, 0, 0 },
+	.mask = 0x07,
 };
 
 static const struct freq_desc freq_desc_cht = {
 	.use_msr_plat = true,
 	.freqs = { 83300, 100000, 133300, 116700, 80000, 93300, 90000,
 		   88900, 87500 },
+	.mask = 0x0f,
 };
 
 static const struct freq_desc freq_desc_tng = {
 	.use_msr_plat = true,
 	.freqs = { 0, 100000, 133300, 0, 0, 0, 0, 0 },
+	.mask = 0x07,
 };
 
 static const struct freq_desc freq_desc_ann = {
 	.use_msr_plat = true,
 	.freqs = { 83300, 100000, 133300, 100000, 0, 0, 0, 0 },
+	.mask = 0x0f,
 };
 
 static const struct freq_desc freq_desc_lgm = {
 	.use_msr_plat = true,
 	.freqs = { 78000, 78000, 78000, 78000, 78000, 78000, 78000, 78000 },
+	.mask = 0x0f,
 };
 
 static const struct x86_cpu_id tsc_msr_cpu_ids[] = {
@@ -93,6 +101,7 @@ unsigned long cpu_khz_from_msr(void)
 	const struct freq_desc *freq_desc;
 	const struct x86_cpu_id *id;
 	unsigned long res;
+	int index;
 
 	id = x86_match_cpu(tsc_msr_cpu_ids);
 	if (!id)
@@ -109,13 +118,17 @@ unsigned long cpu_khz_from_msr(void)
 
 	/* Get FSB FREQ ID */
 	rdmsr(MSR_FSB_FREQ, lo, hi);
+	index = lo & freq_desc->mask;
 
 	/* Map CPU reference clock freq ID(0-7) to CPU reference clock freq(KHz) */
-	freq = freq_desc->freqs[lo & 0x7];
+	freq = freq_desc->freqs[index];
 
 	/* TSC frequency = maximum resolved freq * maximum resolved bus ratio */
 	res = freq * ratio;
 
+	if (freq == 0)
+		pr_err("Error MSR_FSB_FREQ index %d is unknown\n", index);
+
 #ifdef CONFIG_X86_LOCAL_APIC
 	lapic_timer_period = (freq * 1000) / HZ;
 #endif


