Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A3DAC433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 21:00:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 22334206F1
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 21:00:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=pesu-pes-edu.20150623.gappssmtp.com header.i=@pesu-pes-edu.20150623.gappssmtp.com header.b="JC4covp7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731287AbgF2VAI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 17:00:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731224AbgF2TM7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 15:12:59 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20AD1C08E88C
        for <linux-kernel@vger.kernel.org>; Sun, 28 Jun 2020 22:34:52 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id t11so2548596pfq.11
        for <linux-kernel@vger.kernel.org>; Sun, 28 Jun 2020 22:34:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pesu-pes-edu.20150623.gappssmtp.com; s=20150623;
        h=from:date:to:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=PLzwnsru7uXe97PgGUdN3v/8H1BV8GdZHweH5WV3o2U=;
        b=JC4covp7h9MQ3mBo81HAG9L6bvM7ALyvFFOlzv1szglIjAQAgR6eIwR4u9QSJo808B
         8onNGyokVvlDJsQutaNoEmLLINhSi0ekzZsiVYMMBy9Yu5lx5RHlp1OdUJs3h+yAmYGT
         ge6s0nXoIZQ2+qd4gkxbMXRzHO+E/Saj/nKyqmmj/2mCCXwqJq6/n6Z1Vc8wUwl1Qfmg
         ywResd9LwvA+CRCIoSSTIrR/ZkSl0vUF9fH2KYIfAhC3lztDOiUTJZKgFmly2lO/WDRG
         vB4BZVVn8FUgEa8rIUF0Lumknwvl1VPXdz7u5YGv+jP/Zyl7rQzFD3VtCHgKy7PlADXJ
         NCxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=PLzwnsru7uXe97PgGUdN3v/8H1BV8GdZHweH5WV3o2U=;
        b=dgv4vc5Ysxv2pUC6W5OSIfKUOmkJ5/ngbfly+D4nEQj9n/e8qmDZbqRo95sChF4g1D
         qaE8Tvk6cs1h9ao8FgpWJAREJRcmonr3kmE+AN0a+rXP/rMeRmM8oOu5tknLz/iCUCj2
         hYW+oRCx7puWp9MZaIK3Rl8kpU/ARIwX4h5cBJk0GG0Enoy7S56tfGH8EJ9LCMM/8pLJ
         37Q9HOwzPVPDwQ5e1hBLJbwEOnuJLM4vRIz83zBpCmerkXxQdXk+hm3/y3Z03b3xSILd
         O9QufzvY3oGfp52KCaq/16XWicwnQEqMnpEwQgFjGnB7opbfcGJOn8eLzsGPR2A91KEg
         tGRw==
X-Gm-Message-State: AOAM530iOcvRXgidg3IIn/OKXqdSS+Cq6q7494OtxRw8nAubOlu7r8X4
        YWmlURr4ud50LgCnS0ZWLUOj8g==
X-Google-Smtp-Source: ABdhPJy2baizvtZuar/8Tzvq2EPS2YQ/BGUWe9ZloTvm/n4kPDa662zfVUL6W0omlAfsTOfrPFo/1w==
X-Received: by 2002:a63:1119:: with SMTP id g25mr8721160pgl.126.1593408891526;
        Sun, 28 Jun 2020 22:34:51 -0700 (PDT)
Received: from localhost ([2406:7400:73:703c:908:f18a:1156:5c38])
        by smtp.gmail.com with ESMTPSA id fv7sm14248389pjb.22.2020.06.28.22.34.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Jun 2020 22:34:50 -0700 (PDT)
From:   B K Karthik <bkkarthik@pesu.pes.edu>
X-Google-Original-From: B K Karthik <karthik.bk2000@live.com>
Date:   Mon, 29 Jun 2020 01:34:42 -0400
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] staging: rtl8188eu: include: hal8188e_rate_adaptive.h: fixed
 a blank space coding style issue
Message-ID: <20200629053442.eob7oixlxbs5rh33@pesu-pes-edu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="h7dv7tjs5edeqagw"
Content-Disposition: inline
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--h7dv7tjs5edeqagw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

