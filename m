Return-Path: <SRS0=iO2y=4R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E28D3C3F2CD
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Feb 2020 22:30:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90C1E2073D
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Feb 2020 22:30:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WRtP4Hmk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727714AbgB2Wan (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Feb 2020 17:30:43 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:55229 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727368AbgB2Wan (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Feb 2020 17:30:43 -0500
Received: by mail-wm1-f66.google.com with SMTP id z12so7299004wmi.4
        for <linux-kernel@vger.kernel.org>; Sat, 29 Feb 2020 14:30:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=+ZCrYsNqKRAIp1fvJ7TMjzlFEYRSD6dPJpjBXOVRGD4=;
        b=WRtP4HmkqKysL0ohaRqjr+Q0UUB0aQEIU0UjHL5KSUOpCwLkEpIdImIOkJATCt5100
         MGRYT21xHwjo1lYc/Gke6sAV9WIUucChyuJz3pIoo0AJJe8mJcTozhJPNOmhzjH4g4Eu
         U7VyQN1D2Z2n7FNOX9ss8zvr4mFkGIcO9w1OOQ66hYo2NTPhV5Gk4ojGx6959k3KF1M7
         J+Casc6vgMC6o40eOHz2oRQpMDxueezmBGUOj7AlU6elj0wea6N0RDtl1htf7z1ou+Vh
         3GBWVaAXpKRpHmOyfTbgpw4dkhadZdLsqbN8d7ftJJ5Npi+j8B7NWUD20uzDuD30KB3u
         +iog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=+ZCrYsNqKRAIp1fvJ7TMjzlFEYRSD6dPJpjBXOVRGD4=;
        b=EOCImse6xSrz8rGDAuvT9M3kDhOt4sH6U4euXJzhh57F9MpdRTgjjpxQYeDwGMTmTh
         awf6b66GVz3D+NUw/m7qvSpyhmjgaxrGVrmLpynhEYjcZOW6YylOJ6RLjf06Sw9GP4Pl
         W2Tj9GbWZrgHXDz1eWJ4p+dMTkNeAxTt6vW8D2thUr5mR75e+9Lub06J5uMecDMhNdV9
         PqCMPPnp8savA7Lt+xE0kT5g4zZUo4x+asZI8BDUtRT4cGfvYsZ3JXAoS+WWFDjWdyvj
         hnZFc1zKGYXrp7W7eIioVP0anXnlDVsaopRyGqNkjyLwJnRoli+YoSsAmjmoFhLi7vO1
         fFqg==
X-Gm-Message-State: APjAAAVqEwbsIyPgWwTDR8LIzVe3WntxxW5e1eDxPBr80Me1zTaSXYmm
        U79XhF3JRzVIplE9PSbsFFY=
X-Google-Smtp-Source: APXvYqzThlVUPzKaUPbQ1RNyVIkJIZlcYf3QgJiUtf693iU33emVJ8TPsH2ipsvXZMvotoy6GT0PmA==
X-Received: by 2002:a1c:a706:: with SMTP id q6mr10678143wme.23.1583015438403;
        Sat, 29 Feb 2020 14:30:38 -0800 (PST)
Received: from kbp1-lhp-F74019 (a81-14-236-68.net-htp.de. [81.14.236.68])
        by smtp.gmail.com with ESMTPSA id z14sm19104781wru.31.2020.02.29.14.30.36
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 29 Feb 2020 14:30:37 -0800 (PST)
Date:   Sun, 1 Mar 2020 00:30:35 +0200
From:   Yan Yankovskyi <yyankovskyi@gmail.com>
To:     Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>
Cc:     xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org
Subject: [PATCH] xen: Use 'unsigned int' instead of 'unsigned'
Message-ID: <20200229223035.GA28145@kbp1-lhp-F74019>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Resolve the following warning, reported by checkpatch.pl:
WARNING: Prefer 'unsigned int' to bare use of 'unsigned'

No functional change.

Signed-off-by: Yan Yankovskyi <yyankovskyi@gmail.com>
---
 drivers/xen/events/events_2l.c           | 18 ++---
 drivers/xen/events/events_base.c         | 92 ++++++++++++------------
 drivers/xen/events/events_fifo.c         | 52 +++++++-------
 drivers/xen/events/events_internal.h     | 46 ++++++------
 drivers/xen/evtchn.c                     |  7 +-
 drivers/xen/grant-table.c                | 12 ++--
 drivers/xen/mcelog.c                     |  6 +-
 drivers/xen/privcmd.c                    | 10 +--
 drivers/xen/xen-scsiback.c               |  8 +--
 drivers/xen/xenbus/xenbus_dev_frontend.c |  9 +--
 drivers/xen/xlate_mmu.c                  |  4 +-
 11 files changed, 133 insertions(+), 131 deletions(-)

diff --git a/drivers/xen/events/events_2l.c b/drivers/xen/events/events_2l.c
index 8edef51c92e5..38fa771fe3de 100644
--- a/drivers/xen/events/events_2l.c
+++ b/drivers/xen/events/events_2l.c
@@ -42,48 +42,48 @@
 
 static DEFINE_PER_CPU(xen_ulong_t [EVTCHN_MASK_SIZE], cpu_evtchn_mask);
 
-static unsigned evtchn_2l_max_channels(void)
+static unsigned int evtchn_2l_max_channels(void)
 {
 	return EVTCHN_2L_NR_CHANNELS;
 }
 
-static void evtchn_2l_bind_to_cpu(struct irq_info *info, unsigned cpu)
+static void evtchn_2l_bind_to_cpu(struct irq_info *info, unsigned int cpu)
 {
 	clear_bit(info->evtchn, BM(per_cpu(cpu_evtchn_mask, info->cpu)));
 	set_bit(info->evtchn, BM(per_cpu(cpu_evtchn_mask, cpu)));
 }
 
-static void evtchn_2l_clear_pending(unsigned port)
+static void evtchn_2l_clear_pending(unsigned int port)
 {
 	struct shared_info *s = HYPERVISOR_shared_info;
 	sync_clear_bit(port, BM(&s->evtchn_pending[0]));
 }
 
-static void evtchn_2l_set_pending(unsigned port)
+static void evtchn_2l_set_pending(unsigned int port)
 {
 	struct shared_info *s = HYPERVISOR_shared_info;
 	sync_set_bit(port, BM(&s->evtchn_pending[0]));
 }
 
-static bool evtchn_2l_is_pending(unsigned port)
+static bool evtchn_2l_is_pending(unsigned int port)
 {
 	struct shared_info *s = HYPERVISOR_shared_info;
 	return sync_test_bit(port, BM(&s->evtchn_pending[0]));
 }
 
-static bool evtchn_2l_test_and_set_mask(unsigned port)
+static bool evtchn_2l_test_and_set_mask(unsigned int port)
 {
 	struct shared_info *s = HYPERVISOR_shared_info;
 	return sync_test_and_set_bit(port, BM(&s->evtchn_mask[0]));
 }
 
-static void evtchn_2l_mask(unsigned port)
+static void evtchn_2l_mask(unsigned int port)
 {
 	struct shared_info *s = HYPERVISOR_shared_info;
 	sync_set_bit(port, BM(&s->evtchn_mask[0]));
 }
 
-static void evtchn_2l_unmask(unsigned port)
+static void evtchn_2l_unmask(unsigned int port)
 {
 	struct shared_info *s = HYPERVISOR_shared_info;
 	unsigned int cpu = get_cpu();
@@ -159,7 +159,7 @@ static inline xen_ulong_t active_evtchns(unsigned int cpu,
  * a bitset of words which contain pending event bits.  The second
  * level is a bitset of pending events themselves.
  */
-static void evtchn_2l_handle_events(unsigned cpu)
+static void evtchn_2l_handle_events(unsigned int cpu)
 {
 	int irq;
 	xen_ulong_t pending_words;
diff --git a/drivers/xen/events/events_base.c b/drivers/xen/events/events_base.c
index 499eff7d3f65..6388d07161ea 100644
--- a/drivers/xen/events/events_base.c
+++ b/drivers/xen/events/events_base.c
@@ -82,7 +82,7 @@ int **evtchn_to_irq;
 #ifdef CONFIG_X86
 static unsigned long *pirq_eoi_map;
 #endif
-static bool (*pirq_needs_eoi)(unsigned irq);
+static bool (*pirq_needs_eoi)(unsigned int irq);
 
 #define EVTCHN_ROW(e)  (e / (PAGE_SIZE/sizeof(**evtchn_to_irq)))
 #define EVTCHN_COL(e)  (e % (PAGE_SIZE/sizeof(**evtchn_to_irq)))
@@ -97,9 +97,9 @@ static struct irq_chip xen_pirq_chip;
 static void enable_dynirq(struct irq_data *data);
 static void disable_dynirq(struct irq_data *data);
 
-static void clear_evtchn_to_irq_row(unsigned row)
+static void clear_evtchn_to_irq_row(unsigned int row)
 {
-	unsigned col;
+	unsigned int col;
 
 	for (col = 0; col < EVTCHN_PER_ROW; col++)
 		evtchn_to_irq[row][col] = -1;
@@ -107,7 +107,7 @@ static void clear_evtchn_to_irq_row(unsigned row)
 
 static void clear_evtchn_to_irq_all(void)
 {
-	unsigned row;
+	unsigned int row;
 
 	for (row = 0; row < EVTCHN_ROW(xen_evtchn_max_channels()); row++) {
 		if (evtchn_to_irq[row] == NULL)
@@ -116,10 +116,10 @@ static void clear_evtchn_to_irq_all(void)
 	}
 }
 
-static int set_evtchn_to_irq(unsigned evtchn, unsigned irq)
+static int set_evtchn_to_irq(unsigned int evtchn, unsigned int irq)
 {
-	unsigned row;
-	unsigned col;
+	unsigned int row;
+	unsigned int col;
 
 	if (evtchn >= xen_evtchn_max_channels())
 		return -EINVAL;
@@ -143,7 +143,7 @@ static int set_evtchn_to_irq(unsigned evtchn, unsigned irq)
 	return 0;
 }
 
-int get_evtchn_to_irq(unsigned evtchn)
+int get_evtchn_to_irq(unsigned int evtchn)
 {
 	if (evtchn >= xen_evtchn_max_channels())
 		return -1;
@@ -153,16 +153,16 @@ int get_evtchn_to_irq(unsigned evtchn)
 }
 
 /* Get info for IRQ */
-struct irq_info *info_for_irq(unsigned irq)
+struct irq_info *info_for_irq(unsigned int irq)
 {
 	return irq_get_handler_data(irq);
 }
 
 /* Constructors for packed IRQ information. */
 static int xen_irq_info_common_setup(struct irq_info *info,
-				     unsigned irq,
+				     unsigned int irq,
 				     enum xen_irq_type type,
-				     unsigned evtchn,
+				     unsigned int evtchn,
 				     unsigned short cpu)
 {
 	int ret;
@@ -183,17 +183,17 @@ static int xen_irq_info_common_setup(struct irq_info *info,
 	return xen_evtchn_port_setup(info);
 }
 
-static int xen_irq_info_evtchn_setup(unsigned irq,
-				     unsigned evtchn)
+static int xen_irq_info_evtchn_setup(unsigned int irq,
+				     unsigned int evtchn)
 {
 	struct irq_info *info = info_for_irq(irq);
 
 	return xen_irq_info_common_setup(info, irq, IRQT_EVTCHN, evtchn, 0);
 }
 
-static int xen_irq_info_ipi_setup(unsigned cpu,
-				  unsigned irq,
-				  unsigned evtchn,
+static int xen_irq_info_ipi_setup(unsigned int cpu,
+				  unsigned int irq,
+				  unsigned int evtchn,
 				  enum ipi_vector ipi)
 {
 	struct irq_info *info = info_for_irq(irq);
@@ -205,10 +205,10 @@ static int xen_irq_info_ipi_setup(unsigned cpu,
 	return xen_irq_info_common_setup(info, irq, IRQT_IPI, evtchn, 0);
 }
 
-static int xen_irq_info_virq_setup(unsigned cpu,
-				   unsigned irq,
-				   unsigned evtchn,
-				   unsigned virq)
+static int xen_irq_info_virq_setup(unsigned int cpu,
+				   unsigned int irq,
+				   unsigned int evtchn,
+				   unsigned int virq)
 {
 	struct irq_info *info = info_for_irq(irq);
 
@@ -219,10 +219,10 @@ static int xen_irq_info_virq_setup(unsigned cpu,
 	return xen_irq_info_common_setup(info, irq, IRQT_VIRQ, evtchn, 0);
 }
 
-static int xen_irq_info_pirq_setup(unsigned irq,
-				   unsigned evtchn,
-				   unsigned pirq,
-				   unsigned gsi,
+static int xen_irq_info_pirq_setup(unsigned int irq,
+				   unsigned int evtchn,
+				   unsigned int pirq,
+				   unsigned int gsi,
 				   uint16_t domid,
 				   unsigned char flags)
 {
@@ -245,7 +245,7 @@ static void xen_irq_info_cleanup(struct irq_info *info)
 /*
  * Accessors for packed IRQ information.
  */
-unsigned int evtchn_from_irq(unsigned irq)
+unsigned int evtchn_from_irq(unsigned int irq)
 {
 	if (WARN(irq >= nr_irqs, "Invalid irq %d!\n", irq))
 		return 0;
@@ -253,7 +253,7 @@ unsigned int evtchn_from_irq(unsigned irq)
 	return info_for_irq(irq)->evtchn;
 }
 
-unsigned irq_from_evtchn(unsigned int evtchn)
+unsigned int irq_from_evtchn(unsigned int evtchn)
 {
 	return get_evtchn_to_irq(evtchn);
 }
@@ -264,7 +264,7 @@ int irq_from_virq(unsigned int cpu, unsigned int virq)
 	return per_cpu(virq_to_irq, cpu)[virq];
 }
 
-static enum ipi_vector ipi_from_irq(unsigned irq)
+static enum ipi_vector ipi_from_irq(unsigned int irq)
 {
 	struct irq_info *info = info_for_irq(irq);
 
@@ -274,7 +274,7 @@ static enum ipi_vector ipi_from_irq(unsigned irq)
 	return info->u.ipi;
 }
 
-static unsigned virq_from_irq(unsigned irq)
+static unsigned int virq_from_irq(unsigned int irq)
 {
 	struct irq_info *info = info_for_irq(irq);
 
@@ -284,7 +284,7 @@ static unsigned virq_from_irq(unsigned irq)
 	return info->u.virq;
 }
 
-static unsigned pirq_from_irq(unsigned irq)
+static unsigned int pirq_from_irq(unsigned int irq)
 {
 	struct irq_info *info = info_for_irq(irq);
 
@@ -294,12 +294,12 @@ static unsigned pirq_from_irq(unsigned irq)
 	return info->u.pirq.pirq;
 }
 
-static enum xen_irq_type type_from_irq(unsigned irq)
+static enum xen_irq_type type_from_irq(unsigned int irq)
 {
 	return info_for_irq(irq)->type;
 }
 
-unsigned cpu_from_irq(unsigned irq)
+unsigned int cpu_from_irq(unsigned int irq)
 {
 	return info_for_irq(irq)->cpu;
 }
@@ -307,7 +307,7 @@ unsigned cpu_from_irq(unsigned irq)
 unsigned int cpu_from_evtchn(unsigned int evtchn)
 {
 	int irq = get_evtchn_to_irq(evtchn);
-	unsigned ret = 0;
+	unsigned int ret = 0;
 
 	if (irq != -1)
 		ret = cpu_from_irq(irq);
@@ -316,13 +316,13 @@ unsigned int cpu_from_evtchn(unsigned int evtchn)
 }
 
 #ifdef CONFIG_X86
-static bool pirq_check_eoi_map(unsigned irq)
+static bool pirq_check_eoi_map(unsigned int irq)
 {
 	return test_bit(pirq_from_irq(irq), pirq_eoi_map);
 }
 #endif
 
-static bool pirq_needs_eoi_flag(unsigned irq)
+static bool pirq_needs_eoi_flag(unsigned int irq)
 {
 	struct irq_info *info = info_for_irq(irq);
 	BUG_ON(info->type != IRQT_PIRQ);
@@ -361,7 +361,7 @@ void notify_remote_via_irq(int irq)
 }
 EXPORT_SYMBOL_GPL(notify_remote_via_irq);
 
-static void xen_irq_init(unsigned irq)
+static void xen_irq_init(unsigned int irq)
 {
 	struct irq_info *info;
 #ifdef CONFIG_SMP
@@ -399,7 +399,7 @@ static inline int __must_check xen_allocate_irq_dynamic(void)
 	return xen_allocate_irqs_dynamic(1);
 }
 
-static int __must_check xen_allocate_irq_gsi(unsigned gsi)
+static int __must_check xen_allocate_irq_gsi(unsigned int gsi)
 {
 	int irq;
 
@@ -423,7 +423,7 @@ static int __must_check xen_allocate_irq_gsi(unsigned gsi)
 	return irq;
 }
 
-static void xen_free_irq(unsigned irq)
+static void xen_free_irq(unsigned int irq)
 {
 	struct irq_info *info = irq_get_handler_data(irq);
 
@@ -561,7 +561,7 @@ static void shutdown_pirq(struct irq_data *data)
 {
 	unsigned int irq = data->irq;
 	struct irq_info *info = info_for_irq(irq);
-	unsigned evtchn = evtchn_from_irq(irq);
+	unsigned int evtchn = evtchn_from_irq(irq);
 
 	BUG_ON(info->type != IRQT_PIRQ);
 
@@ -583,7 +583,7 @@ static void disable_pirq(struct irq_data *data)
 	disable_dynirq(data);
 }
 
-int xen_irq_from_gsi(unsigned gsi)
+int xen_irq_from_gsi(unsigned int gsi)
 {
 	struct irq_info *info;
 
@@ -642,8 +642,8 @@ static void __unbind_from_irq(unsigned int irq)
  * Shareable implies level triggered, not shareable implies edge
  * triggered here.
  */
-int xen_bind_pirq_gsi_to_irq(unsigned gsi,
-			     unsigned pirq, int shareable, char *name)
+int xen_bind_pirq_gsi_to_irq(unsigned int gsi,
+			     unsigned int pirq, int shareable, char *name)
 {
 	int irq = -1;
 	struct physdev_irq irq_op;
@@ -798,7 +798,7 @@ int xen_destroy_irq(int irq)
 	return rc;
 }
 
-int xen_irq_from_pirq(unsigned pirq)
+int xen_irq_from_pirq(unsigned int pirq)
 {
 	int irq;
 
@@ -821,7 +821,7 @@ int xen_irq_from_pirq(unsigned pirq)
 }
 
 
-int xen_pirq_from_irq(unsigned irq)
+int xen_pirq_from_irq(unsigned int irq)
 {
 	return pirq_from_irq(irq);
 }
@@ -953,7 +953,7 @@ static int find_virq(unsigned int virq, unsigned int cpu)
  * hypervisor ABI. Use xen_evtchn_max_channels() for the maximum
  * supported.
  */
-unsigned xen_evtchn_nr_channels(void)
+unsigned int xen_evtchn_nr_channels(void)
 {
         return evtchn_ops->nr_channels();
 }
@@ -1120,7 +1120,7 @@ EXPORT_SYMBOL_GPL(unbind_from_irqhandler);
  * @irq:irq bound to an event channel.
  * @priority: priority between XEN_IRQ_PRIORITY_MAX and XEN_IRQ_PRIORITY_MIN.
  */
-int xen_set_irq_priority(unsigned irq, unsigned priority)
+int xen_set_irq_priority(unsigned int irq, unsigned int priority)
 {
 	struct evtchn_set_priority set_priority;
 
@@ -1322,7 +1322,7 @@ static int xen_rebind_evtchn_to_cpu(int evtchn, unsigned int tcpu)
 static int set_affinity_irq(struct irq_data *data, const struct cpumask *dest,
 			    bool force)
 {
-	unsigned tcpu = cpumask_first_and(dest, cpu_online_mask);
+	unsigned int tcpu = cpumask_first_and(dest, cpu_online_mask);
 	int ret = xen_rebind_evtchn_to_cpu(evtchn_from_irq(data->irq), tcpu);
 
 	if (!ret)
diff --git a/drivers/xen/events/events_fifo.c b/drivers/xen/events/events_fifo.c
index 76b318e88382..e724f662acd3 100644
--- a/drivers/xen/events/events_fifo.c
+++ b/drivers/xen/events/events_fifo.c
@@ -64,7 +64,7 @@ struct evtchn_fifo_queue {
 static DEFINE_PER_CPU(struct evtchn_fifo_control_block *, cpu_control_block);
 static DEFINE_PER_CPU(struct evtchn_fifo_queue, cpu_queue);
 static event_word_t *event_array[MAX_EVENT_ARRAY_PAGES] __read_mostly;
-static unsigned event_array_pages __read_mostly;
+static unsigned int event_array_pages __read_mostly;
 
 /*
  * sync_set_bit() and friends must be unsigned long aligned.
@@ -82,19 +82,19 @@ static unsigned event_array_pages __read_mostly;
 
 #endif
 
-static inline event_word_t *event_word_from_port(unsigned port)
+static inline event_word_t *event_word_from_port(unsigned int port)
 {
-	unsigned i = port / EVENT_WORDS_PER_PAGE;
+	unsigned int i = port / EVENT_WORDS_PER_PAGE;
 
 	return event_array[i] + port % EVENT_WORDS_PER_PAGE;
 }
 
-static unsigned evtchn_fifo_max_channels(void)
+static unsigned int evtchn_fifo_max_channels(void)
 {
 	return EVTCHN_FIFO_NR_CHANNELS;
 }
 
-static unsigned evtchn_fifo_nr_channels(void)
+static unsigned int evtchn_fifo_nr_channels(void)
 {
 	return event_array_pages * EVENT_WORDS_PER_PAGE;
 }
@@ -120,7 +120,7 @@ static int init_control_block(int cpu,
 
 static void free_unused_array_pages(void)
 {
-	unsigned i;
+	unsigned int i;
 
 	for (i = event_array_pages; i < MAX_EVENT_ARRAY_PAGES; i++) {
 		if (!event_array[i])
@@ -132,7 +132,7 @@ static void free_unused_array_pages(void)
 
 static void init_array_page(event_word_t *array_page)
 {
-	unsigned i;
+	unsigned int i;
 
 	for (i = 0; i < EVENT_WORDS_PER_PAGE; i++)
 		array_page[i] = 1 << EVTCHN_FIFO_MASKED;
@@ -140,8 +140,8 @@ static void init_array_page(event_word_t *array_page)
 
 static int evtchn_fifo_setup(struct irq_info *info)
 {
-	unsigned port = info->evtchn;
-	unsigned new_array_pages;
+	unsigned int port = info->evtchn;
+	unsigned int new_array_pages;
 	int ret;
 
 	new_array_pages = port / EVENT_WORDS_PER_PAGE + 1;
@@ -186,42 +186,42 @@ static int evtchn_fifo_setup(struct irq_info *info)
 	return ret;
 }
 
-static void evtchn_fifo_bind_to_cpu(struct irq_info *info, unsigned cpu)
+static void evtchn_fifo_bind_to_cpu(struct irq_info *info, unsigned int cpu)
 {
 	/* no-op */
 }
 
-static void evtchn_fifo_clear_pending(unsigned port)
+static void evtchn_fifo_clear_pending(unsigned int port)
 {
 	event_word_t *word = event_word_from_port(port);
 	sync_clear_bit(EVTCHN_FIFO_BIT(PENDING, word), BM(word));
 }
 
-static void evtchn_fifo_set_pending(unsigned port)
+static void evtchn_fifo_set_pending(unsigned int port)
 {
 	event_word_t *word = event_word_from_port(port);
 	sync_set_bit(EVTCHN_FIFO_BIT(PENDING, word), BM(word));
 }
 
-static bool evtchn_fifo_is_pending(unsigned port)
+static bool evtchn_fifo_is_pending(unsigned int port)
 {
 	event_word_t *word = event_word_from_port(port);
 	return sync_test_bit(EVTCHN_FIFO_BIT(PENDING, word), BM(word));
 }
 
-static bool evtchn_fifo_test_and_set_mask(unsigned port)
+static bool evtchn_fifo_test_and_set_mask(unsigned int port)
 {
 	event_word_t *word = event_word_from_port(port);
 	return sync_test_and_set_bit(EVTCHN_FIFO_BIT(MASKED, word), BM(word));
 }
 
-static void evtchn_fifo_mask(unsigned port)
+static void evtchn_fifo_mask(unsigned int port)
 {
 	event_word_t *word = event_word_from_port(port);
 	sync_set_bit(EVTCHN_FIFO_BIT(MASKED, word), BM(word));
 }
 
-static bool evtchn_fifo_is_masked(unsigned port)
+static bool evtchn_fifo_is_masked(unsigned int port)
 {
 	event_word_t *word = event_word_from_port(port);
 	return sync_test_bit(EVTCHN_FIFO_BIT(MASKED, word), BM(word));
@@ -242,7 +242,7 @@ static void clear_masked(volatile event_word_t *word)
 	} while (w != old);
 }
 
-static void evtchn_fifo_unmask(unsigned port)
+static void evtchn_fifo_unmask(unsigned int port)
 {
 	event_word_t *word = event_word_from_port(port);
 
@@ -270,7 +270,7 @@ static uint32_t clear_linked(volatile event_word_t *word)
 	return w & EVTCHN_FIFO_LINK_MASK;
 }
 
-static void handle_irq_for_port(unsigned port)
+static void handle_irq_for_port(unsigned int port)
 {
 	int irq;
 
@@ -279,14 +279,14 @@ static void handle_irq_for_port(unsigned port)
 		generic_handle_irq(irq);
 }
 
-static void consume_one_event(unsigned cpu,
+static void consume_one_event(unsigned int cpu,
 			      struct evtchn_fifo_control_block *control_block,
-			      unsigned priority, unsigned long *ready,
+			      unsigned int priority, unsigned long *ready,
 			      bool drop)
 {
 	struct evtchn_fifo_queue *q = &per_cpu(cpu_queue, cpu);
 	uint32_t head;
-	unsigned port;
+	unsigned int port;
 	event_word_t *word;
 
 	head = q->head[priority];
@@ -324,11 +324,11 @@ static void consume_one_event(unsigned cpu,
 	q->head[priority] = head;
 }
 
-static void __evtchn_fifo_handle_events(unsigned cpu, bool drop)
+static void __evtchn_fifo_handle_events(unsigned int cpu, bool drop)
 {
 	struct evtchn_fifo_control_block *control_block;
 	unsigned long ready;
-	unsigned q;
+	unsigned int q;
 
 	control_block = per_cpu(cpu_control_block, cpu);
 
@@ -341,14 +341,14 @@ static void __evtchn_fifo_handle_events(unsigned cpu, bool drop)
 	}
 }
 
-static void evtchn_fifo_handle_events(unsigned cpu)
+static void evtchn_fifo_handle_events(unsigned int cpu)
 {
 	__evtchn_fifo_handle_events(cpu, false);
 }
 
 static void evtchn_fifo_resume(void)
 {
-	unsigned cpu;
+	unsigned int cpu;
 
 	for_each_possible_cpu(cpu) {
 		void *control_block = per_cpu(cpu_control_block, cpu);
@@ -395,7 +395,7 @@ static const struct evtchn_ops evtchn_ops_fifo = {
 	.resume            = evtchn_fifo_resume,
 };
 
-static int evtchn_fifo_alloc_control_block(unsigned cpu)
+static int evtchn_fifo_alloc_control_block(unsigned int cpu)
 {
 	void *control_block = NULL;
 	int ret = -ENOMEM;
diff --git a/drivers/xen/events/events_internal.h b/drivers/xen/events/events_internal.h
index 82938cff6c7a..b2ae517a171e 100644
--- a/drivers/xen/events/events_internal.h
+++ b/drivers/xen/events/events_internal.h
@@ -32,7 +32,7 @@ struct irq_info {
 	struct list_head list;
 	int refcnt;
 	enum xen_irq_type type;	/* type */
-	unsigned irq;
+	unsigned int irq;
 	unsigned int evtchn;	/* event channel */
 	unsigned short cpu;	/* cpu bound */
 
@@ -54,20 +54,20 @@ struct irq_info {
 #define PIRQ_MSI_GROUP	(1 << 2)
 
 struct evtchn_ops {
-	unsigned (*max_channels)(void);
-	unsigned (*nr_channels)(void);
+	unsigned int (*max_channels)(void);
+	unsigned int (*nr_channels)(void);
 
 	int (*setup)(struct irq_info *info);
-	void (*bind_to_cpu)(struct irq_info *info, unsigned cpu);
+	void (*bind_to_cpu)(struct irq_info *info, unsigned int cpu);
 
-	void (*clear_pending)(unsigned port);
-	void (*set_pending)(unsigned port);
-	bool (*is_pending)(unsigned port);
-	bool (*test_and_set_mask)(unsigned port);
-	void (*mask)(unsigned port);
-	void (*unmask)(unsigned port);
+	void (*clear_pending)(unsigned int port);
+	void (*set_pending)(unsigned int port);
+	bool (*is_pending)(unsigned int port);
+	bool (*test_and_set_mask)(unsigned int port);
+	void (*mask)(unsigned int port);
+	void (*unmask)(unsigned int port);
 
-	void (*handle_events)(unsigned cpu);
+	void (*handle_events)(unsigned int cpu);
 	void (*resume)(void);
 };
 
@@ -76,11 +76,11 @@ extern const struct evtchn_ops *evtchn_ops;
 extern int **evtchn_to_irq;
 int get_evtchn_to_irq(unsigned int evtchn);
 
-struct irq_info *info_for_irq(unsigned irq);
-unsigned cpu_from_irq(unsigned irq);
-unsigned cpu_from_evtchn(unsigned int evtchn);
+struct irq_info *info_for_irq(unsigned int irq);
+unsigned int cpu_from_irq(unsigned int irq);
+unsigned int cpu_from_evtchn(unsigned int evtchn);
 
-static inline unsigned xen_evtchn_max_channels(void)
+static inline unsigned int xen_evtchn_max_channels(void)
 {
 	return evtchn_ops->max_channels();
 }
@@ -97,42 +97,42 @@ static inline int xen_evtchn_port_setup(struct irq_info *info)
 }
 
 static inline void xen_evtchn_port_bind_to_cpu(struct irq_info *info,
-					       unsigned cpu)
+					       unsigned int cpu)
 {
 	evtchn_ops->bind_to_cpu(info, cpu);
 }
 
-static inline void clear_evtchn(unsigned port)
+static inline void clear_evtchn(unsigned int port)
 {
 	evtchn_ops->clear_pending(port);
 }
 
-static inline void set_evtchn(unsigned port)
+static inline void set_evtchn(unsigned int port)
 {
 	evtchn_ops->set_pending(port);
 }
 
-static inline bool test_evtchn(unsigned port)
+static inline bool test_evtchn(unsigned int port)
 {
 	return evtchn_ops->is_pending(port);
 }
 
-static inline bool test_and_set_mask(unsigned port)
+static inline bool test_and_set_mask(unsigned int port)
 {
 	return evtchn_ops->test_and_set_mask(port);
 }
 
-static inline void mask_evtchn(unsigned port)
+static inline void mask_evtchn(unsigned int port)
 {
 	return evtchn_ops->mask(port);
 }
 
-static inline void unmask_evtchn(unsigned port)
+static inline void unmask_evtchn(unsigned int port)
 {
 	return evtchn_ops->unmask(port);
 }
 
-static inline void xen_evtchn_handle_events(unsigned cpu)
+static inline void xen_evtchn_handle_events(unsigned int cpu)
 {
 	return evtchn_ops->handle_events(cpu);
 }
diff --git a/drivers/xen/evtchn.c b/drivers/xen/evtchn.c
index 052b55a14ebc..4cd7a36031ea 100644
--- a/drivers/xen/evtchn.c
+++ b/drivers/xen/evtchn.c
@@ -83,7 +83,7 @@ struct per_user_data {
 struct user_evtchn {
 	struct rb_node node;
 	struct per_user_data *user;
-	unsigned port;
+	unsigned int port;
 	bool enabled;
 };
 
@@ -138,7 +138,8 @@ static void del_evtchn(struct per_user_data *u, struct user_evtchn *evtchn)
 	kfree(evtchn);
 }
 
-static struct user_evtchn *find_evtchn(struct per_user_data *u, unsigned port)
+static struct user_evtchn *find_evtchn(struct per_user_data *u,
+				       unsigned int port)
 {
 	struct rb_node *node = u->evtchns.rb_node;
 
@@ -286,7 +287,7 @@ static ssize_t evtchn_write(struct file *file, const char __user *buf,
 	mutex_lock(&u->bind_mutex);
 
 	for (i = 0; i < (count/sizeof(evtchn_port_t)); i++) {
-		unsigned port = kbuf[i];
+		unsigned int port = kbuf[i];
 		struct user_evtchn *evtchn;
 
 		evtchn = find_evtchn(u, port);
diff --git a/drivers/xen/grant-table.c b/drivers/xen/grant-table.c
index 7b36b51cdb9f..7d9e8d90e139 100644
--- a/drivers/xen/grant-table.c
+++ b/drivers/xen/grant-table.c
@@ -116,7 +116,7 @@ struct gnttab_ops {
 	 * status of the grant entry to be updated.
 	 */
 	void (*update_entry)(grant_ref_t ref, domid_t domid,
-			     unsigned long frame, unsigned flags);
+			     unsigned long frame, unsigned int flags);
 	/*
 	 * Stop granting a grant entry to domain for accessing. Ref parameter is
 	 * reference of a grant entry whose grant access will be stopped,
@@ -167,7 +167,7 @@ static inline grant_ref_t *__gnttab_entry(grant_ref_t entry)
 /* This can be used as an l-value */
 #define gnttab_entry(entry) (*__gnttab_entry(entry))
 
-static int get_free_entries(unsigned count)
+static int get_free_entries(unsigned int count)
 {
 	unsigned long flags;
 	int ref, rc = 0;
@@ -242,7 +242,7 @@ static void put_free_entry(grant_ref_t ref)
  *  4. Write ent->flags, inc. valid type.
  */
 static void gnttab_update_entry_v1(grant_ref_t ref, domid_t domid,
-				   unsigned long frame, unsigned flags)
+				   unsigned long frame, unsigned int flags)
 {
 	gnttab_shared.v1[ref].domid = domid;
 	gnttab_shared.v1[ref].frame = frame;
@@ -940,7 +940,7 @@ static inline void
 gnttab_retry_eagain_gop(unsigned int cmd, void *gop, int16_t *status,
 						const char *func)
 {
-	unsigned delay = 1;
+	unsigned int delay = 1;
 
 	do {
 		BUG_ON(HYPERVISOR_grant_table_op(cmd, gop, 1));
@@ -954,7 +954,7 @@ gnttab_retry_eagain_gop(unsigned int cmd, void *gop, int16_t *status,
 	}
 }
 
-void gnttab_batch_map(struct gnttab_map_grant_ref *batch, unsigned count)
+void gnttab_batch_map(struct gnttab_map_grant_ref *batch, unsigned int count)
 {
 	struct gnttab_map_grant_ref *op;
 
@@ -967,7 +967,7 @@ void gnttab_batch_map(struct gnttab_map_grant_ref *batch, unsigned count)
 }
 EXPORT_SYMBOL_GPL(gnttab_batch_map);
 
-void gnttab_batch_copy(struct gnttab_copy *batch, unsigned count)
+void gnttab_batch_copy(struct gnttab_copy *batch, unsigned int count)
 {
 	struct gnttab_copy *op;
 
diff --git a/drivers/xen/mcelog.c b/drivers/xen/mcelog.c
index e9ac3b8c4167..c0b3507054c7 100644
--- a/drivers/xen/mcelog.c
+++ b/drivers/xen/mcelog.c
@@ -107,7 +107,7 @@ static ssize_t xen_mce_chrdev_read(struct file *filp, char __user *ubuf,
 				size_t usize, loff_t *off)
 {
 	char __user *buf = ubuf;
-	unsigned num;
+	unsigned int num;
 	int i, err;
 
 	mutex_lock(&mcelog_lock);
@@ -163,7 +163,7 @@ static long xen_mce_chrdev_ioctl(struct file *f, unsigned int cmd,
 	case MCE_GET_LOG_LEN:
 		return put_user(XEN_MCE_LOG_LEN, p);
 	case MCE_GETCLEAR_FLAGS: {
-		unsigned flags;
+		unsigned int flags;
 
 		do {
 			flags = xen_mcelog.flags;
@@ -196,7 +196,7 @@ static struct miscdevice xen_mce_chrdev_device = {
  */
 static void xen_mce_log(struct xen_mce *mce)
 {
-	unsigned entry;
+	unsigned int entry;
 
 	entry = xen_mcelog.next;
 
diff --git a/drivers/xen/privcmd.c b/drivers/xen/privcmd.c
index c6070e70dd73..52447ab70e6b 100644
--- a/drivers/xen/privcmd.c
+++ b/drivers/xen/privcmd.c
@@ -107,10 +107,10 @@ static void free_page_list(struct list_head *pages)
  * error code; its up to the caller to dispose of any partial list.
  */
 static int gather_array(struct list_head *pagelist,
-			unsigned nelem, size_t size,
+			unsigned int nelem, size_t size,
 			const void __user *data)
 {
-	unsigned pageidx;
+	unsigned int pageidx;
 	void *pagedata;
 	int ret;
 
@@ -151,13 +151,13 @@ static int gather_array(struct list_head *pagelist,
  * Call function "fn" on each element of the array fragmented
  * over a list of pages.
  */
-static int traverse_pages(unsigned nelem, size_t size,
+static int traverse_pages(unsigned int nelem, size_t size,
 			  struct list_head *pos,
 			  int (*fn)(void *data, void *state),
 			  void *state)
 {
 	void *pagedata;
-	unsigned pageidx;
+	unsigned int pageidx;
 	int ret = 0;
 
 	BUG_ON(size > PAGE_SIZE);
@@ -187,7 +187,7 @@ static int traverse_pages(unsigned nelem, size_t size,
  * Similar to traverse_pages, but use each page as a "block" of
  * data to be processed as one unit.
  */
-static int traverse_pages_block(unsigned nelem, size_t size,
+static int traverse_pages_block(unsigned int nelem, size_t size,
 				struct list_head *pos,
 				int (*fn)(void *data, int nr, void *state),
 				void *state)
diff --git a/drivers/xen/xen-scsiback.c b/drivers/xen/xen-scsiback.c
index ba0942e481bc..45c341063ba5 100644
--- a/drivers/xen/xen-scsiback.c
+++ b/drivers/xen/xen-scsiback.c
@@ -327,7 +327,7 @@ static void scsiback_send_response(struct vscsibk_info *info,
 	int notify;
 	struct scsi_sense_hdr sshdr;
 	unsigned long flags;
-	unsigned len;
+	unsigned int len;
 
 	spin_lock_irqsave(&info->ring_lock, flags);
 
@@ -340,7 +340,7 @@ static void scsiback_send_response(struct vscsibk_info *info,
 	if (sense_buffer != NULL &&
 	    scsi_normalize_sense(sense_buffer, VSCSIIF_SENSE_BUFFERSIZE,
 				 &sshdr)) {
-		len = min_t(unsigned, 8 + sense_buffer[7],
+		len = min_t(unsigned int, 8 + sense_buffer[7],
 			    VSCSIIF_SENSE_BUFFERSIZE);
 		memcpy(ring_res->sense_buffer, sense_buffer, len);
 		ring_res->sense_len = len;
@@ -507,8 +507,8 @@ static int scsiback_gnttab_data_map(struct vscsiif_request *ring_req,
 		for (i = 0; i < nr_sgl; i++) {
 			n_segs = ring_req->seg[i].length /
 				 sizeof(struct scsiif_request_segment);
-			if ((unsigned)ring_req->seg[i].offset +
-			    (unsigned)ring_req->seg[i].length > PAGE_SIZE ||
+			if ((unsigned int)ring_req->seg[i].offset +
+			    (unsigned int)ring_req->seg[i].length > PAGE_SIZE ||
 			    n_segs * sizeof(struct scsiif_request_segment) !=
 			    ring_req->seg[i].length)
 				return -EINVAL;
diff --git a/drivers/xen/xenbus/xenbus_dev_frontend.c b/drivers/xen/xenbus/xenbus_dev_frontend.c
index 597af455a522..30402f02a90d 100644
--- a/drivers/xen/xenbus/xenbus_dev_frontend.c
+++ b/drivers/xen/xenbus/xenbus_dev_frontend.c
@@ -128,7 +128,7 @@ static ssize_t xenbus_file_read(struct file *filp,
 {
 	struct xenbus_file_priv *u = filp->private_data;
 	struct read_buffer *rb;
-	unsigned i;
+	unsigned int i;
 	int ret;
 
 	mutex_lock(&u->reply_mutex);
@@ -148,7 +148,8 @@ static ssize_t xenbus_file_read(struct file *filp,
 	rb = list_entry(u->read_buffers.next, struct read_buffer, list);
 	i = 0;
 	while (i < len) {
-		unsigned sz = min((unsigned)len - i, rb->len - rb->cons);
+		unsigned int sz = min((unsigned int)len - i,
+				      rb->len - rb->cons);
 
 		ret = copy_to_user(ubuf + i, &rb->msg[rb->cons], sz);
 
@@ -443,7 +444,7 @@ static int xenbus_command_reply(struct xenbus_file_priv *u,
 	return rc;
 }
 
-static int xenbus_write_transaction(unsigned msg_type,
+static int xenbus_write_transaction(unsigned int msg_type,
 				    struct xenbus_file_priv *u)
 {
 	int rc;
@@ -493,7 +494,7 @@ static int xenbus_write_transaction(unsigned msg_type,
 	return rc;
 }
 
-static int xenbus_write_watch(unsigned msg_type, struct xenbus_file_priv *u)
+static int xenbus_write_watch(unsigned int msg_type, struct xenbus_file_priv *u)
 {
 	struct watch_adapter *watch;
 	char *path, *token;
diff --git a/drivers/xen/xlate_mmu.c b/drivers/xen/xlate_mmu.c
index 7b1077f0abcb..e6b5cd4e26aa 100644
--- a/drivers/xen/xlate_mmu.c
+++ b/drivers/xen/xlate_mmu.c
@@ -45,7 +45,7 @@
 typedef void (*xen_gfn_fn_t)(unsigned long gfn, void *data);
 
 /* Break down the pages in 4KB chunk and call fn for each gfn */
-static void xen_for_each_gfn(struct page **pages, unsigned nr_gfn,
+static void xen_for_each_gfn(struct page **pages, unsigned int nr_gfn,
 			     xen_gfn_fn_t fn, void *data)
 {
 	unsigned long xen_pfn = 0;
@@ -144,7 +144,7 @@ int xen_xlate_remap_gfn_array(struct vm_area_struct *vma,
 			      unsigned long addr,
 			      xen_pfn_t *gfn, int nr,
 			      int *err_ptr, pgprot_t prot,
-			      unsigned domid,
+			      unsigned int domid,
 			      struct page **pages)
 {
 	int err;
-- 
2.17.1

