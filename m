Return-Path: <SRS0=9JlO=3L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2052BC2D0DB
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 09:10:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E251F24655
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 09:10:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728992AbgAVJKT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jan 2020 04:10:19 -0500
Received: from mga12.intel.com ([192.55.52.136]:54325 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725911AbgAVJKS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jan 2020 04:10:18 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 22 Jan 2020 01:10:18 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,349,1574150400"; 
   d="scan'208";a="244990387"
Received: from unknown (HELO bong5-HP-Z440.png.intel.com) ([10.221.118.166])
  by orsmga002.jf.intel.com with ESMTP; 22 Jan 2020 01:10:14 -0800
From:   Ong Boon Leong <boon.leong.ong@intel.com>
To:     netdev@vger.kernel.org
Cc:     Tan Tee Min <tee.min.tan@intel.com>,
        Voon Weifeng <weifeng.voon@intel.com>,
        Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Alexandre TORGUE <alexandre.torgue@st.com>,
        Jose Abreu <Jose.Abreu@synopsys.com>,
        "David S . Miller" <davem@davemloft.net>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Joao Pinto <Joao.Pinto@synopsys.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH net v3 0/5] net: stmmac: general fixes for Ethernet functionality
Date:   Wed, 22 Jan 2020 17:09:31 +0800
Message-Id: <20200122090936.28555-1-boon.leong.ong@intel.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks to all feedbacks from community.

We updated the patch-series to below:-

1/5: It ensures that the real_num_rx|tx_queues are set in both driver
     probe() and resume(). So, move the netif_set_real_num_rx|tx_queues()
     into stmmac_hw_setup(). Added lock_acquired to allow to decide when
     to rtnl_lock() & rtnl_unlock() pair:-
     stmmac_open(): rtnl_lock() & rtnl_unlock() is not needed.
     stmmac_resume(): rtnl_lock() & rtnl_unlock() is needed.

2/5: It ensures that the previous value of GMAC_VLAN_TAG register is
     read first before for updating the register.

3/5: It ensures the GMAC IP v4.xx and above behaves correctly to:-
       ip link set <devname> multicast off|on

4/5: Added similar IFF_MULTICAST flag for xgmac2.

5/5: It ensures PCI platform data is using plat->phy_interface.

Rgds,
Boon Leong

Changes from v2:-
   patch 1/5 - added control for rtnl_lock() & rtnl_unlock() to ensure
               they are used forstmmac_resume()
   patch 4/5 - added IFF_MULTICAST flag check for xgmac to ensure
               multicast works correctly.

v1:-
 - Drop v1 patches (1/7, 3/7 & 4/7) that are not valid.

Aashish Verma (1):
  net: stmmac: Fix incorrect location to set real_num_rx|tx_queues

Tan, Tee Min (2):
  net: stmmac: fix incorrect GMAC_VLAN_TAG register writting in GMAC4+
  net: stmmac: xgmac: fix missing IFF_MULTICAST checki in
    dwxgmac2_set_filter

Verma, Aashish (1):
  net: stmmac: fix missing IFF_MULTICAST check in dwmac4_set_filter

Voon Weifeng (1):
  net: stmmac: update pci platform data to use phy_interface

 .../net/ethernet/stmicro/stmmac/dwmac4_core.c |  9 +++++----
 .../ethernet/stmicro/stmmac/dwxgmac2_core.c   |  2 +-
 .../net/ethernet/stmicro/stmmac/stmmac_main.c | 19 ++++++++++++-------
 .../net/ethernet/stmicro/stmmac/stmmac_pci.c  | 14 ++++++++------
 4 files changed, 26 insertions(+), 18 deletions(-)

-- 
2.17.1

