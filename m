Return-Path: <SRS0=Xj+s=AD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49BA3C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 17:37:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2878620732
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 17:37:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="H4SDREWP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730128AbgFVRhw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jun 2020 13:37:52 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:30813 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730112AbgFVRhv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 13:37:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1592847470;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=lg9K+pgZBrMOb0IX6ElB7OWsafUaHf8Qs0wm12j4t9Q=;
        b=H4SDREWPAtLUdGzFT+rH473ZO9UjhrGjH9NZzfPf43x0cjlqY5hxYxadRnPVvIxVaoRHkf
        oPylRlCudhjLiNlBSODwyDAXXv87jVo/KUll2TJVsR+AWsb4yHBVCGoWBSQxndCuqBICMp
        lNgUwz5W0JmRBrRKqYnx3hyRNay/v70=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-139-9xkVeD4jPc2iZ4sI9UqCXQ-1; Mon, 22 Jun 2020 13:37:45 -0400
X-MC-Unique: 9xkVeD4jPc2iZ4sI9UqCXQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5BAD510059A2;
        Mon, 22 Jun 2020 17:37:44 +0000 (UTC)
Received: from localhost (ovpn-116-68.gru2.redhat.com [10.97.116.68])
        by smtp.corp.redhat.com (Postfix) with ESMTP id CE72A19C71;
        Mon, 22 Jun 2020 17:37:42 +0000 (UTC)
Date:   Mon, 22 Jun 2020 14:37:41 -0300
From:   Bruno Meneguele <bmeneg@redhat.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Petr Mladek <pmladek@suse.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        David Laight <David.Laight@aculab.com>
Subject: Re: [PATCH] Revert "kernel/printk: add kmsg SEEK_CUR handling"
Message-ID: <20200622173741.GA8956@glitch>
References: <20200622030222.1370098-1-Jason@zx2c4.com>
 <CAHk-=wj5TPoHih-8m+s9UNShiKavUFLacmHFmNbDrXQem43kSA@mail.gmail.com>
 <20200622133747.GD2850@glitch>
 <CAHk-=wgR8TZi_M4p3PZQh5nGjUjNBeXqhGyxUe8eykyf8g6p=A@mail.gmail.com>
 <20200622171001.GF2850@glitch>
 <CAHk-=wg6vtnyxW6DR6_pTmMowjd9SuULu4C0DJBXCzJz8XgyXg@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAHk-=wg6vtnyxW6DR6_pTmMowjd9SuULu4C0DJBXCzJz8XgyXg@mail.gmail.com>
X-PGP-Key: http://keys.gnupg.net/pks/lookup?op=get&search=0x3823031E4660608D
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="X1bOJ3K7DJ5YkBrT"
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--X1bOJ3K7DJ5YkBrT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 22, 2020 at 10:32:51AM -0700, Linus Torvalds wrote:
> On Mon, Jun 22, 2020 at 10:10 AM Bruno Meneguele <bmeneg@redhat.com> wrot=
e:
> >
> > Although both options are pretty fine by me too, I "fear" (not really)
> > we can end up stacking special behavior interfaces, forcing userspace t=
o
> > keep a "table of special case files". Personally, I prefer to return
> > something _valid_ to userspace rather than _fail_ with special meaning.
>=20
> Well, what's even worse if user space has to handle two different
> things just because behavior changed in different kernels..
>=20
> So at some point "odd behavior" is much better than "odd behavior in
> two different ways"..

Really well pointed!

Ok, +1 for doc-only patch it is :).

--=20
bmeneg=20
PGP Key: http://bmeneg.com/pubkey.txt

--X1bOJ3K7DJ5YkBrT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEdWo6nTbnZdbDmXutYdRkFR+RokMFAl7w7GUACgkQYdRkFR+R
okNYvQf7BN9lahjWkOBj1A+rlTV5bTZJVM5Kjn+KJmQ1tma0CDd5FQmyHPINBB2u
ommewr0fF2vGNnd3WHKU0XuzjmEATbeF3FHhE4BYzOzUJpIFEPdl7nmPsZR99Zbh
c+LEGBIUEt7xckXMmUHzxUt+keB+8aJ8aisYYOIXkdeSvj2ztIAznbRZ6H5st+b8
xfSgGC46MqLfxftPAZn0rBhYDRQdy7mkH+y3aMY/5wtp07emM5tl6kDvsXddiUZ9
+aiRSTXzDPRz+uTNKdc+9T27cIx988GZ5EX6GEQg2aP4xpFk42jiYuaT6ezFySBA
rhNweJmI2/cL0aL9YexyxgbvB1Yx8A==
=0toj
-----END PGP SIGNATURE-----

--X1bOJ3K7DJ5YkBrT--

