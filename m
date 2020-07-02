Return-Path: <SRS0=maQP=AN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0A82C433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 05:00:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BCE26207D4
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 05:00:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=pesu-pes-edu.20150623.gappssmtp.com header.i=@pesu-pes-edu.20150623.gappssmtp.com header.b="pFEIifpa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726268AbgGBFAB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jul 2020 01:00:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725994AbgGBFAB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jul 2020 01:00:01 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5464C08C5C1
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jul 2020 22:00:00 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id u8so11609556pje.4
        for <linux-kernel@vger.kernel.org>; Wed, 01 Jul 2020 22:00:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pesu-pes-edu.20150623.gappssmtp.com; s=20150623;
        h=from:date:to:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=Pr1sEuloYTO3PoNym4dRyjYz9qutOl3oSwCRaMr1Qxg=;
        b=pFEIifpaBqZWHvwxUpSwh0W7TzHeaTDCSDtJ1ae/lb5eGHqX1AJ2pV1Jd8FVaA0Yiq
         m5OamhhubkR0o08wref97YKddAjP/s2+5FLM3seKRDDCgUnpuVOJz6Hwg1G8B03D7zIW
         5ildj3m+L/5NVN6lUl35/M5TiytE5eXxlnNEm/bdVCLtKTBSR1AKrI9jYNrWAhGXkbhF
         YLBuVJMXWb01NSDVWD0KVUL88hZ/ordoGNOIu/IEbJbCaDOibE+2Emx2jzLQX0jZd/Ie
         DwGwPugNG1JQnD4EP8Ye1OC6AhfrOi0Bdbfx2tS5AYZRU/pkq9W5ezwx3SXCiM8WEt+9
         knFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=Pr1sEuloYTO3PoNym4dRyjYz9qutOl3oSwCRaMr1Qxg=;
        b=B3Zm2KPqc8mflq93vORTM5yv3M/d139YJbGEtwJM8w1W1/BiZlV6WgVKChtMeIsMcx
         4r1o3w8AR9M/xlfRm+1Kr5soMe9HIQW9onx6SahbofPsAE80cejJrX7+OsFrOr5a2yRo
         SwuoJ6aHYD/PtnaYUOWwqeTtUyinzqo+1/usQsIsSvsKWBqc+nHyXsIcltvAzoo1mPsu
         uuqy8Gy5bhOznPjKOHxj56c9JtRfVHvphj+h/8sUXtMCR2HQvmB74X3q2BxmorpjXMZg
         hRgpdAM+hfc93UyZAQtOMj+4PK+o23VS6r8bdVFWjKqK77vv6ha1D0YPKZokRn6euF3M
         peEA==
X-Gm-Message-State: AOAM531bsxL2ZeoylyIX8/ET+7zXDGsa2EPeWI1eJcN0ZDO3dXjqlPfT
        uk99KabliBXeXh9V3O70ONt+1w==
X-Google-Smtp-Source: ABdhPJxJeD/qSJ2W5mN0WChKiANAnBgmITS+BdwTUUmTkLuh2e9SYjdr2/DSRzrng1kbTqu6gbjzNQ==
X-Received: by 2002:a17:902:8f83:: with SMTP id z3mr24313007plo.203.1593666000448;
        Wed, 01 Jul 2020 22:00:00 -0700 (PDT)
Received: from localhost ([2406:7400:73:3271:908:f18a:1156:5c38])
        by smtp.gmail.com with ESMTPSA id h17sm6936442pgv.41.2020.07.01.21.59.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jul 2020 21:59:59 -0700 (PDT)
From:   B K Karthik <bkkarthik@pesu.pes.edu>
X-Google-Original-From: B K Karthik <karthik.bk2000@live.com>
Date:   Thu, 2 Jul 2020 00:59:52 -0400
To:     Larry Finger <Larry.Finger@lwfinger.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] staging: rtl8188eu: include: rtw_pwrctrl.h: fixed a
 blank space coding style issue.
Message-ID: <20200702045952.upb3aroqvyo5o7u5@pesu-pes-edu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="arxmo2od4a4upx6r"
Content-Disposition: inline
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--arxmo2od4a4upx6r
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


--arxmo2od4a4upx6r
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAEBCgAdFiEEpIrzAt4LvWLJmKjp471Q5AHeZ2oFAl79accACgkQ471Q5AHe
Z2o9iAwAivoR5wWeV+tLwLnB+bL8rRMzoLHOVGGCMl32HWYU7W6i4djQ37CoQQtY
YknQEGY/1LojpxrqhyBcWmjfa9GE/ULREas/UClYmbxroG6ifuOwT7EFfWUkWSDy
0/nvwMyGQRr+2wxLE+4i0nmIb/oWIaTaCKSIHKFl0pVPMlS0lEDhjp8eE4j4S+m/
35waq0gwHTNEEw1H0cYF2NYKzLtrJ5xHaZw9OvAu6C+7p0FpkcALAsFQ3r2sIRY0
q1M/2obqlTkuawy47jsnPgevEknqR/eNvS+ndavVCZPDeYDdVeuPBfSNjacbNPJW
af5Ijhsl0uSYHFifkfbBx/x2pKnyWWsfHi6fOvHpn9W7oJPA41JzIDeT1Q62j4IT
RuWgzhi2ZH09hmQdhbbzX9xMVb0anadH8D/C6aJryKImMIkb/N08VzgUQsjvOzSg
a0Dl3Ui6AvhohVUrg62YYOniGLhMRFJ0+e4f+TP0W7HSyi6RV4w7VKuNLM7HONY/
5bWho8XF
=nlZX
-----END PGP SIGNATURE-----

--arxmo2od4a4upx6r--
