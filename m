Return-Path: <SRS0=maQP=AN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FA6AC433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 04:52:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D8C94206A1
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 04:52:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=pesu-pes-edu.20150623.gappssmtp.com header.i=@pesu-pes-edu.20150623.gappssmtp.com header.b="2C6v/dC0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726140AbgGBEsw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jul 2020 00:48:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725994AbgGBEsw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jul 2020 00:48:52 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02BA7C08C5C1
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jul 2020 21:48:51 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id b92so11976550pjc.4
        for <linux-kernel@vger.kernel.org>; Wed, 01 Jul 2020 21:48:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pesu-pes-edu.20150623.gappssmtp.com; s=20150623;
        h=from:date:to:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=oQ3N4vXqTW8GG4DAXes6EoCpeKFpzlLKogoAV6Wjej0=;
        b=2C6v/dC0WBh8tmgsHO2L7EIic6S67c2zrKy/mXfjGdJihoULveOTuW6sLGy+nGfRk2
         jVvhJrPupjTKGELHIJFwt7+xz+Q8t922rpmxTKAeUn7wX3CmjWpQCNAakgji7OxVXoBT
         Vk8V/NWjmMrZCxsvXFyYxL/z0l30LG25/rXmyTsONEuPgDHlrwjklQ0aFByGrvcgjoBU
         d2TZuGH+UzZCvnLg01E/Aa9mTXsuZ2dXcTSc56XuSCgOsl+Chw2ASpD9Vur/VXfxvfw1
         x5qHmxp2jE6gYbwhy+NGg0jWDnhCFpsurphqRpfzEOvjQBo6smsouW6dX2OFYgp4CiMm
         z5mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=oQ3N4vXqTW8GG4DAXes6EoCpeKFpzlLKogoAV6Wjej0=;
        b=cQ6GU5INd9Zmd0S6KaB9B0ghgL4yuNUir0WQDLND2rko0vZhaYfAIWs+it2/JpQAnl
         lWI7E6HRlIYXbIVPRbxKGrzP8gwUrBBF7OmouQX/9+jE37UURX4NshuvHO4N+Yfrj8Ho
         742p9dkLOjxF24+9ElADzicNowajkFPtOfrs7bXWARCVSNoKPMPOccRYyIi79OTqT57L
         sixqWXPR0fw6z0/eg1wrmcYAWNEC0I0O7UmFcW3wBOZQk5mpfb/l7qaLYTeUJQeA3s0X
         23hBdFkObznKVmvFy5ewErXzAnADDs/5n1xiDMBcbIGYg+uaUHa5K+6HBI1jp81k/Wim
         Vktw==
X-Gm-Message-State: AOAM530mvUMAeUY0Jeo7XLASg1AgrCmjt3TVkxP78hYm7AdDV5lgU2IL
        Hq7Tg97WEekG/iNhW9MSoLBh0Q4OtqM=
X-Google-Smtp-Source: ABdhPJw5Jn7mqfNG+tXD2LpL1G4eOtznyFzNWvzJLMgoEiEnIpQ+X7NJjIjzFWG6/bw1+n0mJ2stvA==
X-Received: by 2002:a17:90a:ba92:: with SMTP id t18mr14633976pjr.121.1593665331413;
        Wed, 01 Jul 2020 21:48:51 -0700 (PDT)
Received: from localhost ([2406:7400:73:3271:908:f18a:1156:5c38])
        by smtp.gmail.com with ESMTPSA id 10sm7278800pfx.136.2020.07.01.21.48.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jul 2020 21:48:50 -0700 (PDT)
From:   B K Karthik <bkkarthik@pesu.pes.edu>
X-Google-Original-From: B K Karthik <karthik.bk2000@live.com>
Date:   Thu, 2 Jul 2020 00:48:42 -0400
To:     Larry Finger <Larry.Finger@lwfinger.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Michael Straube <straube.linux@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] staging: rtl8188eu: include: rtl8188e_xmit.h: fixed multiple
 blank space coding style issues
Message-ID: <20200702044842.fbafuffk7zercbi7@pesu-pes-edu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="iu7gfz62fcrlikq2"
Content-Disposition: inline
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--iu7gfz62fcrlikq2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

added blank spaces to improve code readability.

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
+	SET_BITS_TO_LE_4BYTE(__pAdd r +4, 0, 8, __Value)
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


--iu7gfz62fcrlikq2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAEBCgAdFiEEpIrzAt4LvWLJmKjp471Q5AHeZ2oFAl79ZyoACgkQ471Q5AHe
Z2o2cQwAqSC3lz0HlNCcPFsaauk3Z8pcofy2MVL9gkQets+iIpd1e1hOuylVNQDL
fBcAZ8y4KGn8faaSEYmtT6m80aDAtMp3Qs62PIFV5cQ9/B46QH9apqRU46A9sqFl
/Zc20teXz+dSCRHFzsCucg7wNKWMofngdkehwEzK0FShND/9vTpwl3os9t/KXpSM
UbUksuCAiQEF3qAKSuI3uhxQ2IMjiLqL8V/PeX64T+aab9UWUFh1BxEOQe6SIAW7
OhfliYjcDoUA8+lmFbIA2PuJU68uqZDUZCAIWjK2oSZ4vMM7gu8xkEtzMj2ctL7T
th7Db5ahOxqPYI/aLxUQwi4xV7dO3IZazIYrRYJG97vdRFr5zPKmldWqr8MsqsrY
ctna0dpN3+RugiQpNmYOwCdaKXRPNYYwysGIlnbT2xKAym1Fejg3aN4sBLKbSDN1
CkWszngTVJ1U9wamOBb77UeZHYr6o3WpgT5iX2mVkdB8ufadGZ3OJEhqE8kgs1LN
E6arixhN
=Czbe
-----END PGP SIGNATURE-----

--iu7gfz62fcrlikq2--
