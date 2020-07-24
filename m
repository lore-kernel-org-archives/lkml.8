Return-Path: <SRS0=4orP=BD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E72CCC433E8
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 13:14:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BF7672065F
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 13:14:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iesrQsY5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726878AbgGXNOL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jul 2020 09:14:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726182AbgGXNOL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jul 2020 09:14:11 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D01AC0619D3
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jul 2020 06:14:11 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id 207so5088034pfu.3
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jul 2020 06:14:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:mime-version:content-disposition;
        bh=43P66Fc2aAnp4qTC6waFnOvWVRLlCg4Ewg4/5+qAaPc=;
        b=iesrQsY5ydwDmsTY2kTV8vuXCi2id+5XuBiuQzA7aNjAoiWDHlSg40vlCUO7dSUxTw
         0lPCJMsfPp1SULd/Byqd1MsVimdrS56zDGNAJCh22QjJdtNvObQf+DTa96cG0tnjy0K/
         luMX5rrKZ6yyN5c+9wfBgR3eE5QZBONaYqiqUPpGRRP/G+AgEj0APfIqObCOZ1ZKRAY7
         qzzX9QO+62y7UpIvT3WD3/E0B5/xLQwKZYvzV1WJaBpPpnDUxIgF5f3KJFMbIinyueLq
         jrycY2qU0iWYx67L5+t9AtCsWuCOio/L1iRCcMGJLAIhAmiS/UxJS6NkBRAq06+rHseA
         koeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition;
        bh=43P66Fc2aAnp4qTC6waFnOvWVRLlCg4Ewg4/5+qAaPc=;
        b=P24d8+KquIOefBvuGnxVZ1LOnIqnKap4r1Ig4ozgAGjPeGL8DrBs3wvyHSqZClHi9f
         ZY6tLOTN3y+jICIIyzfxEi/MGT/fVMsi6LvNkOa7h5FSabLcQ9tbefGKGFuxuQNl2OLR
         m9JpWnysJXSqQVpZkaO8ZRmDe5h5iilWDlNA1W4S/1PZQ7+7Rnhl2Q9xOCSzN57Hywyu
         nhQSfbHRen4jU0xxZ55UbCWFiIzaHgVIwmjH8DrZ8We7mb6yETNh3OlG/prUNyIW8SWm
         WMGNkHZk1pgbJX25e2hy7H4fy2a6s1yXSJbQ0RxlLM93c9ChzgnuHpXzRvOc3UPXlyTe
         biPA==
X-Gm-Message-State: AOAM533H0HouqLBo7bKmOpxQTyUlA7UGn7KTSFYuS+dPtka/LQlxjwWX
        ggicn4CovJUd/cUics8htDY=
X-Google-Smtp-Source: ABdhPJxCX+WwMMOkaTap07DisAkCFoIimynX/6s/HS7vcD7LJ9fTsEUx54AZMGw7nCb9YUGc+VyEYA==
X-Received: by 2002:a65:43c1:: with SMTP id n1mr8271003pgp.67.1595596450534;
        Fri, 24 Jul 2020 06:14:10 -0700 (PDT)
Received: from localhost ([1.22.41.181])
        by smtp.gmail.com with ESMTPSA id x9sm6192051pgr.57.2020.07.24.06.14.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jul 2020 06:14:09 -0700 (PDT)
Date:   Fri, 24 Jul 2020 18:44:03 +0530
From:   Mrinal Pandey <mrinalmni@gmail.com>
To:     gregkh@linuxfoundation.org, arve@android.com, tkjos@android.com,
        maco@android.com, joel@joelfernandes.org, christian@brauner.io,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        mrinalmni@gmail.com
Subject: [PATCH 3/6] drivers: android: Remove braces for a single statement
 if-else block
Message-ID: <20200724131403.dahfhdwa3wirzkxj@mrinalpandey>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="3bvf6kql47vqrvnj"
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--3bvf6kql47vqrvnj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Remove braces for both if and else block as suggested by checkpatch.

Signed-off-by: Mrinal Pandey <mrinalmni@gmail.com>
---
 drivers/android/binder.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/android/binder.c b/drivers/android/binder.c
index 5fdf982ec83b..3cf13ff16934 100644
--- a/drivers/android/binder.c
+++ b/drivers/android/binder.c
@@ -2759,11 +2759,10 @@ static bool binder_proc_transaction(struct binder_t=
ransaction *t,
 	binder_node_lock(node);
 	if (oneway) {
 		BUG_ON(thread);
-		if (node->has_async_transaction) {
+		if (node->has_async_transaction)
 			pending_async =3D true;
-		} else {
+		else
 			node->has_async_transaction =3D true;
-		}
 	}
=20
 	binder_inner_proc_lock(proc);
--=20
2.25.1


--3bvf6kql47vqrvnj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE8DwCG1PwaC2uTI99xIwpEWwxhGQFAl8a3poACgkQxIwpEWwx
hGSkHA//RighMrxFGk+BTWAwUxsE+wTGy1Vvn0Nc1RSyxD0A6YPqaRCg4B9nGqhk
PCyg07NT2hGY2k/V2EDplmVu5oHpQREtED06uAEZY3efi1gdFsw4fEhd08x1kpu4
jDXzJuG2fJvfDLd49iVnfV2z5gtt8KQXyiZXZ2T/BP0w11JLJA9RcyRzAOkJUH4f
8PtiaN1EiMsXw/wPaYRWLc+RuojZl8AfSA3dsLtT8Pb7oCgn20QUDFDFPB4MMoaZ
ULVRGjcj81Oa4jWCTStSzzz01iywx+T+HV6nPwaV/QvZT2ga+l8c/b1H79TW4hcv
IFex7ns9CS9t1U59DOaPHnVtapyfrkg6kONfc1++StUvuxrXaTag/2EYmc9xpoFb
tVtlsoM/FtO+3tVC5UixIiVEGdQRdLElxvdMgnX+2I/HtT7IRyKeVjH8/J+7Akd5
n5CaMBTHqQxbyO0J7P+gF4MF9w8EF8BlLwYTdcmM/E9ktQJOGDnH3tGifMO4b+5U
bWOZ45mo5kN5ynkEPEdo0aPGoA2SWk1fgCZZKml5lyuKlxjsy+TpLcs9olpqx/HU
qryOd+4lLY/mF6j+vWZ7gnVwwIe04RQYATLIXl6xBOuRUnXUVjESdtKpBHLtBv7N
EDmO5dmBONAcpoYSE8qVyH8Y7Dh5FK+cVjwRqyuRt5I538BCuks=
=wUz9
-----END PGP SIGNATURE-----

--3bvf6kql47vqrvnj--
