Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B9D0C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 20:45:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DDD73206C0
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 20:45:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=pesu-pes-edu.20150623.gappssmtp.com header.i=@pesu-pes-edu.20150623.gappssmtp.com header.b="pOimQYia"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389623AbgF2UpI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 16:45:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731588AbgF2TN7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 15:13:59 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79027C014ABF
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 01:07:55 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id h22so7695207pjf.1
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 01:07:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pesu-pes-edu.20150623.gappssmtp.com; s=20150623;
        h=from:date:to:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=OXfEAC8m7WsWKLpZr4RzDGbNAcYuuq3MdYSLZ6OlkGQ=;
        b=pOimQYiak1CbHv7d59idxDYghN9l3G41PcKqfxGsTfgpSIyxG5bc/7aq0zT/8EvPeg
         3WOVfr4BbAciS6IYJBubYgbglqDpFERjl3Wl6bg26bjYaNOSlNQeR4AmjHwQd+9GQt/C
         jgxzDtTZ7Hhb1+K5YI1ZhURetiPSEU0pdNEGmQCfHWsIfXTM2c42q88OmkMzLzsvMODM
         dDrvvtv7ewkFnHse3xS34IDEZqKUWdrKgctWslz1Yxzreg9yly1Z2Sfdk2da8yb2qdEn
         I850t9J/guTuiDkuwX8LnGsBDrWHDkns0XP2a0AmPABHqBQD7EVY9ARZsDLGjK/WZ9+4
         cd4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=OXfEAC8m7WsWKLpZr4RzDGbNAcYuuq3MdYSLZ6OlkGQ=;
        b=DgPSf633FCEHPiLPCg4QiFs55lvH2NUtQoaadzJxcbypbQYh5gO3SGL736Wa4SLbhJ
         /bF0z6dSoN7MMgq+ko+uxlLBUVmcOjEOG56YNhD3VlZfk5bP2hcTE6X8kn1y0tno2EsY
         XmtTqCncBOgd8t8ie36ysEshG3UcGAMF6K1DC5VOBlEyb6Kkx0BIJ1zXagUDOrNtvMlK
         caadJs8LVCDpRBvzh68LbAalJtgGK6DBl+N9hiLa6c/70sg0SEg5Ou7L4TtrRrhNoFti
         CMpPTln5LREZHMvFb9Ti16126UacGsQ4b+THx4m/nlSkN4V5Qb7c8iqMTOFgQ890JwVr
         uthQ==
X-Gm-Message-State: AOAM532sQdXlhXL6vYuPlfJbA5FQgcgZancq1swUMbKTgudMEKvskDBW
        xHYDX8g04HkaV13kx8dDH3m9rQ==
X-Google-Smtp-Source: ABdhPJxie99acwKP/77ZGxBZ2fXE0poRQF3nOSrZU7/tjM6WDJBL6sJEiEgmxDiYhMEZmiuSZA2KTQ==
X-Received: by 2002:a17:90b:1103:: with SMTP id gi3mr16296490pjb.110.1593418074892;
        Mon, 29 Jun 2020 01:07:54 -0700 (PDT)
Received: from localhost ([2406:7400:73:703c:908:f18a:1156:5c38])
        by smtp.gmail.com with ESMTPSA id s12sm3410494pgp.54.2020.06.29.01.07.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2020 01:07:53 -0700 (PDT)
From:   B K Karthik <bkkarthik@pesu.pes.edu>
X-Google-Original-From: B K Karthik <karthik.bk2000@live.com>
Date:   Mon, 29 Jun 2020 04:07:48 -0400
To:     Larry Finger <Larry.Finger@lwfinger.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Michael Straube <straube.linux@gmail.com>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] staging: rtl8188eu: include: odm.h: fixed a blank space
 coding style issue.
Message-ID: <20200629080748.l4ufcpuk4cg2m725@pesu-pes-edu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ky3s2llo3bsba3pz"
Content-Disposition: inline
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ky3s2llo3bsba3pz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

added blank space and enclosed a complex valued macro within parentheses for improved code readability.

Signed-off-by: B K Karthik <karthik.bk2000@live.com>
---
 drivers/staging/rtl8188eu/include/odm.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/rtl8188eu/include/odm.h b/drivers/staging/rtl8188eu/include/odm.h
index 9d39fe13626a..27bffc2ead66 100644
--- a/drivers/staging/rtl8188eu/include/odm.h
+++ b/drivers/staging/rtl8188eu/include/odm.h
@@ -244,7 +244,7 @@ struct odm_rate_adapt {

 #define AVG_THERMAL_NUM		8
 #define IQK_Matrix_REG_NUM	8
-#define IQK_Matrix_Settings_NUM	1+24+21
+#define IQK_Matrix_Settings_NUM	(1 + 24 + 21)

 #define	DM_Type_ByFWi		0
 #define	DM_Type_ByDriver	1
--
2.20.1


--ky3s2llo3bsba3pz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAEBCgAdFiEEpIrzAt4LvWLJmKjp471Q5AHeZ2oFAl75oVQACgkQ471Q5AHe
Z2qxIwv6A7R+6jcIxfrGZmDNs1aGiG271nP9bJyOcZS3Trkc4IAghcVyMsLkQ6UE
B7Zm32o/NMawi7DNQKowf9kMM2crNKY1vDQgxVm38zlJPjLl/QuSL2OQf9QiGw8h
vYghWNcxiMJAqdEfXJh92KLFqzNh8Kru7CQ3DLE2XDSMDx9ohXjqRmciUL4cfj7H
2r6PC8a1iPBKC42wC1zYu+RNhCCRgNSFRntYbdfz/wfJsFulH3Gw1X3vFa6YIVaC
NRRvpsM6hR/gDAEGe1YoZ9VDQy5/8BKuoIa/DNbQ0zJsSE2cVFpYqLquI0nSGu1u
DFpjyj7rZNAHdd3Vp7CXI3msFRkUHinXGww6SZfd7morZV+7+jzDEXjnX4rMwaXh
hjLE7LrB5l7IBIL5vgbSymptwTqc0coUaW0vFEjiWoWN/FUIP+Diml+FhUkUgFi6
4rHopvniFo2/7Lz9T0cIgEwMvoGwPxB+DUB6Av0MH2xoz7SO3Kao2U9P1eXJpLnk
doyI6Kvx
=SdWm
-----END PGP SIGNATURE-----

--ky3s2llo3bsba3pz--
