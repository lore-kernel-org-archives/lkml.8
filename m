Return-Path: <SRS0=mfLo=CD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4B2FC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 18:38:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B264A2071E
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 18:38:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726645AbgHYSiT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Aug 2020 14:38:19 -0400
Received: from mga04.intel.com ([192.55.52.120]:52293 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726090AbgHYSiQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Aug 2020 14:38:16 -0400
IronPort-SDR: CfPNwrok0nwSxAjIteCd6J/21qTPN44o7CrFYQg6fzGXuUbWk4yFi/IAGMuEkA8p1eLavw0QgB
 Mx56g6uP+UHQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9723"; a="153603578"
X-IronPort-AV: E=Sophos;i="5.76,353,1592895600"; 
   d="scan'208";a="153603578"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2020 11:38:15 -0700
IronPort-SDR: WWIglTRktSXpx/rfkQrAS7OJmEHKlmSz5JAXPIKV/CrgqeVLFIZUr2MkwYHpQhPA26M4J/nfrX
 z4Sbx3AEy7/w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,353,1592895600"; 
   d="scan'208";a="322863924"
Received: from amritabi-mobl1.gar.corp.intel.com (HELO amaramad-DESK.gar.corp.intel.com) ([10.213.78.183])
  by fmsmga004.fm.intel.com with ESMTP; 25 Aug 2020 11:38:13 -0700
From:   Madhusudanarao Amara <madhusudanarao.amara@intel.com>
To:     heikki.krogerus@intel.com, gregkh@linuxfoundation.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     madhusudanarao.amara@intel.com
Subject: [PATCH] usb: typec: intel_pmc_mux: Un-register the USB role switch
Date:   Wed, 26 Aug 2020 00:08:11 +0530
Message-Id: <20200825183811.7262-1-madhusudanarao.amara@intel.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Added missing code for un-register USB role switch in the remove and
error path.

Cc: Stable <stable@vger.kernel.org> # v5.8
Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Fixes: 6701adfa9693b ("usb: typec: driver for Intel PMC mux control")
Signed-off-by: Madhusudanarao Amara <madhusudanarao.amara@intel.com>
---
 drivers/usb/typec/mux/intel_pmc_mux.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/usb/typec/mux/intel_pmc_mux.c b/drivers/usb/typec/mux/intel_pmc_mux.c
index e4021e13af40..fd9008f19208 100644
--- a/drivers/usb/typec/mux/intel_pmc_mux.c
+++ b/drivers/usb/typec/mux/intel_pmc_mux.c
@@ -497,6 +497,7 @@ static int pmc_usb_probe(struct platform_device *pdev)
 	for (i = 0; i < pmc->num_ports; i++) {
 		typec_switch_unregister(pmc->port[i].typec_sw);
 		typec_mux_unregister(pmc->port[i].typec_mux);
+		usb_role_switch_unregister(pmc->port[i].usb_sw);
 	}
 
 	return ret;
@@ -510,6 +511,7 @@ static int pmc_usb_remove(struct platform_device *pdev)
 	for (i = 0; i < pmc->num_ports; i++) {
 		typec_switch_unregister(pmc->port[i].typec_sw);
 		typec_mux_unregister(pmc->port[i].typec_mux);
+		usb_role_switch_unregister(pmc->port[i].usb_sw);
 	}
 
 	return 0;
-- 
2.17.1

