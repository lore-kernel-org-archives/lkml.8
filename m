Return-Path: <SRS0=ltrd=5B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38A32C0044D
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 11:07:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ECFE820719
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 11:07:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584356852;
	bh=Yoi4vjM+pBCHhSmb2BxNlhsafO1rYMotKOOSy3NHdcs=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:List-ID:From;
	b=mEH96nlqNuu2XvGLQ4DvotObQXctbG3LxvWSQZ8VPUJEY62h2rCSuwO6fmo7Vrtyu
	 gqXnUStCvnzL81xPBMoMC/LJgz4OeJuxekRAPR7YbUffkZENyXu7TOrrruwFK3qIxQ
	 iazW8ed8ciyKIrideRjM3mYFY/6P8e+yUyi80KZw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730792AbgCPLHb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Mar 2020 07:07:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:38368 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730645AbgCPLHa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Mar 2020 07:07:30 -0400
Received: from tleilax.poochiereds.net (68-20-15-154.lightspeed.rlghnc.sbcglobal.net [68.20.15.154])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 406CD205ED;
        Mon, 16 Mar 2020 11:07:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584356849;
        bh=Yoi4vjM+pBCHhSmb2BxNlhsafO1rYMotKOOSy3NHdcs=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=0q3FrFPolyZyJmVapojOd7cYRxKT4kH14BcCg/Jgc6D5TJOJSoG6vzGvj00lwvFBr
         C7paH5LR23aO+yd3vULW3qv97m0sqU9dB1CJC13cOsJbxs1+Y8d6Vt26Bn2EhhwjC3
         vvcxoWvT8vDh1cQred1z7uRKO/U6h8RyzOKVGIRw=
Message-ID: <ce48ed9e48eda3c0f27d2f417314bd00cb1a68db.camel@kernel.org>
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
Date:   Mon, 16 Mar 2020 07:07:24 -0400
In-Reply-To: <87pndcsxc6.fsf@notabene.neil.brown.name>
References: <20200308140314.GQ5972@shao2-debian>
         <1bfba96b4bf0d3ca9a18a2bced3ef3a2a7b44dad.camel@kernel.org>
         <87blp5urwq.fsf@notabene.neil.brown.name>
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
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-gMbWT6Z2eu/7hmN1Hnqd"
User-Agent: Evolution 3.34.4 (3.34.4-1.fc31) 
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-gMbWT6Z2eu/7hmN1Hnqd
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2020-03-16 at 16:06 +1100, NeilBrown wrote:

[...]

> No, we really do need fl_blocked_requests to be empty.
> After fl_blocker is cleared, the owner might check for other blockers
> and might queue behind them leaving the blocked requests in place.
> Or it might have to detach all those blocked requests and wake them up
> so they can go and fend for themselves.
>=20
> I think the worse-case scenario could go something like that.
> Process A get a lock - Al
> Process B tries to get a conflicting lock and blocks Bl -> Al
> Process C tries to get a conflicting lock and blocks on B:
>    Cl -> Bl -> Al
>=20
> At much the same time that C goes to attach Cl to Bl, A
> calls unlock and B get signaled.
>=20
> So A is calling locks_wake_up_blocks(Al) - which takes blocked_lock_lock.
> C is calling  locks_insert_block(Bl, Cl) - which also takes the lock
> B is calling  locks_delete_block(Bl)  which might not take the lock.
>=20
> Assume C gets the lock first.
>=20
> Before C calls locks_insert_block, Bl->fl_blocked_requests is empty.
> After A finishes in locks_wake_up_blocks, Bl->fl_blocker is NULL
>=20
> If B sees that fl_blocker is NULL, we need it to see that
> fl_blocked_requests is no longer empty, so that it takes the lock and
> cleans up fl_blocked_requests.
>=20
> If the list_empty test on fl_blocked_request goes after the fl_blocker
> test, the memory barriers we have should assure that.  I had thought
> that it would need an extra barrier, but as a spinlock places the change
> to fl_blocked_requests *before* the change to fl_blocker, I no longer
> think that is needed.

Got it. I was thinking all of the waiters of a blocker would already be
awoken once fl_blocker was set to NULL, but you're correct and they
aren't. How about this?

-----------------8<------------------

=46rom f40e865842ae84a9d465ca9edb66f0985c1587d4 Mon Sep 17 00:00:00 2001
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 9 Mar 2020 14:35:43 -0400
Subject: [PATCH] locks: reinstate locks_delete_block optimization

