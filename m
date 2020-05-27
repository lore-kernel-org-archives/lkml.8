Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88C37C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 20:51:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 606A12088E
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 20:51:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KBI9y4h2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728631AbgE0UvU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 16:51:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728082AbgE0UvT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 16:51:19 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF00BC05BD1E
        for <linux-kernel@vger.kernel.org>; Wed, 27 May 2020 13:51:19 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id h129so25682084ybc.3
        for <linux-kernel@vger.kernel.org>; Wed, 27 May 2020 13:51:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=DdLsrZGy87gL5PPAo+OzWKykA6lM0LgtmgPWJCOmcHk=;
        b=KBI9y4h2V0uHMOfFBPfbiog35DiwugIstTan2mISIhH8KQdcT4+CQos3HKFsPNfGwu
         wtTmEB6XcMsc0iHcHGNhVbGWxlv0uWBgO9Y/GtJ/+NRJSmlCdktSzjtZItvEGZuKntag
         zVEZUl5t8RlO/uyCIXk/DjRJWteYdnJL0LPlALsqoikETA3UHngduPwUCFVmwmZ1rMcz
         4Fz9Ix2v3t8ilmjrBRK/P5im8hYp7yGffAS6kDihg/D5YEPVpMeNaWXB0YbmVaDoP5Gh
         lrll8YobGEPqfKMN5sBgkb3QnGzzfN2NthWtmhfRLGMvRLK4k0oYtzSMQEkSX/rkmQav
         4zXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=DdLsrZGy87gL5PPAo+OzWKykA6lM0LgtmgPWJCOmcHk=;
        b=cZS7AAS+e8YrZrqFYx6An13KosEhpGKNVFHbDbCoqCQa/IiR8CoIa9CtEiHmmNIDSF
         pFv4pbkhk9pVDiMqkBbEf83X5I7uPqw0wHQ49sdavsyF2DT7dMlWcCsmLN89SgWY5DVO
         Zo7yH8c69e67+kkhvL7TlkhAPue0fYrZAAwMp5MantwwwIqprYkkjwqJpur1Wr39tm/I
         1ojZvcEDhPizLqNh1HAXlqZF8IPSb6Y4sV35g1KEY0PKglmJvEw/yw8H4T9+iGa5IC97
         nAaTUjLkPNAI7DwjWAwzMPYoZE7LF3vNPusEavnnpnKak+3Lb758jvqervY3IvA8q71Y
         xSoA==
X-Gm-Message-State: AOAM5319s0HQcIj6sSsKj1OLqv6pjHSAcG6JsW7pRUJH8L/BKBebDqYC
        P3XtEkd96FmLdLbnj7uyYRVyL3lLAddV
X-Google-Smtp-Source: ABdhPJwqrxGl9Q21WiHWkTy/Cz9smW2aDm7R64tvq70OTi1aKuKjSQeoGTICzcGl93U27BBxS8lewg04umpI
X-Received: by 2002:a25:7496:: with SMTP id p144mr25973ybc.112.1590612679064;
 Wed, 27 May 2020 13:51:19 -0700 (PDT)
Date:   Wed, 27 May 2020 21:51:00 +0100
In-Reply-To: <20200527194811.GF30374@kadam>
Message-Id: <20200527205100.35794-1-pterjan@google.com>
Mime-Version: 1.0
References: <20200527194811.GF30374@kadam>
X-Mailer: git-send-email 2.27.0.rc0.183.gde8f92d652-goog
Subject: [PATCH v2] staging: rtl8723bs: Use common packet header constants
From:   Pascal Terjan <pterjan@google.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Cc:     Pascal Terjan <pterjan@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This driver contains a local version of the rfc1042 header and bridge
tunnel header constants which are available from cfg80211.h, switch to
those.

Signed-off-by: Pascal Terjan <pterjan@google.com>
---
v2: improve description and drop confusing cosmetic changes

 drivers/staging/rtl8723bs/core/rtw_recv.c     | 9 +++------
 drivers/staging/rtl8723bs/include/rtw_recv.h  | 2 --
 drivers/staging/rtl8723bs/os_dep/recv_linux.c | 5 +++--
 3 files changed, 6 insertions(+), 10 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_recv.c b/drivers/staging/rtl8723bs/core/rtw_recv.c
index 5245098b9ecf..7e1da0e35812 100644
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
+	if ((!memcmp(psnap, rfc1042_header, SNAP_SIZE) &&
 		(memcmp(psnap_type, SNAP_ETH_TYPE_IPX, 2)) &&
 		(memcmp(psnap_type, SNAP_ETH_TYPE_APPLETALK_AARP, 2))) ||
 		/* eth_type != ETH_P_AARP && eth_type != ETH_P_IPX) || */
-		 !memcmp(psnap, rtw_bridge_tunnel_header, SNAP_SIZE)) {
+		 !memcmp(psnap, bridge_tunnel_header, SNAP_SIZE)) {
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

