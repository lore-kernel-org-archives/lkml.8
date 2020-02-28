Return-Path: <SRS0=RI2K=4Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6150C3F2D0
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 08:34:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D2C3246A8
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 08:34:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726898AbgB1IeK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Feb 2020 03:34:10 -0500
Received: from smtprelay0139.hostedemail.com ([216.40.44.139]:45481 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726778AbgB1IeF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Feb 2020 03:34:05 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay02.hostedemail.com (Postfix) with ESMTP id 547C040C3;
        Fri, 28 Feb 2020 08:34:02 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: loss03_7a62b78765b17
X-Filterd-Recvd-Size: 22027
Received: from joe-laptop.perches.com (unknown [47.151.143.254])
        (Authenticated sender: joe@perches.com)
        by omf04.hostedemail.com (Postfix) with ESMTPA;
        Fri, 28 Feb 2020 08:34:00 +0000 (UTC)
From:   Joe Perches <joe@perches.com>
To:     Randy Dunlap <rdunlap@infradead.org>,
        "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
        Helge Deller <deller@gmx.de>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Cc:     linux-parisc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/7] parport: Use more comon logging styles
Date:   Fri, 28 Feb 2020 00:32:13 -0800
Message-Id: <1da80f696e3602cc2533988b20f9a47cd42db1c4.1582878394.git.joe@perches.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <cover.1582878393.git.joe@perches.com>
References: <cover.1582878393.git.joe@perches.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some of the logging can be poorly formatted because of unexpected
line breaks given printks without KERN_CONT that should be pr_cont.

Miscellanea:

o Remove unnecessary spaces between function name and open parenthesis
o Convert bare printks to pr_<level> where appropriate
o Convert embedded function names to use %s, __func__
o Coalesce formats
o Realign arguments
o Use do {} while (0) in a macro and not a bare if

Signed-off-by: Joe Perches <joe@perches.com>
---
 drivers/parport/parport_gsc.c  | 10 ++--
 drivers/parport/parport_gsc.h  | 21 ++++----
 drivers/parport/parport_ip32.c | 92 ++++++++++++++++++----------------
 drivers/parport/parport_pc.c   | 62 +++++++++++------------
 drivers/parport/probe.c        | 27 ++++------
 drivers/parport/share.c        | 13 +++--
 6 files changed, 108 insertions(+), 117 deletions(-)

