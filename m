Return-Path: <SRS0=2Lxt=AV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36634C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 13:11:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 011AC207BB
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 13:11:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NLYr/WFs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727861AbgGJNLH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jul 2020 09:11:07 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:43476 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726828AbgGJNLD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jul 2020 09:11:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1594386661;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=gljGcFi9pvin4NSQiUvypzy124N0N1e+L+bUaxisI78=;
        b=NLYr/WFs9PUq7+riju8SHucVTCRQYfPlUBFMuS+HrfOvLSppcXq/P83yA1BRuLy9Yk9as8
        XXF1NyQwd5snDan5VsRXcGz4ibwu3hkih0vSeH1oE61Hw3ii35Lbc0+fEvngcp1Jr28XLA
        o6dnMOJk56C5kJkc3wwbSknoNYhzV1o=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-114-GiF5lbolM3a8gU8Y5x4NQQ-1; Fri, 10 Jul 2020 09:10:57 -0400
X-MC-Unique: GiF5lbolM3a8gU8Y5x4NQQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B54D2E928;
        Fri, 10 Jul 2020 13:10:55 +0000 (UTC)
Received: from localhost (ovpn-116-117.gru2.redhat.com [10.97.116.117])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3BE50724A9;
        Fri, 10 Jul 2020 13:10:53 +0000 (UTC)
Date:   Fri, 10 Jul 2020 10:10:52 -0300
From:   Bruno Meneguele <bmeneg@redhat.com>
To:     Petr Mladek <pmladek@suse.com>
Cc:     linux-kernel@vger.kernel.org, sergey.senozhatsky@gmail.com,
        torvalds@linux-foundation.org, Jason@zx2c4.com
Subject: Re: [PATCH] doc:kmsg: explictly state the return value in case of
 SEEK_CUR
Message-ID: <20200710131052.GA9078@glitch>
References: <20200709155415.41207-1-bmeneg@redhat.com>
 <20200710121923.GO4751@alley>
MIME-Version: 1.0
In-Reply-To: <20200710121923.GO4751@alley>
X-PGP-Key: http://keys.gnupg.net/pks/lookup?op=get&search=0x3823031E4660608D
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=bmeneg@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="AqsLC8rIMeq19msA"
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--AqsLC8rIMeq19msA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 10, 2020 at 02:19:23PM +0200, Petr Mladek wrote:
> On Thu 2020-07-09 12:54:15, Bruno Meneguele wrote:
> > The commit 625d3449788f ("Revert "kernel/printk: add kmsg SEEK_CUR
> > handling"") reverted a change done to the return value in case a SEEK_C=
UR
> > operation was performed for kmsg buffer based on the fact that differen=
t
> > userspace apps were handling the new return value (-ESPIPE) in differen=
t
> > ways, breaking them.
> >=20
> > At the same time -ESPIPE was the wrong decision because kmsg /does supp=
ort/
> > seek() but doesn't follow the "normal" behavior userspace is used to.
> > Because of that and also considering the time -EINVAL has been used, it=
 was
> > decided to keep this way to avoid more userspace breakage.
> >=20
> > This patch adds an official statement to the kmsg documentation pointin=
g to
> > the current return value for SEEK_CUR, -EINVAL, thus userspace librarie=
s and
> > apps can refer to it for a definitive guide on what to expected.
> >=20
> > --- a/Documentation/ABI/testing/dev-kmsg
> > +++ b/Documentation/ABI/testing/dev-kmsg
> > @@ -56,6 +56,11 @@ Description:=09The /dev/kmsg character device node p=
rovides userspace access
> >  =09=09  seek after the last record available at the time
> >  =09=09  the last SYSLOG_ACTION_CLEAR was issued.
> > =20
> > +=09=09Considering that the seek operation is supported but has=20
> > +=09=09special meaning to the device, any attempt to seek specific
> > +=09=09positions on the buffer (i.e.  using SEEK_CUR) results in an
> > +=09=09-EINVAL error returned to userspace.
>=20
> Sigh, I see that devkmsg_llseek() returns -ESPIPE when offset is not
> zero. This is a real mess.
>=20
> I wonder if we could afford to switch this one to -EINVAL and reduce
> the mess.
>=20

That's a really good question for which I think the answer is something
close to: "that's impossible to predict". I could try some in-house (at
redhat) automated tests to see if something break, but I doubt it is
enough to catch any breakage.

> Anyway, for a random reader, it might be pretty unclear what is
> exactly special about /dev/kmsg. I wonder if the following might
> be more explanatory and strightforward:
>=20
> =09=09Other seek operations or offsets are not supported because of
> =09=09the special behavior. The device allows to read or write
> =09=09only whole variable lenght messages that are stored in
> =09=09a ring buffer.
>=20
> =09=09Because of the non-standard behavior also the error values
> =09=09are non-standardand. -ESPIPE is returned for non-zero offset.
> =09=09-EINVAL is returned for other operations, e.g. SEEK_CUR.
> =09=09This behavior is historical and could not be modified
> =09=09wihtout the risk of breaking userspace.
>=20

Yes, no doubt it's better!

>=20
> Finally, only few people read documentation. We should add some
> warning also to the code. I think about a something like:
>=20
> /*
>  * Be careful when modifying this function!!!
>  *
>  * Only few operations are supported because the device works only with
>  * the entire variable length messages. Non-standard error values are
>  * returned in the other cases. User space applications might depend
>  * on this behavior.
>  */
>=20

Agreed.

I'm going to prepare a v2 of the patch adding the comments.

Thanks Petr!

--=20
bmeneg=20
PGP Key: http://bmeneg.com/pubkey.txt

--AqsLC8rIMeq19msA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEdWo6nTbnZdbDmXutYdRkFR+RokMFAl8IaNwACgkQYdRkFR+R
okPtSgf/RrbH0ofSXM+xsuCCXzWeCEsT590daxzzoFEMaGjZz1Bji9zW39bR3X7p
jp+Pfx1N8W71xNgkdG1Nh++Yrq89/hBaDC1KZ7RRWVB3gCZSPQDl5rieDIEwyen1
M3j5skAjuR9Wpgbf3DeO5VyYYx2ek7Wj2HsWZN5TRfj6pqdMd7C65mklJ7+0h8Nu
YzzJqJVeJgOqAg2PWJA5f3F+O1gXEfIk1Qq11ObAuUPqUbCzr0muYd/0DMO19IqB
7Vc/Ou/o6ynHFQ4h2x43FP1iD96eIhLR2Sl8/J8fKqMRa+18mpypXjSGa2tDMRLn
GYB8m/zU8VUP3WFeUkHeUqpVWrOgTg==
=voHf
-----END PGP SIGNATURE-----

--AqsLC8rIMeq19msA--

