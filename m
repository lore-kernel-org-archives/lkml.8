Return-Path: <SRS0=r24B=6M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3806C83000
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 10:06:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7F88F206D6
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 10:06:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JBPK9JRz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727923AbgD1KGg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Apr 2020 06:06:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727066AbgD1KGg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 06:06:36 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3A2BC03C1A9;
        Tue, 28 Apr 2020 03:06:35 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id j2so23936730wrs.9;
        Tue, 28 Apr 2020 03:06:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=0NOPRK0/Yhwkuu7bUSlcqL6G+yespVTHDJSREMkCqog=;
        b=JBPK9JRz84aiA4FcjeQVa53YeTll/0vLhduBNuC3BPHjAnaQOq7/fsfSZF1NRBO3bg
         QVIUP/tGpw902ClCUlNYJ/bIM/zNzsjlO+9tJ7MMdj9g13G2WtacQjl5EE/jkArnzt/g
         aiXnVUgjppZ9tNo1b5GOy7ntnOYoLnbkUO4EnxbaZydD5zLl90y0i8eE9VIMvcCe4Gsa
         GbAlVSRjddGK6Ifuc+gpk1JZlWUURMG8rjbd4nKhEZNEjfrFGFZ+ljO+ZUx+ACVw6UGx
         4l/fW9Jp/+pA6/w650L/X6mBx5Lh9sdxsxDsY3nCViD5oxji1y6NjrsSiIlJu0zCt8cO
         afdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=0NOPRK0/Yhwkuu7bUSlcqL6G+yespVTHDJSREMkCqog=;
        b=G7Uu13NrWM9ltqKKcAahMXQX0awHY+RVbTrIdjgX/J4jCJm8Nmx0Ioskna8cay25Lk
         TTJjsqVyiI4NJfh8CY+ycKJlHfzjxd29+C/rRdZP3ugXOGuwX5u8Gv+pE8D5IsJSPMHd
         Cv3U4Zrhle/6imKxumPCYmoLPKahJlJbwpkP9bOmyQOY3tVOQNujHJmeloz72ygT0LXf
         EQ3l8F2E6tihewGMq/OL8uLrIdYrSyWYnSp9crRb6owkaLx8U3h+afKHc7n9upGUUhly
         O8yQOAH4bLUUaWywGQ7dYnlkHXhpc9BBPsDmqwqYr/3/S7r+1jF2gRVH/qhW2R+62xwY
         Ba0g==
X-Gm-Message-State: AGi0PuY1ZsLrPoW5jiFyJV/RZ75z4aYjT/KzXBtYWcutIiwfQ0J6OFLQ
        pb6LRNQ/CWRuz70ajMADGuCmbGkD
X-Google-Smtp-Source: APiQypJi5ZpL1icthw5cAYkTdZLk7nsvaXcwbZzuN4qQcwQWsTAh/CP1Xwvu/LGQvYzH+4s95ERlog==
X-Received: by 2002:adf:ab1b:: with SMTP id q27mr34705138wrc.220.1588068394689;
        Tue, 28 Apr 2020 03:06:34 -0700 (PDT)
Received: from localhost (p2E5BEDBA.dip0.t-ipconnect.de. [46.91.237.186])
        by smtp.gmail.com with ESMTPSA id t20sm3201391wmi.2.2020.04.28.03.06.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Apr 2020 03:06:33 -0700 (PDT)
Date:   Tue, 28 Apr 2020 12:06:32 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Nagarjuna Kristam <nkristam@nvidia.com>
Cc:     balbi@kernel.org, gregkh@linuxfoundation.org, jonathanh@nvidia.com,
        mark.rutland@arm.com, robh+dt@kernel.org, kishon@ti.com,
        devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2 4/8] phy: tegra: xusb: Add USB2 pad power control
 support for Tegra210
Message-ID: <20200428100632.GD3592148@ulmo>
References: <1586939108-10075-1-git-send-email-nkristam@nvidia.com>
 <1586939108-10075-5-git-send-email-nkristam@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="wLAMOaPNJ0fu1fTG"
Content-Disposition: inline
In-Reply-To: <1586939108-10075-5-git-send-email-nkristam@nvidia.com>
User-Agent: Mutt/1.13.1 (2019-12-14)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--wLAMOaPNJ0fu1fTG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 15, 2020 at 01:55:04PM +0530, Nagarjuna Kristam wrote:
> Add USB2 pad power on and off API's for TEgra210 and provide its control

"Tegra210"

> via soc ops. It can be used by operations like charger detect to power on
> and off USB2 pad if needed.
>=20
> Signed-off-by: Nagarjuna Kristam <nkristam@nvidia.com>
> ---
> V2:
>  - Patch re-based.
> ---
>  drivers/phy/tegra/xusb-tegra210.c | 190 ++++++++++++++++++++++++++------=
------
>  1 file changed, 133 insertions(+), 57 deletions(-)

Again, is there any particular reason why this has to be done with a
custom API rather than just passing the UTMI PHY to the charging code?

Thierry

--wLAMOaPNJ0fu1fTG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl6oACgACgkQ3SOs138+
s6F9KQ/+M3fL7+wFt2a7E9qXFb9sgMBGcZ60bYeJG5FVGV2Rs3Ec9cPx1cvmJqnG
esMRcnr6qzKuZtSt+5aoA1q7wRDqrjAFdt4y1KUl8/hjKhqOO/K+/mWXRFem+9HZ
SDMi2IfNwizsGojMftpg9LXZgJVsr9tI01etxAeJ0xfBtoQSyCtoXfbCXWuTi58E
KpvwuzpgbK0LAADwTxmwmijgZ8OFHve1AHoT8Ye0cWhXGKWBZLM9hkYaEhPXWYNH
9ZKzZuzf69ovCNcdJZUOelo4mVGWqwZpYj8z+Kxl+6G4bWE437M3bCHS7q0Ffsda
34uLaJehBT+UeN6FsVbPbvsy7kUjEs9fPC12zk43ThMg1msgXE661QDU7U7N4d6j
BgzW6800Ae12vMC1rmLSL1QtfeW9/EUjw7LX0krTOBkJ/Lz8PpWybN2dtkDb3vLJ
crKgw8jMm08K0/1wAL+McPymKHZLn5UoOupBgyj2bLBM5nXolX3F3yABEW45+7Ur
djmeUddxwOoR/+ceoDz5tSLDEJ8tR1m636wL+Ao2Zu97jPKCP+R05fOax/qPNdOw
oCjzAeY14cr3zSwUdKCUmg/f8lLGb+Py36xF7HyO75TY1ZaW5DWpkfKWwtfZwvEF
8khdnwwHo6oZhnHCy+trucc3Wkyb+IYFQL3b18uzH3YaigPbr/g=
=tXcG
-----END PGP SIGNATURE-----

--wLAMOaPNJ0fu1fTG--
