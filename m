Return-Path: <SRS0=MDzn=5V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9258FC2D0F4
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Apr 2020 10:41:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C09C20675
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Apr 2020 10:41:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726523AbgDEKl2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 Apr 2020 06:41:28 -0400
Received: from mga12.intel.com ([192.55.52.136]:4435 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726444AbgDEKl1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Apr 2020 06:41:27 -0400
IronPort-SDR: 7Gw9obn4uu/Jf+Z8Ad101wVPiKA8TKke8YY01swkUN5O2YtT9BtMUjinizHCgl6YYTVvA/h+uB
 B9tqwb5WX78Q==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Apr 2020 03:41:27 -0700
IronPort-SDR: TC0QQbWGILYXESrFkub+TzDtzSEHPZ+1bv18FpT7ZZIuPOY+aGMs8XdqASWsNYNHawWm8lrhRI
 yqEpYra/Kehw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,347,1580803200"; 
   d="scan'208";a="241526865"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by fmsmga007.fm.intel.com with ESMTP; 05 Apr 2020 03:41:25 -0700
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1jL2iT-000IoS-Ak; Sun, 05 Apr 2020 18:41:25 +0800
Date:   Sun, 5 Apr 2020 18:41:07 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Paolo Abeni <pabeni@redhat.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Matthieu Baerts <matthieu.baerts@tessares.net>,
        Mat Martineau <mathew.j.martineau@linux.intel.com>
Subject: net/mptcp/pm_netlink.c:98:22: warning: The scope of the variable
 'skc' can be reduced. [variableScope]
Message-ID: <202004051802.wQTCzw3s%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   4c205c84e249e0a91dcfabe461d77667ec9b2d05
commit: 01cacb00b35cb62b139f07d5f84bcf0eeda8eff6 mptcp: add netlink-based PM
date:   6 days ago

If you fix the issue, kindly add following tag as appropriate
Reported-by: kbuild test robot <lkp@intel.com>


cppcheck warnings: (new ones prefixed by >>)

>> net/mptcp/pm_netlink.c:98:22: warning: The scope of the variable 'skc' can be reduced. [variableScope]
>>  struct sock_common *skc;
                        ^

vim +/skc +98 net/mptcp/pm_netlink.c

    92	
    93	static bool lookup_subflow_by_saddr(const struct list_head *list,
    94					    struct mptcp_addr_info *saddr)
    95	{
    96		struct mptcp_subflow_context *subflow;
    97		struct mptcp_addr_info cur;
  > 98		struct sock_common *skc;
    99	
   100		list_for_each_entry(subflow, list, node) {
   101			skc = (struct sock_common *)mptcp_subflow_tcp_sock(subflow);
   102	
   103			local_address(skc, &cur);
   104			if (addresses_equal(&cur, saddr, false))
   105				return true;
   106		}
   107	
   108		return false;
   109	}
   110	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
