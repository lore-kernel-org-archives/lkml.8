Return-Path: <SRS0=ltrd=5B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B385C0044D
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 05:06:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4421620663
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 05:06:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729648AbgCPFGN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Mar 2020 01:06:13 -0400
Received: from mx2.suse.de ([195.135.220.15]:54734 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729536AbgCPFGN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Mar 2020 01:06:13 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id BBB02AC37;
        Mon, 16 Mar 2020 05:06:09 +0000 (UTC)
From:   NeilBrown <neilb@suse.de>
To:     Jeff Layton <jlayton@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 16 Mar 2020 16:06:01 +1100
Cc:     yangerkun <yangerkun@huawei.com>,
        kernel test robot <rong.a.chen@intel.com>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        Bruce Fields <bfields@fieldses.org>,
        Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: [locks] 6d390e4b5d: will-it-scale.per_process_ops -96.6% regression
In-Reply-To: <b5a1bb4c4494a370f915af479bcdf8b3b351eb6d.camel@kernel.org>
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
Message-ID: <87pndcsxc6.fsf@notabene.neil.brown.name>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha256; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Sun, Mar 15 2020, Jeff Layton wrote:

> On Sat, 2020-03-14 at 08:58 -0700, Linus Torvalds wrote:
>> On Fri, Mar 13, 2020 at 7:31 PM NeilBrown <neilb@suse.de> wrote:
>> > The idea of list_del_init_release() and list_empty_acquire() is growing
>> > on me though.  See below.
>>=20
>> This does look like a promising approach.
>>=20
>> However:
>>=20
>> > +       if (waiter->fl_blocker =3D=3D NULL &&
>> > +           list_empty(&waiter->fl_blocked_requests) &&
>> > +           list_empty_acquire(&waiter->fl_blocked_member))
>> > +               return status;
>>=20
>> This does not seem sensible to me.
>>=20
>> The thing is, the whole point about "acquire" semantics is that it
>> should happen _first_ - because a load-with-acquire only orders things
>> _after_ it.
>>=20
>> So testing some other non-locked state before testing the load-acquire
>> state makes little sense: it means that the other tests you do are
>> fundamentally unordered and nonsensical in an unlocked model.
>>=20
>> So _if_ those other tests matter (do they?), then they should be after
>> the acquire test (because they test things that on the writer side are
>> set before the "store-release"). Otherwise you're testing random
>> state.
>>=20
>> And if they don't matter, then they shouldn't exist at all.
>>=20
>> IOW, if you depend on ordering, then the _only_ ordering that exists is:
>>=20
>>  - writer side: writes done _before_ the smp_store_release() are visible
>>=20
>>  - to the reader side done _after_ the smp_load_acquire()
>>=20
>> and absolutely no other ordering exists or makes sense to test for.
>>=20
>> That limited ordering guarantee is why a store-release -> load-acquire
>> is fundamentally cheaper than any other serialization.
>>=20
>> So the optimistic "I don't need to do anything" case should start ouf wi=
th
>>=20
>>         if (list_empty_acquire(&waiter->fl_blocked_member)) {
>>=20
>> and go from there. Does it actually need to do anything else at all?
>> But if it does need to check the other fields, they should be checked
>> after that acquire.
>>=20
>> Also, it worries me that the comment talks about "if fl_blocker is
>> NULL". But it realy now is that fl_blocked_member list being empty
>> that is the real serialization test, adn that's the one that the
>> comment should primarily talk about.
>>=20
>
> Good point. The list manipulation and setting of fl_blocker are always
> done in conjunction, so I don't see why we'd need to check but one
> condition there (whichever gets the explicit acquire/release semantics).
>
> The fl_blocker pointer seems like the clearest way to indicate that to
> me, but if using list_empty makes sense for other reasons, I'm fine with
> that.
>
> This is what I have so far (leaving Linus as author since he did the
> original patch):
>
> ------------8<-------------
>
> From 1493f539e09dfcd5e0862209c6f7f292a2f2d228 Mon Sep 17 00:00:00 2001
> From: Linus Torvalds <torvalds@linux-foundation.org>
> Date: Mon, 9 Mar 2020 14:35:43 -0400
> Subject: [PATCH] locks: reinstate locks_delete_block optimization
>
> There is measurable performance impact in some synthetic tests due to
> commit 6d390e4b5d48 (locks: fix a potential use-after-free problem when
> wakeup a waiter). Fix the race condition instead by clearing the
> fl_blocker pointer after the wake_up, using explicit acquire/release
> semantics.
>
> With this change, we can just check for fl_blocker to clear as an
> indicator that the block is already deleted, and eliminate the
> list_empty check that was in the old optimization.
>
> This does mean that we can no longer use the clearing of fl_blocker as
> the wait condition, so switch the waiters over to checking whether the
> fl_blocked_member list_head is empty.
>
> Cc: yangerkun <yangerkun@huawei.com>
> Cc: NeilBrown <neilb@suse.de>
> Fixes: 6d390e4b5d48 (locks: fix a potential use-after-free problem when w=
akeup a waiter)
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
>  fs/cifs/file.c |  3 ++-
>  fs/locks.c     | 38 ++++++++++++++++++++++++++++++++------
>  2 files changed, 34 insertions(+), 7 deletions(-)
>
> diff --git a/fs/cifs/file.c b/fs/cifs/file.c
> index 3b942ecdd4be..8f9d849a0012 100644
> --- a/fs/cifs/file.c
> +++ b/fs/cifs/file.c
> @@ -1169,7 +1169,8 @@ cifs_posix_lock_set(struct file *file, struct file_=
lock *flock)
>  	rc =3D posix_lock_file(file, flock, NULL);
>  	up_write(&cinode->lock_sem);
>  	if (rc =3D=3D FILE_LOCK_DEFERRED) {
> -		rc =3D wait_event_interruptible(flock->fl_wait, !flock->fl_blocker);
> +		rc =3D wait_event_interruptible(flock->fl_wait,
> +					list_empty(&flock->fl_blocked_member));
>  		if (!rc)
>  			goto try_again;
>  		locks_delete_block(flock);
> diff --git a/fs/locks.c b/fs/locks.c
> index 426b55d333d5..652a09ab02d7 100644
> --- a/fs/locks.c
> +++ b/fs/locks.c
> @@ -725,7 +725,6 @@ static void __locks_delete_block(struct file_lock *wa=
iter)
>  {
>  	locks_delete_global_blocked(waiter);
>  	list_del_init(&waiter->fl_blocked_member);
> -	waiter->fl_blocker =3D NULL;
>  }
>=20=20
>  static void __locks_wake_up_blocks(struct file_lock *blocker)
> @@ -740,6 +739,12 @@ static void __locks_wake_up_blocks(struct file_lock =
*blocker)
>  			waiter->fl_lmops->lm_notify(waiter);
>  		else
>  			wake_up(&waiter->fl_wait);
> +
> +		/*
> +		 * Tell the world we're done with it - see comment at
> +		 * top of locks_delete_block().
> +		 */
> +		smp_store_release(&waiter->fl_blocker, NULL);
>  	}
>  }
>=20=20
> @@ -753,11 +758,27 @@ int locks_delete_block(struct file_lock *waiter)
>  {
>  	int status =3D -ENOENT;
>=20=20
> +	/*
> +	 * If fl_blocker is NULL, it won't be set again as this thread "owns"
> +	 * the lock and is the only one that might try to claim the lock.
> +	 * Because fl_blocker is explicitly set last during a delete, it's
> +	 * safe to locklessly test to see if it's NULL and avoid doing
> +	 * anything further if it is.
> +	 */
> +	if (!smp_load_acquire(&waiter->fl_blocker))
> +		return status;

No, we really do need fl_blocked_requests to be empty.
After fl_blocker is cleared, the owner might check for other blockers
and might queue behind them leaving the blocked requests in place.
Or it might have to detach all those blocked requests and wake them up
so they can go and fend for themselves.

I think the worse-case scenario could go something like that.
Process A get a lock - Al
Process B tries to get a conflicting lock and blocks Bl -> Al
Process C tries to get a conflicting lock and blocks on B:
   Cl -> Bl -> Al

At much the same time that C goes to attach Cl to Bl, A
calls unlock and B get signaled.

So A is calling locks_wake_up_blocks(Al) - which takes blocked_lock_lock.
C is calling  locks_insert_block(Bl, Cl) - which also takes the lock
B is calling  locks_delete_block(Bl)  which might not take the lock.

Assume C gets the lock first.

Before C calls locks_insert_block, Bl->fl_blocked_requests is empty.
After A finishes in locks_wake_up_blocks, Bl->fl_blocker is NULL

If B sees that fl_blocker is NULL, we need it to see that
fl_blocked_requests is no longer empty, so that it takes the lock and
cleans up fl_blocked_requests.

If the list_empty test on fl_blocked_request goes after the fl_blocker
test, the memory barriers we have should assure that.  I had thought
that it would need an extra barrier, but as a spinlock places the change
to fl_blocked_requests *before* the change to fl_blocker, I no longer
think that is needed.

Thanks,
NeilBrown


> +
>  	spin_lock(&blocked_lock_lock);
>  	if (waiter->fl_blocker)
>  		status =3D 0;
>  	__locks_wake_up_blocks(waiter);
>  	__locks_delete_block(waiter);
> +
> +	/*
> +	 * Tell the world we're done with it - see comment at top
> +	 * of this function
> +	 */
> +	smp_store_release(&waiter->fl_blocker, NULL);
>  	spin_unlock(&blocked_lock_lock);
>  	return status;
>  }
> @@ -1350,7 +1371,8 @@ static int posix_lock_inode_wait(struct inode *inod=
e, struct file_lock *fl)
>  		error =3D posix_lock_inode(inode, fl, NULL);
>  		if (error !=3D FILE_LOCK_DEFERRED)
>  			break;
> -		error =3D wait_event_interruptible(fl->fl_wait, !fl->fl_blocker);
> +		error =3D wait_event_interruptible(fl->fl_wait,
> +					list_empty(&fl->fl_blocked_member));
>  		if (error)
>  			break;
>  	}
> @@ -1435,7 +1457,8 @@ int locks_mandatory_area(struct inode *inode, struc=
t file *filp, loff_t start,
>  		error =3D posix_lock_inode(inode, &fl, NULL);
>  		if (error !=3D FILE_LOCK_DEFERRED)
>  			break;
> -		error =3D wait_event_interruptible(fl.fl_wait, !fl.fl_blocker);
> +		error =3D wait_event_interruptible(fl.fl_wait,
> +					list_empty(&fl.fl_blocked_member));
>  		if (!error) {
>  			/*
>  			 * If we've been sleeping someone might have
> @@ -1638,7 +1661,8 @@ int __break_lease(struct inode *inode, unsigned int=
 mode, unsigned int type)
>=20=20
>  	locks_dispose_list(&dispose);
>  	error =3D wait_event_interruptible_timeout(new_fl->fl_wait,
> -						!new_fl->fl_blocker, break_time);
> +					list_empty(&new_fl->fl_blocked_member),
> +					break_time);
>=20=20
>  	percpu_down_read(&file_rwsem);
>  	spin_lock(&ctx->flc_lock);
> @@ -2122,7 +2146,8 @@ static int flock_lock_inode_wait(struct inode *inod=
e, struct file_lock *fl)
>  		error =3D flock_lock_inode(inode, fl);
>  		if (error !=3D FILE_LOCK_DEFERRED)
>  			break;
> -		error =3D wait_event_interruptible(fl->fl_wait, !fl->fl_blocker);
> +		error =3D wait_event_interruptible(fl->fl_wait,
> +				list_empty(&fl->fl_blocked_member));
>  		if (error)
>  			break;
>  	}
> @@ -2399,7 +2424,8 @@ static int do_lock_file_wait(struct file *filp, uns=
igned int cmd,
>  		error =3D vfs_lock_file(filp, cmd, fl, NULL);
>  		if (error !=3D FILE_LOCK_DEFERRED)
>  			break;
> -		error =3D wait_event_interruptible(fl->fl_wait, !fl->fl_blocker);
> +		error =3D wait_event_interruptible(fl->fl_wait,
> +					list_empty(&fl->fl_blocked_member));
>  		if (error)
>  			break;
>  	}
> --=20
> 2.24.1

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEG8Yp69OQ2HB7X0l6Oeye3VZigbkFAl5vCTkACgkQOeye3VZi
gbmNeQ/+KswYY+Rmw0irgoahIBJWUky+S4bxNi9MrLC/V5MJe1lhi+qQxWhl2E6D
98DiTKsV6VdPdpZntg5csIR18fU75qYBilW/gG+5J8kE+dh/JGqMgGWosHjb3X0d
+MUPKwmDvuYGFciLQJMI/Y/D9+ylckTI8FjL79Kf3Pz8fpuPYMiGlQ9y135l5FaS
SjgyAUTi/eLr8ehf6Oy+z/1OYmWFai4HMhxC1Bv5oSNgiWl4yXPxb3ps60agAoEp
OxmqgNKcCl0D1esb3Qnap06LPY7H2kPs9EPp+SpzTKaraJrPRTfsErV5d8wKvOwL
BqR+28a/Eo+x+NSog8GJRnFufHAXsISDkZDF29979BAks1y5Ybcor/Vb12aArnm5
+sym68DAlPHkpkZC/zJdKTsX761owRpMUyg7HaE+UIAK34oz5uM2n5H2sye1ZwH2
02VUwVMGOP6a5aJxmA8Stnhb+Qz6QyMoS37sphOQnUo6HJC2B2HqQRSp/5qtvlnr
kwnYy4d8HFutcW7TUgXWBWKxXEKen7GTmyZGOBZHccf0hY8vJKUkIJ+4ml3eZebj
bXF8CYirdi6Tdrls3ydCZT/MOd5HruuWuVnh3SD4iTdo7jYC/s02zEkJ/e0635Zt
cWHhrAOxTNPtyo7AWLIh2znipHPzVgXkQ6KAn5wt7oiXHvY25OA=
=RFqA
-----END PGP SIGNATURE-----
--=-=-=--
