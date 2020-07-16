Return-Path: <SRS0=y5Sx=A3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B3A3C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 15:25:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2FEA1206F5
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 15:25:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=pesu-pes-edu.20150623.gappssmtp.com header.i=@pesu-pes-edu.20150623.gappssmtp.com header.b="XurTJMQX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728856AbgGPPZ4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jul 2020 11:25:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728638AbgGPPZ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jul 2020 11:25:56 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F95DC061755
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jul 2020 08:25:56 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id b92so4837724pjc.4
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jul 2020 08:25:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pesu-pes-edu.20150623.gappssmtp.com; s=20150623;
        h=from:date:to:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=RMKMbC5jYSfPNsKIURX7KQu3FS04i/MQG7VAJB3u/Kg=;
        b=XurTJMQXdm8hRwI+aCQKonbNg+WUWjOVflr2fLG+ZlavH5vJ3sZWzyX8e+3lQT6nww
         Fqaj31wduC2ih/0GDg1qJMsLORsBrfa9THtII199vpWx1MCYgYjsB4Zer9F0fd+/9zwJ
         JtBNxeGVCMYFrwK2cFVnWg3Bt1uR53YWvWjQ+L6502WZcuvEkX1zhOn3zFxCdFrtZuIm
         tgso+MFNt5TccK0rKHVHCf15jJO02Sfz3O7no3Nrq0H5WM6Qq7osal444fjhMmWUmZG3
         FwYshoN8R/vGAbjfoJOF8pUWL/EJ9PmS3O4VRft+4l0vnVI35R7kDBnuB3K9O+I07Kl/
         mFag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=RMKMbC5jYSfPNsKIURX7KQu3FS04i/MQG7VAJB3u/Kg=;
        b=opKIfs0T3E0cYgegAypwGxbvoXJiSh84ty0vLfWVPNrMidyUgzjVmwtttgkabHZ4jX
         fFW0hYMCZDF/TyS0hsC4ayzOiU6wkaTefJK3dG+0ZgEyxsE8P47P02dqj9v4G1tpkSLD
         w98+bfEMjenqupFMCS2V4TOvTIfsodoT7wMoQhM4gSrLffZnTnouu6eX+wGOdMJSHZAp
         JK6StnyjFkeywnseM5HZaMJ8y6y9MM7r+80+xUbeeG8nYQYD/RqVWhFzPgQoQ/CNiLJ+
         7dBsju2FGXL1ox48AznV8cpwT+h5ulfEAy0ovX5xrZ5sUdBhhaXHgmBLkS3b2lGJlgEs
         KZ6Q==
X-Gm-Message-State: AOAM530CNZqMHOIlvJJcu/6yW9hDGLIK9BNp51MBWPyLGeFTiz2K6rAa
        Lapr+3FWgQxMwAsp+V103Jnl4w==
X-Google-Smtp-Source: ABdhPJw5Sm980CfM4G+paonG0HR3QSkTZxo5X/EFbD+kPoIcLmEZimn9jiNJgAXAORDPwlyuaB3YZQ==
X-Received: by 2002:a17:90b:196:: with SMTP id t22mr753125pjs.13.1594913155420;
        Thu, 16 Jul 2020 08:25:55 -0700 (PDT)
Received: from localhost ([2406:7400:73:bebb:9750:968d:7cd5:3ec7])
        by smtp.gmail.com with ESMTPSA id c207sm5162589pfb.159.2020.07.16.08.25.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2020 08:25:53 -0700 (PDT)
From:   B K Karthik <bkkarthik@pesu.pes.edu>
X-Google-Original-From: B K Karthik <karthik.bk2000@live.com>
Date:   Thu, 16 Jul 2020 11:25:48 -0400
To:     Ian Abbott <abbotti@mev.co.uk>,
        H Hartley Sweeten <hsweeten@visionengravers.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Vlastimil Babka <vbabka@suse.cz>,
        Xiyu Yang <xiyuyang19@fudan.edu.cn>,
        Michel Lespinasse <walken@google.com>,
        Divyansh Kamboj <kambojdivyansh2000@gmail.com>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4] staging: comedi: comedi_fops.c: added casts to get rid of
 sparse warnings
