Return-Path: <SRS0=Ktsx=44=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFC49C10F27
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 08:20:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6EE572082E
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 08:20:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sgHzeNyr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728578AbgCKIUI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Mar 2020 04:20:08 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:42625 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726097AbgCKIUI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 04:20:08 -0400
Received: by mail-wr1-f68.google.com with SMTP id v11so1337965wrm.9
        for <linux-kernel@vger.kernel.org>; Wed, 11 Mar 2020 01:20:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=yUlOZtw0A5ch2LhZ/EICcSSU3rQFan95dUnasfsC/o8=;
        b=sgHzeNyrtsLQem6SRf4uwUJuhnPu8jemhLQPpcpqycXZM6enYNSWFCZR8MuqbEwneX
         kQhRXWW67mY3wBIE3PXc9E3M1gGQWw6HZ4OV6BdVdLH3aq1BRMJAbI9elmUNyVqWt888
         AKwE46DOUzH0N2igemcno4J1oKV5zmvWLLk4KYy7xDqb7G7QKyeBfW7pHPwEvZx+DzfQ
         aM/mK60sHnGbVGaBdtpqDP2tsZ4KFQsUlnFYUK7Q/Q+G5GzT5eh4O6sNx7eNmem2S3HT
         LfDjDAoUS6omH0r4jBzVQexZTCD5e0h5KNg+QulZklE/8/4Tx97+f/2c4Trpjnl6cgD5
         g4JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=yUlOZtw0A5ch2LhZ/EICcSSU3rQFan95dUnasfsC/o8=;
        b=F65wYIJrZhyHcZ2x7KWyHgVaLZyKTxnxlhnlXiC9GUzwr5Genwcf1lBTzqozamv8/t
         NVhf2PcJkdK0OLp5pN6qWdTszh20h4OcAFEXg6TH94fvoFoV/HCVYkuSvHoN/cvIQUKN
         0m9zSIAHBQUM8P1PIhrCNJiwQUSJwI0ihnsMtkIId0CsjwvhoFRIrvLQOryH9U7eeaXU
         8BvV7EjL1oop0sSAv9dD/WA/xtnE1ltPMFfp4ZmAqXytcciAmOlnRC7bbDFr+gqN7vdX
         2O698H5tNXqW8bugWIFMMWMuyfBTvGCCdf0WjkeOgBjusmHSzcYBa7v+lRqc1PHJffvQ
         buUg==
X-Gm-Message-State: ANhLgQ2abh2LI8HBA7uIlcv/tHReqSIPzeeRcys7uag+oICD4GHlDsF8
        38oXufCg65KYUXxQ6BQmWX6uVccW
X-Google-Smtp-Source: ADFU+vtaVej/v4tpoSAbFJKbBJlEh6XOH7Vf8zQ0eXOb89v6ixpWiym3tZSAz7t8BbdRe0sePsZHnw==
X-Received: by 2002:a5d:69c7:: with SMTP id s7mr3005143wrw.165.1583914805844;
        Wed, 11 Mar 2020 01:20:05 -0700 (PDT)
Received: from localhost (pD9E516A9.dip0.t-ipconnect.de. [217.229.22.169])
        by smtp.gmail.com with ESMTPSA id z6sm13958693wru.15.2020.03.11.01.20.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2020 01:20:04 -0700 (PDT)
Date:   Wed, 11 Mar 2020 09:20:00 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        kernel test robot <rong.a.chen@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Jann Horn <jannh@google.com>,
        LKML <linux-kernel@vger.kernel.org>, x86-ml <x86@kernel.org>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@suse.de>,
        lkp@lists.01.org
Subject: Re: [futex] 8019ad13ef: will-it-scale.per_process_ops -97.8%
 regression
Message-ID: <20200311082000.GA724@ulmo>
References: <20200308140200.GO5972@shao2-debian>
 <CAHk-=wgJV7xrxsTkOG203huPShzZBEC6N_BG0KGwHBmEq4yqWg@mail.gmail.com>
 <CAHk-=whrpL8pbKLg3_s3+bxv6kbPnzbSP8dQkZ+Rv=jAT3aoKw@mail.gmail.com>
 <87h7yy90ve.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="HcAYCG3uE/tztfnV"
