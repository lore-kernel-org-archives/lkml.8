Return-Path: <SRS0=PfNx=4F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25A98C7619D
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 08:39:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ECCF32067D
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 08:39:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rWvqb1ix"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728466AbgBQIj0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Feb 2020 03:39:26 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:54106 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728108AbgBQIjZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Feb 2020 03:39:25 -0500
Received: by mail-wm1-f66.google.com with SMTP id s10so16205570wmh.3;
        Mon, 17 Feb 2020 00:39:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=pxEEeciF+LuNB4+RBNEBd1ZjZeWEJp318KAIkZVPMDM=;
        b=rWvqb1ixTs8BxO1/8gTHa6D4lordYJ3amOl2r0jzD/nKYv0yF+0v1kGDq4WZGFrMzp
         XilFMrLVFwe7+CwckSGJ959/+6nrGPtVwXlkaQRTpc89TK3ImnnoUji+QPLszAO66YKp
         mZAPVqXpZkXRrpxrCrO4k04eOAAvNLGzlaBDrN4F+NAfV4zUupyg5kGlnBOK6d34K7Iq
         9Mj6VH2mJ5jsjRlR4cMaRTBxz0hHLPFxc48uYZr0qT6SPg0fkeRKdtt0MZQPfEDjdkIw
         5OOFHEf7Wc0K/UFN/NxLiY4K05MFJmuNhnV6mE/HyDx+VN1P0TgmQAgO1iqE8AfwsLsT
         liwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=pxEEeciF+LuNB4+RBNEBd1ZjZeWEJp318KAIkZVPMDM=;
        b=a8fcINR5KZZpCv9R2z41DWrRfIsJU2hHnmfYEllQNXGXfus7yRg805o5DeQYmt/MGK
         4p7O8VNU2crOBSIeHR1INgA7rHjQaG5BSP6OCgaUyPDMOqftzEWh70jWtaA9jlOlcB57
         zBJwfLNfc8pdTC90sxvU/Y4cMa4G8opNmuetJJ72GngYUPU6kEClaNrddjbj2bCDDLau
         v6pZBDZv4iD72J4BJ2GoG7e/fIEeKc+O2j3J4dUxHDbcdOpmAFgyKTisDxp3Q/vajcjh
         8m8ZKVukVb0fXOzlIp9o7K0/J/aLNCz+pzXkK/rSneErtqEONOOR5ZltKiBa4kv70S/U
         nhgg==
X-Gm-Message-State: APjAAAU+WH51OI9E4nwucvKoSCo/ixPpCQ3riEuCer7sPYuJV0JHyfza
        2JZV3kp7yonQTaF/OH5DKJZRI6HW
X-Google-Smtp-Source: APXvYqx/Q7bOEUoUcfHN49/4KjZNN909CGAqkyiTOxP/PM8N34bsiPCVp2gm5hP2nqYQxWM9jcuU9g==
X-Received: by 2002:a7b:c8c5:: with SMTP id f5mr20105089wml.44.1581928761598;
        Mon, 17 Feb 2020 00:39:21 -0800 (PST)
Received: from localhost (p2E5BEF3F.dip0.t-ipconnect.de. [46.91.239.63])
        by smtp.gmail.com with ESMTPSA id v22sm18852482wml.11.2020.02.17.00.39.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Feb 2020 00:39:20 -0800 (PST)
Date:   Mon, 17 Feb 2020 09:39:19 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Nagarjuna Kristam <nkristam@nvidia.com>
Cc:     balbi@kernel.org, gregkh@linuxfoundation.org, jonathanh@nvidia.com,
        mark.rutland@arm.com, robh+dt@kernel.org, kishon@ti.com,
        devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [Patch V5 03/21] phy: tegra: xusb: Add usb-role-switch support
Message-ID: <20200217083919.GF1339021@ulmo>
References: <1581322307-11140-1-git-send-email-nkristam@nvidia.com>
 <1581322307-11140-4-git-send-email-nkristam@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="sDKAb4OeUBrWWL6P"
Content-Disposition: inline
In-Reply-To: <1581322307-11140-4-git-send-email-nkristam@nvidia.com>
User-Agent: Mutt/1.13.1 (2019-12-14)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--sDKAb4OeUBrWWL6P
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 10, 2020 at 01:41:29PM +0530, Nagarjuna Kristam wrote:
> If usb-role-switch property is present in USB 2 port, register
> usb-role-switch to receive usb role changes.
>=20
> Signed-off-by: Nagarjuna Kristam <nkristam@nvidia.com>
> ---
> V5
>  - No changes
> ---
> V4:
>  - Updated function name in debug messages as suggested by Thierry.
>  - Added owner info to port->dev during USB role switch registration.
> ---
> V3:
>  - Driver aborts if usb-role-switch is not added in dt forotg/peripheral
>    roles.
>  - Added role name strings instead of enum values in debug prints.
>  - Updated arguments and variable allignments as per Thierry inputs.
> ---
> V2:
>  - Removed dev_set_drvdata for port->dev.
>  - Added of_platform_depopulate during error handling and driver removal.
> ---
>  drivers/phy/tegra/Kconfig |  1 +
>  drivers/phy/tegra/xusb.c  | 67 +++++++++++++++++++++++++++++++++++++++++=
++++++
>  drivers/phy/tegra/xusb.h  |  3 +++
>  3 files changed, 71 insertions(+)

Acked-by: Thierry Reding <treding@nvidia.com>

--sDKAb4OeUBrWWL6P
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl5KUTcACgkQ3SOs138+
s6F3aA//VUmI29LB+vP9qNxFW3wdDt2nGlLmhkG5hic35GoOPaB0U+uYacvlSRUk
h5/OJsTN0BG9wW9jvQwQjXm4DvI0AZDYwYFTkcRuu7aPX4dEsTOtQKgnlMCQBa/E
NpZdFP3SRUzkKVzoUyZNE609qHKW0NnLQDSrdNny3JFZt30ECaBdcV3zd8pwi2M7
jB91dl/qly/FvCO23RDN2ngpj81bsvdNx4kMr89cvmFdLruikjtiF6Bts3FGcBh2
hy0CBDTHXEwE9npbodqLkZjlFGowuhNfIYZBTWDfS6BIEByGAw53neXzWcOzH3eh
qMeOswVpT+IadnejojaEDuUA4VwewPRbMqtJeGiBW0FOHzCYorix9N+wSS07fcOu
9l622lI1Hbq+IstTjQkpUi9/GlwPzhdg3R1pJBW8vA4CGLIOw4bxBlTwrWXN6zFR
WPI8W5iVHecVO+Y4xChoM9LviqdLa0qnOa1eNy/NkEjw0dtZnMtJQcHLyAiRkpS/
cDPW5cAMZXrxS+sJ4/8E/6wNUjbNRxewbltwPFZHorfRd+0YBTzYfMTidXb2Nxb6
Jf1YIaklsGKR6hbxht9g+QGj4t7V8poKdkbyePuOqZ5C42det4eMRgt6sfp4PABx
RmEmYGOyswayZqYYGxHJp/BZFWfp9S+j0tS34N3GptE0Ik4QNS0=
=Abay
-----END PGP SIGNATURE-----

--sDKAb4OeUBrWWL6P--
