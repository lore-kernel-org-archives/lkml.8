Return-Path: <SRS0=eufF=BE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7767AC433E4
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Jul 2020 06:22:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4D705206F6
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Jul 2020 06:22:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595658178;
	bh=v+o6KDVU0hhUK3tFxWmgsHzU0c3K1RrkTsgOBzBkiUM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:List-ID:From;
	b=UNz7h0PUhTWjcVCGHCbTedTK6Eia6+/idcWoq1naI3D1tPqk4M6gRLi/KR9DKLRFk
	 geKA5y0HMif6aLuVIdh/E+cj7SYNvmNeHjdJg5j8YYlOscjTRcKz+fp7v4Y/l3aoRH
	 4UjTG+VgoJBHb0taVyk+PTTHBWMp8y5jYw8tBiOk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726926AbgGYGW5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 Jul 2020 02:22:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725941AbgGYGW4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Jul 2020 02:22:56 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3143DC0619D3;
        Fri, 24 Jul 2020 23:22:56 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id j22so432283lfm.2;
        Fri, 24 Jul 2020 23:22:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=v+o6KDVU0hhUK3tFxWmgsHzU0c3K1RrkTsgOBzBkiUM=;
        b=VgmeMWUtsBJLOAiQWnxQ27VL42WD1X/So5Qx8SPDdBWohI8Cewsz3MdAoQLXG+f7Uo
         d7tW1y66veZB/XEhVvvhpvABJjBdg6FTwLqjcHcjJ7P/S/ykCxc9M914W/7hvWdvgdsU
         1MjTOFvN2E42TEcGsguWDt9CA84gtPAOoLbNII3o0TNsMG3fpekpwQO1vN2gNV4qiAzE
         SCXFQsELc5R/z76HaFqzfye8pKxcypWrqfUIUT2bywzzdjS3lhSpF+LyU/JTwTVhZfRq
         uezH75OJ7HwUNCEUbB/VagvTGDp17WGpaWqrYWVX0mq23hr8XOK3tLlCWNgXZD2IFTuV
         f+MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:in-reply-to:references
         :date:message-id:mime-version;
        bh=v+o6KDVU0hhUK3tFxWmgsHzU0c3K1RrkTsgOBzBkiUM=;
        b=sxq2Jq/SosPE3IiuktMpPhpgrbdfydKVSzbppcVBMipTykoBg6MABXFfnKCApIFhcl
         dvMErvibkqvmKFxT0NMUtllBv7uAzyLW9uhT/NuKZWLl7kei8WhAB3sQk+jdtS8YKvDv
         yG3h6FpjmIGGypz6t3/AwPte8L3PatIuQJtQFdVNFG2rm+Yh9i8MH93xOHKZ28FT1ST/
         dh8T8mHIJZ+0TzFIA05s19C0FiC+9CFpQ9UVw1sLjM2JchRBKV5lcOxCY4tVlwMsa4bE
         CTiaM4Xp/D99frDBU2henPW+fOoqJa6HGUYBKkZeQKsZ8IyGRUivzb5mchkSp/yMI2bT
         TTZg==
X-Gm-Message-State: AOAM533nmmaHlkAu06rtAAt5s4GOjlhOflKnLqQow1zLlxt7iLCk4YEJ
        Hh3d9I+BUea74C/KlC+8cdqRoNOGXTk=
X-Google-Smtp-Source: ABdhPJy/g2C0d5ows8tJWTqCtjK9g1uiCpxiqx7pz8GxYrQeQrZuYmoazscExS0BAkqc0Qo99uAgsg==
X-Received: by 2002:a19:8c9:: with SMTP id 192mr6741144lfi.204.1595658174473;
        Fri, 24 Jul 2020 23:22:54 -0700 (PDT)
Received: from saruman (91-155-214-58.elisa-laajakaista.fi. [91.155.214.58])
        by smtp.gmail.com with ESMTPSA id m1sm977486lfa.22.2020.07.24.23.22.53
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 24 Jul 2020 23:22:53 -0700 (PDT)
From:   Felipe Balbi <balbi@kernel.org>
To:     "Ramuthevar\,Vadivel MuruganX" 
        <vadivel.muruganx.ramuthevar@linux.intel.com>,
        linux-kernel@vger.kernel.org, p.zabel@pengutronix.de
Cc:     gregkh@linuxfoundation.org, robh@kernel.org,
        devicetree@vger.kernel.org, linux-usb@vger.kernel.org,
        cheol.yong.kim@intel.com, qi-ming.wu@intel.com, yin1.li@intel.com,
        andriy.shevchenko@intel.com,
        Ramuthevar Vadivel Murugan 
        <vadivel.muruganx.ramuthevar@linux.intel.com>
Subject: Re: [PATCH v2 2/2] usb: phy: Add USB3 PHY support for Intel LGM SoC
In-Reply-To: <20200611021246.3250-3-vadivel.muruganx.ramuthevar@linux.intel.com>
References: <20200611021246.3250-1-vadivel.muruganx.ramuthevar@linux.intel.com> <20200611021246.3250-3-vadivel.muruganx.ramuthevar@linux.intel.com>
Date:   Sat, 25 Jul 2020 09:22:49 +0300
Message-ID: <87o8o4nmfa.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha256; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

"Ramuthevar,Vadivel MuruganX"
<vadivel.muruganx.ramuthevar@linux.intel.com> writes:

> From: Ramuthevar Vadivel Murugan <vadivel.muruganx.ramuthevar@linux.intel=
.com>
>
> Add support for USB PHY on Intel LGM SoC.
>
> Signed-off-by: Ramuthevar Vadivel Murugan <vadivel.muruganx.ramuthevar@li=
nux.intel.com>

use drivers/phy/ instead.

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEElLzh7wn96CXwjh2IzL64meEamQYFAl8bz7kACgkQzL64meEa
mQZHYg/8CYRv6cfRk1zplKFpSlZUbTgesgFwovG0pSPay4eBDj8EFj0E0+SGA/ls
Lmr9u3AxMwGe9//aiLVuFt9ASVvqhX2dkjM7lWYc2AcQoqO/3s9pDxvUo8uzjUgV
02OKU5YsnOa6zBi8cHHG7/AlA2oLieX7Bold2KH/4qiwTK6frVXg3QK0cn0jOxCH
gAelUoSwXomCHaUP4McC9mgJsCFToPjP5SJej8r2uS2hpW+aN1FAmu/jN3IYr+zc
OemcMFxERkIspyw2GnmXeL/z8AGyKLzKVDgK54ygjXJxBrnHpLvALNB77F4mllMo
3DkDMgNOtfOKB3eWSVQPxlwU5vI0mee3ZbVeFc9HxnJjmVD7bacRDnt+dJa5HWYC
BXNVScSafgO3jl4DEWSRn8jTYDsu30J2+fJth32fbnmdsrUAdDzoprzJZ2x7V5rh
uP4SPKYFd/NQ08M0NufEi7HOYWnXtY1lwcsZWKXb8KjCt99a2J4+v2CLeKt+18V5
CUL6Zbg8Ov3aXME8yrcaU4koDzJkqkHWx/LMtrUd2/Slieg3keAOpg0/NbyghtWS
7bN9hTX2FBKv+YsrgZL8I4T9a8cEm9JntK+cdNWhpsLHm2lE8ESAHi+WZ4/mVqJV
HdLcJh8ugBhzpSsoFN5uu72n5J4KEOjDB86lsx9uYdumJqoNCvg=
=aqSS
-----END PGP SIGNATURE-----
--=-=-=--
