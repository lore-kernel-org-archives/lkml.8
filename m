Return-Path: <SRS0=maQP=AN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7862EC433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 04:58:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4927C20836
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 04:58:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=pesu-pes-edu.20150623.gappssmtp.com header.i=@pesu-pes-edu.20150623.gappssmtp.com header.b="mRqio+jt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726247AbgGBE6y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jul 2020 00:58:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725994AbgGBE6y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jul 2020 00:58:54 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 308A3C08C5C1
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jul 2020 21:58:54 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id d4so12862181pgk.4
        for <linux-kernel@vger.kernel.org>; Wed, 01 Jul 2020 21:58:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pesu-pes-edu.20150623.gappssmtp.com; s=20150623;
        h=from:date:to:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=Fu+uvM9GGFzgfzLNgXcB41BKzaY2S3FZ9C27Xg/uHdA=;
        b=mRqio+jtK77pER9SguqKN4DUy9Yk5svDt0sMHSvPa80h06LVav75AF+0YXwrXHPd6h
         cb5wlkEOlKAYpkBxJa6Dy08BfgpuwFbiFpQ+Anbv4+xBpD2GUW8wwfjyVbpfVrRQ9gKA
         v1WYzZpUOkxBWAX4hU1KodO0GCXnmXPXt9Jaq38+yEEVUW0hd/NvxV2vJAbj92nvcvo/
         WOzobNEsRi/ACTb4OoyPK1eBHbOb3ovfJAmhHLVzLh1QqUK3upFodjMJx0hN3s1mtyKM
         4zUWRztT7TYvpJ1hVeL7f2h51zrkgBCn32VtC9JB7Xe77xGV1+g6oilTiyiKbGDnyzgq
         A6vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=Fu+uvM9GGFzgfzLNgXcB41BKzaY2S3FZ9C27Xg/uHdA=;
        b=BUyEj99piiHRynl2C3/55ve33iNjMEU6Hy78oIX0c/EPtdtuSsOTqPS2RTZKabeUR9
         eFQ8GSfBrBqLZZq+SEbiK9R184hEbZA7ESA4eFO+lg5gYdh1zHbRXsE/pzGn2plCnjyk
         /2NMTif+jJFF5I6VqDuAxg2Zqip4uTujxJLn5jxyeXRdilGWPWiVGA7SR10YamlTn2VA
         Tkzkdt1rEvYsv1Qey+E9UsXRUAbPdRSL0kWyehBuL5hzBfyJfnImnwL4iz4NXON8zcwA
         nezxECZ3SmXfbZq00FE45k3O/lLP16Y+JsCcKCU6mbewTmSrLc3lfI7HSpz58tEXLG+m
         UBBg==
X-Gm-Message-State: AOAM530aBmycTUlFYPQIfWFE4huuj/ppo+muMx2AGiXKSzSTmHb3pzms
        7aNi1KGh/nc+Tx+OP5KWpsmg4A==
X-Google-Smtp-Source: ABdhPJyfmAZnIg+JFuPx3lJvM12dFnwMxKwQRb/ACEHZrZhd34wP1EvVY2s6yINGmrtkHWhq+GaEeA==
X-Received: by 2002:a65:60d4:: with SMTP id r20mr19455828pgv.436.1593665933697;
        Wed, 01 Jul 2020 21:58:53 -0700 (PDT)
Received: from localhost ([2406:7400:73:3271:908:f18a:1156:5c38])
        by smtp.gmail.com with ESMTPSA id az16sm6458568pjb.7.2020.07.01.21.58.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jul 2020 21:58:52 -0700 (PDT)
From:   B K Karthik <bkkarthik@pesu.pes.edu>
X-Google-Original-From: B K Karthik <karthik.bk2000@live.com>
Date:   Thu, 2 Jul 2020 00:58:45 -0400
To:     Larry Finger <Larry.Finger@lwfinger.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] staging: rtl8188eu: include: rtw_pwrctrl.h: fixed
 multiple parentheses coding style issues.
Message-ID: <20200702045845.terffnfygc4wl5cn@pesu-pes-edu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="tfd45ozx6ehvkinw"
Content-Disposition: inline
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--tfd45ozx6ehvkinw
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
+#define LPS_DELAY_TIME	(1*HZ) /*  1 sec */

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


--tfd45ozx6ehvkinw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAEBCgAdFiEEpIrzAt4LvWLJmKjp471Q5AHeZ2oFAl79aYUACgkQ471Q5AHe
Z2oxnQwAsLH/gSaEGzzK6uIBR1LEqvH8RFXY6G6t5tW0JrF6YOkha2fVqNMWpXWc
U/ZLtHO2ze+KtaYPIXPjBr+7vVNFU9YU6FJAPbtOTWDRPH6Vt6RzahEuhXFmfngW
w6Vke1gmbsvMJmB02alDIyC28Ti0hud5gGMEWgMDuZ9LM7kYOEY+hNnYS7eVGgyH
0M/uXJxaOh06EORkRsReGqG5jk8wKCNMTbKpv46/Oxk/NYfNLVvTT2psLX5eIaEc
mhvpDMzRh5WxMKZCFCqVGlqxQoYhPWz0BUU5+XKPvAXTcvfKkQKlJoJOuC7EPg8s
uKZPDmulnzIMk6O6rfl4HvmgO3+xtcBXSEFEpn6z1mxbV7mgbV/Op8I0+hciUMqm
PHvYlDpszesP1mP+J+EudYy49VtXtjt96a8kshZKQMaIneoEGRMVUjb10XEhgxKb
APvRq63hMqHzSeebHVlSb60DysP7SFKbhVfxdH10/8G00cVQmp2N/CGu0YguW7mL
VarfP7Zo
=R5w2
-----END PGP SIGNATURE-----

--tfd45ozx6ehvkinw--
