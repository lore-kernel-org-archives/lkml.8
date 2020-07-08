Return-Path: <SRS0=/IhT=AT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4CC1C433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 16:21:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 94EB9206DF
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 16:21:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730605AbgGHQVn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jul 2020 12:21:43 -0400
Received: from mga02.intel.com ([134.134.136.20]:45327 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730387AbgGHQVm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 12:21:42 -0400
IronPort-SDR: 48/TwBHXdVe73xAmv+RisoLnaP1v910wve4UMYgGbzfVd36sZe2/xJaUOmHYEMKnJUTNAGCbRu
 WvW28+O2J0Sw==
X-IronPort-AV: E=McAfee;i="6000,8403,9676"; a="136084446"
X-IronPort-AV: E=Sophos;i="5.75,327,1589266800"; 
   d="scan'208";a="136084446"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2020 09:21:41 -0700
IronPort-SDR: /fzY5M2SacsbJj91JEEPal6g5TmdKA87bWnG6Rrr3pW5RgJh3A2aI8/1y6LmQTeab1zCu9i6tk
 bOzpKea5CYsg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,327,1589266800"; 
   d="scan'208";a="427888174"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga004.jf.intel.com with ESMTP; 08 Jul 2020 09:21:39 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id CC49B212; Wed,  8 Jul 2020 19:21:38 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/5] irqdomain: Remove unused of_device_id forward declaration
Date:   Wed,  8 Jul 2020 19:21:31 +0300
Message-Id: <20200708162135.31010-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200708162135.31010-1-andriy.shevchenko@linux.intel.com>
References: <20200708162135.31010-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is no users of of_device_id in irqdomain.h. Drop it.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 include/linux/irqdomain.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/linux/irqdomain.h b/include/linux/irqdomain.h
index b37350c4fe37..ad6d2335e980 100644
--- a/include/linux/irqdomain.h
+++ b/include/linux/irqdomain.h
@@ -38,7 +38,6 @@
 
 struct device_node;
 struct irq_domain;
-struct of_device_id;
 struct irq_chip;
 struct irq_data;
 struct cpumask;
-- 
2.27.0

