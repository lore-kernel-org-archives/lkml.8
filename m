Return-Path: <SRS0=4orP=BD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,DATE_IN_PAST_06_12,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE837C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 01:43:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9434820737
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 01:43:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726716AbgGXBnW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jul 2020 21:43:22 -0400
Received: from mga03.intel.com ([134.134.136.65]:24308 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726284AbgGXBnW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jul 2020 21:43:22 -0400
IronPort-SDR: Wat8JI1bBDoB3KvxYXS/83GjPMi3j1qdGANmlPm5JiB7L/7u1uKXdX2Rk8a0qD7RsGX43GCh1n
 hhHmQ1NMaIzg==
X-IronPort-AV: E=McAfee;i="6000,8403,9691"; a="150632532"
X-IronPort-AV: E=Sophos;i="5.75,388,1589266800"; 
   d="scan'208";a="150632532"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jul 2020 18:43:21 -0700
IronPort-SDR: T7YYDmQ9wjOSJPYKP8f87ewHjV5UJCnwN4NR7F+wP9L2IS9xMbwIg33+hd3/h7ojvQvZD3NB9Z
 GU0QbpLoGiCw==
X-IronPort-AV: E=Sophos;i="5.75,388,1589266800"; 
   d="scan'208";a="463063485"
Received: from bard-ubuntu.sh.intel.com ([10.239.13.33])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jul 2020 18:43:17 -0700
From:   Bard Liao <yung-chuan.liao@linux.intel.com>
To:     alsa-devel@alsa-project.org, vkoul@kernel.org
Cc:     vinod.koul@linaro.org, linux-kernel@vger.kernel.org, tiwai@suse.de,
        broonie@kernel.org, gregkh@linuxfoundation.org, jank@cadence.com,
        srinivas.kandagatla@linaro.org, rander.wang@linux.intel.com,
        ranjani.sridharan@linux.intel.com, hui.wang@canonical.com,
        pierre-louis.bossart@linux.intel.com, sanyog.r.kale@intel.com,
        mengdong.lin@intel.com, bard.liao@intel.com
Subject: [PATCH] soundwire: master: enable pm runtime
Date:   Thu, 23 Jul 2020 21:49:02 +0800
Message-Id: <20200723134902.26290-1-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We should enable pm runtime.

Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
---
 drivers/soundwire/master.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/soundwire/master.c b/drivers/soundwire/master.c
index 5f0b2189defe..3488bb824e84 100644
--- a/drivers/soundwire/master.c
+++ b/drivers/soundwire/master.c
@@ -154,6 +154,7 @@ int sdw_master_device_add(struct sdw_bus *bus, struct device *parent,
 	bus->dev = &md->dev;
 	bus->md = md;
 
+	pm_runtime_enable(&bus->md->dev);
 device_register_err:
 	return ret;
 }
@@ -166,6 +167,7 @@ int sdw_master_device_add(struct sdw_bus *bus, struct device *parent,
  */
 int sdw_master_device_del(struct sdw_bus *bus)
 {
+	pm_runtime_disable(&bus->md->dev);
 	device_unregister(bus->dev);
 
 	return 0;
-- 
2.17.1