There is measurable performance impact in some synthetic tests due to
commit 6d390e4b5d48 (locks: fix a potential use-after-free problem when
wakeup a waiter). Fix the race condition instead by clearing the
fl_blocker pointer after the wake_up, using explicit acquire/release
semantics.

This does mean that we can no longer use the clearing of fl_blocker as
the wait condition, so switch the waiters over to checking whether the
fl_blocked_member list_head is empty.

Cc: yangerkun <yangerkun@huawei.com>
Cc: NeilBrown <neilb@suse.de>
Fixes: 6d390e4b5d48 (locks: fix a potential use-after-free problem when wak=
eup a waiter)
Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/cifs/file.c |  3 ++-
 fs/locks.c     | 41 +++++++++++++++++++++++++++++++++++------
 2 files changed, 37 insertions(+), 7 deletions(-)

diff --git a/fs/cifs/file.c b/fs/cifs/file.c
index 3b942ecdd4be..8f9d849a0012 100644
--- a/fs/cifs/file.c
+++ b/fs/cifs/file.c
@@ -1169,7 +1169,8 @@ cifs_posix_lock_set(struct file *file, struct file_lo=
ck *flock)
 	rc =3D posix_lock_file(file, flock, NULL);
 	up_write(&cinode->lock_sem);
 	if (rc =3D=3D FILE_LOCK_DEFERRED) {
-		rc =3D wait_event_interruptible(flock->fl_wait, !flock->fl_blocker);
+		rc =3D wait_event_interruptible(flock->fl_wait,
+					list_empty(&flock->fl_blocked_member));
 		if (!rc)
 			goto try_again;
 		locks_delete_block(flock);
diff --git a/fs/locks.c b/fs/locks.c
index 426b55d333d5..eaf754ecdaa8 100644
--- a/fs/locks.c
+++ b/fs/locks.c
@@ -725,7 +725,6 @@ static void __locks_delete_block(struct file_lock *wait=
er)
 {
 	locks_delete_global_blocked(waiter);
 	list_del_init(&waiter->fl_blocked_member);
-	waiter->fl_blocker =3D NULL;
 }
=20
 static void __locks_wake_up_blocks(struct file_lock *blocker)
@@ -740,6 +739,12 @@ static void __locks_wake_up_blocks(struct file_lock *b=
locker)
 			waiter->fl_lmops->lm_notify(waiter);
 		else
 			wake_up(&waiter->fl_wait);
+
+		/*
+		 * Tell the world we're done with it - see comment at
+		 * top of locks_delete_block().
+		 */
+		smp_store_release(&waiter->fl_blocker, NULL);
 	}
 }
=20
@@ -753,11 +758,30 @@ int locks_delete_block(struct file_lock *waiter)
 {
 	int status =3D -ENOENT;
=20
+	/*
+	 * If fl_blocker is NULL, it won't be set again as this thread "owns"
+	 * the lock and is the only one that might try to claim the lock.
+	 * Because fl_blocker is explicitly set last during a delete, it's
+	 * safe to locklessly test to see if it's NULL. If it is, then we know
+	 * that no new locks can be inserted into its fl_blocked_requests list,
+	 * and we can therefore avoid doing anything further as long as that
+	 * list is empty.
+	 */
+	if (!smp_load_acquire(&waiter->fl_blocker) &&
+	    list_empty(&waiter->fl_blocked_requests))
+		return status;
+
 	spin_lock(&blocked_lock_lock);
 	if (waiter->fl_blocker)
 		status =3D 0;
 	__locks_wake_up_blocks(waiter);
 	__locks_delete_block(waiter);
+
+	/*
+	 * Tell the world we're done with it - see comment at top
+	 * of this function
+	 */
+	smp_store_release(&waiter->fl_blocker, NULL);
 	spin_unlock(&blocked_lock_lock);
 	return status;
 }
@@ -1350,7 +1374,8 @@ static int posix_lock_inode_wait(struct inode *inode,=
 struct file_lock *fl)
 		error =3D posix_lock_inode(inode, fl, NULL);
 		if (error !=3D FILE_LOCK_DEFERRED)
 			break;
-		error =3D wait_event_interruptible(fl->fl_wait, !fl->fl_blocker);
+		error =3D wait_event_interruptible(fl->fl_wait,
+					list_empty(&fl->fl_blocked_member));
 		if (error)
 			break;
 	}
