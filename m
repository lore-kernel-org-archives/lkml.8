Return-Path: <SRS0=87nF=CT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6DB8C43461
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 20:20:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A5082208E4
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 20:20:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726663AbgIJUU3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Sep 2020 16:20:29 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:11797 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730877AbgIJO7R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 10:59:17 -0400
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 7B8FBB3EEC11B98B58E5;
        Thu, 10 Sep 2020 22:59:13 +0800 (CST)
Received: from huawei.com (10.175.113.133) by DGGEMS412-HUB.china.huawei.com
 (10.3.19.212) with Microsoft SMTP Server id 14.3.487.0; Thu, 10 Sep 2020
 22:59:06 +0800
From:   Wang Hai <wanghai38@huawei.com>
To:     <yisen.zhuang@huawei.com>, <salil.mehta@huawei.com>,
        <davem@davemloft.net>, <kuba@kernel.org>, <snelson@pensando.io>,
        <colin.king@canonical.com>, <maz@kernel.org>, <luobin9@huawei.com>
CC:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH net-next 0/6] Fix some kernel-doc warnings for hns
Date:   Thu, 10 Sep 2020 22:56:14 +0800
Message-ID: <20200910145620.27470-1-wanghai38@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.113.133]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix some kernel-doc warnings for hns.

Wang Hai (6):
  hinic: Fix some kernel-doc warnings in hinic_hw_io.c
  net: hns: fix 'cdev' kernel-doc warning in hnae_ae_unregister()
  net: hns: Fix some kernel-doc warnings in hns_dsaf_xgmac.c
  net: hns: Fix some kernel-doc warnings in hns_enet.c
  net: hns: Fix a kernel-doc warning in hinic_hw_api_cmd.c
  net: hns: Fix a kernel-doc warning in hinic_hw_eqs.c

 drivers/net/ethernet/hisilicon/hns/hnae.c            | 2 +-
 drivers/net/ethernet/hisilicon/hns/hns_dsaf_xgmac.c  | 3 +--
 drivers/net/ethernet/hisilicon/hns/hns_enet.c        | 3 +--
 drivers/net/ethernet/huawei/hinic/hinic_hw_api_cmd.c | 2 +-
 drivers/net/ethernet/huawei/hinic/hinic_hw_eqs.c     | 2 +-
 drivers/net/ethernet/huawei/hinic/hinic_hw_io.c      | 4 ++--
 6 files changed, 7 insertions(+), 9 deletions(-)

-- 
2.17.1

