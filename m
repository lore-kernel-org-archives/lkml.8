Return-Path: <SRS0=TdnH=CB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64D9FC433DF
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Aug 2020 08:27:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 404452067C
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Aug 2020 08:27:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="3AtgK9gC";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="/rLkDqqY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728407AbgHWI1J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Aug 2020 04:27:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728210AbgHWI1B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Aug 2020 04:27:01 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D4B9C061575
        for <linux-kernel@vger.kernel.org>; Sun, 23 Aug 2020 01:27:00 -0700 (PDT)
Date:   Sun, 23 Aug 2020 08:25:36 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1598171213;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=4IM69E9HiiP3XVTEvo5dGOzD3Rd69hDsnkTIiXa2cxw=;
        b=3AtgK9gCAGDmvYhcT5KwTXcyLwaYZ54A0kvs1molKd39et2GlfgSrhL+gDCczoNrQHhaw/
        oGZNT44PFP4WG3H7SvxHYbuKHi7JGv5gak4RgjeVIXvdoNDxhNT7vXuAMHVDpWwFP7f5o2
        OmWamJS1HrvXqy6sBov5uENah0/0oQuG6FwPFroqh42vH5ZAawpU+U9ZNh2e3FjvyKqPEh
        aidGNiHfRP09s9dcE5KPhv2iLVt2anIkK3HZUVgWtmQH5zVemAv6liNrj+FKxmo1Q4FN4Y
        L6h4khjgAscUWJFItOuxV8ruZgVfwNTtsE6suiqHOm7RDq58+gvEDwiznBJjUg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1598171213;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=4IM69E9HiiP3XVTEvo5dGOzD3Rd69hDsnkTIiXa2cxw=;
        b=/rLkDqqYFro9MAmRrLzt0lmvHZIWDFXYE9LWuHlQSeyA1x6p16Ras8NewopNEhIGQriajG
        aymUslOT4oeJ7lBw==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org
Subject: [GIT pull] perf/urgent for v5.9-rc2
References: <159817113401.5783.14776307451257171431.tglx@nanos>
Message-ID: <159817113641.5783.13356693197176111647.tglx@nanos>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

please pull the latest perf/urgent branch from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git perf-urgent-2020-08-23

up to:  24633d901ea4: perf/x86/intel/uncore: Add BW counters for GT, IA and IO breakdown


A single update for perf on x86 which ass support for the
broken down bandwith counters.

Thanks,

	tglx

------------------>
Vaibhav Shankar (1):
      perf/x86/intel/uncore: Add BW counters for GT, IA and IO breakdown


 arch/x86/events/intel/uncore_snb.c | 52 +++++++++++++++++++++++++++++++++++---
 1 file changed, 49 insertions(+), 3 deletions(-)

diff --git a/arch/x86/events/intel/uncore_snb.c b/arch/x86/events/intel/uncore_snb.c
index cb94ba86efd2..6a4ca27b2c9e 100644
--- a/arch/x86/events/intel/uncore_snb.c
+++ b/arch/x86/events/intel/uncore_snb.c
@@ -390,6 +390,18 @@ static struct uncore_event_desc snb_uncore_imc_events[] = {
 	INTEL_UNCORE_EVENT_DESC(data_writes.scale, "6.103515625e-5"),
 	INTEL_UNCORE_EVENT_DESC(data_writes.unit, "MiB"),
 
+	INTEL_UNCORE_EVENT_DESC(gt_requests, "event=0x03"),
+	INTEL_UNCORE_EVENT_DESC(gt_requests.scale, "6.103515625e-5"),
+	INTEL_UNCORE_EVENT_DESC(gt_requests.unit, "MiB"),
+
+	INTEL_UNCORE_EVENT_DESC(ia_requests, "event=0x04"),
+	INTEL_UNCORE_EVENT_DESC(ia_requests.scale, "6.103515625e-5"),
+	INTEL_UNCORE_EVENT_DESC(ia_requests.unit, "MiB"),
+
+	INTEL_UNCORE_EVENT_DESC(io_requests, "event=0x05"),
+	INTEL_UNCORE_EVENT_DESC(io_requests.scale, "6.103515625e-5"),
+	INTEL_UNCORE_EVENT_DESC(io_requests.unit, "MiB"),
+
 	{ /* end: all zeroes */ },
 };
 
