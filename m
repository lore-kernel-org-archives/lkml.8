Return-Path: <SRS0=vN1y=BQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FAB1C388F9
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 11:05:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5E9CB2310A
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 11:05:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728817AbgHFHtG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Aug 2020 03:49:06 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:59946 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728367AbgHFHsr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Aug 2020 03:48:47 -0400
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 71E11A9348D262EB461C;
        Thu,  6 Aug 2020 15:48:38 +0800 (CST)
Received: from localhost.localdomain (10.175.118.36) by
 DGGEMS404-HUB.china.huawei.com (10.3.19.204) with Microsoft SMTP Server id
 14.3.487.0; Thu, 6 Aug 2020 15:48:29 +0800
From:   Luo bin <luobin9@huawei.com>
To:     <davem@davemloft.net>
CC:     <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        <luoxianjun@huawei.com>, <yin.yinshi@huawei.com>,
        <cloud.wangxiaoyun@huawei.com>, <chiqijun@huawei.com>
Subject: [PATCH net-next] hinic: fix strncpy output truncated compile warnings
Date:   Thu, 6 Aug 2020 15:48:30 +0800
Message-ID: <20200806074830.1375-1-luobin9@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.118.36]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

fix the compile warnings of 'strncpy' output truncated before
terminating nul copying N bytes from a string of the same length

Signed-off-by: Luo bin <luobin9@huawei.com>
Reported-by: kernel test robot <lkp@intel.com>
---
 drivers/net/ethernet/huawei/hinic/hinic_devlink.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/huawei/hinic/hinic_devlink.c b/drivers/net/ethernet/huawei/hinic/hinic_devlink.c
index c6adc776f3c8..1dc948c07b94 100644
--- a/drivers/net/ethernet/huawei/hinic/hinic_devlink.c
+++ b/drivers/net/ethernet/huawei/hinic/hinic_devlink.c
@@ -342,9 +342,9 @@ static int chip_fault_show(struct devlink_fmsg *fmsg,
 
 	level = event->event.chip.err_level;
 	if (level < FAULT_LEVEL_MAX)
-		strncpy(level_str, fault_level[level], strlen(fault_level[level]));
+		strncpy(level_str, fault_level[level], strlen(fault_level[level]) + 1);
 	else
-		strncpy(level_str, "Unknown", strlen("Unknown"));
+		strncpy(level_str, "Unknown", sizeof(level_str));
 
 	if (level == FAULT_LEVEL_SERIOUS_FLR) {
 		err = devlink_fmsg_u32_pair_put(fmsg, "Function level err func_id",
@@ -388,9 +388,9 @@ static int fault_report_show(struct devlink_fmsg *fmsg,
 	int err;
 
 	if (event->type < FAULT_TYPE_MAX)
-		strncpy(type_str, fault_type[event->type], strlen(fault_type[event->type]));
+		strncpy(type_str, fault_type[event->type], strlen(fault_type[event->type]) + 1);
 	else
-		strncpy(type_str, "Unknown", strlen("Unknown"));
+		strncpy(type_str, "Unknown", sizeof(type_str));
 
 	err = devlink_fmsg_string_pair_put(fmsg, "Fault type", type_str);
 	if (err)
-- 
2.17.1

