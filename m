Return-Path: <SRS0=rxDU=A5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BF56C433E1
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Jul 2020 09:14:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6E9F62073E
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Jul 2020 09:14:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=pesu-pes-edu.20150623.gappssmtp.com header.i=@pesu-pes-edu.20150623.gappssmtp.com header.b="zJhihHko"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726531AbgGRJOu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Jul 2020 05:14:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725809AbgGRJOt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Jul 2020 05:14:49 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 439A9C0619D2
        for <linux-kernel@vger.kernel.org>; Sat, 18 Jul 2020 02:14:49 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id mn17so7624034pjb.4
        for <linux-kernel@vger.kernel.org>; Sat, 18 Jul 2020 02:14:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pesu-pes-edu.20150623.gappssmtp.com; s=20150623;
        h=from:date:to:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=cKEpENRz6Co+TfaAIpmLq652jkpOnfh/vQOlcll5dLE=;
        b=zJhihHkos9vaDBR1NxjLfxGiRdluMRMauT1pn/C2UAcGOQVfDGFtWKDErCsYB/CJsR
         sbsS9X6kOuLNJ/Gv0iJrVo9CWjxRxasVJ7kYhhRPmBh2Ne7rwlnB8/q7CWz6GSfXZund
         LizhfmigqKmg20Qz/CO3yxYPWCBXxHwqBmIuegiM8YmzJAmUj2UzevEwmcYjJTAFYXHT
         /HOilfkZ5hahtLP8IzPwXZPqgkhsId6zT4Z2j/Lr9yVi/40iPkOwA2BFR8EX0JGWHry7
         nN26pMy0SgOmjzK18oL2xrnPQc8f/URxMF6G0GTlQULUHqm5NINs5RIUR7wkZe33V1MM
         zybw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=cKEpENRz6Co+TfaAIpmLq652jkpOnfh/vQOlcll5dLE=;
        b=FvCoTthmiRvQweb3iK7uMHIJXBoox8VKVeL/CUJ6sFseEmpfeKK9rGCLaIWMf23ngz
         M4XBlD5ZkwPMRV685sNXN6d6y2455cbq5ufL4Th48bIMPh+tTteBMbtmUlEoiAMtyMIR
         4s/wVyuQ/zJ0UBoCO7+M3YJhtQk+GY3lLxdNd+wuomN7cNI1mpOhBpgHqUNnYjX73b4a
         pAldsSbXhZdr3pdJ9QWcPjFQoMNOjUZ1gpf+dExtL4IT2fLeVjUJ8DFrf7YswohlCkuB
         Rf6455f5r4ooKlPntNFVCoK8nNrtXm5k0M8ooaSH6A/RoyXfwTi6+VlcCC/g+06Ll+YY
         0Y0Q==
X-Gm-Message-State: AOAM532UwJy4RgKVqgUWxadDzXCJdS1AWS0gxl/l4Dh662771py3cIiL
        QHh1QmNKKfOG0k555Dgr4FfNNXU0Lbw=
X-Google-Smtp-Source: ABdhPJw6ja/5O5yRBq5e2Ea4nArJXAFPCBBMagd931AXnWOtYQEEWcFYLwOL6mpoHhHwShsW8ZT77g==
X-Received: by 2002:a17:90b:33c2:: with SMTP id lk2mr5751576pjb.122.1595063688633;
        Sat, 18 Jul 2020 02:14:48 -0700 (PDT)
Received: from localhost ([2406:7400:73:207:8b43:3062:877d:c647])
        by smtp.gmail.com with ESMTPSA id r8sm10220303pfg.147.2020.07.18.02.14.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Jul 2020 02:14:47 -0700 (PDT)
From:   B K Karthik <bkkarthik@pesu.pes.edu>
X-Google-Original-From: B K Karthik <karthik.bk2000@live.com>
Date:   Sat, 18 Jul 2020 05:14:42 -0400
To:     Larry Finger <Larry.Finger@lwfinger.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Michael Straube <straube.linux@gmail.com>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/4] staging: rtl8188eu: include: fixed multiple blank space
 coding style issues
