Return-Path: <SRS0=zXkI=7F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC09DC433E0
	for <linux-kernel@archiver.kernel.org>; Sat, 23 May 2020 21:29:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 99E1D2072C
	for <linux-kernel@archiver.kernel.org>; Sat, 23 May 2020 21:29:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hHrhbWrk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388102AbgEWV33 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 May 2020 17:29:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387586AbgEWV32 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 May 2020 17:29:28 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D66D2C061A0E
        for <linux-kernel@vger.kernel.org>; Sat, 23 May 2020 14:29:27 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 5so13245296ybe.17
        for <linux-kernel@vger.kernel.org>; Sat, 23 May 2020 14:29:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=KyJv4MxnbuJAFDTG+VPNiW2cvu5uD75l264G/8mVLTo=;
        b=hHrhbWrk++yW+KWRMlojrxqgdo15EuM0aARn9mwzDSBsmsXM/3/TVgd+bz6jjTZKWs
         Y2JSFcl1aRrkmmtyZkY+Dk973mkQke+xk/Kg3Xtpx+4AnwpzeSrNQULkS7BIOKkciTNP
         S2sstg4VK/pPg/Z1QxmhlB8ySBSYiDN8CLv2JghVzXY7PdDM9jKMS3PeGPaDr5WSEW6S
         ciKUwRAFIN4cE2d7Q3JldRjPBgKtMBgIESFBkXd3LlqTg2tmHM33ma6lpmKDSxtqOVmi
         G2AInJgLvgQw98Eqo19l33qLDhMPJlxIyXGPCxVUK9WCW9LQyL1AVxM+4X9XYITAXy1d
         M5WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=KyJv4MxnbuJAFDTG+VPNiW2cvu5uD75l264G/8mVLTo=;
        b=Rqb8j6Gg13Ui+bcNlp47TpdCJwxsi4xVivYgfLwpUWIp3pCgyKXrAYGVrWNDzf29bA
         FTrpApUwCkj2O06MWhc0AUc0Me7+1nMUZTq82lBeQu/FgLAZ4N2okr7ac/PgR2vECGzh
         Xg5TW69tM786eJizt+Jp3yYka5jo/07+L8bjkT020dUP4ufKuI6BVbIL1EeqkLrq6q7r
         U10gqOXqzdI/P72Ves+9YrXIRZ4RnhQvbd3Cgkz7sugLhcvttq9yISDwT4Ny+a1z1qL/
         DdttmbbhRvlj1eGNgBVIgMw5Hv5iHiAypiFrtfDa/t82uEfLI/Us7KB36qN1ARN1XuIp
         158Q==
X-Gm-Message-State: AOAM531HxiUH4LD5zKSnQreolPWkBNSkM2qapsVnRusRkhiI90qe9QND
        3iCehNmv4JISPv0Uh/EvlehdZNvY5Stv
X-Google-Smtp-Source: ABdhPJyA0SF/qrSy1pgHfbm255UVkYs7n14NlGtA2YTZ9FR1px4Ml9w8zZl1Dlyk/WGoNJWXqzNz30dUPQ8U
X-Received: by 2002:a25:8509:: with SMTP id w9mr30903760ybk.500.1590269366933;
 Sat, 23 May 2020 14:29:26 -0700 (PDT)
Date:   Sat, 23 May 2020 22:29:19 +0100
Message-Id: <20200523212919.33181-1-pterjan@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.27.0.rc0.183.gde8f92d652-goog
Subject: [PATCH] staging: rtl8723bs: Use shared header constants
From:   Pascal Terjan <pterjan@google.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Cc:     Pascal Terjan <pterjan@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is one of the 9 drivers redefining rfc1042_header.

Signed-off-by: Pascal Terjan <pterjan@google.com>
---
 drivers/staging/rtl8723bs/core/rtw_recv.c     | 15 ++++++---------
 drivers/staging/rtl8723bs/include/rtw_recv.h  |  2 --
 drivers/staging/rtl8723bs/os_dep/recv_linux.c |  5 +++--
 3 files changed, 9 insertions(+), 13 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_recv.c b/drivers/staging/rtl8723bs/core/rtw_recv.c
index 5245098b9ecf..dc58822924b4 100644
--- a/drivers/staging/rtl8723bs/core/rtw_recv.c
+++ b/drivers/staging/rtl8723bs/core/rtw_recv.c
@@ -10,14 +10,11 @@
 #include <rtw_debug.h>
 #include <linux/jiffies.h>
 #include <rtw_recv.h>
