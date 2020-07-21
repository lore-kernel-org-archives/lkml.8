Return-Path: <SRS0=jpuI=BA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9027CC433E3
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 11:07:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7540320709
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 11:07:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726977AbgGULHP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jul 2020 07:07:15 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:7806 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727991AbgGULHG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jul 2020 07:07:06 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 1C47810CE4E6F6BD047;
        Tue, 21 Jul 2020 19:07:02 +0800 (CST)
Received: from localhost.localdomain (10.69.192.56) by
 DGGEMS405-HUB.china.huawei.com (10.3.19.205) with Microsoft SMTP Server id
 14.3.487.0; Tue, 21 Jul 2020 19:06:54 +0800
From:   Huazhong Tan <tanhuazhong@huawei.com>
To:     <davem@davemloft.net>
CC:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <salil.mehta@huawei.com>, <yisen.zhuang@huawei.com>,
        <linuxarm@huawei.com>, <kuba@kernel.org>,
        Huazhong Tan <tanhuazhong@huawei.com>
Subject: [PATCH net 0/4] net: hns3: fixes for -net
Date:   Tue, 21 Jul 2020 19:03:50 +0800
Message-ID: <1595329434-46766-1-git-send-email-tanhuazhong@huawei.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.56]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are some bugfixes for the HNS3 ethernet driver.

Jian Shen (1):
  net: hns3: fix return value error when query MAC link status fail

Yunsheng Lin (3):
  net: hns3: fix for not unmapping TX buffer correctly
  net: hns3: fix for not calculating TX BD send size correctly
  net: hns3: fix error handling for desc filling

 drivers/net/ethernet/hisilicon/hns3/hnae3.h        |  1 +
 drivers/net/ethernet/hisilicon/hns3/hns3_enet.c    | 24 +++++------
 drivers/net/ethernet/hisilicon/hns3/hns3_enet.h    |  2 -
 .../ethernet/hisilicon/hns3/hns3pf/hclge_main.c    | 49 ++++++++++------------
 .../ethernet/hisilicon/hns3/hns3pf/hclge_main.h    |  3 ++
 5 files changed, 38 insertions(+), 41 deletions(-)

-- 
2.7.4

