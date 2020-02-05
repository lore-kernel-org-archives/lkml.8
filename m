Return-Path: <SRS0=fqu/=3Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA3FAC35249
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 03:23:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7CA93214AF
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 03:23:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727899AbgBEDXd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Feb 2020 22:23:33 -0500
Received: from out30-54.freemail.mail.aliyun.com ([115.124.30.54]:52236 "EHLO
        out30-54.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727714AbgBEDXd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Feb 2020 22:23:33 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01f04427;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0TpA7DPY_1580873008;
Received: from IT-FVFX43SYHV2H.lan(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0TpA7DPY_1580873008)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 05 Feb 2020 11:23:29 +0800
Subject: [PATCH v2] net/bluetooth: remove __get_channel/dir and __dir
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     Johan Hedberg <johan.hedberg@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1579596583-258090-1-git-send-email-alex.shi@linux.alibaba.com>
 <8CA3EF63-F688-48B2-A21D-16FDBC809EDE@holtmann.org>
 <09359312-a1c8-c560-85ba-0f94be521b26@linux.alibaba.com>
 <2287CD53-58F4-40FD-B2F3-81A9F22F4731@holtmann.org>
From:   Alex Shi <alex.shi@linux.alibaba.com>
Message-ID: <1e76a7b8-c90a-56fe-96d7-4088dc7f6c38@linux.alibaba.com>
Date:   Wed, 5 Feb 2020 11:23:27 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <2287CD53-58F4-40FD-B2F3-81A9F22F4731@holtmann.org>
Content-Type: text/plain; charset=gbk
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


These 3 macros are never used from first git commit Linux-2.6.12-rc2.
let's remove them.

Signed-off-by: Alex Shi <alex.shi@linux.alibaba.com>
Cc: Marcel Holtmann <marcel@holtmann.org>
Cc: Johan Hedberg <johan.hedberg@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc: linux-bluetooth@vger.kernel.org
Cc: netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---
 net/bluetooth/rfcomm/core.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/net/bluetooth/rfcomm/core.c b/net/bluetooth/rfcomm/core.c
index 3a9e9d9670be..dcecce087b24 100644
--- a/net/bluetooth/rfcomm/core.c
+++ b/net/bluetooth/rfcomm/core.c
@@ -73,8 +73,6 @@ static struct rfcomm_session *rfcomm_session_create(bdaddr_t *src,
 
 /* ---- RFCOMM frame parsing macros ---- */
 #define __get_dlci(b)     ((b & 0xfc) >> 2)
-#define __get_channel(b)  ((b & 0xf8) >> 3)
-#define __get_dir(b)      ((b & 0x04) >> 2)
 #define __get_type(b)     ((b & 0xef))
 
 #define __test_ea(b)      ((b & 0x01))
@@ -87,7 +85,6 @@ static struct rfcomm_session *rfcomm_session_create(bdaddr_t *src,
 #define __ctrl(type, pf)       (((type & 0xef) | (pf << 4)))
 #define __dlci(dir, chn)       (((chn & 0x1f) << 1) | dir)
 #define __srv_channel(dlci)    (dlci >> 1)
-#define __dir(dlci)            (dlci & 0x01)
 
 #define __len8(len)       (((len) << 1) | 1)
 #define __len16(len)      ((len) << 1)
-- 
1.8.3.1


