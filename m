Return-Path: <SRS0=ZTvs=4H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3149C3404C
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 01:24:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80F6A24682
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 01:24:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728121AbgBSBYV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Feb 2020 20:24:21 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:10209 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727940AbgBSBYN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Feb 2020 20:24:13 -0500
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 9FAEE2C74B945B3103F0;
        Wed, 19 Feb 2020 09:24:07 +0800 (CST)
Received: from localhost.localdomain (10.69.192.56) by
 DGGEMS407-HUB.china.huawei.com (10.3.19.207) with Microsoft SMTP Server id
 14.3.439.0; Wed, 19 Feb 2020 09:23:59 +0800
From:   Huazhong Tan <tanhuazhong@huawei.com>
To:     <davem@davemloft.net>
CC:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <salil.mehta@huawei.com>, <yisen.zhuang@huawei.com>,
        <linuxarm@huawei.com>, <kuba@kernel.org>,
        Huazhong Tan <tanhuazhong@huawei.com>
Subject: [PATCH net-next 0/4] net: hns3: misc updates for -net-next
Date:   Wed, 19 Feb 2020 09:23:29 +0800
Message-ID: <1582075413-34966-1-git-send-email-tanhuazhong@huawei.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.56]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series includes some misc updates for the HNS3
ethernet driver.

[patch 1] modifies an unsuitable print when setting dulex mode.
[patch 2] adds some debugfs info for TC and DWRR.
[patch 3] adds some debugfs info for loopback.
[patch 4] adds a missing help info for QS shaper in debugfs.

Guangbin Huang (1):
  net: hns3: modify an unsuitable print when setting unknown duplex to
    fibre

Yonglong Liu (2):
  net: hns3: add enabled TC numbers and DWRR weight info in debugfs
  net: hns3: add missing help info for QS shaper in debugfs

Yufeng Mo (1):
  net: hns3: add support for dump MAC ID and loopback status in debugfs

 drivers/net/ethernet/hisilicon/hns3/hns3_debugfs.c |  2 +
 drivers/net/ethernet/hisilicon/hns3/hns3_ethtool.c |  2 +-
 .../ethernet/hisilicon/hns3/hns3pf/hclge_debugfs.c | 63 ++++++++++++++++++++--
 .../ethernet/hisilicon/hns3/hns3pf/hclge_main.c    |  3 ++
 .../ethernet/hisilicon/hns3/hns3pf/hclge_main.h    |  1 +
 5 files changed, 67 insertions(+), 4 deletions(-)

-- 
2.7.4

