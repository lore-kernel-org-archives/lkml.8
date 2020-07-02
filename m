Return-Path: <SRS0=maQP=AN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6152C433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 04:57:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B9F34207D4
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 04:57:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=pesu-pes-edu.20150623.gappssmtp.com header.i=@pesu-pes-edu.20150623.gappssmtp.com header.b="TuqMrwUE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726107AbgGBE5o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jul 2020 00:57:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725994AbgGBE5n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jul 2020 00:57:43 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4F31C08C5C1
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jul 2020 21:57:43 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id gc9so5412223pjb.2
        for <linux-kernel@vger.kernel.org>; Wed, 01 Jul 2020 21:57:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pesu-pes-edu.20150623.gappssmtp.com; s=20150623;
        h=from:date:to:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=vpDDToAY/0u64vxOMayUbLKI/kNwLx2pDUSMO68DWgQ=;
        b=TuqMrwUEQPpanmCO7On25noMwjp6ZmTCErpmiNBMGb3Tfx04XJFPys/h6Q71d+CLjU
         cpB+8rOqlaMHvYOE9SuBmOB1VE2bX7HHm4LPVguw8jNNfKjdmheItvU33j920+ehQ+8m
         bq0pkR5CrxIW1pdvpOmdSmk59Dv+KQUFYs9IbdSQAIGtb5xfVDrZeY72jfEG6fynW5wr
         ktchQ4uZDf9BlTMULXGszN5OaFYw0EAp+KCFWmsbuo90X/QEGNTHqZEDyPIEbut3K0Zo
         qYPz8aSIjQNBJgfeLnxeE76zCa/gW2oglyZ2lO7OFFuPC2Dct/ND9REbLs+cQYmq4RJf
         z0vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=vpDDToAY/0u64vxOMayUbLKI/kNwLx2pDUSMO68DWgQ=;
        b=TevmZBjeXVdennyKY+l2DfwdYPwHfaNhztXwoDenphSlrQ98Oz4dFiRHQzAxIrjvoM
         b45Nami4GokRtnBBZntyIzDvM0HdcpRwUJRNeASwRlorAMFUXuOFQbA++EA3EPm79iA0
         ZbH758vlA3DGJyxoX9fqtHqOlb/2AkvE2Y3MZW3Jm97xVnfk14WPW1qH5QLy+D/ASgDA
         ZMbE9KLshqGeUh7e+gh587OxepczbpRrcoFQw59i9j1gYDwzX5gd0dtW8FkeOQizy8fK
         bXcUXxetDtBhCNCsQ+xtJxnPODDkds6msoEMIoHtwgLVuwfQq4skdXMSCp6GB3SAVtUI
         /5+g==
X-Gm-Message-State: AOAM533o7PHQWU941zDR6ZU7GWP0XDzlrpsa14nR9P4vquau4jhX+OQx
        XdDl02qrzWbLBfglho/4XSA/DQ==
X-Google-Smtp-Source: ABdhPJzXnSxuxbeuYQzBRza19+FnQTYRi03xOU3FLeHv46bFK7OAiDWEOiMMTE2RYuR9C4Rd6KX/gA==
X-Received: by 2002:a17:902:c405:: with SMTP id k5mr8896916plk.233.1593665863227;
        Wed, 01 Jul 2020 21:57:43 -0700 (PDT)
Received: from localhost ([2406:7400:73:3271:908:f18a:1156:5c38])
        by smtp.gmail.com with ESMTPSA id z8sm7684354pgz.7.2020.07.01.21.57.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jul 2020 21:57:42 -0700 (PDT)
From:   B K Karthik <bkkarthik@pesu.pes.edu>
X-Google-Original-From: B K Karthik <karthik.bk2000@live.com>
Date:   Thu, 2 Jul 2020 00:57:35 -0400
To:     Larry Finger <Larry.Finger@lwfinger.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Michael Straube <straube.linux@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] staging: rtl8188eu: include: rtl8188e_xmit.h: fixed multiple
 blank space coding style issues
Message-ID: <20200702045735.okpfchl5zmrynaam@pesu-pes-edu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="gzuhorb3v7t6g5ly"
Content-Disposition: inline
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--gzuhorb3v7t6g5ly
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


--gzuhorb3v7t6g5ly
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAEBCgAdFiEEpIrzAt4LvWLJmKjp471Q5AHeZ2oFAl79aT4ACgkQ471Q5AHe
Z2rdvQv+OKWpXlbme4xBg9lJ7aY5c4dS7Lynr4cMPDKm6SgohiefNuGH+rAxTjPz
DLmBlwnFkGWhzDY1qFAgnQVCseqYYMDKXAncBIjOnl6fsiIalGyU5k0Xm8roThsQ
cscI4o6yL8ugWWe5o0c+CIU/G3qZ1snqWUhNdGSZbND+ql3CM6+zBvGJp70g5FHY
LRRSAMak1TFmvbUTzRah6UD8GRnRNBrOGZbHM0YkeSKyUhKC6nANy8+x7L6YDKAR
5tPplL+jtVH+RJjihvGaIEGbyTrvQj8a3aH0TEmr1/yBTHMqc/Vgg0OkpN8dRtLD
oHI3JWVWOFWlj3LjbJK3/QjPT3OVQhNCGFKfOIvYJjfshujmrARvZxbUwdyDZ926
Wddws3/r917j5BpwWRtEHftNjo/gGlx+nQHnlDyA30mEsdmtYL/WVPMEwHGlk6os
y/+W1zmNalh90KTAV+o2x4G5SGfRRqpMThNdPrxMfG6xgrrdJgN0NNdg+Hfg5P0o
3ysR0bcZ
=cYvi
-----END PGP SIGNATURE-----

--gzuhorb3v7t6g5ly--
