Return-Path: <SRS0=Mt+e=5P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AEECC2D0EB
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 10:07:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D13720733
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 10:07:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585562848;
	bh=Ih3i9hio4E+l2yRz5iex17bsbwdjJkq1iyYOeIbg+jQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:List-ID:From;
	b=bfaBdGo3IC76zcLp6nMw4yxYoVlUNCs40MK4fshb0SdiT8BzACH/iOMQCbqvPYE28
	 Ovg5yd8V/dgqn2MML6D8h25iSqTw/o3omB9sHWCD1xp6N4gXOcWMb7SbBQLp9zHSVS
	 r48+ICu5SnjzO+u7GqiXh3w5+iWmfdoq+NY2Hh4Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729259AbgC3KH1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Mar 2020 06:07:27 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:37507 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728748AbgC3KH1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Mar 2020 06:07:27 -0400
Received: by mail-lf1-f65.google.com with SMTP id t11so1209793lfe.4;
        Mon, 30 Mar 2020 03:07:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=pn1nEZ5WRc7r1oBeu3ACXMRxB5gHQTein//I6VEvyMk=;
        b=To8v++WqI2k8HyEftGBjw25ilWel8fn9JU6mV0H0/ytUABHhLNgLKkPZsKbV6FeFj1
         cah5fYzerRwOd0OZE+Cg0hrU4eWftc3mHg4YC3SmenHNFB0uuIJPtJOskFMwYerSoowh
         CvVNTPyjpkdmI4RfEexF7VCsE8lg0eSpjLdtqqXEij0IaJ28Y0UR5uzYtec0dZs1GxAG
         VAB64hUI7Ckoyo2QZFhZH5Lym82CSHz7OnIoOx0y4E9+rhHf8+8VCTCnpd70Ay1AT1Sn
         gKzQn4pzaE22v8eIa+Jr7OHtV9GUY5huMogmlrreuXNozQ7ucwtrPZ3jAfYmwEkKF6pv
         ShgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:in-reply-to:references
         :date:message-id:mime-version;
        bh=pn1nEZ5WRc7r1oBeu3ACXMRxB5gHQTein//I6VEvyMk=;
        b=I/6SV+QByLn8IrjCdOXwlH/J8byUIi61jBe9RbKT8DPlwKYmZO0oaCRE5zLCWEdWM4
         scY+cdUwNobgBbREOZ8NecbAzBF2NlvixR6RP7sKmJBQW8/2PVLsbcIHjZHpkcLOUQha
         Z+r+oht0RLw8npiOVE2FCmD5dCRXfhGBSM01rsVs+ZeKY3BWArUx5sEgN1xHUgYWu5oj
         n4J3kDEheTKBNhR9q7Dyddj8WI7W44AmkHGhxK/ll4JebKSHz3e4lU43gLmhI4YkH7nT
         vXOznhHgIYxHp3lVciJJ/jkkHs8p5cC17FYyO1iNg+TJawC61CZsT2+TmECN4Uo52GKg
         c+qw==
X-Gm-Message-State: AGi0PuZ/OYRX3u+yysXVKtKiqde0cSzJlcipiB/zpH0cscxYErwcJqbm
        NxnDdCj7V5IbMMdn9njaTVc=
X-Google-Smtp-Source: APiQypIWGcEAv1TvxsYN0+ybnQg5S+ZYDd2PDDjIG79GcvXLZcK4Hi/zLOCSHoxBSsdvbct8oCLsAQ==
X-Received: by 2002:ac2:4199:: with SMTP id z25mr7505806lfh.90.1585562844369;
        Mon, 30 Mar 2020 03:07:24 -0700 (PDT)
Received: from saruman (91-155-214-58.elisa-laajakaista.fi. [91.155.214.58])
        by smtp.gmail.com with ESMTPSA id c4sm7471624lfm.37.2020.03.30.03.07.23
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 30 Mar 2020 03:07:23 -0700 (PDT)
From:   Felipe Balbi <balbi@kernel.org>
To:     Nagarjuna Kristam <nkristam@nvidia.com>, kishon@ti.com,
        robh+dt@kernel.org, thierry.reding@gmail.com, jonathanh@nvidia.com,
        gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-usb@vger.kernel.org,
        jckuo@nvidia.com
