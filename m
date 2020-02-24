Return-Path: <SRS0=7TUr=4M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BE46C35670
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 00:51:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 388CE206E0
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 00:51:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lnbkvK48"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727256AbgBXAvb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Feb 2020 19:51:31 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:36728 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727151AbgBXAva (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Feb 2020 19:51:30 -0500
Received: by mail-pf1-f194.google.com with SMTP id 185so4464821pfv.3
        for <linux-kernel@vger.kernel.org>; Sun, 23 Feb 2020 16:51:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=dR7HmsfW/e4ORYYJfGJEpowa+n5wLkb3n2L+pXm42kE=;
        b=lnbkvK48+NhUTJXX6PBghLX1c0WBiXJA6/JEuFI1o9SDsy51iCyqPA4pXZcjFK0F0t
         HvoujNz+ipV2cReSp3IPKNiQGi/B63lgEJBWiIGwF5xFHd3YP4omH87EDtEBomTCNFS7
         NGJouRFDl0cgwzSwKC35VgHtFuDgENPuTaTAk9wtenFj962qOhSxsnIFJbn1neCvm6JZ
         8k1k22nQbTv5K7nSaEKRlHnHj7zbJ5x+kXRo9NRWDwleCznjlozI8pUOEUUzm7LpaCPR
         v2de0ozY6b78yRsXdtdEI06pHSiO4Ik3211pIpgZgBrM9CPE2qOAuriqA0PeQv+lS9UW
         yWHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=dR7HmsfW/e4ORYYJfGJEpowa+n5wLkb3n2L+pXm42kE=;
        b=cJOsVE1/T2qLfHMLO+APiT2Vi/8nQcxyhwJABzfhQhIQDi9T0lUL6QyKdpRGgp1V+f
         EkovtUj3X0nqsdSetuA2mRs7wpnc4AtfeT94HGVPVaz/L5T2X+yOsO2ecrxF8WdYQFFS
         UQYlNp58sivkKLfjq3RRuHVNn0sDtA/4pNrWKKr6HswKqv6e58nr1Rq0rquYv1GfoR2s
         Hs/WuzSY5hZvBLUob1TU32Hhj/kOvkmwRFNWSIdz4fqwPdUttdb7oHYC2nwfhH70lhxo
         O6iPCq3y/cSLxRXkBhzckCUCHX6ku9qaeElztVF31TRbRWm64k88NrdKJbjDUed2FjTy
         7xjQ==
X-Gm-Message-State: APjAAAU4h0GYeHAT6tdLXXsUQysZ+ep871W2I06nAmo4DNxnfGkkhEPX
        733jK46sY2i72EGsV8nYVo0=
X-Google-Smtp-Source: APXvYqyTawcP4uedvvFYC9O38pAz3nVykeaV5Olb98iEDffywkAeKt/7Tdzpod2cUxpjshdiX8D9Lw==
X-Received: by 2002:a63:6383:: with SMTP id x125mr47280511pgb.409.1582505490024;
        Sun, 23 Feb 2020 16:51:30 -0800 (PST)
Received: from localhost ([106.51.232.35])
        by smtp.gmail.com with ESMTPSA id r72sm9816807pjb.18.2020.02.23.16.51.29
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 23 Feb 2020 16:51:29 -0800 (PST)
Date:   Mon, 24 Feb 2020 06:21:28 +0530
From:   afzal mohammed <afzal.mohd.ma@gmail.com>
To:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Cc:     Scott Wood <oss@buserror.net>,
        Kumar Gala <galak@kernel.crashing.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Vitaly Bordug <vitb@kernel.crashing.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH v2 10/18] powerpc: Replace setup_irq() by request_irq()
Message-ID: <2258497a01bb136305fb698282f5620020881fe7.1582471508.git.afzal.mohd.ma@gmail.com>
References: <cover.1582471508.git.afzal.mohd.ma@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1582471508.git.afzal.mohd.ma@gmail.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

request_irq() is preferred over setup_irq(). The early boot setup_irq()
invocations happen either via 'init_IRQ()' or 'time_init()', while
memory allocators are ready by 'mm_init()'.

Per tglx[1], setup_irq() existed in olden days when allocators were not
ready by the time early interrupts were initialized.

Hence replace setup_irq() by request_irq().

Seldom remove_irq() usage has been observed coupled with setup_irq(),
wherever that has been found, it too has been replaced by free_irq().

[1] https://lkml.kernel.org/r/alpine.DEB.2.20.1710191609480.1971@nanos

Signed-off-by: afzal mohammed <afzal.mohd.ma@gmail.com>
Tested-by: Christophe Leroy <christophe.leroy@c-s.fr> # for 8xx parts
---

