Return-Path: <SRS0=j27y=4W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A7C5C3F2D1
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 09:57:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 12C4B208CD
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 09:57:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rtfYQklR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726947AbgCEJ5u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Mar 2020 04:57:50 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:38048 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725903AbgCEJ5u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Mar 2020 04:57:50 -0500
Received: by mail-wr1-f67.google.com with SMTP id t11so6191556wrw.5
        for <linux-kernel@vger.kernel.org>; Thu, 05 Mar 2020 01:57:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=f9Y6dDiZbq3Gn6/Vwc6Qc20Po2wP0HmANub8fAzg6g8=;
        b=rtfYQklRbOxaAENaTuWCe6CkzEnVmx3gAKUBlp/Cp5gTdWQGqRUrjg/Xc/P0AcSmHP
         hfWrDKMYOYmCZOpfcEA1Sk1UoI8cVXeY61fWr1KkEvjxzPwD2PoCtKT2xI6gO6WLGGu4
         +0P5MzC8KwLQ6XGzQ40LZRHMdzKTrlrtqWdZh3sGV8eZYxyee7XvylqsEbcudsX1qnPt
         bdz4VW38Icz6T7CEQBziH305gR+HZVL3DGZszVtAHPoqvSHELaoJ5wB8jAtMMfbTYogA
         Ml2n9jl3aOL1F8nHkRepCXPaZnDtizWqWA9PEcmyKPXaW+Upa5+SOzkTI+F16fKg5PDb
         bFng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=f9Y6dDiZbq3Gn6/Vwc6Qc20Po2wP0HmANub8fAzg6g8=;
        b=baLVQF7FO4HO6a3Lb4sgZDLgIbNB0axk5hSw7W9oIhEJu0qdMokbtU+gOQ3mBfI6cl
         UlJ8nq0Un55cA5dPVAmltt6hyZAuMI8U7cFdJoYDaPOwA6hfMm05GryAjSFRdFNOBEeA
         ESCTTt5NQSVTftYF4MVpW9EfdTPj4rR2hXqsh0G0QESJFSRJFY3JqXHhgPrXA3txMY0b
         SIbgUEgyIYYO6W4T3IWuXqSGyKqMQPoUET5mzulzaQulV8md32jYi8I+KgUNJryo6+jL
         W3JuEOO1ICN8k/Vv7WPBYCz+wdytt9rf9kpTtHvdCnzEO6CyW+mfAd6cZ/xpytzjHDxe
         fEFw==
X-Gm-Message-State: ANhLgQ05kqwDarJM6mHZeQwt6GcKCcv4EOVw4/VxcqO2KRzMas8Hy7/8
        JD1HdIUsESyFb9QPHxhCabs=
X-Google-Smtp-Source: ADFU+vt/MwLeHri7D7QctDLpHVznpWp0AqylLKc06xPKFWIHWA46pB4Vht7+O53JTs2JmhcSIZ1yMg==
X-Received: by 2002:a5d:68ce:: with SMTP id p14mr9115237wrw.315.1583402264478;
        Thu, 05 Mar 2020 01:57:44 -0800 (PST)
Received: from kbp1-lhp-F74019 (ip-109-41-64-183.web.vodafone.de. [109.41.64.183])
        by smtp.gmail.com with ESMTPSA id s7sm5482757wrm.13.2020.03.05.01.57.42
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 05 Mar 2020 01:57:43 -0800 (PST)
Date:   Thu, 5 Mar 2020 11:57:39 +0200
From:   Yan Yankovskyi <yyankovskyi@gmail.com>
To:     Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Jan Beulich <jbeulich@suse.com>
Cc:     Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org
Subject: [PATCH] xen: Use evtchn_type_t as a type for event channels
Message-ID: <20200305095739.GA26471@kbp1-lhp-F74019>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make event channel functions pass event channel port using
evtchn_port_t type. It eliminates signed <-> unsigned conversion.
Also rename 'evtchn' variables to 'port' in case if 'port' is not
ambiguous.

Signed-off-by: Yan Yankovskyi <yyankovskyi@gmail.com>
---
 drivers/xen/events/events_2l.c        |  20 +-
 drivers/xen/events/events_base.c      | 253 +++++++++++++-------------
 drivers/xen/events/events_fifo.c      |  22 +--
 drivers/xen/events/events_internal.h  |  30 +--
 drivers/xen/evtchn.c                  |  15 +-
 drivers/xen/pvcalls-back.c            |   5 +-
 drivers/xen/pvcalls-front.c           |  17 +-
 drivers/xen/xen-pciback/xenbus.c      |   7 +-
 drivers/xen/xen-scsiback.c            |  11 +-
 drivers/xen/xenbus/xenbus_client.c    |   6 +-
 include/xen/events.h                  |  20 +-
 include/xen/interface/event_channel.h |   2 +-
 include/xen/xenbus.h                  |   5 +-
 13 files changed, 212 insertions(+), 201 deletions(-)

diff --git a/drivers/xen/events/events_2l.c b/drivers/xen/events/events_2l.c
index 8edef51c92e5..a246e9fa189f 100644
--- a/drivers/xen/events/events_2l.c
+++ b/drivers/xen/events/events_2l.c
@@ -53,37 +53,37 @@ static void evtchn_2l_bind_to_cpu(struct irq_info *info, unsigned cpu)
 	set_bit(info->evtchn, BM(per_cpu(cpu_evtchn_mask, cpu)));
 }
 
-static void evtchn_2l_clear_pending(unsigned port)
+static void evtchn_2l_clear_pending(evtchn_port_t port)
 {
 	struct shared_info *s = HYPERVISOR_shared_info;
 	sync_clear_bit(port, BM(&s->evtchn_pending[0]));
 }
 
-static void evtchn_2l_set_pending(unsigned port)
+static void evtchn_2l_set_pending(evtchn_port_t port)
 {
 	struct shared_info *s = HYPERVISOR_shared_info;
 	sync_set_bit(port, BM(&s->evtchn_pending[0]));
 }
 
-static bool evtchn_2l_is_pending(unsigned port)
+static bool evtchn_2l_is_pending(evtchn_port_t port)
 {
 	struct shared_info *s = HYPERVISOR_shared_info;
 	return sync_test_bit(port, BM(&s->evtchn_pending[0]));
 }
 
-static bool evtchn_2l_test_and_set_mask(unsigned port)
+static bool evtchn_2l_test_and_set_mask(evtchn_port_t port)
 {
 	struct shared_info *s = HYPERVISOR_shared_info;
 	return sync_test_and_set_bit(port, BM(&s->evtchn_mask[0]));
 }
 
-static void evtchn_2l_mask(unsigned port)
+static void evtchn_2l_mask(evtchn_port_t port)
 {
 	struct shared_info *s = HYPERVISOR_shared_info;
 	sync_set_bit(port, BM(&s->evtchn_mask[0]));
 }
 
-static void evtchn_2l_unmask(unsigned port)
+static void evtchn_2l_unmask(evtchn_port_t port)
 {
 	struct shared_info *s = HYPERVISOR_shared_info;
 	unsigned int cpu = get_cpu();
@@ -173,9 +173,9 @@ static void evtchn_2l_handle_events(unsigned cpu)
 	/* Timer interrupt has highest priority. */
 	irq = irq_from_virq(cpu, VIRQ_TIMER);
 	if (irq != -1) {
-		unsigned int evtchn = evtchn_from_irq(irq);
-		word_idx = evtchn / BITS_PER_LONG;
-		bit_idx = evtchn % BITS_PER_LONG;
+		evtchn_port_t port = evtchn_from_irq(irq);
+		word_idx = port / BITS_PER_LONG;
+		bit_idx = port % BITS_PER_LONG;
 		if (active_evtchns(cpu, s, word_idx) & (1ULL << bit_idx))
 			generic_handle_irq(irq);
 	}
@@ -228,7 +228,7 @@ static void evtchn_2l_handle_events(unsigned cpu)
 
 		do {
 			xen_ulong_t bits;
-			int port;
+			evtchn_port_t port;
 
 			bits = MASK_LSBS(pending_bits, bit_idx);
 
diff --git a/drivers/xen/events/events_base.c b/drivers/xen/events/events_base.c
index 499eff7d3f65..5b26509d773c 100644
--- a/drivers/xen/events/events_base.c
+++ b/drivers/xen/events/events_base.c
@@ -116,16 +116,16 @@ static void clear_evtchn_to_irq_all(void)
 	}
 }
 
