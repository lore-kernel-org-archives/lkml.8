Return-Path: <SRS0=maQP=AN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80252C433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 11:16:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 532702070C
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 11:16:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=pesu-pes-edu.20150623.gappssmtp.com header.i=@pesu-pes-edu.20150623.gappssmtp.com header.b="q1tlZJcc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728511AbgGBLQG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jul 2020 07:16:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726483AbgGBLQF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jul 2020 07:16:05 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06726C08C5C1
        for <linux-kernel@vger.kernel.org>; Thu,  2 Jul 2020 04:16:05 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id e8so13327451pgc.5
        for <linux-kernel@vger.kernel.org>; Thu, 02 Jul 2020 04:16:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pesu-pes-edu.20150623.gappssmtp.com; s=20150623;
        h=from:date:to:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=Qrvb9nofOcphMhPvn7rhmWkgGEuaksdRhmOaMZHUskk=;
        b=q1tlZJccCFLKiPQ/B2sC/vDQU5b/O+7mvoncg0hJaJt6QweyYmQV4qNQmntWnC2ZG6
         620otiEomwaTtEn6zINRnpFA37xc059rchr5UYDrEMiKHffYM0YthZ62ESZQ8JfxSxvI
         4yPqmUrnbvrzKbexHh/xqmTd68zs9trc1uVdUuxiHfUqeoKSTal1YPYH96umePhBtVLg
         MBeQBh+6Oij38m453JqZ4UpklIksz1WSIjdkB3H0VNrXldSIdZImcld/iM+H5Xpi5AMj
         j5gE/TeJIzVlu0emm4UqUkGz2Bh1iHv6100K3hhnmUgRyFlvo/pPlVrtnz7wXM8vy1rW
         jlSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=Qrvb9nofOcphMhPvn7rhmWkgGEuaksdRhmOaMZHUskk=;
        b=i0wdiiRF2yhdIijlKbuF1p5eVEV33zME+dxB5QkzLcmyD+NO1qHqgA5/W72NSJo9Wf
         C5kduSspNe/XjLjs+0NWRJj74+AJFOnsRe6yB3Z3pJkjUamflqdMmE4mWYFQl2QW5GlI
         O5k7dEHjyuxX4uiE48lNZq1UP5KEfZR3AQZe6B0B14A1l5A5L0DCyN1zcsS6C4j81J5n
         0Bv2e/HPH9YXwNVK3rFGsElCxJl3jUGcLCA9Yb62v3jDvkAJf3gapl7atLStFT3zFdVA
         lhB7O7TrhV9Y5+6B8pQbFcJOuq5Bty0vgQb2WJc+nXi45TvsLjuTixY0uBVw+Rw3UAab
         vy+Q==
X-Gm-Message-State: AOAM533CvphoY9MbNH0s6kwD93dFsRDPC+vQ3o+YZ+Xz3coEwHp+nyyZ
        hbJRh5prBSC6NfZ3OjGdXxGknw==
X-Google-Smtp-Source: ABdhPJyhLd/8NX87aLg4uj6IPzpgTgUg5wAdDZI704xXtpl5sgn32mtenwtWMbVTFLzfDJMFS9r5Jg==
X-Received: by 2002:a63:d44e:: with SMTP id i14mr9483301pgj.280.1593688564494;
        Thu, 02 Jul 2020 04:16:04 -0700 (PDT)
Received: from localhost ([2406:7400:73:3271:908:f18a:1156:5c38])
        by smtp.gmail.com with ESMTPSA id s22sm8492352pgv.43.2020.07.02.04.16.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jul 2020 04:16:03 -0700 (PDT)
From:   B K Karthik <bkkarthik@pesu.pes.edu>
X-Google-Original-From: B K Karthik <karthik.bk2000@live.com>
Date:   Thu, 2 Jul 2020 07:15:56 -0400
To:     Larry Finger <Larry.Finger@lwfinger.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Kees Cook <keescook@chromium.org>,
        Michael Straube <straube.linux@gmail.com>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] staging: rtl8188eu: include: rtl8188e_xmit.h: fixed multiple
 blank space coding style issues
Message-ID: <20200702111556.uswbq7umpigltvfk@pesu-pes-edu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="xqnxwb3h3522s2yn"
Content-Disposition: inline
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--xqnxwb3h3522s2yn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

added blank spaces to improve code readability. (coding style issue)

Signed-off-by: B K Karthik <karthik.bk2000@live.com>
---
 drivers/staging/rtl8188eu/include/rtl8188e_xmit.h | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/rtl8188eu/include/rtl8188e_xmit.h b/drivers/staging/rtl8188eu/include/rtl8188e_xmit.h
