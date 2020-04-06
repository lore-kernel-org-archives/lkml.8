Return-Path: <SRS0=Zj89=5W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 281CAC2BA19
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 10:05:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5F9B2063A
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 10:05:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FacHHc+V"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726992AbgDFKFS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Apr 2020 06:05:18 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:43544 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726883AbgDFKFS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Apr 2020 06:05:18 -0400
Received: by mail-wr1-f66.google.com with SMTP id w15so10439886wrv.10;
        Mon, 06 Apr 2020 03:05:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=0tO7qYHShLZtkYLoWqZdme05F28qiTafVE+ie9CPm+U=;
        b=FacHHc+Ve/FsyxlMwcp/ELyDcpBBR4FUOhLkL/oGlAcWieRc5prKdGur+vGog5Wdzy
         e350bmIi2cmBfBs96Xcc5FPhviKdGBR0X0wBjg1SeeWWXgBmr1tUKslL8BgydRFSwDrM
         lPz5SNKfvkmf1Ckf/vp3orhAIqCmiAhfFmYQjXDz3+IGd7eVqhJ/LPOWwN66v4CMaEV8
         FQ72KbaZpIPsWin0mO+RyVGPfrZwo5ISdNFXx7lTMsOFnhPFX4eW8DP+qd2M/5PIi6a0
         7roUwVlA/QNYuAvZnkSM9wS/wou0HIulLFUOQGdnd3YevTmRW7va0ZvlUxoNFBGIrlyt
         Jolg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=0tO7qYHShLZtkYLoWqZdme05F28qiTafVE+ie9CPm+U=;
        b=Ghh1qJRHcd0qfu2R9nZzpU08E0Dgml+IZ5SSdeG9FzAp7VH2e26mdxVXipFYYXvrA0
         6IfoDZGFmO2sXnytDegxxZuIbNCRKOKoOQiD5wuFa6YslzkiLb94jQXDjQ1kTcdvSN+J
         RvAfuEWbtuTQLwHp3l6+VBi2VERH19/ehR+gaj/1CUT6WxrM6FLS8OlO4Q1udcyBsEa+
         KZFHjju2FE9N+EZlidSd7TEYX05eh0fCVrIsqqY52BwsuADpSBUThuWALQDVJ/zFKlH7
         /tses95l0QWVKtgYgSEG4v44KRH7IzbXUZxOSr3jryJ2BlIHTQwv4pMzrTLTBw23FplI
         210w==
X-Gm-Message-State: AGi0Pua8iop/yOudCSsDyWYfw1BeoWDKYEFQAFlvvFKajewwDEeSsV7m
        K1wZTOmjJRZW8MnN44GVeWU=
X-Google-Smtp-Source: APiQypJWxcMenGaf7dx5vasdM0pTt65nxXxjnNC3cDM+mvVWxyfTQCbb+fN7JixUXFSa013EomKZiA==
X-Received: by 2002:adf:bb4c:: with SMTP id x12mr3932121wrg.82.1586167516689;
        Mon, 06 Apr 2020 03:05:16 -0700 (PDT)
Received: from localhost (pD9E51D62.dip0.t-ipconnect.de. [217.229.29.98])
        by smtp.gmail.com with ESMTPSA id z16sm10528370wrg.66.2020.04.06.03.05.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Apr 2020 03:05:15 -0700 (PDT)
Date:   Mon, 6 Apr 2020 12:05:14 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Tang Bin <tangbin@cmss.chinamobile.com>
Cc:     stern@rowland.harvard.edu, gregkh@linuxfoundation.org,
        jonathanh@nvidia.com, linux-usb@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usb: host: ehci-tegra: Remove superfluous dev_err()
 message
Message-ID: <20200406100514.GC475759@ulmo>
References: <20200406055530.10860-1-tangbin@cmss.chinamobile.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="bAmEntskrkuBymla"
Content-Disposition: inline
In-Reply-To: <20200406055530.10860-1-tangbin@cmss.chinamobile.com>
User-Agent: Mutt/1.13.1 (2019-12-14)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--bAmEntskrkuBymla
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 06, 2020 at 01:55:30PM +0800, Tang Bin wrote:
> The platform_get_irq() can print error message,so remove the redundant
> dev_err() here.
>=20
> Signed-off-by: Tang Bin <tangbin@cmss.chinamobile.com>
> ---
>  drivers/usb/host/ehci-tegra.c | 1 -
>  1 file changed, 1 deletion(-)

Acked-by: Thierry Reding <treding@nvidia.com>

--bAmEntskrkuBymla
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl6K/toACgkQ3SOs138+
s6EFiQ/9HplumsKrtti66E0YSQfH8LrXsSNONksobklebtje7hxEn+0GDKDzoFT8
yYMmEQMLLwZuOpaK884bFA8FZ4hGtZp7lNNV7oBJkkb/Ecfmsz6IL32LwEhGMWXr
aGYYctiRXIUJNjVcE9dCIUArp8G/qzNmrb4rOv4/EqXw50FIz5DdwCWiQiDEmpBO
kr/qnxF7fUPCcKJSIeoKGc8GVv61ML3YAUVC7tgLYLKSde8okR0fGtSnkwdSPGqS
HBoJ5gKHCizrbvP2z9Fx0Ek1jpmutscmmigR3oidgefcLqqRhEdek7b4phZmmGHE
Aq5n3Vbgqwcdh16WAvgz4Zen+8MF2sMNHWYGDY/PxzzBnVAimqptha3D1urc1Oda
OFJ679xu1DK2hKiaVnb7zDpD9DtARuy3JX8JyV2TuTd43Q59nLN1L5GtW3CtRYmg
LzN36Y8v+aB3faNkRDI5tipxkRezOJxTO2ETIISqcnvwqEn5kWz0LQ3MOxZFuiv0
/GzzbWTC2zIyaj8Hhyc2yokNXRdblt64alNLeRzNsHmieweoW6TUtxDb0pwdSBJw
BWhlF5PnzzI810uaxyVDt2B6O7GfN9Au84gM+MdkDmIY0OZdyikVq8j1vHzGpxTY
nQAJ+8b6zdgjh/WMnljO/EvkiFAF5e1wyjP1MsR1EfATzbJNeWo=
=B7KZ
-----END PGP SIGNATURE-----

--bAmEntskrkuBymla--
