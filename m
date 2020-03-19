Return-Path: <SRS0=Q7wL=5E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F053C4332E
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 13:08:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66A7121556
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 13:08:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584623330;
	bh=EYQOWPY8vAXWHUB6f4RQwDkcB1H0VABO48Stohkc0fA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=OSWHkakTD6zhsLjdIo7Lx9ZftiyZrievKJs4hps/qfR0SubWFSLRl5BFcy2mi5TWU
	 XaEwIHxkqhjQRod7T9DfEG22xVAuE9y2J91XP+Moc2pomHIxEE9QwW/tDEFFpY+jXs
	 OQI0YdtSyGoRutKgkHqYXLcfugs20+KPdxdLxTMM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728202AbgCSNIt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Mar 2020 09:08:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:53010 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728197AbgCSNIp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Mar 2020 09:08:45 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C54172098B;
        Thu, 19 Mar 2020 13:08:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584623324;
        bh=EYQOWPY8vAXWHUB6f4RQwDkcB1H0VABO48Stohkc0fA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YjbLH5e3xWKVmvxIzxNSysyDUQ7KhY/XNDENQohTpk9PJUq5M8L7odTiZEtAy1IJq
         cbkPwLqcHW5l3W70uz+eoAUsx69sLaAMPqyqnoo1EQqMH3/8MfJA778y7f5LbJKfCu
         7w0qo5FZD2LsvpoQbg2cJPVkyXRoQ8a2DrgKdhX8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Martin Weinelt <martin@linuxlounge.net>,
        Sven Eckelmann <sven@narfation.org>,
        Antonio Quartulli <a@unstable.cc>,
        Simon Wunderlich <sw@simonwunderlich.de>
Subject: [PATCH 4.4 82/93] batman-adv: Reduce tt_global hash refcnt only for removed entry
Date:   Thu, 19 Mar 2020 14:00:26 +0100
Message-Id: <20200319123950.489055929@linuxfoundation.org>
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

commit f131a56880d10932931e74773fb8702894a94a75 upstream.

The batadv_hash_remove is a function which searches the hashtable for an
entry using a needle, a hashtable bucket selection function and a compare
function. It will lock the bucket list and delete an entry when the compare
function matches it with the needle. It returns the pointer to the
hlist_node which matches or NULL when no entry matches the needle.

The batadv_tt_global_free is not itself protected in anyway to avoid that
any other function is modifying the hashtable between the search for the
entry and the call to batadv_hash_remove. It can therefore happen that the
entry either doesn't exist anymore or an entry was deleted which is not the
same object as the needle. In such an situation, the reference counter (for
the reference stored in the hashtable) must not be reduced for the needle.
Instead the reference counter of the actually removed entry has to be
reduced.

Otherwise the reference counter will underflow and the object might be
freed before all its references were dropped. The kref helpers reported
this problem as:

  refcount_t: underflow; use-after-free.

Fixes: 7683fdc1e886 ("batman-adv: protect the local and the global trans-tables with rcu")
Reported-by: Martin Weinelt <martin@linuxlounge.net>
Signed-off-by: Sven Eckelmann <sven@narfation.org>
Acked-by: Antonio Quartulli <a@unstable.cc>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/batman-adv/translation-table.c |   18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

--- a/net/batman-adv/translation-table.c
+++ b/net/batman-adv/translation-table.c
@@ -508,14 +508,26 @@ static void batadv_tt_global_free(struct
 				  struct batadv_tt_global_entry *tt_global,
 				  const char *message)
 {
+	struct batadv_tt_global_entry *tt_removed_entry;
+	struct hlist_node *tt_removed_node;
+
 	batadv_dbg(BATADV_DBG_TT, bat_priv,
 		   "Deleting global tt entry %pM (vid: %d): %s\n",
 		   tt_global->common.addr,
 		   BATADV_PRINT_VID(tt_global->common.vid), message);
 
-	batadv_hash_remove(bat_priv->tt.global_hash, batadv_compare_tt,
-			   batadv_choose_tt, &tt_global->common);
-	batadv_tt_global_entry_free_ref(tt_global);
+	tt_removed_node = batadv_hash_remove(bat_priv->tt.global_hash,
+					     batadv_compare_tt,
+					     batadv_choose_tt,
+					     &tt_global->common);
+	if (!tt_removed_node)
+		return;
+
+	/* drop reference of remove hash entry */
+	tt_removed_entry = hlist_entry(tt_removed_node,
+				       struct batadv_tt_global_entry,
+				       common.hash_entry);
+	batadv_tt_global_entry_free_ref(tt_removed_entry);
 }
 
 /**


