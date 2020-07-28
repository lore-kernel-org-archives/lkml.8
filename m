Return-Path: <SRS0=jZ1s=BH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94ECAC433EC
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 02:19:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7C5E220759
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 02:19:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726842AbgG1CTR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jul 2020 22:19:17 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:8283 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726237AbgG1CTL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 22:19:11 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 73847B108A1A53138FF3;
        Tue, 28 Jul 2020 10:19:07 +0800 (CST)
Received: from localhost.localdomain (10.69.192.56) by
 DGGEMS408-HUB.china.huawei.com (10.3.19.208) with Microsoft SMTP Server id
 14.3.487.0; Tue, 28 Jul 2020 10:18:59 +0800
From:   Huazhong Tan <tanhuazhong@huawei.com>
To:     <davem@davemloft.net>
CC:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <salil.mehta@huawei.com>, <yisen.zhuang@huawei.com>,
        <linuxarm@huawei.com>, <kuba@kernel.org>,
        Huazhong Tan <tanhuazhong@huawei.com>
Subject: [PATCH net 0/5] net: hns3: fixes for -net
Date:   Tue, 28 Jul 2020 10:16:47 +0800
Message-ID: <1595902612-12880-1-git-send-email-tanhuazhong@huawei.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.56]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are some bugfixes for the HNS3 ethernet driver. patch#1 fixes
a desc filling bug, patch#2 fixes a false TX timeout issue, and
patch#3~#5 fixes some bugs related to VLAN and FD.

Guojia Liao (2):
  net: hns3: fix aRFS FD rules leftover after add a user FD rule
  net: hns3: fix for VLAN config when reset failed

Jian Shen (1):
  net: hns3: add reset check for VF updating port based VLAN

Yonglong Liu (1):
  net: hns3: fix a TX timeout issue

Yunsheng Lin (1):
  net: hns3: fix desc filling bug when skb is expanded or lineared

 drivers/net/ethernet/hisilicon/hns3/hns3_enet.c    | 18 ++++------
 .../ethernet/hisilicon/hns3/hns3pf/hclge_main.c    | 35 +++++++++++---------
 .../ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c  | 38 +++++++++++++++-------
 3 files changed, 52 insertions(+), 39 deletions(-)

-- 
2.7.4

