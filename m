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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F823C7619B
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 08:31:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03C8220725
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 08:31:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VGtUbVWd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728243AbgBQIbX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Feb 2020 03:31:23 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:51779 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726397AbgBQIbX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Feb 2020 03:31:23 -0500
Received: by mail-wm1-f68.google.com with SMTP id t23so16172851wmi.1;
        Mon, 17 Feb 2020 00:31:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=8rbgYJlkuhz7p0MRk02omjGLVw/OhkLVh8HKOL7Pyw4=;
        b=VGtUbVWd6GDA5GYAI1zle3ge1bn6dD2X5BWXrZcKWzpDZXpHAB1b3JKz8uoTKqBJV7
         SVGkPI6aJpLMgmu3QaI+FhltcPfFdE///lUby+3YoO99rFaCReeco/pgrH8j7/D5K7cl
         KF0t+86yOH2LZJ4WasjLYMk8ZwpwWDM2WJgImLKDHi7lpqnUn1riguf0dz81f/b08iek
         WDjk6hqqfFJ0MHomvJ062mj9PNj3Ah8NNqUPTeKMAmmfX33+4wrKsBNxCRa8tdFdIBCm
         6DOdtFSL6XfcvTJe6JfImnoUOFfsZaFXlP3f8BiKOtOTxl2pKdqjDn5TOLppKy8coOR4
         h/Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=8rbgYJlkuhz7p0MRk02omjGLVw/OhkLVh8HKOL7Pyw4=;
        b=OQVSlpa+Cdh0RL4tZiJCIfdvdEcdIYOJTGp2MR4/UwClvSas9ZJs5V34dFP7J1VEbT
         BArVPVLJsCqVSYd1Xt8E02JBQa7WLAOYfAWzhSmDiTSNwPMGl56/jai4pKh3KBO0/Y26
         STuW0iDCFdFiGdjnndeH3/BX4pAZWbt8oYtDn47Abw6vJnD7ByrWjTnMrB0LFZIqzvE3
         UFUS/j/fLLBx7Hw+ZmcQD5+C65Whzv6NnPZ3tric6ufs9zGkzWOfj84HkZTF6uee82O2
         3+uvfVEb+83tA6bD4RIeY8yNrmCy8WACpAC09UAgyiX0VbLoeCw7T90ca8YPTMW4fs/0
         1aeQ==
X-Gm-Message-State: APjAAAX2H62Wr8b0y/SkoDxtbZqvI724ERZTwpoYBZlSyRgX3nx5vIbA
        W9EnPSVePVfUuNm48j7160k=
X-Google-Smtp-Source: APXvYqz9N8PHcSSp1HK+3KW8LZATYFgVsMTTvjiUP7bT53uGJnrfzE0TO0/baeUxuBD3T3ZwnFQE6g==
X-Received: by 2002:a1c:ddd6:: with SMTP id u205mr21807313wmg.151.1581928281370;
        Mon, 17 Feb 2020 00:31:21 -0800 (PST)
Received: from localhost (p2E5BEF3F.dip0.t-ipconnect.de. [46.91.239.63])
        by smtp.gmail.com with ESMTPSA id y131sm20125840wmc.13.2020.02.17.00.31.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Feb 2020 00:31:20 -0800 (PST)
Date:   Mon, 17 Feb 2020 09:31:19 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     JC Kuo <jckuo@nvidia.com>
Cc:     gregkh@linuxfoundation.org, robh@kernel.org, jonathanh@nvidia.com,
        kishon@ti.com, linux-tegra@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, nkristam@nvidia.com
Subject: Re: [PATCH v6 4/5] arm64: tegra: Add XUSB and pad controller on
 Tegra194
Message-ID: <20200217083119.GC1339021@ulmo>
References: <20200212061133.11665-1-jckuo@nvidia.com>
 <20200212061133.11665-5-jckuo@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="69pVuxX8awAiJ7fD"
Content-Disposition: inline
In-Reply-To: <20200212061133.11665-5-jckuo@nvidia.com>
User-Agent: Mutt/1.13.1 (2019-12-14)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--69pVuxX8awAiJ7fD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 12, 2020 at 02:11:32PM +0800, JC Kuo wrote:
> Adds the XUSB pad and XUSB controllers on Tegra194.
>=20
> Signed-off-by: JC Kuo <jckuo@nvidia.com>
> ---
> Changes in v6: rebase
> Changes in v5: none
> Changes in v4: none
> Changes in v3: none
> Changes in v2:
>  - renamed xhci@3610000 with usb@3610000
>  - moved padctl@3520000 and usb@3610000 inside /cbb
>  - cleaned up "clocks" property of usb@3610000 node
>  - added blanks lines to visually separate blocks
>=20
>  arch/arm64/boot/dts/nvidia/tegra194.dtsi | 139 +++++++++++++++++++++++
>  1 file changed, 139 insertions(+)

Applied to for-5.7/arm64/dt, thanks.

Thierry

--69pVuxX8awAiJ7fD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl5KT1cACgkQ3SOs138+
s6GnYA//Sd6ujIPiLIfMs8BIr5umZlDgL84Yb3sZrCSLrvv75bXQiLBSIUUlaJXA
TrUEzOv4zD6AfYw/4+dQOWm9FKLwYDY2Cde/vVuILP5bKxnGFSqKYuFnFSFfko1m
1wP90nroVW/83B+i/28eI19IPL0tRXnjGbOhEGuKEiFLMv1wytH2OuThDjkrNbnw
hahF+j7Ip17EXejh5SFCk3oFMTwAQrD60B2CrfmHdc9EkaLRT885BSFY2EGfCTud
peNf1olQukAdafJJ27qOmoPL2WEwhVQJf1rOGrPygYPb8CcrHpwakuzYczvvA3kK
IYA+wqZxDnaNAVQurr1PM5dceI7514AW3TeZK3VlCQ6l2AJg+ZAzeOBMit7Qq1Bt
MGe4wgQyV6zhyaisPy7TrZIc8Ua/DO0ZJz6sgSWykfN+g5t7PPFPv/i4LXb/w3IB
Ndrw+AH+iDDSNSE1JbQEczmxlyDD5Yb41i6uvLhNayCuVD25k1HGlPLMOe+7qVfn
7siMqO+t2DozPnkgd1dtsYG2JzxYRwIz++rH69gyCc1LOCuKFs/hKH0qkLnGegBx
nxATs+cVNo7qab7XuoRDi47JwVZw4/IyZckYim5j6gRJR4eMooteZJVeWQ5o/9vf
G855HvFBew+mmvpfDPd0sQ1vfGYqFnSSiMmacW0nhlQFr7b9GhM=
=F5ca
-----END PGP SIGNATURE-----

--69pVuxX8awAiJ7fD--
