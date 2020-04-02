Return-Path: <SRS0=iZC5=5S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 269A2C2BA12
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 06:52:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 07F2220784
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 06:52:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729384AbgDBGwu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Apr 2020 02:52:50 -0400
Received: from mga12.intel.com ([192.55.52.136]:1100 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729030AbgDBGwt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Apr 2020 02:52:49 -0400
IronPort-SDR: iIWWncgCWDz1euOZGxikixw7SxpYVeG8NbWwiQ4ozWFQjhHw8IlsT6/VWenQNT1EY1bDbG/LRc
 b2byp4lAEloA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2020 23:52:49 -0700
IronPort-SDR: evd6HV31MgdXqd7895E10ZsYdinXTTOGytf6a+z+5+enrwiRgI6QIB+o3KQr/CeoZ4vVV6crkG
 ZEMjcvqzUTCQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,334,1580803200"; 
   d="scan'208";a="238430670"
Received: from yanchun1-mobl2.ccr.corp.intel.com (HELO lkp-boy.ccr.corp.intel.com) ([10.255.31.3])
  by orsmga007.jf.intel.com with ESMTP; 01 Apr 2020 23:52:47 -0700
From:   Li Zhijian <zhijianx.li@intel.com>
To:     shuah@kernel.org, linux-kselftest@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, matthieu.baerts@tessares.net,
        Li Zhijian <lizhijian@cn.fujitsu.com>
Subject: [PATCH] selftests:mptcp: fix empty optstring
Date:   Thu,  2 Apr 2020 14:52:16 +0800
Message-Id: <20200402065216.23301-1-zhijianx.li@intel.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Li Zhijian <lizhijian@cn.fujitsu.com>

Signed-off-by: Li Zhijian <lizhijian@cn.fujitsu.com>
---
 tools/testing/selftests/net/mptcp/pm_netlink.sh | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/pm_netlink.sh b/tools/testing/selftests/net/mptcp/pm_netlink.sh
index 9172746b6cf0..8c7998c64d9e 100755
--- a/tools/testing/selftests/net/mptcp/pm_netlink.sh
+++ b/tools/testing/selftests/net/mptcp/pm_netlink.sh
@@ -8,8 +8,7 @@ usage() {
 	echo "Usage: $0 [ -h ]"
 }
 
-
-while getopts "$optstring" option;do
+while getopts "h" option;do
 	case "$option" in
 	"h")
 		usage $0
-- 
2.17.1

