Return-Path: <SRS0=Q7wL=5E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97547C4332E
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 13:11:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6EBA320722
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 13:11:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584623514;
	bh=If8LOuZuwFEjouDXrY7qAUXtG8O0r9olz6X8s3nhxu8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=s5ag8wYJJR7/BGQvnRG7WKsEZRgXnM5q5PJfLhjvtsamaQUDA67qFKG35rXH68mJR
	 HUPSdxLYEHFDSfV7LlDeSkMADVnGSrFiFOdOVe5CbPRLC0kz8DzijmU9hXInYbGpVm
	 XI3I1FVCo7vLOZDUQZBAFUsdAHDRzD+HhVV7voaM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728792AbgCSNLx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Mar 2020 09:11:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:57284 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728219AbgCSNLt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Mar 2020 09:11:49 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7908A20722;
        Thu, 19 Mar 2020 13:11:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584623508;
        bh=If8LOuZuwFEjouDXrY7qAUXtG8O0r9olz6X8s3nhxu8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tZI/AXDRcqFSXBGc3HvrNV3w9IlV/vdFmayqAlEcc+8lhgQaEnRa2/NLSBhI1Q7cf
         9nwvr90K67N5yXI910I/N1jnUEDlHCisd0MaPtWaLfQPDbAEUE4U8eIjQ5OpIOAAsE
         0HqdwpgCjWHNCZmcmIpzxEBhQgO3IRanE0z8kL+4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sven Eckelmann <sven@narfation.org>,
        Simon Wunderlich <sw@simonwunderlich.de>
Subject: [PATCH 4.9 51/90] batman-adv: Fix double free during fragment merge error
Date:   Thu, 19 Mar 2020 14:00:13 +0100
Message-Id: <20200319123944.264971850@linuxfoundation.org>
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

commit 248e23b50e2da0753f3b5faa068939cbe9f8a75a upstream.

The function batadv_frag_skb_buffer was supposed not to consume the skbuff
on errors. This was followed in the helper function
batadv_frag_insert_packet when the skb would potentially be inserted in the
fragment queue. But it could happen that the next helper function
batadv_frag_merge_packets would try to merge the fragments and fail. This
results in a kfree_skb of all the enqueued fragments (including the just
inserted one). batadv_recv_frag_packet would detect the error in
batadv_frag_skb_buffer and try to free the skb again.

The behavior of batadv_frag_skb_buffer (and its helper
batadv_frag_insert_packet) must therefore be changed to always consume the
skbuff to have a common behavior and avoid the double kfree_skb.

Fixes: 610bfc6bc99b ("batman-adv: Receive fragmented packets and merge")
Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/batman-adv/fragmentation.c |    8 +++++---
 net/batman-adv/routing.c       |    6 ++++++
 2 files changed, 11 insertions(+), 3 deletions(-)

--- a/net/batman-adv/fragmentation.c
+++ b/net/batman-adv/fragmentation.c
@@ -232,8 +232,10 @@ err_unlock:
 	spin_unlock_bh(&chain->lock);
 
 err:
-	if (!ret)
+	if (!ret) {
 		kfree(frag_entry_new);
+		kfree_skb(skb);
+	}
 
 	return ret;
 }
@@ -305,7 +307,7 @@ free:
  *
  * There are three possible outcomes: 1) Packet is merged: Return true and
  * set *skb to merged packet; 2) Packet is buffered: Return true and set *skb
- * to NULL; 3) Error: Return false and leave skb as is.
+ * to NULL; 3) Error: Return false and free skb.
  *
  * Return: true when packet is merged or buffered, false when skb is not not
  * used.
@@ -330,9 +332,9 @@ bool batadv_frag_skb_buffer(struct sk_bu
 		goto out_err;
 
 out:
-	*skb = skb_out;
 	ret = true;
 out_err:
+	*skb = skb_out;
 	return ret;
 }
 
--- a/net/batman-adv/routing.c
+++ b/net/batman-adv/routing.c
@@ -1080,6 +1080,12 @@ int batadv_recv_frag_packet(struct sk_bu
 	batadv_inc_counter(bat_priv, BATADV_CNT_FRAG_RX);
 	batadv_add_counter(bat_priv, BATADV_CNT_FRAG_RX_BYTES, skb->len);
 
+	/* batadv_frag_skb_buffer will always consume the skb and
+	 * the caller should therefore never try to free the
+	 * skb after this point
+	 */
+	ret = NET_RX_SUCCESS;
+
 	/* Add fragment to buffer and merge if possible. */
 	if (!batadv_frag_skb_buffer(&skb, orig_node_src))
 		goto out;


