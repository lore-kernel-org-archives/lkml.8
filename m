Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39AF2C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 20:21:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0FB7B2080C
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 20:21:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592943684;
	bh=HbkcnfYS5vY5kTL73icnaMVAYX8HaETTBgU2/mpIdTQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=WiybEHWPj4WX5cqDAD2hyQQ/JzblbEgxcIhhn25A4PB8/HyFtvo5z1ZNk9wPOdQwb
	 TqcBgEa6gt0yTvienDPsvfXt57NRTYYAOGaSUKrndV5x3rjqmtm7PwBaXg3xSPNSuN
	 i1lNtZ0HqVWuTl+aRvZvkim0kD2i4V1FfESxa5z8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388707AbgFWUVU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 16:21:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:38774 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389469AbgFWUVK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 16:21:10 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E6FE92064B;
        Tue, 23 Jun 2020 20:21:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592943670;
        bh=HbkcnfYS5vY5kTL73icnaMVAYX8HaETTBgU2/mpIdTQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iNB4dXhDlbvk/GFyzGG0gPm1CuomglEGZXimOxK/tpzgJXpMEr6Y1N4TX84mISWus
         60qJFk61y52pA8eqnsWO+zSlWBf4CyI/om80iGV7OucXDvZprTMPtHS3VtY0fAurGr
         3r9jz3+9W3/RQdx0WqfGFBbtSiggfX+lOQuClN18=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Stable@vger.kernel.org, Chen Yu <yu.c.chen@intel.com>,
        Aaron Brown <aaron.f.brown@intel.com>,
        Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Subject: [PATCH 5.7 474/477] e1000e: Do not wake up the system via WOL if device wakeup is disabled
Date:   Tue, 23 Jun 2020 21:57:51 +0200
Message-Id: <20200623195429.952991404@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200623195407.572062007@linuxfoundation.org>
References: <20200623195407.572062007@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chen Yu <yu.c.chen@intel.com>

commit 6bf6be1127f7e6d4bf39f84d56854e944d045d74 upstream.

Currently the system will be woken up via WOL(Wake On LAN) even if the
device wakeup ability has been disabled via sysfs:
 cat /sys/devices/pci0000:00/0000:00:1f.6/power/wakeup
 disabled

The system should not be woken up if the user has explicitly
disabled the wake up ability for this device.

This patch clears the WOL ability of this network device if the
user has disabled the wake up ability in sysfs.

Fixes: bc7f75fa9788 ("[E1000E]: New pci-express e1000 driver")
Reported-by: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: <Stable@vger.kernel.org>
Signed-off-by: Chen Yu <yu.c.chen@intel.com>
Tested-by: Aaron Brown <aaron.f.brown@intel.com>
Signed-off-by: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/net/ethernet/intel/e1000e/netdev.c |   14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

--- a/drivers/net/ethernet/intel/e1000e/netdev.c
+++ b/drivers/net/ethernet/intel/e1000e/netdev.c
@@ -6518,11 +6518,17 @@ static int __e1000_shutdown(struct pci_d
 	struct net_device *netdev = pci_get_drvdata(pdev);
 	struct e1000_adapter *adapter = netdev_priv(netdev);
 	struct e1000_hw *hw = &adapter->hw;
-	u32 ctrl, ctrl_ext, rctl, status;
-	/* Runtime suspend should only enable wakeup for link changes */
-	u32 wufc = runtime ? E1000_WUFC_LNKC : adapter->wol;
+	u32 ctrl, ctrl_ext, rctl, status, wufc;
 	int retval = 0;
 
+	/* Runtime suspend should only enable wakeup for link changes */
+	if (runtime)
+		wufc = E1000_WUFC_LNKC;
+	else if (device_may_wakeup(&pdev->dev))
+		wufc = adapter->wol;
+	else
+		wufc = 0;
+
 	status = er32(STATUS);
 	if (status & E1000_STATUS_LU)
 		wufc &= ~E1000_WUFC_LNKC;
@@ -6579,7 +6585,7 @@ static int __e1000_shutdown(struct pci_d
 	if (adapter->hw.phy.type == e1000_phy_igp_3) {
 		e1000e_igp3_phy_powerdown_workaround_ich8lan(&adapter->hw);
 	} else if (hw->mac.type >= e1000_pch_lpt) {
-		if (!(wufc & (E1000_WUFC_EX | E1000_WUFC_MC | E1000_WUFC_BC)))
+		if (wufc && !(wufc & (E1000_WUFC_EX | E1000_WUFC_MC | E1000_WUFC_BC)))
 			/* ULP does not support wake from unicast, multicast
 			 * or broadcast.
 			 */


