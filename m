Return-Path: <SRS0=7UTg=7D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EB41C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 17:58:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 137E520759
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 17:58:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729213AbgEUR6P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 May 2020 13:58:15 -0400
Received: from mga03.intel.com ([134.134.136.65]:63550 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727883AbgEUR6P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 May 2020 13:58:15 -0400
IronPort-SDR: gwicssT2ogRWISmDQEqF27Bq37+dNKBNRvn17BPFIrv2x81JSSpaQz/DJui/Ixp1F9xQfBdPkD
 JveBl22+ZIBg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2020 10:58:14 -0700
IronPort-SDR: TcfMhpGw3LfGf0eahhdlMV9ev/8N/Xltjf0NJSvAFjXaminb+VNw5h8b/ssbIBAipk9ek+wVFH
 lAWktAqTPb0g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,418,1583222400"; 
   d="scan'208";a="254058362"
Received: from chenyu-office.sh.intel.com ([10.239.158.173])
  by orsmga007.jf.intel.com with ESMTP; 21 May 2020 10:58:11 -0700
From:   Chen Yu <yu.c.chen@intel.com>
To:     Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Auke Kok <auke-jan.h.kok@intel.com>,
        Jeff Garzik <jeff@garzik.org>
Cc:     intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Len Brown <len.brown@intel.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        "Shevchenko, Andriy" <andriy.shevchenko@intel.com>,
        "Neftin, Sasha" <sasha.neftin@intel.com>,
        "Lifshits, Vitaly" <vitaly.lifshits@intel.com>,
        Chen Yu <yu.c.chen@intel.com>
Subject: [PATCH 0/2] Make WOL of e1000e consistent with sysfs device wakeup
Date:   Fri, 22 May 2020 01:58:02 +0800
Message-Id: <cover.1590081982.git.yu.c.chen@intel.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently the WOL(Wake On Lan) bahavior of e1000e is not consistent with its corresponding
device wake up ability.
Fix this by:
1. Do not wake up the system via WOL if device wakeup is disabled
2. Make WOL display info from ethtool consistent with device wake up
   settings in sysfs

Chen Yu (2):
  e1000e: Do not wake up the system via WOL if device wakeup is disabled
  e1000e: Make WOL info in ethtool consistent with device wake up
    ability

 drivers/net/ethernet/intel/e1000e/ethtool.c |  2 +-
 drivers/net/ethernet/intel/e1000e/netdev.c  | 14 ++++++++++----
 2 files changed, 11 insertions(+), 5 deletions(-)

-- 
2.17.1