index 49884cceb349..c115007d883d 100644
--- a/drivers/staging/rtl8188eu/include/rtl8188e_xmit.h
+++ b/drivers/staging/rtl8188eu/include/rtl8188e_xmit.h
@@ -30,11 +30,11 @@
 #define SET_EARLYMODE_LEN2_1(__pAddr, __Value)			\
 	SET_BITS_TO_LE_4BYTE(__pAddr, 28, 4, __Value)
 #define SET_EARLYMODE_LEN2_2(__pAddr, __Value)			\
-	SET_BITS_TO_LE_4BYTE(__pAddr+4, 0, 8, __Value)
+	SET_BITS_TO_LE_4BYTE(__pAddr + 4, 0, 8, __Value)
 #define SET_EARLYMODE_LEN3(__pAddr, __Value)			\
-	SET_BITS_TO_LE_4BYTE(__pAddr+4, 8, 12, __Value)
+	SET_BITS_TO_LE_4BYTE(__pAddr + 4, 8, 12, __Value)
 #define SET_EARLYMODE_LEN4(__pAddr, __Value)			\
-	SET_BITS_TO_LE_4BYTE(__pAddr+4, 20, 12, __Value)
+	SET_BITS_TO_LE_4BYTE(__pAddr + 4, 20, 12, __Value)

 /*  */
 /* defined for TX DESC Operation */
@@ -100,7 +100,7 @@ enum TXDESC_SC {

 #define txdesc_set_ccx_sw_88e(txdesc, value) \
 	do { \
-		((struct txdesc_88e *)(txdesc))->sw1 = (((value)>>8) & 0x0f); \
+		((struct txdesc_88e *)(txdesc))->sw1 = (((value) >> 8) & 0x0f); \
 		((struct txdesc_88e *)(txdesc))->sw0 = ((value) & 0xff); \
 	} while (0)

@@ -138,9 +138,9 @@ struct txrpt_ccx_88e {
 	u8 sw0;
 };

-#define txrpt_ccx_sw_88e(txrpt_ccx) ((txrpt_ccx)->sw0 + ((txrpt_ccx)->sw1<<8))
+#define txrpt_ccx_sw_88e(txrpt_ccx) ((txrpt_ccx)->sw0 + ((txrpt_ccx)->sw1 << 8))
 #define txrpt_ccx_qtime_88e(txrpt_ccx)			\
-	((txrpt_ccx)->ccx_qtime0+((txrpt_ccx)->ccx_qtime1<<8))
+	((txrpt_ccx)->ccx_qtime0+((txrpt_ccx)->ccx_qtime1 << 8))

 void rtl8188e_fill_fake_txdesc(struct adapter *padapter, u8 *pDesc,
 			       u32 BufferLen, u8 IsPsPoll, u8 IsBTQosNull);
--
2.20.1


--xqnxwb3h3522s2yn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAEBCgAdFiEEpIrzAt4LvWLJmKjp471Q5AHeZ2oFAl79wesACgkQ471Q5AHe
Z2pFJgv/emdhtEWGrr3W/IhgH3IZ9XcWq4f1F7W1J998aP05iui9L01qxL2vvmmZ
pXRGfhAtSDwpES+AoBP0kdVpbRhAQswAwHhyD1YIa6muiJifKJaCL8HrI5qnlA+X
5Q+PrHIfqS5FD4YrjFIckf+AZ26F5npD/BtYASVDCq+9r7/gcqeLhPYqsVVSh7+0
Sb29Qw3WMrzlH8YG6F3H47VKZMktJsqNsjqqc2DcJGXdooghpAqbXq8EEcR1ciTU
EUdUKwUfbqKKUJriU1aBxD3RtMBdVkNcL1oBV3gfqeQoIXGZNxOTMg7nGv49Qrvq
vAJHnMMykBfhkA/p1q4tb1drA0iG77DzhLe1GOXpWxdao8Dfy42jP9FKr/AGhNjN
PcSTqs4bjxWTxkLDdPzzi4XK9k+U+Lu9qQu7P1Vl3brjlloKmnaXVu1nOEv4DjL9
V9WgDiqtYvOLsO/vkBoP4KA/ju05YaV+T7V6n6F/InGwQNhfTf0PgW4eZOxp+7Kw
vPyFW8AL
=N8aX
-----END PGP SIGNATURE-----

--xqnxwb3h3522s2yn--
