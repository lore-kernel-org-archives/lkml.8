Return-Path: <SRS0=Xzqw=5F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9690AC4332B
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 12:59:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 770122070A
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 12:59:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727548AbgCTM7U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Mar 2020 08:59:20 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:35600 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727097AbgCTM6K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Mar 2020 08:58:10 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jFHDt-0003gx-AM; Fri, 20 Mar 2020 13:58:01 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id DF09D1C22BF;
        Fri, 20 Mar 2020 13:58:00 +0100 (CET)
Date:   Fri, 20 Mar 2020 12:58:00 -0000
From:   "tip-bot2 for Kan Liang" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/x86/intel/uncore: Factor out __snr_uncore_mmio_init_box
Cc:     Kan Liang <kan.liang@linux.intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <1584470314-46657-2-git-send-email-kan.liang@linux.intel.com>
References: <1584470314-46657-2-git-send-email-kan.liang@linux.intel.com>
MIME-Version: 1.0
Message-ID: <158470908062.28353.5000456330988388813.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     3442a9ecb8e72a33c28a2b969b766c659830e410
Gitweb:        https://git.kernel.org/tip/3442a9ecb8e72a33c28a2b969b766c659830e410
Author:        Kan Liang <kan.liang@linux.intel.com>
AuthorDate:    Tue, 17 Mar 2020 11:38:33 -07:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 20 Mar 2020 13:06:23 +01:00

perf/x86/intel/uncore: Factor out __snr_uncore_mmio_init_box

The IMC uncore unit in Ice Lake server can only be accessed by MMIO,
which is similar as Snow Ridge.
Factor out __snr_uncore_mmio_init_box which can be shared with Ice Lake
server in the following patch.

No functional changes.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/1584470314-46657-2-git-send-email-kan.liang@linux.intel.com
---
 arch/x86/events/intel/uncore_snbep.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/arch/x86/events/intel/uncore_snbep.c b/arch/x86/events/intel/uncore_snbep.c
index ad20220..01023f0 100644
--- a/arch/x86/events/intel/uncore_snbep.c
+++ b/arch/x86/events/intel/uncore_snbep.c
@@ -4380,10 +4380,10 @@ static struct pci_dev *snr_uncore_get_mc_dev(int id)
 	return mc_dev;
 }
 
-static void snr_uncore_mmio_init_box(struct intel_uncore_box *box)
+static void __snr_uncore_mmio_init_box(struct intel_uncore_box *box,
+				       unsigned int box_ctl, int mem_offset)
 {
 	struct pci_dev *pdev = snr_uncore_get_mc_dev(box->dieid);
-	unsigned int box_ctl = uncore_mmio_box_ctl(box);
 	resource_size_t addr;
 	u32 pci_dword;
 
@@ -4393,7 +4393,7 @@ static void snr_uncore_mmio_init_box(struct intel_uncore_box *box)
 	pci_read_config_dword(pdev, SNR_IMC_MMIO_BASE_OFFSET, &pci_dword);
 	addr = (pci_dword & SNR_IMC_MMIO_BASE_MASK) << 23;
 
-	pci_read_config_dword(pdev, SNR_IMC_MMIO_MEM0_OFFSET, &pci_dword);
+	pci_read_config_dword(pdev, mem_offset, &pci_dword);
 	addr |= (pci_dword & SNR_IMC_MMIO_MEM0_MASK) << 12;
 
 	addr += box_ctl;
@@ -4405,6 +4405,12 @@ static void snr_uncore_mmio_init_box(struct intel_uncore_box *box)
 	writel(IVBEP_PMON_BOX_CTL_INT, box->io_addr);
 }
 
+static void snr_uncore_mmio_init_box(struct intel_uncore_box *box)
+{
+	__snr_uncore_mmio_init_box(box, uncore_mmio_box_ctl(box),
+				   SNR_IMC_MMIO_MEM0_OFFSET);
+}
+
 static void snr_uncore_mmio_disable_box(struct intel_uncore_box *box)
 {
 	u32 config;
