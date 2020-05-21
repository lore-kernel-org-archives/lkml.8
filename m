Return-Path: <SRS0=7UTg=7D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67D9DC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 11:39:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3306F207FB
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 11:39:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729060AbgEULjw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 May 2020 07:39:52 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:38052 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728348AbgEULjw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 May 2020 07:39:52 -0400
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id B028071144CF9A1710A5;
        Thu, 21 May 2020 19:39:49 +0800 (CST)
Received: from localhost.localdomain (10.69.192.56) by
 DGGEMS409-HUB.china.huawei.com (10.3.19.209) with Microsoft SMTP Server id
 14.3.487.0; Thu, 21 May 2020 19:39:43 +0800
From:   Huazhong Tan <tanhuazhong@huawei.com>
To:     <davem@davemloft.net>
CC:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <salil.mehta@huawei.com>, <yisen.zhuang@huawei.com>,
        <linuxarm@huawei.com>, <kuba@kernel.org>,
        Huazhong Tan <tanhuazhong@huawei.com>
Subject: [PATCH V2 net-next 0/2] net: hns3: adds two VLAN feature
Date:   Thu, 21 May 2020 19:38:23 +0800
Message-ID: <1590061105-36478-1-git-send-email-tanhuazhong@huawei.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.56]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset adds two new VLAN feature.

[patch 1] adds a new dynamic VLAN mode.
[patch 2] adds support for 'QoS' field to PVID.

Change log:
V1->V2: modifies [patch 1]'s commit log, suggested by Jakub Kicinski.

GuoJia Liao (2):
  net: hns3: adds support for dynamic VLAN mode
  net: hns3: add support for 'QoS' in port based VLAN configuration

 drivers/net/ethernet/hisilicon/hns3/hnae3.h        |   5 +-
 drivers/net/ethernet/hisilicon/hns3/hns3_enet.c    |   3 +
 drivers/net/ethernet/hisilicon/hns3/hns3_ethtool.c |   6 +-
 .../net/ethernet/hisilicon/hns3/hns3pf/hclge_cmd.h |   2 +
 .../ethernet/hisilicon/hns3/hns3pf/hclge_main.c    | 151 ++++++++++++++++-----
 .../ethernet/hisilicon/hns3/hns3pf/hclge_main.h    |  25 +++-
 .../net/ethernet/hisilicon/hns3/hns3pf/hclge_mbx.c |  10 +-
 7 files changed, 155 insertions(+), 47 deletions(-)

-- 
2.7.4

