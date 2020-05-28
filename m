Return-Path: <SRS0=f73W=7K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F35EC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 13:51:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8026920897
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 13:51:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390645AbgE1NvO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 May 2020 09:51:14 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:5304 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2390498AbgE1NvB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 09:51:01 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 22EF75EBCD9D41EEF2B8;
        Thu, 28 May 2020 21:50:54 +0800 (CST)
Received: from localhost.localdomain (10.69.192.56) by
 DGGEMS413-HUB.china.huawei.com (10.3.19.213) with Microsoft SMTP Server id
 14.3.487.0; Thu, 28 May 2020 21:50:48 +0800
From:   Huazhong Tan <tanhuazhong@huawei.com>
To:     <davem@davemloft.net>
CC:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <salil.mehta@huawei.com>, <yisen.zhuang@huawei.com>,
        <linuxarm@huawei.com>, <kuba@kernel.org>,
        Huazhong Tan <tanhuazhong@huawei.com>
Subject: [PATCH net-next 00/12] net: hns3: misc updates for -next
Date:   Thu, 28 May 2020 21:48:07 +0800
Message-ID: <1590673699-63819-1-git-send-email-tanhuazhong@huawei.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.56]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset includes some updates for the HNS3 ethernet driver.

#1 removes an unnecessary 'goto'.
#2 adds a missing mutex destroy.
#3&4 refactor two function, make them more readable and maintainable.
#5&6 fix unsuitable type of gro enable field both for PF & VF.
#7-#11 removes some unused fields, macro and redundant definitions.
#12 adds more debug info for parsing speed fails.

Huazhong Tan (12):
  net: hns3: remove an unnecessary 'goto' in hclge_init_ae_dev()
  net: hns3: add a missing mutex destroy in hclge_init_ad_dev()
  net: hns3: refactor hclge_config_tso()
  net: hns3: refactor hclge_query_bd_num_cmd_send()
  net: hns3: modify an incorrect type in struct hclge_cfg_gro_status_cmd
  net: hns3: modify an incorrect type in struct
    hclgevf_cfg_gro_status_cmd
  net: hns3: remove some unused fields in struct hns3_nic_priv
  net: hns3; remove unused HNAE3_RESTORE_CLIENT in enum
    hnae3_reset_notify_type
  net: hns3: remove unused struct hnae3_unic_private_info
  net: hns3: remove two duplicated register macros in hclgevf_main.h
  net: hns3: remove some unused fields in struct hclge_dev
  net: hns3: print out speed info when parsing speed fails

 drivers/net/ethernet/hisilicon/hns3/hnae3.h        | 12 ------
 drivers/net/ethernet/hisilicon/hns3/hns3_enet.h    | 22 ----------
 .../net/ethernet/hisilicon/hns3/hns3pf/hclge_cmd.h |  4 +-
 .../ethernet/hisilicon/hns3/hns3pf/hclge_main.c    | 50 ++++++++++------------
 .../ethernet/hisilicon/hns3/hns3pf/hclge_main.h    |  6 ---
 .../ethernet/hisilicon/hns3/hns3vf/hclgevf_cmd.h   |  4 +-
 .../ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c  |  8 ++--
 .../ethernet/hisilicon/hns3/hns3vf/hclgevf_main.h  |  4 +-
 8 files changed, 31 insertions(+), 79 deletions(-)

-- 
2.7.4

