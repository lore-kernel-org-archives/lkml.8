Return-Path: <SRS0=Q7wL=5E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8A37C4332D
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 13:34:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF4AE20663
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 13:34:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584624878;
	bh=jWvfLHWRFDVu0lk90ON/QCNgNR0mI7eMzZMwsE0u8Ew=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=gC19GdcrlX/IFSBHZFXAoob4+xlWluD78eXjeH0GxKQZOG1KL1pcFL6EHjXH+vfD3
	 2XhCk0Lcsm53Mi06Tjn3sabT2LECGpRDeT8qssv/0duE5gcCG+6qGJGFIhFfbRqGXO
	 06Q+pL5cKmCx0X7DgO0nz+qGhEs0iq26idr0EohE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727546AbgCSNMs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Mar 2020 09:12:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:59102 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728457AbgCSNMp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Mar 2020 09:12:45 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 66BE62145D;
        Thu, 19 Mar 2020 13:12:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584623564;
        bh=jWvfLHWRFDVu0lk90ON/QCNgNR0mI7eMzZMwsE0u8Ew=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MT0L4zL+jf3y0DlPyTtLdLlgTy5ptMECMQvfnGgcrtS3G7DY9CnujOyUR/ulUVf1o
         0P9RywGAaooZqQ21tSH9I62FFuJoraSiA7KdPln+mHGxmisa6M+2yuJ5B9bffYAmZ+
         TzhirEjHgZiFKC0/JdXBs+/Yrv59bPu15uVSPQsg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sven Eckelmann <sven@narfation.org>,
        Marek Lindner <mareklindner@neomailbox.ch>,
        Simon Wunderlich <sw@simonwunderlich.de>
Subject: [PATCH 4.9 70/90] batman-adv: Prevent duplicated gateway_node entry
Date:   Thu, 19 Mar 2020 14:00:32 +0100
Message-Id: <20200319123950.114450764@linuxfoundation.org>
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

commit dff9bc42ab0b2d38c5e90ddd79b238fed5b4c7ad upstream.

The function batadv_gw_node_add is responsible for adding new gw_node to
the gateway_list. It is expecting that the caller already checked that
there is not already an entry with the same key or not.

But the lock for the list is only held when the list is really modified.
This could lead to duplicated entries because another context could create
an entry with the same key between the check and the list manipulation.

The check and the manipulation of the list must therefore be in the same
locked code section.

Fixes: c6c8fea29769 ("net: Add batman-adv meshing protocol")
Signed-off-by: Sven Eckelmann <sven@narfation.org>
Acked-by: Marek Lindner <mareklindner@neomailbox.ch>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/batman-adv/gateway_client.c |   11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

--- a/net/batman-adv/gateway_client.c
+++ b/net/batman-adv/gateway_client.c
@@ -31,6 +31,7 @@
 #include <linux/kernel.h>
 #include <linux/kref.h>
 #include <linux/list.h>
+#include <linux/lockdep.h>
 #include <linux/netdevice.h>
 #include <linux/netlink.h>
 #include <linux/rculist.h>
@@ -325,6 +326,9 @@ out:
  * @bat_priv: the bat priv with all the soft interface information
  * @orig_node: originator announcing gateway capabilities
  * @gateway: announced bandwidth information
+ *
+ * Has to be called with the appropriate locks being acquired
+ * (gw.list_lock).
  */
 static void batadv_gw_node_add(struct batadv_priv *bat_priv,
 			       struct batadv_orig_node *orig_node,
@@ -332,6 +336,8 @@ static void batadv_gw_node_add(struct ba
 {
 	struct batadv_gw_node *gw_node;
 
+	lockdep_assert_held(&bat_priv->gw.list_lock);
+
 	if (gateway->bandwidth_down == 0)
 		return;
 
@@ -346,10 +352,8 @@ static void batadv_gw_node_add(struct ba
 	gw_node->bandwidth_down = ntohl(gateway->bandwidth_down);
 	gw_node->bandwidth_up = ntohl(gateway->bandwidth_up);
 
-	spin_lock_bh(&bat_priv->gw.list_lock);
 	kref_get(&gw_node->refcount);
 	hlist_add_head_rcu(&gw_node->list, &bat_priv->gw.list);
-	spin_unlock_bh(&bat_priv->gw.list_lock);
 
 	batadv_dbg(BATADV_DBG_BATMAN, bat_priv,
 		   "Found new gateway %pM -> gw bandwidth: %u.%u/%u.%u MBit\n",
@@ -404,11 +408,14 @@ void batadv_gw_node_update(struct batadv
 {
 	struct batadv_gw_node *gw_node, *curr_gw = NULL;
 
+	spin_lock_bh(&bat_priv->gw.list_lock);
 	gw_node = batadv_gw_node_get(bat_priv, orig_node);
 	if (!gw_node) {
 		batadv_gw_node_add(bat_priv, orig_node, gateway);
+		spin_unlock_bh(&bat_priv->gw.list_lock);
 		goto out;
 	}
+	spin_unlock_bh(&bat_priv->gw.list_lock);
 
 	if ((gw_node->bandwidth_down == ntohl(gateway->bandwidth_down)) &&
 	    (gw_node->bandwidth_up == ntohl(gateway->bandwidth_up)))


