Return-Path: <SRS0=OCv1=CF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAA90C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 15:23:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C1C8422B4E
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 15:23:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728486AbgH0PW7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Aug 2020 11:22:59 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:10282 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728600AbgH0Las (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Aug 2020 07:30:48 -0400
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id B9F4649C27C575CDA633;
        Thu, 27 Aug 2020 19:12:40 +0800 (CST)
Received: from localhost.localdomain (10.175.118.36) by
 DGGEMS412-HUB.china.huawei.com (10.3.19.212) with Microsoft SMTP Server id
 14.3.487.0; Thu, 27 Aug 2020 19:12:30 +0800
From:   Luo bin <luobin9@huawei.com>
To:     <davem@davemloft.net>
CC:     <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        <luoxianjun@huawei.com>, <yin.yinshi@huawei.com>,
        <cloud.wangxiaoyun@huawei.com>, <chiqijun@huawei.com>
Subject: [PATCH net-next v1 0/3] hinic: add debugfs support
Date:   Thu, 27 Aug 2020 19:13:18 +0800
Message-ID: <20200827111321.24272-1-luobin9@huawei.com>
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
 .../net/ethernet/huawei/hinic/hinic_debugfs.c | 325 ++++++++++++++++++
 .../net/ethernet/huawei/hinic/hinic_debugfs.h | 114 ++++++
 drivers/net/ethernet/huawei/hinic/hinic_dev.h |  20 ++
 .../net/ethernet/huawei/hinic/hinic_hw_dev.c  |   1 +
 .../net/ethernet/huawei/hinic/hinic_hw_dev.h  |   2 +
 .../net/ethernet/huawei/hinic/hinic_hw_io.c   |   2 +
 .../net/ethernet/huawei/hinic/hinic_hw_io.h   |   1 +
 .../net/ethernet/huawei/hinic/hinic_hw_qp.h   |   6 +
 .../net/ethernet/huawei/hinic/hinic_main.c    |  83 ++++-
 10 files changed, 551 insertions(+), 6 deletions(-)
 create mode 100644 drivers/net/ethernet/huawei/hinic/hinic_debugfs.c
 create mode 100644 drivers/net/ethernet/huawei/hinic/hinic_debugfs.h

-- 
2.17.1

