Return-Path: <SRS0=iZCi=CS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6249DC433E2
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 05:18:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1533321D40
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 05:18:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=me.com header.i=@me.com header.b="xzPBsvUz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726005AbgIIFSB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Sep 2020 01:18:01 -0400
Received: from mr85p00im-hyfv06021401.me.com ([17.58.23.190]:50335 "EHLO
        mr85p00im-hyfv06021401.me.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725772AbgIIFSB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Sep 2020 01:18:01 -0400
X-Greylist: delayed 338 seconds by postgrey-1.27 at vger.kernel.org; Wed, 09 Sep 2020 01:18:01 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=me.com; s=1a1hai;
        t=1599628342; bh=Wx7CdgvR0x2FU5ZQ+IXCDMPlwOpOHWjeFt6nBqtZ8ks=;
        h=From:To:Subject:Date:Message-Id;
        b=xzPBsvUzfTFjny8P9/eiO0u2x9aRGyii1Ain6lm2e3Aj+7FXypoUrOXIctWryFLns
         yiFTnx0KKBsGBqBh4dqN2WMCJc1ZJg+xjYzSM82rUQ/BTtcoLidI9Qodi0A9YP9RdT
         RrqNlcnjH7HHbJPCOqwtT9opDiE4Y+MZlg30jptdLYAl44FGtbZD5tyUzh4ZHDPVsB
         b0OKYahihqC/hRjLvtMJrPSJLDR93YG8HPpxaYDHXOOUR0SuTJWcIcNhnG9/a2eC2l
         r/cJbXTXM0i5XiCQf1mGQGFHYOqhpLx2GGB2U9ABs+GhJ9r7m3dg5VWRRYqKMl6RWm
         t5n0ZoYOhJ74A==
Received: from localhost (unknown [80.214.153.78])
        by mr85p00im-hyfv06021401.me.com (Postfix) with ESMTPSA id 3A9E59C01B1;
        Wed,  9 Sep 2020 05:12:22 +0000 (UTC)
From:   Alain Volmat <avolmat@me.com>
To:     Jassi Brar <jaswinder.singh@linaro.org>,
        Lee Jones <lee.jones@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Patrice Chotard <patrice.chotard@st.com>, avolmat@me.com
Subject: [PATCH v2] mailbox: sti: fix struct description warnings
Date:   Wed,  9 Sep 2020 07:12:19 +0200
Message-Id: <20200909051219.4531-1-avolmat@me.com>
X-Mailer: git-send-email 2.17.1
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-09-09_03:2020-09-08,2020-09-09 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015 mlxscore=0
 mlxlogscore=570 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-2006250000 definitions=main-2009090047
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix formating of struct description to avoid warning highlighted
by W=1 compilation.

Signed-off-by: Alain Volmat <avolmat@me.com>
---
v2: fixes tag removed

 drivers/mailbox/mailbox-sti.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/mailbox/mailbox-sti.c b/drivers/mailbox/mailbox-sti.c
index 2baf69a0b81c..0f2bc09c364d 100644
--- a/drivers/mailbox/mailbox-sti.c
+++ b/drivers/mailbox/mailbox-sti.c
@@ -36,7 +36,7 @@
 #define MBOX_BASE(mdev, inst)   ((mdev)->base + ((inst) * 4))
 
 /**
- * STi Mailbox device data
+ * struct sti_mbox_device - STi Mailbox device data
  *
  * An IP Mailbox is currently composed of 4 instances
  * Each instance is currently composed of 32 channels
@@ -60,7 +60,7 @@ struct sti_mbox_device {
 };
 
 /**
- * STi Mailbox platform specific configuration
+ * struct sti_mbox_pdata - STi Mailbox platform specific configuration
  *
  * @num_inst:	Maximum number of instances in one HW Mailbox
  * @num_chan:	Maximum number of channel per instance
@@ -71,7 +71,7 @@ struct sti_mbox_pdata {
 };
 
 /**
- * STi Mailbox allocated channel information
+ * struct sti_channel - STi Mailbox allocated channel information
  *
  * @mdev:	Pointer to parent Mailbox device
  * @instance:	Instance number channel resides in
-- 
2.17.1

