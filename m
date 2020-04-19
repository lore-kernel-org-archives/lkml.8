Return-Path: <SRS0=QXtz=6E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DATE_IN_PAST_06_12,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35636C3815B
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 06:46:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1F3D62072B
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 06:46:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726112AbgDTGqX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Apr 2020 02:46:23 -0400
Received: from mga09.intel.com ([134.134.136.24]:48034 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725773AbgDTGqW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 02:46:22 -0400
IronPort-SDR: LPP2vh0cIpecW9edTrk5sIjvTH6lFfv9AbNGXH9mZIDON6KhEtvaE3aLkeuCduJGBIhH5xamd3
 SSqtOXggZakQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2020 23:46:22 -0700
IronPort-SDR: 1hIjqnFsmjxCqW/SsUJrW0agOg7YlfuopBvTXfe1eDrX2yGroLKkHinBhEtTHrie5flPqXPBkK
 WLvX6uCu4wlg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,406,1580803200"; 
   d="scan'208";a="254845081"
Received: from bard-ubuntu.sh.intel.com ([10.239.13.33])
  by orsmga003.jf.intel.com with ESMTP; 19 Apr 2020 23:46:18 -0700
From:   Bard Liao <yung-chuan.liao@linux.intel.com>
To:     alsa-devel@alsa-project.org, vkoul@kernel.org
Cc:     linux-kernel@vger.kernel.org, tiwai@suse.de, broonie@kernel.org,
        gregkh@linuxfoundation.org, jank@cadence.com,
        srinivas.kandagatla@linaro.org, rander.wang@linux.intel.com,
        ranjani.sridharan@linux.intel.com, hui.wang@canonical.com,
        pierre-louis.bossart@linux.intel.com, sanyog.r.kale@intel.com,
        slawomir.blauciak@intel.com, mengdong.lin@intel.com,
        bard.liao@intel.com
Subject: [PATCH 4/4] soundwire: bus: reduce verbosity on enumeration
Date:   Mon, 20 Apr 2020 02:51:17 +0800
Message-Id: <20200419185117.4233-4-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200419185117.4233-1-yung-chuan.liao@linux.intel.com>
References: <20200419185117.4233-1-yung-chuan.liao@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

No need to repeat the same info log on all enumerations (essentially
each power-up), keep it as debug information.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
Reviewed-by: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>
Reviewed-by: Kai Vehmanen <kai.vehmanen@linux.intel.com>
---
 drivers/soundwire/bus.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/soundwire/bus.c b/drivers/soundwire/bus.c
index 488c3c9e4947..f9a078ce76bc 100644
--- a/drivers/soundwire/bus.c
+++ b/drivers/soundwire/bus.c
@@ -563,9 +563,9 @@ static int sdw_assign_device_num(struct sdw_slave *slave)
 	}
 
 	if (!new_device)
-		dev_info(slave->bus->dev,
-			 "Slave already registered, reusing dev_num:%d\n",
-			 slave->dev_num);
+		dev_dbg(slave->bus->dev,
+			"Slave already registered, reusing dev_num:%d\n",
+			slave->dev_num);
 
 	/* Clear the slave->dev_num to transfer message on device 0 */
 	dev_num = slave->dev_num;
-- 
2.17.1