Message-ID: <20200718091442.xamnoawpguo42k7v@pesu-pes-edu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ocvxayynsj2aaq3w"
Content-Disposition: inline
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ocvxayynsj2aaq3w
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

fixed multiple blank space coding style issues
reported by checkpatch

Signed-off-by: B K Karthik <karthik.bk2000@live.com>
---
 drivers/staging/rtl8188eu/include/hal_com.h       |  2 +-
 drivers/staging/rtl8188eu/include/osdep_service.h |  2 +-
 drivers/staging/rtl8188eu/include/rtl8188e_hal.h  |  2 +-
 drivers/staging/rtl8188eu/include/rtl8188e_xmit.h | 12 ++++++------
 drivers/staging/rtl8188eu/include/rtw_cmd.h       |  2 +-
 5 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/staging/rtl8188eu/include/hal_com.h b/drivers/staging/=
rtl8188eu/include/hal_com.h
index 542e6e93ff8e..da772a6ebad3 100644
--- a/drivers/staging/rtl8188eu/include/hal_com.h
+++ b/drivers/staging/rtl8188eu/include/hal_com.h
@@ -81,7 +81,7 @@
 #define	RATE_ALL_OFDM_AG	(RATR_6M | RATR_9M | RATR_12M | RATR_18M | \
 				 RATR_24M | RATR_36M | RATR_48M | RATR_54M)
 #define	RATE_ALL_OFDM_1SS	(RATR_MCS0 | RATR_MCS1 | RATR_MCS2 |	\
-				 RATR_MCS3 | RATR_MCS4 | RATR_MCS5|RATR_MCS6 | \
+				 RATR_MCS3 | RATR_MCS4 | RATR_MCS5 | RATR_MCS6 | \
 				 RATR_MCS7)
 #define	RATE_ALL_OFDM_2SS	(RATR_MCS8 | RATR_MCS9 | RATR_MCS10 | \
 				 RATR_MCS11 | RATR_MCS12 | RATR_MCS13 | \
diff --git a/drivers/staging/rtl8188eu/include/osdep_service.h b/drivers/st=
aging/rtl8188eu/include/osdep_service.h
index 0d3e4a6e7e85..31d897f1d21f 100644
--- a/drivers/staging/rtl8188eu/include/osdep_service.h
+++ b/drivers/staging/rtl8188eu/include/osdep_service.h
@@ -82,7 +82,7 @@ void rtw_free_netdev(struct net_device *netdev);
=20
 /* Macros for handling unaligned memory accesses */
=20
-#define RTW_GET_BE24(a) ((((u32)(a)[0]) << 16) | (((u32) (a)[1]) << 8) | \
+#define RTW_GET_BE24(a) ((((u32)(a)[0]) << 16) | (((u32)(a)[1]) << 8) | \
 			 ((u32)(a)[2]))
=20
 void rtw_buf_free(u8 **buf, u32 *buf_len);
diff --git a/drivers/staging/rtl8188eu/include/rtl8188e_hal.h b/drivers/sta=
ging/rtl8188eu/include/rtl8188e_hal.h
index ba7c98712934..3be28a6dbd49 100644
--- a/drivers/staging/rtl8188eu/include/rtl8188e_hal.h
+++ b/drivers/staging/rtl8188eu/include/rtl8188e_hal.h
@@ -104,7 +104,7 @@ enum usb_rx_agg_mode {
 	(WMM_NORMAL_TX_TOTAL_PAGE_NUMBER + 1) /* 0xA9 */
=20
 /* Chip specific */
-#define CHIP_BONDING_IDENTIFIER(_value)	(((_value)>>22)&0x3)
+#define CHIP_BONDING_IDENTIFIER(_value)	(((_value) >> 22) & 0x3)
 #define CHIP_BONDING_92C_1T2R	0x1
 #define CHIP_BONDING_88C_USB_MCARD	0x2
 #define CHIP_BONDING_88C_USB_HP	0x1
diff --git a/drivers/staging/rtl8188eu/include/rtl8188e_xmit.h b/drivers/st=
aging/rtl8188eu/include/rtl8188e_xmit.h
index 49884cceb349..1472c597cc53 100644
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
=20
 /*  */
 /* defined for TX DESC Operation */
@@ -100,7 +100,7 @@ enum TXDESC_SC {
=20
 #define txdesc_set_ccx_sw_88e(txdesc, value) \
 	do { \
-		((struct txdesc_88e *)(txdesc))->sw1 =3D (((value)>>8) & 0x0f); \
+		((struct txdesc_88e *)(txdesc))->sw1 =3D (((value) >> 8) & 0x0f); \
 		((struct txdesc_88e *)(txdesc))->sw0 =3D ((value) & 0xff); \
 	} while (0)
=20
@@ -138,9 +138,9 @@ struct txrpt_ccx_88e {
 	u8 sw0;
 };
=20
-#define txrpt_ccx_sw_88e(txrpt_ccx) ((txrpt_ccx)->sw0 + ((txrpt_ccx)->sw1<=
<8))
+#define txrpt_ccx_sw_88e(txrpt_ccx) ((txrpt_ccx)->sw0 + ((txrpt_ccx)->sw1 =
<< 8))
 #define txrpt_ccx_qtime_88e(txrpt_ccx)			\
