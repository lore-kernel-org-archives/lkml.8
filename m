Return-Path: <SRS0=Xj+s=AD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6D18C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 13:38:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8520B20716
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 13:38:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hqQ98FJl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729247AbgFVNiA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jun 2020 09:38:00 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:55532 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728070AbgFVNh7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 09:37:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1592833078;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=mgkrMlHTxNpnMQAYHl1K4EwFxcTFYH4+ZUAQ7d50tGY=;
        b=hqQ98FJlme/61XxkWMFdDhoojiWhI8hayZ+d/Zswv1SoqAD7rZi6s/neJ0JZUTOaBeFuQJ
        QDSqnuOFwkVZZfL/C4htL7u5NHBxGTW3W0HAyBiVcXaFUSLRI+G20hunv1hoVBRp2SyABG
        0oizWFR44zYyrGaSSy/5YLLfhZP7mug=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-35-taiTrE9hNXq1zEyx4hjdhQ-1; Mon, 22 Jun 2020 09:37:52 -0400
X-MC-Unique: taiTrE9hNXq1zEyx4hjdhQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 01183872FE1;
        Mon, 22 Jun 2020 13:37:50 +0000 (UTC)
Received: from localhost (ovpn-116-90.gru2.redhat.com [10.97.116.90])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8FB355BADE;
        Mon, 22 Jun 2020 13:37:48 +0000 (UTC)
Date:   Mon, 22 Jun 2020 10:37:47 -0300
From:   Bruno Meneguele <bmeneg@redhat.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Petr Mladek <pmladek@suse.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        David Laight <David.Laight@aculab.com>
Subject: Re: [PATCH] Revert "kernel/printk: add kmsg SEEK_CUR handling"
Message-ID: <20200622133747.GD2850@glitch>
References: <20200622030222.1370098-1-Jason@zx2c4.com>
 <CAHk-=wj5TPoHih-8m+s9UNShiKavUFLacmHFmNbDrXQem43kSA@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAHk-=wj5TPoHih-8m+s9UNShiKavUFLacmHFmNbDrXQem43kSA@mail.gmail.com>
X-PGP-Key: http://keys.gnupg.net/pks/lookup?op=get&search=0x3823031E4660608D
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=bmeneg@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="bi5JUZtvcfApsciF"
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--bi5JUZtvcfApsciF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jun 21, 2020 at 08:50:09PM -0700, Linus Torvalds wrote:
> On Sun, Jun 21, 2020 at 8:02 PM Jason A. Donenfeld <Jason@zx2c4.com> wrot=
e:
> >
> > This reverts commit 8ece3b3eb576a78d2e67ad4c3a80a39fa6708809.
> >
> > This commit broke userspace. Bash uses ESPIPE to determine whether or
> > not the file should be read using "unbuffered I/O", which means reading
> > 1 byte at a time instead of 128 bytes at a time.
>=20
> Ack. Somewhat odd behavior, but clearly user space depended on the
> legacy "return EINVAL rather than ESPIPE" behavior.
>=20
> I do think there are other reasons to not return ESPIPE. The fact is,
> the printk buffer _is_ seekable, it's just relative seeking that
> doesn't work. You can seek to the beginning and the end and a
> particular offset, just not relative.
>=20
> So I kind of see why people wanted to return ESPIPE, but at the same
> time it really is very misleading: ESPIPE is for pure streams that
> can't lseek at all.

That was indeed a misunderstanding of mine wrt ESPIPE meaning.
And I agree with your previous paragraph where you stated that the
buffer is only not "relative" seekable. So, ack for the revert.

However, the issue with glibc is their fd checking on dprintf using:

lseek(offset =3D=3D 0, whence =3D=3D SEEK_CUR)

Which, technically, isn't a relative seek operation in my opinion, thus
I'm also not sure that returning EINVAL is correct.=20

Would it make sense to return the next buffer index instead? Basically
the same as SEEK_END does? The first "if (offset)" in the function would
prevent any real relative move while SEEK_CUR would return a valid
address following this buffer behavior of specific points it could seek
to.

>=20
> The fact that some silly shell internal then reacts very badly to that
> may be extreme, but it may be as well as you can do it you worry about
> leaving data for the next user.
>=20
> I've applied the revert.
>=20
>              Linus
>=20

--=20
bmeneg=20
PGP Key: http://bmeneg.com/pubkey.txt

--bi5JUZtvcfApsciF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEdWo6nTbnZdbDmXutYdRkFR+RokMFAl7wtCsACgkQYdRkFR+R
okMX3wgAtGljuKIhXYBxhpvs4p2xQWRLW/RTySITG7k86tmTNf9qs/7/kog9a0Yb
gF087sCIG9ZC0POru1uaKVV7uLS6mxJo2e5nzkZukGEoXVkECFjbK79nlJMc3kW5
sgJCT2NvuCng2Ytr82CUVACvWqsna7diX+Pm0RWcys/CwzcEGlbmVmiWJc9BrAIK
1NZCSLtB08HqndkHL9rKeoXBrpb2x4UTMXixJ4Z/axp+UmjhQBfMD+fY/FD/VRPZ
Op8/mMglCHDygjghG3m2Fk/6pOQwOkbw/nfGuwcB7gZ+Yr+7DeoCEgrJCPK5Kd2B
pi30kaQTwAU5V/TLbLAA+Xiy5xppQg==
=+dr2
-----END PGP SIGNATURE-----

--bi5JUZtvcfApsciF--

