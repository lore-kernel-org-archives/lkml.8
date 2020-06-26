Return-Path: <SRS0=rtH4=AH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B0D0C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 02:17:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 597022084D
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 02:17:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=pesu-pes-edu.20150623.gappssmtp.com header.i=@pesu-pes-edu.20150623.gappssmtp.com header.b="E9IDCNPQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728095AbgFZCRc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jun 2020 22:17:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728000AbgFZCRb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jun 2020 22:17:31 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E093C08C5DB
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jun 2020 19:17:31 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id r18so4274749pgk.11
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jun 2020 19:17:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pesu-pes-edu.20150623.gappssmtp.com; s=20150623;
        h=from:date:to:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=C9cKwuo46T4OQrYiN0jf2d+XY2/rTSOAO5/07IXErvU=;
        b=E9IDCNPQpqP3Bmq1JubBLUBuabW2Gp9yfeXWaGS+Ca3o4tXDoyzU4KFTn9e5GBXiob
         HTiI7bkgOza+4JTxAFlf2i4AG6AAsWbVulxePySyjzKh1U9Oaw1/khBoxjd1yLp7SiH2
         wYzmX2dCzYNHF/7+kBx7F4UTgl3Dx81kmsJF8V4PZqvhVCm4SbomesBNboWU/slBlY4E
         /coqKN+MZbwGG1W+pmAHtiahyNhySVmNL6IL7bAQHBl7Do/HK0ZKgRJfjzm3Y1wIovKs
         2MDa9nlofzzLGl+jNQIt1sXdfZQ8yipLNuB/xLWEUlu60tg60WYfVRg1T59c63AbSSg1
         +qvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=C9cKwuo46T4OQrYiN0jf2d+XY2/rTSOAO5/07IXErvU=;
        b=Xkf7R/TQp+LrJ1UCS/qGdwU4XsjQ3LyYGOpQex7DQZimX8FamB/RPqw6WR8LivRaCS
         pwsZ0O9gRHr0mRstXXyPoeT56cFN2EzxUIO93sRUsIQ5ezTwCV68O8A6lLNanLjq3eOG
         mI1mvz6ILn7qVeGQqmkDxOgmLhh3Hw9Cv8ub2hY1Y2vNRlTFccJBoi0eAC77k1+IccZX
         oMTVNguUxld2cgF+Eki8J9EjTJgOr0LIVk0fuX0AtbreXq9Ql07V/mt4X2QIiajZazgI
         ZyHsHoJWaPOdZFHBnfDiOUWI3dl/9El8QxHD0Nkq3gAskT+iUMnGOxql9R6rWzeYqOXI
         qpGA==
X-Gm-Message-State: AOAM532P9YlxQy1a788dETTRYsAoUmbzpf84zKCwy3rOM+FAju2AI7ac
        d2UdA7E8JjT1RNPQaISEQ4DhfQ==
X-Google-Smtp-Source: ABdhPJzsojEVWEwDErVET3M62SJCkzIEavMN3mExLU5NPys9mAJyxcRvlnQsml/NFgA9Wp6Rd43sCw==
X-Received: by 2002:a05:6a00:15c3:: with SMTP id o3mr609027pfu.304.1593137850548;
        Thu, 25 Jun 2020 19:17:30 -0700 (PDT)
Received: from localhost ([2406:7400:73:e1a0:908:f18a:1156:5c38])
        by smtp.gmail.com with ESMTPSA id m7sm21416701pgg.69.2020.06.25.19.17.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jun 2020 19:17:29 -0700 (PDT)
From:   B K Karthik <bkkarthik@pesu.pes.edu>
X-Google-Original-From: B K Karthik <karthik.bk2000@live.com>
Date:   Thu, 25 Jun 2020 22:17:23 -0400
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        linux-media@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] fixing ERROR: Macros with complex values must be enclosed
 within parentheses.
Message-ID: <20200626021723.len2cts3ffq4wimq@pesu-pes-edu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="wtu5diuv5qrhk3yt"
Content-Disposition: inline
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--wtu5diuv5qrhk3yt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

soc_camera.c:

fixing ERROR: Macros with complex values must be enclused within parenthese=
s.

Signed-off-by: B K Karthik <karthik.bk2000@live.com>
---
 drivers/staging/media/soc_camera/soc_camera.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/staging/media/soc_camera/soc_camera.c b/drivers/stagin=
g/media/soc_camera/soc_camera.c
index 39f513f69b89..f609ecf6691c 100644
--- a/drivers/staging/media/soc_camera/soc_camera.c
+++ b/drivers/staging/media/soc_camera/soc_camera.c
@@ -238,8 +238,7 @@ unsigned long soc_camera_apply_board_flags(struct soc_c=
amera_subdev_desc *ssdd,
 }
 EXPORT_SYMBOL(soc_camera_apply_board_flags);
=20
-#define pixfmtstr(x) (x) & 0xff, ((x) >> 8) & 0xff, ((x) >> 16) & 0xff, \
-	((x) >> 24) & 0xff
+#define pixfmtstr(x) ((x) & 0xff, ((x) >> 8) & 0xff, ((x) >> 16) & 0xff, (=
(x) >> 24) & 0xff)
=20
 static int soc_camera_try_fmt(struct soc_camera_device *icd,
 			      struct v4l2_format *f)
--=20
2.20.1


--wtu5diuv5qrhk3yt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAEBCgAdFiEEpIrzAt4LvWLJmKjp471Q5AHeZ2oFAl71WrMACgkQ471Q5AHe
Z2rirQv/QQcRtEifvypBhlZr7yuzX+8HlXqUu66cTwep5gDD2GoI/xmoiGSbzQic
AOIOMWsTQYKGU6VATt4FfVmsrSuXXiFcWwYJwmtlp51oAmph7quEXEiwQgYPjURT
YLEXzPt4OcK2VTJFm4nveRGzsIhJX3Zh1SqQ2/Jx1mr9mRa3AyBPCrLarx+wmkbf
LAg3jNHVq778Q69YyEfIpVMw1l39zh/OZnukEJF1JHPXIRIKwxwAluIT9E12uWgv
KJwYZKtXvCCE+PEA5EZeXGE00N9ZfUO98JfVShwddu4YuN7b978ukqmNZsaz1dY5
EX2HByFbOMQbXrHe+58QA7Qqw2K/d3RmE+66cq9xCbSctdTerUkzkbM4wEeukBCw
81PQIHIp0fupT0TGNVgPRZXm8jcpOd7R7pQDYMM5j/R2iCFiR+Bq+zq7ZkZOTBec
OGD1q1DiOZpr/kBA9Fxp1OHfj9KVaUHI5o7dZk79XErxfkCgghLeEHG8ojsAwytI
YWOpUkjF
=N+em
-----END PGP SIGNATURE-----

--wtu5diuv5qrhk3yt--