@@ -1435,7 +1460,8 @@ int locks_mandatory_area(struct inode *inode, struct =
file *filp, loff_t start,
 		error =3D posix_lock_inode(inode, &fl, NULL);
 		if (error !=3D FILE_LOCK_DEFERRED)
 			break;
-		error =3D wait_event_interruptible(fl.fl_wait, !fl.fl_blocker);
+		error =3D wait_event_interruptible(fl.fl_wait,
+					list_empty(&fl.fl_blocked_member));
 		if (!error) {
 			/*
 			 * If we've been sleeping someone might have
@@ -1638,7 +1664,8 @@ int __break_lease(struct inode *inode, unsigned int m=
ode, unsigned int type)
=20
 	locks_dispose_list(&dispose);
 	error =3D wait_event_interruptible_timeout(new_fl->fl_wait,
-						!new_fl->fl_blocker, break_time);
+					list_empty(&new_fl->fl_blocked_member),
+					break_time);
=20
 	percpu_down_read(&file_rwsem);
 	spin_lock(&ctx->flc_lock);
@@ -2122,7 +2149,8 @@ static int flock_lock_inode_wait(struct inode *inode,=
 struct file_lock *fl)
 		error =3D flock_lock_inode(inode, fl);
 		if (error !=3D FILE_LOCK_DEFERRED)
 			break;
-		error =3D wait_event_interruptible(fl->fl_wait, !fl->fl_blocker);
+		error =3D wait_event_interruptible(fl->fl_wait,
+				list_empty(&fl->fl_blocked_member));
 		if (error)
 			break;
 	}
@@ -2399,7 +2427,8 @@ static int do_lock_file_wait(struct file *filp, unsig=
ned int cmd,
 		error =3D vfs_lock_file(filp, cmd, fl, NULL);
 		if (error !=3D FILE_LOCK_DEFERRED)
 			break;
-		error =3D wait_event_interruptible(fl->fl_wait, !fl->fl_blocker);
+		error =3D wait_event_interruptible(fl->fl_wait,
+					list_empty(&fl->fl_blocked_member));
 		if (error)
 			break;
 	}
--=20
2.24.1


--=-gMbWT6Z2eu/7hmN1Hnqd
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQJHBAABCAAxFiEES8DXskRxsqGE6vXTAA5oQRlWghUFAl5vXewTHGpsYXl0b25A
a2VybmVsLm9yZwAKCRAADmhBGVaCFR6aD/9/QfzgXZH02FAzu63FILmPrPZ/t+lT
QP8Jeewj1o4/5vaaIZfdOfzjIT4mwlgEjnYFh03t51IUjzBHI281JD8Dy7l2ItlZ
IkRN5oaI5IJGff3ZTIE6ZY2syGRBvvI4dzB5EebkB6Z/bfyTM9NlmoV9a4uRxtwr
Q7st6mDuSYV83MDdTlhqQzMFMfF/R1jUeZwm1mRJIcPfv1HWhHXT7IlJPcKAgkEz
dlYZwPLZdoIyh8+LHJS0hMdx/SdxEz0crNLBy9EwJt0y0R63NPrOlMzbmqOLIeT7
OTRys+OyGgAc9DjFWLxBdMnz+ARA+bxYXGgJlQHG/zlGNlLThXhEGzjRmoUEqhP4
c1jJyeysyucd+yBAdnuStLog7b0/HrOReW2W5TtghJy8xfFFVNEsZAlukivWxVP2
o1TZfcpu19iyRDeE/3hXTcTpbnId0wjKHyStg/nPOdMXsqGWZZ125xjbblkeMDv8
bmu6k9vk7XGkEQS1Z1VuO8Pv9fioCc28TPqakeec0L+J5rPkUqVeLlJa427EQ3gP
o4U2u4TrudT8Cy81tyDPRZkERgSAK2ruPiBSFo2Bkj44tf9Nsy+Fl9T3csibuuns
eEnTpzR9QFHtEajsVRSXUQ1nrgm/0GBVQ51ZRZYWLKM/xbBxY9FDsXg9RWct9qiE
cDJ7IuAfl8kCwQ==
=uMPN
-----END PGP SIGNATURE-----

--=-gMbWT6Z2eu/7hmN1Hnqd--

