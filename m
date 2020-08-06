Return-Path: <SRS0=vN1y=BQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1912EC433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 17:12:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6BA862313F
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 17:12:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="orBbfWDx";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="bC8Kj4Gm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730344AbgHFRMA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Aug 2020 13:12:00 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:58874 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729710AbgHFRKJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Aug 2020 13:10:09 -0400
Date:   Thu, 06 Aug 2020 17:10:05 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1596733806;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YOMo0P16tgPCTAJXt80yTm/HuS5EKQ0yH4ZkqTx19r4=;
        b=orBbfWDxyB6VqKbDp/ygm4Bqc0g2zbZltvyLsnEaUNDGYuzN2HJEQwiiFCIAdcHc0Yjkts
        XAvAnI08LG9S7NjvFFTXWhWOis1mOIHhc1EdGUtU4VCdQXh1aPRx5Q0+oRXy7Ips9G3I/f
        HFiQKPZJajBspkVgGDGsGINumwF7nWuSa7mtmFEPQx+OdOUYOAKekC88zixz6qQSYUm+i4
        VI+FgyCxKPXL4pVn6Nkt8Ubxf6bhWZEQlxSiMTP0Yw/qq7YxuAF9uAzrb0IcI9yXmZj4pn
        9uOvj/cYfxw1pxn+HdWcYepMXuwB9MAdCpIZdcqUR/v8pAWkz7k1D22/3t4arA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1596733806;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YOMo0P16tgPCTAJXt80yTm/HuS5EKQ0yH4ZkqTx19r4=;
        b=bC8Kj4GmOXCQkV2Wxk5ZE3XioS2ZvwJZWFmKUSjMue5xudf6ScwkijRoi0xEFrwuOJG+eR
        zRnJ03lFUw0P39Bg==
From:   "tip-bot2 for Dilip Kota" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86/tsr: Fix tsc frequency enumeration bug on
 Lightning Mountain SoC
Cc:     Dilip Kota <eswara.kota@linux.intel.com>,
        Ingo Molnar <mingo@kernel.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: =?utf-8?q?=3C211c643ae217604b46cbec43a2c0423946dc7d2d=2E15964?=
 =?utf-8?q?40057=2Egit=2Eeswara=2Ekota=40linux=2Eintel=2Ecom=3E?=
References: =?utf-8?q?=3C211c643ae217604b46cbec43a2c0423946dc7d2d=2E159644?=
 =?utf-8?q?0057=2Egit=2Eeswara=2Ekota=40linux=2Eintel=2Ecom=3E?=
MIME-Version: 1.0
Message-ID: <159673380550.3192.4383515267826217195.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     287bad1f2b30253443e61ff6d5597a76787f736a
Gitweb:        https://git.kernel.org/tip/287bad1f2b30253443e61ff6d5597a76787f736a
Author:        Dilip Kota <eswara.kota@linux.intel.com>
AuthorDate:    Mon, 03 Aug 2020 15:56:36 +08:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Thu, 06 Aug 2020 15:27:31 +02:00

x86/tsr: Fix tsc frequency enumeration bug on Lightning Mountain SoC

Frequency descriptor of Lightning Mountain SoC doesn't have all the
frequency entries so resulting in the below failure causing a kernel hang:

    Error MSR_FSB_FREQ index 15 is unknown
    tsc: Fast TSC calibration failed

So, add all the frequency entries in the Lightning Mountain SoC frequency
descriptor.

Fixes: 0cc5359d8fd45 ("x86/cpu: Update init data for new Airmont CPU model")
Fixes: 812c2d7506fd ("x86/tsc_msr: Use named struct initializers")
Signed-off-by: Dilip Kota <eswara.kota@linux.intel.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Link: https://lore.kernel.org/r/211c643ae217604b46cbec43a2c0423946dc7d2d.1596440057.git.eswara.kota@linux.intel.com
---
 arch/x86/kernel/tsc_msr.c |  9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/tsc_msr.c b/arch/x86/kernel/tsc_msr.c
index 4fec6f3..a654a9b 100644
--- a/arch/x86/kernel/tsc_msr.c
+++ b/arch/x86/kernel/tsc_msr.c
@@ -133,10 +133,15 @@ static const struct freq_desc freq_desc_ann = {
 	.mask = 0x0f,
 };
 
-/* 24 MHz crystal? : 24 * 13 / 4 = 78 MHz */
+/*
+ * 24 MHz crystal? : 24 * 13 / 4 = 78 MHz
+ * Frequency step for Lightning Mountain SoC is fixed to 78 MHz,
+ * so all the frequency entries are 78000.
+ */
 static const struct freq_desc freq_desc_lgm = {
 	.use_msr_plat = true,
-	.freqs = { 78000, 78000, 78000, 78000, 78000, 78000, 78000, 78000 },
+	.freqs = { 78000, 78000, 78000, 78000, 78000, 78000, 78000, 78000,
+		   78000, 78000, 78000, 78000, 78000, 78000, 78000, 78000 },
 	.mask = 0x0f,
 };
 
