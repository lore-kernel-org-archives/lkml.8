Return-Path: <SRS0=maQP=AN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6211C433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 11:27:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C0B6520675
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 11:27:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=pesu-pes-edu.20150623.gappssmtp.com header.i=@pesu-pes-edu.20150623.gappssmtp.com header.b="HwiYMHSN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728806AbgGBL11 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jul 2020 07:27:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728502AbgGBL10 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jul 2020 07:27:26 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1E54C08C5C1
        for <linux-kernel@vger.kernel.org>; Thu,  2 Jul 2020 04:27:26 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id w2so12526865pgg.10
        for <linux-kernel@vger.kernel.org>; Thu, 02 Jul 2020 04:27:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pesu-pes-edu.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=xxVvosb2amin9BFIRGrxAO+BSau+UIIa0mUkKu+/RSI=;
        b=HwiYMHSNLGiPTj+eLoFYYCv8STpwSN+aakDFtwggFi06ZTR2rO9t4ieR6D8DYjOnFF
         CvtbEtrGTAyfxb4OVQhaeoHY0A4C5Oyt96WExj+7OQhIjay3oIbipdAZkjWqKoVKvdvu
         jD8rD+Pps9oMy05HYAhqiociLu200xBOfYthTHu04k5Y6Lg3jnXDh6sg+aOXm30V6Tpy
         LsgniJQH7U8PCY6WgucdlS6pUhxa1xf4IMN+Q0iRzF+OIU8Lksk0jJTArBvZFp3EvfO1
         7fidzsSCCg4bpmWczHlIYqiujSidsEdQ4q7HCdhSmzwX+oV7/DSaDvpkIuLmntvxfFMv
         oXSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=xxVvosb2amin9BFIRGrxAO+BSau+UIIa0mUkKu+/RSI=;
        b=QDR3Xg5RPQjZIzlT9t93psZfmZpYNjt6HrD+MS5SCiBqKuDqcfy9GpB0UxH0nuFg9d
         inn9oDcfdknBLiBt6HgB4dIlo+lySoAShhDN4RZwOTVzyj2wbgv05PxPTms+S7hOOl4o
         PjuAWGM4XzlOrhl0qtPfF7zKwSSe62eEYWpNMLVeV/Nz4cfQiqdON4W9MYlztogaARFp
         1Wp752BWBzLSXexwy7I6wb2dTjyne3HuYcFuTkswr7DbY7JuyyMET3u7MjvBUZjuQRud
         bBmH1XoudvXdPuvvoN80jjj2v8sv5LK+4CN/h68HA3mSqCWkZg6Hb0t9JcQf0mk6ju6k
         fOmg==
X-Gm-Message-State: AOAM531wMI5Ru1i3U+37OFXLy8Uc5SbKxVicxBhF4xkqLn2eqnma6LS7
        qjb/r7uh3GPaFJmSuMSOvivO5Q==
X-Google-Smtp-Source: ABdhPJx0kIoo4VzR6JkF+6ePeKECGCTXNBmGrMrL+khrUcm1al6vHhwWigbEzCR55cqth/kw9a2/1g==
X-Received: by 2002:a65:478a:: with SMTP id e10mr23853468pgs.146.1593689246428;
        Thu, 02 Jul 2020 04:27:26 -0700 (PDT)
Received: from localhost ([2406:7400:73:3271:908:f18a:1156:5c38])
        by smtp.gmail.com with ESMTPSA id k92sm7885691pje.30.2020.07.02.04.27.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jul 2020 04:27:25 -0700 (PDT)
Date:   Thu, 2 Jul 2020 07:27:18 -0400
From:   B K Karthik <bkkarthik@pesu.pes.edu>
To:     B K Karthik <karthik.bk2000@live.com>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] staging: rtl8188eu: include: rtw_pwrctrl.h: fixed a
 blank space coding style issue.
Message-ID: <20200702112718.igdpcicprid74pyj@pesu-pes-edu>
References: <20200702112210.th4aiiszhdtufbpe@pesu-pes-edu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="il2oqzpbqvyo7t3t"
Content-Disposition: inline
In-Reply-To: <20200702112210.th4aiiszhdtufbpe@pesu-pes-edu>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--il2oqzpbqvyo7t3t
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

-#define LPS_DELAY_TIME (1*HZ) /*  1 sec */
+#define LPS_DELAY_TIME (1 * HZ) /*  1 sec */

 #define EXE_PWR_NONE   0x01
 #define EXE_PWR_IPS            0x02
--
2.20.1


--il2oqzpbqvyo7t3t
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAEBCgAdFiEEpIrzAt4LvWLJmKjp471Q5AHeZ2oFAl79xJUACgkQ471Q5AHe
Z2os7wv+NYI8O0JJ4pDIYcg7pg3GvyVcwoP6mQWhqjP8V6ffl4iQ81Fra9bVxY3D
Zk6il9x7b1OQPpg1IcroQ26+asY/i7m6cPyYEOCmZbm89NmHNY9jFNtZB6tGMWp+
vQeCf8Bxh0VVlKB1/pDdSq3xYLR5xvFwYwsLT77bHjxIDuB2JPw5UauJdluPDmOH
7+/cP48TcWe+xR77TNWCnL+ldOStSCOJ3IlmxZqXyX4gsVyIKoXFGyg4YK8rPNR7
efKbpdwK761IfpfzW2FYiakJculdkQ2xtQWvgvLdqai5KMv+r1hcChVCOo3kYch0
oGfVol+YaONoLlSFkKuB8oS2rbhHKePSsPuoLKIcSVke6hGulUVq7zfR6NMXmnQw
wnPDsubkTlRRTxcMoVF5TEWWPGxi72TLFgZZengE9q6zdbkCmCN7cyFg4Xr17qT2
/6FHmJNt45tvOFDMhywLAb9z/uB3HOY/7NyczbZ6gTtn396CwV/xMpjrPNcj8THm
Ku0TDAFC
=P3nI
-----END PGP SIGNATURE-----

--il2oqzpbqvyo7t3t--
