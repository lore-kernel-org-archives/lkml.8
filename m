Return-Path: <SRS0=sqqi=7C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DATE_IN_PAST_06_12,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8369C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 07:13:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AF32E207D3
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 07:13:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726510AbgETHNs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 May 2020 03:13:48 -0400
Received: from mga02.intel.com ([134.134.136.20]:16407 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726369AbgETHNr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 May 2020 03:13:47 -0400
IronPort-SDR: YFw+xRProKIFay5bZWjuMur1lBEldkPuNLD+c3IZ5xNNrYau1138DvwuvmO8foJsbUojghTNJk
 X1SBewyMd+rg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2020 00:13:47 -0700
IronPort-SDR: 1I4Md1o/u325pnWQMRQ3X79EeTBosykvzJPYwMnXYMhD0Jvyg9TpV494VcD529MpfSn6Je8ttg
 MPYvcYD4VoQA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,413,1583222400"; 
   d="scan'208";a="253596937"
Received: from bard-ubuntu.sh.intel.com ([10.239.13.33])
  by fmsmga007.fm.intel.com with ESMTP; 20 May 2020 00:13:43 -0700
From:   Bard Liao <yung-chuan.liao@linux.intel.com>
To:     alsa-devel@alsa-project.org, vkoul@kernel.org
Cc:     vinod.koul@linaro.org, linux-kernel@vger.kernel.org, tiwai@suse.de,
        broonie@kernel.org, gregkh@linuxfoundation.org, jank@cadence.com,
        srinivas.kandagatla@linaro.org, rander.wang@linux.intel.com,
        ranjani.sridharan@linux.intel.com, hui.wang@canonical.com,
        pierre-louis.bossart@linux.intel.com, sanyog.r.kale@intel.com,
        slawomir.blauciak@intel.com, mengdong.lin@intel.com,
        bard.liao@intel.com
Subject: [PATCH 1/2] soundwire: intel: use a single module
Date:   Wed, 20 May 2020 03:19:02 +0800
Message-Id: <20200519191903.6557-1-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rander Wang <rander.wang@intel.com>

It's not clear why we have two modules for the Intel controller/master
support when there is a single Kconfig. This adds complexity for no
good reason, the two parts need to work together anyways.

Signed-off-by: Rander Wang <rander.wang@intel.com>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
---
 drivers/soundwire/Makefile | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/soundwire/Makefile b/drivers/soundwire/Makefile
index 7319918e0aec..4f6094767212 100644
--- a/drivers/soundwire/Makefile
+++ b/drivers/soundwire/Makefile
@@ -16,12 +16,9 @@ soundwire-cadence-objs := cadence_master.o
 obj-$(CONFIG_SOUNDWIRE_CADENCE) += soundwire-cadence.o
 
 #Intel driver
-soundwire-intel-objs :=	intel.o
+soundwire-intel-objs :=	intel.o intel_init.o
 obj-$(CONFIG_SOUNDWIRE_INTEL) += soundwire-intel.o
 
-soundwire-intel-init-objs := intel_init.o
-obj-$(CONFIG_SOUNDWIRE_INTEL) += soundwire-intel-init.o
-
 #Qualcomm driver
 soundwire-qcom-objs :=	qcom.o
 obj-$(CONFIG_SOUNDWIRE_QCOM) += soundwire-qcom.o
-- 
2.17.1

