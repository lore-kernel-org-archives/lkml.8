Return-Path: <SRS0=ltrd=5B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DATE_IN_PAST_06_12,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49617C0044D
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 08:40:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 237D920658
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 08:40:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730210AbgCPIke (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Mar 2020 04:40:34 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:60422 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730048AbgCPIkd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Mar 2020 04:40:33 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 4D83AD535B3E8090DE8B;
        Mon, 16 Mar 2020 16:40:29 +0800 (CST)
Received: from localhost.localdomain (10.175.34.53) by
 DGGEMS411-HUB.china.huawei.com (10.3.19.211) with Microsoft SMTP Server id
 14.3.487.0; Mon, 16 Mar 2020 16:40:20 +0800
From:   Luo bin <luobin9@huawei.com>
To:     <davem@davemloft.net>
CC:     <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        <aviad.krawczyk@huawei.com>, <luoxianjun@huawei.com>,
        <cloud.wangxiaoyun@huawei.com>, <yin.yinshi@huawei.com>
Subject: [PATCH net 0/6] hinic: BugFixes
Date:   Mon, 16 Mar 2020 00:56:24 +0000
Message-ID: <20200316005630.9817-1-luobin9@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.34.53]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix a number of bugs which have been present since the first commit.

The bugs fixed in these patchs are hardly exposed unless given
very specific conditions.

Luo bin (6):
  hinic: fix process of long length skb without frags
  hinic: fix a bug of waitting for IO stopped
  hinic: fix the bug of clearing event queue
  hinic: fix out-of-order excution in arm cpu
  hinic: fix wrong para of wait_for_completion_timeout
  hinic: fix wrong value of MIN_SKB_LEN

 .../net/ethernet/huawei/hinic/hinic_ethtool.c |  1 +
 .../net/ethernet/huawei/hinic/hinic_hw_cmdq.c |  5 +-
 .../net/ethernet/huawei/hinic/hinic_hw_dev.c  | 51 +------------------
 .../net/ethernet/huawei/hinic/hinic_hw_eqs.c  | 27 +++++++---
 .../net/ethernet/huawei/hinic/hinic_hw_mgmt.c |  5 +-
 .../net/ethernet/huawei/hinic/hinic_main.c    |  1 +
 drivers/net/ethernet/huawei/hinic/hinic_rx.c  |  3 ++
 drivers/net/ethernet/huawei/hinic/hinic_tx.c  | 15 ++++--
 drivers/net/ethernet/huawei/hinic/hinic_tx.h  |  2 +-
 9 files changed, 46 insertions(+), 64 deletions(-)

-- 
2.17.1

