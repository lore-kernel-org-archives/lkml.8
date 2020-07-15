Return-Path: <SRS0=kup7=A2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC284C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 16:55:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AF423206F4
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 16:55:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726661AbgGOQzj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jul 2020 12:55:39 -0400
Received: from mga06.intel.com ([134.134.136.31]:11291 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726398AbgGOQzi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jul 2020 12:55:38 -0400
IronPort-SDR: JQVSSCdXJz8jJ+sz4xq8uADUXECZa5JVlR8+/zpGDk6PS+fLKXvc8XVRfWymY0wDPbMgDbpIBg
 LkU/gbcn+bbg==
X-IronPort-AV: E=McAfee;i="6000,8403,9683"; a="210739342"
X-IronPort-AV: E=Sophos;i="5.75,355,1589266800"; 
   d="scan'208";a="210739342"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2020 09:55:37 -0700
IronPort-SDR: rkodu1XP7wuy8dfyVNQJEuNahLyq+9htGYJkoVrhNOfDjjKvoCstQOxLeh8qkedwgCfd1nMWKJ
 Ug0fHuHHx09A==
X-IronPort-AV: E=Sophos;i="5.75,355,1589266800"; 
   d="scan'208";a="430192750"
Received: from bellalan-mobl2.ger.corp.intel.com (HELO dalessan-mobl1.ir.intel.com) ([10.251.85.12])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2020 09:55:34 -0700
From:   Daniele Alessandrelli <daniele.alessandrelli@linux.intel.com>
To:     Sudeep Holla <sudeep.holla@arm.com>,
        linux-arm-kernel@lists.infradead.org
Cc:     Daniele Alessandrelli <daniele.alessandrelli@intel.com>,
        Peng Fan <peng.fan@nxp.com>,
        "Paul J. Murphy" <paul.j.murphy@linux.intel.com>,
        "Paul J. Murphy" <paul.j.murphy@intel.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] firmware: arm_scmi: Pass shmem address to SMCCC call
Date:   Wed, 15 Jul 2020 17:55:18 +0100
Message-Id: <20200715165518.57558-1-daniele.alessandrelli@linux.intel.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Daniele Alessandrelli <daniele.alessandrelli@intel.com>

Currently, when SMC/HVC is used as transport, the base address of the
shared memory used for communication is not passed to the SMCCC call.
This means that such an address must be hard-coded into the bootloader.

In order to increase flexibility and allow the memory layout to be
changed without modifying the bootloader, this patch adds the shared
memory base address to the a1 argument of the SMCCC call.

On the Secure Monitor side, the service call implementation can
therefore read the a1 argument in order to know the location of the
shared memory to use. This change is backward compatible to existing
service call implementations as long as they don't check for a1 to be
zero.

Signed-off-by: Daniele Alessandrelli <daniele.alessandrelli@intel.com>
Signed-off-by: Paul J. Murphy <paul.j.murphy@intel.com>
---
 drivers/firmware/arm_scmi/smc.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/firmware/arm_scmi/smc.c b/drivers/firmware/arm_scmi/smc.c
index 49bc4b0e8428..aef3a58f8266 100644
--- a/drivers/firmware/arm_scmi/smc.c
+++ b/drivers/firmware/arm_scmi/smc.c
@@ -21,12 +21,14 @@
  *
  * @cinfo: SCMI channel info
  * @shmem: Transmit/Receive shared memory area
+ * @shmem_paddr: Physical address of shmem
  * @func_id: smc/hvc call function id
  */
 
 struct scmi_smc {
 	struct scmi_chan_info *cinfo;
 	struct scmi_shared_mem __iomem *shmem;
+	resource_size_t shmem_paddr;
 	struct mutex shmem_lock;
 	u32 func_id;
 };
@@ -73,6 +75,7 @@ static int smc_chan_setup(struct scmi_chan_info *cinfo, struct device *dev,
 		dev_err(dev, "failed to ioremap SCMI Tx shared memory\n");
 		return -EADDRNOTAVAIL;
 	}
+	scmi_info->shmem_paddr = res.start;
 
 	ret = of_property_read_u32(dev->of_node, "arm,smc-id", &func_id);
 	if (ret < 0)
@@ -109,7 +112,8 @@ static int smc_send_message(struct scmi_chan_info *cinfo,
 
 	shmem_tx_prepare(scmi_info->shmem, xfer);
 
-	arm_smccc_1_1_invoke(scmi_info->func_id, 0, 0, 0, 0, 0, 0, 0, &res);
+	arm_smccc_1_1_invoke(scmi_info->func_id, scmi_info->shmem_paddr, 0, 0,
+			     0, 0, 0, 0, &res);
 	scmi_rx_callback(scmi_info->cinfo, shmem_read_header(scmi_info->shmem));
 
 	mutex_unlock(&scmi_info->shmem_lock);
-- 
2.26.2

