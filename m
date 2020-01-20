Return-Path: <SRS0=vnT4=3J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4525CC33CA1
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 12:54:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 21E9622464
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 12:54:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727075AbgATMyp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jan 2020 07:54:45 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:9671 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726589AbgATMyp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jan 2020 07:54:45 -0500
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 58230D174755C140357B;
        Mon, 20 Jan 2020 20:54:43 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS413-HUB.china.huawei.com (10.3.19.213) with Microsoft SMTP Server id
 14.3.439.0; Mon, 20 Jan 2020 20:54:33 +0800
From:   Chen Zhou <chenzhou10@huawei.com>
To:     <yisen.zhuang@huawei.com>, <salil.mehta@huawei.com>,
        <davem@davemloft.net>
CC:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <chenzhou10@huawei.com>
Subject: [PATCH -next v2] net: hns3: replace snprintf with scnprintf in hns3_dbg_cmd_read
Date:   Mon, 20 Jan 2020 20:49:43 +0800
Message-ID: <20200120124943.30274-1-chenzhou10@huawei.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The return value of snprintf may be greater than the size of
HNS3_DBG_READ_LEN, use scnprintf instead in hns3_dbg_cmd_read.

Signed-off-by: Chen Zhou <chenzhou10@huawei.com>
---

changes in v2:
- fix checkpatch style problem.

---
 drivers/net/ethernet/hisilicon/hns3/hns3_debugfs.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3_debugfs.c b/drivers/net/ethernet/hisilicon/hns3/hns3_debugfs.c
index 6b328a2..92ee1f5 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3_debugfs.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3_debugfs.c
@@ -297,8 +297,8 @@ static ssize_t hns3_dbg_cmd_read(struct file *filp, char __user *buffer,
 	if (!buf)
 		return -ENOMEM;
 
-	len = snprintf(buf, HNS3_DBG_READ_LEN, "%s\n",
-		       "Please echo help to cmd to get help information");
+	len = scnprintf(buf, HNS3_DBG_READ_LEN, "%s\n",
+			"Please echo help to cmd to get help information");
 	uncopy_bytes = copy_to_user(buffer, buf, len);
 
 	kfree(buf);
-- 
2.7.4

