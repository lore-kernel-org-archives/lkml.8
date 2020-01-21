Return-Path: <SRS0=3tRb=3K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57963C2D0CE
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 08:49:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A73922522
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 08:49:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729213AbgAUIt4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jan 2020 03:49:56 -0500
Received: from out30-56.freemail.mail.aliyun.com ([115.124.30.56]:41058 "EHLO
        out30-56.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727220AbgAUItz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jan 2020 03:49:55 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R791e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04394;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0ToHVM6y_1579596590;
Received: from localhost(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0ToHVM6y_1579596590)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 21 Jan 2020 16:49:51 +0800
From:   Alex Shi <alex.shi@linux.alibaba.com>
Cc:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] net/bluetooth: remove __get_channel/dir
Date:   Tue, 21 Jan 2020 16:49:43 +0800
Message-Id: <1579596583-258090-1-git-send-email-alex.shi@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These 2 macros are never used from first git commit Linux-2.6.12-rc2. So
better to remove them.

Signed-off-by: Alex Shi <alex.shi@linux.alibaba.com>
Cc: Marcel Holtmann <marcel@holtmann.org> 
Cc: Johan Hedberg <johan.hedberg@gmail.com> 
Cc: "David S. Miller" <davem@davemloft.net> 
Cc: "Gustavo A. R. Silva" <gustavo@embeddedor.com> 
Cc: linux-bluetooth@vger.kernel.org 
Cc: netdev@vger.kernel.org 
Cc: linux-kernel@vger.kernel.org 
---
 net/bluetooth/rfcomm/core.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/net/bluetooth/rfcomm/core.c b/net/bluetooth/rfcomm/core.c
index 3a9e9d9670be..825adff79f13 100644
--- a/net/bluetooth/rfcomm/core.c
+++ b/net/bluetooth/rfcomm/core.c
@@ -73,8 +73,6 @@ static struct rfcomm_session *rfcomm_session_create(bdaddr_t *src,
 
 /* ---- RFCOMM frame parsing macros ---- */
 #define __get_dlci(b)     ((b & 0xfc) >> 2)
-#define __get_channel(b)  ((b & 0xf8) >> 3)
-#define __get_dir(b)      ((b & 0x04) >> 2)
 #define __get_type(b)     ((b & 0xef))
 
 #define __test_ea(b)      ((b & 0x01))
-- 
1.8.3.1

