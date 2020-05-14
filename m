Return-Path: <SRS0=2JZx=64=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08756C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 01:13:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0072D2065D
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 01:13:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OA99C6V9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728338AbgENBNv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 May 2020 21:13:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725943AbgENBNu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 May 2020 21:13:50 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A00ADC061A0C
        for <linux-kernel@vger.kernel.org>; Wed, 13 May 2020 18:13:49 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id a136so1471071qkg.6
        for <linux-kernel@vger.kernel.org>; Wed, 13 May 2020 18:13:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3j+fb44yuraErwrk1dNcbOMiilc+TCUHhggke2VSVxE=;
        b=OA99C6V9LpBtSycUXEGVpKJi2xuhEd1vjm1XsWbDoJgKJY3+AWDS7VZyYfie+rHASk
         /2ZJauGEFD1VlfZSOJOguCKydEuifHdKCkWmxuCj0rA/9MBaeYoI/pXXvRz0jYpWBasa
         +n+cbafw7wFhQ4m2bNHX4Szy9Ih6q+srA+vJKEMgPnX+nNoC0Kv7UIWXupFgfL8WKG9n
         jW3u1k2BmMjVSls8MNYcGBxtr3C1qdLwSbS5FvzkhT5V4p7pepzlILNmWjXzQcc6cL8s
         bCfOd0pxKQ17AujlAcay8uI9JARJEwA1OWF34VYvUsNsGLLsRp/yFY7UAh9MV14l2IfK
         RnZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3j+fb44yuraErwrk1dNcbOMiilc+TCUHhggke2VSVxE=;
        b=CpwR0VZh+Izd3R6ck1kj/9WpZedDkqTmj5fpVeLW8s84lun6GPuhjCp2E3UmLPbJ3k
         Bzcus0nHAWc4XPmjg69sAkvF8Ab7yVSvDLb/ZxQ4jqarCoZwzo7qrehDR6l3Y9HN77Yc
         fen0mgHQKGiRa5qPEXME7lvlMr/SI2YYepfMJupKlmrRItwTapNSzggR/wHEdpq8Pz9C
         h2x+KXwChf6mxXtyHVT5wo+SmqW6wjo2fE9AGdR5WCTSUR4G5CFtwUKZVuqJHpjx2FWj
         RydFL2D+QMDXIagZuoZ4QhRGlaUzFHsa7uUzbABUw1tIbY15A8vweTTDG+lDN9XNGOGg
         KoFg==
X-Gm-Message-State: AOAM530XpE/ru4s3Yog4l0eMY9ORAUzDCsGxTPJIZEPiyJvUOdDXwri1
        XQz+vNlxVIjt3Cm5CUHOWi4=
X-Google-Smtp-Source: ABdhPJz5qisrh9QVa+g27npCtw2rxTS+nkv7gJe/ySujsO14fMreuAOVX+KIR83jiMYHf2FgiTuv1Q==
X-Received: by 2002:ae9:dcc2:: with SMTP id q185mr2479482qkf.239.1589418828800;
        Wed, 13 May 2020 18:13:48 -0700 (PDT)
Received: from LeoBras.aus.stglabs.ibm.com (179-125-143-209.dynamic.desktop.com.br. [179.125.143.209])
        by smtp.gmail.com with ESMTPSA id j11sm1308314qkk.33.2020.05.13.18.13.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2020 18:13:48 -0700 (PDT)
From:   Leonardo Bras <leobras.c@gmail.com>
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Allison Randal <allison@lohutok.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Nicholas Piggin <npiggin@gmail.com>,
        Leonardo Bras <leobras.c@gmail.com>,
        Nathan Lynch <nathanl@linux.ibm.com>,
        "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>,
        Nadav Amit <namit@vmware.com>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/2] powerpc/rtas: Implement reentrant rtas call
Date:   Wed, 13 May 2020 22:12:45 -0300
Message-Id: <20200514011245.127174-3-leobras.c@gmail.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200514011245.127174-1-leobras.c@gmail.com>
References: <20200514011245.127174-1-leobras.c@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Implement rtas_call_reentrant() for reentrant rtas-calls:
"ibm,int-on", "ibm,int-off",ibm,get-xive" and  "ibm,set-xive".

On LoPAPR Version 1.1 (March 24, 2016), from 7.3.10.1 to 7.3.10.4,
items 2 and 3 say:

2 - For the PowerPC External Interrupt option: The * call must be
reentrant to the number of processors on the platform.
3 - For the PowerPC External Interrupt option: The * argument call
buffer for each simultaneous call must be physically unique.

So, these rtas-calls can be called in a lockless way, if using
a different buffer for each cpu doing such rtas call.

For this, it was suggested to add the buffer (struct rtas_args)
in the PACA struct, so each cpu can have it's own buffer.

Reentrant rtas calls are useful to avoid deadlocks in crashing,
where rtas-calls are needed, but some other thread crashed holding
the rtas.lock.

