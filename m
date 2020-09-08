Return-Path: <SRS0=o+hd=CR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 176C5C43461
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 17:27:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B51B62078B
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 17:27:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599586053;
	bh=7Pzg1WVdz2wq0y7jIJVV0/6t7pgXAjx9arQklN+Os+0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=uvvsKP1JRdnqessN//I6CQ179p8HcccSri5qjaQHI0p0CryarlBrXZdE1khnPLIXj
	 2AxxTy/64WdLPvWkzlAQU2eYZdd1lGnnlSegoMQvmErvOPTREdm5m0l/VF0iW8GvnB
	 5cFHiMt1k+Gsgs5ZdzVkFLBzmRmkkO4BrhG3tX0Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731873AbgIHR1c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Sep 2020 13:27:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:58436 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731510AbgIHQQ5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 12:16:57 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 68FA42482B;
        Tue,  8 Sep 2020 15:44:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599579883;
        bh=7Pzg1WVdz2wq0y7jIJVV0/6t7pgXAjx9arQklN+Os+0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oE1EC1P3+K7cfPl2h8QxzDOiiK2rK9jgpr6F7NySnZI9Yg2/Gy01um/i75EwXU+hV
         Q72BVwpllqsO0DhnQ3tFb1Ql2IBpqEaDPomS7QiIoTJ64YFvHC0zapzF8mgcBfnTwn
         AQjCfpMq85+f19FSKJiGnsWPFC28re7bZzzqK5Os=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Or Cohen <orcohen@paloaltonetworks.com>,
        Eric Dumazet <edumazet@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 071/129] net/packet: fix overflow in tpacket_rcv
Date:   Tue,  8 Sep 2020 17:25:12 +0200
Message-Id: <20200908152233.248148317@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200908152229.689878733@linuxfoundation.org>
References: <20200908152229.689878733@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Or Cohen <orcohen@paloaltonetworks.com>

[ Upstream commit acf69c946233259ab4d64f8869d4037a198c7f06 ]

Using tp_reserve to calculate netoff can overflow as
tp_reserve is unsigned int and netoff is unsigned short.

This may lead to macoff receving a smaller value then
sizeof(struct virtio_net_hdr), and if po->has_vnet_hdr
is set, an out-of-bounds write will occur when
calling virtio_net_hdr_from_skb.

The bug is fixed by converting netoff to unsigned int
and checking if it exceeds USHRT_MAX.

This addresses CVE-2020-14386

Fixes: 8913336a7e8d ("packet: add PACKET_RESERVE sockopt")
Signed-off-by: Or Cohen <orcohen@paloaltonetworks.com>
Signed-off-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/packet/af_packet.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/net/packet/af_packet.c b/net/packet/af_packet.c
index 7735340c892eb..fbc2d4dfddf0e 100644
--- a/net/packet/af_packet.c
+++ b/net/packet/af_packet.c
@@ -2169,7 +2169,8 @@ static int tpacket_rcv(struct sk_buff *skb, struct net_device *dev,
 	int skb_len = skb->len;
 	unsigned int snaplen, res;
 	unsigned long status = TP_STATUS_USER;
-	unsigned short macoff, netoff, hdrlen;
+	unsigned short macoff, hdrlen;
+	unsigned int netoff;
 	struct sk_buff *copy_skb = NULL;
 	struct timespec ts;
 	__u32 ts_status;
@@ -2238,6 +2239,10 @@ static int tpacket_rcv(struct sk_buff *skb, struct net_device *dev,
 		}
 		macoff = netoff - maclen;
 	}
+	if (netoff > USHRT_MAX) {
+		atomic_inc(&po->tp_drops);
+		goto drop_n_restore;
+	}
 	if (po->tp_version <= TPACKET_V2) {
 		if (macoff + snaplen > po->rx_ring.frame_size) {
 			if (po->copy_thresh &&
-- 
2.25.1



