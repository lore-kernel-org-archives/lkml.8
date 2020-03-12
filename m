Return-Path: <SRS0=+FT0=45=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CCF7C10DCE
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 04:42:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 396D120739
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 04:42:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731638AbgCLEmU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Mar 2020 00:42:20 -0400
Received: from mx2.suse.de ([195.135.220.15]:39050 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726534AbgCLEmT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Mar 2020 00:42:19 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 1AE41B2D4;
        Thu, 12 Mar 2020 04:42:17 +0000 (UTC)
From:   NeilBrown <neilb@suse.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 12 Mar 2020 15:42:07 +1100
Cc:     Jeff Layton <jlayton@kernel.org>, yangerkun <yangerkun@huawei.com>,
        kernel test robot <rong.a.chen@intel.com>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        Bruce Fields <bfields@fieldses.org>,
        Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: [locks] 6d390e4b5d: will-it-scale.per_process_ops -96.6% regression
In-Reply-To: <CAHk-=wiNoAk8v3GrbK3=q6KRBrhLrTafTmWmAo6-up6Ce9fp6A@mail.gmail.com>
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
Message-ID: <87o8t2tc9s.fsf@notabene.neil.brown.name>
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

On Wed, Mar 11 2020, Linus Torvalds wrote:

> On Wed, Mar 11, 2020 at 3:22 PM NeilBrown <neilb@suse.de> wrote:
>>
>> We can combine the two ideas - move the list_del_init() later, and still
>> protect it with the wq locks.  This avoids holding the lock across the
>> callback, but provides clear atomicity guarantees.
>
> Ugfh. Honestly, this is disgusting.
>
> Now you re-take the same lock in immediate succession for the
> non-callback case.  It's just hidden.
>
> And it's not like the list_del_init() _needs_ the lock (it's not
> currently called with the lock held).
>
> So that "hold the lock over list_del_init()" seems to be horrendously
> bogus. It's only done as a serialization thing for that optimistic
> case.
>
> And that optimistic case doesn't even *want* that kind of
> serialization. It really just wants a "I'm done" flag.
>
> So no. Don't do this. It's mis-using the lock in several ways.
>
>              Linus

It seems that test_and_set_bit_lock() is the preferred way to handle
flags when memory ordering is important, and I can't see how to use that
well with an "I'm done" flag.  I can make it look OK with a "I'm
detaching" flag.  Maybe this is better.

NeilBrown

From=20f46db25f328ddf37ca9fbd390c6eb5f50c4bd2e6 Mon Sep 17 00:00:00 2001
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
If the wake_up happens after the lock is freed, a use-after-free error occu=
rs.

This patch restores the optimization and adds a flag to ensure this
use-after-free is avoid.  The use happens only when the flag is set, and
the free doesn't happen until the flag has been cleared, or we have
taken blocked_lock_lock.

