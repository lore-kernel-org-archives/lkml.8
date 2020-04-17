Return-Path: <SRS0=3W8M=6B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C67AC38A2B
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 16:50:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7515220771
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 16:50:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726775AbgDQQuS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Apr 2020 12:50:18 -0400
Received: from mx2.suse.de ([195.135.220.15]:41074 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726644AbgDQQuS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Apr 2020 12:50:18 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id C267DAB5C;
        Fri, 17 Apr 2020 16:50:15 +0000 (UTC)
Message-ID: <6c9db8d92b6702bc5d7b238788e3cb3cf7ab2486.camel@suse.de>
Subject: Re: [PATCH v1] of: property: Don't retry device_link_add() upon
 failure
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     Saravana Kannan <saravanak@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        kernel-team@android.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Fri, 17 Apr 2020 18:50:07 +0200
In-Reply-To: <20200416205838.161894-1-saravanak@google.com>
References: <20200416205838.161894-1-saravanak@google.com>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-S4qEB5rg9v9YAAE0ijXu"
User-Agent: Evolution 3.34.4 
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-S4qEB5rg9v9YAAE0ijXu
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2020-04-16 at 13:58 -0700, Saravana Kannan wrote:
> When of_link_to_phandle() was implemented initially, there was no way to
> tell if device_link_add() was failing because the supplier device hasn't
> been parsed yet, hasn't been added yet, the links were creating a cycle,
> etc. Some of these were transient errors that'd go away at a later
> point.
>=20
> However, with the current set of improved checks, if device_link_add()
> fails, it'll only be for permanent errors like cycles or out-of-memory
> errors.
>=20
> Also, with the addition of DL_FLAG_SYNC_STATE_ONLY flag [1] to device
> links, all the valid dependency cycles due to "proxy" device links
> (needed for correctness of sync_state() device callback) will never fail
> device_link_add() due to cycles.
>=20
> So, continuing to retry failing device links (by returning -EAGAIN) is
> no longer useful. At worst, it prevents platforms from setting
> fw_devlink=3Don (or better) because it prevents proper boot up. So, let's
> not do that anymore.
>=20
> [1] -=20
> https://lore.kernel.org/lkml/20191028220027.251605-1-saravanak@google.com=
/
> Cc: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Saravana Kannan <saravanak@google.com>
> ---

Tested-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>

Thanks!
Nicolas


--=-S4qEB5rg9v9YAAE0ijXu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEErOkkGDHCg2EbPcGjlfZmHno8x/4FAl6Z3j8ACgkQlfZmHno8
x/56ywf/TnZ5z9lUBQeAu4oZSHk+zFvjHHD622iRbKSt3mLE28iB56jZKk8T9kFh
SF24OokLgQyz7i2uQAaSZN+VMPruhb0Bga+9Q1uvefP6r7PuCeL/SzexyPEpwQ7/
Muf8KHm/wbvmzP86IsNCzqwHXivgGVBDaOItYuxoHML5T8tayXtALitYxOHfdY26
aDYjubdI6tPjSiXnJbP3JbWKKiZejOsvLgmCCfBJQADEPIY7Y0DqafgcB3+pQMBp
PUs+v4nAFD0q82W5TiEVG7lJp33CVw01PMdEBa9V/3XLGb7ANNsmqgHI10vrhKa+
pgOhyX+asj0kBaFGhikG8d8ArM91lg==
=Q//f
-----END PGP SIGNATURE-----

--=-S4qEB5rg9v9YAAE0ijXu--