-static int set_evtchn_to_irq(unsigned evtchn, unsigned irq)
+static int set_evtchn_to_irq(evtchn_port_t port, unsigned int irq)
 {
 	unsigned row;
 	unsigned col;
 
-	if (evtchn >= xen_evtchn_max_channels())
+	if (port >= xen_evtchn_max_channels())
 		return -EINVAL;
 
-	row = EVTCHN_ROW(evtchn);
-	col = EVTCHN_COL(evtchn);
+	row = EVTCHN_ROW(port);
+	col = EVTCHN_COL(port);
 
 	if (evtchn_to_irq[row] == NULL) {
 		/* Unallocated irq entries return -1 anyway */
@@ -143,13 +143,13 @@ static int set_evtchn_to_irq(unsigned evtchn, unsigned irq)
 	return 0;
 }
 
-int get_evtchn_to_irq(unsigned evtchn)
+int get_evtchn_to_irq(evtchn_port_t port)
 {
-	if (evtchn >= xen_evtchn_max_channels())
+	if (port >= xen_evtchn_max_channels())
 		return -1;
-	if (evtchn_to_irq[EVTCHN_ROW(evtchn)] == NULL)
+	if (evtchn_to_irq[EVTCHN_ROW(port)] == NULL)
 		return -1;
-	return evtchn_to_irq[EVTCHN_ROW(evtchn)][EVTCHN_COL(evtchn)];
+	return evtchn_to_irq[EVTCHN_ROW(port)][EVTCHN_COL(port)];
 }
 
 /* Get info for IRQ */
@@ -162,7 +162,7 @@ struct irq_info *info_for_irq(unsigned irq)
 static int xen_irq_info_common_setup(struct irq_info *info,
 				     unsigned irq,
 				     enum xen_irq_type type,
-				     unsigned evtchn,
+				     evtchn_port_t port,
 				     unsigned short cpu)
 {
 	int ret;
@@ -171,10 +171,10 @@ static int xen_irq_info_common_setup(struct irq_info *info,
 
 	info->type = type;
 	info->irq = irq;
-	info->evtchn = evtchn;
+	info->evtchn = port;
 	info->cpu = cpu;
 
-	ret = set_evtchn_to_irq(evtchn, irq);
+	ret = set_evtchn_to_irq(port, irq);
 	if (ret < 0)
 		return ret;
 
@@ -184,16 +184,16 @@ static int xen_irq_info_common_setup(struct irq_info *info,
 }
 
 static int xen_irq_info_evtchn_setup(unsigned irq,
-				     unsigned evtchn)
+				     evtchn_port_t port)
 {
 	struct irq_info *info = info_for_irq(irq);
 
-	return xen_irq_info_common_setup(info, irq, IRQT_EVTCHN, evtchn, 0);
+	return xen_irq_info_common_setup(info, irq, IRQT_EVTCHN, port, 0);
 }
 
 static int xen_irq_info_ipi_setup(unsigned cpu,
 				  unsigned irq,
-				  unsigned evtchn,
+				  evtchn_port_t port,
 				  enum ipi_vector ipi)
 {
 	struct irq_info *info = info_for_irq(irq);
@@ -202,12 +202,12 @@ static int xen_irq_info_ipi_setup(unsigned cpu,
 
 	per_cpu(ipi_to_irq, cpu)[ipi] = irq;
 
-	return xen_irq_info_common_setup(info, irq, IRQT_IPI, evtchn, 0);
+	return xen_irq_info_common_setup(info, irq, IRQT_IPI, port, 0);
 }
 
 static int xen_irq_info_virq_setup(unsigned cpu,
 				   unsigned irq,
-				   unsigned evtchn,
+				   evtchn_port_t port,
 				   unsigned virq)
 {
 	struct irq_info *info = info_for_irq(irq);
@@ -216,11 +216,11 @@ static int xen_irq_info_virq_setup(unsigned cpu,
 
 	per_cpu(virq_to_irq, cpu)[virq] = irq;
 
-	return xen_irq_info_common_setup(info, irq, IRQT_VIRQ, evtchn, 0);
+	return xen_irq_info_common_setup(info, irq, IRQT_VIRQ, port, 0);
 }
 
 static int xen_irq_info_pirq_setup(unsigned irq,
-				   unsigned evtchn,
+				   evtchn_port_t port,
 				   unsigned pirq,
 				   unsigned gsi,
 				   uint16_t domid,
@@ -233,7 +233,7 @@ static int xen_irq_info_pirq_setup(unsigned irq,
 	info->u.pirq.domid = domid;
 	info->u.pirq.flags = flags;
 
-	return xen_irq_info_common_setup(info, irq, IRQT_PIRQ, evtchn, 0);
+	return xen_irq_info_common_setup(info, irq, IRQT_PIRQ, port, 0);
 }
 
 static void xen_irq_info_cleanup(struct irq_info *info)
@@ -253,9 +253,9 @@ unsigned int evtchn_from_irq(unsigned irq)
 	return info_for_irq(irq)->evtchn;
 }
 
-unsigned irq_from_evtchn(unsigned int evtchn)
+unsigned int irq_from_evtchn(evtchn_port_t port)
 {
-	return get_evtchn_to_irq(evtchn);
+	return get_evtchn_to_irq(port);
 }
 EXPORT_SYMBOL_GPL(irq_from_evtchn);
 
@@ -304,9 +304,9 @@ unsigned cpu_from_irq(unsigned irq)
 	return info_for_irq(irq)->cpu;
 }
 
-unsigned int cpu_from_evtchn(unsigned int evtchn)
+unsigned int cpu_from_evtchn(evtchn_port_t port)
 {
-	int irq = get_evtchn_to_irq(evtchn);
+	int irq = get_evtchn_to_irq(port);
 	unsigned ret = 0;
 
 	if (irq != -1)
@@ -354,10 +354,10 @@ static void bind_evtchn_to_cpu(unsigned int chn, unsigned int cpu)
  */
 void notify_remote_via_irq(int irq)
 {
-	int evtchn = evtchn_from_irq(irq);
+	evtchn_port_t port = evtchn_from_irq(irq);
 
-	if (VALID_EVTCHN(evtchn))
-		notify_remote_via_evtchn(evtchn);
+	if (VALID_EVTCHN(port))
+		notify_remote_via_evtchn(port);
 }
 EXPORT_SYMBOL_GPL(notify_remote_via_irq);
 
@@ -445,7 +445,7 @@ static void xen_free_irq(unsigned irq)
 	irq_free_desc(irq);
 }
 
-static void xen_evtchn_close(unsigned int port)
+static void xen_evtchn_close(evtchn_port_t port)
 {
 	struct evtchn_close close;
 
@@ -472,25 +472,25 @@ static void pirq_query_unmask(int irq)
 
 static void eoi_pirq(struct irq_data *data)
 {
-	int evtchn = evtchn_from_irq(data->irq);
+	evtchn_port_t port = evtchn_from_irq(data->irq);
 	struct physdev_eoi eoi = { .irq = pirq_from_irq(data->irq) };
 	int rc = 0;
 
-	if (!VALID_EVTCHN(evtchn))
+	if (!VALID_EVTCHN(port))
 		return;
 
 	if (unlikely(irqd_is_setaffinity_pending(data)) &&
 	    likely(!irqd_irq_disabled(data))) {
-		int masked = test_and_set_mask(evtchn);
+		int masked = test_and_set_mask(port);
 
-		clear_evtchn(evtchn);
+		clear_evtchn(port);
 
 		irq_move_masked_irq(data);
 
 		if (!masked)
-			unmask_evtchn(evtchn);
+			unmask_evtchn(port);
 	} else
-		clear_evtchn(evtchn);
+		clear_evtchn(port);
 
 	if (pirq_needs_eoi(data->irq)) {
 		rc = HYPERVISOR_physdev_op(PHYSDEVOP_eoi, &eoi);
@@ -508,12 +508,12 @@ static unsigned int __startup_pirq(unsigned int irq)
 {
 	struct evtchn_bind_pirq bind_pirq;
 	struct irq_info *info = info_for_irq(irq);
-	int evtchn = evtchn_from_irq(irq);
+	evtchn_port_t port = evtchn_from_irq(irq);
 	int rc;
 
 	BUG_ON(info->type != IRQT_PIRQ);
 
-	if (VALID_EVTCHN(evtchn))
+	if (VALID_EVTCHN(port))
 		goto out;
 
 	bind_pirq.pirq = pirq_from_irq(irq);
@@ -525,30 +525,30 @@ static unsigned int __startup_pirq(unsigned int irq)
 		pr_warn("Failed to obtain physical IRQ %d\n", irq);
 		return 0;
 	}
-	evtchn = bind_pirq.port;
+	port = bind_pirq.port;
 
 	pirq_query_unmask(irq);
 
-	rc = set_evtchn_to_irq(evtchn, irq);
+	rc = set_evtchn_to_irq(port, irq);
 	if (rc)
 		goto err;
 
-	info->evtchn = evtchn;
-	bind_evtchn_to_cpu(evtchn, 0);
+	info->evtchn = port;
+	bind_evtchn_to_cpu(port, 0);
 
 	rc = xen_evtchn_port_setup(info);
 	if (rc)
 		goto err;
 
 out:
-	unmask_evtchn(evtchn);
+	unmask_evtchn(port);
 	eoi_pirq(irq_get_irq_data(irq));
 
 	return 0;
 
 err:
 	pr_err("irq%d: Failed to set port to irq mapping (%d)\n", irq, rc);
-	xen_evtchn_close(evtchn);
+	xen_evtchn_close(port);
 	return 0;
 }
 
@@ -561,15 +561,15 @@ static void shutdown_pirq(struct irq_data *data)
 {
 	unsigned int irq = data->irq;
 	struct irq_info *info = info_for_irq(irq);
-	unsigned evtchn = evtchn_from_irq(irq);
+	evtchn_port_t port = evtchn_from_irq(irq);
 
 	BUG_ON(info->type != IRQT_PIRQ);
 
-	if (!VALID_EVTCHN(evtchn))
+	if (!VALID_EVTCHN(port))
 		return;
 
-	mask_evtchn(evtchn);
-	xen_evtchn_close(evtchn);
+	mask_evtchn(port);
+	xen_evtchn_close(port);
 	xen_irq_info_cleanup(info);
 }
 
@@ -601,7 +601,7 @@ EXPORT_SYMBOL_GPL(xen_irq_from_gsi);
 
 static void __unbind_from_irq(unsigned int irq)
 {
-	int evtchn = evtchn_from_irq(irq);
+	evtchn_port_t port = evtchn_from_irq(irq);
 	struct irq_info *info = irq_get_handler_data(irq);
 
 	if (info->refcnt > 0) {
@@ -610,10 +610,10 @@ static void __unbind_from_irq(unsigned int irq)
 			return;
 	}
 
-	if (VALID_EVTCHN(evtchn)) {
+	if (VALID_EVTCHN(port)) {
 		unsigned int cpu = cpu_from_irq(irq);
 
-		xen_evtchn_close(evtchn);
+		xen_evtchn_close(port);
 
 		switch (type_from_irq(irq)) {
 		case IRQT_VIRQ:
@@ -827,17 +827,17 @@ int xen_pirq_from_irq(unsigned irq)
 }
 EXPORT_SYMBOL_GPL(xen_pirq_from_irq);
 
-int bind_evtchn_to_irq(unsigned int evtchn)
+int bind_evtchn_to_irq(evtchn_port_t port)
 {
 	int irq;
 	int ret;
 
-	if (evtchn >= xen_evtchn_max_channels())
+	if (port >= xen_evtchn_max_channels())
 		return -ENOMEM;
 
 	mutex_lock(&irq_mapping_update_lock);
 
-	irq = get_evtchn_to_irq(evtchn);
+	irq = get_evtchn_to_irq(port);
 
 	if (irq == -1) {
 		irq = xen_allocate_irq_dynamic();
@@ -847,14 +847,14 @@ int bind_evtchn_to_irq(unsigned int evtchn)
 		irq_set_chip_and_handler_name(irq, &xen_dynamic_chip,
 					      handle_edge_irq, "event");
 
-		ret = xen_irq_info_evtchn_setup(irq, evtchn);
+		ret = xen_irq_info_evtchn_setup(irq, port);
 		if (ret < 0) {
 			__unbind_from_irq(irq);
 			irq = ret;
 			goto out;
 		}
 		/* New interdomain events are bound to VCPU 0. */
-		bind_evtchn_to_cpu(evtchn, 0);
+		bind_evtchn_to_cpu(port, 0);
 	} else {
 		struct irq_info *info = info_for_irq(irq);
 		WARN_ON(info == NULL || info->type != IRQT_EVTCHN);
@@ -870,8 +870,8 @@ EXPORT_SYMBOL_GPL(bind_evtchn_to_irq);
 static int bind_ipi_to_irq(unsigned int ipi, unsigned int cpu)
 {
 	struct evtchn_bind_ipi bind_ipi;
-	int evtchn, irq;
-	int ret;
+	evtchn_port_t port;
+	int ret, irq;
 
 	mutex_lock(&irq_mapping_update_lock);
 
@@ -889,15 +889,15 @@ static int bind_ipi_to_irq(unsigned int ipi, unsigned int cpu)
 		if (HYPERVISOR_event_channel_op(EVTCHNOP_bind_ipi,
 						&bind_ipi) != 0)
 			BUG();
-		evtchn = bind_ipi.port;
+		port = bind_ipi.port;
 
-		ret = xen_irq_info_ipi_setup(cpu, irq, evtchn, ipi);
+		ret = xen_irq_info_ipi_setup(cpu, irq, port, ipi);
 		if (ret < 0) {
 			__unbind_from_irq(irq);
 			irq = ret;
 			goto out;
 		}
-		bind_evtchn_to_cpu(evtchn, cpu);
+		bind_evtchn_to_cpu(port, cpu);
 	} else {
 		struct irq_info *info = info_for_irq(irq);
 		WARN_ON(info == NULL || info->type != IRQT_IPI);
@@ -909,7 +909,7 @@ static int bind_ipi_to_irq(unsigned int ipi, unsigned int cpu)
 }
 
 int bind_interdomain_evtchn_to_irq(unsigned int remote_domain,
-				   unsigned int remote_port)
+				   evtchn_port_t remote_port)
 {
 	struct evtchn_bind_interdomain bind_interdomain;
 	int err;
@@ -927,7 +927,8 @@ EXPORT_SYMBOL_GPL(bind_interdomain_evtchn_to_irq);
 static int find_virq(unsigned int virq, unsigned int cpu)
 {
 	struct evtchn_status status;
-	int port, rc = -ENOENT;
+	evtchn_port_t port;
+	int rc = -ENOENT;
 
 	memset(&status, 0, sizeof(status));
 	for (port = 0; port < xen_evtchn_max_channels(); port++) {
@@ -962,7 +963,8 @@ EXPORT_SYMBOL_GPL(xen_evtchn_nr_channels);
 int bind_virq_to_irq(unsigned int virq, unsigned int cpu, bool percpu)
 {
 	struct evtchn_bind_virq bind_virq;
-	int evtchn, irq, ret;
+	evtchn_port_t port = xen_evtchn_max_channels();
+	int irq, ret;
 
 	mutex_lock(&irq_mapping_update_lock);
 
@@ -985,22 +987,21 @@ int bind_virq_to_irq(unsigned int virq, unsigned int cpu, bool percpu)
 		ret = HYPERVISOR_event_channel_op(EVTCHNOP_bind_virq,
 						&bind_virq);
 		if (ret == 0)
-			evtchn = bind_virq.port;
+			port = bind_virq.port;
 		else {
 			if (ret == -EEXIST)
 				ret = find_virq(virq, cpu);
 			BUG_ON(ret < 0);
-			evtchn = ret;
 		}
 
-		ret = xen_irq_info_virq_setup(cpu, irq, evtchn, virq);
+		ret = xen_irq_info_virq_setup(cpu, irq, port, virq);
 		if (ret < 0) {
 			__unbind_from_irq(irq);
 			irq = ret;
 			goto out;
 		}
 
-		bind_evtchn_to_cpu(evtchn, cpu);
+		bind_evtchn_to_cpu(port, cpu);
 	} else {
 		struct irq_info *info = info_for_irq(irq);
 		WARN_ON(info == NULL || info->type != IRQT_VIRQ);
@@ -1019,14 +1020,14 @@ static void unbind_from_irq(unsigned int irq)
 	mutex_unlock(&irq_mapping_update_lock);
 }
 
-int bind_evtchn_to_irqhandler(unsigned int evtchn,
+int bind_evtchn_to_irqhandler(evtchn_port_t port,
 			      irq_handler_t handler,
 			      unsigned long irqflags,
 			      const char *devname, void *dev_id)
 {
 	int irq, retval;
 
-	irq = bind_evtchn_to_irq(evtchn);
+	irq = bind_evtchn_to_irq(port);
 	if (irq < 0)
 		return irq;
 	retval = request_irq(irq, handler, irqflags, devname, dev_id);
@@ -1040,7 +1041,7 @@ int bind_evtchn_to_irqhandler(unsigned int evtchn,
 EXPORT_SYMBOL_GPL(bind_evtchn_to_irqhandler);
 
 int bind_interdomain_evtchn_to_irqhandler(unsigned int remote_domain,
-					  unsigned int remote_port,
+					  evtchn_port_t remote_port,
 					  irq_handler_t handler,
 					  unsigned long irqflags,
 					  const char *devname,
@@ -1132,9 +1133,9 @@ int xen_set_irq_priority(unsigned irq, unsigned priority)
 }
 EXPORT_SYMBOL_GPL(xen_set_irq_priority);
 
-int evtchn_make_refcounted(unsigned int evtchn)
+int evtchn_make_refcounted(evtchn_port_t port)
 {
-	int irq = get_evtchn_to_irq(evtchn);
+	int irq = get_evtchn_to_irq(port);
 	struct irq_info *info;
 
 	if (irq == -1)
@@ -1153,18 +1154,18 @@ int evtchn_make_refcounted(unsigned int evtchn)
 }
 EXPORT_SYMBOL_GPL(evtchn_make_refcounted);
 
-int evtchn_get(unsigned int evtchn)
+int evtchn_get(evtchn_port_t port)
 {
 	int irq;
 	struct irq_info *info;
 	int err = -ENOENT;
 
-	if (evtchn >= xen_evtchn_max_channels())
+	if (port >= xen_evtchn_max_channels())
 		return -EINVAL;
 
 	mutex_lock(&irq_mapping_update_lock);
 
-	irq = get_evtchn_to_irq(evtchn);
+	irq = get_evtchn_to_irq(port);
 	if (irq == -1)
 		goto done;
 
@@ -1186,9 +1187,9 @@ int evtchn_get(unsigned int evtchn)
 }
 EXPORT_SYMBOL_GPL(evtchn_get);
 
-void evtchn_put(unsigned int evtchn)
+void evtchn_put(evtchn_port_t port)
 {
-	int irq = get_evtchn_to_irq(evtchn);
+	int irq = get_evtchn_to_irq(port);
 	if (WARN_ON(irq == -1))
 		return;
 	unbind_from_irq(irq);
@@ -1252,7 +1253,7 @@ void xen_hvm_evtchn_do_upcall(void)
 EXPORT_SYMBOL_GPL(xen_hvm_evtchn_do_upcall);
 
 /* Rebind a new event channel to an existing irq. */
-void rebind_evtchn_irq(int evtchn, int irq)
+void rebind_evtchn_irq(evtchn_port_t port, int irq)
 {
 	struct irq_info *info = info_for_irq(irq);
 
@@ -1266,16 +1267,16 @@ void rebind_evtchn_irq(int evtchn, int irq)
 	mutex_lock(&irq_mapping_update_lock);
 
 	/* After resume the irq<->evtchn mappings are all cleared out */
-	BUG_ON(get_evtchn_to_irq(evtchn) != -1);
+	BUG_ON(get_evtchn_to_irq(port) != -1);
 	/* Expect irq to have been bound before,
 	   so there should be a proper type */
 	BUG_ON(info->type == IRQT_UNBOUND);
 
-	(void)xen_irq_info_evtchn_setup(irq, evtchn);
+	(void)xen_irq_info_evtchn_setup(irq, port);
 
 	mutex_unlock(&irq_mapping_update_lock);
 
-        bind_evtchn_to_cpu(evtchn, info->cpu);
+	bind_evtchn_to_cpu(port, info->cpu);
 	/* This will be deferred until interrupt is processed */
 	irq_set_affinity(irq, cpumask_of(info->cpu));
 
@@ -1284,26 +1285,26 @@ void rebind_evtchn_irq(int evtchn, int irq)
 }
 
 /* Rebind an evtchn so that it gets delivered to a specific cpu */
-static int xen_rebind_evtchn_to_cpu(int evtchn, unsigned int tcpu)
+static int xen_rebind_evtchn_to_cpu(evtchn_port_t port, unsigned int tcpu)
 {
 	struct evtchn_bind_vcpu bind_vcpu;
 	int masked;
 
-	if (!VALID_EVTCHN(evtchn))
+	if (!VALID_EVTCHN(port))
 		return -1;
 
 	if (!xen_support_evtchn_rebind())
 		return -1;
 
 	/* Send future instances of this interrupt to other vcpu. */
-	bind_vcpu.port = evtchn;
+	bind_vcpu.port = port;
 	bind_vcpu.vcpu = xen_vcpu_nr(tcpu);
 
 	/*
 	 * Mask the event while changing the VCPU binding to prevent
 	 * it being delivered on an unexpected VCPU.
 	 */
-	masked = test_and_set_mask(evtchn);
+	masked = test_and_set_mask(port);
 
 	/*
 	 * If this fails, it usually just indicates that we're dealing with a
@@ -1311,10 +1312,10 @@ static int xen_rebind_evtchn_to_cpu(int evtchn, unsigned int tcpu)
 	 * it, but don't do the xenlinux-level rebind in that case.
 	 */
 	if (HYPERVISOR_event_channel_op(EVTCHNOP_bind_vcpu, &bind_vcpu) >= 0)
-		bind_evtchn_to_cpu(evtchn, tcpu);
+		bind_evtchn_to_cpu(port, tcpu);
 
 	if (!masked)
-		unmask_evtchn(evtchn);
+		unmask_evtchn(port);
 
 	return 0;
 }
@@ -1342,39 +1343,39 @@ EXPORT_SYMBOL_GPL(xen_set_affinity_evtchn);
 
 static void enable_dynirq(struct irq_data *data)
 {
-	int evtchn = evtchn_from_irq(data->irq);
+	evtchn_port_t port = evtchn_from_irq(data->irq);
 
-	if (VALID_EVTCHN(evtchn))
-		unmask_evtchn(evtchn);
+	if (VALID_EVTCHN(port))
+		unmask_evtchn(port);
 }
 
 static void disable_dynirq(struct irq_data *data)
 {
-	int evtchn = evtchn_from_irq(data->irq);
+	evtchn_port_t port = evtchn_from_irq(data->irq);
 
-	if (VALID_EVTCHN(evtchn))
-		mask_evtchn(evtchn);
+	if (VALID_EVTCHN(port))
+		mask_evtchn(port);
 }
 
 static void ack_dynirq(struct irq_data *data)
 {
-	int evtchn = evtchn_from_irq(data->irq);
+	evtchn_port_t port = evtchn_from_irq(data->irq);
 
-	if (!VALID_EVTCHN(evtchn))
+	if (!VALID_EVTCHN(port))
 		return;
 
 	if (unlikely(irqd_is_setaffinity_pending(data)) &&
 	    likely(!irqd_irq_disabled(data))) {
-		int masked = test_and_set_mask(evtchn);
+		int masked = test_and_set_mask(port);
 
-		clear_evtchn(evtchn);
+		clear_evtchn(port);
 
 		irq_move_masked_irq(data);
 
 		if (!masked)
-			unmask_evtchn(evtchn);
+			unmask_evtchn(port);
 	} else
-		clear_evtchn(evtchn);
+		clear_evtchn(port);
 }
 
 static void mask_ack_dynirq(struct irq_data *data)
@@ -1385,16 +1386,16 @@ static void mask_ack_dynirq(struct irq_data *data)
 
 static int retrigger_dynirq(struct irq_data *data)
 {
-	unsigned int evtchn = evtchn_from_irq(data->irq);
+	evtchn_port_t port = evtchn_from_irq(data->irq);
 	int masked;
 
-	if (!VALID_EVTCHN(evtchn))
+	if (!VALID_EVTCHN(port))
 		return 0;
 
-	masked = test_and_set_mask(evtchn);
-	set_evtchn(evtchn);
+	masked = test_and_set_mask(port);
+	set_evtchn(port);
 	if (!masked)
-		unmask_evtchn(evtchn);
+		unmask_evtchn(port);
 
 	return 1;
 }
@@ -1440,7 +1441,8 @@ static void restore_pirqs(void)
 static void restore_cpu_virqs(unsigned int cpu)
 {
 	struct evtchn_bind_virq bind_virq;
-	int virq, irq, evtchn;
+	evtchn_port_t port;
+	int virq, irq;
 
 	for (virq = 0; virq < NR_VIRQS; virq++) {
 		if ((irq = per_cpu(virq_to_irq, cpu)[virq]) == -1)
@@ -1454,18 +1456,19 @@ static void restore_cpu_virqs(unsigned int cpu)
 		if (HYPERVISOR_event_channel_op(EVTCHNOP_bind_virq,
 						&bind_virq) != 0)
 			BUG();
-		evtchn = bind_virq.port;
+		port = bind_virq.port;
 
 		/* Record the new mapping. */
-		(void)xen_irq_info_virq_setup(cpu, irq, evtchn, virq);
-		bind_evtchn_to_cpu(evtchn, cpu);
+		(void)xen_irq_info_virq_setup(cpu, irq, port, virq);
+		bind_evtchn_to_cpu(port, cpu);
 	}
 }
 
 static void restore_cpu_ipis(unsigned int cpu)
 {
 	struct evtchn_bind_ipi bind_ipi;
-	int ipi, irq, evtchn;
+	evtchn_port_t port;
+	int ipi, irq;
 
 	for (ipi = 0; ipi < XEN_NR_IPIS; ipi++) {
 		if ((irq = per_cpu(ipi_to_irq, cpu)[ipi]) == -1)
@@ -1478,38 +1481,38 @@ static void restore_cpu_ipis(unsigned int cpu)
 		if (HYPERVISOR_event_channel_op(EVTCHNOP_bind_ipi,
 						&bind_ipi) != 0)
 			BUG();
-		evtchn = bind_ipi.port;
+		port = bind_ipi.port;
 
 		/* Record the new mapping. */
-		(void)xen_irq_info_ipi_setup(cpu, irq, evtchn, ipi);
-		bind_evtchn_to_cpu(evtchn, cpu);
+		(void)xen_irq_info_ipi_setup(cpu, irq, port, ipi);
+		bind_evtchn_to_cpu(port, cpu);
 	}
 }
 
 /* Clear an irq's pending state, in preparation for polling on it */
 void xen_clear_irq_pending(int irq)
 {
-	int evtchn = evtchn_from_irq(irq);
+	evtchn_port_t port = evtchn_from_irq(irq);
 
-	if (VALID_EVTCHN(evtchn))
-		clear_evtchn(evtchn);
+	if (VALID_EVTCHN(port))
+		clear_evtchn(port);
 }
 EXPORT_SYMBOL(xen_clear_irq_pending);
 void xen_set_irq_pending(int irq)
 {
-	int evtchn = evtchn_from_irq(irq);
+	evtchn_port_t port = evtchn_from_irq(irq);
 
-	if (VALID_EVTCHN(evtchn))
-		set_evtchn(evtchn);
+	if (VALID_EVTCHN(port))
+		set_evtchn(port);
 }
 
 bool xen_test_irq_pending(int irq)
 {
-	int evtchn = evtchn_from_irq(irq);
+	evtchn_port_t port = evtchn_from_irq(irq);
 	bool ret = false;
 
-	if (VALID_EVTCHN(evtchn))
-		ret = test_evtchn(evtchn);
+	if (VALID_EVTCHN(port))
+		ret = test_evtchn(port);
 
 	return ret;
 }
@@ -1518,14 +1521,14 @@ bool xen_test_irq_pending(int irq)
  * the irq will be disabled so it won't deliver an interrupt. */
 void xen_poll_irq_timeout(int irq, u64 timeout)
 {
-	evtchn_port_t evtchn = evtchn_from_irq(irq);
+	evtchn_port_t port = evtchn_from_irq(irq);
 
-	if (VALID_EVTCHN(evtchn)) {
+	if (VALID_EVTCHN(port)) {
 		struct sched_poll poll;
 
 		poll.nr_ports = 1;
 		poll.timeout = timeout;
-		set_xen_guest_handle(poll.ports, &evtchn);
+		set_xen_guest_handle(poll.ports, &port);
 
 		if (HYPERVISOR_sched_op(SCHEDOP_poll, &poll) != 0)
 			BUG();
@@ -1667,7 +1670,7 @@ module_param(fifo_events, bool, 0);
 void __init xen_init_IRQ(void)
 {
 	int ret = -EINVAL;
-	unsigned int evtchn;
+	evtchn_port_t port;
 
 	if (fifo_events)
 		ret = xen_evtchn_fifo_init();
@@ -1679,8 +1682,8 @@ void __init xen_init_IRQ(void)
 	BUG_ON(!evtchn_to_irq);
 
 	/* No event channels are 'live' right now. */
-	for (evtchn = 0; evtchn < xen_evtchn_nr_channels(); evtchn++)
-		mask_evtchn(evtchn);
+	for (port = 0; port < xen_evtchn_nr_channels(); port++)
+		mask_evtchn(port);
 
 	pirq_needs_eoi = pirq_needs_eoi_flag;
 
diff --git a/drivers/xen/events/events_fifo.c b/drivers/xen/events/events_fifo.c
index 76b318e88382..c60ee0450173 100644
--- a/drivers/xen/events/events_fifo.c
+++ b/drivers/xen/events/events_fifo.c
@@ -82,7 +82,7 @@ static unsigned event_array_pages __read_mostly;
 
 #endif
 
-static inline event_word_t *event_word_from_port(unsigned port)
+static inline event_word_t *event_word_from_port(evtchn_port_t port)
 {
 	unsigned i = port / EVENT_WORDS_PER_PAGE;
 
@@ -140,7 +140,7 @@ static void init_array_page(event_word_t *array_page)
 
 static int evtchn_fifo_setup(struct irq_info *info)
 {
-	unsigned port = info->evtchn;
+	evtchn_port_t port = info->evtchn;
 	unsigned new_array_pages;
 	int ret;
 
@@ -191,37 +191,37 @@ static void evtchn_fifo_bind_to_cpu(struct irq_info *info, unsigned cpu)
 	/* no-op */
 }
 
-static void evtchn_fifo_clear_pending(unsigned port)
+static void evtchn_fifo_clear_pending(evtchn_port_t port)
 {
 	event_word_t *word = event_word_from_port(port);
 	sync_clear_bit(EVTCHN_FIFO_BIT(PENDING, word), BM(word));
 }
 
-static void evtchn_fifo_set_pending(unsigned port)
+static void evtchn_fifo_set_pending(evtchn_port_t port)
 {
 	event_word_t *word = event_word_from_port(port);
 	sync_set_bit(EVTCHN_FIFO_BIT(PENDING, word), BM(word));
 }
 
-static bool evtchn_fifo_is_pending(unsigned port)
+static bool evtchn_fifo_is_pending(evtchn_port_t port)
 {
 	event_word_t *word = event_word_from_port(port);
 	return sync_test_bit(EVTCHN_FIFO_BIT(PENDING, word), BM(word));
 }
 
-static bool evtchn_fifo_test_and_set_mask(unsigned port)
+static bool evtchn_fifo_test_and_set_mask(evtchn_port_t port)
 {
 	event_word_t *word = event_word_from_port(port);
 	return sync_test_and_set_bit(EVTCHN_FIFO_BIT(MASKED, word), BM(word));
 }
 
-static void evtchn_fifo_mask(unsigned port)
+static void evtchn_fifo_mask(evtchn_port_t port)
 {
 	event_word_t *word = event_word_from_port(port);
 	sync_set_bit(EVTCHN_FIFO_BIT(MASKED, word), BM(word));
 }
 
-static bool evtchn_fifo_is_masked(unsigned port)
+static bool evtchn_fifo_is_masked(evtchn_port_t port)
 {
 	event_word_t *word = event_word_from_port(port);
 	return sync_test_bit(EVTCHN_FIFO_BIT(MASKED, word), BM(word));
@@ -242,7 +242,7 @@ static void clear_masked(volatile event_word_t *word)
 	} while (w != old);
 }
 
-static void evtchn_fifo_unmask(unsigned port)
+static void evtchn_fifo_unmask(evtchn_port_t port)
 {
 	event_word_t *word = event_word_from_port(port);
 
@@ -270,7 +270,7 @@ static uint32_t clear_linked(volatile event_word_t *word)
 	return w & EVTCHN_FIFO_LINK_MASK;
 }
 
-static void handle_irq_for_port(unsigned port)
+static void handle_irq_for_port(evtchn_port_t port)
 {
 	int irq;
 
@@ -286,7 +286,7 @@ static void consume_one_event(unsigned cpu,
 {
 	struct evtchn_fifo_queue *q = &per_cpu(cpu_queue, cpu);
 	uint32_t head;
-	unsigned port;
+	evtchn_port_t port;
 	event_word_t *word;
 
 	head = q->head[priority];
diff --git a/drivers/xen/events/events_internal.h b/drivers/xen/events/events_internal.h
index 82938cff6c7a..f403cf25d45e 100644
--- a/drivers/xen/events/events_internal.h
+++ b/drivers/xen/events/events_internal.h
@@ -33,7 +33,7 @@ struct irq_info {
 	int refcnt;
 	enum xen_irq_type type;	/* type */
 	unsigned irq;
-	unsigned int evtchn;	/* event channel */
+	evtchn_port_t evtchn;	/* event channel */
 	unsigned short cpu;	/* cpu bound */
 
 	union {
@@ -60,12 +60,12 @@ struct evtchn_ops {
 	int (*setup)(struct irq_info *info);
 	void (*bind_to_cpu)(struct irq_info *info, unsigned cpu);
 
-	void (*clear_pending)(unsigned port);
-	void (*set_pending)(unsigned port);
-	bool (*is_pending)(unsigned port);
-	bool (*test_and_set_mask)(unsigned port);
-	void (*mask)(unsigned port);
-	void (*unmask)(unsigned port);
+	void (*clear_pending)(evtchn_port_t port);
+	void (*set_pending)(evtchn_port_t port);
+	bool (*is_pending)(evtchn_port_t port);
+	bool (*test_and_set_mask)(evtchn_port_t port);
+	void (*mask)(evtchn_port_t port);
+	void (*unmask)(evtchn_port_t port);
 
 	void (*handle_events)(unsigned cpu);
 	void (*resume)(void);
@@ -74,11 +74,11 @@ struct evtchn_ops {
 extern const struct evtchn_ops *evtchn_ops;
 
 extern int **evtchn_to_irq;
-int get_evtchn_to_irq(unsigned int evtchn);
+int get_evtchn_to_irq(evtchn_port_t port);
 
 struct irq_info *info_for_irq(unsigned irq);
 unsigned cpu_from_irq(unsigned irq);
-unsigned cpu_from_evtchn(unsigned int evtchn);
+unsigned int cpu_from_evtchn(evtchn_port_t port);
 
 static inline unsigned xen_evtchn_max_channels(void)
 {
@@ -102,32 +102,32 @@ static inline void xen_evtchn_port_bind_to_cpu(struct irq_info *info,
 	evtchn_ops->bind_to_cpu(info, cpu);
 }
 
-static inline void clear_evtchn(unsigned port)
+static inline void clear_evtchn(evtchn_port_t port)
 {
 	evtchn_ops->clear_pending(port);
 }
 
-static inline void set_evtchn(unsigned port)
+static inline void set_evtchn(evtchn_port_t port)
 {
 	evtchn_ops->set_pending(port);
 }
 
-static inline bool test_evtchn(unsigned port)
+static inline bool test_evtchn(evtchn_port_t port)
 {
 	return evtchn_ops->is_pending(port);
 }
 
-static inline bool test_and_set_mask(unsigned port)
+static inline bool test_and_set_mask(evtchn_port_t port)
 {
 	return evtchn_ops->test_and_set_mask(port);
 }
 
-static inline void mask_evtchn(unsigned port)
+static inline void mask_evtchn(evtchn_port_t port)
 {
 	return evtchn_ops->mask(port);
 }
 
-static inline void unmask_evtchn(unsigned port)
+static inline void unmask_evtchn(evtchn_port_t port)
 {
 	return evtchn_ops->unmask(port);
 }
diff --git a/drivers/xen/evtchn.c b/drivers/xen/evtchn.c
index 052b55a14ebc..31a83d5dfebc 100644
--- a/drivers/xen/evtchn.c
+++ b/drivers/xen/evtchn.c
@@ -83,7 +83,7 @@ struct per_user_data {
 struct user_evtchn {
 	struct rb_node node;
 	struct per_user_data *user;
-	unsigned port;
+	evtchn_port_t port;
 	bool enabled;
 };
 
@@ -138,7 +138,8 @@ static void del_evtchn(struct per_user_data *u, struct user_evtchn *evtchn)
 	kfree(evtchn);
 }
 
-static struct user_evtchn *find_evtchn(struct per_user_data *u, unsigned port)
+static struct user_evtchn *find_evtchn(struct per_user_data *u,
+				       evtchn_port_t port)
 {
 	struct rb_node *node = u->evtchns.rb_node;
 
@@ -163,7 +164,7 @@ static irqreturn_t evtchn_interrupt(int irq, void *data)
 	struct per_user_data *u = evtchn->user;
 
 	WARN(!evtchn->enabled,
-	     "Interrupt for port %d, but apparently not enabled; per-user %p\n",
+	     "Interrupt for port %u, but apparently not enabled; per-user %p\n",
 	     evtchn->port, u);
 
 	disable_irq_nosync(irq);
@@ -286,7 +287,7 @@ static ssize_t evtchn_write(struct file *file, const char __user *buf,
 	mutex_lock(&u->bind_mutex);
 
 	for (i = 0; i < (count/sizeof(evtchn_port_t)); i++) {
-		unsigned port = kbuf[i];
+		evtchn_port_t port = kbuf[i];
 		struct user_evtchn *evtchn;
 
 		evtchn = find_evtchn(u, port);
@@ -361,7 +362,7 @@ static int evtchn_resize_ring(struct per_user_data *u)
 	return 0;
 }
 
-static int evtchn_bind_to_user(struct per_user_data *u, int port)
+static int evtchn_bind_to_user(struct per_user_data *u, evtchn_port_t port)
 {
 	struct user_evtchn *evtchn;
 	struct evtchn_close close;
@@ -423,13 +424,13 @@ static void evtchn_unbind_from_user(struct per_user_data *u,
 
 static DEFINE_PER_CPU(int, bind_last_selected_cpu);
 
-static void evtchn_bind_interdom_next_vcpu(int evtchn)
+static void evtchn_bind_interdom_next_vcpu(evtchn_port_t port)
 {
 	unsigned int selected_cpu, irq;
 	struct irq_desc *desc;
 	unsigned long flags;
 
-	irq = irq_from_evtchn(evtchn);
+	irq = irq_from_evtchn(port);
 	desc = irq_to_desc(irq);
 
 	if (!desc)
diff --git a/drivers/xen/pvcalls-back.c b/drivers/xen/pvcalls-back.c
index c57c71b7d53d..cf4ce3e9358d 100644
--- a/drivers/xen/pvcalls-back.c
+++ b/drivers/xen/pvcalls-back.c
@@ -300,7 +300,7 @@ static struct sock_mapping *pvcalls_new_active_socket(
 		struct pvcalls_fedata *fedata,
 		uint64_t id,
 		grant_ref_t ref,
-		uint32_t evtchn,
+		evtchn_port_t evtchn,
 		struct socket *sock)
 {
 	int ret;
@@ -905,7 +905,8 @@ static irqreturn_t pvcalls_back_conn_event(int irq, void *sock_map)
 
 static int backend_connect(struct xenbus_device *dev)
 {
-	int err, evtchn;
+	int err;
+	evtchn_port_t evtchn;
 	grant_ref_t ring_ref;
 	struct pvcalls_fedata *fedata = NULL;
 
diff --git a/drivers/xen/pvcalls-front.c b/drivers/xen/pvcalls-front.c
index 57592a6b5c9e..a7b6fff29e73 100644
--- a/drivers/xen/pvcalls-front.c
+++ b/drivers/xen/pvcalls-front.c
@@ -368,12 +368,11 @@ static int alloc_active_ring(struct sock_mapping *map)
 	return -ENOMEM;
 }
 
-static int create_active(struct sock_mapping *map, int *evtchn)
+static int create_active(struct sock_mapping *map, evtchn_port_t *evtchn)
 {
 	void *bytes;
-	int ret = -ENOMEM, irq = -1, i;
+	int ret = -ENOMEM, irq = -1, free_evtchn = 0, i;
 
-	*evtchn = -1;
 	init_waitqueue_head(&map->active.inflight_conn_req);
 
 	bytes = map->active.data.in;
@@ -389,6 +388,7 @@ static int create_active(struct sock_mapping *map, int *evtchn)
 	ret = xenbus_alloc_evtchn(pvcalls_front_dev, evtchn);
 	if (ret)
 		goto out_error;
+	free_evtchn = 1;
 	irq = bind_evtchn_to_irqhandler(*evtchn, pvcalls_front_conn_handler,
 					0, "pvcalls-frontend", map);
 	if (irq < 0) {
@@ -404,7 +404,7 @@ static int create_active(struct sock_mapping *map, int *evtchn)
 	return 0;
 
 out_error:
-	if (*evtchn >= 0)
+	if (free_evtchn)
 		xenbus_free_evtchn(pvcalls_front_dev, *evtchn);
 	return ret;
 }
@@ -415,7 +415,8 @@ int pvcalls_front_connect(struct socket *sock, struct sockaddr *addr,
 	struct pvcalls_bedata *bedata;
 	struct sock_mapping *map = NULL;
 	struct xen_pvcalls_request *req;
-	int notify, req_id, ret, evtchn;
+	int notify, req_id, ret;
+	evtchn_port_t evtchn;
 
 	if (addr->sa_family != AF_INET || sock->type != SOCK_STREAM)
 		return -EOPNOTSUPP;
@@ -765,7 +766,8 @@ int pvcalls_front_accept(struct socket *sock, struct socket *newsock, int flags)
 	struct sock_mapping *map;
 	struct sock_mapping *map2 = NULL;
 	struct xen_pvcalls_request *req;
-	int notify, req_id, ret, evtchn, nonblock;
+	int notify, req_id, ret, nonblock;
+	evtchn_port_t evtchn;
 
 	map = pvcalls_enter_sock(sock);
 	if (IS_ERR(map))
@@ -1125,7 +1127,8 @@ static int pvcalls_front_remove(struct xenbus_device *dev)
 static int pvcalls_front_probe(struct xenbus_device *dev,
 			  const struct xenbus_device_id *id)
 {
-	int ret = -ENOMEM, evtchn, i;
+	int ret = -ENOMEM, i;
+	evtchn_port_t evtchn;
 	unsigned int max_page_order, function_calls, len;
 	char *versions;
 	grant_ref_t gref_head = 0;
diff --git a/drivers/xen/xen-pciback/xenbus.c b/drivers/xen/xen-pciback/xenbus.c
index 833b2d2c4318..f2115587855f 100644
--- a/drivers/xen/xen-pciback/xenbus.c
+++ b/drivers/xen/xen-pciback/xenbus.c
@@ -105,13 +105,13 @@ static void free_pdev(struct xen_pcibk_device *pdev)
 }
 
 static int xen_pcibk_do_attach(struct xen_pcibk_device *pdev, int gnt_ref,
-			     int remote_evtchn)
+			     evtchn_port_t remote_evtchn)
 {
 	int err = 0;
 	void *vaddr;
 
 	dev_dbg(&pdev->xdev->dev,
-		"Attaching to frontend resources - gnt_ref=%d evtchn=%d\n",
+		"Attaching to frontend resources - gnt_ref=%d evtchn=%u\n",
 		gnt_ref, remote_evtchn);
 
 	err = xenbus_map_ring_valloc(pdev->xdev, &gnt_ref, 1, &vaddr);
@@ -142,7 +142,8 @@ static int xen_pcibk_do_attach(struct xen_pcibk_device *pdev, int gnt_ref,
 static int xen_pcibk_attach(struct xen_pcibk_device *pdev)
 {
 	int err = 0;
-	int gnt_ref, remote_evtchn;
+	int gnt_ref;
+	evtchn_port_t remote_evtchn;
 	char *magic = NULL;
 
 
diff --git a/drivers/xen/xen-scsiback.c b/drivers/xen/xen-scsiback.c
index ba0942e481bc..03d7180a8ae7 100644
--- a/drivers/xen/xen-scsiback.c
+++ b/drivers/xen/xen-scsiback.c
@@ -813,7 +813,7 @@ static irqreturn_t scsiback_irq_fn(int irq, void *dev_id)
 }
 
 static int scsiback_init_sring(struct vscsibk_info *info, grant_ref_t ring_ref,
-			evtchn_port_t evtchn)
+			evtchn_port_t port)
 {
 	void *area;
 	struct vscsiif_sring *sring;
@@ -829,7 +829,7 @@ static int scsiback_init_sring(struct vscsibk_info *info, grant_ref_t ring_ref,
 	sring = (struct vscsiif_sring *)area;
 	BACK_RING_INIT(&info->ring, sring, PAGE_SIZE);
 
-	err = bind_interdomain_evtchn_to_irq(info->domid, evtchn);
+	err = bind_interdomain_evtchn_to_irq(info->domid, port);
 	if (err < 0)
 		goto unmap_page;
 
@@ -854,18 +854,19 @@ static int scsiback_init_sring(struct vscsibk_info *info, grant_ref_t ring_ref,
 static int scsiback_map(struct vscsibk_info *info)
 {
 	struct xenbus_device *dev = info->dev;
-	unsigned int ring_ref, evtchn;
+	unsigned int ring_ref;
+	evtchn_port_t port;
 	int err;
 
 	err = xenbus_gather(XBT_NIL, dev->otherend,
 			"ring-ref", "%u", &ring_ref,
-			"event-channel", "%u", &evtchn, NULL);
+			"event-channel", "%u", &port, NULL);
 	if (err) {
 		xenbus_dev_fatal(dev, err, "reading %s ring", dev->otherend);
 		return err;
 	}
 
-	return scsiback_init_sring(info, ring_ref, evtchn);
+	return scsiback_init_sring(info, ring_ref, port);
 }
 
 /*
diff --git a/drivers/xen/xenbus/xenbus_client.c b/drivers/xen/xenbus/xenbus_client.c
index e17ca8156171..1f87514e4efc 100644
--- a/drivers/xen/xenbus/xenbus_client.c
+++ b/drivers/xen/xenbus/xenbus_client.c
@@ -391,7 +391,7 @@ EXPORT_SYMBOL_GPL(xenbus_grant_ring);
  * error, the device will switch to XenbusStateClosing, and the error will be
  * saved in the store.
  */
-int xenbus_alloc_evtchn(struct xenbus_device *dev, int *port)
+int xenbus_alloc_evtchn(struct xenbus_device *dev, evtchn_port_t *port)
 {
 	struct evtchn_alloc_unbound alloc_unbound;
 	int err;
@@ -414,7 +414,7 @@ EXPORT_SYMBOL_GPL(xenbus_alloc_evtchn);
 /**
  * Free an existing event channel. Returns 0 on success or -errno on error.
  */
-int xenbus_free_evtchn(struct xenbus_device *dev, int port)
+int xenbus_free_evtchn(struct xenbus_device *dev, evtchn_port_t port)
 {
 	struct evtchn_close close;
 	int err;
@@ -423,7 +423,7 @@ int xenbus_free_evtchn(struct xenbus_device *dev, int port)
 
 	err = HYPERVISOR_event_channel_op(EVTCHNOP_close, &close);
 	if (err)
-		xenbus_dev_error(dev, err, "freeing event channel %d", port);
+		xenbus_dev_error(dev, err, "freeing event channel %u", port);
 
 	return err;
 }
diff --git a/include/xen/events.h b/include/xen/events.h
index c0e6a0598397..5fac55ddd6d3 100644
--- a/include/xen/events.h
+++ b/include/xen/events.h
@@ -14,8 +14,8 @@
 
 unsigned xen_evtchn_nr_channels(void);
 
-int bind_evtchn_to_irq(unsigned int evtchn);
-int bind_evtchn_to_irqhandler(unsigned int evtchn,
+int bind_evtchn_to_irq(evtchn_port_t port);
+int bind_evtchn_to_irqhandler(evtchn_port_t port,
 			      irq_handler_t handler,
 			      unsigned long irqflags, const char *devname,
 			      void *dev_id);
@@ -31,9 +31,9 @@ int bind_ipi_to_irqhandler(enum ipi_vector ipi,
 			   const char *devname,
 			   void *dev_id);
 int bind_interdomain_evtchn_to_irq(unsigned int remote_domain,
-				   unsigned int remote_port);
+				   evtchn_port_t remote_port);
 int bind_interdomain_evtchn_to_irqhandler(unsigned int remote_domain,
-					  unsigned int remote_port,
+					  evtchn_port_t remote_port,
 					  irq_handler_t handler,
 					  unsigned long irqflags,
 					  const char *devname,
@@ -54,15 +54,15 @@ int xen_set_irq_priority(unsigned irq, unsigned priority);
 /*
  * Allow extra references to event channels exposed to userspace by evtchn
  */
-int evtchn_make_refcounted(unsigned int evtchn);
-int evtchn_get(unsigned int evtchn);
-void evtchn_put(unsigned int evtchn);
+int evtchn_make_refcounted(evtchn_port_t port);
+int evtchn_get(evtchn_port_t port);
+void evtchn_put(evtchn_port_t port);
 
 void xen_send_IPI_one(unsigned int cpu, enum ipi_vector vector);
-void rebind_evtchn_irq(int evtchn, int irq);
+void rebind_evtchn_irq(evtchn_port_t port, int irq);
 int xen_set_affinity_evtchn(struct irq_desc *desc, unsigned int tcpu);
 
-static inline void notify_remote_via_evtchn(int port)
+static inline void notify_remote_via_evtchn(evtchn_port_t port)
 {
 	struct evtchn_send send = { .port = port };
 	(void)HYPERVISOR_event_channel_op(EVTCHNOP_send, &send);
@@ -86,7 +86,7 @@ void xen_poll_irq(int irq);
 void xen_poll_irq_timeout(int irq, u64 timeout);
 
 /* Determine the IRQ which is bound to an event channel */
-unsigned irq_from_evtchn(unsigned int evtchn);
+unsigned int irq_from_evtchn(evtchn_port_t port);
 int irq_from_virq(unsigned int cpu, unsigned int virq);
 unsigned int evtchn_from_irq(unsigned irq);
 
diff --git a/include/xen/interface/event_channel.h b/include/xen/interface/event_channel.h
index 45650c9a06d5..cf80e338fbb0 100644
--- a/include/xen/interface/event_channel.h
+++ b/include/xen/interface/event_channel.h
@@ -220,7 +220,7 @@ struct evtchn_expand_array {
 #define EVTCHNOP_set_priority    13
 struct evtchn_set_priority {
 	/* IN parameters. */
-	uint32_t port;
+	evtchn_port_t port;
 	uint32_t priority;
 };
 
diff --git a/include/xen/xenbus.h b/include/xen/xenbus.h
index 89a889585ba0..bc7509b52fea 100644
--- a/include/xen/xenbus.h
+++ b/include/xen/xenbus.h
@@ -44,6 +44,7 @@
 #include <linux/slab.h>
 #include <xen/interface/xen.h>
 #include <xen/interface/grant_table.h>
+#include <xen/interface/event_channel.h>
 #include <xen/interface/io/xenbus.h>
 #include <xen/interface/io/xs_wire.h>
 
@@ -218,8 +219,8 @@ int xenbus_unmap_ring(struct xenbus_device *dev,
 		      grant_handle_t *handles, unsigned int nr_handles,
 		      unsigned long *vaddrs);
 
-int xenbus_alloc_evtchn(struct xenbus_device *dev, int *port);
-int xenbus_free_evtchn(struct xenbus_device *dev, int port);
+int xenbus_alloc_evtchn(struct xenbus_device *dev, evtchn_port_t *port);
+int xenbus_free_evtchn(struct xenbus_device *dev, evtchn_port_t port);
 
 enum xenbus_state xenbus_read_driver_state(const char *path);
 
-- 
2.17.1

