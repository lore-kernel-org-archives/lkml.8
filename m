Return-Path: <SRS0=/Won=67=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0450C433DF
	for <linux-kernel@archiver.kernel.org>; Sun, 17 May 2020 20:22:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A61912065F
	for <linux-kernel@archiver.kernel.org>; Sun, 17 May 2020 20:22:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726633AbgEQUWg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 May 2020 16:22:36 -0400
Received: from mga17.intel.com ([192.55.52.151]:39256 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726271AbgEQUWf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 May 2020 16:22:35 -0400
IronPort-SDR: +haE7v44fJAcN94mI8/ao6xivGuwZ1Zse9nZV83JmF+9C1PYnRTQ2Io79aUwtAZwby4Tm1ZoX+
 F2QVSkuLQdPg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2020 13:22:35 -0700
IronPort-SDR: 9aek+GDFWBwb8l4OXELI/9r9yhBrUbn4+pYxpO1CvikuvJ8L8nFuQZ67TNsbg/51Udj6JLkdFI
 /OV/yg8zHqag==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,404,1583222400"; 
   d="scan'208";a="263753551"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 17 May 2020 13:22:33 -0700
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1jaPns-00063p-Or; Mon, 18 May 2020 04:22:32 +0800
Date:   Mon, 18 May 2020 04:22:16 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Pascal Terjan <pterjan@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Cc:     kbuild-all@lists.01.org, Pascal Terjan <pterjan@google.com>
Subject: [RFC PATCH] staging: rtl8192u: indicate_packets() can be static
Message-ID: <20200517202216.GA24634@8c544063f25c>
References: <20200517165819.136715-1-pterjan@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200517165819.136715-1-pterjan@google.com>
X-Patchwork-Hint: ignore
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Signed-off-by: kbuild test robot <lkp@intel.com>
---
 ieee80211_rx.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/rtl8192u/ieee80211/ieee80211_rx.c b/drivers/staging/rtl8192u/ieee80211/ieee80211_rx.c
index 3309f64be4c94..bceff1ba3d7d4 100644
--- a/drivers/staging/rtl8192u/ieee80211/ieee80211_rx.c
+++ b/drivers/staging/rtl8192u/ieee80211/ieee80211_rx.c
@@ -520,7 +520,7 @@ static bool AddReorderEntry(struct rx_ts_record *pTS, struct rx_reorder_entry *p
 	return true;
 }
 
-void indicate_packets(struct ieee80211_device *ieee, struct ieee80211_rxb *rxb)
+static void indicate_packets(struct ieee80211_device *ieee, struct ieee80211_rxb *rxb)
 {
 	struct net_device_stats *stats = &ieee->stats;
 	struct net_device *dev = ieee->dev;
