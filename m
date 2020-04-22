Return-Path: <SRS0=eifh=6G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3594BC55189
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 10:11:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 153AE2070B
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 10:11:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587550310;
	bh=5hFOxgmCBqcsIjjTt1iQtpOiZuQcLpKbqqSbFXco9Ow=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Kc02kLfqgb7MMqtKcjXNk4tJ44F9RMNMGybrb5Xa1jjljAlI4BmgoZWKJxymvF51S
	 cgbIGDmS4UDGf8gSHNK6WkKT+Lz0XZuciICDkmRYr+JX8nhf0VOobIJODpfam47xJ7
	 Bh1SkEtRBC1dsxpsd7huSlBmBLgZX6I/HAXrt2ag=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729247AbgDVKLt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Apr 2020 06:11:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:44076 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729235AbgDVKLo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Apr 2020 06:11:44 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 21F8220776;
        Wed, 22 Apr 2020 10:11:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587550302;
        bh=5hFOxgmCBqcsIjjTt1iQtpOiZuQcLpKbqqSbFXco9Ow=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DSFBdUYBXTjU/sJ67mCm4bkLmNnu/Jw6SPVnqHwSW/mF7ZmE0jRp5EPGzQ+5t8PuS
         vpVLxTTLTTJID6VdmKO7xCBuEfgFJ92LFKayB+O/j7zJLWrCmWhZ2BjoNEzGUlJcLq
         R2bC0hhCp7QGVXRw8v/ZGiz+lmL/Qsha0w8YMcKQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, David Gibson <david@gibson.dropbear.id.au>,
        =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH 4.14 090/199] powerpc/xive: Use XIVE_BAD_IRQ instead of zero to catch non configured IPIs
Date:   Wed, 22 Apr 2020 11:56:56 +0200
Message-Id: <20200422095107.078999636@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200422095057.806111593@linuxfoundation.org>
References: <20200422095057.806111593@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Cédric Le Goater <clg@kaod.org>

commit b1a504a6500df50e83b701b7946b34fce27ad8a3 upstream.

When a CPU is brought up, an IPI number is allocated and recorded
under the XIVE CPU structure. Invalid IPI numbers are tracked with
interrupt number 0x0.

On the PowerNV platform, the interrupt number space starts at 0x10 and
this works fine. However, on the sPAPR platform, it is possible to
allocate the interrupt number 0x0 and this raises an issue when CPU 0
is unplugged. The XIVE spapr driver tracks allocated interrupt numbers
in a bitmask and it is not correctly updated when interrupt number 0x0
is freed. It stays allocated and it is then impossible to reallocate.

Fix by using the XIVE_BAD_IRQ value instead of zero on both platforms.

Reported-by: David Gibson <david@gibson.dropbear.id.au>
Fixes: eac1e731b59e ("powerpc/xive: guest exploitation of the XIVE interrupt controller")
Cc: stable@vger.kernel.org # v4.14+
Signed-off-by: Cédric Le Goater <clg@kaod.org>
Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
Tested-by: David Gibson <david@gibson.dropbear.id.au>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Link: https://lore.kernel.org/r/20200306150143.5551-2-clg@kaod.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/powerpc/sysdev/xive/common.c        |   12 +++---------
 arch/powerpc/sysdev/xive/native.c        |    4 ++--
 arch/powerpc/sysdev/xive/spapr.c         |    4 ++--
 arch/powerpc/sysdev/xive/xive-internal.h |    7 +++++++
 4 files changed, 14 insertions(+), 13 deletions(-)

--- a/arch/powerpc/sysdev/xive/common.c
+++ b/arch/powerpc/sysdev/xive/common.c
@@ -72,13 +72,6 @@ static u32 xive_ipi_irq;
 /* Xive state for each CPU */
 static DEFINE_PER_CPU(struct xive_cpu *, xive_cpu);
 
-/*
- * A "disabled" interrupt should never fire, to catch problems
- * we set its logical number to this
- */
-#define XIVE_BAD_IRQ		0x7fffffff
-#define XIVE_MAX_IRQ		(XIVE_BAD_IRQ - 1)
-
 /* An invalid CPU target */
 #define XIVE_INVALID_TARGET	(-1)
 
@@ -1073,7 +1066,7 @@ static int xive_setup_cpu_ipi(unsigned i
 	xc = per_cpu(xive_cpu, cpu);
 
 	/* Check if we are already setup */
-	if (xc->hw_ipi != 0)
+	if (xc->hw_ipi != XIVE_BAD_IRQ)
 		return 0;
 
 	/* Grab an IPI from the backend, this will populate xc->hw_ipi */
@@ -1110,7 +1103,7 @@ static void xive_cleanup_cpu_ipi(unsigne
 	/* Disable the IPI and free the IRQ data */
 
 	/* Already cleaned up ? */
-	if (xc->hw_ipi == 0)
+	if (xc->hw_ipi == XIVE_BAD_IRQ)
 		return;
 
 	/* Mask the IPI */
@@ -1266,6 +1259,7 @@ static int xive_prepare_cpu(unsigned int
 		if (np)
 			xc->chip_id = of_get_ibm_chip_id(np);
 		of_node_put(np);
+		xc->hw_ipi = XIVE_BAD_IRQ;
 
 		per_cpu(xive_cpu, cpu) = xc;
 	}
--- a/arch/powerpc/sysdev/xive/native.c
+++ b/arch/powerpc/sysdev/xive/native.c
@@ -310,7 +310,7 @@ static void xive_native_put_ipi(unsigned
 	s64 rc;
 
 	/* Free the IPI */
-	if (!xc->hw_ipi)
+	if (xc->hw_ipi == XIVE_BAD_IRQ)
 		return;
 	for (;;) {
 		rc = opal_xive_free_irq(xc->hw_ipi);
@@ -318,7 +318,7 @@ static void xive_native_put_ipi(unsigned
 			msleep(1);
 			continue;
 		}
-		xc->hw_ipi = 0;
+		xc->hw_ipi = XIVE_BAD_IRQ;
 		break;
 	}
 }
--- a/arch/powerpc/sysdev/xive/spapr.c
+++ b/arch/powerpc/sysdev/xive/spapr.c
@@ -443,11 +443,11 @@ static int xive_spapr_get_ipi(unsigned i
 
 static void xive_spapr_put_ipi(unsigned int cpu, struct xive_cpu *xc)
 {
-	if (!xc->hw_ipi)
+	if (xc->hw_ipi == XIVE_BAD_IRQ)
 		return;
 
 	xive_irq_bitmap_free(xc->hw_ipi);
-	xc->hw_ipi = 0;
+	xc->hw_ipi = XIVE_BAD_IRQ;
 }
 #endif /* CONFIG_SMP */
 
--- a/arch/powerpc/sysdev/xive/xive-internal.h
+++ b/arch/powerpc/sysdev/xive/xive-internal.h
@@ -9,6 +9,13 @@
 #ifndef __XIVE_INTERNAL_H
 #define __XIVE_INTERNAL_H
 
+/*
+ * A "disabled" interrupt should never fire, to catch problems
+ * we set its logical number to this
+ */
+#define XIVE_BAD_IRQ		0x7fffffff
+#define XIVE_MAX_IRQ		(XIVE_BAD_IRQ - 1)
+
 /* Each CPU carry one of these with various per-CPU state */
 struct xive_cpu {
 #ifdef CONFIG_SMP


