Return-Path: <SRS0=o+hd=CR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57B51C43461
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 03:03:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 34A4621941
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 03:03:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728786AbgIHDDP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Sep 2020 23:03:15 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:11252 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728372AbgIHDCa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Sep 2020 23:02:30 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 9E815FCC73654E726394;
        Tue,  8 Sep 2020 11:02:27 +0800 (CST)
Received: from localhost.localdomain (10.69.192.56) by
 DGGEMS403-HUB.china.huawei.com (10.3.19.203) with Microsoft SMTP Server id
 14.3.487.0; Tue, 8 Sep 2020 11:02:18 +0800
From:   Huazhong Tan <tanhuazhong@huawei.com>
To:     <davem@davemloft.net>
CC:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <salil.mehta@huawei.com>, <yisen.zhuang@huawei.com>,
        <linuxarm@huawei.com>, <kuba@kernel.org>,
        Huazhong Tan <tanhuazhong@huawei.com>
Subject: [PATCH net-next 0/7] net: hns3: misc updates
Date:   Tue, 8 Sep 2020 10:59:47 +0800
Message-ID: <1599533994-32744-1-git-send-email-tanhuazhong@huawei.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.56]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are some misc updates for the HNS3 ethernet driver.

#1 narrows two local variable range in hclgevf_reset_prepare_wait().
#2 adds reset failure check in periodic service task.
#3~#7 adds some cleanups.

Guangbin Huang (2):
  net: hns3: skip periodic service task if reset failed
  net: hns3: fix a typo in struct hclge_mac

Guojia Liao (1):
  net: hns3: remove some unused function hns3_update_promisc_mode()

Huazhong Tan (4):
  net: hns3: narrow two local variable range in
    hclgevf_reset_prepare_wait()
  net: hns3: remove unused field 'io_base' in struct hns3_enet_ring
  net: hns3: remove unused field 'tc_num_last_time' in struct hclge_dev
  net: hns3: remove some unused macros related to queue

 drivers/net/ethernet/hisilicon/hns3/hns3_enet.c          | 16 ----------------
 drivers/net/ethernet/hisilicon/hns3/hns3_enet.h          |  7 -------
 drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c  |  3 +++
 drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.h  |  3 +--
 .../net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c    | 15 +++++++++------
 5 files changed, 13 insertions(+), 31 deletions(-)

-- 
2.7.4