Fixes: 6d390e4b5d48 ("locks: fix a potential use-after-free problem when wa=
keup a waiter")
Signed-off-by: NeilBrown <neilb@suse.de>
=2D--
 fs/locks.c         | 44 ++++++++++++++++++++++++++++++++++++++------
 include/linux/fs.h |  3 ++-
 2 files changed, 40 insertions(+), 7 deletions(-)

diff --git a/fs/locks.c b/fs/locks.c
index 426b55d333d5..334473004c6c 100644
=2D-- a/fs/locks.c
+++ b/fs/locks.c
@@ -283,7 +283,7 @@ locks_dump_ctx_list(struct list_head *list, char *list_=
type)
 	struct file_lock *fl;
=20
 	list_for_each_entry(fl, list, fl_list) {
=2D		pr_warn("%s: fl_owner=3D%p fl_flags=3D0x%x fl_type=3D0x%x fl_pid=3D%u\=
n", list_type, fl->fl_owner, fl->fl_flags, fl->fl_type, fl->fl_pid);
+		pr_warn("%s: fl_owner=3D%p fl_flags=3D0x%lx fl_type=3D0x%x fl_pid=3D%u\n=
", list_type, fl->fl_owner, fl->fl_flags, fl->fl_type, fl->fl_pid);
 	}
 }
=20
@@ -314,7 +314,7 @@ locks_check_ctx_file_list(struct file *filp, struct lis=
t_head *list,
 	list_for_each_entry(fl, list, fl_list)
 		if (fl->fl_file =3D=3D filp)
 			pr_warn("Leaked %s lock on dev=3D0x%x:0x%x ino=3D0x%lx "
=2D				" fl_owner=3D%p fl_flags=3D0x%x fl_type=3D0x%x fl_pid=3D%u\n",
+				" fl_owner=3D%p fl_flags=3D0x%lx fl_type=3D0x%x fl_pid=3D%u\n",
 				list_type, MAJOR(inode->i_sb->s_dev),
 				MINOR(inode->i_sb->s_dev), inode->i_ino,
 				fl->fl_owner, fl->fl_flags, fl->fl_type, fl->fl_pid);
@@ -736,10 +736,13 @@ static void __locks_wake_up_blocks(struct file_lock *=
blocker)
 		waiter =3D list_first_entry(&blocker->fl_blocked_requests,
 					  struct file_lock, fl_blocked_member);
 		__locks_delete_block(waiter);
=2D		if (waiter->fl_lmops && waiter->fl_lmops->lm_notify)
=2D			waiter->fl_lmops->lm_notify(waiter);
=2D		else
=2D			wake_up(&waiter->fl_wait);
+		if (!test_and_set_bit_lock(FL_DELETING, &waiter->fl_flags)) {
+			if (waiter->fl_lmops && waiter->fl_lmops->lm_notify)
+				waiter->fl_lmops->lm_notify(waiter);
+			else
+				wake_up(&waiter->fl_wait);
+			clear_bit_unlock(FL_DELETING, &waiter->fl_flags);
+		}
 	}
 }
=20
@@ -753,11 +756,40 @@ int locks_delete_block(struct file_lock *waiter)
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
+	 *
+	 * We perform these checks only if we can set FL_DELETING.
+	 * This ensure that we don't race with __locks_wake_up_blocks()
+	 * in a way which leads it to call wake_up() *after* we return
+	 * and the file_lock is freed.
+	 */
+	if (!test_and_set_bit_lock(FL_DELETING, &waiter->fl_flags)) {
+		if (waiter->fl_blocker =3D=3D NULL &&
+		    list_empty(&waiter->fl_blocked_requests)) {
+			/* Already fully unlinked */
+			clear_bit_unlock(FL_DELETING, &waiter->fl_flags);
+			return status;
+		}
+	}
+
 	spin_lock(&blocked_lock_lock);
 	if (waiter->fl_blocker)
 		status =3D 0;
 	__locks_wake_up_blocks(waiter);
 	__locks_delete_block(waiter);
+	/* This flag might not be set and it is largely irrelevant
+	 * now, but it seem cleaner to clear it.
+	 */
+	clear_bit(FL_DELETING, &waiter->fl_flags);
 	spin_unlock(&blocked_lock_lock);
 	return status;
 }
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 3cd4fe6b845e..4db514f29bca 100644
=2D-- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -1012,6 +1012,7 @@ static inline struct file *get_file(struct file *f)
 #define FL_UNLOCK_PENDING	512 /* Lease is being broken */
 #define FL_OFDLCK	1024	/* lock is "owned" by struct file */
 #define FL_LAYOUT	2048	/* outstanding pNFS layout */
+#define FL_DELETING	32768	/* lock is being disconnected */
=20
 #define FL_CLOSE_POSIX (FL_POSIX | FL_CLOSE)
=20
@@ -1087,7 +1088,7 @@ struct file_lock {
 						 * ->fl_blocker->fl_blocked_requests
 						 */
 	fl_owner_t fl_owner;
=2D	unsigned int fl_flags;
+	unsigned long fl_flags;
 	unsigned char fl_type;
 	unsigned int fl_pid;
 	int fl_link_cpu;		/* what cpu's list is this on? */
=2D-=20
2.25.1


--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEG8Yp69OQ2HB7X0l6Oeye3VZigbkFAl5pvZ8ACgkQOeye3VZi
gbnSNBAAnDXJDaJafu3HVOVtVc6B1utMkFfRbQ7JpIFYiWSXb8N8EKdcSzVPmOFb
Qta2n1K7wDe+Q3fn3XvAHMu7XTTqrfyjdOsADWiv6Dr4s+OTH015J4x46pGrt5SL
vP2daAEJ65ku1X1gDfaQInBzD9Fu0EEZ2452G6CEJsg9YXMSfLK8HZqUI9tAOGGN
LrMcTGYDv7RFjA0DFV4vt4UpK3+Lt180tLkLPNRFZY/9ZPlG72pba4YI+CBXQvnK
ssl71YVdw/U8lFdfxgd7/AFdP6iH9cQX4XtstQoFRWxoy9MaMC1Q58BXisPDXF9v
M25fXFVDmQpGbNQwcx8/SbJrMK49PAKg/Zg4GitL99p/A9AviOHhqu4y5f2mmGg1
/8eFMtz3UudSMWuSQeRZdTn+lP7FtGIT/M3oX/4foULubVYhb+VMvVemfaBQgivh
kfcktyyJCCpymRN9jeU0f+JSkGhFfAyjlQNh1zxhBaueAZFzl6uurYcYads8g3yT
iwFqHPcPYvmFYVA/k5vTwHR9l9UW5m1d5fzA7wIJLEg+krz5ql7eoeQZ9Jhl3paU
kebfBZ/6wk/45VU5eQisk8IXoUSiobWljP94eL177akcbcKVSzkRdP5XoefCkVaB
5A3CLN+cJbKhXzMXld9ZZFyGNl7QoLdhpCEyBnn6eeawWdjNPmk=
=wOQC
-----END PGP SIGNATURE-----
--=-=-=--
