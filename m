Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,DATE_IN_PAST_06_12,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65A99C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 08:04:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 49AFD20758
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 08:04:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726745AbgHQIEx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 04:04:53 -0400
Received: from mga09.intel.com ([134.134.136.24]:25796 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725765AbgHQIEu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 04:04:50 -0400
IronPort-SDR: MIdmN3AFLOgcW6xnKsv80xa5teyLynIWGkuSf5tqcxPW2QJJ4kJZfNKZa6ZyaB+JHtWI/aXNAy
 KdnDDJxcX9Og==
X-IronPort-AV: E=McAfee;i="6000,8403,9715"; a="155749613"
X-IronPort-AV: E=Sophos;i="5.76,322,1592895600"; 
   d="scan'208";a="155749613"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2020 01:04:50 -0700
IronPort-SDR: 0nl6vz9Rjl4rJnPfgZ0q1hQmESMNwwmQ4oIgs8HFMGwigWSXzpstNK9Q34hrPdluEDXcYq8kQi
 W4J/9RVgqBNw==
X-IronPort-AV: E=Sophos;i="5.76,322,1592895600"; 
   d="scan'208";a="471339988"
Received: from bard-ubuntu.sh.intel.com ([10.239.13.33])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2020 01:04:46 -0700
From:   Bard Liao <yung-chuan.liao@linux.intel.com>
To:     alsa-devel@alsa-project.org, vkoul@kernel.org
Cc:     vinod.koul@linaro.org, linux-kernel@vger.kernel.org, tiwai@suse.de,
        broonie@kernel.org, gregkh@linuxfoundation.org, jank@cadence.com,
        srinivas.kandagatla@linaro.org, rander.wang@linux.intel.com,
        ranjani.sridharan@linux.intel.com, hui.wang@canonical.com,
        pierre-louis.bossart@linux.intel.com, sanyog.r.kale@intel.com,
        mengdong.lin@intel.com, bard.liao@intel.com
Subject: [PATCH v2] soundwire: SDCA: add helper macro to access controls
Date:   Mon, 17 Aug 2020 04:10:58 +0800
Message-Id: <20200816201058.9687-1-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

The upcoming SDCA (SoundWire Device Class Audio) specification defines
a hiearchical encoding to interface with Class-defined capabilities,
based on which audio function, entity, control and channel being used.

The specification is not yet accessible to the general public but this
information is released with explicit permission from the MIPI Board
to avoid delays with SDCA support on Linux platforms.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Rander Wang <rander.wang@linux.intel.com>
Reviewed-by: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>
Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
---

Changelog:

v2:
 - add SDW_SDCA_MBQ_CTL

---
 include/linux/soundwire/sdw_registers.h | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/include/linux/soundwire/sdw_registers.h b/include/linux/soundwire/sdw_registers.h
index 5d3c271af7d1..4517c0f65b4f 100644
--- a/include/linux/soundwire/sdw_registers.h
+++ b/include/linux/soundwire/sdw_registers.h
@@ -305,4 +305,16 @@
 #define SDW_CASC_PORT_MASK_INTSTAT3		1
 #define SDW_CASC_PORT_REG_OFFSET_INTSTAT3	2
 
+/* v1.2 device - SDCA address mapping */
+#define SDW_SDCA_CTL(fun, ent, ctl, ch)		(BIT(30) |			\
+						 (((fun) & 0x7) << 22) |	\
+						 (((ent) & 0x40) << 15) |	\
+						 (((ent) & 0x3f) << 7) |	\
+						 (((ctl) & 0x30) << 15) |	\
+						 (((ctl) & 0x0f) << 3) |	\
+						 (((ch) & 0x38) << 12) |	\
+						 ((ch) & 0x07))
+
+#define SDW_SDCA_MBQ_CTL(reg)			((reg) | BIT(13))
+
 #endif /* __SDW_REGISTERS_H */
-- 
2.17.1

