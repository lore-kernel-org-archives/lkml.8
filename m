Return-Path: <SRS0=ro3C=3X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20A97C35247
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 16:35:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E944321744
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 16:35:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580747754;
	bh=4lUYntdem9KaoQXqTsHcnMgcRvsiAA2mzCa1crZVygQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=oIyzjP3cWq8/K2icrtE5ChdHmVvDWH7MI4QpUkbo6n3Y5nHUOtC37sx9E+mbAkE44
	 ak+OITW17WKTEAHcqfwfTYyXp2I3azjvLHC0qBxe8wzOawTYDDOdH1JDUECs2xUd9a
	 r/qGp7bIuI7HJ4345qCA5Mtb0pJ9efulk6PKtx2s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731100AbgBCQfw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Feb 2020 11:35:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:50880 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731082AbgBCQfv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Feb 2020 11:35:51 -0500
Received: from localhost (unknown [104.132.45.99])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3176D2051A;
        Mon,  3 Feb 2020 16:35:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580747750;
        bh=4lUYntdem9KaoQXqTsHcnMgcRvsiAA2mzCa1crZVygQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lMqwJs1c/z8Drc8fSKYsFoudWI53hoBAL79iQR/CYyldP+zrEkr1eHZ6mpntJDyOz
         1InkA2wZIIdNNWf3DMs/OTyKGbbOvAJ0gVHK0P70stqcRyXAYPaEp5O8WJ1uObd6sF
         UqzGO5hz+plibgEEq8T8LI88Z6n/lM6LCsavniUk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jouni Malinen <j@w1.fi>,
        Johannes Berg <johannes.berg@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 53/90] mac80211: Fix TKIP replay protection immediately after key setup
Date:   Mon,  3 Feb 2020 16:19:56 +0000
Message-Id: <20200203161924.283085792@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200203161917.612554987@linuxfoundation.org>
References: <20200203161917.612554987@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jouni Malinen <j@w1.fi>

[ Upstream commit 6f601265215a421f425ba3a4850a35861d024643 ]

TKIP replay protection was skipped for the very first frame received
after a new key is configured. While this is potentially needed to avoid
dropping a frame in some cases, this does leave a window for replay
attacks with group-addressed frames at the station side. Any earlier
frame sent by the AP using the same key would be accepted as a valid
frame and the internal RSC would then be updated to the TSC from that
frame. This would allow multiple previously transmitted group-addressed
frames to be replayed until the next valid new group-addressed frame
from the AP is received by the station.

Fix this by limiting the no-replay-protection exception to apply only
for the case where TSC=0, i.e., when this is for the very first frame
protected using the new key, and the local RSC had not been set to a
higher value when configuring the key (which may happen with GTK).

Signed-off-by: Jouni Malinen <j@w1.fi>
Link: https://lore.kernel.org/r/20200107153545.10934-1-j@w1.fi
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/mac80211/tkip.c | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/net/mac80211/tkip.c b/net/mac80211/tkip.c
index 727dc9f3f3b3a..e7f57bb18f6e0 100644
--- a/net/mac80211/tkip.c
+++ b/net/mac80211/tkip.c
@@ -263,9 +263,21 @@ int ieee80211_tkip_decrypt_data(struct arc4_ctx *ctx,
 	if ((keyid >> 6) != key->conf.keyidx)
 		return TKIP_DECRYPT_INVALID_KEYIDX;
 
-	if (rx_ctx->ctx.state != TKIP_STATE_NOT_INIT &&
-	    (iv32 < rx_ctx->iv32 ||
-	     (iv32 == rx_ctx->iv32 && iv16 <= rx_ctx->iv16)))
+	/* Reject replays if the received TSC is smaller than or equal to the
+	 * last received value in a valid message, but with an exception for
+	 * the case where a new key has been set and no valid frame using that
+	 * key has yet received and the local RSC was initialized to 0. This
+	 * exception allows the very first frame sent by the transmitter to be
+	 * accepted even if that transmitter were to use TSC 0 (IEEE 802.11
+	 * described TSC to be initialized to 1 whenever a new key is taken into
+	 * use).
+	 */
+	if (iv32 < rx_ctx->iv32 ||
+	    (iv32 == rx_ctx->iv32 &&
+	     (iv16 < rx_ctx->iv16 ||
+	      (iv16 == rx_ctx->iv16 &&
+	       (rx_ctx->iv32 || rx_ctx->iv16 ||
+		rx_ctx->ctx.state != TKIP_STATE_NOT_INIT)))))
 		return TKIP_DECRYPT_REPLAY;
 
 	if (only_iv) {
-- 
2.20.1



