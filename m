Return-Path: <SRS0=fM4p=AJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CC8DC433E0
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Jun 2020 14:03:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2E77520663
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Jun 2020 14:03:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=pesu-pes-edu.20150623.gappssmtp.com header.i=@pesu-pes-edu.20150623.gappssmtp.com header.b="i1HCOhmR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726469AbgF1OA4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 28 Jun 2020 10:00:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726344AbgF1OA4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Jun 2020 10:00:56 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0418AC061794
        for <linux-kernel@vger.kernel.org>; Sun, 28 Jun 2020 07:00:56 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id d6so6898813pjs.3
        for <linux-kernel@vger.kernel.org>; Sun, 28 Jun 2020 07:00:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pesu-pes-edu.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=ONqbasDyxWogZeTKAn4mK/woyA98Q/3ofEsG6iZPlpg=;
        b=i1HCOhmR1tFnazLFHtuhOVYLNpnz+Gpm5AsH/86ONkWloYAmMt3GXFk0aU0i6z7k45
         /xIvMDm0RqGzlZl6l1wNAjr/bsfCv1OltyHc/PZgTIqP9dhO6EkUDrE5qQpxkEH2dZpB
         vo44+3mt9kYQGqtpll4NfE2H93jRIA0++bbi8gZfZHLmQNQCg/y0glpxnatWMlJw2bcn
         w195gmdHBlyVY5Tun4sbcKllXVgxehneNJCvfk3cN92h2riE21iHFYMctVUT8Wxo+PnI
         6LipXHfWqwBRgzmnFNnyDWOYZ6H5J6BC1oL0n+vuROuzTG6GKj5ffcFWg8sg1BEvEIX4
         dxhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=ONqbasDyxWogZeTKAn4mK/woyA98Q/3ofEsG6iZPlpg=;
        b=CQhKR2VrBzjNOD3xEcM7o2XwC0MBsJQ2XGkCHSL8rBto2enO3JMV5DHYltmyKIZXxS
         hogjZLaw81A6sq6Q797g4MY+uF21BxQyXDlKqJn0tuIf+8w77Datfzer/tEdVqdfMBgt
         udqE+coGJAzb5Vlf1A+WJibr9EcBFqhCW1IW5bZ4y0/VctQ6Z9GXKt4sH7/Q1E0ZFHBg
         bDFHWEqnrI6VBNVEeJDN/rVWEjKO6p55oOZf/rJvxQew84Brm09I7Cf6NgsWkzxYfCjQ
         LL8Ih6aLB1h5iijdCg/lq765+/eWS2GaH4aJiX8j2AIO5mrwjwk4mjNGY27WcZdPC+AE
         XxlA==
X-Gm-Message-State: AOAM530P6hs2cDUCPe0wKiC/qK8Yj8Rq9hqnDN+Yymo5atWBxn2wgA41
        Ytu8EJP8HtJGNzFIz3QCrLDyUFKwltH83Q==
X-Google-Smtp-Source: ABdhPJyNtziaTqMpGn5TWMxl8uEIj37gpLxMNdAWeTPiR/7535ku0gUvIgKllHTttmyFij49P+JQIg==
X-Received: by 2002:a17:90a:3e02:: with SMTP id j2mr3409194pjc.47.1593352854930;
        Sun, 28 Jun 2020 07:00:54 -0700 (PDT)
Received: from localhost ([2406:7400:73:ff29:908:f18a:1156:5c38])
        by smtp.gmail.com with ESMTPSA id n89sm12578553pjb.1.2020.06.28.07.00.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Jun 2020 07:00:53 -0700 (PDT)
Date:   Sun, 28 Jun 2020 10:00:46 -0400
From:   B K Karthik <bkkarthik@pesu.pes.edu>
To:     Andy Whitcroft <apw@canonical.com>, Joe Perches <joe@perches.com>,
        linux-kernel@vger.kernel.org
Subject: [REPORT] False positive errors found while using
 scripts/checkpatch.pl
Message-ID: <20200628140046.imqmf5vy2vvbwkzo@pesu-pes-edu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="g4vybuynwhjz2ry6"
Content-Disposition: inline
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--g4vybuynwhjz2ry6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The following are reported while using checkpatch.pl on=20
drivers/staging/fbtft/fbtft-bus.c

ERROR: space prohibited before that close parenthesis ')'
#65: FILE: drivers/staging/fbtft/fbtft-bus.c:65:
+define_fbtft_write_reg(fbtft_write_reg8_bus8, u8, u8, )

ERROR: space prohibited before that close parenthesis ')'
#67: FILE: drivers/staging/fbtft/fbtft-bus.c:67:
+define_fbtft_write_reg(fbtft_write_reg16_bus16, u16, u16, )

These are false positives as correcting these issues breaks the build.

--g4vybuynwhjz2ry6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAEBCgAdFiEEpIrzAt4LvWLJmKjp471Q5AHeZ2oFAl74oo4ACgkQ471Q5AHe
Z2pNzAwAnrfOzbE5u7WWJfZnQD5GfjLtywSEm29NBnNk9XPFmEyJ3ZvPp3brXlw7
W1DvH7RHWtI/vzy+VuIlXV0La1QBOGvbuq8zbN59nsWM0L/8apOGPDlTnfwcVWhs
OYLPLQi4TZgM4bLngNj4NHI3PIAJesVD3ZMr9nEYl8CJ0sw0Sk/6PQRJIELrgLZV
TtRSTOLqfMsGCtfb7jFVMaHiiGveTyu4LtxDyTcETn59EKIqsNgWhuhehZcL8NY7
YYS4lNRQq9ANYOzfrVCOZfy2frW7FNyOy5HoO4wvCvDOCvK6KNHd2tjTH6ghrSNt
iqF/FDCQXWE+5oSFLzdKh/ZTd4jBCHXLztuL4jjVAB+qmJLQK9ovUoMu5XMD4H/N
NQJP2TD7qWlmmDDKSRL8YQgTHXLvwaDnAEeARSqma8Y5gt/hzZBV9cqdK/A8372R
v+aYPXN+MU2NkeeJo9srlSTf4e+Bxluhk0tqw9LISDSCg42SEY43BbxW75yJL2cw
42r/939h
=37ir
-----END PGP SIGNATURE-----

--g4vybuynwhjz2ry6--
