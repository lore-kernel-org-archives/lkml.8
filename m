Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52316C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 13:51:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2AEA12078C
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 13:51:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388887AbgE0Nvl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 09:51:41 -0400
Received: from mout.kundenserver.de ([212.227.126.131]:54443 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388516AbgE0Nvk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 09:51:40 -0400
Received: from threadripper.lan ([149.172.98.151]) by mrelayeu.kundenserver.de
 (mreue009 [212.227.15.129]) with ESMTPA (Nemesis) id
 1N1fei-1itmw20YYa-011xf5; Wed, 27 May 2020 15:51:26 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Roopa Prabhu <roopa@cumulusnetworks.com>,
        Nikolay Aleksandrov <nikolay@cumulusnetworks.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        bridge@lists.linux-foundation.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com
Subject: [PATCH] bridge: multicast: work around clang bug
Date:   Wed, 27 May 2020 15:51:13 +0200
Message-Id: <20200527135124.1082844-1-arnd@arndb.de>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:tNJGImBksv3+uHh4LK9iDkXQuSmBokYMQI86sR1uOpirtHXc2NK
 CrX21qK2bbI6xhZ/Ib4t+RJHd4UNZzA3A8i8Udhs+Nj6xtysytaLytX2xtrUB3t5bOmtrDH
 Ibtv+P8HKRJy4pUycJSjjYzaNl2DkK5nnWSAL7d8WuvguMsMdN+CvlSnMfp143rT9MKRdXy
 GJne/oiPD9a6i+xx4Thjg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:BuiwkU7bU2Y=:GCvuv9qB6dHCgoInEOLGK9
 808pZ65A3+ZvuUmKlZmMiMD+KWWW2i9sI6v31khsncel949CUjtROBxfQ/YqLPiJUBV2ZsN9j
 qQV6S3goxKEOk9KzwOExut5lMc8AjOFOiF7jXZmTEB/owEEAV0SUx3tM8L1tkLLBxrJELyN6J
 PqyBUv8hhDmxkOB5b+/7AwSSKMb+THSX2UgAaAdjJXpHwVzyyPLJtTMOxmpQCb7DzClmRCS/u
 dSbxI4gPROhiPNa8PXGS6rZ9c0mebdDsIs42fVsJKJMSaRpWjWffc9pt5Y8+y0CmvHl4n3vAt
 qH9K9bG8kV4OEwviLn4j3mWr8mFsal3Pz9anJ5PlSWXDL46FLykAv6jQouHtV/hri3R2yFyb+
 hwhaFktbARAdRFXtEcygRtIZxEfRg6b7j0WKdyJe8Dc1aBg13Zi4xs1rtC1MrDU3qgpxPIWcX
 ME2+KIlcSe8RyJWLuNR2qQLQcPKIeQZUeQyjQNfAYeIJG6gcWSzqAk7UUppgM7hX/9AzZgiPl
 7EdDeK3BKgwKGWGRypzGiRdQOk/cb/6PY1mti/GTsTFSrbPz8N6apCWYpoIx2bg4EY2Lhk7QN
 ua8LzeoeF5dWNsDG8BvW9SP1/8hmPZ7Q1cuPp6P0l2vReHontQz/GesEr++93qzBrWIpccEbi
 QjLD6J7noL6sgsnqeNoIwHa8y1tl2XpOQYJ1KDVXNob0pyUWKGelHT+PJVJmrf8ooIbe/a5E5
 Ejc2tS5hwpNiGyKjwaRcItpmmNZPROwbjJcVBXMabwtIKubudHvMqjW+19SuMHF+eWEbZNHjL
 m6RSK50uvvuP0D73KZUz5T2LuCfFaMWnR9CemE+ZRKpt2N+Oh0=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clang-10 and clang-11 run into a corner case of the register
allocator on 32-bit ARM, leading to excessive stack usage from
register spilling:

net/bridge/br_multicast.c:2422:6: error: stack frame size of 1472 bytes in function 'br_multicast_get_stats' [-Werror,-Wframe-larger-than=]

Work around this by marking one of the internal functions as
noinline_for_stack.

Link: https://bugs.llvm.org/show_bug.cgi?id=45802#c9
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 net/bridge/br_multicast.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/bridge/br_multicast.c b/net/bridge/br_multicast.c
index ad12fe3fca8c..83490bf73a13 100644
--- a/net/bridge/br_multicast.c
+++ b/net/bridge/br_multicast.c
@@ -2413,7 +2413,8 @@ void br_multicast_uninit_stats(struct net_bridge *br)
 	free_percpu(br->mcast_stats);
 }
 
-static void mcast_stats_add_dir(u64 *dst, u64 *src)
+/* noinline for https://bugs.llvm.org/show_bug.cgi?id=45802#c9 */
+static noinline_for_stack void mcast_stats_add_dir(u64 *dst, u64 *src)
 {
 	dst[BR_MCAST_DIR_RX] += src[BR_MCAST_DIR_RX];
 	dst[BR_MCAST_DIR_TX] += src[BR_MCAST_DIR_TX];
-- 
2.26.2

