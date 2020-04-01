Return-Path: <SRS0=sqB7=5R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AA52C2D0F0
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 16:46:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A22220784
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 16:46:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585759604;
	bh=6QCiJe92C6d7clPEjD79k8RBuhcqQjqzeW6E0U7WrJY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=VzgmLbfhqbap9xjPDzMynYs4Kvn5IG0amLYjvWU86EeywBDly5LKwv54hTM42gDuF
	 /b5FyviN6TD9wuX5YviioHVutHcSfdeVgORposguoZ5X9W8zhzkqi4Q4Gk+uj2aRFI
	 RBc2rOdgRp35NNr07PQ41kpgw+/IjrIzrhIoRWwo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388041AbgDAQqm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Apr 2020 12:46:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:48062 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389966AbgDAQqi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Apr 2020 12:46:38 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6C23320705;
        Wed,  1 Apr 2020 16:46:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585759597;
        bh=6QCiJe92C6d7clPEjD79k8RBuhcqQjqzeW6E0U7WrJY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Mt+neDx+44BNos/yzhrjsi76b1RSlmb10yVKtT5GTg9WV1J+O+zosF52BuaTldEuZ
         jKVY+caJOzXJrb2qUppOKMoACKW4RxJvp8L/Q0C2cdYiT5Ga/igTK/7IYlu9kczM8z
         qQ1ozysE69h2v3WbbV+lewiNso/0sjhsxpDgoRng=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Johannes Berg <johannes.berg@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Woody Suwalski <terraluna977@gmail.com>
Subject: [PATCH 4.14 131/148] mac80211: fix authentication with iwlwifi/mvm
Date:   Wed,  1 Apr 2020 18:18:43 +0200
Message-Id: <20200401161604.952154480@linuxfoundation.org>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200401161552.245876366@linuxfoundation.org>
References: <20200401161552.245876366@linuxfoundation.org>
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
@@ -3457,7 +3457,8 @@ begin:
 		 * Drop unicast frames to unauthorised stations unless they are
 		 * EAPOL frames from the local station.
 		 */
-		if (unlikely(!ieee80211_vif_is_mesh(&tx.sdata->vif) &&
+		if (unlikely(ieee80211_is_data(hdr->frame_control) &&
+			     !ieee80211_vif_is_mesh(&tx.sdata->vif) &&
 			     tx.sdata->vif.type != NL80211_IFTYPE_OCB &&
 			     !is_multicast_ether_addr(hdr->addr1) &&
 			     !test_sta_flag(tx.sta, WLAN_STA_AUTHORIZED) &&


