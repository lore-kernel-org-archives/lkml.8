Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF687C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 16:06:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9857121532
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 16:06:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HP2EZNf4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392438AbgFSQGw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 12:06:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405547AbgFSQF5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 12:05:57 -0400
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96ECCC06174E
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jun 2020 09:05:57 -0700 (PDT)
Received: by mail-ed1-x544.google.com with SMTP id m21so7980738eds.13
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jun 2020 09:05:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=osi+7kegHQUhLjJCtI4D4dYsD7Tnr4PgL85qHMsaxOY=;
        b=HP2EZNf4A1EVG7NLnAfafrXxKY2QlHTRc7+0DkPnBlREWkBZ+JUC/6X5c8vzCTzEcN
         jtqdKfzTls4uekWytl18VNuEsonzP4ji9CDcmzKVRiLp8DFA8Z8VLjWhdH8GSXEbWXkz
         fCwYdPNXierqrjWx97YmEuA4pbWoPIjlLJ33Lfq+nuQGa8AHwh19CjK63qVqSS0pXLSl
         LCqTfjYU6meqY2yaFll0okiIzJYR1hTT6x6NxHaTyHTm0Ngp3i7h34KfURb8QyjiRd4e
         AASuDrBWHIaU7gtEKHS5fedKx+LEZm3MFYXSG417OtSl+56Qa3AyGqMjsy9z5aaZkwIh
         I3hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=osi+7kegHQUhLjJCtI4D4dYsD7Tnr4PgL85qHMsaxOY=;
        b=bAjll0uZBOROeTaDVuuToxcwcpgtaWXag/q6i6y0iu4ytImn63edDm4zQI/mAPgOuN
         Q1zcv28QCdDVqGfqrethKOsMHBEIWOUAhhOBRVwu0Se6x3OtWGz33eSfkI26Rwq0/pr/
         lbKp3/KfU3zh3EmM1nHd5U/JAJD+laahcGc9BQV82hdlzybhirNt6+UjCPB9lTXRrWJV
         MAtExdP4sNKuDQ8Cnq/jh5b7U9cJQB1MuPUxQOi3Wz+gu154rbyhiiXUDVElXoF0JNPc
         hJf2lUw6YrboMCf1kvvVV5Fkw8J0hfoq0VnIfzuj72wmqjsd0QbBPyww0iAPH2Noj/fl
         oG1w==
X-Gm-Message-State: AOAM5330PJyDdppCx9iuY6IwvjeS5WLGpaZAafs2ImKrmQW0rFdTci6c
        3Uq2IaDLSdrD3Qw5ChEG5JU=
X-Google-Smtp-Source: ABdhPJwUJgBnLelDqqBVTLpTKWXVb6j1Ab5QhWAYa9AwdkoiMBzgtNrWAvKq/HY4LJGAZ3TxgRZ4xw==
X-Received: by 2002:a50:f983:: with SMTP id q3mr4227018edn.259.1592582756391;
        Fri, 19 Jun 2020 09:05:56 -0700 (PDT)
Received: from localhost.localdomain (dslb-178-006-252-242.178.006.pools.vodafone-ip.de. [178.6.252.242])
        by smtp.gmail.com with ESMTPSA id dj26sm4931780edb.4.2020.06.19.09.05.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jun 2020 09:05:55 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH] staging: rtl8188eu: use common packet header constants
Date:   Fri, 19 Jun 2020 18:03:28 +0200
Message-Id: <20200619160328.22776-1-straube.linux@gmail.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The driver replicates the definitions of rfc1042_header and
bridge_tunnel_header available from cfg80211.h. Use the common
ones from cfg80211.h.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/rtl8188eu/core/rtw_recv.c | 18 +++++-------------
 1 file changed, 5 insertions(+), 13 deletions(-)

diff --git a/drivers/staging/rtl8188eu/core/rtw_recv.c b/drivers/staging/rtl8188eu/core/rtw_recv.c
index a036ef104198..0257e56b551a 100644
--- a/drivers/staging/rtl8188eu/core/rtw_recv.c
+++ b/drivers/staging/rtl8188eu/core/rtw_recv.c
@@ -15,6 +15,7 @@
 #include <mon.h>
 #include <wifi.h>
 #include <linux/vmalloc.h>
+#include <net/cfg80211.h>
 
 #define ETHERNET_HEADER_SIZE	14	/*  Ethernet Header Length */
 #define LLC_HEADER_SIZE			6	/*  LLC Header Length */
@@ -22,15 +23,6 @@
 static u8 SNAP_ETH_TYPE_IPX[2] = {0x81, 0x37};
 static u8 SNAP_ETH_TYPE_APPLETALK_AARP[2] = {0x80, 0xf3};
 
-/* Bridge-Tunnel header (for EtherTypes ETH_P_AARP and ETH_P_IPX) */
-static u8 rtw_bridge_tunnel_header[] = {
-	0xaa, 0xaa, 0x03, 0x00, 0x00, 0xf8
-};
-
-static u8 rtw_rfc1042_header[] = {
-	0xaa, 0xaa, 0x03, 0x00, 0x00, 0x00
-};
-
 static void rtw_signal_stat_timer_hdl(struct timer_list *t);
 
 void _rtw_init_sta_recv_priv(struct sta_recv_priv *psta_recvpriv)
@@ -1277,10 +1269,10 @@ static int wlanhdr_to_ethhdr(struct recv_frame *precvframe)
 	psnap = (struct ieee80211_snap_hdr *)(ptr+pattrib->hdrlen + pattrib->iv_len);
 	psnap_type = ptr+pattrib->hdrlen + pattrib->iv_len+SNAP_SIZE;
 	/* convert hdr + possible LLC headers into Ethernet header */
-	if ((!memcmp(psnap, rtw_rfc1042_header, SNAP_SIZE) &&
+	if ((!memcmp(psnap, rfc1042_header, SNAP_SIZE) &&
 	     memcmp(psnap_type, SNAP_ETH_TYPE_IPX, 2) &&
 	     memcmp(psnap_type, SNAP_ETH_TYPE_APPLETALK_AARP, 2)) ||
-	     !memcmp(psnap, rtw_bridge_tunnel_header, SNAP_SIZE)) {
+	     !memcmp(psnap, bridge_tunnel_header, SNAP_SIZE)) {
 		/* remove RFC1042 or Bridge-Tunnel encapsulation and replace EtherType */
 		bsnaphdr = true;
 	} else {
@@ -1560,9 +1552,9 @@ static int amsdu_to_msdu(struct adapter *padapter, struct recv_frame *prframe)
 		/* convert hdr + possible LLC headers into Ethernet header */
 		eth_type = get_unaligned_be16(&sub_skb->data[6]);
 		if (sub_skb->len >= 8 &&
-		    ((!memcmp(sub_skb->data, rtw_rfc1042_header, SNAP_SIZE) &&
+		    ((!memcmp(sub_skb->data, rfc1042_header, SNAP_SIZE) &&
 			  eth_type != ETH_P_AARP && eth_type != ETH_P_IPX) ||
-			 !memcmp(sub_skb->data, rtw_bridge_tunnel_header, SNAP_SIZE))) {
+			 !memcmp(sub_skb->data, bridge_tunnel_header, SNAP_SIZE))) {
 			/* remove RFC1042 or Bridge-Tunnel encapsulation and replace EtherType */
 			skb_pull(sub_skb, SNAP_SIZE);
 			memcpy(skb_push(sub_skb, ETH_ALEN), pattrib->src, ETH_ALEN);
-- 
2.27.0

