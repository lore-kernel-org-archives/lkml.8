Return-Path: <SRS0=maQP=AN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58D8BC433E2
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 04:52:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 34F5E206A1
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 04:52:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=pesu-pes-edu.20150623.gappssmtp.com header.i=@pesu-pes-edu.20150623.gappssmtp.com header.b="RpxYDqla"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726142AbgGBEuN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jul 2020 00:50:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725994AbgGBEuN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jul 2020 00:50:13 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 692B6C08C5C1
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jul 2020 21:50:13 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id c1so4716558pja.5
        for <linux-kernel@vger.kernel.org>; Wed, 01 Jul 2020 21:50:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pesu-pes-edu.20150623.gappssmtp.com; s=20150623;
        h=from:date:to:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=F6LmeZX+6/twUDfqjCU4/+RVNpb2JuA2WcOC1ESyj6M=;
        b=RpxYDqlaOg+aSsozjdEH7TQfJZAZ7oKftHWfuxeffKsxYulJ4iEsGsetssji0IFCWG
         /eJO3DqsNCPVlsX6A771WSE0FkGM2pTwP9l6HhqEegFWErxXjuDHnHgmU1rJRhYn3WSV
         FgFeynLee6MaVCHNzoCM82jlqbnqv6LGQAczZ3FJJkmawahIfFFzq9ahnLyZckCx3eO+
         +VJkl684m9o4DqxjzYoqzkh+6bFFQePdr7gOpFQQSjk46VSZzhSbF/HI9981AcAjdk3j
         hrdEFlVlmylgQ06nTVqF3Bf6i2t7hcWCP0FQSSRegAd3fwVKPIZeYJCs8CVWWN0TQn8H
         5OeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=F6LmeZX+6/twUDfqjCU4/+RVNpb2JuA2WcOC1ESyj6M=;
        b=QZD/vQcluqaH4erRGUJrcw038uDsRkFde/WKINa4gfPdLwTF6W2tQs4IXRZcWFsXt5
         +SW6/YQxsVz45K0nMKLxpMd2gCqNc69eUW00esUAbUlVBMvGwCBw5g2JiH/QJ46CH6o9
         n3Tsy2wDVe4pCas2w7tjd1vt4n/FmFCNb6b3CxNrlTHi8CECXKzv9ZKO23uL0n8xkXim
         dCDjHIziHbc1VraQPa9WcaSxoBuQl/qXCsqv8hZ89l1Q+v+9XCO8koUFcB4K6T6TZsyu
         enlgwYpWMI0mHyhdOOOG2N7FzMKDS+E73tdR7R2XO+Swakux97T3g43pFq4DJzyH9VxA
         zvAQ==
X-Gm-Message-State: AOAM531j5lxqPiylA+baObu20bG2GucNuHme8vbJpMFj7uas1hls1h3+
        moOHmDHG1rc95Hjx6Us01BsH/w==
X-Google-Smtp-Source: ABdhPJw/dn0+RNR+K+qxXnTc0cST1WTsW5nKfm6ePohk8OsZskJJix5DKMHIdYwJwJgsb5nitMHv1g==
X-Received: by 2002:a17:90a:3a81:: with SMTP id b1mr25434275pjc.217.1593665412996;
        Wed, 01 Jul 2020 21:50:12 -0700 (PDT)
Received: from localhost ([2406:7400:73:3271:908:f18a:1156:5c38])
        by smtp.gmail.com with ESMTPSA id l9sm6119303pjy.2.2020.07.01.21.50.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jul 2020 21:50:12 -0700 (PDT)
From:   B K Karthik <bkkarthik@pesu.pes.edu>
X-Google-Original-From: B K Karthik <karthik.bk2000@live.com>
Date:   Thu, 2 Jul 2020 00:50:04 -0400
To:     Larry Finger <Larry.Finger@lwfinger.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] staging: rtl8188eu: include: rtw_cmd.h: fixed a blank space
 coding style issue.
Message-ID: <20200702045004.5wp7fnzw5pg4yov5@pesu-pes-edu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="zygqjcf6nxczcpxr"
Content-Disposition: inline
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--zygqjcf6nxczcpxr
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


--zygqjcf6nxczcpxr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAEBCgAdFiEEpIrzAt4LvWLJmKjp471Q5AHeZ2oFAl79Z3wACgkQ471Q5AHe
Z2o58gwAg8Y6R1M+CQCan4VuSvGWvCvzR4lR/I2qDwvNYyK0oKRvch/PWcYex/cz
xaSHE4YHRJONZAbtkNM+twahIBfysdb2ZoHzKsQnSOa3oSmMpP6E5jsmi9yAfNJO
IgwqnU3bYNGr2ocA8tSLsq+MhbcdKy9ftu1GL7+bzdpUlmVb/muWZiRewq2CBjkE
CnNUFEemCpBOn5bORWNepScnl5siOzXBWOlxM8nt1t+XDs9qtSsYXLoTNNnaiL9u
YZ/I6NM6jMha7g44mO1+QxXZMbEtN3GAuqr+BF2kxaWo5y20W5ABPhNOU6CDrl2c
pC5BHmrEuSb8U4kiWtfGAyXOAKbdByKiOSFkjjgkJ5vRWxPWKXnfr/vWHJ4MILTU
Ydh+6v6cw4wygnTr8TClx64q/FyBHk4CE1VhGDTT+bg2SpgHLXxZRqvaxu1wJen2
D0c2Wf1k1p48ZEMFS7IBOuQ3H586BQQ7jZh0hYcBPJJj1MSlSqyP0WdU24MSvLai
rO+rrgcX
=x9Gc
-----END PGP SIGNATURE-----

--zygqjcf6nxczcpxr--
