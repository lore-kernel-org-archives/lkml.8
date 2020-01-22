Return-Path: <SRS0=9JlO=3L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57D6FC33CAF
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 09:53:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2694B20704
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 09:53:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579686797;
	bh=UfNcciLhGR8mUtx9Sy6RXf1jvwXSevNstUj4IZjS/Dc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=sfYeiy4YCVU20/01CRYg6j6Hmikzaoj5psR0mNaikOPayp74FlRJQtgVyh7hJg3FR
	 ET3LHSlHPw/bS+Y334Kb2mu2n2pz3UQHNI9md7T5aH2uhAb9EBuRZP0+hw41zh7dJb
	 mBfYL+QLLKiiJ8z2eSCGkQHIhuG67FtJ+6zXPJ1A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730950AbgAVJxQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jan 2020 04:53:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:50726 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731379AbgAVJfe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jan 2020 04:35:34 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5650424673;
        Wed, 22 Jan 2020 09:35:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579685733;
        bh=UfNcciLhGR8mUtx9Sy6RXf1jvwXSevNstUj4IZjS/Dc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Zd2xM5+eqcqXJmgqBYsg1ahGg8nhIMVTxZW/mhvlwTdPZ/mlPuiKyEH6zVAFeknXb
         /clmJ1b5Z/6CWOgzGB+bJNkn9kS156GItzAgxdLSdyhci0pHktJst/Z2zVbfJBqP4n
         eABrql75kBGi+p9g2TLhKZkjaCh8vku8ObaBq+cw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jouni Malinen <jouni@codeaurora.org>,
        Johannes Berg <johannes@sipsolutions.net>,
        "David S. Miller" <davem@davemloft.net>,
        Ben Hutchings <ben.hutchings@codethink.co.uk>
Subject: [PATCH 4.9 13/97] mac80211: Do not send Layer 2 Update frame before authorization
Date:   Wed, 22 Jan 2020 10:28:17 +0100
Message-Id: <20200122092757.991592555@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200122092755.678349497@linuxfoundation.org>
References: <20200122092755.678349497@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jouni Malinen <jouni@codeaurora.org>

commit 3e493173b7841259a08c5c8e5cbe90adb349da7e upstream.

The Layer 2 Update frame is used to update bridges when a station roams
to another AP even if that STA does not transmit any frames after the
reassociation. This behavior was described in IEEE Std 802.11F-2003 as
something that would happen based on MLME-ASSOCIATE.indication, i.e.,
before completing 4-way handshake. However, this IEEE trial-use
recommended practice document was published before RSN (IEEE Std
802.11i-2004) and as such, did not consider RSN use cases. Furthermore,
IEEE Std 802.11F-2003 was withdrawn in 2006 and as such, has not been
maintained amd should not be used anymore.

Sending out the Layer 2 Update frame immediately after association is
fine for open networks (and also when using SAE, FT protocol, or FILS
authentication when the station is actually authenticated by the time
association completes). However, it is not appropriate for cases where
RSN is used with PSK or EAP authentication since the station is actually
fully authenticated only once the 4-way handshake completes after
authentication and attackers might be able to use the unauthenticated
triggering of Layer 2 Update frame transmission to disrupt bridge
behavior.

Fix this by postponing transmission of the Layer 2 Update frame from
station entry addition to the point when the station entry is marked
authorized. Similarly, send out the VLAN binding update only if the STA
entry has already been authorized.

Signed-off-by: Jouni Malinen <jouni@codeaurora.org>
Reviewed-by: Johannes Berg <johannes@sipsolutions.net>
Signed-off-by: David S. Miller <davem@davemloft.net>
[bwh: Backported to 4.9: adjust context]
Signed-off-by: Ben Hutchings <ben.hutchings@codethink.co.uk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/mac80211/cfg.c      |   11 +++--------
 net/mac80211/sta_info.c |    4 ++++
 2 files changed, 7 insertions(+), 8 deletions(-)

--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -1357,7 +1357,6 @@ static int ieee80211_add_station(struct
 	struct sta_info *sta;
 	struct ieee80211_sub_if_data *sdata;
 	int err;
-	int layer2_update;
 
 	if (params->vlan) {
 		sdata = IEEE80211_DEV_TO_SUB_IF(params->vlan);
@@ -1401,18 +1400,12 @@ static int ieee80211_add_station(struct
 	    test_sta_flag(sta, WLAN_STA_ASSOC))
 		rate_control_rate_init(sta);
 
-	layer2_update = sdata->vif.type == NL80211_IFTYPE_AP_VLAN ||
-		sdata->vif.type == NL80211_IFTYPE_AP;
-
 	err = sta_info_insert_rcu(sta);
 	if (err) {
 		rcu_read_unlock();
 		return err;
 	}
 
-	if (layer2_update)
-		cfg80211_send_layer2_update(sta->sdata->dev, sta->sta.addr);
-
 	rcu_read_unlock();
 
 	return 0;
@@ -1521,7 +1514,9 @@ static int ieee80211_change_station(stru
 				atomic_inc(&sta->sdata->bss->num_mcast_sta);
 		}
 
-		cfg80211_send_layer2_update(sta->sdata->dev, sta->sta.addr);
+		if (sta->sta_state == IEEE80211_STA_AUTHORIZED)
+			cfg80211_send_layer2_update(sta->sdata->dev,
+						    sta->sta.addr);
 	}
 
 	err = sta_apply_parameters(local, sta, params);
--- a/net/mac80211/sta_info.c
+++ b/net/mac80211/sta_info.c
@@ -1896,6 +1896,10 @@ int sta_info_move_state(struct sta_info
 			ieee80211_check_fast_xmit(sta);
 			ieee80211_check_fast_rx(sta);
 		}
+		if (sta->sdata->vif.type == NL80211_IFTYPE_AP_VLAN ||
+		    sta->sdata->vif.type == NL80211_IFTYPE_AP)
+			cfg80211_send_layer2_update(sta->sdata->dev,
+						    sta->sta.addr);
 		break;
 	default:
 		break;


