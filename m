Return-Path: <SRS0=Q7wL=5E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE269C4332D
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 13:37:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9911E20787
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 13:37:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584625050;
	bh=5m/4LNJzcgDOPgG1OQAwVGIz81GYUpumboa+v5QL+i8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=JYMywLIQTcZgccv2H276fayctxUKXlYzqR0NjzwiroNv8pySK5rqHVHnyBv8jlFVU
	 rQA31D2bF6jNSFS1chuExM+i7O1PnD1IxHr57VLsSzXnvIP/WuuT3cq5tDLyTC0VGJ
	 bNoAiR4N1fP24WYiTvRQNCGF+MVm0qCA8hAdqsrI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728149AbgCSNh3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Mar 2020 09:37:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:52470 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727192AbgCSNIU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Mar 2020 09:08:20 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7A726208DB;
        Thu, 19 Mar 2020 13:08:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584623299;
        bh=5m/4LNJzcgDOPgG1OQAwVGIz81GYUpumboa+v5QL+i8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QaLnj0+G8bsJ9iWF1rnckjKREPyzUgqm8Gz3u6oe7ZDS+4WvKauHU9+OKLDVF3SK/
         tVE4DnFkM21ITXZMByQ7bDZwlqVbCfvSnfCcqQejfLG25OorFcxjS22flfuKpVLLIO
         /O/aOCFAeMggr+Bi9lzxT4ELCm9is9yb3IdOltDw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sven Eckelmann <sven@narfation.org>,
        Marek Lindner <mareklindner@neomailbox.ch>,
        Simon Wunderlich <sw@simonwunderlich.de>
Subject: [PATCH 4.4 59/93] batman-adv: Free last_bonding_candidate on release of orig_node
Date:   Thu, 19 Mar 2020 14:00:03 +0100
Message-Id: <20200319123943.584894613@linuxfoundation.org>
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

commit cbef1e102003edb236c6b2319ab269ccef963731 upstream.

The orig_ifinfo reference counter for last_bonding_candidate in
batadv_orig_node has to be reduced when an originator node is released.
Otherwise the orig_ifinfo is leaked and the reference counter the netdevice
is not reduced correctly.

Fixes: f3b3d9018975 ("batman-adv: add bonding again")
Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Marek Lindner <mareklindner@neomailbox.ch>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/batman-adv/originator.c |    7 +++++++
 1 file changed, 7 insertions(+)

--- a/net/batman-adv/originator.c
+++ b/net/batman-adv/originator.c
@@ -565,6 +565,7 @@ static void batadv_orig_node_release(str
 	struct batadv_neigh_node *neigh_node;
 	struct batadv_orig_ifinfo *orig_ifinfo;
 	struct batadv_orig_node_vlan *vlan;
+	struct batadv_orig_ifinfo *last_candidate;
 
 	spin_lock_bh(&orig_node->neigh_list_lock);
 
@@ -580,8 +581,14 @@ static void batadv_orig_node_release(str
 		hlist_del_rcu(&orig_ifinfo->list);
 		batadv_orig_ifinfo_free_ref(orig_ifinfo);
 	}
+
+	last_candidate = orig_node->last_bonding_candidate;
+	orig_node->last_bonding_candidate = NULL;
 	spin_unlock_bh(&orig_node->neigh_list_lock);
 
+	if (last_candidate)
+		batadv_orig_ifinfo_free_ref(last_candidate);
+
 	spin_lock_bh(&orig_node->vlan_list_lock);
 	hlist_for_each_entry_safe(vlan, node_tmp, &orig_node->vlan_list, list) {
 		hlist_del_rcu(&vlan->list);


