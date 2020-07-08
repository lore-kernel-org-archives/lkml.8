Return-Path: <SRS0=/IhT=AT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0891DC433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 16:21:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E4BD82067D
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 16:21:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730635AbgGHQVq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jul 2020 12:21:46 -0400
Received: from mga12.intel.com ([192.55.52.136]:40825 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730596AbgGHQVn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 12:21:43 -0400
IronPort-SDR: rzz2L1C9HfR1DMnOMqMk2ZX+tOIPEvmLOMH9VgYYipl5oG8gHLzo5hrW2Ge5q5MP50VYvKBJSf
 FgoWsK3hlr4Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9676"; a="127441013"
X-IronPort-AV: E=Sophos;i="5.75,327,1589266800"; 
   d="scan'208";a="127441013"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2020 09:21:42 -0700
IronPort-SDR: JHkzLSXTvCFhczTEgM5EfmUiOeB8qAfZmG5Su/z2hdCKcuh6NEtb/aKFXJKga18WC8+IRRQlXJ
 SOVbIdho7lsA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,327,1589266800"; 
   d="scan'208";a="358152394"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga001.jf.intel.com with ESMTP; 08 Jul 2020 09:21:39 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id D38FB371; Wed,  8 Jul 2020 19:21:38 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 2/5] irqdomain: Add forward declaration of fwnode_handle
Date:   Wed,  8 Jul 2020 19:21:32 +0300
Message-Id: <20200708162135.31010-3-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200708162135.31010-1-andriy.shevchenko@linux.intel.com>
References: <20200708162135.31010-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

irqdomain.h is a user of struct fwnode_handle. Add forward declaration of it.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 include/linux/irqdomain.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/irqdomain.h b/include/linux/irqdomain.h
index ad6d2335e980..39bb0c13ac07 100644
--- a/include/linux/irqdomain.h
+++ b/include/linux/irqdomain.h
@@ -37,6 +37,7 @@
 #include <linux/radix-tree.h>
 
 struct device_node;
+struct fwnode_handle;
 struct irq_domain;
 struct irq_chip;
 struct irq_data;
-- 
2.27.0

