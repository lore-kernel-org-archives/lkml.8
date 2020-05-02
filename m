Return-Path: <SRS0=7DLR=6Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5D2AC3A5A9
	for <linux-kernel@archiver.kernel.org>; Sat,  2 May 2020 14:27:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B29F42496A
	for <linux-kernel@archiver.kernel.org>; Sat,  2 May 2020 14:27:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588429621;
	bh=K+s5i8Ccp51nBc59RG/W0ZP/68DE7QAVr0ZSUob2qHA=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=krTvpDX5GVoQw38k6AGpEc0lhFI1SW0qcdudwpDfVaFjkR5aa/JZ1+5Mdrp50/yT8
	 J9V4n8geW4/EAGtY09AtWoF93wrYXwQuDXt7sBzWuUF2or27jxs8LiMvpR+VDfEku+
	 eV43Q1fKF0e2ai8jC4GP4IqNCJKJv5yyWFP3IZYg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728282AbgEBO1B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 2 May 2020 10:27:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:58054 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728020AbgEBO1A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 May 2020 10:27:00 -0400
Received: from localhost (p5486C608.dip0.t-ipconnect.de [84.134.198.8])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 388E324969;
        Sat,  2 May 2020 14:26:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588429619;
        bh=K+s5i8Ccp51nBc59RG/W0ZP/68DE7QAVr0ZSUob2qHA=;
        h=From:To:Cc:Subject:Date:From;
        b=r5wcyDexfab2nZ7DFyB5Y5bbcYvPVZMTevWt15zUs9b6nXeAZkMr4tAs3W+8/8cWg
         o4QN34DhSUm/tBWq7J5rUTs95ex2V4oLc0MxqSt6jkvovn6SrdBVnzlAB44Yf52NXu
         qaoGIeMC/qqu327nA2eGzn0h793vfKJ82MW3q08Y=
From:   Wolfram Sang <wsa@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     kernel@pengutronix.de, Wolfram Sang <wsa@kernel.org>,
        Wolfgang Grandegger <wg@grandegger.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        "David S. Miller" <davem@davemloft.net>, linux-can@vger.kernel.org,
        netdev@vger.kernel.org
Subject: [PATCH] can: mscan: mpc5xxx_can: update contact email
Date:   Sat,  2 May 2020 16:26:56 +0200
Message-Id: <20200502142657.19199-1-wsa@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The 'pengutronix' address is defunct for years. Use the proper contact
address.

Signed-off-by: Wolfram Sang <wsa@kernel.org>
---
 drivers/net/can/mscan/mpc5xxx_can.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/can/mscan/mpc5xxx_can.c b/drivers/net/can/mscan/mpc5xxx_can.c
index e4f4b5c9ebd6..e254e04ae257 100644
--- a/drivers/net/can/mscan/mpc5xxx_can.c
+++ b/drivers/net/can/mscan/mpc5xxx_can.c
@@ -5,7 +5,7 @@
  * Copyright (C) 2004-2005 Andrey Volkov <avolkov@varma-el.com>,
  *                         Varma Electronics Oy
  * Copyright (C) 2008-2009 Wolfgang Grandegger <wg@grandegger.com>
- * Copyright (C) 2009 Wolfram Sang, Pengutronix <w.sang@pengutronix.de>
+ * Copyright (C) 2009 Wolfram Sang, Pengutronix <kernel@pengutronix.de>
  */
 
 #include <linux/kernel.h>
-- 
2.20.1

