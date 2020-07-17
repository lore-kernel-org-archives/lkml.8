Return-Path: <SRS0=w5GM=A4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2C2FC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 10:30:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 78AA52070E
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 10:30:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=pesu-pes-edu.20150623.gappssmtp.com header.i=@pesu-pes-edu.20150623.gappssmtp.com header.b="i6Qm5Xrm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726439AbgGQKak (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jul 2020 06:30:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726000AbgGQKaj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jul 2020 06:30:39 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D9C8C061755
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jul 2020 03:30:39 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id d4so6479360pgk.4
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jul 2020 03:30:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pesu-pes-edu.20150623.gappssmtp.com; s=20150623;
        h=from:date:to:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=O8Rb4ehIk0UZ6E5odInG38hop6T9BR/0TgqD2swqKlQ=;
        b=i6Qm5XrmD92+y/wj2u+SJM0+Oz7MzBYO8yRiSCHhnyNyfLVZYWczAuMM8whuRR35J3
         3GirgXTB6vXFF3Z4MXMDG1cpo7P+2ghbpOU/S/zeI6IgJk7nW9w+sRA7JDhQjjOnxcXp
         Z0uKiyGpnriYW89rE/pHymZk9sFq/QM4Jbf6rkSDx0FVCsxj3jj/cBbPo2qHBG/lfVL8
         EiR0b27CbHQtKsIpW2TljgxjgaM5VtsiDdsTXFp957BYTR+PKZb3mO1h+9IG8UJUG4GN
         85YlR33nqv5KfJMgWyztMFuKdN14Kg071V9PAyHHIXXmZHPkqKowcjG73CDQQrhAdORc
         9XOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=O8Rb4ehIk0UZ6E5odInG38hop6T9BR/0TgqD2swqKlQ=;
        b=i7Fvb2+//jRqYscD77sF26RlVV/djRP97ammDm5m8g1SvmzfRxPyC8URH4RRZTLnG3
         MSko7Ihp3QMmkQIVd88X8Fg6h5pjCXiMXCC14rw76R6gda+yWdA/XcuE5VbcPFxLTOZb
         y/u7OOosMY9yyLOXD7TOgxTx4wNpUdreXRPbjNIoZIZ+efrTc/kCrk4M6F8tV0sjJ6ki
         BkEavaHkKXyuiPXzliCF1jMAAIaDDlfzyCYn2xe0jvrCAVn/cUEOw7r5t7sOlkWRa0jR
         tcXuImk4nrqYr9bRSQdF+29NYilHGpSuxGP7sOcfj+DMn3QmoEvcoY4XpXXB07BsWchP
         gWWQ==
X-Gm-Message-State: AOAM5301FbH/FKVo1c/aeQ7Bc6I8baOc1t4KUWqgDbiTOVZQ/8otFPvj
        YDkiBh4o+vEx9ncqg8fuxXTpRg==
X-Google-Smtp-Source: ABdhPJyhqntyH8+/xcS4Ig6qyFqVGttcJl3h3ca/nXRjO2lCkRDpSrbH1FSMrXf+7NuD41F+nzxYAg==
X-Received: by 2002:a65:6554:: with SMTP id a20mr7071306pgw.301.1594981838660;
        Fri, 17 Jul 2020 03:30:38 -0700 (PDT)
Received: from localhost ([2406:7400:73:f893:55c8:468b:6675:c054])
        by smtp.gmail.com with ESMTPSA id f72sm7297633pfa.66.2020.07.17.03.30.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2020 03:30:37 -0700 (PDT)
From:   B K Karthik <bkkarthik@pesu.pes.edu>
X-Google-Original-From: B K Karthik <karthik.bk2000@live.com>
Date:   Fri, 17 Jul 2020 06:30:31 -0400
To:     Ian Abbott <abbotti@mev.co.uk>,
        H Hartley Sweeten <hsweeten@visionengravers.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Xiyu Yang <xiyuyang19@fudan.edu.cn>,
        Vlastimil Babka <vbabka@suse.cz>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michel Lespinasse <walken@google.com>,
        Divyansh Kamboj <kambojdivyansh2000@gmail.com>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH v5] staging: comedi: comedi_fops.c: added casts to get rid of
 sparse warnings
Message-ID: <20200717103031.3mfnlvqo3waolsee@pesu-pes-edu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="7wrplbydiie2qrlz"
Content-Disposition: inline
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--7wrplbydiie2qrlz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

fixed sparse warnings by adding a cast in assignment from
void [noderef] __user * to unsigned int __force *
and a reverse cast in argument from
unsigned int * to  unsigned int __user * .

Signed-off-by: B K Karthik <karthik.bk2000@live.com>
Reviewed-by: Ian Abbott <abbotti@mev.co.uk>
---
v1 -> v2:
- Added a reverse cast in argument
v2 -> v3:
- Changed commit description
v3 -> v4:
- Added versioning info in commit description
v4 -> v5:
- Move versioning info below the divider line

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


--7wrplbydiie2qrlz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAEBCgAdFiEEpIrzAt4LvWLJmKjp471Q5AHeZ2oFAl8RfccACgkQ471Q5AHe
Z2olwQwAq3x8BJVFPqVKJHIME24hUIUYy/l2VmcCJt2dJm889o5AOO/+sBbbEqeI
BFTqNwJNK/wEO28O/KC69AzBZysRkokiA349nkJiGhDdpeZrpaca4pjMqXPJ2FzR
AEzT1y1Y+krXMIqsFtscXgbH0ounqD9gMFNV5ly3Q7cdEwhUwd7+ZWh9bBXuNWe0
Gqh4WuqOBo5+IyXKiA4gwNbDckyWu7tBduexGnLGTLqGL5ymCVwnXF/PWmM9wMwV
3Xqbl5kanZAqNBJAlb+VjGwKLwqeDitOdMO6wZt5jB1dFfRqC+4BTf6SlfAU6Ele
U0VH6FSrq3+BYLj0/xXNnQAkB2DIt1/GbG054BcwxJXM97pV419ZSG/1hQDjH92g
um1xfyaxAgzhPRh+PHYP+uYBa8m+BTQSmKH/qC3oG6B+76Ql45uxt+zKNglNYbT5
w4/bKZtaueih7m4YsGFqxGs6OYO1sZVwFsyyBcWgkLBx1ygz3F/91mV6qM1RP7nG
cLqJogJT
=vmTC
-----END PGP SIGNATURE-----

--7wrplbydiie2qrlz--
