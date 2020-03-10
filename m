Return-Path: <SRS0=K2g5=43=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A345C18E5B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 10:53:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D390F222D9
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 10:53:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="V/wfIIxB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726436AbgCJKx2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 06:53:28 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:40350 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725937AbgCJKx2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 06:53:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1583837607;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=QcfSUQMFok+AcNi7dQXtsoDmhCrnzMZSnlpXGMmh0d0=;
        b=V/wfIIxBi2ApJ0FD/azYXs1ZB5cY/CLh59FovnQ/BvvQD47H1iNPcN7vBf3I7MxhyIRMU5
        gKsQegdKyDdCC3+XIc87qhQNS0VVesABO0AYe6GtuQnEe9/THYA2+8cHM+81lQiJw8wJFV
        QlGeVXHr6BvyOZXGNXLUiaTOMP5tzxU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-167-8uj9hiuuPPGN9Y84CP11UA-1; Tue, 10 Mar 2020 06:53:23 -0400
X-MC-Unique: 8uj9hiuuPPGN9Y84CP11UA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 750F518FE860;
        Tue, 10 Mar 2020 10:53:21 +0000 (UTC)
Received: from localhost (unknown [10.36.118.73])
        by smtp.corp.redhat.com (Postfix) with ESMTP id DA367909E9;
        Tue, 10 Mar 2020 10:53:15 +0000 (UTC)
Date:   Tue, 10 Mar 2020 10:53:14 +0000
From:   Stefan Hajnoczi <stefanha@redhat.com>
To:     Vivek Goyal <vgoyal@redhat.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nvdimm@lists.01.org, virtio-fs@redhat.com, miklos@szeredi.hu,
        dgilbert@redhat.com, mst@redhat.com,
        Sebastien Boeuf <sebastien.boeuf@intel.com>
Subject: Re: [PATCH 03/20] virtio: Add get_shm_region method
Message-ID: <20200310105314.GH140737@stefanha-x1.localdomain>
References: <20200304165845.3081-1-vgoyal@redhat.com>
 <20200304165845.3081-4-vgoyal@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200304165845.3081-4-vgoyal@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="poemUeGtc2GQvHuH"
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--poemUeGtc2GQvHuH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 04, 2020 at 11:58:28AM -0500, Vivek Goyal wrote:
> From: Sebastien Boeuf <sebastien.boeuf@intel.com>
>=20
> Virtio defines 'shared memory regions' that provide a continuously
> shared region between the host and guest.
>=20
> Provide a method to find a particular region on a device.
>=20
> Signed-off-by: Sebastien Boeuf <sebastien.boeuf@intel.com>
> Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> ---
>  include/linux/virtio_config.h | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--poemUeGtc2GQvHuH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl5ncZoACgkQnKSrs4Gr
c8jg6gf/SZPcTN7LLKRqnGxHpVb154voV9YMHZaHBKN3vnrXZ/Ea+UHdkyY5QADv
1HY5kbzIGy9+ACo9dYF7RX+TuinFOlr+r5jN3n7IucAg0tpW4TgOk6zpgA78e9lm
mO+nsBaEiHuhUuon5GUa93qEog7TEWFWJdvcPvVzMqZ2Lgn6GWHiREjWIjET8IUW
toe4/8fig7Co7AvRXossbQVGQy6JO0b77Fe1KkrhIGnFm1CCa40cgb9SQWqgZgx+
H8MqAl8thKLsKsusSCvvypkZnO4WI7I7bfQ8y91OFS6eH+TyOjWeCnE92hTIXNxs
ADjNRLTsQ8amVAZxTD9jyKsF+tsOFA==
=Eh/9
-----END PGP SIGNATURE-----

--poemUeGtc2GQvHuH--

