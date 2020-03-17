Return-Path: <SRS0=kRID=5C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CD8AC18E5B
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 15:59:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EEBAB20738
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 15:59:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584460769;
	bh=QKH9gO8a+divkhjn6vVthIrkDYpvb66V0Iq362aPVWc=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:List-ID:From;
	b=X/TxVfpd4XxprR9D7qSUQ0lPQCO3CmtZ79t2DBivRSMk46aW6ysTsmyId47evw8ys
	 vXkAZ1HSHm50RPsgN2s2Ry6ygAiMA9fK25WQ0/qN4dbbl0cpoz7DvcOG301kh2y1Ua
	 KbE/QXIVvKkGLOkRJw248unRqV48Q7nPpkH7yEQQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726757AbgCQP71 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Mar 2020 11:59:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:60416 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726294AbgCQP71 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Mar 2020 11:59:27 -0400
Received: from tleilax.poochiereds.net (68-20-15-154.lightspeed.rlghnc.sbcglobal.net [68.20.15.154])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E8CDA20724;
        Tue, 17 Mar 2020 15:59:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584460766;
        bh=QKH9gO8a+divkhjn6vVthIrkDYpvb66V0Iq362aPVWc=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=hVli641ctEManFaCzq3O11jVi1IXvi7M3f7R10/wM/B7rETW+kCfvBRioAEXQS1bT
         wUFrGuCkRGcWwHwaM+QxaArLG9Y0yu59tTDP+zag8cFE/GMWWDdyF/g8AQViXz78X5
         ju/FAEeNcULe7UYCq+cjr8yLTXDFv2Y+a/Q7Lb/k=
Message-ID: <46d2c16f48f1fd4ad28a85099c59ae95a9997740.camel@kernel.org>
Subject: Re: [locks] 6d390e4b5d: will-it-scale.per_process_ops -96.6%
 regression
From:   Jeff Layton <jlayton@kernel.org>
To:     NeilBrown <neilb@suse.de>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     yangerkun <yangerkun@huawei.com>,
        kernel test robot <rong.a.chen@intel.com>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        Bruce Fields <bfields@fieldses.org>,
        Al Viro <viro@zeniv.linux.org.uk>
