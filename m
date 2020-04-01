Return-Path: <SRS0=sqB7=5R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7FB2C2D0F2
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 16:19:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B90420857
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 16:19:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585757968;
	bh=ETc9gsiahZ4Pty8Vw11tG9m3QQorzMwTAanEJJvVprM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=EshukRx0d/Wo3yh8IDYh9JMpyfPIZMszRze5jWgks2HNNoIPvUKOWujJMtz6Qcy6j
	 agsYQ3b21kwjNQpLO3LUUMamkXPXKqkGh5nP5SnPcrj8bNmazx/VrrYs6XOrwVgFXJ
	 XS1v52/v1fwFtYokIaPjFr1mDpTbNexNc7gxw59Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732334AbgDAQT1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Apr 2020 12:19:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:41722 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726205AbgDAQT0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Apr 2020 12:19:26 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 194A8212CC;
        Wed,  1 Apr 2020 16:19:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585757964;
        bh=ETc9gsiahZ4Pty8Vw11tG9m3QQorzMwTAanEJJvVprM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=H7ZglDvdRlS2fQEiuAECuNPB4ZbQQ3i+UlcfjbrevrIZMRX0CwylPNhJUvcMnhm3M
         5msrEi9v6/QdR6HaWlVLqyk9W2CLJGAX9jFGHlvqoYJWZoxcMBW6C8HdwurEpoyLe6
         b5TIzfbxzaVD2PaUimeqgAX6bQrxaaRD4goM2FFQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Johannes Berg <johannes.berg@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Woody Suwalski <terraluna977@gmail.com>
Subject: [PATCH 5.6 02/10] mac80211: fix authentication with iwlwifi/mvm
Date:   Wed,  1 Apr 2020 18:17:18 +0200
Message-Id: <20200401161416.929487815@linuxfoundation.org>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200401161413.974936041@linuxfoundation.org>
References: <20200401161413.974936041@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

commit be8c827f50a0bcd56361b31ada11dc0a3c2fd240 upstream.

The original patch didn't copy the ieee80211_is_data() condition
because on most drivers the management frames don't go through
this path. However, they do on iwlwifi/mvm, so we do need to keep
the condition here.

Cc: stable@vger.kernel.org
Fixes: ce2e1ca70307 ("mac80211: Check port authorization in the ieee80211_tx_dequeue() case")
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Cc: Woody Suwalski <terraluna977@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 net/mac80211/tx.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/net/mac80211/tx.c
+++ b/net/mac80211/tx.c
@@ -3610,7 +3610,8 @@ begin:
 		 * Drop unicast frames to unauthorised stations unless they are
 		 * EAPOL frames from the local station.
 		 */
-		if (unlikely(!ieee80211_vif_is_mesh(&tx.sdata->vif) &&
+		if (unlikely(ieee80211_is_data(hdr->frame_control) &&
+			     !ieee80211_vif_is_mesh(&tx.sdata->vif) &&
 			     tx.sdata->vif.type != NL80211_IFTYPE_OCB &&
 			     !is_multicast_ether_addr(hdr->addr1) &&
 			     !test_sta_flag(tx.sta, WLAN_STA_AUTHORIZED) &&


