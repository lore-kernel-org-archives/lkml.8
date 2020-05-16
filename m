Return-Path: <SRS0=wIUh=66=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D73BC433E0
	for <linux-kernel@archiver.kernel.org>; Sat, 16 May 2020 19:07:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5490220709
	for <linux-kernel@archiver.kernel.org>; Sat, 16 May 2020 19:07:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="QZGtrnC0";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="QZGtrnC0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726532AbgEPTHN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 May 2020 15:07:13 -0400
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:56176 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726298AbgEPTHN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 May 2020 15:07:13 -0400
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 918E88EE19F;
        Sat, 16 May 2020 12:07:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1589656032;
        bh=D8G+NdjnQDRxlqYxDKGcemEgX/kXVlKUwQ2n9K0wbU0=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=QZGtrnC0nkisDPiq5z/4wpE2unys4l8Z+NJySN4pHZbyl48d1+wy8Gv24YTUsG1X3
         XpxXQ1s++yw509gQTJCIqhcpg9MrEnuD50xxjK5k3JZ7JTPBMTpLTbBkAgbEr0OOdM
         7JI48ehZPPMJdFYLcB13SDXTkzRW2l6aJykiCNcI=
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id A1rl-KAx3JQT; Sat, 16 May 2020 12:07:12 -0700 (PDT)
Received: from [153.66.254.194] (unknown [50.35.76.230])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id D801D8EE173;
        Sat, 16 May 2020 12:07:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1589656032;
        bh=D8G+NdjnQDRxlqYxDKGcemEgX/kXVlKUwQ2n9K0wbU0=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=QZGtrnC0nkisDPiq5z/4wpE2unys4l8Z+NJySN4pHZbyl48d1+wy8Gv24YTUsG1X3
         XpxXQ1s++yw509gQTJCIqhcpg9MrEnuD50xxjK5k3JZ7JTPBMTpLTbBkAgbEr0OOdM
         7JI48ehZPPMJdFYLcB13SDXTkzRW2l6aJykiCNcI=
Message-ID: <1589656023.8524.1.camel@HansenPartnership.com>
Subject: Re: [dm-devel] next-20200514 - build issue in
 drivers/md/dm-zoned-target.c
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Valdis =?UTF-8?Q?Kl=C4=93tnieks?= <valdis.kletnieks@vt.edu>,
        Hannes Reinecke <hare@suse.de>,
        Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>
Cc:     dm-devel@redhat.com, linux-kernel@vger.kernel.org
Date:   Sat, 16 May 2020 12:07:03 -0700
In-Reply-To: <367320.1589627953@turing-police>
References: <367320.1589627953@turing-police>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-Mp2dUCEd7FWpRS+D3bdZ"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-Mp2dUCEd7FWpRS+D3bdZ
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, 2020-05-16 at 07:19 -0400, Valdis Kl=C4=93tnieks wrote:
> Am seeing a build error in next-0514.  -0420 built OK.
> building a 'make allmodconfig' on a RPi4 in 32-bit mode.
>=20
>   MODPOST 7575 modules
> ERROR: modpost: "__aeabi_uldivmod" [drivers/md/dm-zoned.ko]
> undefined!
>=20
> objdump and 'make drivers/md/dm-zoned-target.s' tells
> me that the problem is in function dmz_fixup_devices(), near here:
>=20
> @ drivers/md/dm-zoned-target.c:806:             reg_dev->nr_zones =3D
> DIV_ROUND_UP(reg_dev->capacity,
>         ldr     r0, [r6, #56]   @ reg_dev_166->capacity, reg_dev_166-
> >capacity
>         adds    r1, r3, r1      @ tmp316, _227, reg_dev_166->capacity
>         adc     r0, r2, r0      @ tmp315, _227, reg_dev_166->capacity
>         subs    r1, r1, #1      @, tmp316,
> @ drivers/md/dm-zoned-target.c:805:             reg_dev-
> >zone_nr_sectors =3D zoned_dev->zone_nr_sectors;
>         strd    r2, [r6, #80]   @, reg_dev,
> @ drivers/md/dm-zoned-target.c:806:             reg_dev->nr_zones =3D
> DIV_ROUND_UP(reg_dev->capacity,
>         sbc     r0, r0, #0      @, tmp315,
>         bl      __aeabi_uldivmod                @
> @ drivers/md/dm-zoned-target.c:806:             reg_dev->nr_zones =3D
> DIV_ROUND_UP(reg_dev->capacity,
>         str     r1, [r6, #64]   @ tmp306, reg_dev_166->nr_zones
>=20
> git blame points at this commit:
>=20
> commit 70978208ec91d798066f4c291bc98ff914bea222
> Author: Hannes Reinecke <hare@suse.de>
> Date:   Mon May 11 10:24:30 2020 +0200
>=20
>     dm zoned: metadata version 2
>=20
> Reverting that commit lets the build complete.

That's because the DIV_ROUND_UP in the patch should actually be
DIV_ROUND_UP_SECTOR_T I think.

James

--=-Mp2dUCEd7FWpRS+D3bdZ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iHUEABMIAB0WIQTnYEDbdso9F2cI+arnQslM7pishQUCXsA51wAKCRDnQslM7pis
hZePAP9k+4pgr+O3cOw3dKCULg5dyXP0H/ovz0PjY3NwyCgqYAEA1ghh0wkxUfz4
GB4Svstsox0oy29X7rGUd/p1slLLNZM=
=2NcN
-----END PGP SIGNATURE-----

--=-Mp2dUCEd7FWpRS+D3bdZ--

