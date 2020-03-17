Return-Path: <SRS0=kRID=5C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D480C1975A
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 21:27:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE49020738
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 21:27:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726839AbgCQV1w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Mar 2020 17:27:52 -0400
Received: from mx2.suse.de ([195.135.220.15]:54610 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726388AbgCQV1w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Mar 2020 17:27:52 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id BDAFFABDC;
        Tue, 17 Mar 2020 21:27:48 +0000 (UTC)
From:   NeilBrown <neilb@suse.de>
To:     Jeff Layton <jlayton@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 18 Mar 2020 08:27:40 +1100
Cc:     yangerkun <yangerkun@huawei.com>,
        kernel test robot <rong.a.chen@intel.com>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        Bruce Fields <bfields@fieldses.org>,
        Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: [locks] 6d390e4b5d: will-it-scale.per_process_ops -96.6% regression
In-Reply-To: <46d2c16f48f1fd4ad28a85099c59ae95a9997740.camel@kernel.org>
References: <20200308140314.GQ5972@shao2-debian>
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
 <46d2c16f48f1fd4ad28a85099c59ae95a9997740.camel@kernel.org>
Message-ID: <878sjysmcz.fsf@notabene.neil.brown.name>
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

On Tue, Mar 17 2020, Jeff Layton wrote:

> On Tue, 2020-03-17 at 09:45 +1100, NeilBrown wrote:
>> > +
>> > +	/*
>> > +	 * Tell the world we're done with it - see comment at top
>> > +	 * of this function
>>=20
>> This comment might be misleading.  The world doesn't care.
>> Only this thread cares where ->fl_blocker is NULL.  We need the release
>> semantics when some *other* thread sets fl_blocker to NULL, not when
>> this thread does.
>> I don't think we need to spell that out and I'm not against using
>> store_release here, but locks_delete_block cannot race with itself, so
>> referring to the comment at the top of this function is misleading.
>>=20
>> So:
>>   Reviewed-by: NeilBrown <neilb@suse.de>
>>=20
>> but I'm not totally happy with the comments.
>>=20
>>=20
>
> Thanks Neil. We can clean up the comments before merge. How about this
> revision to the earlier patch? I took the liberty of poaching your your
> proposed verbiage:

Thanks.  I'm happy with that.

(Well.... actually I hate the use of the word "official" unless there is
a well defined office holder being blamed.  But the word has come to
mean something vaguer in common usage and there is probably no point
fighting it.  In this case "formal" is close but less personally
annoying, but I'm not sure the word is needed at all).

Thanks,
NeilBrown


>
> ------------------8<---------------------
>
> From c9fbfae0ab615e20de0bdf1ae7b27591d602f577 Mon Sep 17 00:00:00 2001
> From: Jeff Layton <jlayton@kernel.org>
> Date: Mon, 16 Mar 2020 18:57:47 -0400
> Subject: [PATCH] SQUASH: update with Neil's comments
>
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
>  fs/locks.c | 31 ++++++++++++++++++++++---------
>  1 file changed, 22 insertions(+), 9 deletions(-)
>
> diff --git a/fs/locks.c b/fs/locks.c
> index eaf754ecdaa8..e74075b0e8ec 100644
> --- a/fs/locks.c
> +++ b/fs/locks.c
> @@ -741,8 +741,9 @@ static void __locks_wake_up_blocks(struct file_lock *=
blocker)
>  			wake_up(&waiter->fl_wait);
>=20=20
>  		/*
> -		 * Tell the world we're done with it - see comment at
> -		 * top of locks_delete_block().
> +		 * The setting of fl_blocker to NULL marks the official "done"
> +		 * point in deleting a block. Paired with acquire at the top
> +		 * of locks_delete_block().
>  		 */
>  		smp_store_release(&waiter->fl_blocker, NULL);
>  	}
> @@ -761,11 +762,23 @@ int locks_delete_block(struct file_lock *waiter)
>  	/*
>  	 * If fl_blocker is NULL, it won't be set again as this thread "owns"
>  	 * the lock and is the only one that might try to claim the lock.
> -	 * Because fl_blocker is explicitly set last during a delete, it's
> -	 * safe to locklessly test to see if it's NULL. If it is, then we know
> -	 * that no new locks can be inserted into its fl_blocked_requests list,
> -	 * and we can therefore avoid doing anything further as long as that
> -	 * list is empty.
> +	 *
> +	 * We use acquire/release to manage fl_blocker so that we can
> +	 * optimize away taking the blocked_lock_lock in many cases.
> +	 *
> +	 * The smp_load_acquire guarantees two things:
> +	 *
> +	 * 1/ that fl_blocked_requests can be tested locklessly. If something
> +	 * was recently added to that list it must have been in a locked region
> +	 * *before* the locked region when fl_blocker was set to NULL.
> +	 *
> +	 * 2/ that no other thread is accessing 'waiter', so it is safe to free
> +	 * it.  __locks_wake_up_blocks is careful not to touch waiter after
> +	 * fl_blocker is released.
> +	 *
> +	 * If a lockless check of fl_blocker shows it to be NULL, we know that
> +	 * no new locks can be inserted into its fl_blocked_requests list, and
> +	 * can avoid doing anything further if the list is empty.
>  	 */
>  	if (!smp_load_acquire(&waiter->fl_blocker) &&
>  	    list_empty(&waiter->fl_blocked_requests))
> @@ -778,8 +791,8 @@ int locks_delete_block(struct file_lock *waiter)
>  	__locks_delete_block(waiter);
>=20=20
>  	/*
> -	 * Tell the world we're done with it - see comment at top
> -	 * of this function
> +	 * The setting of fl_blocker to NULL marks the official "done" point in
> +	 * deleting a block. Paired with acquire at the top of this function.
>  	 */
>  	smp_store_release(&waiter->fl_blocker, NULL);
>  	spin_unlock(&blocked_lock_lock);
> --=20
> 2.24.1

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEG8Yp69OQ2HB7X0l6Oeye3VZigbkFAl5xQMwACgkQOeye3VZi
gbklyw//bFtCx3NOaCI22l1xQpaKvtLBY11zvLLiSEMvif1qva2O0KTDctzIcpi9
XibamKD1YmDaOi0k7Y267NwqAdMjyFSKt/d7pSUELUBfdr+x+d48tvF/x+QT+Hq0
xt+Pp6W2P+azUswhhj4EWEGhhtIegGHfv1c6GfBC8NargPtaea3Ul9uokr/boYa1
d0OiEOxaE0rAp04YQeMYidtEghuSgB2g6SRVl6+eVhLYyNa+vsk5TxSSZ2E5Pf2P
FuSsH/JRYQucmi2rfkZ2ru2kWvbQIKgjVaLDZkrUh3SAnR+vY6S+bHDr9qeR3bls
15EMzsJibnEJHxV2Xw7nAbRKAcD6w5HNJ6xtDXUwlo8LdP1Y5DGlu6vW76sTLYjm
0oFWKv+8hl3h2NCjcK+FaohwD4C3uX0ZlV0QW1t+STDj4kmIpbvNVxdps8FkTgAg
iu5qUf1qoYS9XItegCp9ADaKTul4EPs0cjevqGrDHfCSiujbw0xWYIVWVTHdoTgA
FR3BZmtE4XE44wkD5N2z0RP351ynP6mJquzcCOV6/nzulgm//NEP64pfZjWyMiAb
TgSBPPCYgYGOwOVeCxj3uiJf/+QMo9LJXAOsWi5BMrkzADirD70tu+QmlACz/Q1x
CBhVEwi0V+aBLni0unbx0PDBPqjiLpiDxDAp1Y4QxKSWZpmgbq8=
=VCS6
-----END PGP SIGNATURE-----
--=-=-=--
