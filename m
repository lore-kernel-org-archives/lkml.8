Return-Path: <SRS0=Ktsx=44=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11FC5C2BAEE
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 22:22:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0ADB520750
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 22:22:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729999AbgCKWWi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Mar 2020 18:22:38 -0400
Received: from mx2.suse.de ([195.135.220.15]:58788 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729506AbgCKWWi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 18:22:38 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 871E5B120;
        Wed, 11 Mar 2020 22:22:34 +0000 (UTC)
From:   NeilBrown <neilb@suse.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Jeff Layton <jlayton@kernel.org>
Date:   Thu, 12 Mar 2020 09:22:26 +1100
Cc:     yangerkun <yangerkun@huawei.com>,
        kernel test robot <rong.a.chen@intel.com>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        Bruce Fields <bfields@fieldses.org>,
        Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: [locks] 6d390e4b5d: will-it-scale.per_process_ops -96.6% regression
In-Reply-To: <CAHk-=whUgeZGcs5YAfZa07BYKNDCNO=xr4wT6JLATJTpX0bjGg@mail.gmail.com>
References: <20200308140314.GQ5972@shao2-debian> <e3783d060c778cb41b77380ad3e278133b52f57e.camel@kernel.org> <CAHk-=whGK712fPqmQ3FSHxqe3Aqny4bEeWEvfaytLeLV2+ijCQ@mail.gmail.com> <34355c4fe6c3968b1f619c60d5ff2ca11a313096.camel@kernel.org> <1bfba96b4bf0d3ca9a18a2bced3ef3a2a7b44dad.camel@kernel.org> <87blp5urwq.fsf@notabene.neil.brown.name> <41c83d34ae4c166f48e7969b2b71e43a0f69028d.camel@kernel.org> <ed73fb5d-ddd5-fefd-67ae-2d786e68544a@huawei.com> <923487db2c9396c79f8e8dd4f846b2b1762635c8.camel@kernel.org> <36c58a6d07b67aac751fca27a4938dc1759d9267.camel@kernel.org> <878sk7vs8q.fsf@notabene.neil.brown.name> <c4ef31a663fbf7a3de349696e9f00f2f5c4ec89a.camel@kernel.org> <875zfbvrbm.fsf@notabene.neil.brown.name> <CAHk-=wg8N4fDRC3M21QJokoU+TQrdnv7HqoaFW-Z-ZT8z_Bi7Q@mail.gmail.com> <0066a9f150a55c13fcc750f6e657deae4ebdef97.camel@kernel.org> <CAHk-=whUgeZGcs5YAfZa07BYKNDCNO=xr4wT6JLATJTpX0bjGg@mail.gmail.com>
Message-ID: <87v9nattul.fsf@notabene.neil.brown.name>
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

On Tue, Mar 10 2020, Linus Torvalds wrote:

> On Tue, Mar 10, 2020 at 3:07 PM Jeff Layton <jlayton@kernel.org> wrote:
>>
>> Given that, and the fact that Neil pointed out that yangerkun's latest
>> patch would reintroduce the original race, I'm leaning back toward the
>> patch Neil sent yesterday. It relies solely on spinlocks, and so doesn't
>> have the subtle memory-ordering requirements of the others.
>
> It has subtle locking changes, though.
>
> It now calls the "->lm_notify()" callback with the wait queue spinlock he=
ld.
>
> is that ok? It's not obvious. Those functions take other spinlocks,
> and wake up other things. See for example nlmsvc_notify_blocked()..
> Yes, it was called under the blocked_lock_lock spinlock before too,
> but now there's an _additional_ spinlock, and it must not call
> "wake_up(&waiter->fl_wait))" in the callback, for example, because it
> already holds the lock on that wait queue.
>
> Maybe that is never done. I don't know the callbacks.
>
> I was really hoping that the simple memory ordering of using that
> smp_store_release -> smp_load_acquire using fl_blocker would be
> sufficient. That's a particularly simple and efficient ordering.
>
> Oh well. If you want to go that spinlock way, it needs to document why
> it's safe to do a callback under it.
>
>                   Linus

I've learn recently to dislike calling callbacks while holding a lock.
I don't think the current callbacks care, but the requirement imposes a
burden on future callbacks too.

We can combine the two ideas - move the list_del_init() later, and still
protect it with the wq locks.  This avoids holding the lock across the
callback, but provides clear atomicity guarantees.

NeilBrown

From: NeilBrown <neilb@suse.de>
Subject: [PATCH] Subject: [PATCH] locks: restore locks_delete_lock
 optimization

A recent patch (see Fixes: below) removed an optimization which is
important as it avoids taking a lock in a common case.

The comment justifying the optimisation was correct as far as it went,
in that if the tests succeeded, then the values would remain stable and
the test result will remain valid even without a lock.

However after the test succeeds the lock can be freed while some other
thread might have only just set ->blocker to NULL (thus allowing the
test to succeed) but has not yet called wake_up() on the wq in the lock.
If the wake_up happens after the lock is freed, a use-after-free error occu=
rs.

This patch restores the optimization and reorders code to avoid the
use-after-free.  Specifically we move the list_del_init on
fl_blocked_member to *after* the wake_up(), and add an extra test on
fl_block_member() to locks_delete_lock() before deciding to avoid taking
the spinlock.

To ensure correct ordering for the list_empty() test and the
list_del_init() call, we protect them both with the wq spinlock.  This
provides required atomicity, while scaling much better than taking the
global blocked_lock_lock.

Fixes: 6d390e4b5d48 ("locks: fix a potential use-after-free problem when wa=
keup a waiter")
Signed-off-by: NeilBrown <neilb@suse.de>
=2D--
 fs/locks.c | 46 ++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 38 insertions(+), 8 deletions(-)

diff --git a/fs/locks.c b/fs/locks.c
index 426b55d333d5..16098a209d63 100644
=2D-- a/fs/locks.c
+++ b/fs/locks.c
@@ -721,11 +721,19 @@ static void locks_delete_global_blocked(struct file_l=
ock *waiter)
  *
  * Must be called with blocked_lock_lock held.
  */
=2Dstatic void __locks_delete_block(struct file_lock *waiter)
+static void __locks_delete_block(struct file_lock *waiter, bool notify)
 {
 	locks_delete_global_blocked(waiter);
=2D	list_del_init(&waiter->fl_blocked_member);
 	waiter->fl_blocker =3D NULL;
+	if (notify) {
+		if (waiter->fl_lmops && waiter->fl_lmops->lm_notify)
+			waiter->fl_lmops->lm_notify(waiter);
+		else
+			wake_up(&waiter->fl_wait);
+	}
+	spin_lock(&waiter->fl_wait.lock);
+	list_del_init(&waiter->fl_blocked_member);
+	spin_unlock(&waiter->fl_wait.lock);
 }
=20
 static void __locks_wake_up_blocks(struct file_lock *blocker)
@@ -735,11 +743,7 @@ static void __locks_wake_up_blocks(struct file_lock *b=
locker)
=20
 		waiter =3D list_first_entry(&blocker->fl_blocked_requests,
 					  struct file_lock, fl_blocked_member);
=2D		__locks_delete_block(waiter);
=2D		if (waiter->fl_lmops && waiter->fl_lmops->lm_notify)
=2D			waiter->fl_lmops->lm_notify(waiter);
=2D		else
=2D			wake_up(&waiter->fl_wait);
+		__locks_delete_block(waiter, true);
 	}
 }