-	((txrpt_ccx)->ccx_qtime0+((txrpt_ccx)->ccx_qtime1<<8))
+	((txrpt_ccx)->ccx_qtime0 + ((txrpt_ccx)->ccx_qtime1 << 8))
=20
 void rtl8188e_fill_fake_txdesc(struct adapter *padapter, u8 *pDesc,
 			       u32 BufferLen, u8 IsPsPoll, u8 IsBTQosNull);
diff --git a/drivers/staging/rtl8188eu/include/rtw_cmd.h b/drivers/staging/=
rtl8188eu/include/rtw_cmd.h
index fa5e212fc9e0..002a797c6d0a 100644
--- a/drivers/staging/rtl8188eu/include/rtw_cmd.h
+++ b/drivers/staging/rtl8188eu/include/rtw_cmd.h
@@ -115,7 +115,7 @@ struct	setopmode_parm {
  */
=20
 #define RTW_SSID_SCAN_AMOUNT 9 /*  for WEXT_CSCAN_AMOUNT 9 */
-#define RTW_CHANNEL_SCAN_AMOUNT (14+37)
+#define RTW_CHANNEL_SCAN_AMOUNT (14 + 37)
 struct sitesurvey_parm {
 	int scan_mode;	/* active: 1, passive: 0 */
 	u8 ssid_num;
--=20
2.20.1


--ocvxayynsj2aaq3w
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAEBCgAdFiEEpIrzAt4LvWLJmKjp471Q5AHeZ2oFAl8SvYEACgkQ471Q5AHe
Z2rH6gv+JB9f+nV+qCQ5xtnIgag9pexlAWAX4Oeq1xoikQAIHLjugaLCyThe4oAy
AfuhaVgvFMBXIwCYACz7bZB0fDZFW9wBv6yhjQKDgOkXrHC1Zgnnb8MfA0rT9oDJ
vwweeEs1XuURsFu9aq2nTFpFdKebD3GqSx5T4cyZpQf19ClKFDGhtF3pZjmn5xmk
MB3qEzYs5h2zoY0TH/laeUL1TR7fzzLGFbnSGrkfSfYxShqlr9abIiYRsGmfkm+G
OgLgniwYIXG1TVGCgwTucDdt1G8gBHqR+86NemvfSOdjiI577aWcBqcWUrCqlQZA
BS9bcdKPlKVxq+ty60UeBJd+cKgfJdjZmhROpG3M9H8TQc9XNbn28vkua9bugG+r
qBPMAlmmASKpYxz4zNa6zSRMw3Kf4MrJ3qug5JnxFnn1L58MN4CHE4SRWZrebOdN
TM8Xa7pkRzOtmHfSyHD0L7Aozu7p9GarAfmSIY9EvrVz0JJPynMrwXjeyxBIzuPZ
8xAlwBsJ
=39RY
-----END PGP SIGNATURE-----

--ocvxayynsj2aaq3w--
