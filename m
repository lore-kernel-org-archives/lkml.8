Return-Path: <SRS0=DSgr=5G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DATE_IN_PAST_06_12,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C392C4332B
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Mar 2020 06:58:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F0E0206F9
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Mar 2020 06:58:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728162AbgCUG6r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 21 Mar 2020 02:58:47 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:32974 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728010AbgCUG6l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Mar 2020 02:58:41 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 7ED3EC11A0CC40588250;
        Sat, 21 Mar 2020 14:58:20 +0800 (CST)
Received: from localhost.localdomain (10.175.34.53) by
 DGGEMS401-HUB.china.huawei.com (10.3.19.201) with Microsoft SMTP Server id
 14.3.487.0; Sat, 21 Mar 2020 14:57:21 +0800
From:   Luo bin <luobin9@huawei.com>
To:     <davem@davemloft.net>
CC:     <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        <luoxianjun@huawei.com>, <luobin9@huawei.com>,
        <yin.yinshi@huawei.com>, <cloud.wangxiaoyun@huawei.com>
Subject: [PATCH net 0/5] hinic: BugFixes
Date:   Fri, 20 Mar 2020 23:13:15 +0000
Message-ID: <20200320231320.1001-1-luobin9@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.34.53]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix a number of bugs which have been present since the first commit.

The bugs fixed in these patchs are hardly exposed unless given
very specific conditions.

Luo bin (5):
  hinic: fix a bug of waitting for IO stopped
  hinic: fix the bug of clearing event queue
  hinic: fix out-of-order excution in arm cpu
  hinic: fix wrong para of wait_for_completion_timeout
  hinic: fix wrong value of MIN_SKB_LEN

 .../net/ethernet/huawei/hinic/hinic_hw_cmdq.c |  5 +-
 .../net/ethernet/huawei/hinic/hinic_hw_dev.c  | 51 +------------------
 .../net/ethernet/huawei/hinic/hinic_hw_eqs.c  | 26 +++++++---
 .../net/ethernet/huawei/hinic/hinic_hw_mgmt.c |  5 +-
 drivers/net/ethernet/huawei/hinic/hinic_rx.c  |  3 ++
 drivers/net/ethernet/huawei/hinic/hinic_tx.c  |  4 +-
 6 files changed, 34 insertions(+), 60 deletions(-)

-- 
2.17.1

