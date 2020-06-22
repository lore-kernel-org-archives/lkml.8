Return-Path: <SRS0=Xj+s=AD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93C6BC433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 17:10:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 71503206BE
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 17:10:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZB8U4t9/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729983AbgFVRKR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jun 2020 13:10:17 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:21773 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729789AbgFVRKQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 13:10:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1592845815;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3B50y9fzqmn68tx9RAie0dMH0CacbXY3aKvFcH1I84s=;
        b=ZB8U4t9/NuhPCCf0NBX5Gr7W74uM5a+53OQfxiisGnQDUY1qWYMpW9sfjoX9uesXvA7Ww2
        xusf5YAu/67z6Z+zhxD1bdVJIaKTGdX7xQDQYGqhF3/UsUOhBioCX3f1A0B48saEPCk2JF
        am+Yyc/gZ9oZIVA+oJVRRyfjCOzGf1U=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-494-Bj39DBcRNPWmR2ltLRY2CQ-1; Mon, 22 Jun 2020 13:10:04 -0400
X-MC-Unique: Bj39DBcRNPWmR2ltLRY2CQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 26E8D1902EA8;
        Mon, 22 Jun 2020 17:10:03 +0000 (UTC)
Received: from localhost (ovpn-116-90.gru2.redhat.com [10.97.116.90])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6A9A710013D7;
        Mon, 22 Jun 2020 17:10:02 +0000 (UTC)
Date:   Mon, 22 Jun 2020 14:10:01 -0300
From:   Bruno Meneguele <bmeneg@redhat.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Petr Mladek <pmladek@suse.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        David Laight <David.Laight@aculab.com>
Subject: Re: [PATCH] Revert "kernel/printk: add kmsg SEEK_CUR handling"
Message-ID: <20200622171001.GF2850@glitch>
References: <20200622030222.1370098-1-Jason@zx2c4.com>
 <CAHk-=wj5TPoHih-8m+s9UNShiKavUFLacmHFmNbDrXQem43kSA@mail.gmail.com>
 <20200622133747.GD2850@glitch>
 <CAHk-=wgR8TZi_M4p3PZQh5nGjUjNBeXqhGyxUe8eykyf8g6p=A@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAHk-=wgR8TZi_M4p3PZQh5nGjUjNBeXqhGyxUe8eykyf8g6p=A@mail.gmail.com>
X-PGP-Key: http://keys.gnupg.net/pks/lookup?op=get&search=0x3823031E4660608D
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="fCcDWlUEdh43YKr8"
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--fCcDWlUEdh43YKr8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 22, 2020 at 09:42:25AM -0700, Linus Torvalds wrote:
> > Would it make sense to return the next buffer index instead? Basically
> > the same as SEEK_END does? The first "if (offset)" in the function woul=
d
> > prevent any real relative move while SEEK_CUR would return a valid
> > address following this buffer behavior of specific points it could seek
> > to.
>=20
> Maybe. At the same time, the way we don't actually return a real
> position means that that's very dangerous too. We'll always return
> "we're at position zero".
>=20
> And we never accept byte-by-byte reads and require a "get the whole
> record" model.
>=20
> So I think we might as well accept "kmsg is special".
>=20
> I don't have hugely strong opinions on it - I certainly agree that
> "SEEK_CUR with offset zero could be a no-op", but I also don't think
> there's a huge reason to try to change it, considering just _how_
> special kmsg is.

Although both options are pretty fine by me too, I "fear" (not really)
we can end up stacking special behavior interfaces, forcing userspace to
keep a "table of special case files". Personally, I prefer to return
something _valid_ to userspace rather than _fail_ with special meaning.

But in any case I think it's worth adding a note in the docs just to
make sure we have somewhere to point in case they start looking.

Thanks Linus! Will wait some more in case we have other thoughts around
it before posting anything (doc patch or the other approach).

--=20
bmeneg=20
PGP Key: http://bmeneg.com/pubkey.txt

--fCcDWlUEdh43YKr8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEdWo6nTbnZdbDmXutYdRkFR+RokMFAl7w5ekACgkQYdRkFR+R
okM8lAgA1iOa72bB8CwW2tu6kmDPA6vvHDaAKn3kZoBF9O1KMJDJhBhdU5wIyIDH
h12GJVvURxZrQNtP5a1BdrB2GfEDzYQoB7uefRttoPMJbX0cA4iRBko+NZKijz1T
oKbsCp4t5f23GJbldZTzDTAOAeda1zit7XEtbxE/O4LWPeHQGjODppFGj7sjm688
Se8i4MBbEYl5+VBibRR3g/Hr1MBl2IFhfqhV0Br9p9p1qMrWI+EzyrZtFX8WZdFl
s32H1WGPjCh/Jvm8MvAIuDZ2ughjHrxZU/Aj7iZa7vA2EnBgF179TBSES5UJLD4x
0SCHFUXPAjxwuv3cdIaOORaWMiDcZA==
=kU9L
-----END PGP SIGNATURE-----

--fCcDWlUEdh43YKr8--

