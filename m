Return-Path: <SRS0=PjrZ=CH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F686C433E6
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Aug 2020 00:54:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 327D2207DA
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Aug 2020 00:54:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726939AbgH2Ayn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Aug 2020 20:54:43 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:42856 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726851AbgH2Ayk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Aug 2020 20:54:40 -0400
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 08435FE9F4B6E8E61A5D;
        Sat, 29 Aug 2020 08:54:38 +0800 (CST)
Received: from localhost.localdomain (10.175.118.36) by
 DGGEMS402-HUB.china.huawei.com (10.3.19.202) with Microsoft SMTP Server id
 14.3.487.0; Sat, 29 Aug 2020 08:54:29 +0800
From:   Luo bin <luobin9@huawei.com>
To:     <davem@davemloft.net>
CC:     <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        <luoxianjun@huawei.com>, <yin.yinshi@huawei.com>,
        <cloud.wangxiaoyun@huawei.com>, <chiqijun@huawei.com>
Subject: [PATCH net-next v3 0/3] hinic: add debugfs support
Date:   Sat, 29 Aug 2020 08:55:17 +0800
Message-ID: <20200829005520.27364-1-luobin9@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.118.36]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

add debugfs node for querying sq/rq info and function table

Luo bin (3):
  hinic: add support to query sq info
  hinic: add support to query rq info
  hinic: add support to query function table

 drivers/net/ethernet/huawei/hinic/Makefile    |   3 +-
 .../net/ethernet/huawei/hinic/hinic_debugfs.c | 315 ++++++++++++++++++
 .../net/ethernet/huawei/hinic/hinic_debugfs.h | 114 +++++++
 drivers/net/ethernet/huawei/hinic/hinic_dev.h |  20 ++
 .../net/ethernet/huawei/hinic/hinic_hw_dev.c  |   1 +
 .../net/ethernet/huawei/hinic/hinic_hw_dev.h  |   2 +
 .../net/ethernet/huawei/hinic/hinic_hw_io.c   |   2 +
 .../net/ethernet/huawei/hinic/hinic_hw_io.h   |   1 +
 .../net/ethernet/huawei/hinic/hinic_hw_qp.h   |   6 +
 .../net/ethernet/huawei/hinic/hinic_main.c    |  83 ++++-
 10 files changed, 541 insertions(+), 6 deletions(-)
 create mode 100644 drivers/net/ethernet/huawei/hinic/hinic_debugfs.c
 create mode 100644 drivers/net/ethernet/huawei/hinic/hinic_debugfs.h

-- 
2.17.1

