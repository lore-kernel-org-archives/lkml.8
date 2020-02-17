Return-Path: <SRS0=PfNx=4F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DCBFC7619F
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 08:40:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 349182064C
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 08:40:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gAhh6AkA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728488AbgBQIkZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Feb 2020 03:40:25 -0500
Received: from mail-wr1-f49.google.com ([209.85.221.49]:38570 "EHLO
        mail-wr1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728108AbgBQIkY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Feb 2020 03:40:24 -0500
Received: by mail-wr1-f49.google.com with SMTP id y17so18529345wrh.5;
        Mon, 17 Feb 2020 00:40:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=TRV5lwTvY6dc1Jfr/wfqaukIUerKqFN+k7D9S3reWZY=;
        b=gAhh6AkAtRDAl5r9V6fQW387iILCD5H0v+foKnDqwd1RVZgN3QMmNcBEBBb4hasiwP
         rpGgzsuixPl/QvSoNUwu75zgbG8cXu28PABO0HJEmxCZoBghvw17vVoXr9pCsPMNqGrK
         8NLUG1zwmD946MqrUax+R6TybTliBKHtwpWBmlzg5yIWfFg0C6NaKQi6Vlk3AJodzNNO
         X4xY9D20QIp08yWhdQMKvMC3tdSVkPqPfTNqUTtXGfzG+qW9BK+qmcjz43M3MwI2XOMk
         1uE/UuDsJ3A6E24VRfz8piVlPGiROcUg/tNMA4YT258Sw5+W+Aaz93yXijrQ+Ruz44Mw
         fbIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=TRV5lwTvY6dc1Jfr/wfqaukIUerKqFN+k7D9S3reWZY=;
        b=RUVhzgKGlV4SqLGaYMJmg0SH69QQvnHHbN86CUFcXby+ACS5TlFfHJ1ynyBgKSuIoN
         Tyri2UTMW5n/+Wj79jX3fOKM6VnCk1B/2ECjy0TKX5SeC60tOw6TCsmRSnUOiH+VDSYQ
         8p7qEx/5/TsbeEWR46FNx3RlBoGGlDXwFNO2cKOsEkecQb78G+hSLlVMaN9xi16awbm5
         TY8Y5SilZzacuHJABqzMBIU47Bj+CWiSLnJPMb5JzHdQqpntdgz7Z9W3VtrDQqWTrkch
         Uj8otiARs4iIaeQXS/VF9yDkKXTv71+JDKU03JO1SKLbwLooUfsf6jbc66fJkmXy9fm9
         rKkg==
X-Gm-Message-State: APjAAAWib5wSExQ1axTTG7YmdmQxZE2jdjxsqbBAeeL6HK0c9I4MQS3D
        axFNLjjLNl4pu1HgwxlRX8zRFmqp
X-Google-Smtp-Source: APXvYqxjE8+ZJF8beLUYGhXibZonn/lA7ME1yo+jqcGgejDevhKZoLjmhfqjz0heKJO9zifI+ria+A==
X-Received: by 2002:adf:b60f:: with SMTP id f15mr21657647wre.372.1581928822403;
        Mon, 17 Feb 2020 00:40:22 -0800 (PST)
Received: from localhost (p2E5BEF3F.dip0.t-ipconnect.de. [46.91.239.63])
        by smtp.gmail.com with ESMTPSA id y139sm19859094wmd.24.2020.02.17.00.40.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Feb 2020 00:40:21 -0800 (PST)
Date:   Mon, 17 Feb 2020 09:40:20 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Nagarjuna Kristam <nkristam@nvidia.com>
Cc:     balbi@kernel.org, gregkh@linuxfoundation.org, jonathanh@nvidia.com,
        mark.rutland@arm.com, robh+dt@kernel.org, kishon@ti.com,
        devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [Patch V5 10/21] usb: gadget: tegra-xudc: Add usb-phy support
Message-ID: <20200217084020.GG1339021@ulmo>
References: <1581322307-11140-1-git-send-email-nkristam@nvidia.com>
 <1581322307-11140-11-git-send-email-nkristam@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="MrRUTeZlqqNo1jQ9"
Content-Disposition: inline
In-Reply-To: <1581322307-11140-11-git-send-email-nkristam@nvidia.com>
User-Agent: Mutt/1.13.1 (2019-12-14)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--MrRUTeZlqqNo1jQ9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 10, 2020 at 01:41:36PM +0530, Nagarjuna Kristam wrote:
> usb-phy is used to get notified on the USB role changes. Get usb-phy from
> the UTMI PHY.
>=20
> Signed-off-by: Nagarjuna Kristam <nkristam@nvidia.com>
> ---
> V5:
>  - No changes.
> ---
> V4:
>  - Addressed nit comments from Thierry.
>  - usb_phy_event is used to detect device mode instead of usb_role.
> ---
> V2-V3:
>  - No changes in this version
> ---
>  drivers/usb/gadget/udc/tegra-xudc.c | 48 +++++++++++++++++++++++++++++++=
+++---
>  1 file changed, 45 insertions(+), 3 deletions(-)

Acked-by: Thierry Reding <treding@nvidia.com>

--MrRUTeZlqqNo1jQ9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl5KUXQACgkQ3SOs138+
s6He/A/+NvmNzVycAfLDcJJgsSNYD4OlUiIZfaPP1qgjhMSdtb0HekLzdiKabsPz
jp9VHDewmnEGM8Dg89vurRKJoAAMmVBTO9SrBAWcEp3ld+dLguxLG+SVpL4Ji+9S
tl8zybuUHDNmxZLVQ1Haxmba0KaI8OuaN4bDDB73WPCXS8I753N18QN/eaKuE05+
XjjhTmtcgmnWOyxZOf7x4V695kmFmUwckoCaSLGE+65Cdl9xifi5krBl6NfhfNKO
O5AcGRmBLmtVdw6AjekQJJ9ZT7PTlBYaZnwUso2GKNOSNQWzk9nNqSZn/eeXpUgD
1di8H0Fta77xSGiTO0dG4xln2B1sktjscc1Kw0xkDZLxeWS2neN3TvjYGuXzROhe
QAbpGEG5BvA/K+7/wHP9jFEfXUh+MEzHyTpsUju55jgk7LzfL7jUfMXdu8iVcnax
oDKdtyC+x8ugUFr3Uz/9TorjGTbKMnBV1li8CqIwMpFZBCNqnuN49PMJPkrjgCB2
o6OTtuYxtadBB2qAoO/8LIM/0c0je7yy7it6LjPCp55ELZmjaajeBWrEjDPvXNPZ
Fm8NkfoG7mtVCSCUQtGv/0rktNh9rCbg57JRmLPIW5yRlQL0jrVUCPAfEqD38X9s
intiE4YDqHbL8m/1RpNiM3nWvM+kNrC0TBNSSrEIwOQtIyAVEK4=
=gtx2
-----END PGP SIGNATURE-----

--MrRUTeZlqqNo1jQ9--
