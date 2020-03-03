Return-Path: <SRS0=fZJt=4U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3362C3F2C6
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 08:10:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B142621741
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 08:10:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727799AbgCCIK0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Mar 2020 03:10:26 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:43716 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727654AbgCCIK0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Mar 2020 03:10:26 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1j92dB-00026M-HL; Tue, 03 Mar 2020 09:10:21 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 2E9651C1A9F;
        Tue,  3 Mar 2020 09:10:21 +0100 (CET)
Date:   Tue, 03 Mar 2020 08:10:20 -0000
From:   "tip-bot2 for luanshi" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] irqdomain: Fix function documentation of
 __irq_domain_alloc_fwnode()
Cc:     luanshi <zhangliguang@linux.alibaba.com>,
        Thomas Gleixner <tglx@linutronix.de>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <1583200125-58806-1-git-send-email-zhangliguang@linux.alibaba.com>
References: <1583200125-58806-1-git-send-email-zhangliguang@linux.alibaba.com>
MIME-Version: 1.0
Message-ID: <158322302088.28353.3499023675334636073.tip-bot2@tip-bot2>
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

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     30073b2c0bcad41f1b0d01068e07fd81b812c916
Gitweb:        https://git.kernel.org/tip/30073b2c0bcad41f1b0d01068e07fd81b812c916
Author:        luanshi <zhangliguang@linux.alibaba.com>
AuthorDate:    Tue, 03 Mar 2020 09:48:45 +08:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 03 Mar 2020 09:06:25 +01:00

irqdomain: Fix function documentation of __irq_domain_alloc_fwnode()

The function got renamed at some point, but the kernel-doc was not updated.

Signed-off-by: luanshi <zhangliguang@linux.alibaba.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lkml.kernel.org/r/1583200125-58806-1-git-send-email-zhangliguang@linux.alibaba.com

---
 kernel/irq/irqdomain.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/irq/irqdomain.c b/kernel/irq/irqdomain.c
index 7527e5e..fdfc213 100644
--- a/kernel/irq/irqdomain.c
+++ b/kernel/irq/irqdomain.c
@@ -46,11 +46,11 @@ const struct fwnode_operations irqchip_fwnode_ops;
 EXPORT_SYMBOL_GPL(irqchip_fwnode_ops);
 
 /**
- * irq_domain_alloc_fwnode - Allocate a fwnode_handle suitable for
+ * __irq_domain_alloc_fwnode - Allocate a fwnode_handle suitable for
  *                           identifying an irq domain
  * @type:	Type of irqchip_fwnode. See linux/irqdomain.h
- * @name:	Optional user provided domain name
  * @id:		Optional user provided id if name != NULL
+ * @name:	Optional user provided domain name
  * @pa:		Optional user-provided physical address
  *
  * Allocate a struct irqchip_fwid, and return a poiner to the embedded
