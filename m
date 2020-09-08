Return-Path: <SRS0=o+hd=CR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFAF8C43461
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 19:32:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 795A220658
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 19:32:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599593520;
	bh=iKePNMRyYjuk70vMsaDLL0LcdLKGJj7Qdt4/LFD3uuE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Y2LuRhXT36H7VUrulFE2bhQPylqhaqsIlu6EZLPq690juy+ElQi0M5hUAIw3HM/b3
	 +8DhIujc8uyg0GfzYdoG1/15mWy4ipPY5uN+B25Hxcfu3J2IRtj/PIFe7sA28AGV7F
	 OPwus9q6S/a/xcvbENAwqD5TME5UFUjnGuBo2438=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732113AbgIHTb7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Sep 2020 15:31:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:47726 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730999AbgIHP6F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 11:58:05 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6E9C923D3C;
        Tue,  8 Sep 2020 15:37:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599579449;
        bh=iKePNMRyYjuk70vMsaDLL0LcdLKGJj7Qdt4/LFD3uuE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=p9qo7YP9qXUu2VLBiHWyBeTOkT0vDQqnTnlCFCRWmc1GMuIWe7EnmVhYyto06Dsbb
         ksHQiSSmQibj3l7LdU9Eh4wQRS55HKvov3rcNzYvtdAUOR/nsbiZjsL5YRcaWxDb+b
         r7fNkoZIbCN7Saa6NQsfb5qosScOu7tdWlPqjG98=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Jussi Kivilinna <jussi.kivilinna@haltian.com>,
        Sven Eckelmann <sven@narfation.org>,
        Simon Wunderlich <sw@simonwunderlich.de>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.8 042/186] batman-adv: bla: use netif_rx_ni when not in interrupt context
Date:   Tue,  8 Sep 2020 17:23:04 +0200
Message-Id: <20200908152243.708000869@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200908152241.646390211@linuxfoundation.org>
References: <20200908152241.646390211@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jussi Kivilinna <jussi.kivilinna@haltian.com>

[ Upstream commit 279e89b2281af3b1a9f04906e157992c19c9f163 ]

batadv_bla_send_claim() gets called from worker thread context through
batadv_bla_periodic_work(), thus netif_rx_ni needs to be used in that
case. This fixes "NOHZ: local_softirq_pending 08" log messages seen
when batman-adv is enabled.

Fixes: 23721387c409 ("batman-adv: add basic bridge loop avoidance code")
Signed-off-by: Jussi Kivilinna <jussi.kivilinna@haltian.com>
Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/batman-adv/bridge_loop_avoidance.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/net/batman-adv/bridge_loop_avoidance.c b/net/batman-adv/bridge_loop_avoidance.c
index 41cc87f06b142..cfb9e16afe38a 100644
--- a/net/batman-adv/bridge_loop_avoidance.c
+++ b/net/batman-adv/bridge_loop_avoidance.c
@@ -437,7 +437,10 @@ static void batadv_bla_send_claim(struct batadv_priv *bat_priv, u8 *mac,
 	batadv_add_counter(bat_priv, BATADV_CNT_RX_BYTES,
 			   skb->len + ETH_HLEN);
 
-	netif_rx(skb);
+	if (in_interrupt())
+		netif_rx(skb);
+	else
+		netif_rx_ni(skb);
 out:
 	if (primary_if)
 		batadv_hardif_put(primary_if);
-- 
2.25.1



