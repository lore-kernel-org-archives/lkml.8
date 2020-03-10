Return-Path: <SRS0=K2g5=43=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 619EBC10DCE
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 21:02:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D218215A4
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 21:02:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726488AbgCJVCL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 17:02:11 -0400
Received: from mx2.suse.de ([195.135.220.15]:50898 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726265AbgCJVCK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 17:02:10 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 4184FADBB;
        Tue, 10 Mar 2020 21:02:07 +0000 (UTC)
From:   NeilBrown <neilb@suse.de>
To:     Jeff Layton <jlayton@kernel.org>, yangerkun <yangerkun@huawei.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 11 Mar 2020 08:01:57 +1100
Cc:     kernel test robot <rong.a.chen@intel.com>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        Bruce Fields <bfields@fieldses.org>,
        Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: [locks] 6d390e4b5d: will-it-scale.per_process_ops -96.6% regression
In-Reply-To: <36c58a6d07b67aac751fca27a4938dc1759d9267.camel@kernel.org>
References: <20200308140314.GQ5972@shao2-debian> <e3783d060c778cb41b77380ad3e278133b52f57e.camel@kernel.org> <CAHk-=whGK712fPqmQ3FSHxqe3Aqny4bEeWEvfaytLeLV2+ijCQ@mail.gmail.com> <34355c4fe6c3968b1f619c60d5ff2ca11a313096.camel@kernel.org> <1bfba96b4bf0d3ca9a18a2bced3ef3a2a7b44dad.camel@kernel.org> <87blp5urwq.fsf@notabene.neil.brown.name> <41c83d34ae4c166f48e7969b2b71e43a0f69028d.camel@kernel.org> <ed73fb5d-ddd5-fefd-67ae-2d786e68544a@huawei.com> <923487db2c9396c79f8e8dd4f846b2b1762635c8.camel@kernel.org> <36c58a6d07b67aac751fca27a4938dc1759d9267.camel@kernel.org>
Message-ID: <878sk7vs8q.fsf@notabene.neil.brown.name>
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

On Tue, Mar 10 2020, Jeff Layton wrote:

> On Tue, 2020-03-10 at 08:52 -0400, Jeff Layton wrote:
>
> [snip]
>
>> On Tue, 2020-03-10 at 11:24 +0800, yangerkun wrote:
>> > >=20
>> > Something others. I think there is no need to call locks_delete_block=
=20
>> > for all case in function like flock_lock_inode_wait. What we should do=
=20
>> > as the patch '16306a61d3b7 ("fs/locks: always delete_block after=20
>> > waiting.")' describes is that we need call locks_delete_block not only=
=20
>> > for error equal to -ERESTARTSYS(please point out if I am wrong). And=20
>> > this patch may fix the regression too since simple lock that success o=
r=20
>> > unlock will not try to acquire blocked_lock_lock.
>> >=20
>> >=20
>>=20
>> Nice! This looks like it would work too, and it's a simpler fix.
>>=20
>> I'd be inclined to add a WARN_ON_ONCE(fl->fl_blocker) after the if
>> statements to make sure we never exit with one still queued. Also, I
>> think we can do a similar optimization in __break_lease.
>>=20
>> There are some other callers of locks_delete_block:
>>=20
>> cifs_posix_lock_set: already only calls it in these cases
>>=20
>> nlmsvc_unlink_block: I think we need to call this in most cases, and
>> they're not going to be high-performance codepaths in general
>>=20
>> nfsd4 callback handling: Several calls here, most need to always be
>> called. find_blocked_lock could be reworked to take the
>> blocked_lock_lock only once (I'll do that in a separate patch).
>>=20
>> How about something like this (
>>=20
>> ----------------------8<---------------------
>>=20
>> From: yangerkun <yangerkun@huawei.com>
>>=20
>> [PATCH] filelock: fix regression in unlock performance
>>=20
>> '6d390e4b5d48 ("locks: fix a potential use-after-free problem when
>> wakeup a waiter")' introduces a regression since we will acquire
>> blocked_lock_lock every time locks_delete_block is called.
>>=20
>> In many cases we can just avoid calling locks_delete_block at all,
>> when we know that the wait was awoken by the condition becoming true.
>> Change several callers of locks_delete_block to only call it when
>> waking up due to signal or other error condition.
>>=20
>> [ jlayton: add similar optimization to __break_lease, reword changelog,
>> 	   add WARN_ON_ONCE calls ]
>>=20
>> Fixes: 16306a61d3b7 ("fs/locks: always delete_block after waiting.")
>> Fixes: 6d390e4b5d48 ("locks: fix a potential use-after-free problem when=
 wakeup a waiter")
>> Signed-off-by: yangerkun <yangerkun@huawei.com>
>> Signed-off-by: Jeff Layton <jlayton@kernel.org>
>> ---
>>  fs/locks.c | 29 ++++++++++++++++++++++-------
>>  1 file changed, 22 insertions(+), 7 deletions(-)
>>=20
>> diff --git a/fs/locks.c b/fs/locks.c
>> index 426b55d333d5..b88a5b11c464 100644
>> --- a/fs/locks.c
>> +++ b/fs/locks.c
>> @@ -1354,7 +1354,10 @@ static int posix_lock_inode_wait(struct inode *in=
ode, struct file_lock *fl)
>>  		if (error)
>>  			break;
>>  	}
>> -	locks_delete_block(fl);
>> +	if (error)
>> +		locks_delete_block(fl);
>> +	WARN_ON_ONCE(fl->fl_blocker);
>> +
>>  	return error;
>>  }
>>=20=20
>> @@ -1447,7 +1450,9 @@ int locks_mandatory_area(struct inode *inode, stru=
ct file *filp, loff_t start,
>>=20=20
>>  		break;
>>  	}
>> -	locks_delete_block(&fl);
>> +	if (error)
>> +		locks_delete_block(&fl);
>> +	WARN_ON_ONCE(fl.fl_blocker);
>>=20=20
>>  	return error;
>>  }
>> @@ -1638,23 +1643,28 @@ int __break_lease(struct inode *inode, unsigned =
int mode, unsigned int type)
>>=20=20
>>  	locks_dispose_list(&dispose);
>>  	error =3D wait_event_interruptible_timeout(new_fl->fl_wait,
>> -						!new_fl->fl_blocker, break_time);
>> +						 !new_fl->fl_blocker,
>> +						 break_time);
>>=20=20
>>  	percpu_down_read(&file_rwsem);
>>  	spin_lock(&ctx->flc_lock);
>>  	trace_break_lease_unblock(inode, new_fl);
>> -	locks_delete_block(new_fl);
>>  	if (error >=3D 0) {
>>  		/*
>>  		 * Wait for the next conflicting lease that has not been
>>  		 * broken yet
>>  		 */
>> -		if (error =3D=3D 0)
>> +		if (error =3D=3D 0) {
>> +			locks_delete_block(new_fl);
>>  			time_out_leases(inode, &dispose);
>> +		}
>>  		if (any_leases_conflict(inode, new_fl))
>>  			goto restart;
>>  		error =3D 0;
>> +	} else {
>> +		locks_delete_block(new_fl);
>>  	}
>> +	WARN_ON_ONCE(fl->fl_blocker);
>>  out:
>>  	spin_unlock(&ctx->flc_lock);
>>  	percpu_up_read(&file_rwsem);
>> @@ -2126,7 +2136,10 @@ static int flock_lock_inode_wait(struct inode *in=
ode, struct file_lock *fl)
>>  		if (error)
>>  			break;
>>  	}
>> -	locks_delete_block(fl);
>> +	if (error)
>> +		locks_delete_block(fl);
>> +	WARN_ON_ONCE(fl->fl_blocker);
>> +
>>  	return error;
>>  }
>>=20=20
>> @@ -2403,7 +2416,9 @@ static int do_lock_file_wait(struct file *filp, un=
signed int cmd,
>>  		if (error)
>>  			break;
>>  	}
>> -	locks_delete_block(fl);
>> +	if (error)
>> +		locks_delete_block(fl);
>> +	WARN_ON_ONCE(fl->fl_blocker);
>>=20=20
>>  	return error;
>>  }
>
> I've gone ahead and added the above patch to linux-next. Linus, Neil,
> are you ok with this one? I think this is probably the simplest
> approach.

