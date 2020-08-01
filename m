Return-Path: <SRS0=dmjt=BL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06BA5C433E3
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Aug 2020 02:49:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E58B32083B
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Aug 2020 02:49:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728431AbgHACtd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jul 2020 22:49:33 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:53268 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727116AbgHACtc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jul 2020 22:49:32 -0400
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id EEF78ABD6D7A7F0B8CA0;
        Sat,  1 Aug 2020 10:49:28 +0800 (CST)
Received: from localhost.localdomain (10.175.118.36) by
 DGGEMS402-HUB.china.huawei.com (10.3.19.202) with Microsoft SMTP Server id
 14.3.487.0; Sat, 1 Aug 2020 10:49:21 +0800
From:   Luo bin <luobin9@huawei.com>
To:     <davem@davemloft.net>
CC:     <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        <luoxianjun@huawei.com>, <yin.yinshi@huawei.com>,
        <cloud.wangxiaoyun@huawei.com>, <chiqijun@huawei.com>
Subject: [PATCH net-next v3 0/2] hinic: mailbox channel enhancement
Date:   Sat, 1 Aug 2020 10:49:33 +0800
Message-ID: <20200801024935.20819-1-luobin9@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.118.36]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

add support to generate mailbox random id for VF to ensure that
the mailbox message from VF is valid and PF should check whether
the cmd from VF is supported before passing it to hw.

Luo bin (2):
  hinic: add generating mailbox random index support
  hinic: add check for mailbox msg from VF

 .../net/ethernet/huawei/hinic/hinic_hw_cmdq.h |   8 +
 .../net/ethernet/huawei/hinic/hinic_hw_dev.h  |  13 +
 .../net/ethernet/huawei/hinic/hinic_hw_mbox.c | 308 +++++++++++++++++-
 .../net/ethernet/huawei/hinic/hinic_hw_mbox.h |  22 ++
 .../net/ethernet/huawei/hinic/hinic_hw_mgmt.h |   2 +
 .../net/ethernet/huawei/hinic/hinic_sriov.c   |  69 +++-
 6 files changed, 420 insertions(+), 2 deletions(-)

-- 
2.17.1

