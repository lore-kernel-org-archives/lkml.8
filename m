Return-Path: <SRS0=4VRK=47=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB45EC10DCE
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Mar 2020 02:31:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 793782074B
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Mar 2020 02:31:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726628AbgCNCbQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Mar 2020 22:31:16 -0400
Received: from mx2.suse.de ([195.135.220.15]:34424 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726414AbgCNCbQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Mar 2020 22:31:16 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id F36DFAFE0;
        Sat, 14 Mar 2020 02:31:11 +0000 (UTC)
From:   NeilBrown <neilb@suse.de>
To:     Jeff Layton <jlayton@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 14 Mar 2020 13:31:03 +1100
Cc:     yangerkun <yangerkun@huawei.com>,
        kernel test robot <rong.a.chen@intel.com>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        Bruce Fields <bfields@fieldses.org>,
        Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: [locks] 6d390e4b5d: will-it-scale.per_process_ops -96.6% regression
In-Reply-To: <f000e352d9e103b3ade3506aac225920420d2323.camel@kernel.org>
References: <20200308140314.GQ5972@shao2-debian>
 <e3783d060c778cb41b77380ad3e278133b52f57e.camel@kernel.org>
 <CAHk-=whGK712fPqmQ3FSHxqe3Aqny4bEeWEvfaytLeLV2+ijCQ@mail.gmail.com>
 <34355c4fe6c3968b1f619c60d5ff2ca11a313096.camel@kernel.org>
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
Message-ID: <877dznu0pk.fsf@notabene.neil.brown.name>
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

On Fri, Mar 13 2020, Jeff Layton wrote:

> On Thu, 2020-03-12 at 09:07 -0700, Linus Torvalds wrote:
>> On Wed, Mar 11, 2020 at 9:42 PM NeilBrown <neilb@suse.de> wrote:
>> > It seems that test_and_set_bit_lock() is the preferred way to handle
>> > flags when memory ordering is important
>>=20
>> That looks better.
>>=20
>> The _preferred_ way is actually the one I already posted: do a
>> "smp_store_release()" to store the flag (like a NULL pointer), and a
>> smp_load_acquire() to load it.
>>=20
>> That's basically optimal on most architectures (all modern ones -
>> there are bad architectures from before people figured out that
>> release/acquire is better than separate memory barriers), not needing
>> any atomics and only minimal memory ordering.
>>=20
>> I wonder if a special flags value (keeping it "unsigned int" to avoid
>> the issue Jeff pointed out) might be acceptable?
>>=20
>> IOW, could we do just
>>=20
>>         smp_store_release(&waiter->fl_flags, FL_RELEASED);
>>=20
>> to say that we're done with the lock? Or do people still look at and
>> depend on the flag values at that point?
>
> I think nlmsvc_grant_block does. We could probably work around it
> there, but we'd need to couple this change with some clear
> documentation to make it clear that you can't rely on fl_flags after
> locks_delete_block returns.
>
> If avoiding new locks is preferred here (and I'm fine with that), then
> maybe we should just go with the patch you sent originally (along with
> changing the waiters to wait on fl_blocked_member going empty instead
> of the fl_blocker going NULL)?

I agree.  I've poked at this for a while and come to the conclusion that
I cannot really come up with anything that is structurally better than
your patch.
The idea of list_del_init_release() and list_empty_acquire() is growing
on me though.  See below.

list_empty_acquire() might be appropriate for waitqueue_active(), which
is documented as requiring a memory barrier, but in practice seems to
often be used without one.

But I'm happy for you to go with your patch that changes all the wait
calls.

NeilBrown



diff --git a/fs/locks.c b/fs/locks.c
index 426b55d333d5..2e5eb677c324 100644
=2D-- a/fs/locks.c
+++ b/fs/locks.c
@@ -174,6 +174,20 @@
=20
 #include <linux/uaccess.h>
=20
+/* Should go in list.h */
+static inline int list_empty_acquire(const struct list_head *head)
+{
+	return smp_load_acquire(&head->next) =3D=3D head;
+}
+
+static inline void list_del_init_release(struct list_head *entry)
+{
+	__list_del_entry(entry);
+	entry->prev =3D entry;
+	smp_store_release(&entry->next, entry);
+}
+
+
 #define IS_POSIX(fl)	(fl->fl_flags & FL_POSIX)
 #define IS_FLOCK(fl)	(fl->fl_flags & FL_FLOCK)
 #define IS_LEASE(fl)	(fl->fl_flags & (FL_LEASE|FL_DELEG|FL_LAYOUT))
@@ -724,7 +738,6 @@ static void locks_delete_global_blocked(struct file_loc=
k *waiter)
 static void __locks_delete_block(struct file_lock *waiter)
 {
 	locks_delete_global_blocked(waiter);
=2D	list_del_init(&waiter->fl_blocked_member);
 	waiter->fl_blocker =3D NULL;
 }
=20
@@ -740,6 +753,11 @@ static void __locks_wake_up_blocks(struct file_lock *b=
locker)
 			waiter->fl_lmops->lm_notify(waiter);
 		else
 			wake_up(&waiter->fl_wait);
+		/*
+		 * Tell the world that we're done with it - see comment at
+		 * top of locks_delete_block().
+		 */
+		list_del_init_release(&waiter->fl_blocked_member);
 	}
 }
