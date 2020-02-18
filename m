Return-Path: <SRS0=52rg=4G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F56DC34047
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 20:02:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A77C21D56
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 20:02:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582056176;
	bh=6M0+NYh2dsJFvJERXW7FFln+BxQTlcXI9TLiM82kJmU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=UuCcLRNFAoejTw28LN3QIwZ6X+NX696Z87xzlbTbXZkCksHYVtdKuEOwjbURXcC5y
	 1fxS4NfwBhhPwngQfvzexb5nrzhV+/c8SPAVKOIzgUdAAzKapYhRxyWV22Bh605w7v
	 5/slwmltIfsd7T/kiwZcolNjt2yq52cM50pXbJGw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729023AbgBRUCz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Feb 2020 15:02:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:43614 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728273AbgBRUCu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Feb 2020 15:02:50 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0C2A421D56;
        Tue, 18 Feb 2020 20:02:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582056169;
        bh=6M0+NYh2dsJFvJERXW7FFln+BxQTlcXI9TLiM82kJmU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SSUEIdEsK53W0v5WVGIWU2T7VF3BwOajNcqD6cno4SIUKUYwXhqNacIjBTDTXApET
         9ATqs50yTd1/RGCLcN53x+4Dfsr+jQoyTa72UQHOhPQFpyaqxAgt8F89S5NaEh19W8
         YJZs0h+szVHobZ/d0yJx/G2iTuft1hvGgBHEzk0E=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Johannes Berg <johannes.berg@intel.com>,
        =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
Subject: [PATCH 5.5 61/80] mac80211: use more bits for ack_frame_id
Date:   Tue, 18 Feb 2020 20:55:22 +0100
Message-Id: <20200218190437.913785931@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200218190432.043414522@linuxfoundation.org>
References: <20200218190432.043414522@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

commit f2b18baca9539c6a3116d48b70972c7a2ba5d766 upstream.

It turns out that this wasn't a good idea, I hit a test failure in
hwsim due to this. That particular failure was easily worked around,
but it raised questions: if an AP needs to, for example, send action
frames to each connected station, the current limit is nowhere near
enough (especially if those stations are sleeping and the frames are
queued for a while.)

Shuffle around some bits to make more room for ack_frame_id to allow
up to 8192 queued up frames, that's enough for queueing 4 frames to
each connected station, even at the maximum of 2007 stations on a
single AP.

We take the bits from band (which currently only 2 but I leave 3 in
case we add another band) and from the hw_queue, which can only need
4 since it has a limit of 16 queues.

Fixes: 6912daed05e1 ("mac80211: Shrink the size of ack_frame_id to make room for tx_time_est")
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Acked-by: Toke Høiland-Jørgensen <toke@redhat.com>
Link: https://lore.kernel.org/r/20200115122549.b9a4ef9f4980.Ied52ed90150220b83a280009c590b65d125d087c@changeid
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 include/net/mac80211.h |   11 +++++------
 net/mac80211/cfg.c     |    2 +-
 net/mac80211/tx.c      |    2 +-
 3 files changed, 7 insertions(+), 8 deletions(-)

--- a/include/net/mac80211.h
+++ b/include/net/mac80211.h
@@ -1004,12 +1004,11 @@ ieee80211_rate_get_vht_nss(const struct
 struct ieee80211_tx_info {
 	/* common information */
 	u32 flags;
-	u8 band;
-
-	u8 hw_queue;
-
-	u16 ack_frame_id:6;
-	u16 tx_time_est:10;
+	u32 band:3,
+	    ack_frame_id:13,
+	    hw_queue:4,
+	    tx_time_est:10;
+	/* 2 free bits */
 
 	union {
 		struct {
--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -3450,7 +3450,7 @@ int ieee80211_attach_ack_skb(struct ieee
 
 	spin_lock_irqsave(&local->ack_status_lock, spin_flags);
 	id = idr_alloc(&local->ack_status_frames, ack_skb,
-		       1, 0x40, GFP_ATOMIC);
+		       1, 0x2000, GFP_ATOMIC);
 	spin_unlock_irqrestore(&local->ack_status_lock, spin_flags);
 
 	if (id < 0) {
--- a/net/mac80211/tx.c
+++ b/net/mac80211/tx.c
@@ -2442,7 +2442,7 @@ static int ieee80211_store_ack_skb(struc
 
 		spin_lock_irqsave(&local->ack_status_lock, flags);
 		id = idr_alloc(&local->ack_status_frames, ack_skb,
-			       1, 0x40, GFP_ATOMIC);
+			       1, 0x2000, GFP_ATOMIC);
 		spin_unlock_irqrestore(&local->ack_status_lock, flags);
 
 		if (id >= 0) {


