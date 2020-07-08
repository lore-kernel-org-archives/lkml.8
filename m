Return-Path: <SRS0=/IhT=AT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D0B3C433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 16:21:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 212C52067D
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 16:21:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730644AbgGHQVt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jul 2020 12:21:49 -0400
Received: from mga11.intel.com ([192.55.52.93]:64766 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730627AbgGHQVp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 12:21:45 -0400
IronPort-SDR: ZtY2uantfk31O28rPkbTzL2vWyMVe4U2P7XZfAxJyJRpFB+UUa4AaCexUGM1Suos4R/jcmYzX+
 9uwb6QWPIBnw==
X-IronPort-AV: E=McAfee;i="6000,8403,9676"; a="145948503"
X-IronPort-AV: E=Sophos;i="5.75,327,1589266800"; 
   d="scan'208";a="145948503"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2020 09:21:45 -0700
IronPort-SDR: 19+/wi5fnmPjDk0XJGoJMNGwIwxvWLKg3QZM0oq65iPYeEX9NQMZP5m8AuD9nu7eJ/vSkpDpsF
 lex5QA7n7nWQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,327,1589266800"; 
   d="scan'208";a="323931915"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga007.jf.intel.com with ESMTP; 08 Jul 2020 09:21:42 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id EDA45496; Wed,  8 Jul 2020 19:21:38 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 5/5] regmap: irq: Convert to use fwnode directly
Date:   Wed,  8 Jul 2020 19:21:35 +0300
Message-Id: <20200708162135.31010-6-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200708162135.31010-1-andriy.shevchenko@linux.intel.com>
References: <20200708162135.31010-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since IRQ domain provides an API to take fwnode as a parameter,
switch regmap IRQ to use that directly instead of be limited
to OF case only.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/base/regmap/regmap-irq.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/base/regmap/regmap-irq.c b/drivers/base/regmap/regmap-irq.c
index 369a57e6f89d..2ecdfdbdfc71 100644
--- a/drivers/base/regmap/regmap-irq.c
+++ b/drivers/base/regmap/regmap-irq.c
@@ -772,13 +772,12 @@ int regmap_add_irq_chip_fwnode(struct fwnode_handle *fwnode,
 	}
 
 	if (irq_base)
-		d->domain = irq_domain_add_legacy(to_of_node(fwnode),
-						  chip->num_irqs, irq_base,
-						  0, &regmap_domain_ops, d);
+		d->domain = irq_domain_create_legacy(fwnode, chip->num_irqs,
+						     irq_base, 0,
+						     &regmap_domain_ops, d);
 	else
-		d->domain = irq_domain_add_linear(to_of_node(fwnode),
-						  chip->num_irqs,
-						  &regmap_domain_ops, d);
+		d->domain = irq_domain_create_linear(fwnode, chip->num_irqs,
+						     &regmap_domain_ops, d);
 	if (!d->domain) {
 		dev_err(map->dev, "Failed to create IRQ domain\n");
 		ret = -ENOMEM;
-- 
2.27.0

