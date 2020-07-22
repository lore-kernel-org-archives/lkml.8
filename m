Return-Path: <SRS0=5pK+=BB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A375C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 20:35:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0259C20709
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 20:35:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732696AbgGVUfU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jul 2020 16:35:20 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:50072 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726447AbgGVUfU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jul 2020 16:35:20 -0400
Received: from 2.general.sarnold.us.vpn ([10.172.64.71] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <seth.arnold@canonical.com>)
        id 1jyLSP-0006Dv-4C; Wed, 22 Jul 2020 20:35:17 +0000
Date:   Wed, 22 Jul 2020 20:35:14 +0000
From:   Seth Arnold <seth.arnold@canonical.com>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-kernel@vger.kernel.org, apparmor@lists.ubuntu.com
Subject: Re: [apparmor] [PATCH] security: apparmor: file.h: delete duplicated
 word
Message-ID: <20200722203514.GB84486@millbarge>
References: <20200719180835.24658-1-rdunlap@infradead.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="U+BazGySraz5kW0T"
Content-Disposition: inline
In-Reply-To: <20200719180835.24658-1-rdunlap@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--U+BazGySraz5kW0T
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jul 19, 2020 at 11:08:35AM -0700, Randy Dunlap wrote:
> Delete the doubled word "then" in a comment.
>=20
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: John Johansen <john.johansen@canonical.com>
> Cc: apparmor@lists.ubuntu.com

Reviewed-by: Seth Arnold <seth.arnold@canonical.com>

Thanks

> ---
>  security/apparmor/include/file.h |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> --- linux-next-20200717.orig/security/apparmor/include/file.h
> +++ linux-next-20200717/security/apparmor/include/file.h
> @@ -167,7 +167,7 @@ int aa_audit_file(struct aa_profile *pro
>   * @perms: permission table indexed by the matched state accept entry of=
 @dfa
>   * @trans: transition table for indexed by named x transitions
>   *
> - * File permission are determined by matching a path against @dfa and th=
en
> + * File permission are determined by matching a path against @dfa and
>   * then using the value of the accept entry for the matching state as
>   * an index into @perms.  If a named exec transition is required it is
>   * looked up in the transition table.
>=20

--U+BazGySraz5kW0T
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEQVAQ8bojyMcg37H18yFyWZ2NLpcFAl8Yov4ACgkQ8yFyWZ2N
Lped0wf7BOUDobQFJ75lulsDDZ+njuj+aWldahIGtNOsBSkxOxo8jU/yFQ3CcvOV
K1VxjYqkhxU5QhWceVFsQ8DN8ILghdb6yofJ9vfnuSgdqcifzwoHbku3Ul99hZyo
sN5MkQKlLdMsksQCWEvHvB7ofMguuHjHbsYlqPOspdMMLPOEetFzte+irh0cNUyg
T+oIcWtW9ZUZLSOzmMCM8siFK9lZ2f72zzUpiG1jHxWq9RqVivcKDXGIsvuJtBvZ
oPALNws2CAWFpwwHj217PkTwVifdPhdvT80ujs27vIim0I2bmSYBF21pYZ5K9pOW
iAA3GhT6OVL5aXhhQIA6btoyPWbsnw==
=GKRw
-----END PGP SIGNATURE-----

--U+BazGySraz5kW0T--
