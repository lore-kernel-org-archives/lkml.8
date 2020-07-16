Return-Path: <SRS0=y5Sx=A3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21B78C433E2
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 12:48:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EE1A620739
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 12:48:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mtDy/qzB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728182AbgGPMsO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jul 2020 08:48:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726537AbgGPMsN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jul 2020 08:48:13 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18723C061755;
        Thu, 16 Jul 2020 05:48:13 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id a1so6393162ejg.12;
        Thu, 16 Jul 2020 05:48:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=he6fHQwTBHTnEWj47aps+Xt/rcyd1tGPq9T15hrhuAc=;
        b=mtDy/qzBjw0oUYgQgSeMXeC5bqbXNzDGtwbwP/ljv8kFrNL46JEDv23R/XqONNhgyS
         eAxASnT6Fk/92y8gts6wCS26NB5+r8ieP3K+PzA4kK5TAxr2JgxLSg/oQ+Rx9E9Ium2f
         pwRtSwBj8/TkYBCxxY7VNCw2qaUGD/VyfveYPoyB+g7xOe3j4vax75m05eid8AZNthLC
         ah9NadI0IqWF7NP8gJGD0em9evBJS7UL6IoQJeB+NmbtziIAozU19N7hWpxjm87hsBbb
         DiGGKCZMlPeHxpBU9H7hATtzdYFbHzvzQYTlLk2NRkx2C1Kst06R05EVxGFbo/18/iVc
         Lbnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=he6fHQwTBHTnEWj47aps+Xt/rcyd1tGPq9T15hrhuAc=;
        b=d6zrVYOnUOp+P8PxN4Ha8kGYHvC8p4dZ0KJqM9Uwgcq4AROUPqYyzua6jbd2rSi9+/
         PqNNHZBzj3LI1o70Xy9KvZ8q7uGIjgRV8/90MxBnku3BjIVQNFDx1BtYQjkYVDQZqQNb
         3Ta65WFj6nx2KdluU+pq1Q1+OHc8YzAloJki2QrYavtZbtNbQy5hqbZ/zecH46R3e2Xi
         GKeFJUQ6ZY1tWp2WQFGkJYEXLPAndDTY6B7snGIA5zvzLYQ7+FNdFlXLYj/D/DDCPKME
         l215cmFp7mL3MNJFxrukrTADGIUoz7inO9LU473B4ab5z0YQkFd1hzFXwuCmdK+RoTU5
         H5YQ==
X-Gm-Message-State: AOAM530JxhnbZhiqxqqJELd4KvQFUy9KfYJleB23IxCN/TesMrZ09hhb
        DxP784VZsMACDr3wh8FvZEo=
X-Google-Smtp-Source: ABdhPJyY+Y0YNBsfLoM5blp8Kwtp9PVCScz/d3DBySNqcW9JvA/Khu3m3qzyg2eLb+38DXUaYW/hFQ==
X-Received: by 2002:a17:906:1ec3:: with SMTP id m3mr3612491ejj.197.1594903691699;
        Thu, 16 Jul 2020 05:48:11 -0700 (PDT)
Received: from localhost ([62.96.65.119])
        by smtp.gmail.com with ESMTPSA id b4sm5184599edx.96.2020.07.16.05.48.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2020 05:48:10 -0700 (PDT)
Date:   Thu, 16 Jul 2020 14:48:09 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>
Cc:     Nagarjuna Kristam <nkristam@nvidia.com>, jonathanh@nvidia.com,
        mark.rutland@arm.com, robh+dt@kernel.org,
        devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V4 0/7] Tegra XUSB charger detect support
