Return-Path: <SRS0=0sZ+=6V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFA82C38A2A
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 11:12:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B179A208E4
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 11:12:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726408AbgEGLM7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 May 2020 07:12:59 -0400
Received: from cmccmta1.chinamobile.com ([221.176.66.79]:3526 "EHLO
        cmccmta1.chinamobile.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725893AbgEGLM6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 07:12:58 -0400
Received: from spf.mail.chinamobile.com (unknown[172.16.121.17]) by rmmx-syy-dmz-app01-12001 (RichMail) with SMTP id 2ee15eb3ecfbafc-3ed47; Thu, 07 May 2020 19:11:55 +0800 (CST)
X-RM-TRANSID: 2ee15eb3ecfbafc-3ed47
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG: 00000000
Received: from localhost.localdomain (unknown[112.0.146.193])
        by rmsmtp-syy-appsvr09-12009 (RichMail) with SMTP id 2ee95eb3ecf8d80-33832;
        Thu, 07 May 2020 19:11:55 +0800 (CST)
X-RM-TRANSID: 2ee95eb3ecf8d80-33832
From:   Tang Bin <tangbin@cmss.chinamobile.com>
To:     gregkh@linuxfoundation.org, allison@lohutok.net,
        rfontana@redhat.com, kstewart@linuxfoundation.org,
        mpe@ellerman.id.au, tglx@linutronix.de
Cc:     linux-kernel@vger.kernel.org,
        Tang Bin <tangbin@cmss.chinamobile.com>,
        Zhang Shengju <zhangshengju@cmss.chinamobile.com>
Subject: [PATCH] dca: Use PTR_ERR_OR_ZERO() to simplify code
Date:   Thu,  7 May 2020 19:12:24 +0800
Message-Id: <20200507111224.4176-1-tangbin@cmss.chinamobile.com>
X-Mailer: git-send-email 2.20.1.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The function PTR_ERR_OR_ZERO() contains the check of
IS_ERR() and the return of PTR_ERR() or zero.

Signed-off-by: Zhang Shengju <zhangshengju@cmss.chinamobile.com>
Signed-off-by: Tang Bin <tangbin@cmss.chinamobile.com>
---
 drivers/dca/dca-sysfs.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/dca/dca-sysfs.c b/drivers/dca/dca-sysfs.c
index eb25627b0..21ebd0af2 100644
--- a/drivers/dca/dca-sysfs.c
+++ b/drivers/dca/dca-sysfs.c
@@ -24,9 +24,7 @@ int dca_sysfs_add_req(struct dca_provider *dca, struct device *dev, int slot)
 
 	cd = device_create(dca_class, dca->cd, MKDEV(0, slot + 1), NULL,
 			   "requester%d", req_count++);
-	if (IS_ERR(cd))
-		return PTR_ERR(cd);
-	return 0;
+	return PTR_ERR_OR_ZERO(cd);
 }
 
 void dca_sysfs_remove_req(struct dca_provider *dca, int slot)
-- 
2.20.1.windows.1



