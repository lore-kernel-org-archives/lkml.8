Return-Path: <SRS0=EKp2=A6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63EC0C433E1
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Jul 2020 23:04:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 431A2208B3
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Jul 2020 23:04:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="PRbaQE3+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726742AbgGSXEx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 Jul 2020 19:04:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726126AbgGSXEx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jul 2020 19:04:53 -0400
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F722C0619D2;
        Sun, 19 Jul 2020 16:04:53 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4B90mw6BWGz9sRN;
        Mon, 20 Jul 2020 09:04:48 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1595199890;
        bh=D+5rkaJRkU+g9sxinJrCl4G4sduYGPSSa80PlqhZDIQ=;
        h=Date:From:To:Cc:Subject:From;
        b=PRbaQE3+6Aa3fHXOrBVRgcXOs2BnPD9x4ns6grcAcF70uxTdYrlNjm9Wnmb4RUu3T
         mMFSsVWJUAvziOTzioEraSZO9pkwT3+pzbCJUzSCQJ72N/ZM9xAXwOtbQX1/Bt2sql
         NVQHJFCVpiSFzR2bmx2+C654mELYElmLTMd0eajNOvYAhBJDT92dUIQ++/kyoXqa0l
         NgwH05kuyzzUutuCN1a/Ms/15Af3XPsybcc3EOMoGSmyKEian4UcoO2wRT5RrgG7Z7
         fdYo5SdMlAG4BOg/6Q1cledJP69oY4wkhvKdwm6noo3zVS8/o6Rdhhsab7+g0g/yYl
         sIgFjO7K48IdQ==
Date:   Mon, 20 Jul 2020 09:04:47 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Colin Cross <ccross@android.com>, Olof Johansson <olof@lixom.net>,
        Thierry Reding <treding@nvidia.com>,
        Arnd Bergmann <arnd@arndb.de>,
        ARM <linux-arm-kernel@lists.infradead.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Dmitry Osipenko <digetx@gmail.com>
Subject: linux-next: manual merge of the tegra tree with the arm-soc tree
Message-ID: <20200720090447.0a4f74ee@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/KaR0zxqy9ZQk=q7HKhQ1fzj";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/KaR0zxqy9ZQk=q7HKhQ1fzj
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the tegra tree got a conflict in:

  arch/arm/configs/tegra_defconfig

between commit:

  67c70aa86f8b ("arm/arm64: defconfig: Update configs to use the new CROS_E=
C options")

from the arm-soc tree and commit:

  3a3cb021b038 ("ARM: tegra_defconfig: Enable options useful for Nexus 7 an=
d Acer A500")

from the tegra tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc arch/arm/configs/tegra_defconfig
index 8688c715ccde,729069b6d34c..000000000000
--- a/arch/arm/configs/tegra_defconfig
+++ b/arch/arm/configs/tegra_defconfig
@@@ -145,10 -164,15 +164,15 @@@ CONFIG_CHARGER_SMB347=3D
  CONFIG_CHARGER_TPS65090=3Dy
  CONFIG_SENSORS_LM90=3Dy
  CONFIG_SENSORS_LM95245=3Dy
+ CONFIG_THERMAL=3Dy
+ CONFIG_THERMAL_STATISTICS=3Dy
+ CONFIG_CPU_THERMAL=3Dy
  CONFIG_WATCHDOG=3Dy
+ CONFIG_MAX77620_WATCHDOG=3Dy
  CONFIG_TEGRA_WATCHDOG=3Dy
  CONFIG_MFD_AS3722=3Dy
 -CONFIG_MFD_CROS_EC=3Dy
 +CONFIG_MFD_CROS_EC_DEV=3Dy
+ CONFIG_MFD_MAX77620=3Dy
  CONFIG_MFD_MAX8907=3Dy
  CONFIG_MFD_STMPE=3Dy
  CONFIG_MFD_PALMAS=3Dy

--Sig_/KaR0zxqy9ZQk=q7HKhQ1fzj
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl8U0Y8ACgkQAVBC80lX
0GzPVwgAplp7C7Z9qEVlj2adVH9SAYnyWkkSjqUGn4MQlgKPkavFBPx/JgtJ5NYS
NInoR0R7cQFznLaaNCJ/I7mem7sV7JG1fwtzfU7Yy3Tpih61qcQcN8tERIii7ZU1
/jZxJpPFsQZ+ToXdKR37D3Fz0rXbftVaGDZR46DzRKbIbXKShivt+5b2WEVFwhRC
jxOkPWFmdrQ+uduKNZyLO3vq4rlDVN6Z/Q+TSy0vxjLpxXLjuK8YfgHB3gjxozM5
HCZcZcWeTxRUjUqhEXk2hUgbL7Mx37GZFLXotKTUPvWxGjbozUpwbRsY9s5NZaQY
hz7PRgWt8q3htVMhX0HpZxTXjTDTYQ==
=mkUh
-----END PGP SIGNATURE-----

--Sig_/KaR0zxqy9ZQk=q7HKhQ1fzj--
