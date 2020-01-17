Return-Path: <SRS0=N8G3=3G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56609C33CB1
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 12:59:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1FB762083E
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 12:59:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b="LBDK3Rdf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728680AbgAQM7B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jan 2020 07:59:01 -0500
Received: from esa6.hc3370-68.iphmx.com ([216.71.155.175]:24029 "EHLO
        esa6.hc3370-68.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727047AbgAQM6x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jan 2020 07:58:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=citrix.com; s=securemail; t=1579265933;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=imzAVPRg8eCVer6WghQ9w5Jf3bFTfGNNdETp9UAPsoY=;
  b=LBDK3RdfK7pAKL9n2022+r51pYcxPuHElWuIHYJPHCxRGXFjhVAzNadb
   3A7MQymnkA7O/9dVg2zkRjaig0mDHUrx7Wa++a9MYnCQzGahmvN9LdswV
   y6Dld/m8pDdjcAi7PuzQsOlWbVcqcZLDSptMgPhN/XqfbZED8Kgeso7cM
   g=;
Authentication-Results: esa6.hc3370-68.iphmx.com; dkim=none (message not signed) header.i=none; spf=None smtp.pra=sergey.dyasli@citrix.com; spf=Pass smtp.mailfrom=sergey.dyasli@citrix.com; spf=None smtp.helo=postmaster@mail.citrix.com
Received-SPF: None (esa6.hc3370-68.iphmx.com: no sender
  authenticity information available from domain of
  sergey.dyasli@citrix.com) identity=pra;
  client-ip=162.221.158.21; receiver=esa6.hc3370-68.iphmx.com;
  envelope-from="sergey.dyasli@citrix.com";
  x-sender="sergey.dyasli@citrix.com";
  x-conformance=sidf_compatible
Received-SPF: Pass (esa6.hc3370-68.iphmx.com: domain of
  sergey.dyasli@citrix.com designates 162.221.158.21 as
  permitted sender) identity=mailfrom;
  client-ip=162.221.158.21; receiver=esa6.hc3370-68.iphmx.com;
  envelope-from="sergey.dyasli@citrix.com";
  x-sender="sergey.dyasli@citrix.com";
  x-conformance=sidf_compatible; x-record-type="v=spf1";
  x-record-text="v=spf1 ip4:209.167.231.154 ip4:178.63.86.133
  ip4:195.66.111.40/30 ip4:85.115.9.32/28 ip4:199.102.83.4
  ip4:192.28.146.160 ip4:192.28.146.107 ip4:216.52.6.88
  ip4:216.52.6.188 ip4:162.221.158.21 ip4:162.221.156.83
  ip4:168.245.78.127 ~all"
Received-SPF: None (esa6.hc3370-68.iphmx.com: no sender
  authenticity information available from domain of
  postmaster@mail.citrix.com) identity=helo;
  client-ip=162.221.158.21; receiver=esa6.hc3370-68.iphmx.com;
  envelope-from="sergey.dyasli@citrix.com";
  x-sender="postmaster@mail.citrix.com";
  x-conformance=sidf_compatible
IronPort-SDR: 9Pu+Dt4AmrdPopz9X+nqR/BgvGLwCGMi4qVLlyuEh3k94OexmfeofNXTntlanbYRuLsYxfZlBT
 Lrz3S4mzj+puxMJ8Jo8y0SfffVP7bc/scRO23dHBd+HX4rVw+kT+b7tFlF8c35lmDBLBJ1mctn
 9EZXkeeJCjvAkP89TdmjIz9xq7qCRFedYIaST8GIAjgqtr6KH2oRrTOJGpO4JtV9OtGaVMwiCK
 IH/1chH8J4VSQ7BL2hBX6eO3omZmcU4WoyMDnXGfzaGCdmOjnujJAIYi5Amz6ZEpyDylGUShII
 GIE=
X-SBRS: 2.7
X-MesageID: 11502060
X-Ironport-Server: esa6.hc3370-68.iphmx.com
X-Remote-IP: 162.221.158.21
X-Policy: $RELAYED
X-IronPort-AV: E=Sophos;i="5.70,330,1574139600"; 
   d="scan'208";a="11502060"
From:   Sergey Dyasli <sergey.dyasli@citrix.com>
To:     <xen-devel@lists.xen.org>, <kasan-dev@googlegroups.com>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
CC:     Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        "Stefano Stabellini" <sstabellini@kernel.org>,
        George Dunlap <george.dunlap@citrix.com>,
        Ross Lagerwall <ross.lagerwall@citrix.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Sergey Dyasli <sergey.dyasli@citrix.com>,
        Wei Liu <wei.liu@kernel.org>, Paul Durrant <paul@xen.org>
Subject: [PATCH v2 4/4] xen/netback: fix grant copy across page boundary
Date:   Fri, 17 Jan 2020 12:58:34 +0000
Message-ID: <20200117125834.14552-5-sergey.dyasli@citrix.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200117125834.14552-1-sergey.dyasli@citrix.com>
References: <20200117125834.14552-1-sergey.dyasli@citrix.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ross Lagerwall <ross.lagerwall@citrix.com>

When KASAN (or SLUB_DEBUG) is turned on, there is a higher chance that
non-power-of-two allocations are not aligned to the next power of 2 of
the size. Therefore, handle grant copies that cross page boundaries.

Signed-off-by: Ross Lagerwall <ross.lagerwall@citrix.com>
Signed-off-by: Sergey Dyasli <sergey.dyasli@citrix.com>
---
v1 --> v2:
- Use sizeof_field(struct sk_buff, cb)) instead of magic number 48
- Slightly update commit message

