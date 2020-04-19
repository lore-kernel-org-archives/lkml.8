Return-Path: <SRS0=L1Qp=6D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DED81C38A30
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Apr 2020 14:55:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A4D4E21841
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Apr 2020 14:55:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bonedaddy.net header.i=@bonedaddy.net header.b="iPFIDk3E"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726476AbgDSOzS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 Apr 2020 10:55:18 -0400
Received: from smtp.bonedaddy.net ([45.33.94.42]:48512 "EHLO
        smtp.bonedaddy.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726398AbgDSOzR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Apr 2020 10:55:17 -0400
X-Greylist: delayed 415 seconds by postgrey-1.27 at vger.kernel.org; Sun, 19 Apr 2020 10:55:17 EDT
Received: from chianamo (n58-108-4-64.per1.wa.optusnet.com.au [58.108.4.64])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: pabs3@bonedaddy.net)
        by smtp.bonedaddy.net (Postfix) with ESMTPSA id 53E19180043;
        Sun, 19 Apr 2020 10:48:20 -0400 (EDT)
Authentication-Results: smtp.bonedaddy.net; dmarc=fail (p=none dis=none) header.from=bonedaddy.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bonedaddy.net;
        s=mail; t=1587307702;
        bh=orbOLhLh68VHjj9KoqAE/l3nV665NUdq1aidfrkBWoc=;
        h=Subject:From:To:Cc:In-Reply-To:References:Date;
        b=iPFIDk3EJOmtIhN/wwEuJ3N6eojbUPY3vQsC1Ifs6qYznwpDvqeXYxrtmphy2pFne
         ALFR6r0IIAOxwEFgW8OiAmcd65jSDecQ1LVFgwoG7/sU23RqQAhtR9S4txVRxGmlRN
         aRzeeUMvgBWkIoxb2qcx3Hhc4Skoz8m+YxVtbI2QRxPlfqVI8x16RUm4HLBASs/UNn
         Cq6ZmzsT0Y5sHM3guS27QOOAfvgyzUsozGfYYTLrXJEg1PUOzxCdk0U9SgmyXDHKsd
         7Zq1JnSQjGxv5Ihn9Qkv4IeuoayStdAGYAuSf5FL2HCGVxexserZzgPeeV3Gdfy3M1
         w7yfjY+L8cdhg==
Message-ID: <9cb6a39a43178be29af2f47a92c2e84754b62b69.camel@bonedaddy.net>
Subject: Re: [PATCH 0/3] dm raid/raid1: enable discard support when any
 devices support discard
From:   Paul Wise <pabs3@bonedaddy.net>
To:     Mike Snitzer <snitzer@redhat.com>
Cc:     Alasdair Kergon <agk@redhat.com>, dm-devel@redhat.com,
        linux-kernel@vger.kernel.org
In-Reply-To: <20200419131908.GA22398@redhat.com>
References: <20200419073026.197967-1-pabs3@bonedaddy.net>
         <20200419131908.GA22398@redhat.com>
Content-Type: multipart/signed; micalg="pgp-sha512";
        protocol="application/pgp-signature"; boundary="=-Dc6DoNjKBj0aUd9iYgmL"
Date:   Sun, 19 Apr 2020 22:48:16 +0800
MIME-Version: 1.0
User-Agent: Evolution 3.36.1-1 
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-Dc6DoNjKBj0aUd9iYgmL
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, 2020-04-19 at 09:19 -0400, Mike Snitzer wrote:

> You went overboard with implementation before checking to see if your
> work would be well received.  Your 2/3 patch header shows you're
> capable of analyzing past commits to explain the evolution of code,
> etc.  But yet you make no mention of this commit header which explicitly
> speaks to why what you're proposing is _not_ acceptable:
>=20
> commit 8a74d29d541cd86569139c6f3f44b2d210458071
> Author: Mike Snitzer <snitzer@redhat.com>
> Date:   Tue Nov 14 15:40:52 2017 -0500
>=20
>     dm: discard support requires all targets in a table support discards