I think this patch contains an assumption which is not justified.  It
assumes that if a wait_event completes without error, then the wake_up()
must have happened.  I don't think that is correct.

In the patch that caused the recent regression, the race described
involved a signal arriving just as __locks_wake_up_blocks() was being
called on another thread.
So the waiting process was woken by a signal *after* ->fl_blocker was set
to NULL, and *before* the wake_up().  If wait_event_interruptible()
finds that the condition is true, it will report success whether there
was a signal or not.

If you skip the locks_delete_block() after a wait, you get exactly the
same race as the optimization - which only skipped most of
locks_delete_block().

I have a better solution.  I did like your patch except that it changed
too much code.  So I revised it to change less code.  See below.

NeilBrown

From: NeilBrown <neilb@suse.de>
Date: Wed, 11 Mar 2020 07:39:04 +1100
Subject: [PATCH] locks: restore locks_delete_lock optimization

A recent patch (see Fixes: below) removed an optimization which is
important as it avoids taking a lock in a common case.

The comment justifying the optimisation was correct as far as it went,
in that if the tests succeeded, then the values would remain stable and
the test result will remain valid even without a lock.

However after the test succeeds the lock can be freed while some other
thread might have only just set ->blocker to NULL (thus allowing the
test to succeed) but has not yet called wake_up() on the wq in the lock.
If the wake_up happens after the lock is freed, a use-after-free error
occurs.

