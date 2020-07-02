Return-Path: <SRS0=maQP=AN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B35EC433E4
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 04:52:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6E38E206A1
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 04:52:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=pesu-pes-edu.20150623.gappssmtp.com header.i=@pesu-pes-edu.20150623.gappssmtp.com header.b="DpFxI1yM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726157AbgGBEwj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jul 2020 00:52:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725994AbgGBEwi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jul 2020 00:52:38 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74687C08C5C1
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jul 2020 21:52:38 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id 67so7918166pfg.5
        for <linux-kernel@vger.kernel.org>; Wed, 01 Jul 2020 21:52:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pesu-pes-edu.20150623.gappssmtp.com; s=20150623;
        h=from:date:to:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=D0fzDV6d+DhPIhu1xk99/I6s73Vn8AZolXIwVAG94/I=;
        b=DpFxI1yMZ5vpr2aIVjRL5vJJibjCGstgiWvQVYYAyB7eD5YmXwLQbZBJkCuOwSX2ES
         RFxnu0ea3uYGamC4DEIjEgsuuCLa/chiJrzJk60Seym9cPOXmd/fbn6HN8ZK/lxoAJWn
         GBhvO9kCfund8cY0pHKQIFm/5FIfv5vAE07p/ApdPIoo0C3iN+3RgnCbKGndfqr6TRcz
         rWtmBA8Dre/lB2ICQEI3Dl7lEGkynvsPTKmMLS+lci0/QZKcQK6IjNOeMyEQ40WM8SN8
         OmErpL71CHaCHcFD/HLeH0wxyhtRgk0pwwG3voi252SQ5ybZBFMagKw65C4qX2Qe7WaD
         sVRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=D0fzDV6d+DhPIhu1xk99/I6s73Vn8AZolXIwVAG94/I=;
        b=icIQPjZ6VxPXgJPjjXPDZorr9vyk2U0h6uFgzJxN210jb95lmNtRZYErDt/s732RG+
         ek36onZUhXbOsd7g5KjXAMImF7JJ2zwPUVKuNZhyanpXuAaebARI1nIoeYKRN0Tw12Ng
         EI+2sqJ8kTZN3vZPd/cneyhZd5EbI+FJDd5TlEEnMLIQe78DMBws1CS+DVKKtIaeasmy
         BR2/mqsYDXHra2cZCV9m1/8aNWXetXU52vOma1x8geLAUU89eV2te60Gk5Ypkp8gylhd
         +ppdU3UAd5qMm7/Lb/0fL7t9GKqHg0uizPP+uegUfi90uAtWJO6Re8p8bKYtCO8j6Vc+
         e7yQ==
X-Gm-Message-State: AOAM531bg/NZoZMw79LQP+SRk0vEeZmbL2RIy5V0J2CM3ZdoThKKldV4
        RmAamP6v+CamtSHzoR0Z9Y9IIQ==
X-Google-Smtp-Source: ABdhPJxVQHjRzTxGnZbx7lJlBX54b771nynXfP+KSK8qEd1f/DaP7MFu/QkkDf9fTBp6+tcIgjN4ag==
X-Received: by 2002:a63:3c09:: with SMTP id j9mr21042092pga.206.1593665557996;
        Wed, 01 Jul 2020 21:52:37 -0700 (PDT)
Received: from localhost ([2406:7400:73:3271:908:f18a:1156:5c38])
        by smtp.gmail.com with ESMTPSA id x10sm7553820pfp.80.2020.07.01.21.52.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jul 2020 21:52:37 -0700 (PDT)
From:   B K Karthik <bkkarthik@pesu.pes.edu>
X-Google-Original-From: B K Karthik <karthik.bk2000@live.com>
Date:   Thu, 2 Jul 2020 00:52:29 -0400
To:     Larry Finger <Larry.Finger@lwfinger.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] staging: rtl8188eu: include: rtw_pwrctrl.h: fixed a
 blank space coding style issue.
Message-ID: <20200702045229.4qvoictqtyq7pgds@pesu-pes-edu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="vaenm4hzlcnpktmd"
Content-Disposition: inline
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--vaenm4hzlcnpktmd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

add blank spaces to improve code readability.

Signed-off-by: B K Karthik <karthik.bk2000@live.com>
---
 drivers/staging/rtl8188eu/include/rtw_pwrctrl.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/rtl8188eu/include/rtw_pwrctrl.h b/drivers/staging/rtl8188eu/include/rtw_pwrctrl.h
index c89328142731..b4cf0f1ce6d3 100644
--- a/drivers/staging/rtl8188eu/include/rtw_pwrctrl.h
+++ b/drivers/staging/rtl8188eu/include/rtw_pwrctrl.h
@@ -84,7 +84,7 @@ struct reportpwrstate_parm {
	unsigned short rsvd;
 };

-#define LPS_DELAY_TIME	(1*HZ) /*  1 sec */
+#define LPS_DELAY_TIME	(1 * HZ) /*  1 sec */

 #define EXE_PWR_NONE	0x01
 #define EXE_PWR_IPS		0x02
--
2.20.1


--vaenm4hzlcnpktmd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAEBCgAdFiEEpIrzAt4LvWLJmKjp471Q5AHeZ2oFAl79aA0ACgkQ471Q5AHe
Z2qE8gv9HdNyih+caQXARUv5pkIbZDt+E4h30rUcBr6EeWSuYb2Ks5EGshaL3kaW
3VbCCmQBdcDyGUWadrKokOwml9A4PP4vTccV183NFfYP0gW/tlzG+aJDt+pu4BaB
Ho8+OeHY1mN2guLIUSdIxZJsQMuYNHA6UciZp32mALByyL2YvuSiDOx0XoNTCVa1
Q+8jTOnDF2BPzyBogPhE11meJvp1q6wIGDIi9WCPqGhrvN42OvQ10ugZ552IR/Ez
D5cSsviIUwffsehR3kRDikSL+DFVKucYAiGTHmfCEpMgBlkWp4v+jaGhT3VaeXha
QNQtOJyN8KW0anEE84Uoxqa+pWawczs1K1rW+I2v10CPgkL8ap843vi2RmzffKkF
6yTFOHf+L7Op2/03yApscLNFoqMPnByxll/hq4d9/Ds48UUuyoexSankOCD/4HUc
4g+gDinO/+NX7VJsKoJItng4P8K28A1braBgPa1MBZCbB1bpK6wHUkJBqhMbdh4g
oqpCwrz0
=/B2n
-----END PGP SIGNATURE-----

--vaenm4hzlcnpktmd--