Message-ID: <20200716152548.mzau4zhurwkzp5p6@pesu-pes-edu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="jmkhzignupuhzb25"
Content-Disposition: inline
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--jmkhzignupuhzb25
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

fixed sparse warnings by adding a cast in assignment from
void [noderef] __user * to unsigned int __force *
and a reverse cast in argument from
unsigned int * to  unsigned int __user * .

v1 -> v2:
- Add a reverse cast in argument
v2 -> v3:
- Change commit description as suggested by Ian Abott
v3 -> v4:
- Add versioning information in commit description

Signed-off-by: B K Karthik <karthik.bk2000@live.com>
---
 drivers/staging/comedi/comedi_fops.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/comedi/comedi_fops.c b/drivers/staging/comedi/=
comedi_fops.c
index 3f70e5dfac39..9cdc1e8a022d 100644
--- a/drivers/staging/comedi/comedi_fops.c
+++ b/drivers/staging/comedi/comedi_fops.c
@@ -2956,7 +2956,7 @@ static int get_compat_cmd(struct comedi_cmd *cmd,
 	cmd->scan_end_arg =3D v32.scan_end_arg;
 	cmd->stop_src =3D v32.stop_src;
 	cmd->stop_arg =3D v32.stop_arg;
-	cmd->chanlist =3D compat_ptr(v32.chanlist);
+	cmd->chanlist =3D (unsigned int __force *)compat_ptr(v32.chanlist);
 	cmd->chanlist_len =3D v32.chanlist_len;
 	cmd->data =3D compat_ptr(v32.data);
 	cmd->data_len =3D v32.data_len;
@@ -2983,7 +2983,7 @@ static int put_compat_cmd(struct comedi32_cmd_struct =
__user *cmd32,
 	v32.stop_src =3D cmd->stop_src;
 	v32.stop_arg =3D cmd->stop_arg;
 	/* Assume chanlist pointer is unchanged. */
-	v32.chanlist =3D ptr_to_compat(cmd->chanlist);
+	v32.chanlist =3D ptr_to_compat((unsigned int __user *)cmd->chanlist);
 	v32.chanlist_len =3D cmd->chanlist_len;
 	v32.data =3D ptr_to_compat(cmd->data);
 	v32.data_len =3D cmd->data_len;
--=20
2.20.1


--jmkhzignupuhzb25
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAEBCgAdFiEEpIrzAt4LvWLJmKjp471Q5AHeZ2oFAl8QcXwACgkQ471Q5AHe
Z2pXMwv/dD/m/gD6ll7ullSAXYCoCM7i9lvWbRpA9dp3rk3rmqQnig1pL0sM5NfN
O+ce32drCrgL41P41bKYbZA5FzaLZnsyobrp+4uDIN4dsy+tYOxqXevIW1+7la0F
8NsA3hbZwrTWlxXCuiGysLN3axa7/ZkVFTdgvbmo1QyZaWIUn0GEGM9Pu/+VuHJu
X6zo0C4wgdHdxwAVOWE9q8Rf7AVC+cqLCmD32+OvyAxDONgdflijKJRJaFYnBitv
9tcxrrvxMDcFcUp3k03NIeMj6gtyOmXjR8/6jSouGolkdwPSXe5en1f6WkciGC1N
D6WsfImiVaOzrtZG73ga7dUPyRqj5Ra0KA2MZSuPLks1H6dGz1W4gzCO0r1FRGM0
acxoIlW0fuFDnX2qUehcLN7ZnFy3dnVazNzzKqE3jSUIJ0Drzwljr4udE7btBITO
LCzrHlJJVZHeUpGam5Wf/1SvDoKk0sf15Y9TGLEWXc4HYnw7ghC12L4JdvBbeKxg
uOH84aY2
=RRHD
-----END PGP SIGNATURE-----

--jmkhzignupuhzb25--