diff --git a/drivers/parport/parport_gsc.c b/drivers/parport/parport_gsc.c
index 81082d..cb6a08 100644
--- a/drivers/parport/parport_gsc.c
+++ b/drivers/parport/parport_gsc.c
@@ -238,14 +238,14 @@ struct parport *parport_gsc_probe_port(unsigned long base,
 
 	priv = kzalloc (sizeof (struct parport_gsc_private), GFP_KERNEL);
 	if (!priv) {
-		printk (KERN_DEBUG "parport (0x%lx): no memory!\n", base);
+		printk(KERN_DEBUG "parport (0x%lx): no memory!\n", base);
 		return NULL;
 	}
 	ops = kmemdup(&parport_gsc_ops, sizeof(struct parport_operations),
 		      GFP_KERNEL);
 	if (!ops) {
-		printk (KERN_DEBUG "parport (0x%lx): no memory for ops!\n",
-			base);
+		printk(KERN_DEBUG "parport (0x%lx): no memory for ops!\n",
+		       base);
 		kfree (priv);
 		return NULL;
 	}
@@ -359,11 +359,11 @@ static int __init parport_init_chip(struct parisc_device *dev)
 	if (boot_cpu_data.cpu_type > pcxt && !pdc_add_valid(port+4)) {
 
 		/* Initialize bidirectional-mode (0x10) & data-tranfer-mode #1 (0x20) */
-		printk("%s: initialize bidirectional-mode.\n", __func__);
+		pr_info("%s: initialize bidirectional-mode\n", __func__);
 		parport_writeb ( (0x10 + 0x20), port + 4);
 
 	} else {
-		printk("%s: enhanced parport-modes not supported.\n", __func__);
+		pr_info("%s: enhanced parport-modes not supported\n", __func__);
 	}
 	
 	p = parport_gsc_probe_port(port, 0, dev->irq,
diff --git a/drivers/parport/parport_gsc.h b/drivers/parport/parport_gsc.h
index 4c4d3c..9301217 100644
--- a/drivers/parport/parport_gsc.h
+++ b/drivers/parport/parport_gsc.h
@@ -71,7 +71,7 @@ struct parport_gsc_private {
 static inline void parport_gsc_write_data(struct parport *p, unsigned char d)
 {
 #ifdef DEBUG_PARPORT
-	printk (KERN_DEBUG "parport_gsc_write_data(%p,0x%02x)\n", p, d);
+	printk(KERN_DEBUG "%s(%p,0x%02x)\n", __func__, p, d);
 #endif
 	parport_writeb(d, DATA(p));
 }
@@ -80,8 +80,7 @@ static inline unsigned char parport_gsc_read_data(struct parport *p)
 {
 	unsigned char val = parport_readb (DATA (p));
 #ifdef DEBUG_PARPORT
-	printk (KERN_DEBUG "parport_gsc_read_data(%p) = 0x%02x\n",
-		p, val);
+	printk(KERN_DEBUG "%s(%p) = 0x%02x\n", __func__, p, val);
 #endif
 	return val;
 }
@@ -95,9 +94,9 @@ static inline unsigned char __parport_gsc_frob_control(struct parport *p,
 	struct parport_gsc_private *priv = p->physport->private_data;
 	unsigned char ctr = priv->ctr;
 #ifdef DEBUG_PARPORT
-	printk (KERN_DEBUG
-		"__parport_gsc_frob_control(%02x,%02x): %02x -> %02x\n",
-		mask, val, ctr, ((ctr & ~mask) ^ val) & priv->ctr_writable);
+	printk(KERN_DEBUG "%s(%02x,%02x): %02x -> %02x\n",
+	       __func__, mask, val,
+	       ctr, ((ctr & ~mask) ^ val) & priv->ctr_writable);
 #endif
 	ctr = (ctr & ~mask) ^ val;
 	ctr &= priv->ctr_writable; /* only write writable bits. */
@@ -126,8 +125,8 @@ static inline void parport_gsc_write_control(struct parport *p,
 
 	/* Take this out when drivers have adapted to newer interface. */
 	if (d & 0x20) {
-		printk (KERN_DEBUG "%s (%s): use data_reverse for this!\n",
-			p->name, p->cad->name);
+		printk(KERN_DEBUG "%s (%s): use data_reverse for this!\n",
+		       p->name, p->cad->name);
 		parport_gsc_data_reverse (p);
 	}
 
@@ -155,9 +154,9 @@ static inline unsigned char parport_gsc_frob_control(struct parport *p,
 
 	/* Take this out when drivers have adapted to newer interface. */
 	if (mask & 0x20) {
-		printk (KERN_DEBUG "%s (%s): use data_%s for this!\n",
-			p->name, p->cad->name,
-			(val & 0x20) ? "reverse" : "forward");
+		printk(KERN_DEBUG "%s (%s): use data_%s for this!\n",
+		       p->name, p->cad->name,
+		       (val & 0x20) ? "reverse" : "forward");
 		if (val & 0x20)
 			parport_gsc_data_reverse (p);
 		else
diff --git a/drivers/parport/parport_ip32.c b/drivers/parport/parport_ip32.c
index 4f76e4..48b084 100644
--- a/drivers/parport/parport_ip32.c
+++ b/drivers/parport/parport_ip32.c
@@ -328,19 +328,19 @@ static void parport_ip32_dump_state(struct parport *p, char *str,
 						     "TST", "CFG"};
 		unsigned int ecr = readb(priv->regs.ecr);
 		printk(KERN_DEBUG PPIP32 "    ecr=0x%02x", ecr);
-		printk(" %s",
-		       ecr_modes[(ecr & ECR_MODE_MASK) >> ECR_MODE_SHIFT]);
+		pr_cont(" %s",
+			ecr_modes[(ecr & ECR_MODE_MASK) >> ECR_MODE_SHIFT]);
 		if (ecr & ECR_nERRINTR)
-			printk(",nErrIntrEn");
+			pr_cont(",nErrIntrEn");
 		if (ecr & ECR_DMAEN)
-			printk(",dmaEn");
+			pr_cont(",dmaEn");
 		if (ecr & ECR_SERVINTR)
-			printk(",serviceIntr");
+			pr_cont(",serviceIntr");
 		if (ecr & ECR_F_FULL)
-			printk(",f_full");
+			pr_cont(",f_full");
 		if (ecr & ECR_F_EMPTY)
-			printk(",f_empty");
-		printk("\n");
+			pr_cont(",f_empty");
+		pr_cont("\n");
 	}
 	if (show_ecp_config) {
 		unsigned int oecr, cnfgA, cnfgB;
@@ -352,52 +352,53 @@ static void parport_ip32_dump_state(struct parport *p, char *str,
 		writeb(ECR_MODE_PS2, priv->regs.ecr);
 		writeb(oecr, priv->regs.ecr);
 		printk(KERN_DEBUG PPIP32 "    cnfgA=0x%02x", cnfgA);
-		printk(" ISA-%s", (cnfgA & CNFGA_IRQ) ? "Level" : "Pulses");
+		pr_cont(" ISA-%s", (cnfgA & CNFGA_IRQ) ? "Level" : "Pulses");
 		switch (cnfgA & CNFGA_ID_MASK) {
 		case CNFGA_ID_8:
-			printk(",8 bits");
+			pr_cont(",8 bits");
 			break;
 		case CNFGA_ID_16:
-			printk(",16 bits");
+			pr_cont(",16 bits");
 			break;
 		case CNFGA_ID_32:
-			printk(",32 bits");
+			pr_cont(",32 bits");
 			break;
 		default:
-			printk(",unknown ID");
+			pr_cont(",unknown ID");
 			break;
 		}
 		if (!(cnfgA & CNFGA_nBYTEINTRANS))
-			printk(",ByteInTrans");
+			pr_cont(",ByteInTrans");
 		if ((cnfgA & CNFGA_ID_MASK) != CNFGA_ID_8)
-			printk(",%d byte%s left", cnfgA & CNFGA_PWORDLEFT,
-			       ((cnfgA & CNFGA_PWORDLEFT) > 1) ? "s" : "");
-		printk("\n");
+			pr_cont(",%d byte%s left",
+				cnfgA & CNFGA_PWORDLEFT,
+				((cnfgA & CNFGA_PWORDLEFT) > 1) ? "s" : "");
+		pr_cont("\n");
 		printk(KERN_DEBUG PPIP32 "    cnfgB=0x%02x", cnfgB);
-		printk(" irq=%u,dma=%u",
-		       (cnfgB & CNFGB_IRQ_MASK) >> CNFGB_IRQ_SHIFT,
-		       (cnfgB & CNFGB_DMA_MASK) >> CNFGB_DMA_SHIFT);
-		printk(",intrValue=%d", !!(cnfgB & CNFGB_INTRVAL));
+		pr_cont(" irq=%u,dma=%u",
+			(cnfgB & CNFGB_IRQ_MASK) >> CNFGB_IRQ_SHIFT,
+			(cnfgB & CNFGB_DMA_MASK) >> CNFGB_DMA_SHIFT);
+		pr_cont(",intrValue=%d", !!(cnfgB & CNFGB_INTRVAL));
 		if (cnfgB & CNFGB_COMPRESS)
-			printk(",compress");
-		printk("\n");
+			pr_cont(",compress");
+		pr_cont("\n");
 	}
 	for (i = 0; i < 2; i++) {
 		unsigned int dcr = i ? priv->dcr_cache : readb(priv->regs.dcr);
 		printk(KERN_DEBUG PPIP32 "    dcr(%s)=0x%02x",
 		       i ? "soft" : "hard", dcr);
-		printk(" %s", (dcr & DCR_DIR) ? "rev" : "fwd");
+		pr_cont(" %s", (dcr & DCR_DIR) ? "rev" : "fwd");
 		if (dcr & DCR_IRQ)
-			printk(",ackIntEn");
+			pr_cont(",ackIntEn");
 		if (!(dcr & DCR_SELECT))
-			printk(",nSelectIn");
+			pr_cont(",nSelectIn");
 		if (dcr & DCR_nINIT)
-			printk(",nInit");
+			pr_cont(",nInit");
 		if (!(dcr & DCR_AUTOFD))
-			printk(",nAutoFD");
+			pr_cont(",nAutoFD");
 		if (!(dcr & DCR_STROBE))
-			printk(",nStrobe");
-		printk("\n");
+			pr_cont(",nStrobe");
+		pr_cont("\n");
 	}
 #define sep (f++ ? ',' : ' ')
 	{
@@ -405,20 +406,20 @@ static void parport_ip32_dump_state(struct parport *p, char *str,
 		unsigned int dsr = readb(priv->regs.dsr);
 		printk(KERN_DEBUG PPIP32 "    dsr=0x%02x", dsr);
 		if (!(dsr & DSR_nBUSY))
-			printk("%cBusy", sep);
+			pr_cont("%cBusy", sep);
 		if (dsr & DSR_nACK)
-			printk("%cnAck", sep);
+			pr_cont("%cnAck", sep);
 		if (dsr & DSR_PERROR)
-			printk("%cPError", sep);
+			pr_cont("%cPError", sep);
 		if (dsr & DSR_SELECT)
-			printk("%cSelect", sep);
+			pr_cont("%cSelect", sep);
 		if (dsr & DSR_nFAULT)
-			printk("%cnFault", sep);
+			pr_cont("%cnFault", sep);
 		if (!(dsr & DSR_nPRINT))
-			printk("%c(Print)", sep);
+			pr_cont("%c(Print)", sep);
 		if (dsr & DSR_TIMEOUT)
-			printk("%cTimeout", sep);
-		printk("\n");
+			pr_cont("%cTimeout", sep);
+		pr_cont("\n");
 	}
 #undef sep
 }
@@ -1703,7 +1704,7 @@ static size_t parport_ip32_ecp_write_data(struct parport *p,
 
 		/* Event 49: PError goes high. */
 		if (parport_wait_peripheral(p, DSR_PERROR, DSR_PERROR)) {
-			printk(KERN_DEBUG PPIP32 "%s: PError timeout in %s",
+			printk(KERN_DEBUG PPIP32 "%s: PError timeout in %s\n",
 			       p->name, __func__);
 			physport->ieee1284.phase = IEEE1284_PH_ECP_DIR_UNKNOWN;
 			return 0;
@@ -2132,10 +2133,13 @@ static __init struct parport *parport_ip32_probe_port(void)
 	/* Print out what we found */
 	pr_info("%s: SGI IP32 at 0x%lx (0x%lx)", p->name, p->base, p->base_hi);
 	if (p->irq != PARPORT_IRQ_NONE)
-		printk(", irq %d", p->irq);
-	printk(" [");
-#define printmode(x)	if (p->modes & PARPORT_MODE_##x)		\
-				printk("%s%s", f++ ? "," : "", #x)
+		pr_cont(", irq %d", p->irq);
+	pr_cont(" [");
+#define printmode(x)							\
+do {									\
+	if (p->modes & PARPORT_MODE_##x)				\
+		pr_cont("%s%s", f++ ? "," : "", #x);			\
+} while (0)
 	{
 		unsigned int f = 0;
 		printmode(PCSPP);
@@ -2146,7 +2150,7 @@ static __init struct parport *parport_ip32_probe_port(void)
 		printmode(DMA);
 	}
 #undef printmode
-	printk("]\n");
+	pr_cont("]\n");
 
 	parport_announce_port(p);
 	return p;
diff --git a/drivers/parport/parport_pc.c b/drivers/parport/parport_pc.c
index 2872c67..ab3b04f 100644
--- a/drivers/parport/parport_pc.c
+++ b/drivers/parport/parport_pc.c
@@ -298,8 +298,8 @@ static size_t parport_pc_epp_read_data(struct parport *port, void *buf,
 			status = inb(STATUS(port));
 			if (status & 0x01) {
 				/* EPP timeout should never occur... */
-				printk(KERN_DEBUG
-"%s: EPP timeout occurred while talking to w91284pic (should not have done)\n", port->name);
+				printk(KERN_DEBUG "%s: EPP timeout occurred while talking to w91284pic (should not have done)\n",
+				       port->name);
 				clear_epp_timeout(port);
 			}
 		}
@@ -727,7 +727,7 @@ static size_t parport_pc_compat_write_block_pio(struct parport *port,
 	r = change_mode(port, ECR_PPF); /* Parallel port FIFO */
 	if (r)
 		printk(KERN_DEBUG "%s: Warning change_mode ECR_PPF failed\n",
-								port->name);
+		       port->name);
 
 	port->physport->ieee1284.phase = IEEE1284_PH_FWD_DATA;
 
@@ -770,9 +770,8 @@ static size_t parport_pc_compat_write_block_pio(struct parport *port,
 				     PARPORT_STATUS_BUSY,
 				     PARPORT_STATUS_BUSY);
 	if (r)
-		printk(KERN_DEBUG
-			"%s: BUSY timeout (%d) in compat_write_block_pio\n",
-			port->name, r);
+		printk(KERN_DEBUG "%s: BUSY timeout (%d) in compat_write_block_pio\n",
+		       port->name, r);
 
 	port->physport->ieee1284.phase = IEEE1284_PH_FWD_IDLE;
 
@@ -810,8 +809,8 @@ static size_t parport_pc_ecp_write_block_pio(struct parport *port,
 					     PARPORT_STATUS_PAPEROUT,
 					     PARPORT_STATUS_PAPEROUT);
 		if (r) {
-			printk(KERN_DEBUG "%s: PError timeout (%d) "
-				"in ecp_write_block_pio\n", port->name, r);
+			printk(KERN_DEBUG "%s: PError timeout (%d) in ecp_write_block_pio\n",
+			       port->name, r);
 		}
 	}
 
@@ -824,7 +823,7 @@ static size_t parport_pc_ecp_write_block_pio(struct parport *port,
 	r = change_mode(port, ECR_ECP); /* ECP FIFO */
 	if (r)
 		printk(KERN_DEBUG "%s: Warning change_mode ECR_ECP failed\n",
-								port->name);
+		       port->name);
 	port->physport->ieee1284.phase = IEEE1284_PH_FWD_DATA;
 
 	/* Write the data to the FIFO. */
@@ -867,8 +866,8 @@ static size_t parport_pc_ecp_write_block_pio(struct parport *port,
 		parport_frob_control(port, PARPORT_CONTROL_INIT, 0);
 		r = parport_wait_peripheral(port, PARPORT_STATUS_PAPEROUT, 0);
 		if (r)
-			printk(KERN_DEBUG "%s: PE,1 timeout (%d) "
-				"in ecp_write_block_pio\n", port->name, r);
+			printk(KERN_DEBUG "%s: PE,1 timeout (%d) in ecp_write_block_pio\n",
+			       port->name, r);
 
 		parport_frob_control(port,
 				      PARPORT_CONTROL_INIT,
@@ -877,17 +876,16 @@ static size_t parport_pc_ecp_write_block_pio(struct parport *port,
 					     PARPORT_STATUS_PAPEROUT,
 					     PARPORT_STATUS_PAPEROUT);
 		if (r)
-			printk(KERN_DEBUG "%s: PE,2 timeout (%d) "
-				"in ecp_write_block_pio\n", port->name, r);
+			printk(KERN_DEBUG "%s: PE,2 timeout (%d) in ecp_write_block_pio\n",
+			       port->name, r);
 	}
 
 	r = parport_wait_peripheral(port,
 				     PARPORT_STATUS_BUSY,
 				     PARPORT_STATUS_BUSY);
 	if (r)
-		printk(KERN_DEBUG
-			"%s: BUSY timeout (%d) in ecp_write_block_pio\n",
-			port->name, r);
+		printk(KERN_DEBUG "%s: BUSY timeout (%d) in ecp_write_block_pio\n",
+		       port->name, r);
 
 	port->physport->ieee1284.phase = IEEE1284_PH_FWD_IDLE;
 
@@ -1611,7 +1609,7 @@ static int parport_ECP_supported(struct parport *pb)
 	if (i <= priv->fifo_depth) {
 		if (verbose_probing)
 			printk(KERN_DEBUG "0x%lx: writeIntrThreshold is %d\n",
-				pb->base, i);
+			       pb->base, i);
 	} else
 		/* Number of bytes we know we can write if we get an
 		   interrupt. */
@@ -1664,14 +1662,14 @@ static int parport_ECP_supported(struct parport *pb)
 
 	if (verbose_probing) {
 		printk(KERN_DEBUG "0x%lx: PWord is %d bits\n",
-			pb->base, 8 * pword);
+		       pb->base, 8 * pword);
 
-		printk(KERN_DEBUG "0x%lx: Interrupts are ISA-%s\n", pb->base,
-			config & 0x80 ? "Level" : "Pulses");
+		printk(KERN_DEBUG "0x%lx: Interrupts are ISA-%s\n",
+		       pb->base, config & 0x80 ? "Level" : "Pulses");
 
 		configb = inb(CONFIGB(pb));
 		printk(KERN_DEBUG "0x%lx: ECP port cfgA=0x%02x cfgB=0x%02x\n",
-			pb->base, config, configb);
+		       pb->base, config, configb);
 		printk(KERN_DEBUG "0x%lx: ECP settings irq=", pb->base);
 		if ((configb >> 3) & 0x07)
 			pr_cont("%d", intrline[(configb >> 3) & 0x07]);
@@ -2453,8 +2451,7 @@ static int sio_via_probe(struct pci_dev *pdev, int autoirq, int autodma,
 		have_epp = 1;
 		break;
 	default:
-		printk(KERN_DEBUG
-			"parport_pc: probing current configuration\n");
+		printk(KERN_DEBUG "parport_pc: probing current configuration\n");
 		siofunc = VIA_FUNCTION_PROBE;
 		break;
 	}
@@ -2490,12 +2487,11 @@ static int sio_via_probe(struct pci_dev *pdev, int autoirq, int autodma,
 	port1 = inb(VIA_CONFIG_DATA) << 2;
 
 	printk(KERN_DEBUG "parport_pc: Current parallel port base: 0x%X\n",
-									port1);
+	       port1);
 	if (port1 == 0x3BC && have_epp) {
 		outb(via->viacfg_parport_base, VIA_CONFIG_INDEX);
 		outb((0x378 >> 2), VIA_CONFIG_DATA);
-		printk(KERN_DEBUG
-			"parport_pc: Parallel port base changed to 0x378\n");
+		printk(KERN_DEBUG "parport_pc: Parallel port base changed to 0x378\n");
 		port1 = 0x378;
 	}
 
@@ -2834,14 +2830,12 @@ static int parport_pc_pci_probe(struct pci_dev *dev,
 		/* TODO: test if sharing interrupts works */
 		irq = dev->irq;
 		if (irq == IRQ_NONE) {
-			printk(KERN_DEBUG
-	"PCI parallel port detected: %04x:%04x, I/O at %#lx(%#lx)\n",
-				id->vendor, id->device, io_lo, io_hi);
+			printk(KERN_DEBUG "PCI parallel port detected: %04x:%04x, I/O at %#lx(%#lx)\n",
+			       id->vendor, id->device, io_lo, io_hi);
 			irq = PARPORT_IRQ_NONE;
 		} else {
-			printk(KERN_DEBUG
-	"PCI parallel port detected: %04x:%04x, I/O at %#lx(%#lx), IRQ %d\n",
-				id->vendor, id->device, io_lo, io_hi, irq);
+			printk(KERN_DEBUG "PCI parallel port detected: %04x:%04x, I/O at %#lx(%#lx), IRQ %d\n",
+			       id->vendor, id->device, io_lo, io_hi, irq);
 		}
 		data->ports[count] =
 			parport_pc_probe_port(io_lo, io_hi, irq,
@@ -3113,8 +3107,8 @@ static int __init parport_parse_dma(const char *dmastr, int *val)
 #ifdef CONFIG_PCI
 static int __init parport_init_mode_setup(char *str)
 {
-	printk(KERN_DEBUG
-	     "parport_pc.c: Specified parameter parport_init_mode=%s\n", str);
+	printk(KERN_DEBUG "parport_pc.c: Specified parameter parport_init_mode=%s\n",
+	       str);
 
 	if (!strcmp(str, "spp"))
 		parport_init_mode = 1;
diff --git a/drivers/parport/probe.c b/drivers/parport/probe.c
index 10ed0d1..7e6d71 100644
--- a/drivers/parport/probe.c
+++ b/drivers/parport/probe.c
@@ -41,13 +41,13 @@ static void pretty_print(struct parport *port, int device)
 	pr_info("%s", port->name);
 
 	if (device >= 0)
-		printk (" (addr %d)", device);
+		pr_cont(" (addr %d)", device);
 
-	printk (": %s", classes[info->class].descr);
+	pr_cont(": %s", classes[info->class].descr);
 	if (info->class)
-		printk(", %s %s", info->mfr, info->model);
+		pr_cont(", %s %s", info->mfr, info->model);
 
-	printk("\n");
+	pr_cont("\n");
 }
 
 static void parse_data(struct parport *port, int device, char *str)
@@ -178,9 +178,8 @@ static ssize_t parport_read_device_id (struct parport *port, char *buffer,
 		 * just return constant nibble forever. This catches
 		 * also those cases. */
 		if (idlens[0] == 0 || idlens[0] > 0xFFF) {
-			printk (KERN_DEBUG "%s: reported broken Device ID"
-				" length of %#zX bytes\n",
-				port->name, idlens[0]);
+			printk(KERN_DEBUG "%s: reported broken Device ID length of %#zX bytes\n",
+			       port->name, idlens[0]);
 			return -EIO;
 		}
 		numidlens = 2;
@@ -202,10 +201,8 @@ static ssize_t parport_read_device_id (struct parport *port, char *buffer,
 
 		if (port->physport->ieee1284.phase != IEEE1284_PH_HBUSY_DAVAIL) {
 			if (belen != len) {
-				printk (KERN_DEBUG "%s: Device ID was %zd bytes"
-					" while device told it would be %d"
-					" bytes\n",
-					port->name, len, belen);
+				printk(KERN_DEBUG "%s: Device ID was %zd bytes while device told it would be %d bytes\n",
+				       port->name, len, belen);
 			}
 			goto done;
 		}
@@ -215,11 +212,9 @@ static ssize_t parport_read_device_id (struct parport *port, char *buffer,
 		 * the first 256 bytes or so that we must have read so
 		 * far. */
 		if (buffer[len-1] == ';') {
- 			printk (KERN_DEBUG "%s: Device ID reading stopped"
-				" before device told data not available. "
-				"Current idlen %u of %u, len bytes %02X %02X\n",
-				port->name, current_idlen, numidlens,
-				length[0], length[1]);
+			printk(KERN_DEBUG "%s: Device ID reading stopped before device told data not available. Current idlen %u of %u, len bytes %02X %02X\n",
+			       port->name, current_idlen, numidlens,
+			       length[0], length[1]);
 			goto done;
 		}
 	}
diff --git a/drivers/parport/share.c b/drivers/parport/share.c
index b0f451..3169fee 100644
--- a/drivers/parport/share.c
+++ b/drivers/parport/share.c
@@ -720,8 +720,7 @@ parport_register_device(struct parport *port, const char *name,
 
 	if (port->physport->flags & PARPORT_FLAG_EXCL) {
 		/* An exclusive device is registered. */
-		printk(KERN_DEBUG "%s: no more devices allowed\n",
-			port->name);
+		printk(KERN_DEBUG "%s: no more devices allowed\n", port->name);
 		return NULL;
 	}
 
@@ -789,9 +788,8 @@ parport_register_device(struct parport *port, const char *name,
 	if (flags & PARPORT_DEV_EXCL) {
 		if (port->physport->devices) {
 			spin_unlock(&port->physport->pardevice_lock);
-			printk(KERN_DEBUG
-				"%s: cannot grant exclusive access for device %s\n",
-				port->name, name);
+			printk(KERN_DEBUG "%s: cannot grant exclusive access for device %s\n",
+			       port->name, name);
 			goto out_free_all;
 		}
 		port->flags |= PARPORT_FLAG_EXCL;
@@ -1259,7 +1257,8 @@ int parport_claim_or_block(struct pardevice *dev)
 	r = parport_claim(dev);
 	if (r == -EAGAIN) {
 #ifdef PARPORT_DEBUG_SHARING
-		printk(KERN_DEBUG "%s: parport_claim() returned -EAGAIN\n", dev->name);
+		printk(KERN_DEBUG "%s: parport_claim() returned -EAGAIN\n",
+		       dev->name);
 #endif
 		/*
 		 * FIXME!!! Use the proper locking for dev->waiting,
@@ -1292,7 +1291,7 @@ int parport_claim_or_block(struct pardevice *dev)
 		if (dev->port->physport->cad != dev)
 			printk(KERN_DEBUG "%s: exiting parport_claim_or_block but %s owns port!\n",
 			       dev->name, dev->port->physport->cad ?
-			       dev->port->physport->cad->name:"nobody");
+			       dev->port->physport->cad->name : "nobody");
 #endif
 	}
 	dev->waiting = 0;
-- 
2.24.0

