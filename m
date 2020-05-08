Return-Path: <SRS0=wESH=6W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D794EC38A2A
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 12:40:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B7E5B24968
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 12:40:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588941643;
	bh=BLurP3RiEK/f5W7P19RB5Tj0EbFM3uY0OjKblFvmWx0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=HzlHu+M+kQl8Y6WKQefD5RuHd32GjlUz9Xw8a5jG6POy9vYJU2H7MKmqB8hfNoymC
	 s9zfUZ0oChRoIJ/0v33wme2b8IbAsk64SESc8qYlF5tONgRgrUz+O5/5UFUURi1RNt
	 o04jBjb0EsFLZ9nbVAyt5DHYd/gAk3FZRjcfvjis=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728213AbgEHMkm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 May 2020 08:40:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:32852 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728647AbgEHMkE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 08:40:04 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F221A21835;
        Fri,  8 May 2020 12:40:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588941603;
        bh=BLurP3RiEK/f5W7P19RB5Tj0EbFM3uY0OjKblFvmWx0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=azcFGwxcAm91sXssi4NXoYq6ZmYp6XLH5DXFVbm40E+az9K1PM0YlqVyOyo5aPT+i
         dT5YiviAf7DVGPLeJXcNCCTWbnSCej4dO+sVXDOhe2d+/99xM/n4gVxKXrzvRnvcKE
         CITBVtGNaPG9OH+f9MvxYbKG+xhHDM/MOmDtXIfU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Nikolay Aleksandrov <nikolay@cumulusnetworks.com>,
        Ding Tianhong <dingtianhong@huawei.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.4 097/312] bonding: prevent out of bound accesses
Date:   Fri,  8 May 2020 14:31:28 +0200
Message-Id: <20200508123131.353492477@linuxfoundation.org>
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

From: Eric Dumazet <edumazet@google.com>

commit f87fda00b6ed232a817c655b8d179b48bde8fdbe upstream.

ether_addr_equal_64bits() requires some care about its arguments,
namely that 8 bytes might be read, even if last 2 byte values are not
used.

KASan detected a violation with null_mac_addr and lacpdu_mcast_addr
in bond_3ad.c

Same problem with mac_bcast[] and mac_v6_allmcast[] in bond_alb.c :
Although the 8-byte alignment was there, KASan would detect out
of bound accesses.

Fixes: 815117adaf5b ("bonding: use ether_addr_equal_unaligned for bond addr compare")
Fixes: bb54e58929f3 ("bonding: Verify RX LACPDU has proper dest mac-addr")
Fixes: 885a136c52a8 ("bonding: use compare_ether_addr_64bits() in ALB")
Signed-off-by: Eric Dumazet <edumazet@google.com>
Reported-by: Dmitry Vyukov <dvyukov@google.com>
Acked-by: Dmitry Vyukov <dvyukov@google.com>
Acked-by: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Acked-by: Ding Tianhong <dingtianhong@huawei.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/net/bonding/bond_3ad.c |   11 +++++++----
 drivers/net/bonding/bond_alb.c |    7 ++-----
 include/net/bonding.h          |    7 ++++++-
 3 files changed, 15 insertions(+), 10 deletions(-)

--- a/drivers/net/bonding/bond_3ad.c
+++ b/drivers/net/bonding/bond_3ad.c
@@ -100,11 +100,14 @@ enum ad_link_speed_type {
 #define MAC_ADDRESS_EQUAL(A, B)	\
 	ether_addr_equal_64bits((const u8 *)A, (const u8 *)B)
 
-static struct mac_addr null_mac_addr = { { 0, 0, 0, 0, 0, 0 } };
+static const u8 null_mac_addr[ETH_ALEN + 2] __long_aligned = {
+	0, 0, 0, 0, 0, 0
+};
 static u16 ad_ticks_per_sec;
 static const int ad_delta_in_ticks = (AD_TIMER_INTERVAL * HZ) / 1000;
 
-static const u8 lacpdu_mcast_addr[ETH_ALEN] = MULTICAST_LACPDU_ADDR;
+static const u8 lacpdu_mcast_addr[ETH_ALEN + 2] __long_aligned =
+	MULTICAST_LACPDU_ADDR;
 
 /* ================= main 802.3ad protocol functions ================== */
 static int ad_lacpdu_send(struct port *port);
@@ -1701,7 +1704,7 @@ static void ad_clear_agg(struct aggregat
 		aggregator->is_individual = false;
 		aggregator->actor_admin_aggregator_key = 0;
 		aggregator->actor_oper_aggregator_key = 0;
-		aggregator->partner_system = null_mac_addr;
+		eth_zero_addr(aggregator->partner_system.mac_addr_value);
 		aggregator->partner_system_priority = 0;
 		aggregator->partner_oper_aggregator_key = 0;
 		aggregator->receive_state = 0;
@@ -1723,7 +1726,7 @@ static void ad_initialize_agg(struct agg
 	if (aggregator) {
 		ad_clear_agg(aggregator);
 
-		aggregator->aggregator_mac_address = null_mac_addr;
+		eth_zero_addr(aggregator->aggregator_mac_address.mac_addr_value);
 		aggregator->aggregator_identifier = 0;
 		aggregator->slave = NULL;
 	}
--- a/drivers/net/bonding/bond_alb.c
+++ b/drivers/net/bonding/bond_alb.c
@@ -42,13 +42,10 @@
 
 
 
-#ifndef __long_aligned
-#define __long_aligned __attribute__((aligned((sizeof(long)))))
-#endif
-static const u8 mac_bcast[ETH_ALEN] __long_aligned = {
+static const u8 mac_bcast[ETH_ALEN + 2] __long_aligned = {
 	0xff, 0xff, 0xff, 0xff, 0xff, 0xff
 };
-static const u8 mac_v6_allmcast[ETH_ALEN] __long_aligned = {
+static const u8 mac_v6_allmcast[ETH_ALEN + 2] __long_aligned = {
 	0x33, 0x33, 0x00, 0x00, 0x00, 0x01
 };
 static const int alb_delta_in_ticks = HZ / ALB_TIMER_TICKS_PER_SEC;
--- a/include/net/bonding.h
+++ b/include/net/bonding.h
@@ -34,6 +34,9 @@
 
 #define BOND_DEFAULT_MIIMON	100
 
+#ifndef __long_aligned
+#define __long_aligned __attribute__((aligned((sizeof(long)))))
+#endif
 /*
  * Less bad way to call ioctl from within the kernel; this needs to be
  * done some other way to get the call out of interrupt context.
@@ -138,7 +141,9 @@ struct bond_params {
 	struct reciprocal_value reciprocal_packets_per_slave;
 	u16 ad_actor_sys_prio;
 	u16 ad_user_port_key;
-	u8 ad_actor_system[ETH_ALEN];
+
+	/* 2 bytes of padding : see ether_addr_equal_64bits() */
+	u8 ad_actor_system[ETH_ALEN + 2];
 };
 
 struct bond_parm_tbl {


