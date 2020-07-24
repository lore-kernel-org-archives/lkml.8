Return-Path: <SRS0=4orP=BD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D030FC433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 13:13:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A8090206D7
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 13:13:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G0b5lRQ2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727014AbgGXNNC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jul 2020 09:13:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726317AbgGXNNB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jul 2020 09:13:01 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF935C0619D3
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jul 2020 06:13:00 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id x9so4411317plr.2
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jul 2020 06:13:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:mime-version:content-disposition;
        bh=uy5GDfVpen8IjesHL+QozgZfDoKohnfQkQwgiP2hb/0=;
        b=G0b5lRQ2JHmuo1woB0xTnk2hNcPNeZEOWeeusKVOd2g0ThyHiMrabUpJ2+PrChiJNW
         eTd29oBiuyGzSbLWjuR9T2JcMaCoqhhtLM3MjntnYhyr4xBhxeqYA4MJPBUTp7EdGzo5
         YjVg3c0q+UJ7tVfVf7ukxjIjV++5lgOPrDFC9yd16/pV3nPtr1XRQv8yQKtw6hHpkYft
         57NyeUFK6XNGte+kFyeIHtlHyh2M6lIlSYHwxxqTroqvz1TfEBSOkhwhgg9FwiEewgJd
         2ZJZXMhc40qiGL5Fq/L3LFNgywRCMGcqNL/NexdMArxkekw3OCMqggfjyYrV1x2nt/uz
         RDlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition;
        bh=uy5GDfVpen8IjesHL+QozgZfDoKohnfQkQwgiP2hb/0=;
        b=e6gejAT6qzLntZFJwZF+kRZC9MyxXnTmghSdBYXnUWmihMJdxMK9erMc2L7kpU2Eqk
         8+UjZRilPB5gHrKN9k3B7M5/1j3D4eQiZ+GM553z4cgHPxW3fAuHWIWSQqlnoaA5vVQr
         4RMQoopfEExkenqL1kLEsQ9w+jpbG26UNc2Ty8d7zAKtEcmVtBtx/M6BTHm85DF9xT6D
         M90pvkmtHTpT6w/qixMVEmXJS2epSDEzpKJTT60l86cO1sPWown2C36IhdwnGyzZC7cm
         vKZLnc7nE5AYx21nDA4XXulXURZ+i/4HZFhV92hMK0d/OxaDWi0NabrlTwY4gjjMYik+
         oflQ==
X-Gm-Message-State: AOAM533HlrxI4WdZKhRZZsANZdxzex4zdqucczEzQzbP8AAnR6FmYFu3
        9B5hO4JQQpEf4HOW3/r4BJI=
X-Google-Smtp-Source: ABdhPJz9hwR2frZ16gDaMHsbAQu7DNluhcyY32F11pCoh0UXgEGpFH3HCzQjEMH9Nl4fXVP9DrDSqA==
X-Received: by 2002:a17:902:e904:: with SMTP id k4mr2630986pld.156.1595596380372;
        Fri, 24 Jul 2020 06:13:00 -0700 (PDT)
Received: from localhost ([1.22.41.181])
        by smtp.gmail.com with ESMTPSA id az16sm5868462pjb.7.2020.07.24.06.12.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jul 2020 06:12:59 -0700 (PDT)
Date:   Fri, 24 Jul 2020 18:42:54 +0530
From:   Mrinal Pandey <mrinalmni@gmail.com>
To:     gregkh@linuxfoundation.org, arve@android.com, tkjos@android.com,
        maco@android.com, joel@joelfernandes.org, christian@brauner.io,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        mrinalmni@gmail.com
Subject: [PATCH 1/6] drivers: android: Fix a variable declaration coding
 style issue
Message-ID: <20200724131254.qxbvderrws36dzzq@mrinalpandey>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="kfrm7gxkb523ry5o"
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--kfrm7gxkb523ry5o
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Add a blank line after variable declarations as suggested by checkpatch.

Signed-off-by: Mrinal Pandey <mrinalmni@gmail.com>
---
 drivers/android/binder_alloc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/android/binder_alloc.c b/drivers/android/binder_alloc.c
index 42c672f1584e..0294cef7402c 100644
--- a/drivers/android/binder_alloc.c
+++ b/drivers/android/binder_alloc.c
@@ -547,6 +547,7 @@ static void binder_delete_free_buffer(struct binder_all=
oc *alloc,
 {
 	struct binder_buffer *prev, *next =3D NULL;
 	bool to_free =3D true;
+
 	BUG_ON(alloc->buffers.next =3D=3D &buffer->entry);
 	prev =3D binder_buffer_prev(buffer);
 	BUG_ON(!prev->free);
--=20
2.25.1


--kfrm7gxkb523ry5o
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE8DwCG1PwaC2uTI99xIwpEWwxhGQFAl8a3lEACgkQxIwpEWwx
hGR5CBAAuNoMJLRil4reD9Cc8gxG+uzpUuRZgJQv8X4k2BgZ68DRep3z+SRgpbxU
D+dp0aT6Lr4J4EhnZaBKXJcrs4nynnDyXN0eGFXgLUGYHiPwzk3X1J/NqhsKavNW
Liy0OmqMeF4ST/KZZRtWjBh/CZORKE/WZkbSXAWECS5TObsKAyGac9j3qkZh22JI
mxJ7YfqYpyxPUb/6slFifNSIADZATzxD50SH0CiQHCYsSsjQaEl6YYMbI/npwWD5
+Uxp4e4P4BlFMy4iyKoVsVNAomGhfRbiEVWx71o7qoVP/33SOmSyt5ch9OfAF+jU
VuIMXbrfKXv2OUieVF1GB5LzAdmiDzkiM6QSq3oPfSiy9b0X3rFEN3pTF3kgIdBy
c5HadCKFH3VPATZG3KSTL0yzXdBMtCFm1j3kopJMY0sV/Z5k1bJ1mxUs7myYkrb0
TIHMvmCeuo0QEa6ZU0kGyBBiyauhCop1K+rkmr3a1tPR7EEUkuZ6/pVFhXlDHzkL
FkIGOknBlDWp9P8SYYFGO4g8drD3qYw/tFTg7Nf//JD6wDCFS1vhY7QlNDbYmWWW
GBBvUH1MpATPO8UOU4IhnHoZNZrFQUTlyC5nDwdmbi0/3wcO3qf+ibm+zOVnVQsN
cqc9lcnqCeGNK/4esZMfwghmaUXdE3r+nlBcgKDPYpYPm5QprmA=
=rLgY
-----END PGP SIGNATURE-----

--kfrm7gxkb523ry5o--
