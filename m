Return-Path: <SRS0=4orP=BD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 911E0C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 13:14:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 69D1E2065F
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 13:14:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gCvhAN8g"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726988AbgGXNO0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jul 2020 09:14:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726182AbgGXNOZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jul 2020 09:14:25 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76445C0619D3
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jul 2020 06:14:25 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id o1so4415809plk.1
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jul 2020 06:14:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:mime-version:content-disposition;
        bh=dzxDyqTxC5C7vOfI1scwv7wBqFZhHOHAY1E3Yx1fnmk=;
        b=gCvhAN8gxAEKQC133j2Q+Rm3uTGWgxKhD0gv7q41xwW0fbceAjto7tQEgP4wUu1QUf
         VLwLAvfF5yIxCk5qCzaKP2SBJZPNKWkcnaDxALRDetyY7IHrJNRZ+NKKWY01eCBVWiGl
         FMiyyqXq3jWZkGlcEl+UihN1NW6aT2KLu0en+t6K4unTRJwiBsHPcLiwoq7dP9e+j2Me
         Ks4abwmgYS4q/EN65iHht/xB9jnLyJbfYZO4g8BBhrkjyoCfRR1TTJhfrP84G3xl5+ts
         wqaSPUTjDa+iMXVSIxgUT3X0guICOL7+JWSA2zEI92fq34KgPOjrqH5pN46qjbJrDLah
         GqCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition;
        bh=dzxDyqTxC5C7vOfI1scwv7wBqFZhHOHAY1E3Yx1fnmk=;
        b=uK41xYD5xn8f8EENoH5BZliFCj7XIjb/wqhiH2J/fOLpEm6EtRKssn2nQUuKObKl6K
         /K857ADaGSBXSCKSdn/x6u0ivH8ounWRUkbPZMBdWvhH0HW8+bDUdAkztHeM0SYCoYrx
         7fUS9dtg9U1OQoo7tsoIFXoE4c38k5wOpquE9qpNnkVVzYR5va3nLfZvEn7jgKiLYtCS
         rJamsSx9+0HYeDaeMwieYuUfUQWD+4Gpbpk0B1P4P58jvkwP7PnqdzkVWrbtKzCC+KX5
         8bTmUwKMwJaaZ8a/s8XxIcs9ELTX3gX+lQFQJ7QgjINpasyJItJfL27z6AzLqtsShna8
         QNTg==
X-Gm-Message-State: AOAM5321ex9AczrPHqgPlyuuVNzRBrEd5A4tuGLSCgnhQDNJSkKfYYff
        uTkyBKpGZc6KZ9D7Y+1KqCU=
X-Google-Smtp-Source: ABdhPJwnqD+PuzPqE8lSUn06RHEbKZLPKf8OY6mWdmU+OVlpL8eg4wB7BrSKTL5Mr4WU/34dAQnhyg==
X-Received: by 2002:a17:90a:3523:: with SMTP id q32mr4964274pjb.185.1595596464961;
        Fri, 24 Jul 2020 06:14:24 -0700 (PDT)
Received: from localhost ([1.22.41.181])
        by smtp.gmail.com with ESMTPSA id s22sm6030243pgv.43.2020.07.24.06.14.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jul 2020 06:14:24 -0700 (PDT)
Date:   Fri, 24 Jul 2020 18:44:20 +0530
From:   Mrinal Pandey <mrinalmni@gmail.com>
To:     gregkh@linuxfoundation.org, arve@android.com, tkjos@android.com,
        maco@android.com, joel@joelfernandes.org, christian@brauner.io,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        mrinalmni@gmail.com
Subject: [PATCH 4/6] drivers: android: Fix a variable declaration coding
 style issue
Message-ID: <20200724131420.fkyzzgnmrmqk6dfe@mrinalpandey>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ps7jevsm5xmkvks7"
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ps7jevsm5xmkvks7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Add a blank line after variable declarations as suggested by checkpatch.

Signed-off-by: Mrinal Pandey <mrinalmni@gmail.com>
---
 drivers/android/binder.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/android/binder.c b/drivers/android/binder.c
index 3cf13ff16934..75832f236bf9 100644
--- a/drivers/android/binder.c
+++ b/drivers/android/binder.c
@@ -3631,6 +3631,7 @@ static int binder_thread_write(struct binder_proc *pr=
oc,
 			ret =3D -1;
 			if (increment && !target) {
 				struct binder_node *ctx_mgr_node;
+
 				mutex_lock(&context->context_mgr_node_lock);
 				ctx_mgr_node =3D context->binder_context_mgr_node;
 				if (ctx_mgr_node)
--=20
2.25.1


--ps7jevsm5xmkvks7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE8DwCG1PwaC2uTI99xIwpEWwxhGQFAl8a3qsACgkQxIwpEWwx
hGRP9A/+LlCEIXuSRjF2CIXkRNs3TC/xhRcngfEZT/1QR8Eu1Z0JwUt9H42mptu+
NmgJ8wXAElh7IRVhrscLUxjwyuc48APblUGNr1fDMGUw+ASQne6OUyug+KNiGw0c
CwfAKKBu9hcw249WSK+sREfvTCh4mau8pVXfo/9EmT3CNLbqOJjIPXgZKVo13+0D
z3IvVH5Pi6SBTcCYwvQna7xsPYfqQFRseouk6XobCqPmTtdSOmC/PEHzloWLRPPm
DbTAzohl8XAA/CgZFDuvxaLdlwV3yiCjvDIK7MXe8U8nVmcXQtaU+3GUUArFct4T
VbfJKOZ/XIkgl97QSsr4ZCB9T9a3OLVzsVK7tithTbbMqB7yuJZaoUoYYYnY6TXD
u7Ou22JU9JsZVyE7j5LffDMvZaJnVo0TpxIWzpSvFL2kmkyb5rsNnQBBgzu5dLUu
ITDhLBexx8ammY2xkKiZNeZLMNi9noiFVZX00n/HhvSLj5RiwC01Wvd6ezn3L5nw
nraSdXJnr+4QXOuJEI2zquTP0OFi9loSav7tcaVlC+OPv7kmZV95R5oaVEfBDe9c
vgiBHaw1OBf2y0oMYMY8nsPrfsM8zGmpasbXTboZmC4ZJwb4r48YmXFaS3tVF7ms
Wj9mmw5E4rxKyT5RhY5r7x1twv3b9+ABKjfbBvR6oeZT0mufW90=
=zILk
-----END PGP SIGNATURE-----

--ps7jevsm5xmkvks7--
