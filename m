Return-Path: <SRS0=r24B=6M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53412C83007
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 08:58:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 22BE8206B9
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 08:58:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Mj22WkJv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726941AbgD1I6Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Apr 2020 04:58:24 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:46308 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726271AbgD1I6Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 04:58:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588064302;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=MSDgdnKSujnY//yD1HvV2piAr94GHY+9CGMl9fk7zQM=;
        b=Mj22WkJvTIE7scp/7KIjnoDRPQQPtRVbuz2ezdL/WevrhyhZ+BJF+pSvZB05kWywMj6mQz
        pn64hNRD6Y6QFnAeDwLmVEptR+59/oJzohhY6oqK1FoqhKjJdU7AZMmCvbfdpgx0LBUfr7
        JbQH9pkpULhvi42uRGSAk2HNPxCEBas=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-483-zdg8qOnLOAGsW_CKHY6-2g-1; Tue, 28 Apr 2020 04:58:19 -0400
X-MC-Unique: zdg8qOnLOAGsW_CKHY6-2g-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 71AE380B70B;
        Tue, 28 Apr 2020 08:58:18 +0000 (UTC)
Received: from localhost (ovpn-115-22.ams2.redhat.com [10.36.115.22])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 036725C1D6;
        Tue, 28 Apr 2020 08:58:17 +0000 (UTC)
Date:   Tue, 28 Apr 2020 09:58:16 +0100
From:   Stefan Hajnoczi <stefanha@redhat.com>
To:     linux-security-module@vger.kernel.org
Cc:     Serge Hallyn <serge@hallyn.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] capabilities: add description for CAP_SETFCAP
Message-ID: <20200428085816.GD15547@stefanha-x1.localdomain>
References: <20200414154945.142372-1-stefanha@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200414154945.142372-1-stefanha@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="SFyWQ0h3ruR435lw"
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--SFyWQ0h3ruR435lw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 14, 2020 at 04:49:45PM +0100, Stefan Hajnoczi wrote:
> Document the purpose of CAP_SETFCAP.  For some reason this capability
> had no description while the others did.
>=20
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>  include/uapi/linux/capability.h | 2 ++
>  1 file changed, 2 insertions(+)

Ping?

> diff --git a/include/uapi/linux/capability.h b/include/uapi/linux/capabil=
ity.h
> index 272dc69fa080..7288f0ad44af 100644
> --- a/include/uapi/linux/capability.h
> +++ b/include/uapi/linux/capability.h
> @@ -332,6 +332,8 @@ struct vfs_ns_cap_data {
> =20
>  #define CAP_AUDIT_CONTROL    30
> =20
> +/* Set or remove capabilities on files */
> +
>  #define CAP_SETFCAP=09     31
> =20
>  /* Override MAC access.
> --=20
> 2.25.1
>=20

--SFyWQ0h3ruR435lw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl6n8CgACgkQnKSrs4Gr
c8hi2wgAubzNWtaI/6UtRD/UgJdcttBom290aRYYObm7RbnjNN+9TCoTYM8Ymrat
LebHR9o/Gg1BRwmufr3QZG5iTDPS090gQ1e1azlQY1nhS7WQ1nreNN3wMq/QwPud
S1P9+KNqCHwMA8RdgOL2A4xxKKqdG0xg8Pv0xum2HkqI4xqYts6iESgLKQ2BR4xt
8/6orr5eZD8HRbaNkJtMhmaUrb8I+jm4rsV+yIRvEIFiiw2ontHO9K0Kviwaa+Ah
995oGJ4nn3YRnJKBF2h412K04a0SNMYhsMTSzn58xaq6EKPTfIcPkfGx1zmupD2Z
rQxy1S8MSVFqiWwmwvxfEdLHnWm2cA==
=jd69
-----END PGP SIGNATURE-----

--SFyWQ0h3ruR435lw--