@@ -405,13 +417,35 @@ static struct uncore_event_desc snb_uncore_imc_events[] = {
 #define SNB_UNCORE_PCI_IMC_DATA_WRITES_BASE	0x5054
 #define SNB_UNCORE_PCI_IMC_CTR_BASE		SNB_UNCORE_PCI_IMC_DATA_READS_BASE
 
+/* BW break down- legacy counters */
+#define SNB_UNCORE_PCI_IMC_GT_REQUESTS		0x3
+#define SNB_UNCORE_PCI_IMC_GT_REQUESTS_BASE	0x5040
+#define SNB_UNCORE_PCI_IMC_IA_REQUESTS		0x4
+#define SNB_UNCORE_PCI_IMC_IA_REQUESTS_BASE	0x5044
+#define SNB_UNCORE_PCI_IMC_IO_REQUESTS		0x5
+#define SNB_UNCORE_PCI_IMC_IO_REQUESTS_BASE	0x5048
+
 enum perf_snb_uncore_imc_freerunning_types {
-	SNB_PCI_UNCORE_IMC_DATA		= 0,
+	SNB_PCI_UNCORE_IMC_DATA_READS		= 0,
+	SNB_PCI_UNCORE_IMC_DATA_WRITES,
+	SNB_PCI_UNCORE_IMC_GT_REQUESTS,
+	SNB_PCI_UNCORE_IMC_IA_REQUESTS,
+	SNB_PCI_UNCORE_IMC_IO_REQUESTS,
+
 	SNB_PCI_UNCORE_IMC_FREERUNNING_TYPE_MAX,
 };
 
 static struct freerunning_counters snb_uncore_imc_freerunning[] = {
-	[SNB_PCI_UNCORE_IMC_DATA]     = { SNB_UNCORE_PCI_IMC_DATA_READS_BASE, 0x4, 0x0, 2, 32 },
+	[SNB_PCI_UNCORE_IMC_DATA_READS]		= { SNB_UNCORE_PCI_IMC_DATA_READS_BASE,
+							0x0, 0x0, 1, 32 },
+	[SNB_PCI_UNCORE_IMC_DATA_READS]		= { SNB_UNCORE_PCI_IMC_DATA_WRITES_BASE,
+							0x0, 0x0, 1, 32 },
+	[SNB_PCI_UNCORE_IMC_GT_REQUESTS]	= { SNB_UNCORE_PCI_IMC_GT_REQUESTS_BASE,
+							0x0, 0x0, 1, 32 },
+	[SNB_PCI_UNCORE_IMC_IA_REQUESTS]	= { SNB_UNCORE_PCI_IMC_IA_REQUESTS_BASE,
+							0x0, 0x0, 1, 32 },
+	[SNB_PCI_UNCORE_IMC_IO_REQUESTS]	= { SNB_UNCORE_PCI_IMC_IO_REQUESTS_BASE,
+							0x0, 0x0, 1, 32 },
 };
 
 static struct attribute *snb_uncore_imc_formats_attr[] = {
@@ -525,6 +559,18 @@ static int snb_uncore_imc_event_init(struct perf_event *event)
 		base = SNB_UNCORE_PCI_IMC_DATA_WRITES_BASE;
 		idx = UNCORE_PMC_IDX_FREERUNNING;
 		break;
+	case SNB_UNCORE_PCI_IMC_GT_REQUESTS:
+		base = SNB_UNCORE_PCI_IMC_GT_REQUESTS_BASE;
+		idx = UNCORE_PMC_IDX_FREERUNNING;
+		break;
+	case SNB_UNCORE_PCI_IMC_IA_REQUESTS:
+		base = SNB_UNCORE_PCI_IMC_IA_REQUESTS_BASE;
+		idx = UNCORE_PMC_IDX_FREERUNNING;
+		break;
+	case SNB_UNCORE_PCI_IMC_IO_REQUESTS:
+		base = SNB_UNCORE_PCI_IMC_IO_REQUESTS_BASE;
+		idx = UNCORE_PMC_IDX_FREERUNNING;
+		break;
 	default:
 		return -EINVAL;
 	}
@@ -598,7 +644,7 @@ static struct intel_uncore_ops snb_uncore_imc_ops = {
 
 static struct intel_uncore_type snb_uncore_imc = {
 	.name		= "imc",
-	.num_counters   = 2,
+	.num_counters   = 5,
 	.num_boxes	= 1,
 	.num_freerunning_types	= SNB_PCI_UNCORE_IMC_FREERUNNING_TYPE_MAX,
 	.mmio_map_size	= SNB_UNCORE_PCI_IMC_MAP_SIZE,

