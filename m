Return-Path: <SRS0=maQP=AN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B0FDC433E3
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 04:52:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 529A8207E8
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 04:52:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=pesu-pes-edu.20150623.gappssmtp.com header.i=@pesu-pes-edu.20150623.gappssmtp.com header.b="RTgR1R4p"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726245AbgGBEvc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jul 2020 00:51:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725994AbgGBEvb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jul 2020 00:51:31 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77A6DC08C5C1
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jul 2020 21:51:31 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id w2so12051388pgg.10
        for <linux-kernel@vger.kernel.org>; Wed, 01 Jul 2020 21:51:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pesu-pes-edu.20150623.gappssmtp.com; s=20150623;
        h=from:date:to:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=/YARYDgAoocQGIiJPdXQ/OBNzg9SVquA525nyFPetjI=;
        b=RTgR1R4pF0FKxBMUiO1ySajqUMjzwSomk7BeRnUlSAheR8sN1yghpi81c7QzAPi30S
         Cd2RmKtaz1EAHX928beEqY8698DBkIlTm2d57H/jz+09SFQRZjqSqegfpIeMkrBc02J5
         4l2oLR8Vzl733jEo0n66VgSt6BHqpX0gTOWQyWroO5eocilGBNUjVV0k9z73iCmB1opi
         aC2bUeo3vIBOSQfgKiB2ixtz38ZfYEnkngbjD4S3Ei1vTRGufTAbIuRpjNV+ppWyT5fn
         W67O7zmu8DxPmnMFWrDKgh3+L1D4/Huhbp3sj/PNp6aT7/jqy4p4OBpM+u7XUdJdIsEk
         pA7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=/YARYDgAoocQGIiJPdXQ/OBNzg9SVquA525nyFPetjI=;
        b=F5poInzeFiX/2w+C/yNXgci3LhbBmDWSAI5tfV+zDYXO81D5LWB5f77vRm018yh4Gs
         lfyTaaewqhGF8EQT4Ak5+YRJ8ebJg/0vEWPzogy7CRA2YUWwSyLrQX2rG900ZPFmWPAC
         0ZMt5JR/TgfTHveOg7bB/XwAMEGuOJDY8Ht/Y8a0g0T6tqGaNfg2cbuQJDbTnCQIqmkv
         UY5YT8bRXcAAmb0H7xIRkTZvZFUlUxtuek2amI/3Z3iXqs5PaOdiL3jss8HRpVX/JwuR
         ijJ3ZpNpQJsa2RdZ/D/CcwXCd/97KAGYP3NL7Gnr/lh5ocNoII0bzBq6ELa3chhLa8Jt
         k8zQ==
X-Gm-Message-State: AOAM532hUa51WwCX5hUMhki0s48m2YFoITl+bJB0ZqORgfjSzJtgr7zg
        TsCvW1yKgzK/PGzF+lwy9YHNeCTJkyE=
X-Google-Smtp-Source: ABdhPJxPTZPC3w/d59Fp37ZizB8i5GBUp8REhCRxOQW8S18y3Z2Rbc7ie3Ym+iWR58XPlJoEGQBCoA==
X-Received: by 2002:a62:cf07:: with SMTP id b7mr25710527pfg.33.1593665490994;
        Wed, 01 Jul 2020 21:51:30 -0700 (PDT)
Received: from localhost ([2406:7400:73:3271:908:f18a:1156:5c38])
        by smtp.gmail.com with ESMTPSA id br9sm6310418pjb.56.2020.07.01.21.51.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jul 2020 21:51:30 -0700 (PDT)
From:   B K Karthik <bkkarthik@pesu.pes.edu>
X-Google-Original-From: B K Karthik <karthik.bk2000@live.com>
Date:   Thu, 2 Jul 2020 00:51:22 -0400
To:     Larry Finger <Larry.Finger@lwfinger.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] staging: rtl8188eu: include: rtw_pwrctrl.h: fixed
 multiple parentheses coding style issues.
Message-ID: <20200702045122.xysl7ctdke6wxedz@pesu-pes-edu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ks6c27hjdea646tv"
Content-Disposition: inline
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ks6c27hjdea646tv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

add parentheses since complex valued macros must be enclosed within parentheses.

Signed-off-by: B K Karthik <karthik.bk2000@live.com>
---
 drivers/staging/rtl8188eu/include/rtw_pwrctrl.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/rtl8188eu/include/rtw_pwrctrl.h b/drivers/staging/rtl8188eu/include/rtw_pwrctrl.h
index 404634999e35..c89328142731 100644
--- a/drivers/staging/rtl8188eu/include/rtw_pwrctrl.h
+++ b/drivers/staging/rtl8188eu/include/rtw_pwrctrl.h
@@ -84,7 +84,7 @@ struct reportpwrstate_parm {
 	unsigned short rsvd;
 };

-#define LPS_DELAY_TIME	1*HZ /*  1 sec */
+#define LPS_DELAY_TIME	(i*HZ) /*  1 sec */

 #define EXE_PWR_NONE	0x01
 #define EXE_PWR_IPS		0x02
@@ -201,7 +201,7 @@ struct pwrctrl_priv {
 };

 #define rtw_get_ips_mode_req(pwrctrlpriv) \
-	(pwrctrlpriv)->ips_mode_req
+	((pwrctrlpriv)->ips_mode_req)

 #define rtw_ips_mode_req(pwrctrlpriv, ips_mode) \
 	((pwrctrlpriv)->ips_mode_req = (ips_mode))
--
2.20.1


--ks6c27hjdea646tv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAEBCgAdFiEEpIrzAt4LvWLJmKjp471Q5AHeZ2oFAl79Z8oACgkQ471Q5AHe
Z2oL3Qv/Y9lIZMUuMYffWsvo/dS/mAzAgBEYtZmXv8NFysaG6SLLXr5euK0SRAtT
u5sziSw40waWJfp4O/DYMiTshprA8tTojvCjoSZP+jdLj/H/aduVAalCRvF8oCNU
ASaEip5GZUcFYKhFVEa/9qfjUd3gbZBEBuWpJhDyC3jx6cxeX+d7RKseKApNbF7j
aE7uXtGaZY14l8b0QPJWXbzN7aqVEIwkJujJKR6/0rLDxYtXD5GVYpW3+mTF103c
e9L3yGZCn/PMMnoE2eTB4oEXZhJWmcOj2lKVa17V0+ZFdkytmxhofxlYBfgRVUSR
yUI6keUD2Y3nO1Eh/xdCuxnCBFzl/sPk4ylYZLMn5RqI/icpNfhcuzCv/FsdkdHo
nLMHg/+TgyVFPDpj9uRSAQ8Nuuk17h/PE3fhgK3BklT+vcosH8YI2NKmN0MtEZkY
7Y3E8YJ+Rr5wG8KIER14sm6d721DGlJxjacCOVJu7jbTQtr/Y4sg7xD7mrjH7PZz
IR5raRTj
=fmwW
-----END PGP SIGNATURE-----

--ks6c27hjdea646tv--
