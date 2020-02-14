Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB262C352A3
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 01:54:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 937D020848
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 01:54:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728555AbgBNBye (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Feb 2020 20:54:34 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:10170 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728193AbgBNByK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 20:54:10 -0500
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 9886A58D8AFD5AD66025;
        Fri, 14 Feb 2020 09:54:06 +0800 (CST)
Received: from localhost.localdomain (10.69.192.56) by
 DGGEMS408-HUB.china.huawei.com (10.3.19.208) with Microsoft SMTP Server id
 14.3.439.0; Fri, 14 Feb 2020 09:53:59 +0800
From:   Huazhong Tan <tanhuazhong@huawei.com>
To:     <davem@davemloft.net>
CC:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <salil.mehta@huawei.com>, <yisen.zhuang@huawei.com>,
        <huangdaode@huawei.com>, <linuxarm@huawei.com>, <kuba@kernel.org>,
        Huazhong Tan <tanhuazhong@huawei.com>
Subject: [PATCH net 0/3] net: hns3: fixes for -net
Date:   Fri, 14 Feb 2020 09:53:40 +0800
Message-ID: <1581645223-23038-1-git-send-email-tanhuazhong@huawei.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.56]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series includes three bugfixes for the HNS3 ethernet driver.

[patch 1] fixes a management table lost issue after IMP reset.
[patch 2] fixes a VF bandwidth configuration not work problem.
[patch 3] fixes a problem related to IPv6 address copying.

Guangbin Huang (1):
  net: hns3: fix a copying IPv6 address error in
    hclge_fd_get_flow_tuples()

Yonglong Liu (1):
  net: hns3: fix VF bandwidth does not take effect in some case

Yufeng Mo (1):
  net: hns3: add management table after IMP reset

 .../ethernet/hisilicon/hns3/hns3pf/hclge_main.c    | 22 ++++++++++++++++------
 .../net/ethernet/hisilicon/hns3/hns3pf/hclge_tm.c  |  2 +-
 2 files changed, 17 insertions(+), 7 deletions(-)

-- 
2.7.4

