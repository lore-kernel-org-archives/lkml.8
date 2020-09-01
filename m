Return-Path: <SRS0=b2Mh=CK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6B8CC433E6
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 15:29:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C43D62100A
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 15:29:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598974178;
	bh=VTehNHRiBgXL+UiN+N+yG0HswAI6mV0x1exACyyb66g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=NS7mINUoG1mIlFe4cWNuy8QGJWpqCf7brTK+tLbxv6tLIckmCEgSj9pTOKTz2l6pD
	 v4INS2NKFGcXrZuNTUvpElBGxvGpHwkDTWNjusOQB7GUGI3hQh4yB1g0QEgFlr9j3s
	 r8kWSyW+eh6jgdTxWTM5OIjHZfawCVLVrzYkzJh8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730544AbgIAP3h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Sep 2020 11:29:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:51960 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729926AbgIAP0Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 11:26:24 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 35A08207D3;
        Tue,  1 Sep 2020 15:26:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598973983;
        bh=VTehNHRiBgXL+UiN+N+yG0HswAI6mV0x1exACyyb66g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MN5vQrMHW01mvltdb4H2Ob//uXq4m0dM1BVr2TW935duJsbDPHFUu4BR9r+Hz1Iob
         LbYOfvflTbjJGvx8ACY8cLvMbHvqU3kZ8k0vYjHMHKrJkSH1LlLXZiU/KjY8pENOnE
         JhdRd7l/sL5UO7K1qBhalYrO9NHF0Glrsy63lyqw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Roman Shaposhnik <roman@zededa.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Juergen Gross <jgross@suse.com>
Subject: [PATCH 4.19 097/125] XEN uses irqdesc::irq_data_common::handler_data to store a per interrupt XEN data pointer which contains XEN specific information.
Date:   Tue,  1 Sep 2020 17:10:52 +0200
Message-Id: <20200901150939.353773322@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200901150934.576210879@linuxfoundation.org>
References: <20200901150934.576210879@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thomas Gleixner <tglx@linutronix.de>

commit c330fb1ddc0a922f044989492b7fcca77ee1db46 upstream.

handler data is meant for interrupt handlers and not for storing irq chip
specific information as some devices require handler data to store internal
per interrupt information, e.g. pinctrl/GPIO chained interrupt handlers.

This obviously creates a conflict of interests and crashes the machine
because the XEN pointer is overwritten by the driver pointer.

As the XEN data is not handler specific it should be stored in
irqdesc::irq_data::chip_data instead.

A simple sed s/irq_[sg]et_handler_data/irq_[sg]et_chip_data/ cures that.

Cc: stable@vger.kernel.org
Reported-by: Roman Shaposhnik <roman@zededa.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Roman Shaposhnik <roman@zededa.com>
Reviewed-by: Juergen Gross <jgross@suse.com>
Link: https://lore.kernel.org/r/87lfi2yckt.fsf@nanos.tec.linutronix.de
Signed-off-by: Juergen Gross <jgross@suse.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/xen/events/events_base.c |   16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

--- a/drivers/xen/events/events_base.c
+++ b/drivers/xen/events/events_base.c
@@ -154,7 +154,7 @@ int get_evtchn_to_irq(unsigned evtchn)
 /* Get info for IRQ */
 struct irq_info *info_for_irq(unsigned irq)
 {
-	return irq_get_handler_data(irq);
+	return irq_get_chip_data(irq);
 }
 
 /* Constructors for packed IRQ information. */
@@ -375,7 +375,7 @@ static void xen_irq_init(unsigned irq)
 	info->type = IRQT_UNBOUND;
 	info->refcnt = -1;
 
-	irq_set_handler_data(irq, info);
+	irq_set_chip_data(irq, info);
 
 	list_add_tail(&info->list, &xen_irq_list_head);
 }
@@ -424,14 +424,14 @@ static int __must_check xen_allocate_irq
 
 static void xen_free_irq(unsigned irq)
 {
-	struct irq_info *info = irq_get_handler_data(irq);
+	struct irq_info *info = irq_get_chip_data(irq);
 
 	if (WARN_ON(!info))
 		return;
 
 	list_del(&info->list);
 
-	irq_set_handler_data(irq, NULL);
+	irq_set_chip_data(irq, NULL);
 
 	WARN_ON(info->refcnt > 0);
 
@@ -601,7 +601,7 @@ EXPORT_SYMBOL_GPL(xen_irq_from_gsi);
 static void __unbind_from_irq(unsigned int irq)
 {
 	int evtchn = evtchn_from_irq(irq);
-	struct irq_info *info = irq_get_handler_data(irq);
+	struct irq_info *info = irq_get_chip_data(irq);
 
 	if (info->refcnt > 0) {
 		info->refcnt--;
@@ -1105,7 +1105,7 @@ int bind_ipi_to_irqhandler(enum ipi_vect
 
 void unbind_from_irqhandler(unsigned int irq, void *dev_id)
 {
-	struct irq_info *info = irq_get_handler_data(irq);
+	struct irq_info *info = irq_get_chip_data(irq);
 
 	if (WARN_ON(!info))
 		return;
@@ -1139,7 +1139,7 @@ int evtchn_make_refcounted(unsigned int
 	if (irq == -1)
 		return -ENOENT;
 
-	info = irq_get_handler_data(irq);
+	info = irq_get_chip_data(irq);
 
 	if (!info)
 		return -ENOENT;
@@ -1167,7 +1167,7 @@ int evtchn_get(unsigned int evtchn)
 	if (irq == -1)
 		goto done;
 
-	info = irq_get_handler_data(irq);
+	info = irq_get_chip_data(irq);
 
 	if (!info)
 		goto done;


