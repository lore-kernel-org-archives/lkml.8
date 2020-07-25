Return-Path: <SRS0=eufF=BE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6C86C433DF
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Jul 2020 07:11:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A2446206EB
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Jul 2020 07:11:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727023AbgGYHLX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 Jul 2020 03:11:23 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:8820 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726572AbgGYHLX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Jul 2020 03:11:23 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id D79CB5C983F28B5AAC04;
        Sat, 25 Jul 2020 15:11:18 +0800 (CST)
Received: from localhost.localdomain (10.175.118.36) by
 DGGEMS411-HUB.china.huawei.com (10.3.19.211) with Microsoft SMTP Server id
 14.3.487.0; Sat, 25 Jul 2020 15:11:13 +0800
From:   Luo bin <luobin9@huawei.com>
To:     <davem@davemloft.net>
CC:     <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        <luoxianjun@huawei.com>, <yin.yinshi@huawei.com>,
        <cloud.wangxiaoyun@huawei.com>, <chiqijun@huawei.com>
Subject: [PATCH net-next v5 0/2] hinic: add some error messages for debug
Date:   Sat, 25 Jul 2020 15:11:17 +0800
Message-ID: <20200725071119.31773-1-luobin9@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.118.36]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

patch #1: support to handle hw abnormal event
patch #2: improve the error messages when functions return failure and
	  dump relevant registers in some exception handling processes

Luo bin (2):
  hinic: add support to handle hw abnormal event
  hinic: add log in exception handling processes

 drivers/net/ethernet/huawei/hinic/hinic_dev.h |   4 +
 .../net/ethernet/huawei/hinic/hinic_devlink.c | 286 +++++++++++++++++-
 .../net/ethernet/huawei/hinic/hinic_devlink.h |   8 +-
 .../net/ethernet/huawei/hinic/hinic_ethtool.c |  20 ++
 .../ethernet/huawei/hinic/hinic_hw_api_cmd.c  |  27 +-
 .../ethernet/huawei/hinic/hinic_hw_api_cmd.h  |   4 +
 .../net/ethernet/huawei/hinic/hinic_hw_cmdq.c |   2 +
 .../net/ethernet/huawei/hinic/hinic_hw_cmdq.h |   2 +
 .../net/ethernet/huawei/hinic/hinic_hw_dev.c  | 160 +++++++++-
 .../net/ethernet/huawei/hinic/hinic_hw_dev.h  | 148 ++++++++-
 .../net/ethernet/huawei/hinic/hinic_hw_eqs.c  |  39 +++
 .../net/ethernet/huawei/hinic/hinic_hw_eqs.h  |   6 +-
 .../net/ethernet/huawei/hinic/hinic_hw_if.c   |  23 ++
 .../net/ethernet/huawei/hinic/hinic_hw_if.h   |  10 +-
 .../net/ethernet/huawei/hinic/hinic_hw_mbox.c |   2 +
 .../net/ethernet/huawei/hinic/hinic_hw_mgmt.c |  11 +
 .../net/ethernet/huawei/hinic/hinic_hw_mgmt.h |   4 +
 .../net/ethernet/huawei/hinic/hinic_main.c    |  87 ++++--
 .../net/ethernet/huawei/hinic/hinic_port.c    |  62 ++--
 .../net/ethernet/huawei/hinic/hinic_port.h    |  25 ++
 .../net/ethernet/huawei/hinic/hinic_sriov.c   |   6 +-
 21 files changed, 855 insertions(+), 81 deletions(-)

-- 
2.17.1

