Return-Path: <SRS0=wESH=6W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD4DDC38A2A
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 12:45:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AFD2F221F7
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 12:45:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588941951;
	bh=KvLHU9qvwL40HmI3IBQBsHdnpHTg5jiXzNUjFjv4S2U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=N7uE2U+9j1CFFr264E1Kj3eVwyHRsWPg53RO/7XWMZOLgwCm+oNQJIb7XpYVZMOQ2
	 DYbY6DBl3btQxwRrDHg1jLkMi1ytNqpsncn8hk3uqoU9/scrwahU0dRu0Aow9/D2S/
	 GICB9j4Ei5nqm6dYF1OCl3qXCREs7J0hV3cu/7vM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728972AbgEHMpv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 May 2020 08:45:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:45568 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728686AbgEHMpi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 08:45:38 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D140A21473;
        Fri,  8 May 2020 12:45:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588941938;
        bh=KvLHU9qvwL40HmI3IBQBsHdnpHTg5jiXzNUjFjv4S2U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lwaiAdy576b3Lme93prMwen/sMBIp9IftaJjWi7Yy/uahnmZPAeEWYbtpXmuIxcD2
         c4ppN1n9wz0PysQ2CVVuAYJel3aIn6QvK5IEgy0ZqzsDVnyfAFgeakog5zsGl3aW2z
         EYlrSWSKJW9ujvEYRvpKEQFsaPuBpUuubl5elDT0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Tom Herbert <tom@herbertland.com>,
        Hannes Frederic Sowa <hannes@stressinduktion.org>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.4 193/312] ipv6: fix checksum annotation in udp6_csum_init
Date:   Fri,  8 May 2020 14:33:04 +0200
Message-Id: <20200508123138.026787779@linuxfoundation.org>
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

From: Hannes Frederic Sowa <hannes@stressinduktion.org>

commit c148d16369ff0095eca950d17968ba1d56a47b53 upstream.

Cc: Tom Herbert <tom@herbertland.com>
Fixes: 4068579e1e098fa ("net: Implmement RFC 6936 (zero RX csums for UDP/IPv6")
Signed-off-by: Hannes Frederic Sowa <hannes@stressinduktion.org>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 net/ipv6/ip6_checksum.c |    7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

--- a/net/ipv6/ip6_checksum.c
+++ b/net/ipv6/ip6_checksum.c
@@ -84,9 +84,12 @@ int udp6_csum_init(struct sk_buff *skb,
 	 * we accept a checksum of zero here. When we find the socket
 	 * for the UDP packet we'll check if that socket allows zero checksum
 	 * for IPv6 (set by socket option).
+	 *
+	 * Note, we are only interested in != 0 or == 0, thus the
+	 * force to int.
 	 */
-	return skb_checksum_init_zero_check(skb, proto, uh->check,
-					   ip6_compute_pseudo);
+	return (__force int)skb_checksum_init_zero_check(skb, proto, uh->check,
+							 ip6_compute_pseudo);
 }
 EXPORT_SYMBOL(udp6_csum_init);
 


