Return-Path: <SRS0=RcPI=7S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0F66C433DF
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 20:11:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 91539206FA
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 20:11:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="mjKCKwJi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728166AbgFEULn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Jun 2020 16:11:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728091AbgFEULk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jun 2020 16:11:40 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E7E1C08C5C2;
        Fri,  5 Jun 2020 13:11:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=uH+/HPsvMfloXqG8Di3N1C7L9r1tjiWx2NoZn1vBzmA=; b=mjKCKwJi5vTCR5U4iFHMsGzhuT
        CS2s3xkLDR6vlAWoZY7ARu0ilGtTQGxDUio3x0uZoDM9eZY5e1r9cHDEW6HXyEJyeHGW/qix51c5G
        4egOBW8XuqZcil7mZiXClFCA/DwOcZJUeH1lo0SKspz/BoE0NKHQH56RnfZkv0xkQYAo3r3/raDoR
        XPZxnXgG2MOC9/FVQ+FNqCCbNTiqlMyOU17j8FMAMikrCvMxxcotEwll8DKUsGSmLh1WboMoPbaKJ
        W225mUOvU/nlyKFVc13RcuHeE4wqt69udlFXAs9NGt034oj7JLq0mL33kImB6fY8naWTVGTVMhW+h
        0Qd8bZzQ==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jhIgg-0000bM-HX; Fri, 05 Jun 2020 20:11:34 +0000
Date:   Fri, 5 Jun 2020 13:11:34 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Qian Cai <cai@lca.pw>
Cc:     linux-kernel@vger.kernel.org, dave@stgolabs.net,
        manfred@colorfullife.com, mm-commits@vger.kernel.org,
        akpm@linux-foundation.org
Subject: Re: + ipc-convert-ipcs_idr-to-xarray-update.patch added to -mm tree
Message-ID: <20200605201134.GJ19604@bombadil.infradead.org>
References: <20200420181310.c18b3c0aa4dc5b3e5ec1be10@linux-foundation.org>
 <20200424014753.DfBuzjmzo%akpm@linux-foundation.org>
 <20200605195848.GB5393@lca.pw>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200605195848.GB5393@lca.pw>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 05, 2020 at 03:58:48PM -0400, Qian Cai wrote:
> This will trigger,
> 
> [ 8853.759549] LTP: starting semget05
> [ 8867.257088] BUG: sleeping function called from invalid context at mm/slab.h:567
> [ 8867.270259] in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 22556, name: semget05
> [ 8867.270309] 2 locks held by semget05/22556:
> [ 8867.270345]  #0: 00000000512de7e0 (&ids->rwsem){++++}-{3:3}, at: ipcget+0x4e/0x230
> [ 8867.270426]  #1: 00000000552b9018 (&new->lock){+.+.}-{2:2}, at: ipc_addid+0xf4/0xf50

Did the fix for this not make it into -next?

commit f0ef33eea4bbbb4129fe79fd73088b668b6fd947
Author: Matthew Wilcox (Oracle) <willy@infradead.org>
Date:   Thu Apr 30 15:27:51 2020 -0400

    fixes

diff --git a/ipc/util.c b/ipc/util.c
index 0f6b0e0aa17e..b929ab0072a5 100644
--- a/ipc/util.c
+++ b/ipc/util.c
@@ -19,8 +19,8 @@
  *
  * General sysv ipc locking scheme:
  *	rcu_read_lock()
- *          obtain the ipc object (kern_ipc_perm) by looking up the id in an idr
- *	    tree.
+ *          obtain the ipc object (kern_ipc_perm) by looking up the id in an
+ *	    xarray.
  *	    - perform initial checks (capabilities, auditing and permission,
  *	      etc).
  *	    - perform read-only operations, such as INFO command, that
@@ -209,14 +209,14 @@ static inline int ipc_id_alloc(struct ipc_ids *ids, struct kern_ipc_perm *new)
 	u32 idx;
 	int err;
 
