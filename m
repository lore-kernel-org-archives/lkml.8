Return-Path: <SRS0=4orP=BD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6B9EC433E5
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 13:14:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A66812074F
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 13:14:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="crDQbd0+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727044AbgGXNOl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jul 2020 09:14:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726753AbgGXNOj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jul 2020 09:14:39 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 443B0C0619D3
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jul 2020 06:14:39 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id gc15so5842776pjb.0
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jul 2020 06:14:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:mime-version:content-disposition;
        bh=reMLRYlsYVkeM3mrx5IDn5+pquZ2PKUwq+BgQPeb0uE=;
        b=crDQbd0+Ra2ZheXq/4azXw+hYoYrjbQc11JsdCvANLDkTf8DoL96/OEeSL8+HTgJyp
         obQoiSet+rGZ5/JCo5sQjNwikd+TQoTXPDj6DYpCjt+AXr5HzOxgUh47x6T1EbancBVZ
         OtIxxi0ifmL/i5lXyyfgOM3H3BEi+P+qKvC9xRdwAw5wVN7tbHB1AtdYIpDYmmBZOQDu
         WcGFGUu4OKOgNhwSza5ek1VTyABtHAIpiQlnrobhnpix4OlG5C7NIu+KjAVRxJql74Bw
         YQvbFZs6L40npUAtmGjF2eNaCkV4tQ3OON9gl9TPam67WRwhRpJ17ZW6WDfq9x1qLJ13
         0KFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition;
        bh=reMLRYlsYVkeM3mrx5IDn5+pquZ2PKUwq+BgQPeb0uE=;
        b=q8vrwmQ0k73jdS0ZmAY53JlapzaDsWGpjkmscLlQyMUz1dFLIsaAgX3msqc7ccCU2x
         bpOfWnrilKGxgURSMqHIBznwQJ+HlOJXhgWJZ+zuk3yxFxaay3/OgKIhYII7YN2BTk4n
         GOYaGsndaTbzBiz43jIbR8y/5xvDThinLbDuPK8owDCbBFa5It5nIfCYCGBJTnbW+fQl
         RSsfXyYVTFzFo+/NcathshMKQ8j289rWSC6a2XEHfqI2WgSKV/lDn8iw7lhZsD/NwKLK
         wTuOnt3Rf0eXfKm57ns9BSfaDB+u/H/q637J9sGUkcdrRn9N6XAor2N40TkZmqVO3YHQ
         WzWg==
X-Gm-Message-State: AOAM532fv+vBIrpINWRLZSF+ElOXGY0CwC9jaFU9jm34CpdIsFbNrgK8
        vEjmjTflG/NG9AVrA9EcTtQ=
X-Google-Smtp-Source: ABdhPJzo6r4cVg9XFVnSSmhDLOnaM7HNU6jJzG2pIvwWmMAoLkD6y9qFg/71rcuEhHlZbvrnAbdtZw==
X-Received: by 2002:a17:90a:1089:: with SMTP id c9mr5403159pja.180.1595596478783;
        Fri, 24 Jul 2020 06:14:38 -0700 (PDT)
Received: from localhost ([1.22.41.181])
        by smtp.gmail.com with ESMTPSA id 66sm6600458pfg.63.2020.07.24.06.14.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jul 2020 06:14:37 -0700 (PDT)
Date:   Fri, 24 Jul 2020 18:44:33 +0530
From:   Mrinal Pandey <mrinalmni@gmail.com>
To:     gregkh@linuxfoundation.org, arve@android.com, tkjos@android.com,
        maco@android.com, joel@joelfernandes.org, christian@brauner.io,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        mrinalmni@gmail.com
Subject: [PATCH 5/6] drivers: android: Fix a variable declaration coding
 style issue
Message-ID: <20200724131433.stf3ycooogawyzb3@mrinalpandey>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="grqqnbefsvlkzzvh"
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--grqqnbefsvlkzzvh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Add a blank line after variable declarations as suggested by checkpatch.

Signed-off-by: Mrinal Pandey <mrinalmni@gmail.com>
---
 drivers/android/binderfs.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/android/binderfs.c b/drivers/android/binderfs.c
index 7cf566aafe1f..8a98a36ff71a 100644
--- a/drivers/android/binderfs.c
+++ b/drivers/android/binderfs.c
@@ -351,6 +351,7 @@ static const struct super_operations binderfs_super_ops=
 =3D {
 static inline bool is_binderfs_control_device(const struct dentry *dentry)
 {
 	struct binderfs_info *info =3D dentry->d_sb->s_fs_info;
+
 	return info->control_dentry =3D=3D dentry;
 }
=20
--=20
2.25.1


--grqqnbefsvlkzzvh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE8DwCG1PwaC2uTI99xIwpEWwxhGQFAl8a3rkACgkQxIwpEWwx
hGTS3hAAnBoTVKJZTQYY6H7ngmGccBbE4quqljqUD8/0UyfwOCH91x3Py9M35U09
DeDH2opW3cJn3boASkps0OuDsd8Eizte2DOxVnvzcFgszkty6XLxzfuaNQnywx55
6HVPITlom5YCCV/gi1bJUBtbeTHzy9ILb3NXeycgiZua5aq9EwFqKNJaoHAtPGrT
B6QCkNAw1hrfvCd5bgqxOgO0ODgMbOL1w/MTnbobUHKeTrLPgKQyZpEsvTBPfJfa
8Swbmf7Wp3QNk/RJSVsHQOsOH7elK6P4ApGrAveoU/SSa9JU49G40ENHeuPDe9K+
cTStZkaX8sO48xRxB/yLwUyGbR0E/MRbKxI4BA699fMGOIeDnNN762lr8bZoRAkg
RUMkH7eQUgnAAsnUl3P/Mk1Wa1d4TlIdmnAeNFsa7CKxnMISGtQr/Wg6uE1guAbU
HvcZ1CzYmy8w2o/C4jJam3F+VymG2rtpskcLmnH7rpTLWtJGu3+oOULX/d04ordD
qCQaVuZmeg1268/RFaRICNN6oycEI3bZc8thGzmrH6YD1V9b5hoRBUo30tFJ+7Tf
ner0nESJWLg29oeEzPVeOklqh/2gLsCrIXq/doM3VMJm7RS99cgudjWYZayaO0xB
Ms4I19LgSIjj61avbj28nEJODFpAi+BYdZgcLBz7DiC4iR8wYpk=
=GUIX
-----END PGP SIGNATURE-----

--grqqnbefsvlkzzvh--
