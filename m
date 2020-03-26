Return-Path: <SRS0=aGSP=5L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9886CC2D0E8
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 12:24:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7280C2076A
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 12:24:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728171AbgCZMYn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Mar 2020 08:24:43 -0400
Received: from mx2.suse.de ([195.135.220.15]:58638 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727990AbgCZMYn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Mar 2020 08:24:43 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 91F3CB153;
        Thu, 26 Mar 2020 12:24:41 +0000 (UTC)
Message-ID: <24f850f64b5c71c71938110775e16caaec2811cc.camel@suse.de>
Subject: Re: [PATCH] ARM: dts: bcm283x: Use firmware PM driver for V3D
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     Stefan Wahren <stefan.wahren@i2se.com>,
        Eric Anholt <eric@anholt.net>
Cc:     wahrenst@gmx.net, devicetree@vger.kernel.org,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list <bcm-kernel-feedback-list@broadcom.com>
Date:   Thu, 26 Mar 2020 13:24:39 +0100
In-Reply-To: <20200303173217.3987-1-nsaenzjulienne@suse.de>
References: <20200303173217.3987-1-nsaenzjulienne@suse.de>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-d7LQKba6+yuwYb7BdPgp"
User-Agent: Evolution 3.34.4 
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-d7LQKba6+yuwYb7BdPgp
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Stefan and Florian,

On Tue, 2020-03-03 at 18:32 +0100, Nicolas Saenz Julienne wrote:
> The register based driver turned out to be unstable, specially on RPi3a+
> but not limited to it. While a fix is being worked on, we roll back to
> using firmware based scheme.
>=20
> Fixes: e1dc2b2e1bef ("ARM: bcm283x: Switch V3D over to using the PM drive=
r
> instead of firmware")
> Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
> ---

now that the problem Stefan was seeing is being taken care of, I think it's
fair to reconsider taking this patch. Maybe even adding a Tested-by by Stef=
an?

Regards,
Nicolas


--=-d7LQKba6+yuwYb7BdPgp
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEErOkkGDHCg2EbPcGjlfZmHno8x/4FAl58nwcACgkQlfZmHno8
x/5rvAf+LW4zqdNAw+skEf7gLWSz8i+ghmc3P0YNFupl4fEuGA62RCruBfIx7zSM
YKS3V9/dAqd4on3dweqB/7/mixPvF/lLbLDpF0AvDySg+dkItI6QhXIcfKCiFWzP
Dyd2w32POGUKljy0gsgRBgxebQ4+bPaDgyTlMnaSnlux7+IDOH9Vr1v4YamYE7N7
9EdGV6fTuib7iOWvkfXmWQoE9Gj0RCoJQ+dGbopRkuAJ9Jng4tqrRy5hHh7Us+2P
u1IpuzS9e2xHRaVSanhkzHqQv9s9Kd0Q0+pqnXwa5//nvuaz8kxWotQl7MMEQ0nV
IaL3nI09Wexdg+FaH1f9grkdodD8pQ==
=TDc9
-----END PGP SIGNATURE-----

--=-d7LQKba6+yuwYb7BdPgp--