This patch restores the optimization and reorders code to avoid the
use-after-free.  Specifically we move the list_del_init on
fl_blocked_member to *after* the wake_up(), and add an extra test on
fl_block_member() to locks_delete_lock() before deciding to avoid taking
the spinlock.

As this involves breaking code out of __locks_delete_block(), we discard
the function completely and open-code it in the two places it was
called.

These lockless accesses do not require any memory barriers.  The failure
mode from possible memory access reordering is that the test at the top
of locks_delete_lock() will fail, and in that case we fall through into
the locked region which provides sufficient memory barriers implicitly.

Fixes: 6d390e4b5d48 ("locks: fix a potential use-after-free problem when wa=
keup a waiter")
Signed-off-by: NeilBrown <neilb@suse.de>
=2D--
 fs/locks.c | 42 ++++++++++++++++++++++++++++--------------
 1 file changed, 28 insertions(+), 14 deletions(-)

diff --git a/fs/locks.c b/fs/locks.c
index 426b55d333d5..dc99ab2262ea 100644
=2D-- a/fs/locks.c
+++ b/fs/locks.c
@@ -716,18 +716,6 @@ static void locks_delete_global_blocked(struct file_lo=
ck *waiter)
 	hash_del(&waiter->fl_link);
 }
=20
=2D/* Remove waiter from blocker's block list.
=2D * When blocker ends up pointing to itself then the list is empty.
=2D *
=2D * Must be called with blocked_lock_lock held.
=2D */
=2Dstatic void __locks_delete_block(struct file_lock *waiter)
=2D{
=2D	locks_delete_global_blocked(waiter);
=2D	list_del_init(&waiter->fl_blocked_member);
=2D	waiter->fl_blocker =3D NULL;
=2D}
=2D
 static void __locks_wake_up_blocks(struct file_lock *blocker)
 {
 	while (!list_empty(&blocker->fl_blocked_requests)) {
@@ -735,11 +723,13 @@ static void __locks_wake_up_blocks(struct file_lock *=
blocker)
=20
 		waiter =3D list_first_entry(&blocker->fl_blocked_requests,
 					  struct file_lock, fl_blocked_member);
=2D		__locks_delete_block(waiter);
+		locks_delete_global_blocked(waiter);
+		waiter->fl_blocker =3D NULL;
 		if (waiter->fl_lmops && waiter->fl_lmops->lm_notify)
 			waiter->fl_lmops->lm_notify(waiter);
 		else
 			wake_up(&waiter->fl_wait);
+		list_del_init(&waiter->fl_blocked_member);
 	}
 }