=20
@@ -753,6 +771,25 @@ int locks_delete_block(struct file_lock *waiter)
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
+	 * However, some other thread could still be in__locks_wake_up_blocks()
+	 * and may yet access 'waiter', so we cannot return and possibly
+	 * free the 'waiter' unless we check that __locks_wake_up_blocks()
+	 * is done.  For that we carefully test fl_blocked_member.
+	 */
+	if (waiter->fl_blocker =3D=3D NULL &&
+	    list_empty(&waiter->fl_blocked_requests) &&
+	    list_empty_acquire(&waiter->fl_blocked_member))
+		return status;
 	spin_lock(&blocked_lock_lock);
 	if (waiter->fl_blocker)
 		status =3D 0;

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEG8Yp69OQ2HB7X0l6Oeye3VZigbkFAl5sQegACgkQOeye3VZi
gbluQRAAps4nkshRrtzTBc/v8ODs6HYzjGtx1s7pOs5rLUopMQGSptHO4V0+zjNg
k+qFRxvgRSWW8DJvUbGDCcFDV/WLBIOHtUBkHcpMqXSqzxG29exotvEBuc07SfbC
BFsAbvLB6pZLutYK6flTrzdMyAO5Wm06QYmLMTtVJQnMvPsaaQqVozFB2KVZ+LgC
eEEx/TDtqhy6PaGln05nP3PC8GhbD+wMzNJ+tLorij03cFEfS+IffVOoM0Q9oq/H
Pdxp7lZOPv5ehcLo0lSgTkPSdTkWGq3QFZGnwNFAruube+9O/aZ4LeaMroyJnB4G
ti90+fSkwur3RpbZvdMK96PwSTy32b9tY5aOiQe7tFav3YIvwlE6fzdaudOC2hNI
2BNor28ITovR8uCB4lUb8i8qAXx6JE988NnZ2j2LQGZeGU+EL2Ca4klUokqjwN6m
/xCLj0rn8LNsZgWnv8Qusgfd1i4+CyPZ8+CcodzdM2npeYp3jgmjvdKh29F6MkJP
FG9q0gIcfeb5id3lAUI4MWSb3r+sZmmQvqD19rIDQuCiqbIo1NTm7wlmMrYCkgH/
1J87in7/fgop/NADnFrtHyVF9Thi9tU4WOttL1r1ldjLGcilqURxI18jf82+LYbC
yugocrnF0Xw3+tfZycJSAJ2JhZkNeOEp7MUoRcdcJXcfksIx6wo=
=4Ppj
-----END PGP SIGNATURE-----
--=-=-=--
