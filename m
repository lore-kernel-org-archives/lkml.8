Return-Path: <SRS0=/IhT=AT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD9C1C433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 16:21:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A404F20720
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 16:21:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730620AbgGHQVo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jul 2020 12:21:44 -0400
Received: from mga11.intel.com ([192.55.52.93]:64766 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730093AbgGHQVm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 12:21:42 -0400
IronPort-SDR: 1t7ve5lMcLkZrE2Eqa6fyIj9TvJFAtojpNZ5/qf3vKpm0GfAuWLTHby9MTZvZ5Jmj6AEGi99RA
 J4tmw/VuSU8Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9676"; a="145948483"
X-IronPort-AV: E=Sophos;i="5.75,327,1589266800"; 
   d="scan'208";a="145948483"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2020 09:21:41 -0700
IronPort-SDR: 7BPnNNcWfd97KDhoERQaMeitiVRiY7Mnn/PI6D9sLfCI1F6zopgYKI+MABYT0bHxlmcPaiRku8
 qfjpJHW6DDkw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,327,1589266800"; 
   d="scan'208";a="388863219"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 08 Jul 2020 09:21:39 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id C2D1421D; Wed,  8 Jul 2020 19:21:38 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 0/5] irqdomain: clean up, add irq_domain_create_legacy()
Date:   Wed,  8 Jul 2020 19:21:30 +0300
Message-Id: <20200708162135.31010-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to make users OF independent provide irq_domain_create_legacy() API.
Last patch is an example of such user. First three patches are little cleanups.

Since regmap patch is dependent to what is now in regmap tree, I suggest to
create an immutable branch in IRQ domain tree and Mark can pull it and apply
the last one.

Andy Shevchenko (5):
  irqdomain: Remove unused of_device_id forward declaration
  irqdomain: Add forward declaration of fwnode_handle
  irqdomain: Replace open coded of_node_to_fwnode()
  irqdomain: Introduce irq_domain_create_legacy() API
  regmap: irq: Convert to use fwnode directly

 Documentation/core-api/irq/irq-domain.rst |  6 ++++++
 drivers/base/regmap/regmap-irq.c          | 11 +++++------
 include/linux/irqdomain.h                 |  8 +++++++-
 kernel/irq/irqdomain.c                    | 19 +++++++++++++++----
 4 files changed, 33 insertions(+), 11 deletions(-)

-- 
2.27.0

