Return-Path: <SRS0=Fjb+=5D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDF29C5ACD7
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 03:58:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0B0320753
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 03:58:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727316AbgCRD6C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Mar 2020 23:58:02 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:58044 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726553AbgCRD57 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Mar 2020 23:57:59 -0400
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 570E46E38FFF20C2D751;
        Wed, 18 Mar 2020 11:57:52 +0800 (CST)
Received: from localhost.localdomain (10.69.192.56) by
 DGGEMS409-HUB.china.huawei.com (10.3.19.209) with Microsoft SMTP Server id
 14.3.487.0; Wed, 18 Mar 2020 11:57:41 +0800
From:   Huazhong Tan <tanhuazhong@huawei.com>
To:     <davem@davemloft.net>
CC:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <salil.mehta@huawei.com>, <yisen.zhuang@huawei.com>,
        <linuxarm@huawei.com>, <kuba@kernel.org>,
        Huazhong Tan <tanhuazhong@huawei.com>
Subject: [PATCH net-next 0/3] net: hns3: add three optimizations for mailbox handling
Date:   Wed, 18 Mar 2020 11:57:04 +0800
Message-ID: <1584503827-12025-1-git-send-email-tanhuazhong@huawei.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.56]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset includes three code optimizations for mailbox handling.

[patch 1] adds a response code conversion.
[patch 2] refactors some structure definitions about PF and
VF mailbox.
[patch 3] refactors the condition whether PF responds VF's mailbox.

Huazhong Tan (1):
  net: hns3: refactor mailbox response scheme between PF and VF

Jian Shen (1):
  net: hns3: add a conversion for mailbox's response code

Yufeng Mo (1):
  net: hns3: refactor the mailbox message between PF and VF

 drivers/net/ethernet/hisilicon/hns3/hclge_mbx.h    |  54 ++-
 .../net/ethernet/hisilicon/hns3/hns3pf/hclge_mbx.c | 387 ++++++++++-----------
 .../ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c  | 311 +++++++++--------
 .../ethernet/hisilicon/hns3/hns3vf/hclgevf_main.h  |   4 +-
 .../ethernet/hisilicon/hns3/hns3vf/hclgevf_mbx.c   |  50 +--
 5 files changed, 420 insertions(+), 386 deletions(-)

-- 
2.7.4

