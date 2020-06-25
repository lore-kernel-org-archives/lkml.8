Return-Path: <SRS0=lrRa=AG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91B48C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 13:51:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5F506206A1
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 13:51:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=pesu-pes-edu.20150623.gappssmtp.com header.i=@pesu-pes-edu.20150623.gappssmtp.com header.b="iJZijdp0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405228AbgFYNvD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jun 2020 09:51:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404803AbgFYNvA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jun 2020 09:51:00 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1165DC08C5DB
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jun 2020 06:51:01 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id d12so2829686ply.1
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jun 2020 06:51:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pesu-pes-edu.20150623.gappssmtp.com; s=20150623;
        h=from:date:to:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=O6XWpAIm/07NSaAOsW+eHsOPwj9NO+y2KozfprF3MfU=;
        b=iJZijdp0c4rgMpbSmneJ/7Y0r69e5W6O14v+/Yh6yx60yuOg/LuDbpgJ85E5VhHBCM
         wH6LaEtu4HnNDLKdhiocMlPnbPqqxaxTfmClWYA8+qKBDGfLk6TFfgVIU2Fah09zaEGt
         eijSbz4wnvdVuFwO4W/uK57q/cvGAFmcP/OqbhpIyvxgP43VOFJKCB22RpN6mI5C7Mbm
         eXCtbDH4PCucy+ENIN8FuwYe9ogGJSREXLeX7TewvJ8Y2jR5yeKv7f8F2qHcoAQ8X02D
         SLluvWTcTqrIwlNUrxHB7nIzGDlkSQx507VEDn9Wh4FWV6uJQXGuv8sjGGMIG2+FUgCP
         JXWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=O6XWpAIm/07NSaAOsW+eHsOPwj9NO+y2KozfprF3MfU=;
        b=n1kiQDsqndptGprns1Wf1tGHh3WYRCcn9u/0STTl4uMu4J+lZAJDpNcto70emrMbju
         39F6rT8CWaX/QIF5iq5qLqIbukzaiRcuqQCdXkBzVjR8EJxXHB31OuPDcZ79hS9RiIV6
         Bm1v4M3lJ3xnvW4/8KNFQRHNCFC9b8dVXV2e/mkqQLlQQAID76NbVXtd8bVzlqsj+FNx
         Zo/VnAjAUIR5Ky6BeUG/++YrxGOSWLzYf1zfpSqXdD9YN3YW1FsJZCvBTX0cXcaIE5I2
         IVWDisIxJN4JRZOyDzjADqzPPnAUGmGmUNfEAykHNVxtQaqXl8L0c4n2CMuwlGXNRY/c
         KP1Q==
X-Gm-Message-State: AOAM532+Z3Ut/nTw9KslKboFtzb5KkB/yQkU1cAu6X9S4euNBGrRswGM
        aO6wWsHm/GVz8OG08M/YlcNPqQ==
X-Google-Smtp-Source: ABdhPJw0XHLBftq9f1yqYhGK7B1rnEDK++/JqGPEqJB/M/z+kCDZMRNU1E6tlnSLrwoI1PKGBTx8lQ==
X-Received: by 2002:a17:90b:4d08:: with SMTP id mw8mr3395070pjb.119.1593093060504;
        Thu, 25 Jun 2020 06:51:00 -0700 (PDT)
Received: from localhost ([2406:7400:73:51e4:908:f18a:1156:5c38])
        by smtp.gmail.com with ESMTPSA id oc6sm9666571pjb.43.2020.06.25.06.50.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jun 2020 06:50:58 -0700 (PDT)
From:   B K Karthik <bkkarthik@pesu.pes.edu>
X-Google-Original-From: B K Karthik <karthik.bk2000@live.com>
Date:   Thu, 25 Jun 2020 09:50:51 -0400
To:     Marc Dietrich <marvin24@gmx.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        ac100@lists.launchpad.net, linux-tegra@vger.kernel.org,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] staging: nvec: changed coding style, line should not end
 with a (
Message-ID: <20200625135051.msl37vuz5fbgiuz4@pesu-pes-edu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="rewokx577v3vntjb"
Content-Disposition: inline
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--rewokx577v3vntjb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Signed-off-by: B K Karthik <karthik.bk2000@live.com>
---
 drivers/staging/nvec/nvec.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/nvec/nvec.c b/drivers/staging/nvec/nvec.c
index 360ec0407740..16afbe1dfdeb 100644
--- a/drivers/staging/nvec/nvec.c
+++ b/drivers/staging/nvec/nvec.c
@@ -382,8 +382,8 @@ static void nvec_request_master(struct work_struct *wor=
k)
 		msg =3D list_first_entry(&nvec->tx_data, struct nvec_msg, node);
 		spin_unlock_irqrestore(&nvec->tx_lock, flags);
 		nvec_gpio_set_value(nvec, 0);
-		err =3D wait_for_completion_interruptible_timeout(
-				&nvec->ec_transfer, msecs_to_jiffies(5000));
+		err =3D wait_for_completion_interruptible_timeout(&nvec->ec_transfer,
+						msecs_to_jiffies(5000));
=20
 		if (err =3D=3D 0) {
 			dev_warn(nvec->dev, "timeout waiting for ec transfer\n");
--=20
2.20.1


--rewokx577v3vntjb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAEBCgAdFiEEpIrzAt4LvWLJmKjp471Q5AHeZ2oFAl70q7oACgkQ471Q5AHe
Z2oxxQv+OOy01Ou3vqU5dN75Df6fs0uJzKJ4lacNDjmMVI7YZvO95FHX6uw2W2ZE
1QIRzE43pNJ9IGkAOr88VNZPddYk9YIf+pQ/0N5P8Ey1l6HpjfzXLsYmkJ7sh/kR
lYUZFLnlzHDSeQWN/GWyYm6is9AKCV7wz566vDg/8ttx7+XRgoyMurqYZeHLT+0B
EHaMLNbnW1HAS++UYxKyZ2+G2VwgTbM5Mb/k08C15t0Op19XwxAHTyEhPFPBYedR
i5oSli2HjK/zFOf8GfnztOtd0E65JNnsPkzlUxADw6OgAvpQlwVkhOb99qwTMQ7c
CZgoM0zhwGmnypFC5nFyMFjAyD8LjBfxU6JoJaWrEsILl+ZLNrG6ruCiZBfAaIwV
BVXKkTfSU7YKZeBVZM2rIvZOnUjWJSKXPd2mnrfvdv/1y0iFx3Dz/EP4l/NDr8sl
81r1GaaE/qwPF2GGPj7bHgTkL3vRZrrxsvYbucY+NQofp/qkbt7olHd4ic8eSE28
uZZcI5eN
=6J1G
-----END PGP SIGNATURE-----

--rewokx577v3vntjb--