=20
@@ -753,11 +757,37 @@ int locks_delete_block(struct file_lock *waiter)
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
+	 * We also check fl_blocked_member is empty un the fl_wait.lock.
+	 * If this fails, __locks_delete_block() must still be notifying
+	 * waiters, so it isn't yet safe to return and free the file_lock.
+	 * Doing this under fl_wait.lock allows significantly better scaling
+	 * than unconditionally taking blocks_lock_lock.
+	 */
+	if (waiter->fl_blocker =3D=3D NULL &&
+	    list_empty(&waiter->fl_blocked_requests)) {
+		spin_lock(&waiter->fl_wait.lock);
+		if (list_empty(&waiter->fl_blocked_member)) {
+			spin_unlock(&waiter->fl_wait.lock);
+			return status;
+		}
+		/* Notification is still happening */
+		spin_unlock(&waiter->fl_wait.lock);
+	}
 	spin_lock(&blocked_lock_lock);
 	if (waiter->fl_blocker)
 		status =3D 0;
 	__locks_wake_up_blocks(waiter);
=2D	__locks_delete_block(waiter);
+	__locks_delete_block(waiter, false);
 	spin_unlock(&blocked_lock_lock);
 	return status;
 }
=2D-=20
2.25.1


--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEG8Yp69OQ2HB7X0l6Oeye3VZigbkFAl5pZKIACgkQOeye3VZi
gblaRQ//Zv/qB6qeBxOzj+SUU1zKJYz61dPDpVVmXD9KiV6Yr6udcKEZ1G01os6b
zqUyd6VBIe+bqx+moaEKwMvjY7ksvZbLfyW3uGvJ2hMrlgis4ZWUWVu3e0O89uX2
/YWNABeXVYWZwoafPmy6Zz4cWsD5Ku0/GkpQP6lxLufsEb1AijOGjsBWGg01vqV1
zj1fvzNKckzRGHCS0aaA3dJ2rh0TnPJwXvkUNbOECsjNfvSWAuJFt/e1IWGH3vJJ
ELuNnrioDCh/leuS5KOoZp0BJGBf7a8nRkkJUMKcrHvDZUy82UilDSBNvsv3s9N5
OVxQ8/beN9k1qaLvJzFYPKUxyHqaubavEUS5ouh4SL+kZC4FQvanGMuSbUU2vv5c
c3Ajz0Ca8vXPWAyAEBu2G64nyBKcc7NhHj9lLsZfBDAJN/+BM3ejL/vGJiIKWs1U
SxtVVQKjjet/lWogC6zI/811MuUbiAfiK1mn7rgHxPDjpDkKIPf3FNqZISpfxyEU
WmTLF0LVvQNWm/+W2arnNby9cwyL1fBl+4kcvjCEZepo8rhN9Snje0QlDEVmCAbr
mNkUY81M2MEnHMW3eC3qkFVkhN1uLI4IMNjpsgtkKLwueF8zZcd/P5TyNm2ushNz
Vjs3N16EsYMuWdKM2AA1zRYx/URdpSAG9/Kx4646j6nHXjsDGfs=
=4AgQ
-----END PGP SIGNATURE-----
--=-=-=--
