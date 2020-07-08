Return-Path: <SRS0=/IhT=AT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A6F6C433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 16:21:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3B8052067D
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 16:21:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730657AbgGHQV4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jul 2020 12:21:56 -0400
Received: from mga01.intel.com ([192.55.52.88]:19571 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730436AbgGHQVm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 12:21:42 -0400
IronPort-SDR: acvjzteNYGlJqg27qMcY11WjvgZPykLwT0R8NEIFW3IXFEdnDxyGIyIS8ZsyVcFw2Xnbq57Gus
 4GPJQknknnrA==
X-IronPort-AV: E=McAfee;i="6000,8403,9676"; a="165952728"
X-IronPort-AV: E=Sophos;i="5.75,327,1589266800"; 
   d="scan'208";a="165952728"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2020 09:21:42 -0700
IronPort-SDR: ZCYwmPTuUO/tsnoMpqT86pOqQ3tn72hzhc1iiegSPF4JPridvsRXfA/3t3JFY1O+zGOCtTfLQU
 oa06JljRBJ7g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,327,1589266800"; 
   d="scan'208";a="314680309"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga008.jf.intel.com with ESMTP; 08 Jul 2020 09:21:39 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id E5E7046D; Wed,  8 Jul 2020 19:21:38 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 4/5] irqdomain: Introduce irq_domain_create_legacy() API
Date:   Wed,  8 Jul 2020 19:21:34 +0300
Message-Id: <20200708162135.31010-5-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200708162135.31010-1-andriy.shevchenko@linux.intel.com>
References: <20200708162135.31010-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce irq_domain_create_legacy() API which is functional equivalent
to the existing irq_domain_add_legacy(), but takes a pointer to the struct
fwnode_handle as a parameter.

Some users want to use it in non-OF cases.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 Documentation/core-api/irq/irq-domain.rst |  6 ++++++
 include/linux/irqdomain.h                 |  6 ++++++
 kernel/irq/irqdomain.c                    | 17 ++++++++++++++---
 3 files changed, 26 insertions(+), 3 deletions(-)

diff --git a/Documentation/core-api/irq/irq-domain.rst b/Documentation/core-api/irq/irq-domain.rst
index 096db12f32d5..a77c24c27f7b 100644
--- a/Documentation/core-api/irq/irq-domain.rst
+++ b/Documentation/core-api/irq/irq-domain.rst
@@ -147,6 +147,7 @@ Legacy
 	irq_domain_add_simple()
 	irq_domain_add_legacy()
 	irq_domain_add_legacy_isa()
+	irq_domain_create_legacy()
 
 The Legacy mapping is a special case for drivers that already have a
 range of irq_descs allocated for the hwirqs.  It is used when the
@@ -185,6 +186,11 @@ that the driver using the simple domain call irq_create_mapping()
 before any irq_find_mapping() since the latter will actually work
 for the static IRQ assignment case.
 
+irq_domain_add_legacy() and irq_domain_create_legacy() are functionally
+equivalent, except for the first argument is different - the former
+accepts an Open Firmware specific 'struct device_node', while the latter
+accepts a more general abstraction 'struct fwnode_handle'.
+
 Hierarchy IRQ domain
 --------------------
 
diff --git a/include/linux/irqdomain.h b/include/linux/irqdomain.h
index 39bb0c13ac07..529719f4a034 100644
--- a/include/linux/irqdomain.h
+++ b/include/linux/irqdomain.h
@@ -270,6 +270,12 @@ struct irq_domain *irq_domain_add_legacy(struct device_node *of_node,
 					 irq_hw_number_t first_hwirq,
 					 const struct irq_domain_ops *ops,
 					 void *host_data);
+struct irq_domain *irq_domain_create_legacy(struct fwnode_handle *fwnode,
+					    unsigned int size,
+					    unsigned int first_irq,
+					    irq_hw_number_t first_hwirq,
+					    const struct irq_domain_ops *ops,
+					    void *host_data);
 extern struct irq_domain *irq_find_matching_fwspec(struct irq_fwspec *fwspec,
 						   enum irq_domain_bus_token bus_token);
 extern bool irq_domain_check_msi_remap(void);
diff --git a/kernel/irq/irqdomain.c b/kernel/irq/irqdomain.c
index d7a762cce8e9..04936a3eb34e 100644
--- a/kernel/irq/irqdomain.c
+++ b/kernel/irq/irqdomain.c
@@ -349,17 +349,28 @@ struct irq_domain *irq_domain_add_legacy(struct device_node *of_node,
 					 irq_hw_number_t first_hwirq,
 					 const struct irq_domain_ops *ops,
 					 void *host_data)
+{
+	return irq_domain_create_legacy(of_node_to_fwnode(of_node), size,
+					first_irq, first_hwirq, ops, host_data);
+}
+EXPORT_SYMBOL_GPL(irq_domain_add_legacy);
+
+struct irq_domain *irq_domain_create_legacy(struct fwnode_handle *fwnode,
+					 unsigned int size,
+					 unsigned int first_irq,
+					 irq_hw_number_t first_hwirq,
+					 const struct irq_domain_ops *ops,
+					 void *host_data)
 {
 	struct irq_domain *domain;
 
-	domain = __irq_domain_add(of_node_to_fwnode(of_node), first_hwirq + size,
-				  first_hwirq + size, 0, ops, host_data);
+	domain = __irq_domain_add(fwnode, first_hwirq + size, first_hwirq + size, 0, ops, host_data);
 	if (domain)
 		irq_domain_associate_many(domain, first_irq, first_hwirq, size);
 
 	return domain;
 }
-EXPORT_SYMBOL_GPL(irq_domain_add_legacy);
+EXPORT_SYMBOL_GPL(irq_domain_create_legacy);
 
 /**
  * irq_find_matching_fwspec() - Locates a domain for a given fwspec
-- 
2.27.0