v2:
 * Replace pr_err("request_irq() on %s failed" by
           pr_err("%s: request_irq() failed"
 * Commit message massage

 arch/powerpc/platforms/85xx/mpc85xx_cds.c | 10 +++-----
 arch/powerpc/platforms/8xx/cpm1.c         |  9 ++-----
 arch/powerpc/platforms/8xx/m8xx_setup.c   |  9 ++-----
 arch/powerpc/platforms/chrp/setup.c       | 14 ++++------
 arch/powerpc/platforms/powermac/pic.c     | 31 ++++++++++-------------
 arch/powerpc/platforms/powermac/smp.c     |  9 ++-----
 6 files changed, 27 insertions(+), 55 deletions(-)

diff --git a/arch/powerpc/platforms/85xx/mpc85xx_cds.c b/arch/powerpc/platforms/85xx/mpc85xx_cds.c
index 6b1436abe9b1..1c5598877d70 100644
--- a/arch/powerpc/platforms/85xx/mpc85xx_cds.c
+++ b/arch/powerpc/platforms/85xx/mpc85xx_cds.c
@@ -218,12 +218,6 @@ static irqreturn_t mpc85xx_8259_cascade_action(int irq, void *dev_id)
 {
 	return IRQ_HANDLED;
 }
-
-static struct irqaction mpc85xxcds_8259_irqaction = {
-	.handler = mpc85xx_8259_cascade_action,
-	.flags = IRQF_SHARED | IRQF_NO_THREAD,
-	.name = "8259 cascade",
-};
 #endif /* PPC_I8259 */
 #endif /* CONFIG_PCI */
 
@@ -271,7 +265,9 @@ static int mpc85xx_cds_8259_attach(void)
 	 *  disabled when the last user of the shared IRQ line frees their
 	 *  interrupt.
 	 */
-	if ((ret = setup_irq(cascade_irq, &mpc85xxcds_8259_irqaction))) {
+	ret = request_irq(cascade_irq, mpc85xx_8259_cascade_action,
+			  IRQF_SHARED | IRQF_NO_THREAD, "8259 cascade", NULL);
+	if (ret) {
 		printk(KERN_ERR "Failed to setup cascade interrupt\n");
 		return ret;
 	}
diff --git a/arch/powerpc/platforms/8xx/cpm1.c b/arch/powerpc/platforms/8xx/cpm1.c
index a43ee7d1ff85..4db4ca2e1222 100644
--- a/arch/powerpc/platforms/8xx/cpm1.c
+++ b/arch/powerpc/platforms/8xx/cpm1.c
@@ -120,12 +120,6 @@ static irqreturn_t cpm_error_interrupt(int irq, void *dev)
 	return IRQ_HANDLED;
 }
 
-static struct irqaction cpm_error_irqaction = {
-	.handler = cpm_error_interrupt,
-	.flags = IRQF_NO_THREAD,
-	.name = "error",
-};
-
 static const struct irq_domain_ops cpm_pic_host_ops = {
 	.map = cpm_pic_host_map,
 };
@@ -187,7 +181,8 @@ unsigned int __init cpm_pic_init(void)
 	if (!eirq)
 		goto end;
 
-	if (setup_irq(eirq, &cpm_error_irqaction))
+	if (request_irq(eirq, cpm_error_interrupt, IRQF_NO_THREAD, "error",
+			NULL))
 		printk(KERN_ERR "Could not allocate CPM error IRQ!");
 
 	setbits32(&cpic_reg->cpic_cicr, CICR_IEN);
diff --git a/arch/powerpc/platforms/8xx/m8xx_setup.c b/arch/powerpc/platforms/8xx/m8xx_setup.c
index f1c805c8adbc..df4d57d07f9a 100644
--- a/arch/powerpc/platforms/8xx/m8xx_setup.c
+++ b/arch/powerpc/platforms/8xx/m8xx_setup.c
@@ -39,12 +39,6 @@ static irqreturn_t timebase_interrupt(int irq, void *dev)
 	return IRQ_HANDLED;
 }
 
-static struct irqaction tbint_irqaction = {
-	.handler = timebase_interrupt,
-	.flags = IRQF_NO_THREAD,
-	.name = "tbint",
-};
-
 /* per-board overridable init_internal_rtc() function. */
 void __init __attribute__ ((weak))
 init_internal_rtc(void)
@@ -157,7 +151,8 @@ void __init mpc8xx_calibrate_decr(void)
 					(TBSCR_TBF | TBSCR_TBE));
 	immr_unmap(sys_tmr2);
 
-	if (setup_irq(virq, &tbint_irqaction))
+	if (request_irq(virq, timebase_interrupt, IRQF_NO_THREAD, "tbint",
+			NULL))
 		panic("Could not allocate timer IRQ!");
 }
 
diff --git a/arch/powerpc/platforms/chrp/setup.c b/arch/powerpc/platforms/chrp/setup.c
index fcf6f2342ef4..3f4e324f1d67 100644
--- a/arch/powerpc/platforms/chrp/setup.c
+++ b/arch/powerpc/platforms/chrp/setup.c
@@ -451,13 +451,6 @@ static void __init chrp_find_openpic(void)
 	of_node_put(np);
 }
 
