Return-Path: <SRS0=CUu6=46=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA577C2BB1D
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 10:44:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 822B320724
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 10:44:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eVCIKuOZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726553AbgCMKoy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Mar 2020 06:44:54 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:59514 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726414AbgCMKoy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Mar 2020 06:44:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1584096293;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=aT9q9UJeOule/4yraFsE371e6/2YUeu5VbTUE9ggi9s=;
        b=eVCIKuOZwqITMe5I14a3kLCGLJMI1fteZpuqgZ81awkJRziwBB6VZghaWynu8EJKgtekY6
        6gifWTLowjB+vPkt+8YDB0LULh+oBAkM5WUSfT+Q5+r7Ou8HEw8FKGv1JL0fMASkBtkXkW
        HO/JyVL1OiXkspWezpZ9WR+ryfYbEKA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-152-S5-3PBs7MFO5Vu_zwLOsXg-1; Fri, 13 Mar 2020 06:44:48 -0400
X-MC-Unique: S5-3PBs7MFO5Vu_zwLOsXg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4E29310CE79E;
        Fri, 13 Mar 2020 10:44:47 +0000 (UTC)
Received: from localhost (ovpn-121-102.rdu2.redhat.com [10.10.121.102])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9E63860C63;
        Fri, 13 Mar 2020 10:44:46 +0000 (UTC)
Date:   Fri, 13 Mar 2020 07:44:45 -0300
From:   Bruno Meneguele <bmeneg@redhat.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        pmladek@suse.com, sergey.senozhatsky@gmail.com, rostedt@goodmis.org
Subject: Re: [PATCH] kernel/printk: add kmsg SEEK_CUR handling
Message-ID: <20200313104445.GH13406@glitch>
References: <20200313003533.2203429-1-bmeneg@redhat.com>
 <20200313072254.GA1960396@kroah.com>
MIME-Version: 1.0
In-Reply-To: <20200313072254.GA1960396@kroah.com>
X-PGP-Key: http://keys.gnupg.net/pks/lookup?op=get&search=0x3823031E4660608D
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="AzNpbZlgThVzWita"
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--AzNpbZlgThVzWita
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 13, 2020 at 08:22:54AM +0100, Greg KH wrote:
> On Thu, Mar 12, 2020 at 09:35:33PM -0300, Bruno Meneguele wrote:
> > Userspace libraries, e.g. glibc's dprintf(), expect the default return =
value
> > for invalid seek situations: -ESPIPE, but when the IO was over /dev/kms=
g the
> > current state of kernel code was returning the generic case of an -EINV=
AL.
> > Hence, userspace programs were not behaving as expected or documented.
> >=20
> > With this patch we add SEEK_CUR case returning the expected value and a=
lso a
> > simple mention of it in kernel's documentation for those relying on tha=
t for
> > guidance.
> >=20
> > Signed-off-by: Bruno Meneguele <bmeneg@redhat.com>
> > ---
> >  Documentation/ABI/testing/dev-kmsg | 2 ++
> >  kernel/printk/printk.c             | 4 ++++
> >  2 files changed, 6 insertions(+)
>=20
> <formletter>
>=20
> This is not the correct way to submit patches for inclusion in the
> stable kernel tree.  Please read:
>     https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.ht=
ml
> for how to do this properly.
>=20
> </formletter>
>=20

ouch, yes of course. Sorry for the noise. =20
Will repost it once the concerns with the patch are solved.

Thanks Greg.

--=20
bmeneg=20
PGP Key: http://bmeneg.com/pubkey.txt

--AzNpbZlgThVzWita
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEdWo6nTbnZdbDmXutYdRkFR+RokMFAl5rZB0ACgkQYdRkFR+R
okNb7ggAxbkwFdSoQBgH0xZI1DmgLTjKi+ZL+j7MtBdujIL2f6vbCfhnK8G4nocx
SvCAk//UCsAqAkib7vCdJTwPm3QT7TmtUAtZ2dgQkooytWEKyLY5h2p/WZwg9RGV
LwA7GU66oYsCzkFIy+TSHa6DL2wsesdef1tDapiDhFKFV/tnFumx9U7JnnyZCV+m
xuUfLKAojOEYGN2T1vJTv4Phy+ru4Rw8ZRWToMHnw0lYNd2V0xnFbzoFYd76JCE9
IT4yW3eJWrngU7f/+IUUkE2MLPot3jToatuJCumKz8CzTa6lxjgX1Pzbm+wVCNBR
BffqOOOwAQyaHpiXziOW/5QCgZPikg==
=bQvY
-----END PGP SIGNATURE-----

--AzNpbZlgThVzWita--

