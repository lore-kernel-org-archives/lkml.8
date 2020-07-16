Return-Path: <SRS0=y5Sx=A3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02662C433E5
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 12:51:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DD9A320739
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 12:51:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728547AbgGPMvY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jul 2020 08:51:24 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:7770 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727106AbgGPMvX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jul 2020 08:51:23 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id C627D35FC82F49BCF856;
        Thu, 16 Jul 2020 20:51:18 +0800 (CST)
Received: from localhost.localdomain (10.175.118.36) by
 DGGEMS403-HUB.china.huawei.com (10.3.19.203) with Microsoft SMTP Server id
 14.3.487.0; Thu, 16 Jul 2020 20:51:10 +0800
From:   Luo bin <luobin9@huawei.com>
To:     <davem@davemloft.net>
CC:     <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        <luoxianjun@huawei.com>, <yin.yinshi@huawei.com>,
        <cloud.wangxiaoyun@huawei.com>, <chiqijun@huawei.com>
Subject: [PATCH net-next 0/2] hinic: add some error messages for debug
Date:   Thu, 16 Jul 2020 20:50:54 +0800
Message-ID: <20200716125056.27160-1-luobin9@huawei.com>
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

 .../ethernet/huawei/hinic/hinic_hw_api_cmd.c  |  27 +-
 .../ethernet/huawei/hinic/hinic_hw_api_cmd.h  |   4 +
 .../net/ethernet/huawei/hinic/hinic_hw_cmdq.c |   2 +
 .../net/ethernet/huawei/hinic/hinic_hw_cmdq.h |   2 +
 .../net/ethernet/huawei/hinic/hinic_hw_dev.c  | 261 +++++++++++++++++-
 .../net/ethernet/huawei/hinic/hinic_hw_dev.h  | 144 +++++++++-
 .../net/ethernet/huawei/hinic/hinic_hw_eqs.c  |  39 +++
 .../net/ethernet/huawei/hinic/hinic_hw_eqs.h  |   4 +
 .../net/ethernet/huawei/hinic/hinic_hw_if.c   |  23 ++
 .../net/ethernet/huawei/hinic/hinic_hw_if.h   |   2 +
 .../net/ethernet/huawei/hinic/hinic_hw_mbox.c |   2 +
 .../net/ethernet/huawei/hinic/hinic_hw_mgmt.c |   1 +
 .../net/ethernet/huawei/hinic/hinic_hw_mgmt.h |   4 +
 .../net/ethernet/huawei/hinic/hinic_main.c    |  56 ++++
 .../net/ethernet/huawei/hinic/hinic_port.c    |  62 ++---
 .../net/ethernet/huawei/hinic/hinic_port.h    |  25 ++
 .../net/ethernet/huawei/hinic/hinic_sriov.c   |   6 +-
 17 files changed, 616 insertions(+), 48 deletions(-)

-- 
2.17.1

