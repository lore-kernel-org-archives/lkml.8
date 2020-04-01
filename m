Return-Path: <SRS0=sqB7=5R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE706C43331
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 16:27:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A780420BED
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 16:27:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585758465;
	bh=1hbslwvl3HRHrAP4PNYJs+QN20wZAm7e0sZuj0tvEjI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ObRUEzBr1+WK5EJyoAKCceWTHq//bNt+ZFG6kDWjW21lwXBc8IOHObBT9kauDbJ/O
	 0Wq34z9XL32/ZpRpQ4ZT+Y8RrOukFstGuuhW1h9wlAKuU1+W6BrNZtxP1k/r7hr0in
	 GkaChuCkyVjSG3QgN+jhIixFRET2AnNufH+HSaXo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388031AbgDAQ1o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Apr 2020 12:27:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:52628 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387535AbgDAQ1m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Apr 2020 12:27:42 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8E036212CC;
        Wed,  1 Apr 2020 16:27:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585758462;
        bh=1hbslwvl3HRHrAP4PNYJs+QN20wZAm7e0sZuj0tvEjI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jRHTFxKotOjNdc393SteRQwmueXX82anZihCmoJO6qR30QqSfq/JUgee4dnL6L4/B
         yKgoP1aksFQz/u3ELaqhNp7EIZAryv/Fd+lM2t30alDBuL2NZZMPcVOiPzxWGeBLko
         esI551D0pCRHURk3jhogXin7NemSbAdQBygbnP90=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Johannes Berg <johannes.berg@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Woody Suwalski <terraluna977@gmail.com>
Subject: [PATCH 4.19 097/116] mac80211: fix authentication with iwlwifi/mvm
Date:   Wed,  1 Apr 2020 18:17:53 +0200
Message-Id: <20200401161554.757299208@linuxfoundation.org>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200401161542.669484650@linuxfoundation.org>
References: <20200401161542.669484650@linuxfoundation.org>
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
@@ -3519,7 +3519,8 @@ begin:
 		 * Drop unicast frames to unauthorised stations unless they are
 		 * EAPOL frames from the local station.
 		 */
-		if (unlikely(!ieee80211_vif_is_mesh(&tx.sdata->vif) &&
+		if (unlikely(ieee80211_is_data(hdr->frame_control) &&
+			     !ieee80211_vif_is_mesh(&tx.sdata->vif) &&
 			     tx.sdata->vif.type != NL80211_IFTYPE_OCB &&
 			     !is_multicast_ether_addr(hdr->addr1) &&
 			     !test_sta_flag(tx.sta, WLAN_STA_AUTHORIZED) &&


