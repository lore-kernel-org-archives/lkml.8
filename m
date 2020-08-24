Return-Path: <SRS0=wYIT=CC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16671C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 09:44:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E44582071E
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 09:44:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598262289;
	bh=I2rc69Oc47pz8Ily187amhLgZCDrNoxj7kJnj5evJDg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=PNEx8xaTUXwUrNFqCaY20Jnf6BnKd//7zzl2Ct13VSIKaUO2y3M1e2yvSq4cTAWSx
	 LjzbQz7FKKbz/D9Drcg6SpWhoGhjFQorQob/WVNo0ZDfjbNOqmIZ0vR8el0aDIsUkG
	 NBmVohiLWPz9HfH3n8FZO7P29jdhLeyCjaqnLB0I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729086AbgHXJor (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Aug 2020 05:44:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:37214 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728748AbgHXInO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Aug 2020 04:43:14 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D24702075B;
        Mon, 24 Aug 2020 08:43:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598258594;
        bh=I2rc69Oc47pz8Ily187amhLgZCDrNoxj7kJnj5evJDg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=yCVk4FzQmZt4yhRK78gXWQ4kyuBH5g8WpadEN3FpTAXCojRlcepRitco7reBp4phK
         CX5Uo9tvBoO1jogZ7TFB3d4K2QGK67T7J67q6yKK1MqgoW85prWZ/IdDRILtZ44ghT
         P06ayo9nLLJZIrDlq/kWGCylePdfyD0fYkdLbLVo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Henrique Figueira <henrislip@gmail.com>,
        Oleksij Rempel <o.rempel@pengutronix.de>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.7 072/124] can: j1939: transport: add j1939_session_skb_find_by_offset() function
Date:   Mon, 24 Aug 2020 10:30:06 +0200
Message-Id: <20200824082412.956507491@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200824082409.368269240@linuxfoundation.org>
References: <20200824082409.368269240@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Oleksij Rempel <o.rempel@pengutronix.de>

[ Upstream commit 840835c9281215341d84966a8855f267a971e6a3 ]

Sometimes it makes no sense to search the skb by pkt.dpo, since we need
next the skb within the transaction block. This may happen if we have an
ETP session with CTS set to less than 255 packets.

After this patch, we will be able to work with ETP sessions where the
block size (ETP.CM_CTS byte 2) is less than 255 packets.

Reported-by: Henrique Figueira <henrislip@gmail.com>
Reported-by: https://github.com/linux-can/can-utils/issues/228
Fixes: 9d71dd0c7009 ("can: add support of SAE J1939 protocol")
Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
Link: https://lore.kernel.org/r/20200807105200.26441-5-o.rempel@pengutronix.de
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/can/j1939/transport.c | 22 +++++++++++++++-------
 1 file changed, 15 insertions(+), 7 deletions(-)

diff --git a/net/can/j1939/transport.c b/net/can/j1939/transport.c
index 30957c9a8eb7a..90a2baac8a4aa 100644
--- a/net/can/j1939/transport.c
+++ b/net/can/j1939/transport.c
@@ -352,17 +352,16 @@ void j1939_session_skb_queue(struct j1939_session *session,
 	skb_queue_tail(&session->skb_queue, skb);
 }
 
-static struct sk_buff *j1939_session_skb_find(struct j1939_session *session)
+static struct
+sk_buff *j1939_session_skb_find_by_offset(struct j1939_session *session,
+					  unsigned int offset_start)
 {
 	struct j1939_priv *priv = session->priv;
+	struct j1939_sk_buff_cb *do_skcb;
 	struct sk_buff *skb = NULL;
 	struct sk_buff *do_skb;
-	struct j1939_sk_buff_cb *do_skcb;
-	unsigned int offset_start;
 	unsigned long flags;
 
-	offset_start = session->pkt.dpo * 7;
-
 	spin_lock_irqsave(&session->skb_queue.lock, flags);
 	skb_queue_walk(&session->skb_queue, do_skb) {
 		do_skcb = j1939_skb_to_cb(do_skb);
@@ -382,6 +381,14 @@ static struct sk_buff *j1939_session_skb_find(struct j1939_session *session)
 	return skb;
 }
 
+static struct sk_buff *j1939_session_skb_find(struct j1939_session *session)
+{
+	unsigned int offset_start;
+
+	offset_start = session->pkt.dpo * 7;
+	return j1939_session_skb_find_by_offset(session, offset_start);
+}
+
 /* see if we are receiver
  * returns 0 for broadcasts, although we will receive them
  */
@@ -766,7 +773,7 @@ static int j1939_session_tx_dat(struct j1939_session *session)
 	int ret = 0;
 	u8 dat[8];
 
-	se_skb = j1939_session_skb_find(session);
+	se_skb = j1939_session_skb_find_by_offset(session, session->pkt.tx * 7);
 	if (!se_skb)
 		return -ENOBUFS;
 
@@ -1765,7 +1772,8 @@ static void j1939_xtp_rx_dat_one(struct j1939_session *session,
 			    __func__, session);
 		goto out_session_cancel;
 	}
-	se_skb = j1939_session_skb_find(session);
+
+	se_skb = j1939_session_skb_find_by_offset(session, packet * 7);
 	if (!se_skb) {
 		netdev_warn(priv->ndev, "%s: 0x%p: no skb found\n", __func__,
 			    session);
-- 
2.25.1