This is a backtrace of a deadlock from a kdump testing environment:

  #0 arch_spin_lock
  #1  lock_rtas ()
  #2  rtas_call (token=8204, nargs=1, nret=1, outputs=0x0)
  #3  ics_rtas_mask_real_irq (hw_irq=4100)
  #4  machine_kexec_mask_interrupts
  #5  default_machine_crash_shutdown
  #6  machine_crash_shutdown
  #7  __crash_kexec
  #8  crash_kexec
  #9  oops_end

Signed-off-by: Leonardo Bras <leobras.c@gmail.com>
---
 arch/powerpc/include/asm/paca.h     |  2 ++
 arch/powerpc/include/asm/rtas.h     |  1 +
 arch/powerpc/kernel/rtas.c          | 42 +++++++++++++++++++++++++++++
 arch/powerpc/sysdev/xics/ics-rtas.c | 22 +++++++--------
 4 files changed, 56 insertions(+), 11 deletions(-)

diff --git a/arch/powerpc/include/asm/paca.h b/arch/powerpc/include/asm/paca.h
index e3cc9eb9204d..5a76ba50b40f 100644
--- a/arch/powerpc/include/asm/paca.h
+++ b/arch/powerpc/include/asm/paca.h
@@ -29,6 +29,7 @@
 #include <asm/hmi.h>
 #include <asm/cpuidle.h>
 #include <asm/atomic.h>
+#include <asm/rtas-types.h>
 
 #include <asm-generic/mmiowb_types.h>
 
@@ -270,6 +271,7 @@ struct paca_struct {
 #ifdef CONFIG_MMIOWB
 	struct mmiowb_state mmiowb_state;
 #endif
+	struct rtas_args reentrant_args;
 } ____cacheline_aligned;
 
 extern void copy_mm_to_paca(struct mm_struct *mm);
diff --git a/arch/powerpc/include/asm/rtas.h b/arch/powerpc/include/asm/rtas.h
index c35c5350b7e4..fa7509c85881 100644
--- a/arch/powerpc/include/asm/rtas.h
+++ b/arch/powerpc/include/asm/rtas.h
@@ -236,6 +236,7 @@ extern struct rtas_t rtas;
 extern int rtas_token(const char *service);
 extern int rtas_service_present(const char *service);
 extern int rtas_call(int token, int, int, int *, ...);
+int rtas_call_reentrant(int token, int nargs, int nret, int *outputs, ...);
 void rtas_call_unlocked(struct rtas_args *args, int token, int nargs,
 			int nret, ...);
 extern void __noreturn rtas_restart(char *cmd);
diff --git a/arch/powerpc/kernel/rtas.c b/arch/powerpc/kernel/rtas.c
index c5fa251b8950..d426b5c4856c 100644
--- a/arch/powerpc/kernel/rtas.c
+++ b/arch/powerpc/kernel/rtas.c
@@ -41,6 +41,7 @@
 #include <asm/time.h>
 #include <asm/mmu.h>
 #include <asm/topology.h>
+#include <asm/paca.h>
 
 /* This is here deliberately so it's only used in this file */
 void enter_rtas(unsigned long);
@@ -483,6 +484,47 @@ int rtas_call(int token, int nargs, int nret, int *outputs, ...)
 }
 EXPORT_SYMBOL(rtas_call);
 
+/**
+ * rtas_call_reentrant() - Used for reentrant rtas calls
+ * @token:	Token for desired reentrant RTAS call
+ * @nargs:	Number of Input Parameters
+ * @nret:	Number of Output Parameters
+ * @outputs:	Array of outputs
+ * @...:	Inputs for desired RTAS call
+ *
+ * According to LoPAR documentation, only "ibm,int-on", "ibm,int-off",
+ * "ibm,get-xive" and "ibm,set-xive" are currently reentrant.
+ * Reentrant calls need their own rtas_args buffer, so not using rtas.args, but
+ * PACA one instead.
+ *
+ * Return:	-1 on error,
+ *		First output value of RTAS call if (nret > 0),
+ *		0 otherwise,
+ */
+
+int rtas_call_reentrant(int token, int nargs, int nret, int *outputs, ...)
+{
+	va_list list;
+	struct rtas_args *args;
+	int i;
+
+	if (!rtas.entry || token == RTAS_UNKNOWN_SERVICE)
+		return -1;
+
+	/* We use the per-cpu (PACA) rtas args buffer */
+	args = &local_paca->reentrant_args;
+
+	va_start(list, outputs);
+	va_rtas_call_unlocked(args, token, nargs, nret, list);
+	va_end(list);
+
+	if (nret > 1 && outputs)
+		for (i = 0; i < nret - 1; ++i)
+			outputs[i] = be32_to_cpu(args->rets[i + 1]);
+
+	return (nret > 0) ? be32_to_cpu(args->rets[0]) : 0;
+}
+
 /* For RTAS_BUSY (-2), delay for 1 millisecond.  For an extended busy status
  * code of 990n, perform the hinted delay of 10^n (last digit) milliseconds.
  */
