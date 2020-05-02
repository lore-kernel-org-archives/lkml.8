Return-Path: <SRS0=7DLR=6Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7318FC47254
	for <linux-kernel@archiver.kernel.org>; Sat,  2 May 2020 14:26:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 538C924957
	for <linux-kernel@archiver.kernel.org>; Sat,  2 May 2020 14:26:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588429603;
	bh=YvxFUYuigZdc0KTPd4GDgesgJeYEt11Ws668XNp1wH4=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=dtmsBvqWy5dzAxggTfVw58BV8c5be7O6XD03rZe6dJJDteo9PRXNWafl5ZHdETTw3
	 2mqvxxjm3AWi82KjZfjJ6qrRJxO3gGdJee+Yflrz3T0lpZzlL6jagOYNqOoXbDZU7k
	 x/GifqoEY3/nRz64ZuFaCKRS95vByJEpI+NcuUtY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728141AbgEBO0m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 2 May 2020 10:26:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:57666 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728020AbgEBO0m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 May 2020 10:26:42 -0400
Received: from localhost (p5486C608.dip0.t-ipconnect.de [84.134.198.8])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7E02121835;
        Sat,  2 May 2020 14:26:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588429602;
        bh=YvxFUYuigZdc0KTPd4GDgesgJeYEt11Ws668XNp1wH4=;
        h=From:To:Cc:Subject:Date:From;
        b=etxkaxsU5RbnqKZGuG7N+Cht75P+aGmHwUmBT9y6+2xs0orWOnbWOU05QUgJzNiVb
         zYxWKPwp2pd6VY5jkcjFcTMIoKYAy+lZqrp4PWGSz/LVjHDIGh90sIljhQQ/26/tY+
         BGPT+dzugW5jjBvZxa0Fa30vWmVi4L0fv56WETQs=
From:   Wolfram Sang <wsa@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     kernel@pengutronix.de, Wolfram Sang <wsa@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-input@vger.kernel.org
Subject: [PATCH] input: lm8333: update contact email
Date:   Sat,  2 May 2020 16:26:39 +0200
Message-Id: <20200502142639.18925-1-wsa@kernel.org>
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
 include/linux/input/lm8333.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/input/lm8333.h b/include/linux/input/lm8333.h
index 79f918c6e8c5..906da5fc06e0 100644
--- a/include/linux/input/lm8333.h
+++ b/include/linux/input/lm8333.h
@@ -1,6 +1,6 @@
 /*
  * public include for LM8333 keypad driver - same license as driver
- * Copyright (C) 2012 Wolfram Sang, Pengutronix <w.sang@pengutronix.de>
+ * Copyright (C) 2012 Wolfram Sang, Pengutronix <kernel@pengutronix.de>
  */
 
 #ifndef _LM8333_H
-- 
2.20.1

