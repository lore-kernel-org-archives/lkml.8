Return-Path: <SRS0=Xzqw=5F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4EBCC4332D
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 16:48:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BFD2020753
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 16:48:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727650AbgCTQsa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Mar 2020 12:48:30 -0400
Received: from mga05.intel.com ([192.55.52.43]:37380 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726983AbgCTQsa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Mar 2020 12:48:30 -0400
IronPort-SDR: mB3BmLr0gEiLfbpT8BfLyvShrJKimjq06CqpwRBDEjFL94z5QxbDUhF5J4hHxE5eAZR81PUM41
 O4x9M1JNnWKA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2020 09:48:29 -0700
IronPort-SDR: z9boVLIcpzv8r02bL/Lm/UIhDgXaPYRwjJ9mAow0Fa8/8iiF/cv/9rhbAAXOYK9fgaP6e7U5rm
 /wDE7wM2pMkw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,285,1580803200"; 
   d="scan'208";a="239275155"
Received: from unknown (HELO climb.png.intel.com) ([10.221.118.165])
  by orsmga008.jf.intel.com with ESMTP; 20 Mar 2020 09:48:26 -0700
From:   Voon Weifeng <weifeng.voon@intel.com>
To:     "David S . Miller" <davem@davemloft.net>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jose Abreu <joabreu@synopsys.com>,
        Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Ong Boon Leong <boon.leong.ong@intel.com>,
        Voon Weifeng <weifeng.voon@intel.com>
Subject: [net-next,v1, 0/3] Add additional EHL PCI info and PCI ID
Date:   Sat, 21 Mar 2020 00:48:22 +0800
Message-Id: <20200320164825.14200-1-weifeng.voon@intel.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Intel EHL consist of 3 identical MAC. 2 are located in the Intel(R)
Programmable Services Engine (Intel(R) PSE) and 1 is located in the
platform Controller Hub (PCH). Each MAC consist of 3 PCI IDs which are
differentiated by MII and speed.

Voon Weifeng (3):
  net: stmmac: add EHL PSE0 & PSE1 1Gbps PCI info and PCI ID
  net: stmmac: add EHL PSE0 & PSE1 2.5Gbps PCI info and PCI ID
  net: stmmac: add EHL SGMII 2.5Gbps PCI info and PCI ID

 .../net/ethernet/stmicro/stmmac/stmmac_pci.c  | 92 +++++++++++++++++--
 1 file changed, 86 insertions(+), 6 deletions(-)

-- 
2.17.1

