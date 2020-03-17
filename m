Return-Path: <SRS0=kRID=5C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 148EFC10F29
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 14:57:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DDA74206EC
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 14:57:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726777AbgCQO5C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Mar 2020 10:57:02 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:43052 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726484AbgCQO5C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Mar 2020 10:57:02 -0400
Received: from [192.168.4.242] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1jEDeL-0005u8-Rs; Tue, 17 Mar 2020 14:56:57 +0000
Received: from ben by deadeye with local (Exim 4.93)
        (envelope-from <ben@decadent.org.uk>)
        id 1jEDeL-00CpNa-FG; Tue, 17 Mar 2020 14:56:57 +0000
Message-ID: <18622dc08c49e7d4304f221e378137ecde09ba61.camel@decadent.org.uk>
Subject: Re: [PATCH] genirq: fix reference leaks on irq affinity notifiers
From:   Ben Hutchings <ben@decadent.org.uk>
To:     Edward Cree <ecree@solarflare.com>, tglx@linutronix.de
Cc:     linux-kernel@vger.kernel.org, psodagud@codeaurora.org
Date:   Tue, 17 Mar 2020 14:56:46 +0000
In-Reply-To: <a527a4bb-fdc4-815d-8852-674767b9dd1d@solarflare.com>
References: <24f5983f-2ab5-e83a-44ee-a45b5f9300f5@solarflare.com>
         <17c4273e4f72ebdf1ca838d75fc6ed93fcdc7287.camel@decadent.org.uk>
         <a527a4bb-fdc4-815d-8852-674767b9dd1d@solarflare.com>
Content-Type: multipart/signed; micalg="pgp-sha512";
        protocol="application/pgp-signature"; boundary="=-8Dsb++f6nhTcgfY8y8C/"
User-Agent: Evolution 3.34.1-4 
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 192.168.4.242
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-8Dsb++f6nhTcgfY8y8C/
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2020-03-17 at 10:58 +0000, Edward Cree wrote:
> On 15/03/2020 20:29, Ben Hutchings wrote:
> > ...since the pending work item holds a reference to the notification
> > state, it's still not clear to me why or whether "genirq: Prevent use-
> > after-free and work list corruption" was needed.
> Yeah, I think that commit was bogus.  The email thread[1] doesn't
>  exactly inspire confidence either.  I think the submitter just didn't
>  realise that there was a ref corresponding to the work; AFAICT there's
>  no way the alleged "work list corruption" could happen.
>=20
> > If it's reasonable to cancel_work_sync() when removing a notifier, I
> > think we can remove the kref and call the release function directly.
> I'd prefer to stick to the smaller fix for -rc and stable.  But if you
>  want to remove the kref for -next, I'd be happy to Ack that patch.

OK, then you can add:

Acked-by: Ben Hutchings <ben@decadent.org.uk>

to this one.

> Btw, we (sfc linux team) think there's still a use-after-free issue in
>  the cpu_rmap lib, as follows:
> 1) irq_cpu_rmap_add creates a glue and notifier, adds glue to rmap->obj
> 2) someone else does irq_set_affinity_notifier.
>    This causes cpu_rmap's notifier (old_notify) to get released, and so
>    irq_cpu_rmap_release kfrees glue.  But it's still in rmap->obj
> 3) free_irq_cpu_rmap loops over obj, finds the glue, tries to clear its
>    notifier.
> Now one could say that this UAF is academic, since having two bits of
>  code trying to register notifiers for the same IRQ is broken anyway
>  (in this case, the rmap would stop getting updated, because the
>  "someone else" stole the notifier).

So far as I can remember, my thinking was that only non-shared IRQs
will have notifiers and only the current user of the IRQ will set the
notifier.  The doc comment for irq_set_affinity_notifier() implies the
latter restriction, but it might be worth spelling this out explicitly.

Ben.

> But I thought I'd bring it up in case it's halfway relevant.
>=20
> -ed
>=20
> [1] https://lore.kernel.org/lkml/1553119211-29761-1-git-send-email-psodag=
ud@codeaurora.org/T/#u
--=20
Ben Hutchings
For every complex problem
there is a solution that is simple, neat, and wrong.


--=-8Dsb++f6nhTcgfY8y8C/
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEErCspvTSmr92z9o8157/I7JWGEQkFAl5w5S8ACgkQ57/I7JWG
EQmZBxAAucg9e7dBvW7zXPn9pe7tgtrQ/iR7i+Y5zGDNAYYHM2wafoFJ25eivyb5
PkGWjBx2COU6U9aoXR3AFlrl1kx4iDmcdVo82WNa1el2RDntfVIytoDh65O31h2P
yquPzfsBAd2appE2kFhOeVb/YXT27AcFBhsgOT0ltCKUiulci9u9B1IQbqE30oxu
Hwqd+tFXnCzdo0gryx3tW1EaNgIYa+Cytlnu9NhCEypD0EaNc5NGIEYG2u7wTtGy
dlPlxaINKKsW0tf6w8YPV2oRbd5EH4v2hqLBl5ey3znHw8ZJ5TiOyyxxm4BM9q4w
4oZS4K1f5tO2EKOevlcuEXLsNQlUYgRWKCMQBgMGVx6oBwZiOfr7nMQTR0qWHLj8
oqw4HVfaJpRCSEN0VA9ch64Xxyy2mkCOIXV9oCsFP0NMO2uXyEMeoMrtAmJ5Fbs5
vqsPXEJLG1ks/+bemebK6BLvBh7ZJJytyp0G8XDKI1ogJnTTR51wQNaqAfgU/M6t
jIo1kKWWoVw72xYDZbl4tlFb5ZvXeGvWPfF89MH9nkjYFyHk+JT9anr0KTyIYtjc
DfBZ8Vqibne43wKUTjRHZFtLbDnZGxH6rePxYrPoCyiLC+rpgingUoVfgAAYuK6K
lTMr9qOiSTSBhHR7XvytOvlS1CJbSgfSIK+09V35nW/kl+EnfC4=
=78Yv
-----END PGP SIGNATURE-----

--=-8Dsb++f6nhTcgfY8y8C/--