added blank space around arithmetic operators to improve readability

Signed-off-by: B K Karthik <karthik.bk2000@live.com>
---
 .../rtl8188eu/include/hal8188e_rate_adaptive.h       | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/rtl8188eu/include/hal8188e_rate_adaptive.h b/d=
rivers/staging/rtl8188eu/include/hal8188e_rate_adaptive.h
index 5b59c25e4c8a..79c0d2f9961e 100644
--- a/drivers/staging/rtl8188eu/include/hal8188e_rate_adaptive.h
+++ b/drivers/staging/rtl8188eu/include/hal8188e_rate_adaptive.h
@@ -35,17 +35,17 @@
 #define GET_TX_REPORT_TYPE1_RERTY_0(__pAddr)			\
 	LE_BITS_TO_4BYTE(__pAddr, 0, 16)
 #define GET_TX_REPORT_TYPE1_RERTY_1(__pAddr)			\
-	LE_BITS_TO_1BYTE(__pAddr+2, 0, 8)
+	LE_BITS_TO_1BYTE(__pAddr + 2, 0, 8)
 #define GET_TX_REPORT_TYPE1_RERTY_2(__pAddr)			\
-	LE_BITS_TO_1BYTE(__pAddr+3, 0, 8)
+	LE_BITS_TO_1BYTE(__pAddr + 3, 0, 8)
 #define GET_TX_REPORT_TYPE1_RERTY_3(__pAddr)			\
-	LE_BITS_TO_1BYTE(__pAddr+4, 0, 8)
+	LE_BITS_TO_1BYTE(__pAddr + 4, 0, 8)
 #define GET_TX_REPORT_TYPE1_RERTY_4(__pAddr)			\
-	LE_BITS_TO_1BYTE(__pAddr+4+1, 0, 8)
+	LE_BITS_TO_1BYTE(__pAddr + 4 + 1, 0, 8)
 #define GET_TX_REPORT_TYPE1_DROP_0(__pAddr)			\
-	LE_BITS_TO_1BYTE(__pAddr+4+2, 0, 8)
+	LE_BITS_TO_1BYTE(__pAddr + 4 + 2, 0, 8)
 #define GET_TX_REPORT_TYPE1_DROP_1(__pAddr)			\
-	LE_BITS_TO_1BYTE(__pAddr+4+3, 0, 8)
+	LE_BITS_TO_1BYTE(__pAddr + 4 + 3, 0, 8)
=20
 /*  End rate adaptive define */
=20
--=20
2.20.1


--h7dv7tjs5edeqagw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAEBCgAdFiEEpIrzAt4LvWLJmKjp471Q5AHeZ2oFAl75fXIACgkQ471Q5AHe
Z2pF2QwAj3e+d2jjhvUgSJyfTQ7y8RzV08p6OhTRDmWuq735at2sKKu3SPmnD6QX
48B4WPqOg+ltGQXw+PYeNjQJYHkoVTb/qfxHvXhxLD8fubc7Z4EI7/aDHMsVeW7x
dQlRV7J3lBSNup6CDYm4fi5xNzcmpr1YUpeDVYF7JEYfJDPxcqdusr+OOuuqgaJy
D7NTD/cTopgjzLE6RmSPWQFm/vX+g8EYCYKl/gl1sjWL14AomX4qxeDa8fRFTa8X
rD/wTn75fJnxCZ6QQ+PvBFZDQ2G1sPSCG2Q/iSUYa0Ko7JDMu5NgdeAJlDARN0HU
wnW33NJ6V1fTD/qscWMsGqK+MVVBq6psL7/GREnvdwnqZ4u42smzh+zab8SDo0xd
lT0Qok+pACeG2YzrEvGYElJpc46h+Ooaccgzm3vXMrJq4P/dK0Gn/e5Siq+okj8U
UOus+gsojl58/ZEobu+LTPUh4NKo9AdEB5H9Bnkz/9+lmyXc/kWs8hRUZ9aQlLTF
YtO2xcBX
=Zy66
-----END PGP SIGNATURE-----

--h7dv7tjs5edeqagw--
