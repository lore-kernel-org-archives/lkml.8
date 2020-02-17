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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7306BC7619F
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 09:53:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A19420725
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 09:53:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CR2HZNed"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729072AbgBQJxm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Feb 2020 04:53:42 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:53750 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726397AbgBQJxm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Feb 2020 04:53:42 -0500
Received: by mail-wm1-f66.google.com with SMTP id s10so16458056wmh.3;
        Mon, 17 Feb 2020 01:53:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=6hH37CNCCIDCXmnxJ2+Lb09mCXL/L91BjKM1eeDMYPA=;
        b=CR2HZNedlqETpleLmz8++Ide6zBpCk2Xbor7nWVPkS5IOYk5VHUkv+Pltu16uWg17b
         ckYE0CVWaf3VvzhIpZz0881U4mNyuxHB1BLNKw6JHyFSgq45Rtfs4pVuzFREH87ohK2r
         MG3YvLr5IGY4BBcosCAfWhl9Ex2pAcPXs/o9c/1ux2t2u42bgOu2pvhz6rFu5fEx8Q7K
         vpOxeCXtviRRyGslCuP0yW2jAtV9HQbweFpofT/0WQPnV/8yLXr0jzW5nA0CcISZ2qCu
         T1yeHJbtKQnOfhZE3ycdqY6i/OfGvfPKLs+7Dm3P0P8DTG1PTARK31eKQa/6FtSmBLvZ
         GtRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=6hH37CNCCIDCXmnxJ2+Lb09mCXL/L91BjKM1eeDMYPA=;
        b=DwUM+uc4+5XviFPNwSCUMuf3fvowC+znRtXGZaCyYQ0qjTSrwqKnVXmyhZwkZNM3BD
         LbKBbnrRUdcyMhlyOa2C0NPS0JhPN6oDA3JzXYmo5u1tqIaRYQioB69cAzj6BR0MSkWd
         t3WyRFKbcn44qxbeRRHQ4RN6MIKgVNCJXPjOhrlMPDZCJkNK39hJpnodXYhR77GGhnsn
         XPevOgq0BLScxxwYhSl2oXG1VOb9vOM5n9Jc8zoGC7aCKJlpwD1ynBI8kuZmfFxW13uR
         gCKWrkYdKXYuMqa8Z374K8lFdvLBueudFWOrjXr86FgS/4nsWiDrhnQ30MRedzKZ0xh1
         sWKQ==
X-Gm-Message-State: APjAAAUw8RUlaw/68p6NBdcbBxVYp3kxoNsDDIpYQxHh0bJwtpEsWP5J
        V2RHOzpo43uL5SJvc/uBbtlwqRlO
X-Google-Smtp-Source: APXvYqy1kdVyMbZmuwlkfsmOEMd1EE3isO1ehHqqHKTqXkFsiGXphcKvwsCSNIdAvjnahvYATMhfDQ==
X-Received: by 2002:a7b:c847:: with SMTP id c7mr20521037wml.3.1581933220023;
        Mon, 17 Feb 2020 01:53:40 -0800 (PST)
Received: from localhost (p2E5BEF3F.dip0.t-ipconnect.de. [46.91.239.63])
        by smtp.gmail.com with ESMTPSA id z133sm20382457wmb.7.2020.02.17.01.53.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Feb 2020 01:53:38 -0800 (PST)
Date:   Mon, 17 Feb 2020 10:53:38 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Sowjanya Komatineni <skomatineni@nvidia.com>
Cc:     jonathanh@nvidia.com, broonie@kernel.org, lgirdwood@gmail.com,
        perex@perex.cz, tiwai@suse.com, digetx@gmail.com,
        mperttunen@nvidia.com, gregkh@linuxfoundation.org,
        sboyd@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        pdeschrijver@nvidia.com, pgaikwad@nvidia.com, spujar@nvidia.com,
        josephl@nvidia.com, daniel.lezcano@linaro.org,
        mmaddireddy@nvidia.com, markz@nvidia.com,
        devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 19/22] ASoC: tegra: Enable audio mclk during
 tegra_asoc_utils_init
Message-ID: <20200217095338.GC1345979@ulmo>
References: <1578986667-16041-1-git-send-email-skomatineni@nvidia.com>
 <1578986667-16041-20-git-send-email-skomatineni@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="hOcCNbCCxyk/YU74"
Content-Disposition: inline
In-Reply-To: <1578986667-16041-20-git-send-email-skomatineni@nvidia.com>
User-Agent: Mutt/1.13.1 (2019-12-14)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--hOcCNbCCxyk/YU74
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 13, 2020 at 11:24:24PM -0800, Sowjanya Komatineni wrote:
> Tegra PMC clock clk_out_1 is dedicated for audio mclk from Tegra30
> through Tegra210 and currently Tegra clock driver keeps the audio
> mclk enabled.
>=20
> With the move of PMC clocks from clock driver into pmc driver,
> audio mclk enable from clock driver is removed and this should be
> taken care by the audio driver.
>=20
> tegra_asoc_utils_init calls tegra_asoc_utils_set_rate and audio mclk
> rate configuration is not needed during init and set_rate is actually
> done during hw_params callback.
>=20
> So, this patch removes tegra_asoc_utils_set_rate call and just leaves
> the audio mclk enabled.
>=20
> Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
> ---
>  sound/soc/tegra/tegra_asoc_utils.c | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)

Acked-by: Thierry Reding <treding@nvidia.com>

--hOcCNbCCxyk/YU74
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl5KYqEACgkQ3SOs138+
s6FYyA//QMQ+t5PYEnti0MIjjEq+6kKbm8Guch7so7GSgu+shvfoWArh7kPMUg4s
0JLo1m9j3csL5Ou3GvATSUG1al0ze3E/gGr2gqD9401YIgyMFeuDYh7pnv0Fd5If
WTv87jqYrxItipKmPAz8OmWgQ+RbFxY2pCBWKew8yRc8q+YZUOoh5cBsL1ZqSz68
dI52Nel1Uiijui0XZx5HK7MnFzLCp7/sHJyqHlr9tpNHHTbb4et/JILVDJH3Du6S
y8HI2QDXzxK2JpbSOtybYc8Uh3cRf0E7ePUredZSGGCjXLhuUY1oY5+i/jcHgEyy
wAAsyQFfdlddoNo7D2VhiXoEyA3zCfelTOm3UjkzsUAH/SmK/zSkVh3kbMsfNF4c
+4rhKUm6iGlPS37m6oJJbxGhiQc343kuyC33bIPU19LLzx3Q6kZDaOebCWtOTtY5
iiK8o/h68lIK2XSdAjbzgS7CJ8FetbLt1/aJTQImXLnR7AHt8b513kIfT6eYA7CQ
JiMLPla4FZPq9di6gxQoh73RYm5+gZ6KbXlZKTsM3UdQC2u2OFBoJULahyPkOfrw
1+L1HPp0hH1etoYCikbo1Iu4A85Bxj9CvPHrXM8u9fuSrv6jx2DdS2KV/2xZG1to
uDi00Rz7U+A5IJri9xonvqHs6qJ/kq0OugOMImxHUwBNcjsfOg8=
=XNuc
-----END PGP SIGNATURE-----

--hOcCNbCCxyk/YU74--
