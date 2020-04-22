Return-Path: <SRS0=eifh=6G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9986C2BA19
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 02:52:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ACEF7206D5
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 02:52:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726456AbgDVCwp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Apr 2020 22:52:45 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:52186 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726173AbgDVCwo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Apr 2020 22:52:44 -0400
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 99E05367F653A2B1F84D;
        Wed, 22 Apr 2020 10:52:42 +0800 (CST)
Received: from linux-lmwb.huawei.com (10.175.103.112) by
 DGGEMS409-HUB.china.huawei.com (10.3.19.209) with Microsoft SMTP Server id
 14.3.487.0; Wed, 22 Apr 2020 10:52:36 +0800
From:   Zou Wei <zou_wei@huawei.com>
To:     <derek.kiernan@xilinx.com>, <dragan.cvetic@xilinx.com>,
        <arnd@arndb.de>, <gregkh@linuxfoundation.org>,
        <michal.simek@xilinx.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Zou Wei <zou_wei@huawei.com>
Subject: [PATCH -next] misc: xilinx_sdfec: Use memdup_user() as a cleanup
Date:   Wed, 22 Apr 2020 10:58:50 +0800
Message-ID: <1587524330-119776-1-git-send-email-zou_wei@huawei.com>
X-Mailer: git-send-email 2.6.2
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.103.112]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix coccicheck warning which recommends to use memdup_user().

This patch fixes the following coccicheck warnings:

drivers/misc/xilinx_sdfec.c:652:8-15: WARNING opportunity for memdup_user

Fixes: 20ec628e8007 ("misc: xilinx_sdfec: Add ability to configure LDPC")
Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Zou Wei <zou_wei@huawei.com>
---
 drivers/misc/xilinx_sdfec.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/drivers/misc/xilinx_sdfec.c b/drivers/misc/xilinx_sdfec.c
index 71bbaa5..7a75894 100644
--- a/drivers/misc/xilinx_sdfec.c
+++ b/drivers/misc/xilinx_sdfec.c
@@ -649,14 +649,9 @@ static int xsdfec_add_ldpc(struct xsdfec_dev *xsdfec, void __user *arg)
 	struct xsdfec_ldpc_params *ldpc;
 	int ret, n;
 
-	ldpc = kzalloc(sizeof(*ldpc), GFP_KERNEL);
-	if (!ldpc)
-		return -ENOMEM;
-
-	if (copy_from_user(ldpc, arg, sizeof(*ldpc))) {
-		ret = -EFAULT;
-		goto err_out;
-	}
+	ldpc = memdup_user(arg, sizeof(*ldpc));
+	if (IS_ERR(ldpc))
+		return PTR_ERR(ldpc);
 
 	if (xsdfec->config.code == XSDFEC_TURBO_CODE) {
 		ret = -EIO;
-- 
2.6.2

