Return-Path: <SRS0=IBMW=4Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F10DCC10F25
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Mar 2020 03:52:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA24C206D7
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Mar 2020 03:52:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727366AbgCGDwo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Mar 2020 22:52:44 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:11603 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726359AbgCGDwf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Mar 2020 22:52:35 -0500
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 13FB229C5B5326740164;
        Sat,  7 Mar 2020 11:52:29 +0800 (CST)
Received: from localhost.localdomain (10.69.192.56) by
 DGGEMS413-HUB.china.huawei.com (10.3.19.213) with Microsoft SMTP Server id
 14.3.439.0; Sat, 7 Mar 2020 11:52:18 +0800
From:   Huazhong Tan <tanhuazhong@huawei.com>
To:     <davem@davemloft.net>
CC:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <salil.mehta@huawei.com>, <yisen.zhuang@huawei.com>,
        <linuxarm@huawei.com>, <kuba@kernel.org>,
        Huazhong Tan <tanhuazhong@huawei.com>
Subject: [PATCH V2 net-next 0/9] net: hns3: misc updates for -net-next
Date:   Sat, 7 Mar 2020 11:42:41 +0800
Message-ID: <1583552570-51203-1-git-send-email-tanhuazhong@huawei.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.56]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series includes some misc updates for the HNS3 ethernet driver.

[patch 1] fixes some mixed type operation warning.
[patch 2] renames a macro to make it more readable.
[patch 3 & 4]  removes some unnecessary code.
[patch 5] adds check before assert VF reset to prevent some unsuitable
error log.
[patch 6 - 9] some modifications related to printing.

Change log:
V1->V2: fixes a wrong print format in [patch 1] suggested by Jian Shen.

Guojia Liao (2):
  net: hns3: fix some mixed type assignment
  net: hns3: delete some reduandant code

Huazhong Tan (2):
  net: hns3: print out status register when VF receives unknown source
    interrupt
  net: hns3: synchronize some print relating to reset issue

Yonglong Liu (1):
  net: hns3: add a check before PF inform VF to reset

Yufeng Mo (4):
  net: hns3: rename macro HCLGE_MAX_NCL_CONFIG_LENGTH
  net: hns3: remove an unnecessary resetting check in
    hclge_handle_hw_ras_error()
  net: hns3: print out command code when dump fails in debugfs
  net: hns3: delete unnecessary logs after kzalloc fails

 drivers/net/ethernet/hisilicon/hns3/hns3_enet.c    |  4 +-
 .../ethernet/hisilicon/hns3/hns3pf/hclge_debugfs.c | 96 ++++++++++++----------
 .../net/ethernet/hisilicon/hns3/hns3pf/hclge_err.c |  3 -
 .../ethernet/hisilicon/hns3/hns3pf/hclge_main.c    | 27 +++---
 .../ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c  |  5 +-
 5 files changed, 75 insertions(+), 60 deletions(-)

-- 
2.7.4