Date:   Tue, 17 Mar 2020 11:59:24 -0400
In-Reply-To: <87k13jsyum.fsf@notabene.neil.brown.name>
References: <20200308140314.GQ5972@shao2-debian>
         <41c83d34ae4c166f48e7969b2b71e43a0f69028d.camel@kernel.org>
         <ed73fb5d-ddd5-fefd-67ae-2d786e68544a@huawei.com>
         <923487db2c9396c79f8e8dd4f846b2b1762635c8.camel@kernel.org>
         <36c58a6d07b67aac751fca27a4938dc1759d9267.camel@kernel.org>
         <878sk7vs8q.fsf@notabene.neil.brown.name>
         <c4ef31a663fbf7a3de349696e9f00f2f5c4ec89a.camel@kernel.org>
         <875zfbvrbm.fsf@notabene.neil.brown.name>
         <CAHk-=wg8N4fDRC3M21QJokoU+TQrdnv7HqoaFW-Z-ZT8z_Bi7Q@mail.gmail.com>
         <0066a9f150a55c13fcc750f6e657deae4ebdef97.camel@kernel.org>
         <CAHk-=whUgeZGcs5YAfZa07BYKNDCNO=xr4wT6JLATJTpX0bjGg@mail.gmail.com>
         <87v9nattul.fsf@notabene.neil.brown.name>
         <CAHk-=wiNoAk8v3GrbK3=q6KRBrhLrTafTmWmAo6-up6Ce9fp6A@mail.gmail.com>
         <87o8t2tc9s.fsf@notabene.neil.brown.name>
         <CAHk-=wj5jOYxjZSUNu_jdJ0zafRS66wcD-4H0vpQS=a14rS8jw@mail.gmail.com>
         <f000e352d9e103b3ade3506aac225920420d2323.camel@kernel.org>
         <877dznu0pk.fsf@notabene.neil.brown.name>
         <CAHk-=whYQqtW6B7oPmPr9-PXwyqUneF4sSFE+o3=7QcENstE-g@mail.gmail.com>
         <b5a1bb4c4494a370f915af479bcdf8b3b351eb6d.camel@kernel.org>
         <87pndcsxc6.fsf@notabene.neil.brown.name>
         <ce48ed9e48eda3c0f27d2f417314bd00cb1a68db.camel@kernel.org>
         <87k13jsyum.fsf@notabene.neil.brown.name>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 (3.34.4-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2020-03-17 at 09:45 +1100, NeilBrown wrote:
> > +
> > +	/*
> > +	 * Tell the world we're done with it - see comment at top
> > +	 * of this function
> 
> This comment might be misleading.  The world doesn't care.
> Only this thread cares where ->fl_blocker is NULL.  We need the release
> semantics when some *other* thread sets fl_blocker to NULL, not when
> this thread does.
> I don't think we need to spell that out and I'm not against using
> store_release here, but locks_delete_block cannot race with itself, so
> referring to the comment at the top of this function is misleading.
> 
> So:
>   Reviewed-by: NeilBrown <neilb@suse.de>
> 
> but I'm not totally happy with the comments.
> 
> 

Thanks Neil. We can clean up the comments before merge. How about this
revision to the earlier patch? I took the liberty of poaching your your
proposed verbiage:

------------------8<---------------------

From c9fbfae0ab615e20de0bdf1ae7b27591d602f577 Mon Sep 17 00:00:00 2001
From: Jeff Layton <jlayton@kernel.org>
Date: Mon, 16 Mar 2020 18:57:47 -0400
Subject: [PATCH] SQUASH: update with Neil's comments

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/locks.c | 31 ++++++++++++++++++++++---------
 1 file changed, 22 insertions(+), 9 deletions(-)

diff --git a/fs/locks.c b/fs/locks.c
index eaf754ecdaa8..e74075b0e8ec 100644
--- a/fs/locks.c
+++ b/fs/locks.c
@@ -741,8 +741,9 @@ static void __locks_wake_up_blocks(struct file_lock *blocker)
 			wake_up(&waiter->fl_wait);
 
 		/*
-		 * Tell the world we're done with it - see comment at
-		 * top of locks_delete_block().
+		 * The setting of fl_blocker to NULL marks the official "done"
+		 * point in deleting a block. Paired with acquire at the top
+		 * of locks_delete_block().
 		 */
 		smp_store_release(&waiter->fl_blocker, NULL);
 	}
@@ -761,11 +762,23 @@ int locks_delete_block(struct file_lock *waiter)
 	/*
 	 * If fl_blocker is NULL, it won't be set again as this thread "owns"
 	 * the lock and is the only one that might try to claim the lock.
-	 * Because fl_blocker is explicitly set last during a delete, it's
-	 * safe to locklessly test to see if it's NULL. If it is, then we know
-	 * that no new locks can be inserted into its fl_blocked_requests list,
-	 * and we can therefore avoid doing anything further as long as that
-	 * list is empty.
+	 *
+	 * We use acquire/release to manage fl_blocker so that we can
+	 * optimize away taking the blocked_lock_lock in many cases.
+	 *
+	 * The smp_load_acquire guarantees two things:
+	 *
+	 * 1/ that fl_blocked_requests can be tested locklessly. If something
+	 * was recently added to that list it must have been in a locked region
+	 * *before* the locked region when fl_blocker was set to NULL.
+	 *
+	 * 2/ that no other thread is accessing 'waiter', so it is safe to free
+	 * it.  __locks_wake_up_blocks is careful not to touch waiter after
+	 * fl_blocker is released.
+	 *
+	 * If a lockless check of fl_blocker shows it to be NULL, we know that
+	 * no new locks can be inserted into its fl_blocked_requests list, and
+	 * can avoid doing anything further if the list is empty.
 	 */
 	if (!smp_load_acquire(&waiter->fl_blocker) &&
 	    list_empty(&waiter->fl_blocked_requests))
@@ -778,8 +791,8 @@ int locks_delete_block(struct file_lock *waiter)
 	__locks_delete_block(waiter);
 
 	/*
-	 * Tell the world we're done with it - see comment at top
-	 * of this function
+	 * The setting of fl_blocker to NULL marks the official "done" point in
+	 * deleting a block. Paired with acquire at the top of this function.
 	 */
 	smp_store_release(&waiter->fl_blocker, NULL);
 	spin_unlock(&blocked_lock_lock);
-- 
2.24.1

