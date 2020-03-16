Return-Path: <SRS0=ltrd=5B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E4A0C0044D
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 07:04:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D95920575
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 07:04:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729813AbgCPHEg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Mar 2020 03:04:36 -0400
Received: from aliyun-cloud.icoremail.net ([47.90.88.95]:34886 "HELO
        aliyun-sdnproxy-1.icoremail.net" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with SMTP id S1729723AbgCPHEg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Mar 2020 03:04:36 -0400
Received: from 137.localdomain (unknown [218.107.205.216])
        by app1 (Coremail) with SMTP id xjNnewDn7Q1cHm9ew20FAA--.217S4;
        Mon, 16 Mar 2020 14:36:24 +0800 (CST)
From:   Pengcheng Yang <yangpc@wangsu.com>
To:     edumazet@google.com, ncardwell@google.com, davem@davemloft.net
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Pengcheng Yang <yangpc@wangsu.com>
Subject: [PATCH RESEND net-next v2 2/5] tcp: fix stretch ACK bugs in Scalable
Date:   Mon, 16 Mar 2020 14:35:08 +0800
Message-Id: <1584340511-9870-3-git-send-email-yangpc@wangsu.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1584340511-9870-1-git-send-email-yangpc@wangsu.com>
References: <1584340511-9870-1-git-send-email-yangpc@wangsu.com>
X-CM-TRANSID: xjNnewDn7Q1cHm9ew20FAA--.217S4
X-Coremail-Antispam: 1UD129KBjvJXoW7Aw4rWryDXr1xJr4furyDJrb_yoW8XFWUpF
        s8Gw1Fkr45WrySgayS9Fy5JF15GwsavFy7Gry2krn3Aws8Gr93tF1kt3y5tFWUA3yxC39I
        krWj93WxWF9YyrUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUgI1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l8cAvFVAK
        0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4
        x0Y4vE2Ix0cI8IcVCY1x0267AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28E
        F7xvwVC2z280aVCY1x0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F4
        0EFcxC0VAKzVAqx4xG6I80ewAv7VCjz48v1sIEY20_Gr4lOx8S6xCaFVCjc4AY6r1j6r4U
        M4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCY02Avz4vE14v_GF1l42
        xK82IYc2Ij64vIr41l42xK82IY6x8ErcxFaVAv8VW8GwCFx2IqxVCFs4IE7xkEbVWUJVW8
        JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1V
        AFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xII
        jxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4
        A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU
        0xZFpf9x0Jj2-eOUUUUU=
X-CM-SenderInfo: p1dqw1nf6zt0xjvxhudrp/
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Change Scalable to properly handle stretch ACKs in additive
increase mode by passing in the count of ACKed packets to
tcp_cong_avoid_ai().

In addition, because we are now precisely accounting for
stretch ACKs, including delayed ACKs, we can now change
TCP_SCALABLE_AI_CNT to 100.

Signed-off-by: Pengcheng Yang <yangpc@wangsu.com>
---
 net/ipv4/tcp_scalable.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/net/ipv4/tcp_scalable.c b/net/ipv4/tcp_scalable.c
index 471571e..6cebf41 100644
--- a/net/ipv4/tcp_scalable.c
+++ b/net/ipv4/tcp_scalable.c
@@ -10,10 +10,9 @@
 #include <net/tcp.h>
 
 /* These factors derived from the recommended values in the aer:
- * .01 and and 7/8. We use 50 instead of 100 to account for
- * delayed ack.
+ * .01 and and 7/8.
  */
-#define TCP_SCALABLE_AI_CNT	50U
+#define TCP_SCALABLE_AI_CNT	100U
 #define TCP_SCALABLE_MD_SCALE	3
 
 static void tcp_scalable_cong_avoid(struct sock *sk, u32 ack, u32 acked)
@@ -23,11 +22,13 @@ static void tcp_scalable_cong_avoid(struct sock *sk, u32 ack, u32 acked)
 	if (!tcp_is_cwnd_limited(sk))
 		return;
 
-	if (tcp_in_slow_start(tp))
-		tcp_slow_start(tp, acked);
-	else
-		tcp_cong_avoid_ai(tp, min(tp->snd_cwnd, TCP_SCALABLE_AI_CNT),
-				  1);
+	if (tcp_in_slow_start(tp)) {
+		acked = tcp_slow_start(tp, acked);
+		if (!acked)
+			return;
+	}
+	tcp_cong_avoid_ai(tp, min(tp->snd_cwnd, TCP_SCALABLE_AI_CNT),
+			  acked);
 }
 
 static u32 tcp_scalable_ssthresh(struct sock *sk)
-- 
1.8.3.1

