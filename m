Return-Path: <SRS0=PfNx=4F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF0FEC7619F
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 08:51:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9877E20718
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 08:51:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gpZUlzMJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728611AbgBQIvf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Feb 2020 03:51:35 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:46878 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728217AbgBQIvf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Feb 2020 03:51:35 -0500
Received: by mail-wr1-f67.google.com with SMTP id z7so18555728wrl.13;
        Mon, 17 Feb 2020 00:51:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=C5xv8SsbTaG0cDhTprdH9BYVte6zKum691BtN4GtW2Y=;
        b=gpZUlzMJheFlYY1KBdQOn3ATc10V2sSG50fwF+2VMg8tAqQlKcoaJTZr82r2/NG5ex
         0aQOOFwKvK3fZ/Kuf4HKf+f6lu9AEvVTJlyZbYEWtMBPclXCt15ubiHzcW/sL/d2N7hL
         tQXcsmPQPL136Ju09GhWQwILxatcisAnrB+5GX6VzVUV/9iDo6nrjkGiXyCY6tQWJQxg
         hXHJdcALf94tDf8om2LlKtxVQn1QcWIiDrcmxT/lEQqoJ4ugp7GZKjSTExPRtdOsxx72
         jLMgRcL5T9HKNUmZyluhD9DJKBcmYHkMQs9GFp1rrEB1NJSWCBALBvywbc4cP71fIrLn
         eEKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=C5xv8SsbTaG0cDhTprdH9BYVte6zKum691BtN4GtW2Y=;
        b=buUj+W9miV+z2btlO2OX3yVdwYpL8RYzZOuhODNObH2e7pLnxJy125YgX7dNmWs68+
         rTmnFOdyCfDtW0cmx7Wf/oOSm1xDIUXFkwkr0Tz0O8uRcvzz0Jd8fdJnotNm7+wRyh5J
         nemHWXhvOTBtUWXp7p/hkqur3ozBbytRzANkuLva6Wd/1khywMqupDPbXue4rw1omkA2
         rZqhREkpbu0NJ42OPwEyA7lXf0aIxkElKCLac8p+TH1XP3MNPUS3bR9sqCuIOXWQh3bd
         CNaNCjpNchRtoDKxBZsl2eEJi6EcAKsUGAEGv4kQjCVku1xzYTvFuoFIs8pM92KvjQ17
         Cndw==
X-Gm-Message-State: APjAAAVE3MqdrW0SHh/1mgV8xFIdW/ZhV8McZft+qJbBOfa5OXC2gy6X
        Jfb4HPaacqmJh2Lzsux+cT0=
X-Google-Smtp-Source: APXvYqy0WmpQraHfizMgbA3gjw0UnnZn6vscoesWRieuCn6d0R4UXALiZrGzc7fX2RLP1GZHkU3iMw==
X-Received: by 2002:adf:dd8a:: with SMTP id x10mr21775343wrl.117.1581929492932;
        Mon, 17 Feb 2020 00:51:32 -0800 (PST)
Received: from localhost (p2E5BEF3F.dip0.t-ipconnect.de. [46.91.239.63])
        by smtp.gmail.com with ESMTPSA id a13sm19720944wrp.93.2020.02.17.00.51.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Feb 2020 00:51:31 -0800 (PST)
Date:   Mon, 17 Feb 2020 09:51:30 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kishon Vijay Abraham I <kishon@ti.com>
Cc:     Nagarjuna Kristam <nkristam@nvidia.com>, jonathanh@nvidia.com,
        mark.rutland@arm.com, robh+dt@kernel.org,
        devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [Patch V5 00/21] Tegra XUSB OTG support
Message-ID: <20200217085130.GJ1339021@ulmo>
References: <1581322307-11140-1-git-send-email-nkristam@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="zYo4Elh1vtcYNvbq"
Content-Disposition: inline
In-Reply-To: <1581322307-11140-1-git-send-email-nkristam@nvidia.com>
User-Agent: Mutt/1.13.1 (2019-12-14)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--zYo4Elh1vtcYNvbq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 10, 2020 at 01:41:26PM +0530, Nagarjuna Kristam wrote:
> This patch series adds OTG support on XUSB hardware used in Tegra210 and
> Tegra186 SoCs.
>=20
> This patchset is composed with :
>  - dt bindings of XUSB Pad Controller
>  - dt bindings for XUSB device Driver
>  - Tegra PHY driver for usb-role-switch and usb-phy
>  - Tegra XUSB host mode driver to support OTG mode
>  - Tegra XUSB device mode driver to use usb-phy and multi device mode
>  - dts for XUSB pad controller
>  - dts for xudc for Jetson TX1 and TX2
>  - dts for Jetson-TK1
>  - dts for Jetson-Nano
>=20
> Tegra Pad controller driver register for role switch updates for
> OTG/peripheral capable USB ports and adds usb-phy for that corresponding
> USB ports.
>=20
> Host and Device mode drivers gets usb-phy from USB2's phy and registers
> notifier for role changes to perform corresponding role tasks.
>=20
> Order of merging Patches:
> Please merge DT changes first followed Tegra PHY driver changes and then
> USB driver changes.

Felipe, Greg, Kishon,

Given the runtime dependencies between these various parts, I could pick
these up into the Tegra tree if you provide an Acked-by.

Thierry

--zYo4Elh1vtcYNvbq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl5KVBIACgkQ3SOs138+
s6GPJQ/8Dr1CPfELHw05VQk0p62qC/U3hkxpH56/8OSVsICja7BxolBa+2ptmTzw
eB1ltsaiHPgYGvl53lyIlbFDofTaukVG9g52tFx4wJM3VKrGDUwj+7a//egwL9aT
fj+QsOWrvHfLpxYfYiNGl9vhQgVhL3U25c0s0SBzBPxjdcLQbNz0erTiE64G9ZI7
TSdqsijAXQflLfp02uS/jhqWUHHhkav0wf+NrYjyq+O30UBTUjuvNA2zXoee9c1P
n45PMAk7hZ+PS5s2Q51KLcNcA83x52Yf8O5lD16GJgCOWNaGrJR+FQombCMr7Sfo
p8VYNhNlNY+CDtt03YlMqgiJZ+lUx7HAArzPUwLRYyQtY1O9fjfxYQXRzLOhPhpV
uRpBCQ2X75GmlRtVY8HHSk6sCwHGKQbUtysaWna48rsKbNou6vAIUPo62BXV/2xT
QpnuSpAzZzmjnLGEkPyZiGSXZtqIQMrz8YIZXH0TER17o9DpuijLJLO2Gdv1gTZr
CbNAv9WSsn1sNUWpH1B2aUvA2ZgRLpw0TJ+6c8rH5AKMn9/KO3fzmvLCN1jFPctz
oJO2Ctm/pym37bpOVliZzDJleKwe8tLi9afv6+VLYaRZ7P8+F4aM7ijBHuwLHLPb
i7CvOEpdpCu+WxEBihmzFm8AxpT7yc8rnVN/WAMQx5+w5Bbh9wA=
=+r7V
-----END PGP SIGNATURE-----

--zYo4Elh1vtcYNvbq--
