Return-Path: <SRS0=dAmO=AZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FED7C433E2
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 13:24:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 13A17224D1
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 13:24:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=pesu-pes-edu.20150623.gappssmtp.com header.i=@pesu-pes-edu.20150623.gappssmtp.com header.b="gEkXrr3u"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728504AbgGNNYA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jul 2020 09:24:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727858AbgGNNX6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 09:23:58 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65CF4C061794
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jul 2020 06:23:58 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id t6so3864195plo.3
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jul 2020 06:23:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pesu-pes-edu.20150623.gappssmtp.com; s=20150623;
        h=from:date:to:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=4tyb2WDwFS2aoAxOZTJuZZO8xIzZEBnfgQRrMTFVPy8=;
        b=gEkXrr3ujKnbFKozZYmYSKWkXIwMUEl0kj87Y52XG5O756MlCo18hrRS93htxsbthP
         kp8Sbtma0TC4EZLqrBUGQeW74DMIgtH6SX40KmCDNC36fvbt+2SDxIqe5AXVoIvyi5Sb
         pqgZpWSrs/LFzkuQJA+G+serReQq8+vo/oZONYqea/XLjYvffTxu1uYKfSptktwOtHwJ
         cZs77V21LVQHT/siPYiMZr3eguJyyeC/r3iFhjK3TU95rJD40CYI3dVfF8h5fWC367h/
         Rv1+YQ2bWX8iBFF0D2YvPUVn9cnu7xKdspxMvs9ikCeA0rnlzlItrwMQogYEQvTJbhsq
         wFSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=4tyb2WDwFS2aoAxOZTJuZZO8xIzZEBnfgQRrMTFVPy8=;
        b=Wkkkbd9Ds1IEZKJ44jPmQOF1tku1XfrmjcOcFFxE4Od1ogH17FLH9sRBfvjCQCttV2
         s+PGklu07hI5OG4Vk0d5RTELH7R45N7v9bAb+mgmlum64AlkJjqcfWL960N/z9KR0PdA
         S/5ZM4WUEotg15pji5D8OlUbPeZrtvWJhc7bIs9ALf2ScAQ+OROm9IgRbFQ6y4kDRxOL
         Cv+dwOtym2uMnnoTSrL5GskDBaeHRCoH7OMBZZRrbwwg4LqujmxRmCUgAQZIDLlHwcVs
         ASXQiMBCvFCyo58MOdKqtAVGCGvzfWFfvwVYk6KTFiMhwyC7splYIIxaEXfqbcT3cGbI
         zqKw==
X-Gm-Message-State: AOAM530pmMrbiFkA/2dU7h168jeybGBJSxKjBtL3dUnqwF2YBuiQtNQx
        C2DMRYsa/kFX42onkY5cfMDWVw==
X-Google-Smtp-Source: ABdhPJwzRaA4tJhjLno+GpL8qdTMO5ieciJeOHn1En2igShXXa0max+08dg16ajrcA9WvWEenrMkrQ==
X-Received: by 2002:a17:90a:454f:: with SMTP id r15mr4607372pjm.6.1594733037918;
        Tue, 14 Jul 2020 06:23:57 -0700 (PDT)
Received: from localhost ([2406:7400:73:6b0b:30fb:46c3:cbfb:2554])
        by smtp.gmail.com with ESMTPSA id n9sm2631321pjo.53.2020.07.14.06.23.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2020 06:23:56 -0700 (PDT)
From:   B K Karthik <bkkarthik@pesu.pes.edu>
X-Google-Original-From: B K Karthik <karthik.bk2000@live.com>
Date:   Tue, 14 Jul 2020 09:23:50 -0400
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-media@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] drivers: staging: media: atomisp: pci: css_2401_system:
 host: csi_rx.c: fixed a sparse warning by making undeclared symbols static
Message-ID: <20200714132350.naekk4zqivpuaedi@pesu-pes-edu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="52gap7mw3pinsur3"
Content-Disposition: inline
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--52gap7mw3pinsur3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

changed symbols N_SHORT_PACKET_LUT_ENTRIES, N_LONG_PACKET_ENTRIES,
N_CSI_RX_FE_CTRL_DLANES, N_CSI_RX_BE_SID_WIDTH to static because they
were not declared earlier.

