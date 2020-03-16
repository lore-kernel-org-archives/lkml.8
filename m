Return-Path: <SRS0=ltrd=5B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12C2BC0044D
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 22:45:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E25FF205ED
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 22:45:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732868AbgCPWpr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Mar 2020 18:45:47 -0400
Received: from mx2.suse.de ([195.135.220.15]:47768 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732837AbgCPWpr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Mar 2020 18:45:47 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 3EE80ABBE;
        Mon, 16 Mar 2020 22:45:45 +0000 (UTC)
From:   NeilBrown <neilb@suse.de>
To:     Jeff Layton <jlayton@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 17 Mar 2020 09:45:37 +1100
Cc:     yangerkun <yangerkun@huawei.com>,
        kernel test robot <rong.a.chen@intel.com>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        Bruce Fields <bfields@fieldses.org>,
        Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: [locks] 6d390e4b5d: will-it-scale.per_process_ops -96.6% regression
In-Reply-To: <ce48ed9e48eda3c0f27d2f417314bd00cb1a68db.camel@kernel.org>
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
Message-ID: <87k13jsyum.fsf@notabene.neil.brown.name>
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

On Mon, Mar 16 2020, Jeff Layton wrote:

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
> @@ -753,11 +758,30 @@ int locks_delete_block(struct file_lock *waiter)
>  {
>  	int status =3D -ENOENT;
>=20=20
> +	/*
> +	 * If fl_blocker is NULL, it won't be set again as this thread "owns"
> +	 * the lock and is the only one that might try to claim the lock.
> +	 * Because fl_blocker is explicitly set last during a delete, it's
> +	 * safe to locklessly test to see if it's NULL. If it is, then we know
> +	 * that no new locks can be inserted into its fl_blocked_requests list,
> +	 * and we can therefore avoid doing anything further as long as that
> +	 * list is empty.

I think it would be worth spelling out what the 'acquire' is needed
for.  We seem to have a general policy of requiring comment to explain
the presence of barriers.

  The 'acquire' on fl_blocker guarantees two things.
  1/ that fl_blocked_requests can be tested locklessly. If something was
     recently added to that list it must have been in a locked region
     *before* the locked region when fl_blocker was set to NULL.
  2/ that no other thread is accessing 'waiter', so it is safe to free it.
      __locks_wake_up_blocks is careful not to touch waiter after
      fl_blocker is released.=20=20
=20=20

> +	 */
> +	if (!smp_load_acquire(&waiter->fl_blocker) &&
> +	    list_empty(&waiter->fl_blocked_requests))
> +		return status;
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

This comment might be misleading.  The world doesn't care.
Only this thread cares where ->fl_blocker is NULL.  We need the release
semantics when some *other* thread sets fl_blocker to NULL, not when
this thread does.
I don't think we need to spell that out and I'm not against using
store_release here, but locks_delete_block cannot race with itself, so
referring to the comment at the top of this function is misleading.

So:
  Reviewed-by: NeilBrown <neilb@suse.de>

but I'm not totally happy with the comments.

Thanks,
NeilBrown


> +	 */
> +	smp_store_release(&waiter->fl_blocker, NULL);
>  	spin_unlock(&blocked_lock_lock);
>  	return status;
>  }

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEG8Yp69OQ2HB7X0l6Oeye3VZigbkFAl5wAZEACgkQOeye3VZi
gbkp1hAAvcReTfAMi662+qaArjpYDm+EphVfKwaUj2/HDfd5H9uZYVuAcg35JN1s
7sWlQXHxQvijoF5Eo5mu3v6pqu63EdxWK2i1bcOZQ8VcGpmY0DF+448idlYdLQ2C
dIp9PrhiFdcutLg9DtV84mH6rjWqhE9whiW7StmUWcgGs1ow5flloLefIVNfzz1n
ndoZJuLhim93l1fQD2CWDZih5Trr6r/gtmUQUqHjqfGMH92gZbIdm2VZWDBeD2QS
Rcyyi5GOWL/4zFjz5iLGHgVAo6nk7SkJTy0c2GdsnSse1ZZ1U5DKfFiah5eYvrcy
hrCkosQcKzsbKUrYO3PqtUzi6R74iZSqIZHvqbOW3YCqlcBKfsc7bzP17mv5I7Xq
T3z9mtPYx8REv89e+LGUzuXokXt5MVmP1bfPM513x7QTptNWIDj0JH7+SMpWeiYR
ZrHWmNK4sRoA3wG858KbVmQl/DLXtvCrnIFHqo43AXAPjiEHxM3YBGstf7PyorlZ
6qfK6vlgw82YAhWXnh5i/fg3Mtw5WEPEi7AUJ44btmhgw1XbzfoJQUEnVPssmjyZ
9nKdygR9GWsPFvAQJBr3pdpkPl/1TL8olJLj4EDBkL0lpnqNLZegfvG9d1V0Icjs
zHeUOFo97uGmJgkSHEfGK8e7IMQQaq7zbVoOZJWv74Sw6MsP7lo=
=M9Ll
-----END PGP SIGNATURE-----
--=-=-=--