+#include <net/cfg80211.h>
 
 static u8 SNAP_ETH_TYPE_IPX[2] = {0x81, 0x37};
 static u8 SNAP_ETH_TYPE_APPLETALK_AARP[2] = {0x80, 0xf3};
 
-u8 rtw_rfc1042_header[] = { 0xaa, 0xaa, 0x03, 0x00, 0x00, 0x00 };
-/* Bridge-Tunnel header (for EtherTypes ETH_P_AARP and ETH_P_IPX) */
-u8 rtw_bridge_tunnel_header[] = { 0xaa, 0xaa, 0x03, 0x00, 0x00, 0xf8 };
-
 static void rtw_signal_stat_timer_hdl(struct timer_list *t);
 
 void _rtw_init_sta_recv_priv(struct sta_recv_priv *psta_recvpriv)
@@ -1625,11 +1622,11 @@ sint wlanhdr_to_ethhdr(union recv_frame *precvframe)
 	psnap_type = ptr+pattrib->hdrlen + pattrib->iv_len+SNAP_SIZE;
 	/* convert hdr + possible LLC headers into Ethernet header */
 	/* eth_type = (psnap_type[0] << 8) | psnap_type[1]; */
-	if ((!memcmp(psnap, rtw_rfc1042_header, SNAP_SIZE) &&
-		(memcmp(psnap_type, SNAP_ETH_TYPE_IPX, 2)) &&
-		(memcmp(psnap_type, SNAP_ETH_TYPE_APPLETALK_AARP, 2))) ||
-		/* eth_type != ETH_P_AARP && eth_type != ETH_P_IPX) || */
-		 !memcmp(psnap, rtw_bridge_tunnel_header, SNAP_SIZE)) {
+	if ((!memcmp(psnap, rfc1042_header, SNAP_SIZE) &&
+	     memcmp(psnap_type, SNAP_ETH_TYPE_IPX, 2) &&
+	     memcmp(psnap_type, SNAP_ETH_TYPE_APPLETALK_AARP, 2)) ||
+	    /* eth_type != ETH_P_AARP && eth_type != ETH_P_IPX) || */
+	    !memcmp(psnap, bridge_tunnel_header, SNAP_SIZE)) {
 		/* remove RFC1042 or Bridge-Tunnel encapsulation and replace EtherType */
 		bsnaphdr = true;
 	} else
diff --git a/drivers/staging/rtl8723bs/include/rtw_recv.h b/drivers/staging/rtl8723bs/include/rtw_recv.h
index 98c3e92245b7..a851b818ef0e 100644
--- a/drivers/staging/rtl8723bs/include/rtw_recv.h
+++ b/drivers/staging/rtl8723bs/include/rtw_recv.h
@@ -38,8 +38,6 @@
 #define RX_MAX_QUEUE				2
 
 #define MAX_SUBFRAME_COUNT	64
-extern u8 rtw_rfc1042_header[];
-extern u8 rtw_bridge_tunnel_header[];
 
 /* for Rx reordering buffer control */
 struct recv_reorder_ctrl
diff --git a/drivers/staging/rtl8723bs/os_dep/recv_linux.c b/drivers/staging/rtl8723bs/os_dep/recv_linux.c
index 2a7b9922b1d4..eb4d1c3008fe 100644
--- a/drivers/staging/rtl8723bs/os_dep/recv_linux.c
+++ b/drivers/staging/rtl8723bs/os_dep/recv_linux.c
@@ -9,6 +9,7 @@
 #include <drv_types.h>
 #include <rtw_debug.h>
 #include <linux/jiffies.h>
+#include <net/cfg80211.h>
 
 void rtw_os_free_recvframe(union recv_frame *precvframe)
 {
@@ -71,9 +72,9 @@ _pkt *rtw_os_alloc_msdu_pkt(union recv_frame *prframe, u16 nSubframe_Length, u8
 	eth_type = RTW_GET_BE16(&sub_skb->data[6]);
 
 	if (sub_skb->len >= 8 &&
-		((!memcmp(sub_skb->data, rtw_rfc1042_header, SNAP_SIZE) &&
+		((!memcmp(sub_skb->data, rfc1042_header, SNAP_SIZE) &&
 		  eth_type != ETH_P_AARP && eth_type != ETH_P_IPX) ||
-		 !memcmp(sub_skb->data, rtw_bridge_tunnel_header, SNAP_SIZE))) {
+		 !memcmp(sub_skb->data, bridge_tunnel_header, SNAP_SIZE))) {
 		/*
 		 * remove RFC1042 or Bridge-Tunnel encapsulation and replace
 		 * EtherType
-- 
2.27.0.rc0.183.gde8f92d652-goog

