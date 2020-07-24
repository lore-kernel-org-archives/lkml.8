Return-Path: <SRS0=4orP=BD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8820BC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 13:15:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6243720714
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 13:15:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tL4mCyjd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727782AbgGXNPA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jul 2020 09:15:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727085AbgGXNOz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jul 2020 09:14:55 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49CB3C0619D3
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jul 2020 06:14:55 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id f185so155352pfg.10
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jul 2020 06:14:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:mime-version:content-disposition;
        bh=Nit0NnPmCNNlebQQdy2f4H1BvnX3IyziXDcDUEve7ZE=;
        b=tL4mCyjdrhqL+vhLgZx3IoyjYCPak1l0yCsxVJJMJD46G/apTkoyzVqHcSuIEHQ5PX
         KS+g9aizILE/96lLa01H/PgF/nPuvolx5lYFXRUsdqNA/t4vXft4j9GAigBRJQruALN8
         6Xq4YMvuhRcV6fPPCIhKdVSFmibF0OmZNaVr0qhQpzoDVJHjrhlfJJwYsoAWk8ztZeMT
         5j4YMve59l3cJGjK18T7EDTSItm2Q22+E3z2f4TmQQ92srUk8wtqXcuAh0ptSolLkOvw
         ZrRojXmw/VOVgTJLt/+grM+e+dyxyd9LYphkrRCAfbT0b38j1Cyutlae7k+Q8mVAye1g
         AlYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition;
        bh=Nit0NnPmCNNlebQQdy2f4H1BvnX3IyziXDcDUEve7ZE=;
        b=MLSFExO/PG7JwGoB+BZjAff65APSTTtwXbS84LSSOBjkwJwfMnYymh+vHeGYzzpTcD
         IGcFoaypPgkMvhM32s2NCm9c/VbDfAGis7B+c6ooBlRnMXV3FnEcQaUok3ACN9o8wRbG
         e8CnOOn5D3qjK7XJmH/S/9cLMXfxYHY+TJmXNlFfuxMjFbjp01MBydzOnmZelcwnl0xq
         AnVp7OHhinQpEbTpb47/Ab+ULFqN7dWv5XpaJmdz4p9zUmfyREPP3eLKAojoIH/w8awQ
         vQmZyIu1NzBp+v3Ej2wvlKdVEekUgdD+4M1P4jzRHAQ5SW5Piy5HfnyQN4v79h/5ANUB
         QsPg==
X-Gm-Message-State: AOAM533s4nv5mgMiowtIa6F/eDLD6S43IeR3FaiDvc4xiwBZ4kjW3JcU
        k24byF9k2QuT0En7z3p5EA8=
X-Google-Smtp-Source: ABdhPJwfoJqjs2vuQkHsJq/jeaTMMrtFZg4TEc5MLQyXYy6rOXOpJG//k9jRmuYbugA5lryOpdcmmQ==
X-Received: by 2002:a63:f814:: with SMTP id n20mr8203259pgh.92.1595596494738;
        Fri, 24 Jul 2020 06:14:54 -0700 (PDT)
Received: from localhost ([1.22.41.181])
        by smtp.gmail.com with ESMTPSA id b21sm6501633pfb.45.2020.07.24.06.14.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jul 2020 06:14:54 -0700 (PDT)
Date:   Fri, 24 Jul 2020 18:44:49 +0530
From:   Mrinal Pandey <mrinalmni@gmail.com>
To:     gregkh@linuxfoundation.org, arve@android.com, tkjos@android.com,
        maco@android.com, joel@joelfernandes.org, christian@brauner.io,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        mrinalmni@gmail.com
Subject: [PATCH 6/6] drivers: android: Fix the SPDX comment style
Message-ID: <20200724131449.zvjutbemg3vqhrzh@mrinalpandey>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="76felxngyahx4fmv"
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--76felxngyahx4fmv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

C source files should have `//` as SPDX comment and not `/**/`. Fix this
by running checkpatch on the file.

Signed-off-by: Mrinal Pandey <mrinalmni@gmail.com>
---
 drivers/android/binderfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/android/binderfs.c b/drivers/android/binderfs.c
index 8a98a36ff71a..4eada4dc232f 100644
--- a/drivers/android/binderfs.c
+++ b/drivers/android/binderfs.c
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: GPL-2.0 */
+// SPDX-License-Identifier: GPL-2.0
=20
 #include <linux/compiler_types.h>
 #include <linux/errno.h>
--=20
2.25.1


--76felxngyahx4fmv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE8DwCG1PwaC2uTI99xIwpEWwxhGQFAl8a3skACgkQxIwpEWwx
hGRgHw/+LIkaOIms9WecmHC1athhjWoFfmjy7JN2I/NyANmFfUbBtL/aAea868Dw
s48fTyq+sd6WpALiPiaCgD56cI878vH7H98qsm3FqYm76uZ/wzl6fKorIhAdJBy3
OyPj7j+8IEfDA/fBHxTYkGNpDY4gQET2nrgAqAqjaxih32tKrM7CI8FzkNPMiejL
m9pRZGV4tw2cdqMgUhtaEsQFsonAiJy+VnrUNGS9yylNGzLSeBi/CnwueSDo0Nu5
97YGWb6p9ck5Gs4FHgCxXgO8p3dvu29wVCaU7FjhRgvfv0DsFjEtlT2/kt3rtQJg
nPgOa6oljuPMiPGupFVXxI827PQJL+ASsF0sQD2VIpOBX6L79qXbF5DIpHTXrxCO
jbW5+fO6Eg1Bglj/D0QDY4QFqGDr/o9UzhOqLGtYP/efxK+5noHLaPWB4d7ps4uB
46jH0vJ/GxHwn8y+5ycXqAaujxznZIR5FPMXVP9TKs0ZjDwB6/Itg30HozynWRT9
E17uLXhUlWMri2EbPAabMiJCRe4IBwj34MCqAFrDwRNxfzIWhN5clLL01MnQdok2
SuERXVT4215iJpDRRrsyUaKo7iE4ebDa5MsSQTWoMktgg2CrtCSUB8fwPlAyPo3M
NoLo65uZ17ZwWuGvKtXQLSBEv5T5FswajawIVGkXpouWBtB/AdQ=
=8dgS
-----END PGP SIGNATURE-----

--76felxngyahx4fmv--
