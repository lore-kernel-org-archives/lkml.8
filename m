Return-Path: <SRS0=wESH=6W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6439C47254
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 13:17:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A7CE820870
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 13:17:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588943834;
	bh=WcvbQdpiOrU41A2xIWY+x5N+ShuoIKEUf0ewgsn0jUw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=f7lSrPPdiqpLAKezQ3w/5HjaAxZwYoGuK8494rmD6PrvQBbkbJzOEDOkaEbcUt6rj
	 2M9zWWH11Yv6BhrDtkNP5Tta/pcIcoG1o1WnnsmK3wXl7lhaH9hPCbIp0KRCi42gPM
	 2viiKds3SMcRLz26GzDG1JFzhBWd8J1KzE0kZxo4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728938AbgEHNRO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 May 2020 09:17:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:42634 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728778AbgEHMoR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 08:44:17 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1C76E208D6;
        Fri,  8 May 2020 12:44:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588941857;
        bh=WcvbQdpiOrU41A2xIWY+x5N+ShuoIKEUf0ewgsn0jUw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bAmefoGe4G7zAzQSrNPk9EI8oSiq8ENyYa4Yql48xSr91KE9IbwWLA5/es1hImKZx
         oQHqUKZBYPeJiI2JL3+kG8EkbOQzUoj6UDWNTxecF8oyWy6E7G4KKesVAyZ1YwsyGF
         cQptg2gps/vuA3UGH45qpB3kLSPKSq44CEnrMy4s=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Pablo Neira Ayuso <pablo@netfilter.org>,
        Eric Dumazet <edumazet@google.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.4 201/312] udp: restore UDPlite many-cast delivery
Date:   Fri,  8 May 2020 14:33:12 +0200
Message-Id: <20200508123138.570843872@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200508123124.574959822@linuxfoundation.org>
References: <20200508123124.574959822@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pablo Neira <pablo@netfilter.org>

commit 73e2d5e34b6cdd1080038daf3d6d6d744a9eefe6 upstream.

Honor udptable parameter that is passed to __udp*_lib_mcast_deliver(),
otherwise udplite broadcast/multicast use the wrong table and it breaks.

Fixes: 2dc41cff7545 ("udp: Use hash2 for long hash1 chains in __udp*_lib_mcast_deliver.")
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Acked-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 net/ipv4/udp.c |    6 +++---
 net/ipv6/udp.c |    6 +++---
 2 files changed, 6 insertions(+), 6 deletions(-)

--- a/net/ipv4/udp.c
+++ b/net/ipv4/udp.c
@@ -1685,10 +1685,10 @@ static int __udp4_lib_mcast_deliver(stru
 
 	if (use_hash2) {
 		hash2_any = udp4_portaddr_hash(net, htonl(INADDR_ANY), hnum) &
-			    udp_table.mask;
-		hash2 = udp4_portaddr_hash(net, daddr, hnum) & udp_table.mask;
+			    udptable->mask;
+		hash2 = udp4_portaddr_hash(net, daddr, hnum) & udptable->mask;
 start_lookup:
-		hslot = &udp_table.hash2[hash2];
+		hslot = &udptable->hash2[hash2];
 		offset = offsetof(typeof(*sk), __sk_common.skc_portaddr_node);
 	}
 
--- a/net/ipv6/udp.c
+++ b/net/ipv6/udp.c
@@ -801,10 +801,10 @@ static int __udp6_lib_mcast_deliver(stru
 
 	if (use_hash2) {
 		hash2_any = udp6_portaddr_hash(net, &in6addr_any, hnum) &
-			    udp_table.mask;
-		hash2 = udp6_portaddr_hash(net, daddr, hnum) & udp_table.mask;
+			    udptable->mask;
+		hash2 = udp6_portaddr_hash(net, daddr, hnum) & udptable->mask;
 start_lookup:
-		hslot = &udp_table.hash2[hash2];
+		hslot = &udptable->hash2[hash2];
 		offset = offsetof(typeof(*sk), __sk_common.skc_portaddr_node);
 	}
 


