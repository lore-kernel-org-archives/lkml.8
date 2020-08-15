Return-Path: <SRS0=qJsj=BZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1A9CC433DF
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Aug 2020 22:27:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C5B1A20657
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Aug 2020 22:27:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="hVfUEGnX";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="I0M6NcjP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728918AbgHOW1E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Aug 2020 18:27:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728091AbgHOW1E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Aug 2020 18:27:04 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9743C061786;
        Sat, 15 Aug 2020 15:27:03 -0700 (PDT)
Date:   Sat, 15 Aug 2020 22:26:58 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1597530421;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wypv7MENFaReKZ9UbFiYXOK6G1uQ5RrEzeXJG9GwfNc=;
        b=hVfUEGnXH1Vx+e9LSsuRyD5aNi2ePl5cXr7NaKCHO3vyMPqnXb0RfWVw1cAi73oZJBRe0z
        B1ZUbcRsOq/g8tBRVwV5leJumdmZh7UEmJU044l4UPgNu9YwuFDg1BHuPS+nHdjZZuWoue
        XWy0m7l8L/bP+B/Lv1u9aNP7UM7Jf5JzlKrTXH/Udt94hXrmeh8iEDvzAkdKiJPxqxGWsn
        WYj+fZMCHYEq4LoskH33kDaMg7NXL3KYN6+Qk/v7hY1XeP/jyuMinUd6Md6f4Dl4LhyIS1
        w1nAii5/mM0ZguwJBGY7vJxD96aANOenAWZf5qR1u3iqJR7gOV91TUH4s/878g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1597530421;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wypv7MENFaReKZ9UbFiYXOK6G1uQ5RrEzeXJG9GwfNc=;
        b=I0M6NcjPBU+YGkqeeSR9P9QzXWWi4V/Ji8XERV4JuauQKoGx2GDIvrjiHWUWIkN3zbD8u9
        PjNwayXtFDhlvxCA==
From:   "tip-bot2 for Vaibhav Shankar" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/urgent] perf/x86/intel/uncore: Add BW counters for GT, IA
 and IO breakdown
Cc:     Vaibhav Shankar <vaibhav.shankar@intel.com>,
        Ingo Molnar <mingo@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200814022234.23605-1-vaibhav.shankar@intel.com>
References: <20200814022234.23605-1-vaibhav.shankar@intel.com>
MIME-Version: 1.0
Message-ID: <159753041851.3192.7787654120960182179.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the perf/urgent branch of tip:

Commit-ID:     24633d901ea44fe99bc9a2d01a3881fa097b78b3
Gitweb:        https://git.kernel.org/tip/24633d901ea44fe99bc9a2d01a3881fa097b78b3
Author:        Vaibhav Shankar <vaibhav.shankar@intel.com>
AuthorDate:    Thu, 13 Aug 2020 19:22:34 -07:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Sat, 15 Aug 2020 20:24:18 +02:00

perf/x86/intel/uncore: Add BW counters for GT, IA and IO breakdown

Linux only has support to read total DDR reads and writes. Here we
add support to enable bandwidth breakdown-GT, IA and IO. Breakdown
of BW is important to debug and optimize memory access. This can also
be used for telemetry and improving the system software.The offsets for
GT, IA and IO are added and these free running counters can be accessed
via MMIO space.

The BW breakdown can be measured using the following cmd:

  perf stat -e uncore_imc/gt_requests/,uncore_imc/ia_requests/,uncore_imc/io_requests/

             30.57 MiB  uncore_imc/gt_requests/
           1346.13 MiB  uncore_imc/ia_requests/
            190.97 MiB  uncore_imc/io_requests/

       5.984572733 seconds time elapsed

     BW/s = <gt,ia,io>_requests/time elapsed

Signed-off-by: Vaibhav Shankar <vaibhav.shankar@intel.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20200814022234.23605-1-vaibhav.shankar@intel.com
---
 arch/x86/events/intel/uncore_snb.c | 52 +++++++++++++++++++++++++++--
 1 file changed, 49 insertions(+), 3 deletions(-)

diff --git a/arch/x86/events/intel/uncore_snb.c b/arch/x86/events/intel/uncore_snb.c
index cb94ba8..6a4ca27 100644
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
