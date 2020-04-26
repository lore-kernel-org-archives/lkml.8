Return-Path: <SRS0=PEot=6K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7414C55191
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Apr 2020 02:15:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 85AAF2076C
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Apr 2020 02:15:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726139AbgDZCPK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 Apr 2020 22:15:10 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:2901 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726092AbgDZCPK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Apr 2020 22:15:10 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 235A67A0F8A595E4D0E7;
        Sun, 26 Apr 2020 10:15:07 +0800 (CST)
Received: from localhost.localdomain (10.69.192.56) by
 DGGEMS403-HUB.china.huawei.com (10.3.19.203) with Microsoft SMTP Server id
 14.3.487.0; Sun, 26 Apr 2020 10:14:59 +0800
From:   Huazhong Tan <tanhuazhong@huawei.com>
To:     <davem@davemloft.net>
CC:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <salil.mehta@huawei.com>, <yisen.zhuang@huawei.com>,
        <linuxarm@huawei.com>, <kuba@kernel.org>,
        Huazhong Tan <tanhuazhong@huawei.com>
Subject: [PATCH V2 net-next 0/9] net: hns3: refactor for MAC table
Date:   Sun, 26 Apr 2020 10:13:39 +0800
Message-ID: <1587867228-9955-1-git-send-email-tanhuazhong@huawei.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.56]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset refactors the MAC table management, configure
the MAC address asynchronously, instead of synchronously.
Base on this change, it also refines the handle of promisc
mode and filter table entries restoring after reset.

change logs:
V2: add patch #9 to remove an unnecessary NULL check suggested
    by Jakub Kicinski.

Huazhong Tan (1):
  net: hns3: remove an unnecessary check in hclge_set_umv_space()

Jian Shen (8):
  net: hns3: refine for unicast MAC VLAN space management
  net: hns3: remove unnecessary parameter 'is_alloc' in
    hclge_set_umv_space()
  net: hns3: replace num_req_vfs with num_alloc_vport in
    hclge_reset_umv_space()
  net: hns3: refactor the MAC address configure
  net: hns3: add support for dumping UC and MC MAC list
  net: hns3: refactor the promisc mode setting
  net: hns3: use mutex vport_lock instead of mutex umv_lock
  net: hns3: optimize the filter table entries handling when resetting

 drivers/net/ethernet/hisilicon/hns3/hclge_mbx.h    |   5 +
 drivers/net/ethernet/hisilicon/hns3/hnae3.h        |   8 +-
 drivers/net/ethernet/hisilicon/hns3/hns3_debugfs.c |   2 +
 drivers/net/ethernet/hisilicon/hns3/hns3_enet.c    | 152 +---
 drivers/net/ethernet/hisilicon/hns3/hns3_enet.h    |  10 +-
 drivers/net/ethernet/hisilicon/hns3/hns3_ethtool.c |   2 +-
 .../ethernet/hisilicon/hns3/hns3pf/hclge_debugfs.c |  51 ++
 .../ethernet/hisilicon/hns3/hns3pf/hclge_main.c    | 868 ++++++++++++++++-----
 .../ethernet/hisilicon/hns3/hns3pf/hclge_main.h    |  33 +-
 .../net/ethernet/hisilicon/hns3/hns3pf/hclge_mbx.c |  70 +-
 .../ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c  | 368 ++++++++-
 .../ethernet/hisilicon/hns3/hns3vf/hclgevf_main.h  |  26 +
 12 files changed, 1166 insertions(+), 429 deletions(-)

-- 
2.7.4

