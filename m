Return-Path: <SRS0=ObIu=6N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA5DBC83003
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 13:08:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 92AC62074A
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 13:08:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="A1P9Z1EQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726812AbgD2NIt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Apr 2020 09:08:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726516AbgD2NIt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Apr 2020 09:08:49 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C70B2C03C1AD;
        Wed, 29 Apr 2020 06:08:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Transfer-Encoding
        :Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=AyLMpojfSDcshP2OGw7tMbAp20EERqjQfToIT1YcV9Y=; b=A1P9Z1EQPE9z3+AvSk54QE9RII
        wW+3ExnefJL8JiA4Y8804FEhojjVbr8BszmXz5tZkFDxb2CiLnHLxQ2JfWlQHo64eX8Q+oI/mWI1G
        9n/bi6dkHFzRH9zg+PDdDE+qMxA7p9BXqAIBaKmfmQMXnOx1QwA/4Gt4/SPD8TlRxfqH2fv2tkUsZ
        EFufMyMmhP7QOBQnz/GjEEV61KguMw8q3Sp1/HhcDCs/NrpmhdUzFXQUtYVPtRMMOKzEy9qEoKfFZ
        2YbNkdwsVhLXH9dZe4thd926kMyQ1VsSa1gbXikIjcP9wV2xmvj9228xeBxKchtXrhJHZ2jkSvT+M
        JAS6sqEA==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jTmS3-0005Yq-Ty; Wed, 29 Apr 2020 13:08:35 +0000
Date:   Wed, 29 Apr 2020 06:08:35 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Manfred Spraul <manfred@colorfullife.com>
Cc:     Wei Yongjun <weiyongjun1@huawei.com>,
        Pankaj Bharadiya <pankaj.laxminarayan.bharadiya@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Waiman Long <longman@redhat.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH -next] ipc: use GFP_ATOMIC under spin lock
Message-ID: <20200429130835.GS29705@bombadil.infradead.org>
References: <20200428034736.27850-1-weiyongjun1@huawei.com>
 <20200428111403.GJ29705@bombadil.infradead.org>
 <a0f82756-3e51-d960-d901-e4cc3c7c4c19@colorfullife.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a0f82756-3e51-d960-d901-e4cc3c7c4c19@colorfullife.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 29, 2020 at 07:22:13AM +0200, Manfred Spraul wrote:
> Hello together,
> 
> On 4/28/20 1:14 PM, Matthew Wilcox wrote:
> > On Tue, Apr 28, 2020 at 03:47:36AM +0000, Wei Yongjun wrote:
> > > The function ipc_id_alloc() is called from ipc_addid(), in which
> > > a spin lock is held, so we should use GFP_ATOMIC instead.
> > > 
> > > Fixes: de5738d1c364 ("ipc: convert ipcs_idr to XArray")
> > > Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
> > I see why you think that, but it's not true.  Yes, we hold a spinlock, but
> > the spinlock is in an object which is not reachable from any other CPU.
> 
> Is it really allowed that spin_lock()/spin_unlock may happen on different
> cpus?
> 
> CPU1: spin_lock()
> 
> CPU1: schedule() -> sleeps
> 
> CPU2: -> schedule() returns
> 
> CPU2: spin_unlock().

I think that is allowed, but I'm not an expert in the implementations.

> > Converting to GFP_ATOMIC is completely wrong.
> 
> What is your solution proposal?
> 
> xa_store() also gets a gfp_ flag. Thus even splitting _alloc() and _store()
> won't help
> 
>     xa_alloc(,entry=NULL,)
>     new->seq = ...
>     spin_lock();
>     xa_store(,entry=new,GFP_KERNEL);

While it takes GFP flags, it won't do any allocation if it's overwriting
an allocated entry.

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
