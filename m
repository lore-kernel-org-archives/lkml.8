Return-Path: <SRS0=8grS=CJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5CF2C433E2
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 16:52:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BBFDB20707
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 16:52:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=me.com header.i=@me.com header.b="XVcNETxo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728748AbgHaQwH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 31 Aug 2020 12:52:07 -0400
Received: from st43p00im-zteg10063501.me.com ([17.58.63.176]:36644 "EHLO
        st43p00im-zteg10063501.me.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727114AbgHaQwF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Aug 2020 12:52:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=me.com; s=1a1hai;
        t=1598892723; bh=DNlHU0ivrGOqblJBFHDGPregVjE9x7n5r3lIlIsXHf4=;
        h=From:To:Subject:Date:Message-Id;
        b=XVcNETxouNsi+OIlZBgotuq0RfeDZhFe3L8eE1L1w3b1aNDQrttzPrSWrgtmqoFi+
         AAfrn4swuBGgFVg6msjLSfehdFg2Ub04+IJLJoUbrjhC/t1POsrXWni8hq7TvJxLh6
         tg7Ef9mYUekUfI5gnMisQSmqYyF+rhtvWXaFKktKJReNqKzfnodIs9azUv8hxBbDY7
         710PxNNkRoWaYJFICYYp5KcOHKlUhKTz27H0yw+MMXMv/6F47Ps2fQ2lezgZnOyB/b
         V4GL1wJklbOm8zL0iC9F22IoESHic9skjAxnuFx8lLb9dzLm0qAfj6QwFlv1OrvEKP
         ZJ/5UGB5tXhpA==
Received: from localhost (unknown [80.214.210.192])
        by st43p00im-zteg10063501.me.com (Postfix) with ESMTPSA id 609F6C8096A;
        Mon, 31 Aug 2020 16:52:03 +0000 (UTC)
From:   Alain Volmat <avolmat@me.com>
To:     Jassi Brar <jaswinder.singh@linaro.org>,
        Lee Jones <lee.jones@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Patrice Chotard <patrice.chotard@st.com>, avolmat@me.com
Subject: [PATCH] mailbox: sti: fix struct description warnings
Date:   Mon, 31 Aug 2020 18:52:01 +0200
Message-Id: <20200831165201.23832-1-avolmat@me.com>
X-Mailer: git-send-email 2.17.1
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-08-31_08:2020-08-31,2020-08-31 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011 mlxscore=0
 mlxlogscore=610 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-2006250000 definitions=main-2008310101
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix formating of struct description to avoid warning highlighted
by W=1 compilation.

Fixes: 9ef4546cbd7e ("mailbox: Add support for ST's Mailbox IP")
Signed-off-by: Alain Volmat <avolmat@me.com>
---
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

