Return-Path: <SRS0=9JlO=3L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DATE_IN_PAST_03_06,
	DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3786DC3F68F
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 13:23:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01FFD24688
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 13:23:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579699415;
	bh=8iV/WSxnVwBToM5OZHnGrzIEhzWmi0xOLLnQqDfDNek=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=rgvDzp0R6S4cwDtzIMHPCiFaNA9820kasciEyJvEcA056rsvVtliPIFNDbDrdJJkT
	 s6e2/yf/WU2IxY2u5VaDAEekkP13bLD1bWEcJewdM5YRTlkTctA5SG3loaEd2vp5l1
	 ulqoYMYGK7drfN84dkhctm/vQv8ahlY2SzRbhsBs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730768AbgAVNXe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jan 2020 08:23:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:41742 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730749AbgAVNX2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jan 2020 08:23:28 -0500
Received: from localhost (unknown [84.241.205.26])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7121A205F4;
        Wed, 22 Jan 2020 13:23:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579699408;
        bh=8iV/WSxnVwBToM5OZHnGrzIEhzWmi0xOLLnQqDfDNek=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HsEyKoU4VvT530NGtSqDjzLwImDEy8r3xLeaDCPTWZSHJAnII7qTonJB/naS8Dgzv
         nq+0/1wjAUtDq2644fzRYCcOdx/vJHkHonylC7sprZsE5ynnpjhLqtF1uYaZ1cSMVZ
         1sLdwzNs2/OWgq87/3S9p4uzST5x+2Y/4b1z4FC4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Sven Eckelmann <sven@narfation.org>,
        Simon Wunderlich <sw@simonwunderlich.de>
Subject: [PATCH 5.4 135/222] batman-adv: Fix DAT candidate selection on little endian systems
Date:   Wed, 22 Jan 2020 10:28:41 +0100
Message-Id: <20200122092843.407940112@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200122092833.339495161@linuxfoundation.org>
References: <20200122092833.339495161@linuxfoundation.org>
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
@@ -285,6 +285,7 @@ static u32 batadv_hash_dat(const void *d
 	u32 hash = 0;
 	const struct batadv_dat_entry *dat = data;
 	const unsigned char *key;
+	__be16 vid;
 	u32 i;
 
 	key = (const unsigned char *)&dat->ip;
@@ -294,7 +295,8 @@ static u32 batadv_hash_dat(const void *d
 		hash ^= (hash >> 6);
 	}
 
-	key = (const unsigned char *)&dat->vid;
+	vid = htons(dat->vid);
+	key = (__force const unsigned char *)&vid;
 	for (i = 0; i < sizeof(dat->vid); i++) {
 		hash += key[i];
 		hash += (hash << 10);


