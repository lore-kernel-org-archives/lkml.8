Return-Path: <SRS0=N8G3=3G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F5F0C33CB1
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 11:44:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E9BA2082F
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 11:44:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pd/AEEOi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726988AbgAQLoz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jan 2020 06:44:55 -0500
Received: from mail-wr1-f52.google.com ([209.85.221.52]:40101 "EHLO
        mail-wr1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726689AbgAQLoy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jan 2020 06:44:54 -0500
Received: by mail-wr1-f52.google.com with SMTP id c14so22387953wrn.7;
        Fri, 17 Jan 2020 03:44:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Cvl/0riDWi1vWOlhaM1KIHjFuBbtXHuUf7sN7cIcdUQ=;
        b=pd/AEEOiXtlnl56Ztp+4tpU0did/dgcZlz3vv9cGoAAp58rnIV5zqsR4APWP9wU++u
         b4W7mM+H46hBk9MzYmr3m9Pq8edDfmWI2k6oq4MGS/adTu5L4Hfjrl62LoezI+JqDmAl
         c2ZikBHmdrpnpaRnDPntKS6UFWR4DGn2sKx5DcBVkGQhb5MSUFScAcSPr8Aikwv1se55
         e9NvdgFAtdgnHEBh/ddNqoaAQganuNQlZ+FynoeqNSuGL1cRiKJuBy92dVjZoVe3TXSN
         LsvJzKEkrVTPlMLhAvcDx20q8rzXVedeZEszrAFrBRUyrw2IogkgEGnq3sGxu5LcLW3/
         2JoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Cvl/0riDWi1vWOlhaM1KIHjFuBbtXHuUf7sN7cIcdUQ=;
        b=dqToYzINsOBPT0uqeO2+dGhvd1DBJZEr0ClDI6amfOT/gYtk6HsMYNs82AS1poFVZ4
         snxTcQAs+DboC4cLMm0Uup+aYeKIfPufxUL90KNWMJ1ffMZ6QUe5qtmJ7ySi/r9wKoR+
         IcOShTcw4jMUeu0BTxtdIpYcV0z74nI6t9yeWY4+nNeoYd3RbhgerYumnne7fZm1F5Zg
         ZdM55G2XZUZm+VHj0qDMseqHXvHrU5QTWUVggO/zngld2F6R8eR5eaWvkuariUY2XYQi
         qnSDj8AsHVS5yzORkITiNC3nOZzT8CVJEvJN7tCM3wLj+LbY95tPZ3Ka1PYsx0q0yhkS
         9hDQ==
X-Gm-Message-State: APjAAAWrWl/Qu9q8GHWcNraJdDmIWGuZDrClFmsO5Fk+bIdcvucvf0xW
        24X1SUDhk/TQN6evmaKAmG0=
X-Google-Smtp-Source: APXvYqxpTfsgq8itcwVKHQ+rQTht6l9AeOGj8QC+aRCPB4ihGNgIclf4SeUlF/ohhCr/WxH0s19xQw==
X-Received: by 2002:a5d:6406:: with SMTP id z6mr2635993wru.294.1579261492500;
        Fri, 17 Jan 2020 03:44:52 -0800 (PST)
Received: from localhost (p2E5BEF3F.dip0.t-ipconnect.de. [46.91.239.63])
        by smtp.gmail.com with ESMTPSA id e16sm33587122wrs.73.2020.01.17.03.44.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jan 2020 03:44:51 -0800 (PST)
Date:   Fri, 17 Jan 2020 12:44:50 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     balbi@kernel.org, gregkh@linuxfoundation.org, jonathanh@nvidia.com,
        nkristam@nvidia.com, felipe.balbi@linux.intel.com,
        linux-usb@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] usb: gadget: xudc: Remove redundant
 platform_get_irq error message
Message-ID: <20200117114450.GB166525@ulmo>
References: <20200116141433.57056-1-yuehaibing@huawei.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="s/l3CgOIzMHHjg/5"
Content-Disposition: inline
In-Reply-To: <20200116141433.57056-1-yuehaibing@huawei.com>
User-Agent: Mutt/1.13.1 (2019-12-14)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--s/l3CgOIzMHHjg/5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 16, 2020 at 10:14:33PM +0800, YueHaibing wrote:
> platform_get_irq() will call dev_err() itself on failure,
> so there is no need for the driver to also do this.
> This is detected by coccinelle.
>=20
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---
>  drivers/usb/gadget/udc/tegra-xudc.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)

Acked-by: Thierry Reding <treding@nvidia.com>

--s/l3CgOIzMHHjg/5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl4hnjIACgkQ3SOs138+
s6G+ehAArX6J/MT8QnvA7i1DoizXGjeNN6C9t/2MrckIK9iyek+eMIIPaGfq0eF5
xzbgIC3XSRrjolAepid+edS44UXQU2sRkQsRwAs3JhHS+BJnbSg3m4Ekd8LY3fl4
McsE+Or8JUAhcnd7a5mFsPt6GCWCIe4bfkEycxGCifs9rgcy2kR9ltPlz0oVBsrH
Na5acjzmr5Lm4yu8cpRtKJIFPqnS47/8xrPAsC+5l4PuXRlFumy1jSGQ4bDBw54B
ThddVgBD/flrlbs7C9cV4imrc62gphEZ0fMM1OFD0mI6xxL3dNpVmWEXWb1EJRE1
i2FzxT9Iy8zL/aHtqJ+DbUlhAlUxmwe49LAKHjmdwTtwCxhQFYE9os4silhzgw45
nMIbGoNkS6HyR+OjCs5OgiSljuOXSq1ZG8ZSiUiJGBG8p3m8sdgDjcVKxdUEtIr/
s+idDzZrrA06TEA9qAp++a4oICaX36tIezjGxtRoBA3x40RjSXUvxC+7E+xqqdUt
kw97vMRuDEpkK+xhBd/8Vsoc+GJ/x51ByFwHYTdf31E30jG6vUa3EJtq5j94L4PM
rAaHfYxgFdm7iYLV+F3XR5tLcwTl3UvP+aoY59j6/dSlF20OyAP5tMO6HxEo+MiG
ikVV7exgW/qHv9ENKHDhrDVJMaNXRZOEwprUcUVKSzw4RTq1p6A=
=QX2u
-----END PGP SIGNATURE-----

--s/l3CgOIzMHHjg/5--
