Return-Path: <SRS0=9JlO=3L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D0FCC2D0DB
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 09:36:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6576B20704
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 09:36:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579685798;
	bh=dO5e43ufofDwgysyhPIszf1u9ISv3J4K7wcgkh0Uwww=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=h/oW+tp4jtKwZwGKOEhzLaSa7Qncx+V4Zoif1yqwywjsRzOyU7QJjYrolaUeaUfmB
	 Iz0avIUGci4C+DMcfRHaXV0qmEa5TkmeDK/GkpqUD4IDWQsDKKjRZUj9XoisO6RgPd
	 xIDI4GCdXWQJEY1n4SmPMEVNK+m3WP45jWpxDJwc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731125AbgAVJgh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jan 2020 04:36:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:52042 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731934AbgAVJgc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jan 2020 04:36:32 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B388C20704;
        Wed, 22 Jan 2020 09:36:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579685792;
        bh=dO5e43ufofDwgysyhPIszf1u9ISv3J4K7wcgkh0Uwww=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=2g75wB6P5TBMyVZX+RaIeJC2crwLwFBmYo2x4SKay7nctVqB7aNfnTxk+71Rcw85E
         dlF7NhITmtWRQUbJm9uCS5kwSBhncJUeMFnwCB2pbhyu9gHEKnfSJ9R5zf1ETVM2XR
         xlXmzjxjZOORtF4rYXKoenCaU7T+i3gUqLn7XCKU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Sven Eckelmann <sven@narfation.org>,
        Simon Wunderlich <sw@simonwunderlich.de>
Subject: [PATCH 4.9 80/97] batman-adv: Fix DAT candidate selection on little endian systems
Date:   Wed, 22 Jan 2020 10:29:24 +0100
Message-Id: <20200122092809.206278846@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200122092755.678349497@linuxfoundation.org>
References: <20200122092755.678349497@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sven Eckelmann <sven@narfation.org>

commit 4cc4a1708903f404d2ca0dfde30e71e052c6cbc9 upstream.

The distributed arp table is using a DHT to store and retrieve MAC address
information for an IP address. This is done using unicast messages to
selected peers. The potential peers are looked up using the IP address and
the VID.

While the IP address is always stored in big endian byte order, this is not
the case of the VID. It can (depending on the host system) either be big
endian or little endian. The host must therefore always convert it to big
endian to ensure that all devices calculate the same peers for the same
lookup data.

Fixes: be1db4f6615b ("batman-adv: make the Distributed ARP Table vlan aware")
Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 net/batman-adv/distributed-arp-table.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- a/net/batman-adv/distributed-arp-table.c
+++ b/net/batman-adv/distributed-arp-table.c
@@ -242,6 +242,7 @@ static u32 batadv_hash_dat(const void *d
 	u32 hash = 0;
 	const struct batadv_dat_entry *dat = data;
 	const unsigned char *key;
+	__be16 vid;
 	u32 i;
 
 	key = (const unsigned char *)&dat->ip;
@@ -251,7 +252,8 @@ static u32 batadv_hash_dat(const void *d
 		hash ^= (hash >> 6);
 	}
 
-	key = (const unsigned char *)&dat->vid;
+	vid = htons(dat->vid);
+	key = (__force const unsigned char *)&vid;
 	for (i = 0; i < sizeof(dat->vid); i++) {
 		hash += key[i];
 		hash += (hash << 10);