RFC --> v1:
- Added BUILD_BUG_ON to the netback patch
- xenvif_idx_release() now located outside the loop

CC: Wei Liu <wei.liu@kernel.org>
CC: Paul Durrant <paul@xen.org>
---
 drivers/net/xen-netback/common.h  |  2 +-
 drivers/net/xen-netback/netback.c | 60 +++++++++++++++++++++++++------
 2 files changed, 50 insertions(+), 12 deletions(-)

diff --git a/drivers/net/xen-netback/common.h b/drivers/net/xen-netback/common.h
index 05847eb91a1b..e57684415edd 100644
--- a/drivers/net/xen-netback/common.h
+++ b/drivers/net/xen-netback/common.h
@@ -155,7 +155,7 @@ struct xenvif_queue { /* Per-queue data for xenvif */
 	struct pending_tx_info pending_tx_info[MAX_PENDING_REQS];
 	grant_handle_t grant_tx_handle[MAX_PENDING_REQS];
 
-	struct gnttab_copy tx_copy_ops[MAX_PENDING_REQS];
+	struct gnttab_copy tx_copy_ops[MAX_PENDING_REQS * 2];
 	struct gnttab_map_grant_ref tx_map_ops[MAX_PENDING_REQS];
 	struct gnttab_unmap_grant_ref tx_unmap_ops[MAX_PENDING_REQS];
 	/* passed to gnttab_[un]map_refs with pages under (un)mapping */
diff --git a/drivers/net/xen-netback/netback.c b/drivers/net/xen-netback/netback.c
index 0020b2e8c279..f8774ede9f0e 100644
--- a/drivers/net/xen-netback/netback.c
+++ b/drivers/net/xen-netback/netback.c
@@ -320,6 +320,7 @@ static int xenvif_count_requests(struct xenvif_queue *queue,
 
 struct xenvif_tx_cb {
 	u16 pending_idx;
+	u8 copies;
 };
 
 #define XENVIF_TX_CB(skb) ((struct xenvif_tx_cb *)(skb)->cb)
@@ -439,6 +440,7 @@ static int xenvif_tx_check_gop(struct xenvif_queue *queue,
 {
 	struct gnttab_map_grant_ref *gop_map = *gopp_map;
 	u16 pending_idx = XENVIF_TX_CB(skb)->pending_idx;
+	u8 copies = XENVIF_TX_CB(skb)->copies;
 	/* This always points to the shinfo of the skb being checked, which
 	 * could be either the first or the one on the frag_list
 	 */
@@ -450,23 +452,26 @@ static int xenvif_tx_check_gop(struct xenvif_queue *queue,
 	int nr_frags = shinfo->nr_frags;
 	const bool sharedslot = nr_frags &&
 				frag_get_pending_idx(&shinfo->frags[0]) == pending_idx;
-	int i, err;
+	int i, err = 0;
 
-	/* Check status of header. */
-	err = (*gopp_copy)->status;
-	if (unlikely(err)) {
-		if (net_ratelimit())
-			netdev_dbg(queue->vif->dev,
+	while (copies) {
+		/* Check status of header. */
+		int newerr = (*gopp_copy)->status;
+		if (unlikely(newerr)) {
+			if (net_ratelimit())
+				netdev_dbg(queue->vif->dev,
 				   "Grant copy of header failed! status: %d pending_idx: %u ref: %u\n",
 				   (*gopp_copy)->status,
 				   pending_idx,
 				   (*gopp_copy)->source.u.ref);
-		/* The first frag might still have this slot mapped */
-		if (!sharedslot)
-			xenvif_idx_release(queue, pending_idx,
-					   XEN_NETIF_RSP_ERROR);
+			err = newerr;
+		}
+		(*gopp_copy)++;
+		copies--;
 	}
-	(*gopp_copy)++;
+	/* The first frag might still have this slot mapped */
+	if (unlikely(err) && !sharedslot)
+		xenvif_idx_release(queue, pending_idx, XEN_NETIF_RSP_ERROR);
 
 check_frags:
 	for (i = 0; i < nr_frags; i++, gop_map++) {
@@ -910,6 +915,7 @@ static void xenvif_tx_build_gops(struct xenvif_queue *queue,
 			xenvif_tx_err(queue, &txreq, extra_count, idx);
 			break;
 		}
+		XENVIF_TX_CB(skb)->copies = 0;
 
 		skb_shinfo(skb)->nr_frags = ret;
 		if (data_len < txreq.size)
@@ -933,6 +939,7 @@ static void xenvif_tx_build_gops(struct xenvif_queue *queue,
 						   "Can't allocate the frag_list skb.\n");
 				break;
 			}
+			XENVIF_TX_CB(nskb)->copies = 0;
 		}
 
 		if (extras[XEN_NETIF_EXTRA_TYPE_GSO - 1].type) {
@@ -990,6 +997,31 @@ static void xenvif_tx_build_gops(struct xenvif_queue *queue,
 
 		queue->tx_copy_ops[*copy_ops].len = data_len;
 		queue->tx_copy_ops[*copy_ops].flags = GNTCOPY_source_gref;
+		XENVIF_TX_CB(skb)->copies++;
+
+		if (offset_in_page(skb->data) + data_len > XEN_PAGE_SIZE) {
+			unsigned int extra_len = offset_in_page(skb->data) +
+					     data_len - XEN_PAGE_SIZE;
+
+			queue->tx_copy_ops[*copy_ops].len -= extra_len;
+			(*copy_ops)++;
+
+			queue->tx_copy_ops[*copy_ops].source.u.ref = txreq.gref;
+			queue->tx_copy_ops[*copy_ops].source.domid =
+				queue->vif->domid;
+			queue->tx_copy_ops[*copy_ops].source.offset =
+				txreq.offset + data_len - extra_len;
+
+			queue->tx_copy_ops[*copy_ops].dest.u.gmfn =
+				virt_to_gfn(skb->data + data_len - extra_len);
+			queue->tx_copy_ops[*copy_ops].dest.domid = DOMID_SELF;
+			queue->tx_copy_ops[*copy_ops].dest.offset = 0;
+
+			queue->tx_copy_ops[*copy_ops].len = extra_len;
+			queue->tx_copy_ops[*copy_ops].flags = GNTCOPY_source_gref;
+
+			XENVIF_TX_CB(skb)->copies++;
+		}
 
 		(*copy_ops)++;
 
@@ -1674,5 +1706,11 @@ static void __exit netback_fini(void)
 }
 module_exit(netback_fini);
 
+static void __init __maybe_unused build_assertions(void)
+{
+	BUILD_BUG_ON(sizeof(struct xenvif_tx_cb) >
+		     sizeof_field(struct sk_buff, cb));
+}
+
 MODULE_LICENSE("Dual BSD/GPL");
 MODULE_ALIAS("xen-backend:vif");
-- 
2.17.1