I do remember seeing this commit while working on this, I guess I
ignored it in my attempts to get fstrim working on my rootfs, woops.

> I haven't looked closely at MD raid in this area but if you trully think
> underlying MD raid can cope with issuing discards to devices that don't
> support them (or that it avoids issuing them?) then please update
> dm-raid.c to conditionally set ti->discard_supported (if not all devices
> support discard).  That is how to inform DM core that the target knows
> better and it will manage discards issued to it.  It keeps the change
> local to dm-raid.c without the flag-day you're proposing.

On my system I have a HDD and an SSD, with /boot on MD RAID and / on
ext4 on DM RAID on 2 DM crypt volumes. In this setup fstrim works on
/boot but does not work on / and with my patches it works on / again.
In addition I don't see any messages in dmesg or other issues when
doing fstrim / with my patches.

I think I might have been worried that discards_supported has other
side effects but grepping the code now I see that was unfounded.
I'll switch the next version to just setting discards_supported.
I still think that my proposed overboard design is clearer though :)

You'll see from the following command that MD raid 0/1/10 arrays enable
discards when any device supports discards:

   git grep -wW discard_supported

It appears that the block layer ignores discard requests when the queue
for the block device indicates that discard is not supported on it:

   git grep -wW __blkdev_issue_discard

It seems to me that where possible DM/MD letting the block layer decide
to pass on or ignore discard requests is the right design. I'm possibly
incorrectly assuming that all block device drivers will correctly
advertise support for discard without false positive/negatives.

BTW, any idea where I should fix the `fstrim --fstab` issue? It is
expecting the queue/discard_granularity sysfs entry to be non-zero.
=46rom my initial debugging attempts it seems raid_io_hints is at fault.

Thanks for your initial response and any further insight you can give.

--=20
bye,
pabs

https://bonedaddy.net/pabs3/

--=-Dc6DoNjKBj0aUd9iYgmL
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEYQsotVz8/kXqG1Y7MRa6Xp/6aaMFAl6cZLAACgkQMRa6Xp/6
aaPZ+w/+NU6azXlrvR0spHz7eK7FaXlJcaVAVePc+ZeKnZzByER1yKehAzkvM+XP
dJ5NsJO/S5IugiM2F7QVPAx2/eOcYOcchAnE0SBKOv/y4IK5RLa0z6d/+WzzSbFc
JCcrvuTZBmTaVfkFpkCXbAjtpqAW1kasRFF8iz4R84TrszNfjVG3zhs50GQld3pU
VIvTctdmLdY7hVbUBLSgOEoRqz5ikPq+h3YRo99uCXF3RrZ6mb9tS/Ngxn9+HNu6
1hzsIyHIesXR9C2s3r7ZVEQ3Vbm4RIjpIBS1DC4R8koaFofRumo8VLZw+K6VEnfD
ni7nktV62Hd9S+bepuYrk6Ca5N8SdbwBC8lJBIqoESRuM3uIxgxgoKxfsPhAYTOc
7D9ksk4Uc7qZ+VdvFfAnbXaHl45PfLTNsg52ANfz4CCnJLGYhRKmjg9nXkqZKCcM
uuvrCey4trHMpdE77KEuLRVWm+4RXEWpEmAQ4RIOgK+3Q4pzRWJM5tHAkcCJjTCc
5LOIuT1oBKyx7y3XeLmPTfhliZFr3USjmDZtCorw5Z+tT4d4GEElfL4+x+3T9y6w
MAaxMZ9qHQDnzvhhIZfqRne4OrmDJqaanqxI5PYwjtYBbDKNW3EnTZJUUB1h8Vph
k8oMt5TBpBexc7TXuty8W9wiVgQzsgEcthDcNBBX8sPz5y/Gf/o=
=enD1
-----END PGP SIGNATURE-----

--=-Dc6DoNjKBj0aUd9iYgmL--

