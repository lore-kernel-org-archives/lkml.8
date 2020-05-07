Return-Path: <SRS0=0sZ+=6V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48965C38A24
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 14:08:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2D63020870
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 14:08:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728057AbgEGOIO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 May 2020 10:08:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726742AbgEGOH0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 10:07:26 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BFD4C05BD43;
        Thu,  7 May 2020 07:07:26 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jWhBK-00026u-H6; Thu, 07 May 2020 16:07:22 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 20F311C03AB;
        Thu,  7 May 2020 16:07:22 +0200 (CEST)
Date:   Thu, 07 May 2020 14:07:22 -0000
From:   "tip-bot2 for Christoph Hellwig" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/platform] x86/platform/uv: Simplify uv_send_IPI_one()
Cc:     Christoph Hellwig <hch@lst.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Russ Anderson <rja@hpe.com>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200504171527.2845224-9-hch@lst.de>
References: <20200504171527.2845224-9-hch@lst.de>
MIME-Version: 1.0
Message-ID: <158886044210.8414.17434284090917646663.tip-bot2@tip-bot2>
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

The following commit has been merged into the x86/platform branch of tip:

Commit-ID:     8e77554580250f1185cffd8d3ac6a9b01de05d60
Gitweb:        https://git.kernel.org/tip/8e77554580250f1185cffd8d3ac6a9b01de05d60
Author:        Christoph Hellwig <hch@lst.de>
AuthorDate:    Mon, 04 May 2020 19:15:24 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 07 May 2020 15:32:22 +02:00

x86/platform/uv: Simplify uv_send_IPI_one()

Merge two helpers only used by uv_send_IPI_one() into the main function.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Not-acked-by:  Dimitri Sivanich <sivanich@hpe.com>
Cc: Russ Anderson <rja@hpe.com>
Link: https://lkml.kernel.org/r/20200504171527.2845224-9-hch@lst.de

---
 arch/x86/include/asm/uv/uv_hub.h   | 20 --------------------
 arch/x86/kernel/apic/x2apic_uv_x.c | 19 ++++++++++++++-----
 2 files changed, 14 insertions(+), 25 deletions(-)

diff --git a/arch/x86/include/asm/uv/uv_hub.h b/arch/x86/include/asm/uv/uv_hub.h
index a998e65..8a25d95 100644
--- a/arch/x86/include/asm/uv/uv_hub.h
+++ b/arch/x86/include/asm/uv/uv_hub.h
@@ -837,26 +837,6 @@ static inline void uv_set_cpu_scir_bits(int cpu, unsigned char value)
 }
 
 extern unsigned int uv_apicid_hibits;
-static unsigned long uv_hub_ipi_value(int apicid, int vector, int mode)
-{
-	apicid |= uv_apicid_hibits;
-	return (1UL << UVH_IPI_INT_SEND_SHFT) |
-			((apicid) << UVH_IPI_INT_APIC_ID_SHFT) |
-			(mode << UVH_IPI_INT_DELIVERY_MODE_SHFT) |
-			(vector << UVH_IPI_INT_VECTOR_SHFT);
-}
-
-static inline void uv_hub_send_ipi(int pnode, int apicid, int vector)
-{
-	unsigned long val;
-	unsigned long dmode = dest_Fixed;
-
-	if (vector == NMI_VECTOR)
-		dmode = dest_NMI;
-
-	val = uv_hub_ipi_value(apicid, vector, dmode);
-	uv_write_global_mmr64(pnode, UVH_IPI_INT, val);
-}
 
 /*
  * Get the minimum revision number of the hub chips within the partition.
diff --git a/arch/x86/kernel/apic/x2apic_uv_x.c b/arch/x86/kernel/apic/x2apic_uv_x.c
index f1a0142..3830538 100644
--- a/arch/x86/kernel/apic/x2apic_uv_x.c
+++ b/arch/x86/kernel/apic/x2apic_uv_x.c
@@ -588,12 +588,21 @@ static int uv_wakeup_secondary(int phys_apicid, unsigned long start_rip)
 
 static void uv_send_IPI_one(int cpu, int vector)
 {
-	unsigned long apicid;
-	int pnode;
+	unsigned long apicid = per_cpu(x86_cpu_to_apicid, cpu);
+	int pnode = uv_apicid_to_pnode(apicid);
+	unsigned long dmode, val;
+
+	if (vector == NMI_VECTOR)
+		dmode = dest_NMI;
+	else
+		dmode = dest_Fixed;
 
-	apicid = per_cpu(x86_cpu_to_apicid, cpu);
-	pnode = uv_apicid_to_pnode(apicid);
-	uv_hub_send_ipi(pnode, apicid, vector);
+	val = (1UL << UVH_IPI_INT_SEND_SHFT) |
+		((apicid | uv_apicid_hibits) << UVH_IPI_INT_APIC_ID_SHFT) |
+		(dmode << UVH_IPI_INT_DELIVERY_MODE_SHFT) |
+		(vector << UVH_IPI_INT_VECTOR_SHFT);
+
+	uv_write_global_mmr64(pnode, UVH_IPI_INT, val);
 }
 
 static void uv_send_IPI_mask(const struct cpumask *mask, int vector)