=20
@@ -753,11 +743,35 @@ int locks_delete_block(struct file_lock *waiter)
 {
 	int status =3D -ENOENT;
=20
+	/*
+	 * If fl_blocker is NULL, it won't be set again as this thread
+	 * "owns" the lock and is the only one that might try to claim
+	 * the lock.  So it is safe to test fl_blocker locklessly.
+	 * Also if fl_blocker is NULL, this waiter is not listed on
+	 * fl_blocked_requests for some lock, so no other request can
+	 * be added to the list of fl_blocked_requests for this
+	 * request.  So if fl_blocker is NULL, it is safe to
+	 * locklessly check if fl_blocked_requests is empty.  If both
+	 * of these checks succeed, there is no need to take the lock.
+	 * We also check fl_blocked_member is empty.  This is logically
+	 * redundant with the test of fl_blocker, but it ensure that
+	 * __locks_wake_up_blocks() has finished the wakeup and will not
+	 * access the lock again, so it is safe to return and free.
+	 * There is no need for any memory barriers with these lockless
+	 * tests as is the reads happen before the corresponding writes are
+	 * seen, we fall through to the locked code.
+	 */
+	if (waiter->fl_blocker =3D=3D NULL &&
+	    list_empty(&waiter->fl_blocked_member) &&
+	    list_empty(&waiter->fl_blocked_requests))
+		return status;
 	spin_lock(&blocked_lock_lock);
 	if (waiter->fl_blocker)
 		status =3D 0;
 	__locks_wake_up_blocks(waiter);
=2D	__locks_delete_block(waiter);
+	locks_delete_global_blocked(waiter);
+	list_del_init(&waiter->fl_blocked_member);
+	waiter->fl_blocker =3D NULL;
 	spin_unlock(&blocked_lock_lock);
 	return status;
 }
=2D-=20
2.25.1


--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEG8Yp69OQ2HB7X0l6Oeye3VZigbkFAl5oAEUACgkQOeye3VZi
gblRFw//SReW82ew5522bZqYbizYmMKnFDB1dCiuW2Tb7ZnIIO21ITCvKEa28iai
6q7zbq/hy4SpZQnTDRakucvTja6BfqCKpg1k5FEsMkdLqpklr2Pllqw8vt02Knln
G9odp5I/VbPUGR0LDjMmPiwUUjg0XqoeQ4Wh6vdov83XticTOAWwKXjCT63gPqqE
77NDCnxCXD2A5NjG+ZOOorG0HzqLlKSHtOZIOdT6SXpR4iNez5mut36xk6kFGnJD
zRmuDQgAbKbKEBzP2LstOHX7ZoZlZT7ko5++XWpUWdQkH76LEl+g45KV7YZNc4Z+
fW4viuxCgMgPksyp/C99y9OP7c3mMlJujvCqWfdit2w64wpDxg5Vu3V2iFohfYb2
+IVGrhyqN27eDVLRXzIu8/CjsBkfjh3fM2d62C1IIdEoSU1FKy7gh1iAvIZf48fD
FRnlXdLoJXLQ8sAa8HlaOyEj41t/8Cdez+cL+Jqz8jv8bmsXqX0fp2Xxh5l3NNnf
xjRbOwPFUEaiO45e/jtdzz3FLubpbUHSgzRhJhkY3TgisCD7zDmhgBb1Q94jaeHK
lkYcBMVcx7g4WzzZ+1h0xibNPdhOfzGVBimiPfe8ZroQZjA39lmPgMNQYA7BrHYh
QgxnbqA6iRbLg6r0ZcBmaViC9Z4/smNtY9qKpd9Jny17kuyX7pk=
=OIIH
-----END PGP SIGNATURE-----
--=-=-=--