+	xa_lock(&ids->ipcs);
+
 	if (get_restore_id(ids) < 0) {
 		int max_idx;
 
 		max_idx = max(ids->in_use*3/2, ipc_min_cycle);
 		max_idx = min(max_idx, ipc_mni) - 1;
 
-		xa_lock(&ids->ipcs);
-
 		err = __xa_alloc_cyclic(&ids->ipcs, &idx, NULL,
 				XA_LIMIT(0, max_idx), &ids->next_idx,
 				GFP_KERNEL);
@@ -224,24 +224,31 @@ static inline int ipc_id_alloc(struct ipc_ids *ids, struct kern_ipc_perm *new)
 			ids->seq++;
 			if (ids->seq >= ipcid_seq_max())
 				ids->seq = 0;
+			err = 0;
 		}
 
-		if (err >= 0) {
+		if (!err) {
 			new->seq = ids->seq;
 			new->id = (new->seq << ipcmni_seq_shift()) + idx;
-			/* xa_store contains a write barrier */
-			__xa_store(&ids->ipcs, idx, new, GFP_KERNEL);
 		}
-
-		xa_unlock(&ids->ipcs);
 	} else {
 		new->id = get_restore_id(ids);
 		new->seq = ipcid_to_seqx(new->id);
 		idx = ipcid_to_idx(new->id);
-		err = xa_insert(&ids->ipcs, idx, new, GFP_KERNEL);
+		err = __xa_insert(&ids->ipcs, idx, NULL, GFP_KERNEL);
 		set_restore_id(ids, -1);
 	}
 
+	/*
+	 * Hold the spinlock so that nobody else can access the object
+	 * once they can find it.  xa_store contains a write barrier so
+	 * all previous stores to 'new' will be visible.
+	 */
+	spin_lock(&new->lock);
+	if (!err)
+		__xa_store(&ids->ipcs, idx, new, GFP_NOWAIT);
+	xa_unlock(&ids->ipcs);
+
 	if (err == -EBUSY)
 		return -ENOSPC;
 	if (err < 0)
@@ -255,7 +262,7 @@ static inline int ipc_id_alloc(struct ipc_ids *ids, struct kern_ipc_perm *new)
  * @new: new ipc permission set
  * @limit: limit for the number of used ids
  *
- * Add an entry 'new' to the ipc ids idr. The permissions object is
+ * Add an entry 'new' to the ipc ids. The permissions object is
  * initialised and the first free entry is set up and the index assigned
  * is returned. The 'new' entry is returned in a locked state on success.
  *
@@ -270,7 +277,7 @@ int ipc_addid(struct ipc_ids *ids, struct kern_ipc_perm *new, int limit)
 	kgid_t egid;
 	int idx;
 
-	/* 1) Initialize the refcount so that ipc_rcu_putref works */
+	/* Initialize the refcount so that ipc_rcu_putref works */
 	refcount_set(&new->refcount, 1);
 
 	if (limit > ipc_mni)
@@ -279,12 +286,7 @@ int ipc_addid(struct ipc_ids *ids, struct kern_ipc_perm *new, int limit)
 	if (ids->in_use >= limit)
 		return -ENOSPC;
 
-	/*
-	 * 2) Hold the spinlock so that nobody else can access the object
-	 * once they can find it
-	 */
 	spin_lock_init(&new->lock);
-	spin_lock(&new->lock);
 	current_euid_egid(&euid, &egid);
 	new->cuid = new->uid = euid;
 	new->gid = new->cgid = egid;
@@ -588,7 +590,7 @@ void ipc64_perm_to_ipc_perm(struct ipc64_perm *in, struct ipc_perm *out)
  * @ids: ipc identifier set
  * @id: ipc id to look for
  *
- * Look for an id in the ipc ids idr and return associated ipc object.
+ * Look for an id in the ipc ids and return associated ipc object.
  *
  * Call inside the RCU critical section.
  * The ipc object is *not* locked on exit.
