Return-Path: <SRS0=Q7wL=5E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FEFDC4332E
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 13:07:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA3142098B
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 13:07:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584623254;
	bh=CXO2uhnFYDXcQ/2+gZnXq7HDfKx4gTcFAJjOcphPXME=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=wfH5GNcbYOpwR3+/j6nY3a5qujNr9oq8NBEpR+u5xlYiyCdc/WSuilqErIDrptQzp
	 t/ELyFwnM8DhVsRPIh8DVikSNZOW5MjSm5bh4rQ81o5FKdSCDFTHsVPx2BGhe1sUTm
	 bs4hVL+9XJZKC0ShYgQ56CG/If2GEBWcoQHWFYHY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727955AbgCSNHd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Mar 2020 09:07:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:51234 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727283AbgCSNHb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Mar 2020 09:07:31 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 284FD20788;
        Thu, 19 Mar 2020 13:07:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584623250;
        bh=CXO2uhnFYDXcQ/2+gZnXq7HDfKx4gTcFAJjOcphPXME=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=osOjVdH0CuNZrNMDTId3vcF807V287GTPPS1WO7gGd07dxWU3El1jAB7Q2q0U/ub2
         zHmR8S8WkDPyqy7/12Koeu5ahY07GOpm3ihDSazB4tIp8r0mrX8ibYMQXImISzYMz7
         Et8mFaewxLhCrrp4H+AXstWKvudTHM7IElbG7PIw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sven Eckelmann <sven@narfation.org>,
        Marek Lindner <mareklindner@neomailbox.ch>,
        Antonio Quartulli <a@unstable.cc>
Subject: [PATCH 4.4 39/93] batman-adv: Only put gw_node list reference when removed
Date:   Thu, 19 Mar 2020 13:59:43 +0100
Message-Id: <20200319123937.486678083@linuxfoundation.org>
X-Mailer: git-send-email 2.25.2
In-Reply-To: <20200319123924.795019515@linuxfoundation.org>
References: <20200319123924.795019515@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sven Eckelmann <sven@narfation.org>

commit c18bdd018e8912ca73ad6c12120b7283b5038875 upstream.

The batadv_gw_node reference counter in batadv_gw_node_update can only be
reduced when the list entry was actually removed. Otherwise the reference
counter may reach zero when batadv_gw_node_update is called from two
different contexts for the same gw_node but only one context is actually
removing the entry from the list.

The release function for this gw_node is not called inside the list_lock
spinlock protected region because the function batadv_gw_node_update still
holds a gw_node reference for the object pointer on the stack. Thus the
actual release function (when required) will be called only at the end of
the function.

Fixes: bd3524c14bd0 ("batman-adv: remove obsolete deleted attribute for gateway node")
Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Marek Lindner <mareklindner@neomailbox.ch>
Signed-off-by: Antonio Quartulli <a@unstable.cc>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/batman-adv/gateway_client.c |    7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

--- a/net/batman-adv/gateway_client.c
+++ b/net/batman-adv/gateway_client.c
@@ -527,11 +527,12 @@ void batadv_gw_node_update(struct batadv
 		 * gets dereferenced.
 		 */
 		spin_lock_bh(&bat_priv->gw.list_lock);
-		hlist_del_init_rcu(&gw_node->list);
+		if (!hlist_unhashed(&gw_node->list)) {
+			hlist_del_init_rcu(&gw_node->list);
+			batadv_gw_node_free_ref(gw_node);
+		}
 		spin_unlock_bh(&bat_priv->gw.list_lock);
 
-		batadv_gw_node_free_ref(gw_node);
-
 		curr_gw = batadv_gw_get_selected_gw_node(bat_priv);
 		if (gw_node == curr_gw)
 			batadv_gw_reselect(bat_priv);


