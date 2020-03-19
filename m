Return-Path: <SRS0=Q7wL=5E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0A69C4332D
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 13:13:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85C2F217D8
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 13:13:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584623616;
	bh=yjNi86oaFDSgqj6/yczUW2ND54b8u6jSPhwePg5HJdI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=WEEt0dRk0OMrh9HVJF3XnaMWpfcOB191Nv5mFrhSBFl9L71/COQVBfk/dbaj9cGut
	 71Tj9uIbeebQDUPdDu4Tgqed7ov1hasSjsJTXdrgrBGvi49yZFSPJDTYRcO59+2TXV
	 mj2XSQ5B2/fUyV+O772YxVflt3FugvxaT+1yOcFQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727717AbgCSNNe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Mar 2020 09:13:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:60686 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729176AbgCSNN2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Mar 2020 09:13:28 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 08291215A4;
        Thu, 19 Mar 2020 13:13:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584623607;
        bh=yjNi86oaFDSgqj6/yczUW2ND54b8u6jSPhwePg5HJdI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=w0YGpeDaejPu/MX1zzH5ky8n9G00WUbiuB+yJHxwJPKN326V37ZWiCXluYS0XjgF4
         //cok2l8HI6U8l3Mbd+BmeBW4b8qOvgUp/z0Ki8qernaEsU27OEd2rRsc16UMZyVCd
         Udu/Em2J4qT6Lj9cWX5vz5T40Fv4O7/ARj7YOCzo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sven Eckelmann <sven@narfation.org>,
        Antonio Quartulli <a@unstable.cc>,
        Simon Wunderlich <sw@simonwunderlich.de>
Subject: [PATCH 4.9 76/90] batman-adv: Avoid probe ELP information leak
Date:   Thu, 19 Mar 2020 14:00:38 +0100
Message-Id: <20200319123951.944994893@linuxfoundation.org>
X-Mailer: git-send-email 2.25.2
In-Reply-To: <20200319123928.635114118@linuxfoundation.org>
References: <20200319123928.635114118@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sven Eckelmann <sven@narfation.org>

commit 88d0895d0ea9d4431507d576c963f2ff9918144d upstream.

The probe ELPs for WiFi interfaces are expanded to contain at least
BATADV_ELP_MIN_PROBE_SIZE bytes. This is usually a lot more than the
number of bytes which the template ELP packet requires.

These extra padding bytes were not initialized and thus could contain data
which were previously stored at the same location. It is therefore required
to set it to some predefined or random values to avoid leaking private
information from the system transmitting these kind of packets.

Fixes: e4623c913508 ("batman-adv: Avoid probe ELP information leak")
Signed-off-by: Sven Eckelmann <sven@narfation.org>
Acked-by: Antonio Quartulli <a@unstable.cc>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/batman-adv/bat_v_elp.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- a/net/batman-adv/bat_v_elp.c
+++ b/net/batman-adv/bat_v_elp.c
@@ -191,6 +191,7 @@ batadv_v_elp_wifi_neigh_probe(struct bat
 	struct sk_buff *skb;
 	int probe_len, i;
 	int elp_skb_len;
+	void *tmp;
 
 	/* this probing routine is for Wifi neighbours only */
 	if (!batadv_is_wifi_netdev(hard_iface->net_dev))
@@ -222,7 +223,8 @@ batadv_v_elp_wifi_neigh_probe(struct bat
 		 * the packet to be exactly of that size to make the link
 		 * throughput estimation effective.
 		 */
-		skb_put(skb, probe_len - hard_iface->bat_v.elp_skb->len);
+		tmp = skb_put(skb, probe_len - hard_iface->bat_v.elp_skb->len);
+		memset(tmp, 0, probe_len - hard_iface->bat_v.elp_skb->len);
 
 		batadv_dbg(BATADV_DBG_BATMAN, bat_priv,
 			   "Sending unicast (probe) ELP packet on interface %s to %pM\n",