diff --git a/arch/powerpc/sysdev/xics/ics-rtas.c b/arch/powerpc/sysdev/xics/ics-rtas.c
index 6aabc74688a6..4cf18000f07c 100644
--- a/arch/powerpc/sysdev/xics/ics-rtas.c
+++ b/arch/powerpc/sysdev/xics/ics-rtas.c
@@ -50,8 +50,8 @@ static void ics_rtas_unmask_irq(struct irq_data *d)
 
 	server = xics_get_irq_server(d->irq, irq_data_get_affinity_mask(d), 0);
 
-	call_status = rtas_call(ibm_set_xive, 3, 1, NULL, hw_irq, server,
-				DEFAULT_PRIORITY);
+	call_status = rtas_call_reentrant(ibm_set_xive, 3, 1, NULL, hw_irq,
+					  server, DEFAULT_PRIORITY);
 	if (call_status != 0) {
 		printk(KERN_ERR
 			"%s: ibm_set_xive irq %u server %x returned %d\n",
@@ -60,7 +60,7 @@ static void ics_rtas_unmask_irq(struct irq_data *d)
 	}
 
 	/* Now unmask the interrupt (often a no-op) */
-	call_status = rtas_call(ibm_int_on, 1, 1, NULL, hw_irq);
+	call_status = rtas_call_reentrant(ibm_int_on, 1, 1, NULL, hw_irq);
 	if (call_status != 0) {
 		printk(KERN_ERR "%s: ibm_int_on irq=%u returned %d\n",
 			__func__, hw_irq, call_status);
@@ -91,7 +91,7 @@ static void ics_rtas_mask_real_irq(unsigned int hw_irq)
 	if (hw_irq == XICS_IPI)
 		return;
 
-	call_status = rtas_call(ibm_int_off, 1, 1, NULL, hw_irq);
+	call_status = rtas_call_reentrant(ibm_int_off, 1, 1, NULL, hw_irq);
 	if (call_status != 0) {
 		printk(KERN_ERR "%s: ibm_int_off irq=%u returned %d\n",
 			__func__, hw_irq, call_status);
@@ -99,8 +99,8 @@ static void ics_rtas_mask_real_irq(unsigned int hw_irq)
 	}
 
 	/* Have to set XIVE to 0xff to be able to remove a slot */
-	call_status = rtas_call(ibm_set_xive, 3, 1, NULL, hw_irq,
-				xics_default_server, 0xff);
+	call_status = rtas_call_reentrant(ibm_set_xive, 3, 1, NULL, hw_irq,
+					  xics_default_server, 0xff);
 	if (call_status != 0) {
 		printk(KERN_ERR "%s: ibm_set_xive(0xff) irq=%u returned %d\n",
 			__func__, hw_irq, call_status);
@@ -131,7 +131,7 @@ static int ics_rtas_set_affinity(struct irq_data *d,
 	if (hw_irq == XICS_IPI || hw_irq == XICS_IRQ_SPURIOUS)
 		return -1;
 
-	status = rtas_call(ibm_get_xive, 1, 3, xics_status, hw_irq);
+	status = rtas_call_reentrant(ibm_get_xive, 1, 3, xics_status, hw_irq);
 
 	if (status) {
 		printk(KERN_ERR "%s: ibm,get-xive irq=%u returns %d\n",
@@ -146,8 +146,8 @@ static int ics_rtas_set_affinity(struct irq_data *d,
 		return -1;
 	}
 
-	status = rtas_call(ibm_set_xive, 3, 1, NULL,
-			   hw_irq, irq_server, xics_status[1]);
+	status = rtas_call_reentrant(ibm_set_xive, 3, 1, NULL,
+				     hw_irq, irq_server, xics_status[1]);
 
 	if (status) {
 		printk(KERN_ERR "%s: ibm,set-xive irq=%u returns %d\n",
@@ -179,7 +179,7 @@ static int ics_rtas_map(struct ics *ics, unsigned int virq)
 		return -EINVAL;
 
 	/* Check if RTAS knows about this interrupt */
-	rc = rtas_call(ibm_get_xive, 1, 3, status, hw_irq);
+	rc = rtas_call_reentrant(ibm_get_xive, 1, 3, status, hw_irq);
 	if (rc)
 		return -ENXIO;
 
@@ -198,7 +198,7 @@ static long ics_rtas_get_server(struct ics *ics, unsigned long vec)
 {
 	int rc, status[2];
 
-	rc = rtas_call(ibm_get_xive, 1, 3, status, vec);
+	rc = rtas_call_reentrant(ibm_get_xive, 1, 3, status, vec);
 	if (rc)
 		return -1;
 	return status[0];
-- 
2.25.4

