Return-Path: <SRS0=2JZx=64=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1C39C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 12:43:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C90272065D
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 12:43:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727086AbgENMnD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 May 2020 08:43:03 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:59336 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726156AbgENMnB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 May 2020 08:43:01 -0400
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 1A91247670AB65287396;
        Thu, 14 May 2020 20:42:58 +0800 (CST)
Received: from localhost.localdomain (10.69.192.56) by
 DGGEMS402-HUB.china.huawei.com (10.3.19.202) with Microsoft SMTP Server id
 14.3.487.0; Thu, 14 May 2020 20:42:49 +0800
From:   Huazhong Tan <tanhuazhong@huawei.com>
To:     <davem@davemloft.net>
CC:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <salil.mehta@huawei.com>, <yisen.zhuang@huawei.com>,
        <linuxarm@huawei.com>, <kuba@kernel.org>,
        Huazhong Tan <tanhuazhong@huawei.com>
Subject: [PATCH net-next 0/5] net: hns3: add some cleanups for -next
Date:   Thu, 14 May 2020 20:41:21 +0800
Message-ID: <1589460086-61130-1-git-send-email-tanhuazhong@huawei.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.56]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset adds some cleanups for the HNS3 ethernet driver.

Huazhong Tan (5):
  net: hns3: modify some incorrect spelling
  net: hns3: remove a duplicated printing in hclge_configure()
  net: hns3: modify an incorrect error log in hclge_mbx_handler()
  net: hns3: remove some unused macros
  net: hns3: remove unnecessary frag list checking in
    hns3_nic_net_xmit()

 drivers/net/ethernet/hisilicon/hns3/hclge_mbx.h         |  2 +-
 drivers/net/ethernet/hisilicon/hns3/hns3_enet.c         |  5 +----
 drivers/net/ethernet/hisilicon/hns3/hns3_enet.h         | 17 -----------------
 .../net/ethernet/hisilicon/hns3/hns3pf/hclge_debugfs.c  | 14 +++++++-------
 drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c |  4 +---
 drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_mbx.c  |  2 +-
 6 files changed, 11 insertions(+), 33 deletions(-)

-- 
2.7.4

