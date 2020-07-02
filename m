Return-Path: <SRS0=maQP=AN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E426C433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 11:18:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ED509208B8
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 11:18:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=pesu-pes-edu.20150623.gappssmtp.com header.i=@pesu-pes-edu.20150623.gappssmtp.com header.b="X2XS2kqy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728647AbgGBLSc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jul 2020 07:18:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726475AbgGBLSc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jul 2020 07:18:32 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AEA1C08C5C1
        for <linux-kernel@vger.kernel.org>; Thu,  2 Jul 2020 04:18:32 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id j19so6456085pgm.11
        for <linux-kernel@vger.kernel.org>; Thu, 02 Jul 2020 04:18:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pesu-pes-edu.20150623.gappssmtp.com; s=20150623;
        h=from:date:to:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=hpv92noNXKFQIELCQobv5aGCxAJ2KsOj9UAoixtSt6c=;
        b=X2XS2kqy/bZIyOyu1ULA/H+QtfgfiMDyKEjsIahG+lHzJ6q/B5q4ZANbPgDuV7lNRm
         I1h5lL4PqjnF5tKD304rVXRptyus1gzSwccHT+ImHIn09zB/bLT0Re7LzC0QD7yNHOKi
         VaPizAN5JgXCUzsmJV+0USOOcMJGcaaMkmEhp5/h1sa4iYsBIn9bvXhYZXg+QhaLwrD2
         1CJcbqNa+VOrpHkKfkdbPmEJZ5QosoQFQsZvV9cKmIrtT5QOk2/lBJGynRAkC8VChEPE
         g8cjqTN4Nemxa4Td2TOaGqc+y4pJvKxNRnj++6HhcweJSqksDHctQyXhiECVsMtL+7Gs
         bm6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=hpv92noNXKFQIELCQobv5aGCxAJ2KsOj9UAoixtSt6c=;
        b=tmJNok+1G/XcIB4N/RdebL/ulzYYvmOIRKOd95g/Z8TKOcinWIjgMqFFgaJZ9yjdvj
         Vp+4zaqoMQhJCq/6LEMSI1t9RgFClLD2iNtCVkhicxzzSGQLrDJhhASgsLIPLzNl2iuO
         GasNQVifMQ0nAdJ/IQPualWOG7NWjjCZ9boR4ko2/BlDW3Ie7+4DV7JEzaCAUIPTbNHp
         iADdOHacJj8liSckjCa6Dqv885BmYGVSS3zuFsc9jMiRN1PFpsZbTxA296rVboJg7HEJ
         yOtgPneU1WY2n7cb55vCcMwA89mu0hICYflcn6dKiMOgZPU3U0Q+wROOEOGO92SvShcX
         kZXA==
X-Gm-Message-State: AOAM533FeCftoBQeoorq8MaTA7Gu0vLsOsP/pVcaE2tR2JmveYZgQOwj
        +WQTZliLvFvl+5BZsNN/4d/osg==
X-Google-Smtp-Source: ABdhPJyUJQcGKm9KgClqnWTupG+/Bs3x9/Q2gimX0+YV6o5xHjuThoNrYM7Iv2Vy1pVRMEEth0kUJg==
X-Received: by 2002:a65:640c:: with SMTP id a12mr23929517pgv.88.1593688711513;
        Thu, 02 Jul 2020 04:18:31 -0700 (PDT)
Received: from localhost ([2406:7400:73:3271:908:f18a:1156:5c38])
        by smtp.gmail.com with ESMTPSA id 4sm8637361pgk.68.2020.07.02.04.18.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jul 2020 04:18:30 -0700 (PDT)
From:   B K Karthik <bkkarthik@pesu.pes.edu>
X-Google-Original-From: B K Karthik <karthik.bk2000@live.com>
Date:   Thu, 2 Jul 2020 07:18:23 -0400
To:     Larry Finger <Larry.Finger@lwfinger.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] staging: rtl8188eu: include: rtw_cmd.h: fixed a blank space
 coding style issue.
Message-ID: <20200702111823.hzvtrmag62plph5m@pesu-pes-edu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="cotxqrvu6kfbsmy5"
Content-Disposition: inline
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--cotxqrvu6kfbsmy5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

add blank spaces for improved code readability.

Signed-off-by: B K Karthik <karthik.bk2000@live.com>
---
 drivers/staging/rtl8188eu/include/rtw_cmd.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/rtl8188eu/include/rtw_cmd.h b/drivers/staging/rtl8188eu/include/rtw_cmd.h
index fa5e212fc9e0..002a797c6d0a 100644
--- a/drivers/staging/rtl8188eu/include/rtw_cmd.h
+++ b/drivers/staging/rtl8188eu/include/rtw_cmd.h
@@ -115,7 +115,7 @@ struct	setopmode_parm {
  */

 #define RTW_SSID_SCAN_AMOUNT 9 /*  for WEXT_CSCAN_AMOUNT 9 */
-#define RTW_CHANNEL_SCAN_AMOUNT (14+37)
+#define RTW_CHANNEL_SCAN_AMOUNT (14 + 37)
 struct sitesurvey_parm {
 	int scan_mode;	/* active: 1, passive: 0 */
 	u8 ssid_num;
--
2.20.1


--cotxqrvu6kfbsmy5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAEBCgAdFiEEpIrzAt4LvWLJmKjp471Q5AHeZ2oFAl79wn4ACgkQ471Q5AHe
Z2r1CQv8C2v6LH61YRDS0MeO1cNSBKoSjWzYL6gleqHuL0QLkCu9rCA1gdVjyk3L
ji2xAMrLnlqU6jh64b8933Xcj1030X5hkbVFHBrdYzxldhNw2lqpWfLxnXn+7N53
kDgjj0WFDVxZpRFpxdmwMYZ/xlg38X2p+4YNal34JUaIFmML3GyjikWZL5k6Q9c8
NsiYKFtQbF7J3BLv0giXi5IkBYb0zEmNhTv/AjBKeokhLNE6eA0q4+RpvB2bEu1K
vSqT74C/RZkyovnLG+v0C+uxLuhS9WeaUBUQk+AurO+HRmM2NIZONkVqxtgPuIzk
FBSFbtWXsd7X7y7dGG+8vU8aebZK1wGIplBj6SNu8520uCziK7zoJz7eCV5p4oUp
Iy3OnC6yRBWXwWURZTg8/XILiIR9KWuOB9/V/4YaiL7YumGu6XkMN00LtRK/t3/p
hYgk7ISq96yrnmOW1JxJdx59vfG1Uana0Ta63XXsHq1NvBSAIRkmpZFB3YXcbI5L
J9WhLaX3
=kgxc
-----END PGP SIGNATURE-----

--cotxqrvu6kfbsmy5--
