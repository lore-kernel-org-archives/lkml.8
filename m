Return-Path: <SRS0=/IhT=AT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D20AFC433E1
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 16:21:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BC5C020842
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 16:21:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730583AbgGHQVm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jul 2020 12:21:42 -0400
Received: from mga07.intel.com ([134.134.136.100]:56227 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730405AbgGHQVm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 12:21:42 -0400
IronPort-SDR: Ly/jPsgGW2wvQgJqUJRwadpSIKv+jlc6YQ2FQWAWGHaDEEhw93SPAWwTSrK1w4BK9lgC5a9EUa
 QWjWsjzFibMA==
X-IronPort-AV: E=McAfee;i="6000,8403,9676"; a="212778630"
X-IronPort-AV: E=Sophos;i="5.75,327,1589266800"; 
   d="scan'208";a="212778630"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2020 09:21:41 -0700
IronPort-SDR: F1zsg85myPZdee3UeItjeKBEvNc2CdS4v0qj7c2QVA2JC74IQVyekMS7bPl8oD0o50mdfdCVOK
 5EhVUH7igfww==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,327,1589266800"; 
   d="scan'208";a="322983135"
Received: from black.fi.intel.com ([10.237.72.28])
  by FMSMGA003.fm.intel.com with ESMTP; 08 Jul 2020 09:21:39 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id DDD6646B; Wed,  8 Jul 2020 19:21:38 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 3/5] irqdomain: Replace open coded of_node_to_fwnode()
Date:   Wed,  8 Jul 2020 19:21:33 +0300
Message-Id: <20200708162135.31010-4-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200708162135.31010-1-andriy.shevchenko@linux.intel.com>
References: <20200708162135.31010-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We can convert device node to fwnode with of_node_to_fwnode().
Replace open coded variant of it in of_phandle_args_to_fwspec().

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 kernel/irq/irqdomain.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/irq/irqdomain.c b/kernel/irq/irqdomain.c
index a4c2c915511d..d7a762cce8e9 100644
--- a/kernel/irq/irqdomain.c
+++ b/kernel/irq/irqdomain.c
@@ -736,7 +736,7 @@ static void of_phandle_args_to_fwspec(struct device_node *np, const u32 *args,
 {
 	int i;
 
-	fwspec->fwnode = np ? &np->fwnode : NULL;
+	fwspec->fwnode = of_node_to_fwnode(np);
 	fwspec->param_count = count;
 
 	for (i = 0; i < count; i++)
-- 
2.27.0