Signed-off-by: B K Karthik <karthik.bk2000@live.com>
---
 .../media/atomisp/pci/css_2401_system/host/csi_rx.c       | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/media/atomisp/pci/css_2401_system/host/csi_rx.=
c b/drivers/staging/media/atomisp/pci/css_2401_system/host/csi_rx.c
index 8e661091f7d9..4d2076db1240 100644
--- a/drivers/staging/media/atomisp/pci/css_2401_system/host/csi_rx.c
+++ b/drivers/staging/media/atomisp/pci/css_2401_system/host/csi_rx.c
@@ -15,26 +15,26 @@
=20
 #include "system_global.h"
=20
-const u32 N_SHORT_PACKET_LUT_ENTRIES[N_CSI_RX_BACKEND_ID] =3D {
+static const u32 N_SHORT_PACKET_LUT_ENTRIES[N_CSI_RX_BACKEND_ID] =3D {
 	4,	/* 4 entries at CSI_RX_BACKEND0_ID*/
 	4,	/* 4 entries at CSI_RX_BACKEND1_ID*/
 	4	/* 4 entries at CSI_RX_BACKEND2_ID*/
 };
=20
-const u32 N_LONG_PACKET_LUT_ENTRIES[N_CSI_RX_BACKEND_ID] =3D {
+static const u32 N_LONG_PACKET_LUT_ENTRIES[N_CSI_RX_BACKEND_ID] =3D {
 	8,	/* 8 entries at CSI_RX_BACKEND0_ID*/
 	4,	/* 4 entries at CSI_RX_BACKEND1_ID*/
 	4	/* 4 entries at CSI_RX_BACKEND2_ID*/
 };
=20
-const u32 N_CSI_RX_FE_CTRL_DLANES[N_CSI_RX_FRONTEND_ID] =3D {
+static const u32 N_CSI_RX_FE_CTRL_DLANES[N_CSI_RX_FRONTEND_ID] =3D {
 	N_CSI_RX_DLANE_ID,	/* 4 dlanes for CSI_RX_FR0NTEND0_ID */
 	N_CSI_RX_DLANE_ID,	/* 4 dlanes for CSI_RX_FR0NTEND1_ID */
 	N_CSI_RX_DLANE_ID	/* 4 dlanes for CSI_RX_FR0NTEND2_ID */
 };
=20
 /* sid_width for CSI_RX_BACKEND<N>_ID */
-const u32 N_CSI_RX_BE_SID_WIDTH[N_CSI_RX_BACKEND_ID] =3D {
+static const u32 N_CSI_RX_BE_SID_WIDTH[N_CSI_RX_BACKEND_ID] =3D {
 	3,
 	2,
 	2
--=20
2.20.1


--52gap7mw3pinsur3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAEBCgAdFiEEpIrzAt4LvWLJmKjp471Q5AHeZ2oFAl8NseYACgkQ471Q5AHe
Z2q9wgv/V4UWsixwDSiDh5IhJKpSctI49K7a+54UXQNdlMduZb2oJZA9jbN/PoRd
2hdgclHErUk54YcJpaVyooLd6HWJoz0lB+Nf4/rWrlEYsPAoeAo6Aoji76VgX+9I
HLBLPH20N9CTA584xJjiluVIdYnuKo/jX/hIDHuU8pZOJbqc8exnmkJVBO7o3mCF
Cz/VeL/GAuFglQ4mzlVFFWfEjEnsrbMiL3qZPgzvS10cjn4htz07hhrcWdmYtnr7
vICyPutw7y3wLchTKwCy3hRwap6Bz2mst2ViYFGkX32iAomdL5ZHCzlPC6xneQq0
EOfN9OAECH9Kw+AjnxFN6EDyIYCGXmC88c+l3u9fJeHqPjY7tKXdVOerC36dOSJa
MJouVcyOxKR54eBVy60F+2mM22SUqQJ0r1c9FIkzj9qF+snEFCQmz6BPXjNvNKIY
u9hBEyu+RsalTLzIwvgZa6xKVfCPFDD+tLoAtxBGAZdh6UYnJgtp0QS2hmx+ZnM2
03gE5VRj
=6ueS
-----END PGP SIGNATURE-----

--52gap7mw3pinsur3--