Subject: Re: [PATCH V1 0/8] Tegra XUSB charger detect support
In-Reply-To: <48fde9ce-7d40-c2c3-1a9c-994654a02367@nvidia.com>
References: <1584527467-8058-1-git-send-email-nkristam@nvidia.com> <87pncve963.fsf@kernel.org> <48fde9ce-7d40-c2c3-1a9c-994654a02367@nvidia.com>
Date:   Mon, 30 Mar 2020 13:07:19 +0300
Message-ID: <875zem2m20.fsf@kernel.org>
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


Hi,

Nagarjuna Kristam <nkristam@nvidia.com> writes:
> On 29-03-2020 16:10, Felipe Balbi wrote:
>>> This patch series adds charger detect support on XUSB hardware used in
>>> Tegra210 and Tegra186 SoCs.
>>>
>>> This patchset is composed with :
>>>   - dt bindings of XUSB Pad Controller
>>>   - Tegra XUSB device mode driver to add vbus_draw support
>>>   - Tegra PHY driver for charger detect support
>>>
>>> Tests done:
>>>   - Connect USB cable from ubuntu host to micro-B port of DUT to detect
>>>     SDP_TYPE charger
>>>   - Connect USB cable from external powered USB hub(which inturn connec=
ts
>>>     to ubuntu host) to micro-B port of DUT to detect CDP_TYPE charger.
>>>   - Connect USB cable from USB charger to micro-B port of DUT to detect
>>>     DCP_TYPE charger.
>>> DUT: Jetson-tx1, Jetson tx2.
>>>
>>> Nagarjuna Kristam (8):
>>>    dt-bindings: phy: tegra-xusb: Add charger-detect property
>>>    usb: gadget: tegra-xudc: Add vbus_draw support
>>>    phy: tegra: xusb: Add support for UTMI pad power control
>>>    phy: tegra: xusb: Add USB2 pad power control support for Tegra210
>>>    phy: tegra: xusb: Add soc ops API to enable UTMI PAD protection
>>>    phy: tegra: xusb: Add support for charger detect
>>>    phy: tegra: xusb: Enable charger detect for Tegra186
>>>    phy: tegra: xusb: Enable charger detect for Tegra210
>> this doesn't apply cleanly. Could you resend after -rc1 is tagged?
>>=20
>> -- balbi
>
> Sure, will send rebased patch once rc1 is available.

Thank you

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEElLzh7wn96CXwjh2IzL64meEamQYFAl6BxNcACgkQzL64meEa
mQb6uw/+Jw0l6xhc47L2wGe3VtmVnfoW4PXuqhadHEnexsIsDoPU996tLlojuqtI
IQtQv5KKOZpMr7agoR7sDkBEr7xjxAuJKtd3tmT4Ib9qmaerUAzXUw6FLLKVPP+U
d4J0s8F2vMqnHnAUp8uWVeTliUhXykHePG1lOmAjvEIeopFHVMHBg8QJ687BFEgt
veR5rqUPJEBo05dwL/+3k1jSraWgnCPYKKPi8/G9IiomNWBu+a2/F06yj/F0ZguI
+IslMiqkb4lrqSoF5T3d9iK/5C3WZtgpiKYKdfLu7Q/5Fokbj0bCD9Jpg2sDbEYq
nEaHVEiLEYVAjHhWonAER3GGNg7cXGbNrYsVmE5sYYRWqeBZz9pgiEu0Ll7UCyRT
VjLptlJojWEiYkWmykuoB+bShWLI8L+AhNlX7h8llX8cfgNW9ZWAIIF1RrkcYM4T
pfNgFf4+Pskvm7miJ//w7pQT6F4Mrb2vdmDUDtDLm6YAEIHxl6cAUZJD60gA8ZUq
8qLA+yTfoj3QD6HUgqZhXPJ+g1KrTCufvFAaBuWGEhiN2ZoEsOVMA2qWXVXXkZb6
9sOgPlMwRgLoBUphbU8bdBXuEtj8dsvfdWKMB97+mOmbz/L3b9iC5KoI4BDQw/xl
wkvDcPeD9GjDwOECEdjjSOoxZL17UIVADvtEtNCyHuVKnQD216E=
=cObg
-----END PGP SIGNATURE-----
--=-=-=--
