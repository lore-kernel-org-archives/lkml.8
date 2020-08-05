Return-Path: <SRS0=MXgo=BP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A230FC433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 20:02:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7950F2076E
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 20:02:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729134AbgHEUCh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Aug 2020 16:02:37 -0400
Received: from mga01.intel.com ([192.55.52.88]:56433 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728886AbgHEUC2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Aug 2020 16:02:28 -0400
IronPort-SDR: tEZgkUK8gJbEskp/5QggItYZZV9rmWw47wdKwUpSl4c6bgWw0wLfFJgqmFpJFl1yj/QSxznlHy
 dNTqgRO19FdA==
X-IronPort-AV: E=McAfee;i="6000,8403,9704"; a="170722104"
X-IronPort-AV: E=Sophos;i="5.75,438,1589266800"; 
   d="scan'208";a="170722104"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2020 13:02:26 -0700
IronPort-SDR: xT+qWi59QbK+7BF7WkCvMt7fUZANd2g064635Re20OBwvJyewGJ6veydrd5hRmKWa93WNgW/E+
 lsvyq5rX6wbg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,438,1589266800"; 
   d="scan'208";a="492940625"
Received: from lkp-server02.sh.intel.com (HELO 37a337f97289) ([10.239.97.151])
  by fmsmga006.fm.intel.com with ESMTP; 05 Aug 2020 13:02:25 -0700
Received: from kbuild by 37a337f97289 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1k3PcH-0000tu-1R; Wed, 05 Aug 2020 20:02:25 +0000
Date:   Thu, 6 Aug 2020 04:02:15 +0800
From:   kernel test robot <lkp@intel.com>
To:     Shannon Nelson <snelson@pensando.io>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: drivers/net/ethernet/pensando/ionic/ionic_ethtool.c:250:51: warning:
 Clarify calculation precedence for '&' and
Message-ID: <202008060413.VgrMuqLJ%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   2324d50d051ec0f14a548e78554fb02513d6dcef
commit: 4d03e00a21409f63668349ae4123f5707d9a28cf ionic: Add initial ethtool support
date:   11 months ago
compiler: ia64-linux-gcc (GCC) 9.3.0

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


cppcheck warnings: (new ones prefixed by >>)

>> drivers/net/ethernet/pensando/ionic/ionic_ethtool.c:250:51: warning: Clarify calculation precedence for '&' and '?'. [clarifyCalculation]
     pause->rx_pause = pause_type & IONIC_PAUSE_F_RX ? 1 : 0;
                                                     ^
   drivers/net/ethernet/pensando/ionic/ionic_ethtool.c:251:51: warning: Clarify calculation precedence for '&' and '?'. [clarifyCalculation]
     pause->tx_pause = pause_type & IONIC_PAUSE_F_TX ? 1 : 0;
                                                     ^
--
>> drivers/net/geneve.c:898:46: warning: Clarify calculation precedence for '&' and '?'. [clarifyCalculation]
     df = key->tun_flags & TUNNEL_DONT_FRAGMENT ? htons(IP_DF) : 0;
                                                ^

vim +250 drivers/net/ethernet/pensando/ionic/ionic_ethtool.c

   239	
   240	static void ionic_get_pauseparam(struct net_device *netdev,
   241					 struct ethtool_pauseparam *pause)
   242	{
   243		struct ionic_lif *lif = netdev_priv(netdev);
   244		u8 pause_type;
   245	
   246		pause->autoneg = 0;
   247	
   248		pause_type = lif->ionic->idev.port_info->config.pause_type;
   249		if (pause_type) {
 > 250			pause->rx_pause = pause_type & IONIC_PAUSE_F_RX ? 1 : 0;
   251			pause->tx_pause = pause_type & IONIC_PAUSE_F_TX ? 1 : 0;
   252		}
   253	}
   254	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
