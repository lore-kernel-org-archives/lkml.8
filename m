Return-Path: <SRS0=Xj+s=AD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACBB4C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 09:59:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 86F47206F1
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 09:59:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="b7g43xmi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726841AbgFVJ7x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jun 2020 05:59:53 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:59895 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726710AbgFVJ7v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 05:59:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1592819990;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4BHHXAqs++6g+gSDQIVmyyKNCLq9QfvogN5UxkxuxLw=;
        b=b7g43xmiZn9rk1ML43hanS51czFUnpLa3FG+XeQUeGse92qAXh896DB5KW9Vgw8d08d+Fd
        fK5npXPm2TpOgzyHU+vvYuhubothiy8AKaQJIIFsWutGmBVbNJhTnvS8B2jEZ3jdKMDM1S
        29lbJBBIo9ZPtjt2Dr+LRRsjLfG57AY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-130-Nygrqms9NTiaHOXIZlTUZg-1; Mon, 22 Jun 2020 05:59:46 -0400
X-MC-Unique: Nygrqms9NTiaHOXIZlTUZg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0A008846375;
        Mon, 22 Jun 2020 09:59:45 +0000 (UTC)
Received: from localhost (ovpn-115-184.ams2.redhat.com [10.36.115.184])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5B26E5D9D5;
        Mon, 22 Jun 2020 09:59:39 +0000 (UTC)
Date:   Mon, 22 Jun 2020 10:59:38 +0100
From:   Stefan Hajnoczi <stefanha@redhat.com>
To:     Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>
Cc:     mst@redhat.com, kvm list <kvm@vger.kernel.org>,
        Stefano Garzarella <sgarzare@redhat.com>,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        Jason Wang <jasowang@redhat.com>
Subject: Re: [RFC v9 10/11] vhost/vsock: switch to the buf API
Message-ID: <20200622095938.GB6675@stefanha-x1.localdomain>
References: <20200619182302.850-1-eperezma@redhat.com>
 <20200619182302.850-11-eperezma@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200619182302.850-11-eperezma@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="UHN/qo2QbUvPLonB"
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--UHN/qo2QbUvPLonB
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 19, 2020 at 08:23:01PM +0200, Eugenio P=E9rez wrote:
> From: "Michael S. Tsirkin" <mst@redhat.com>
>=20
> A straight-forward conversion.
>=20
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> Signed-off-by: Eugenio P=E9rez <eperezma@redhat.com>
> ---
>  drivers/vhost/vsock.c | 30 ++++++++++++++++++------------
>  1 file changed, 18 insertions(+), 12 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--UHN/qo2QbUvPLonB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl7wgQoACgkQnKSrs4Gr
c8gaawf8CE0r7lmdy1n0zKbFGNwbeFg1iFtb/arJ8/pKg6QjAIlXaL2eYU04kVXV
rOn/oN0avr1ji2MKbCL0eKOV2/FpmKhN0RmT/4mvVMfB7MrT/ooruRUoUBV5FsxE
B0ET9VJG6JuUg0xbp2UP/x3QRYSLYwwTXKkc5WDJCflAAlbOJPjHjuK6Mpubgb4y
vx26gYD2lK36TulNmBjkYiiQx72PE2LyA7Ss6Fe4E/DRCzeVNoDr5XQURcYIXjZw
8x2qTEZ95YrJA/cxr36Po9hlycV4P8QHF/sj6Rq1vlTJgFHSFupE1Z21GCuz3kDV
oqun+r8WanK92bkZqA2GYM5TCvZXZg==
=+yyR
-----END PGP SIGNATURE-----

--UHN/qo2QbUvPLonB--

