Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4083C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 15:29:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AE01A21919
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 15:29:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592580578;
	bh=PdfeCfXAK1p8plhpCTmU0CIpBO7DWSybpTY5X1iwXG4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=2wTlFs5vcmKzEZYuWlFMPr4B4plfgjkqRwXWKFQ1o14XDV4Ga4VTrFvFy8nCcqjKg
	 B3AicrdX6XbmxAvMTmrEMttY4+yo+18lYj6KeruRc2ey7FqjVw4UPpXvjQztQxCF/Q
	 DhXjASA2sWhLGP8AbMSnYnHLJ3OEmW8ztN+8r5YI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404685AbgFSP3h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 11:29:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:32958 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404606AbgFSP3W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 11:29:22 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7428121974;
        Fri, 19 Jun 2020 15:29:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592580561;
        bh=PdfeCfXAK1p8plhpCTmU0CIpBO7DWSybpTY5X1iwXG4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KByzKnHWYt5rGZuSHVC7a/e7+CUZDC4T/OngtDIY3LWNbd2Y59Y2don9zcUtX7IN6
         IkjKovuRfPL33/HLKtQfSQnFQmaVsUKDxYPPqNCcIsFTMRvmGabP96jO1PCMhfR8xH
         mKQ/S6qcQiy9+/t7humEq17uy6+MxkIhjVqqpvtc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Anup Patel <anup.patel@wdc.com>,
        Marc Zyngier <maz@kernel.org>,
        Palmer Dabbelt <palmerdabbelt@google.com>
Subject: [PATCH 5.7 296/376] irqchip/sifive-plic: Setup cpuhp once after boot CPU handler is present
Date:   Fri, 19 Jun 2020 16:33:34 +0200
Message-Id: <20200619141724.352736298@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200619141710.350494719@linuxfoundation.org>
References: <20200619141710.350494719@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Anup Patel <anup.patel@wdc.com>

commit 2234ae846ccb9ebdf4c391824cb79e73674dceda upstream.

For multiple PLIC instances, the plic_init() is called once for each
PLIC instance. Due to this we have two issues:
1. cpuhp_setup_state() is called multiple times
2. plic_starting_cpu() can crash for boot CPU if cpuhp_setup_state()
   is called before boot CPU PLIC handler is available.

Address both issues by only initializing the HP notifiers when
the boot CPU setup is complete.

Fixes: f1ad1133b18f ("irqchip/sifive-plic: Add support for multiple PLICs")
Signed-off-by: Anup Patel <anup.patel@wdc.com>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Reviewed-by: Palmer Dabbelt <palmerdabbelt@google.com>
Acked-by: Palmer Dabbelt <palmerdabbelt@google.com>
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/r/20200518091441.94843-3-anup.patel@wdc.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/irqchip/irq-sifive-plic.c |   14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

--- a/drivers/irqchip/irq-sifive-plic.c
+++ b/drivers/irqchip/irq-sifive-plic.c
@@ -76,6 +76,7 @@ struct plic_handler {
 	void __iomem		*enable_base;
 	struct plic_priv	*priv;
 };
+static bool plic_cpuhp_setup_done;
 static DEFINE_PER_CPU(struct plic_handler, plic_handlers);
 
 static inline void plic_toggle(struct plic_handler *handler,
@@ -285,6 +286,7 @@ static int __init plic_init(struct devic
 	int error = 0, nr_contexts, nr_handlers = 0, i;
 	u32 nr_irqs;
 	struct plic_priv *priv;
+	struct plic_handler *handler;
 
 	priv = kzalloc(sizeof(*priv), GFP_KERNEL);
 	if (!priv)
@@ -315,7 +317,6 @@ static int __init plic_init(struct devic
 
 	for (i = 0; i < nr_contexts; i++) {
 		struct of_phandle_args parent;
-		struct plic_handler *handler;
 		irq_hw_number_t hwirq;
 		int cpu, hartid;
 
@@ -369,9 +370,18 @@ done:
 		nr_handlers++;
 	}
 
-	cpuhp_setup_state(CPUHP_AP_IRQ_SIFIVE_PLIC_STARTING,
+	/*
+	 * We can have multiple PLIC instances so setup cpuhp state only
+	 * when context handler for current/boot CPU is present.
+	 */
+	handler = this_cpu_ptr(&plic_handlers);
+	if (handler->present && !plic_cpuhp_setup_done) {
+		cpuhp_setup_state(CPUHP_AP_IRQ_SIFIVE_PLIC_STARTING,
 				  "irqchip/sifive/plic:starting",
 				  plic_starting_cpu, plic_dying_cpu);
+		plic_cpuhp_setup_done = true;
+	}
+
 	pr_info("mapped %d interrupts with %d handlers for %d contexts.\n",
 		nr_irqs, nr_handlers, nr_contexts);
 	set_handle_irq(plic_handle_irq);