Message-ID: <20200716124809.GC535268@ulmo>
References: <1593166742-23592-1-git-send-email-nkristam@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="L6iaP+gRLNZHKoI4"
Content-Disposition: inline
In-Reply-To: <1593166742-23592-1-git-send-email-nkristam@nvidia.com>
User-Agent: Mutt/1.14.4 (2020-06-18)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--L6iaP+gRLNZHKoI4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 26, 2020 at 03:48:55PM +0530, Nagarjuna Kristam wrote:
> This patch series adds charger detect support on XUSB hardware used in
> Tegra210 and Tegra186 SoCs.
>=20
> This patchset is composed with :
>  - dt bindings of XUSB Pad Controller
>  - Tegra XUSB device mode driver to add vbus_draw support=20
>  - Tegra PHY driver for charger detect support
>=20
> Tests done:
>  - Connect USB cable from ubuntu host to micro-B port of DUT to detect
>    SDP_TYPE charger
>  - Connect USB cable from external powered USB hub(which inturn connects
>    to ubuntu host) to micro-B port of DUT to detect CDP_TYPE charger.
>  - Connect USB cable from USB charger to micro-B port of DUT to detect
>    DCP_TYPE charger.
> DUT: Jetson-tx1, Jetson tx2.
>=20
> V4:
>  - Added ACKed-by details for PHY driver.
>  - Used BIT macro instead of (1 << index) usage as suggested by Chunfeng =
Yun.
> V3:
>  - Added ACKed-by details for PHY driver and DT changes.
>  - Functions and its arguments are aligned.
>  - Tabs are used for alignment of MACRO's
>  - For vbus_draw USDC callback, usb_phy set_power error is propogated.
>  - Fixed various comments given by thierry.
> V2:
>  - Added ACKed-by details for DT patches.
>  - All patches rebased.
>=20
> Nagarjuna Kristam (7):
>   dt-bindings: phy: tegra-xusb: Add charger-detect property
>   phy: tegra: xusb: Add support for UTMI pad power control
>   phy: tegra: xusb: Add USB2 pad power control support for Tegra210
>   phy: tegra: xusb: Add soc ops API to enable UTMI PAD protection
>   phy: tegra: xusb: Add support for charger detect
>   phy: tegra: xusb: Enable charger detect for Tegra186
>   phy: tegra: xusb: Enable charger detect for Tegra210
>=20
>  .../bindings/phy/nvidia,tegra124-xusb-padctl.txt   |   4 +
>  drivers/phy/tegra/Makefile                         |   2 +-
>  drivers/phy/tegra/cd.c                             | 283 +++++++++++++++=
++++++
>  drivers/phy/tegra/xusb-tegra186.c                  |  92 +++++--
>  drivers/phy/tegra/xusb-tegra210.c                  | 223 +++++++++++-----
>  drivers/phy/tegra/xusb.c                           |  80 ++++++
>  drivers/phy/tegra/xusb.h                           |  22 ++
>  7 files changed, 621 insertions(+), 85 deletions(-)
>  create mode 100644 drivers/phy/tegra/cd.c

Hi Kishon, Vinod,

did you have any further comments on this series or is it good to go
into v5.9?

Thanks,
Thierry

--L6iaP+gRLNZHKoI4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl8QTIkACgkQ3SOs138+
s6FW9RAAuZoijrJioV2HdJzgYh/9hgJR3ZM9aE8US3TQS4GJd8DgIEyQwhkA9Scs
dr2zywAL2rfbOw08v+LjYHk5wDkOmEO47+U1by0Uni2114TnsfkQRhMOyLG/rcaU
RIh5PVq2D7szCnjXm49To5kFEjtUnHlmjFiOdZAi2Y81/IygqdLzoKF1T5ZLfmBi
gK/zxuPbHaPjpzuWWldK8c3n4Yys1upiiYNXslJbUCoeKjdi3ckMVqiwtYlFV5h5
LFNuZWic1CYkhhbzbY5FEjEmI7e4TtJHgbPAhjdkQBEs88FYu787ZeO+zFLZNAAZ
SApfrcEMKSDkqboHdTPfN398qQPOUqP88JE8QaFxvaUT3QN6hmwTw2sfYkHMovlJ
qW9jzlNnQjX+oe83M/i/xZzCe39Wihp+E5jOQoJ/8tfXSocVDlPIfG+vqb4nrsz6
dSZmq2m6UFQkJlvBiMRUlHkt38f+gvhV+sM4CuTPV4iJOCCh59YZ1ykQkWncFz8H
ZI9rjD4BUwMxIgci5Fdp7v+sY3NIcdLrOzWXBeV38SkLraRheOM3QJTZzKosDxKJ
XCbgyPf9kD4vbgCNr4QXTrWElkNwyDxz4DpXxqtgJ/xCwKFMHz4uBvM0Rfh7kp9e
gSFR4ycZdy5Wsr3bOHDKoU4/PAoiDaVnJH/LEqXB+i28lP5QsAY=
=xtfh
-----END PGP SIGNATURE-----

--L6iaP+gRLNZHKoI4--
