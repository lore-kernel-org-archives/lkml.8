Return-Path: <SRS0=Q7wL=5E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9F84C4332E
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 13:08:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0DD320789
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 13:08:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584623283;
	bh=gAYv07o5TghqOFrz04++cKWfRcn6xhbzEmG//O5p5s0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=C41XyZ7C47w3cKIVsEOznXqFjK2Ti9+u+m124OB1bcRWmERXvt/Y4vVifvlNByPxY
	 0QgPqExxP+37uW5T9uGeAdz+14DlUazXd2jMtb1R+BY9s0H0Pa1wSxdOPJd0FJPNAE
	 Twktno1hMvd95vIC7zLkeB7RtXOJ/JJsHHuQF+rQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728073AbgCSNIC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Mar 2020 09:08:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:52058 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728048AbgCSNIA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Mar 2020 09:08:00 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9CD9620936;
        Thu, 19 Mar 2020 13:07:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584623280;
        bh=gAYv07o5TghqOFrz04++cKWfRcn6xhbzEmG//O5p5s0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AyDIpwSVes9P+5z/HT2PVke00cSuXCMXvqLMPF9zkS1kbxnh+yTwpSG2dalFQwFPH
         HBqs34btUHcUGtDayulj4hlHk6S+MQA7unnDpXXmY46HcFLmnZIFOrUVSzOf6nL5UM
         DVJ/uwB/GouvPXVvpdMXBlPusfRjH4AQ1hmYXzGs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Matthias Schiffer <mschiffer@universe-factory.net>,
        Sven Eckelmann <sven@narfation.org>
Subject: [PATCH 4.4 68/93] batman-adv: update data pointers after skb_cow()
Date:   Thu, 19 Mar 2020 14:00:12 +0100
Message-Id: <20200319123946.666505812@linuxfoundation.org>
X-Mailer: git-send-email 2.25.2
In-Reply-To: <20200319123924.795019515@linuxfoundation.org>
References: <20200319123924.795019515@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Matthias Schiffer <mschiffer@universe-factory.net>

commit bc44b78157f621ff2a2618fe287a827bcb094ac4 upstream.

batadv_check_unicast_ttvn() calls skb_cow(), so pointers into the SKB data
must be (re)set after calling it. The ethhdr variable is dropped
altogether.

Fixes: 78fc6bbe0aca ("batman-adv: add UNICAST_4ADDR packet type")
Signed-off-by: Matthias Schiffer <mschiffer@universe-factory.net>
Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/batman-adv/routing.c |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

--- a/net/batman-adv/routing.c
+++ b/net/batman-adv/routing.c
@@ -904,7 +904,6 @@ int batadv_recv_unicast_packet(struct sk
 	bool is4addr;
 
 	unicast_packet = (struct batadv_unicast_packet *)skb->data;
-	unicast_4addr_packet = (struct batadv_unicast_4addr_packet *)skb->data;
 
 	is4addr = unicast_packet->packet_type == BATADV_UNICAST_4ADDR;
 	/* the caller function should have already pulled 2 bytes */
@@ -925,9 +924,13 @@ int batadv_recv_unicast_packet(struct sk
 	if (!batadv_check_unicast_ttvn(bat_priv, skb, hdr_size))
 		return NET_RX_DROP;
 
+	unicast_packet = (struct batadv_unicast_packet *)skb->data;
+
 	/* packet for me */
 	if (batadv_is_my_mac(bat_priv, unicast_packet->dest)) {
 		if (is4addr) {
+			unicast_4addr_packet =
+				(struct batadv_unicast_4addr_packet *)skb->data;
 			subtype = unicast_4addr_packet->subtype;
 			batadv_dat_inc_counter(bat_priv, subtype);
 


