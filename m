Return-Path: <SRS0=vnT4=3J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5D9EC2D0DB
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 10:05:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9448322525
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 10:05:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727130AbgATKFV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jan 2020 05:05:21 -0500
Received: from out30-130.freemail.mail.aliyun.com ([115.124.30.130]:57837 "EHLO
        out30-130.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726075AbgATKFV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jan 2020 05:05:21 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R301e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04426;MF=wenyang@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0ToE1bps_1579514711;
Received: from localhost(mailfrom:wenyang@linux.alibaba.com fp:SMTPD_---0ToE1bps_1579514711)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 20 Jan 2020 18:05:18 +0800
From:   Wen Yang <wenyang@linux.alibaba.com>
To:     Eric Dumazet <edumazet@google.com>, davem@davemloft.net
Cc:     Wen Yang <wenyang@linux.alibaba.com>,
        Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] tcp_bbr: improve arithmetic division in bbr_update_bw()
Date:   Mon, 20 Jan 2020 18:04:56 +0800
Message-Id: <20200120100456.45609-1-wenyang@linux.alibaba.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

do_div() does a 64-by-32 division. Use div64_long() instead of it
if the divisor is long, to avoid truncation to 32-bit.
And as a nice side effect also cleans up the function a bit.

Signed-off-by: Wen Yang <wenyang@linux.alibaba.com>
Cc: Eric Dumazet <edumazet@google.com>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>
Cc: Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>
Cc: netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---
 net/ipv4/tcp_bbr.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/net/ipv4/tcp_bbr.c b/net/ipv4/tcp_bbr.c
index a6545ef0d27b..6c4d79baff26 100644
--- a/net/ipv4/tcp_bbr.c
+++ b/net/ipv4/tcp_bbr.c
@@ -779,8 +779,7 @@ static void bbr_update_bw(struct sock *sk, const struct rate_sample *rs)
 	 * bandwidth sample. Delivered is in packets and interval_us in uS and
 	 * ratio will be <<1 for most connections. So delivered is first scaled.
 	 */
-	bw = (u64)rs->delivered * BW_UNIT;
-	do_div(bw, rs->interval_us);
+	bw = div64_long((u64)rs->delivered * BW_UNIT, rs->interval_us);
 
 	/* If this sample is application-limited, it is likely to have a very
 	 * low delivered count that represents application behavior rather than
-- 
2.23.0