Content-Disposition: inline
In-Reply-To: <87h7yy90ve.fsf@nanos.tec.linutronix.de>
User-Agent: Mutt/1.13.1 (2019-12-14)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--HcAYCG3uE/tztfnV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Mar 08, 2020 at 07:07:17PM +0100, Thomas Gleixner wrote:
> Linus Torvalds <torvalds@linux-foundation.org> writes:
>=20
> > [ Just a re-send without html crud that makes all the lists unhappy.
> > I'm still on the road, the flight I was supposed to be on yesterday
> > got cancelled.. ]
> >
> > I do note that the futex hashing seems to be broken by that commit. Or
> > at least it's questionable.  It keeps hashing on "both.word",  and
> > doesn't use the u64 field at all for hashing.
> >
> > Maybe I'm mis-reading it - I didn't apply the patch, I just looked at
> > the patch and my source base separately.
> >
> > But the 98% regression sure says something went wrong ;)
>=20
> Right you are. The pointer needs to be the starting point as it moved
> ahead of word, which means it starts at word and hashes word and
> offset and an extra u32 beyond the end of the key.
>=20
> Thanks,
>=20
>         tglx
> ----
> diff --git a/kernel/futex.c b/kernel/futex.c
> index e14f7cd45dbd..9f3251349f65 100644
> --- a/kernel/futex.c
> +++ b/kernel/futex.c
> @@ -385,8 +385,8 @@ static inline int hb_waiters_pending(struct futex_has=
h_bucket *hb)
>   */
>  static struct futex_hash_bucket *hash_futex(union futex_key *key)
>  {
> -	u32 hash =3D jhash2((u32*)&key->both.word,
> -			  (sizeof(key->both.word)+sizeof(key->both.ptr))/4,
> +	u32 hash =3D jhash2((u32*)&key->both.ptr,
> +			  (sizeof(key->both.ptr) + sizeof(key->both.word)) / 4,
>  			  key->both.offset);
>  	return &futex_queues[hash & (futex_hashsize - 1)];
>  }

I was running into an issue with sshfs mounts and git bisect pointed to
the "futex: Fix inode life-time issue" commit as being the culprit. The
issue I was seeing is that an sshfs mount would succeed, but trying to
then access the mount ("ls -l /mnt" would be enough) would cause a soft
lock-up.

Applying this fix on top of next-20200310 fixes the issue for me, so:

Tested-by: Thierry Reding <treding@nvidia.com>

I still need that fix on next-20200311, but it'll probably show up in
linux-next sometime soon.

Thierry

--HcAYCG3uE/tztfnV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl5onywACgkQ3SOs138+
s6E98xAAjB5Um197E9JFyhZtS6MDQtZPZgrFcaasavhUPw9h19hlEDi/af9oGrLM
hJd0Kvymkw/ckZmpMGCji++8rNA8DU1bPrmLr5QIFS4iCDJQVTWyxndqFmuP0aiF
ZlT8ri8my5y5kfXtbf0/CSMMUt0a1STHVK+QW5fFR5zU+oWJSQya6SZWrQv0qY7T
lfdb2MKA8Riur2EYjZH9Ddtt97AwLU6zYUo2679ETysYXzgQ8R+AxX4fYiC+Z0cZ
visXxxh6BK2OLhh+DS2Rzeaxc5+bQ4fpzAPS9CCEtcDZ3HHhNH6QmU3Qk4UkrEV2
KChaRw+DQBVgmTTXOnYMUDWi73ddLdY7oIc8FY1CDp8YJInO7EFOLzPIB8TzLb/v
aGPmUX8lXFPvhuIyu3T3P5Rk/EH7hhcSPgM01ewAQ2XONq8J/M4VTBSx6ijQiIvR
65I9qwaDsULeQkW3yuc2BY03+3wO3lMZ4fJDH+cLWcsBvrs2bdFCU+ukV6FM0rWo
KQH6UC7NK+VMHPIXaxqtTJ9fBuUPm5WCxN9x9i1B0+Ft5IhbVQTgCazyGNlLZoPk
0XVNOOr+Ixz6s9hxbKMww23OZY6YfLD+vplJ2Uh6PUyhto3NPCEXVeV4sgAvhlBW
YjJt8VIYLpnjSc2JntX/9EUbvsDzfuKk5teJKdripeuQyodhWQs=
=3zJe
-----END PGP SIGNATURE-----

--HcAYCG3uE/tztfnV--
