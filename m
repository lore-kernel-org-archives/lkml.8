Return-Path: <SRS0=+GcV=BG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,DATE_IN_PAST_06_12,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D6D8C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 09:53:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0332C2074F
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 09:53:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726924AbgG0Jxj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jul 2020 05:53:39 -0400
Received: from mga09.intel.com ([134.134.136.24]:49453 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726140AbgG0Jxj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 05:53:39 -0400
IronPort-SDR: WqGVwXJ1NLsBhTDqOgLbOIxOuhDjc2YtYdZGdE6EMRpxAcpNLzpPz89FtxPNAGMzZdsDEtqwC0
 og+SkluD7Jvw==
X-IronPort-AV: E=McAfee;i="6000,8403,9694"; a="152240505"
X-IronPort-AV: E=Sophos;i="5.75,402,1589266800"; 
   d="scan'208";a="152240505"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jul 2020 02:53:39 -0700
IronPort-SDR: zPLjLoPPCMGlnfEV1YyScGhCR59QqS54CiI/jGC6iZ93zkwfw58CmCY3TO+EcxU32hIj0C4IrZ
 9hG5IoLXN3lw==
X-IronPort-AV: E=Sophos;i="5.75,402,1589266800"; 
   d="scan'208";a="464006917"
Received: from bard-ubuntu.sh.intel.com ([10.239.13.33])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jul 2020 02:53:34 -0700
From:   Bard Liao <yung-chuan.liao@linux.intel.com>
To:     alsa-devel@alsa-project.org, vkoul@kernel.org
Cc:     vinod.koul@linaro.org, linux-kernel@vger.kernel.org, tiwai@suse.de,
        broonie@kernel.org, gregkh@linuxfoundation.org, jank@cadence.com,
        srinivas.kandagatla@linaro.org, rander.wang@linux.intel.com,
        ranjani.sridharan@linux.intel.com, hui.wang@canonical.com,
        pierre-louis.bossart@linux.intel.com, sanyog.r.kale@intel.com,
        mengdong.lin@intel.com, bard.liao@intel.com
Subject: [PATCH v2] soundwire: master: enable pm runtime
Date:   Mon, 27 Jul 2020 05:59:45 +0800
Message-Id: <20200726215945.3119-1-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The hierarchy of soundwire devices is platform device -> M device -> S
device. A S device is physically attached on the platform device. So the
platform device should be resumed when a S device is resumed. As the
bridge of platform device and S device, we have to implement runtime pm
on M driver. We have set runtime pm ops in M driver already, but still
need to enable runtime pm.

Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>

---

Changes in v2:
 - Edit the commit message to explain why we need the patch. 
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