-#if defined(CONFIG_VT) && defined(CONFIG_INPUT_ADBHID) && defined(CONFIG_XMON)
-static struct irqaction xmon_irqaction = {
-	.handler = xmon_irq,
-	.name = "XMON break",
-};
-#endif
-
 static void __init chrp_find_8259(void)
 {
 	struct device_node *np, *pic = NULL;
@@ -541,8 +534,11 @@ static void __init chrp_init_IRQ(void)
 		if (of_node_is_type(kbd->parent, "adb"))
 			break;
 	of_node_put(kbd);
-	if (kbd)
-		setup_irq(HYDRA_INT_ADB_NMI, &xmon_irqaction);
+	if (kbd) {
+		if (request_irq(HYDRA_INT_ADB_NMI, xmon_irq, 0, "XMON break",
+				NULL))
+			pr_err("%s: request_irq() failed\n", "XMON break");
+	}
 #endif
 }
 
diff --git a/arch/powerpc/platforms/powermac/pic.c b/arch/powerpc/platforms/powermac/pic.c
index 2e969073473d..a08b0ddc2764 100644
--- a/arch/powerpc/platforms/powermac/pic.c
+++ b/arch/powerpc/platforms/powermac/pic.c
@@ -250,20 +250,6 @@ static unsigned int pmac_pic_get_irq(void)
 	return irq_linear_revmap(pmac_pic_host, irq);
 }
 
-#ifdef CONFIG_XMON
-static struct irqaction xmon_action = {
-	.handler	= xmon_irq,
-	.flags		= IRQF_NO_THREAD,
-	.name		= "NMI - XMON"
-};
-#endif
-
-static struct irqaction gatwick_cascade_action = {
-	.handler	= gatwick_action,
-	.flags		= IRQF_NO_THREAD,
-	.name		= "cascade",
-};
-
 static int pmac_pic_host_match(struct irq_domain *h, struct device_node *node,
 			       enum irq_domain_bus_token bus_token)
 {
@@ -384,12 +370,17 @@ static void __init pmac_pic_probe_oldstyle(void)
 		out_le32(&pmac_irq_hw[i]->enable, 0);
 
 	/* Hookup cascade irq */
-	if (slave && pmac_irq_cascade)
-		setup_irq(pmac_irq_cascade, &gatwick_cascade_action);
+	if (slave && pmac_irq_cascade) {
+		if (request_irq(pmac_irq_cascade, gatwick_action,
+				IRQF_NO_THREAD, "cascade", NULL))
+			pr_err("%s: request_irq() failed\n", "cascade");
+	}
 
 	printk(KERN_INFO "irq: System has %d possible interrupts\n", max_irqs);
 #ifdef CONFIG_XMON
-	setup_irq(irq_create_mapping(NULL, 20), &xmon_action);
+	if (request_irq(irq_create_mapping(NULL, 20), xmon_irq, IRQF_NO_THREAD,
+			"NMI - XMON", NULL))
+		pr_err("%s: request_irq() failed\n", "NMI - XMON");
 #endif
 }
 
@@ -441,7 +432,11 @@ static void __init pmac_pic_setup_mpic_nmi(struct mpic *mpic)
 		nmi_irq = irq_of_parse_and_map(pswitch, 0);
 		if (nmi_irq) {
 			mpic_irq_set_priority(nmi_irq, 9);
-			setup_irq(nmi_irq, &xmon_action);
+			if (request_irq(nmi_irq, xmon_irq, IRQF_NO_THREAD,
+					"NMI - XMON", NULL)) {
+				pr_err("%s: request_irq() failed\n",
+				       "NMI - XMON");
+			}
 		}
 		of_node_put(pswitch);
 	}
diff --git a/arch/powerpc/platforms/powermac/smp.c b/arch/powerpc/platforms/powermac/smp.c
index f95fbdee6efe..0121b31a9e7b 100644
--- a/arch/powerpc/platforms/powermac/smp.c
+++ b/arch/powerpc/platforms/powermac/smp.c
@@ -399,12 +399,6 @@ static int __init smp_psurge_kick_cpu(int nr)
 	return 0;
 }
 
-static struct irqaction psurge_irqaction = {
-	.handler = psurge_ipi_intr,
-	.flags = IRQF_PERCPU | IRQF_NO_THREAD,
-	.name = "primary IPI",
-};
-
 static void __init smp_psurge_setup_cpu(int cpu_nr)
 {
 	if (cpu_nr != 0 || !psurge_start)
@@ -413,7 +407,8 @@ static void __init smp_psurge_setup_cpu(int cpu_nr)
 	/* reset the entry point so if we get another intr we won't
 	 * try to startup again */
 	out_be32(psurge_start, 0x100);
-	if (setup_irq(irq_create_mapping(NULL, 30), &psurge_irqaction))
+	if (request_irq(irq_create_mapping(NULL, 30), psurge_ipi_intr,
+			IRQF_PERCPU | IRQF_NO_THREAD, "primary IPI", NULL))
 		printk(KERN_ERR "Couldn't get primary IPI interrupt");
 }
 
-- 
2.25.1

