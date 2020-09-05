Return-Path: <SRS0=flm+=CO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E8EDC2BB84
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Sep 2020 01:17:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5CB7520797
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Sep 2020 01:17:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GA6rJ2om"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728215AbgIEBRc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Sep 2020 21:17:32 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:30404 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726208AbgIEBRb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Sep 2020 21:17:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1599268648;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4aGpilxaerC14wsyR+bT51+0hex+4rvMfDw3FNxSr/o=;
        b=GA6rJ2omS31VW78BmUkuRqWHAU0bJYeLG+AZDfGo4LjhgL1pop7arbznZPbjzrxqWvBCYZ
        y3E+IIjrjl3AP+Az2XkdJioDeHxLTROsaPeAxiccL8JcbKKlwneF/NOQOtxfxFKQdQCusk
        HxJtvc70iuq6znhuJtDjkaFVwzKi6ZM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-18-YPxao6oPNwSOx2QwNdRLFA-1; Fri, 04 Sep 2020 21:17:25 -0400
X-MC-Unique: YPxao6oPNwSOx2QwNdRLFA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E247E801ABB;
        Sat,  5 Sep 2020 01:17:23 +0000 (UTC)
Received: from localhost (ovpn-116-18.gru2.redhat.com [10.97.116.18])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4B3CC7E172;
        Sat,  5 Sep 2020 01:17:22 +0000 (UTC)
Date:   Fri, 4 Sep 2020 22:17:21 -0300
From:   Bruno Meneguele <bmeneg@redhat.com>
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/4] ima: limit secure boot feedback scope for appraise
Message-ID: <20200905011721.GA3225@heredoc.io>
References: <20200904194100.761848-1-bmeneg@redhat.com>
 <20200904194100.761848-4-bmeneg@redhat.com>
 <f6b04ff269d3f5f72ee6b005bb97e6ac7b73b43e.camel@linux.ibm.com>
MIME-Version: 1.0
In-Reply-To: <f6b04ff269d3f5f72ee6b005bb97e6ac7b73b43e.camel@linux.ibm.com>
X-PGP-Key: http://keys.gnupg.net/pks/lookup?op=get&search=0x3823031E4660608D
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=bmeneg@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="RnlQjJ0d97Da+TV1"
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--RnlQjJ0d97Da+TV1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 04, 2020 at 05:07:08PM -0400, Mimi Zohar wrote:
> Hi Bruno,
>=20
> > +=09bool sb_state =3D arch_ima_get_secureboot();
> > +=09int appraisal_state =3D ima_appraise;
> > =20
> >  =09if (strncmp(str, "off", 3) =3D=3D 0)
> > -=09=09ima_appraise =3D 0;
> > +=09=09appraisal_state =3D 0;
> >  =09else if (strncmp(str, "log", 3) =3D=3D 0)
> > -=09=09ima_appraise =3D IMA_APPRAISE_LOG;
> > +=09=09appraisal_state =3D IMA_APPRAISE_LOG;
> >  =09else if (strncmp(str, "fix", 3) =3D=3D 0)
> > -=09=09ima_appraise =3D IMA_APPRAISE_FIX;
> > +=09=09appraisal_state =3D IMA_APPRAISE_FIX;
> >  =09else if (strncmp(str, "enforce", 7) =3D=3D 0)
> > -=09=09ima_appraise =3D IMA_APPRAISE_ENFORCE;
> > +=09=09appraisal_state =3D IMA_APPRAISE_ENFORCE;
> >  =09else
> >  =09=09pr_err("invalid \"%s\" appraise option", str);
> > +
> > +=09/* If appraisal state was changed, but secure boot is enabled,
> > +=09 * keep its default */
> > +=09if (sb_state) {
> > +=09=09if (!(appraisal_state & IMA_APPRAISE_ENFORCE))
> > +=09=09=09pr_info("Secure boot enabled: ignoring ima_appraise=3D%s opti=
on",
> > +=09=09=09=09str);
> > +=09=09else
> > +=09=09=09ima_appraise =3D appraisal_state;
> > +=09}
>=20
> Shouldn't the "else" clause be here.   No need to re-post the entire
> patch set.

Yes, of course it should.
Sorry. Sending the v3 for this patch.

>=20
> thanks,
>=20
> Mimi
>=20
> >  #endif
> >  =09return 1;
> >  }
>=20
>=20

--=20
bmeneg=20
PGP Key: http://bmeneg.com/pubkey.txt

--RnlQjJ0d97Da+TV1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEdWo6nTbnZdbDmXutYdRkFR+RokMFAl9S5yEACgkQYdRkFR+R
okNAUwf/WI2YetZ8RfPxdxORcOb8c5C7o273T+FLI2XG3nOWiFDVsuCVQxwEAmcC
JqehdVUEMAaNn0jKC6GuaWOFWPo0DugT0suZMDZlZp1zofi4scTF4iD66IagnPx8
riIIOHTCRL/VD9I4emM0GKQu7kSNgO82zVbGi5k8d+ah3bboCR3AmQmk3uHMLAfW
nPViQLetn2KQVjYnVT4ISgpOIJNmeOXmMYPLUNDFexaMqOnCZBi8DLE7xEyv5NOu
gzwSMrVKuyi9lakjyWaVE5L500DI7kOZ/YUvP7YK2xxXTfjk8BG8LoFr72O/WxhG
/HYYZcwkbIxa0xeThLSlg8IojURQ1Q==
=OXdZ
-----END PGP SIGNATURE-----

--RnlQjJ0d97Da+TV1--

