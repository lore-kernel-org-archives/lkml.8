Return-Path: <SRS0=8grS=CJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71377C433E7
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 12:42:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4082020782
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 12:42:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GPRxZjjC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727053AbgHaMmc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 31 Aug 2020 08:42:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726515AbgHaMmT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Aug 2020 08:42:19 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E723C061573;
        Mon, 31 Aug 2020 05:42:17 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id i26so7937303ejb.12;
        Mon, 31 Aug 2020 05:42:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=b9Ri7SivWzc8iqz6YfSPi6XQVPBxsAkuCeZyT2uEIvQ=;
        b=GPRxZjjC6gh5BiJyQALYOryKRoLIwgEDRxc/+w2QkdKky8v4s3iqXej4AHA4uGGhec
         Srr0wWaFHSRibnOKsmGwLyD+fxh5j8dGOhriNH8znJ5edFbAht88I14NYkMAUdu1wiN4
         8JFfJCi0dlVrlNnnoASacgl973aHHoNV0eTRXFGB6kWS9jLXP/eXupU4cFbictmbQo/G
         tuAPvZ9A1yC8ohg1TCtWzWJk6xOMY4eGNKbZMXsMKA0G5k8oXqkly05K6qaBHdLAXAUk
         ldXr/FbqCqkZXUR6bzaxrlyDEYfqb5pbuiNeaEtgIBxad2P5jroAhev2DdPYFzz1UYfk
         ZUkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=b9Ri7SivWzc8iqz6YfSPi6XQVPBxsAkuCeZyT2uEIvQ=;
        b=S7LZM/GbR/7KRwawzayyKTUIg7DqMoAhBdh4HEDML17K2WKZDFf3nY1wDLQLfrDWhE
         NXGEe8IYHwHJg5JmbDZTbkDlz018nmVnP1afHr1STlRyGJwDsI47C1WBrlrDEp1Vpcpw
         x+As18IQweemSv/zYaRfWmBuP7ISkDudUwMEDf+Z2bmunh/UCYDR8jyAYDweHXDXMb/s
         v8inF6i9pjxFdl8v0fraZdLvJQOEO6FXnaAH+wKC9BvgXQqVt0pElHQ/FB10+pZ6mbzC
         vl7RhKGdfDBhduZfULGXFCOUqdEZ/+9KznzVqt7EsTeRMETxRHQ8aTwd40MuuW6DFVFD
         /CZA==
X-Gm-Message-State: AOAM530/qSbaNdEDS2L1kKvFOyvJZF1vb7iZ/5aHjGNeMwz1wD/RU03a
        +XVgSs0+kq1my9GGu6Nl/tw=
X-Google-Smtp-Source: ABdhPJxjzVlOGnmjgXAM5UFe9O78WcSoj4mqTZLj4VmrWWOA95DoyfeyXQi9ZDEP/1uGNdg8PSdegg==
X-Received: by 2002:a17:907:270d:: with SMTP id w13mr938949ejk.191.1598877736257;
        Mon, 31 Aug 2020 05:42:16 -0700 (PDT)
Received: from localhost ([62.96.65.119])
        by smtp.gmail.com with ESMTPSA id re19sm4458397ejb.86.2020.08.31.05.42.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Aug 2020 05:42:15 -0700 (PDT)
Date:   Mon, 31 Aug 2020 14:42:14 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     JC Kuo <jckuo@nvidia.com>
Cc:     gregkh@linuxfoundation.org, robh@kernel.org, jonathanh@nvidia.com,
        kishon@ti.com, linux-tegra@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, nkristam@nvidia.com
Subject: Re: [PATCH v2 11/12] usb: host: xhci-tegra: unlink power domain
 devices
Message-ID: <20200831124214.GG1689119@ulmo>
References: <20200831044043.1561074-1-jckuo@nvidia.com>
 <20200831044043.1561074-12-jckuo@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="DWg365Y4B18r8evw"
Content-Disposition: inline
In-Reply-To: <20200831044043.1561074-12-jckuo@nvidia.com>
User-Agent: Mutt/1.14.6 (2020-07-11)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--DWg365Y4B18r8evw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 31, 2020 at 12:40:42PM +0800, JC Kuo wrote:
> This commit unlinks xhci-tegra platform device with ss/host power
> domain devices. Reasons for this change is - at elpg entry, phy
> sleepwalk and wake configuration need to be done before powering
> down ss/host partitions, and phy need be powered off after powering
> down ss/host partitions. Sequence looks like roughly below:
>=20
>   tegra_xusb_enter_elpg() -> xhci_suspend()
>                           -> enable phy sleepwalk and wake if needed
>                           -> power down ss/host partitions
>                           -> power down phy
>=20
> If ss/host power domains are linked to xhci-tegra platform device, we
> are not able to perform the sequence like above.
>=20
> This commit introduces:
>   1. tegra_xusb_unpowergate_partitions() to power up ss and host
>      partitions together. If ss/host power domain devices are
>      available, it invokes pm_runtime_get_sync() to request power
>      driver to power up partitions; If power domain devices are not
>      available, tegra_powergate_sequence_power_up() will be used to
>      power up partitions.
>=20
>   2. tegra_xusb_powergate_partitions() to power down ss and host
>      partitions together. If ss/host power domain devices are
>      available, it invokes pm_runtime_put_sync() to request power
>      driver to power down partitions; If power domain devices are not
>      available, tegra_powergate_power_off() will be used to power down
>      partitions.
>=20
> Signed-off-by: JC Kuo <jckuo@nvidia.com>
> ---
>  drivers/usb/host/xhci-tegra.c | 202 +++++++++++++++++++---------------
>  1 file changed, 111 insertions(+), 91 deletions(-)
>=20
> diff --git a/drivers/usb/host/xhci-tegra.c b/drivers/usb/host/xhci-tegra.c
> index 934be1686352..ce6526c2caf6 100644
> --- a/drivers/usb/host/xhci-tegra.c
> +++ b/drivers/usb/host/xhci-tegra.c
> @@ -249,8 +249,6 @@ struct tegra_xusb {
> =20
>  	struct device *genpd_dev_host;
>  	struct device *genpd_dev_ss;
> -	struct device_link *genpd_dl_host;
> -	struct device_link *genpd_dl_ss;
> =20
>  	struct phy **phys;
>  	unsigned int num_phys;
> @@ -814,36 +812,12 @@ static void tegra_xusb_phy_disable(struct tegra_xus=
b *tegra)
> =20
>  static int tegra_xusb_runtime_suspend(struct device *dev)
>  {
> -	struct tegra_xusb *tegra =3D dev_get_drvdata(dev);
> -
> -	regulator_bulk_disable(tegra->soc->num_supplies, tegra->supplies);
> -	tegra_xusb_clk_disable(tegra);
> -
>  	return 0;
>  }
> =20
>  static int tegra_xusb_runtime_resume(struct device *dev)
>  {
> -	struct tegra_xusb *tegra =3D dev_get_drvdata(dev);
> -	int err;
> -
> -	err =3D tegra_xusb_clk_enable(tegra);
> -	if (err) {
> -		dev_err(dev, "failed to enable clocks: %d\n", err);
> -		return err;
> -	}
> -
> -	err =3D regulator_bulk_enable(tegra->soc->num_supplies, tegra->supplies=
);
> -	if (err) {
> -		dev_err(dev, "failed to enable regulators: %d\n", err);
> -		goto disable_clk;
> -	}
> -
>  	return 0;
> -
> -disable_clk:
> -	tegra_xusb_clk_disable(tegra);
> -	return err;
>  }
> =20
>  #ifdef CONFIG_PM_SLEEP
> @@ -1019,10 +993,6 @@ static int tegra_xusb_load_firmware(struct tegra_xu=
sb *tegra)
>  static void tegra_xusb_powerdomain_remove(struct device *dev,
>  					  struct tegra_xusb *tegra)
>  {
> -	if (tegra->genpd_dl_ss)
> -		device_link_del(tegra->genpd_dl_ss);
> -	if (tegra->genpd_dl_host)
> -		device_link_del(tegra->genpd_dl_host);
>  	if (!IS_ERR_OR_NULL(tegra->genpd_dev_ss))
>  		dev_pm_domain_detach(tegra->genpd_dev_ss, true);
>  	if (!IS_ERR_OR_NULL(tegra->genpd_dev_host))
> @@ -1048,20 +1018,88 @@ static int tegra_xusb_powerdomain_init(struct dev=
ice *dev,
>  		return err;
>  	}
> =20
> -	tegra->genpd_dl_host =3D device_link_add(dev, tegra->genpd_dev_host,
> -					       DL_FLAG_PM_RUNTIME |
> -					       DL_FLAG_STATELESS);
> -	if (!tegra->genpd_dl_host) {
> -		dev_err(dev, "adding host device link failed!\n");
> -		return -ENODEV;
> +	return 0;
> +}
> +
> +static int tegra_xusb_unpowergate_partitions(struct tegra_xusb *tegra)
> +{
> +	struct device *dev =3D tegra->dev;
> +	bool use_genpd;
> +	int rc;
> +
> +	use_genpd =3D of_property_read_bool(dev->of_node, "power-domains");

I don't think that's technically correct. Just because a "power-domains"
property exists in DT doesn't mean any power domains are necessarily
attached to the device. I think you'll need to check for something like

	if (dev->pm_domain)

here.

Thierry

--DWg365Y4B18r8evw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl9M8CYACgkQ3SOs138+
s6FYOBAAn6uruJBlUL3AuXOdjpp44aJJBveMlik94Wwx/oD86M1WzjcV78S/l9+D
hqTUZg94Zw+PUbBbCYWXJD63hT4hIUlErUE6PiBzvZfo4/kOh7p+XdRxcOgqH7S4
pkcD05CGe3WhCyb+zZoplLB976rzhEp5y3G9/wq3ouxm+p/KwpRQRU/p9K1PtHZQ
WNvMxfK0iV2h96yft3dMQ5Xt2sXda9q28t/9IJXAiRBLdGCZDoA64pP77Ut3RNJp
9KrFJ/dUZasF9AAOpxYpQ4m502/gEsYGBMsjT8EfuSZe4C3vIwBRN7gv5lu9l/pS
glLpjbyKzj2z+MlbrYZpoi4QG+ZH10xA1/ndwz90uOOxwLvser2++mCjQRXexY8x
pub2cdL5PafolfIyHIMm+PcWUg33xdPbE+ychI6yZbHzTMutdwQAQXiUcfPoZnYu
XD+sBRCFM/6JucRJmLskySjXqY8Qzs8/qi2g721W1cjtz0no+4VGRgF/VTcin307
wVxWm8e0UFCBIV5ydNu2M8BDofJqCcqT0lidUR+fV9oqSoNxlJitaoo5tHsO7c3h
2O/c2SQZpM/gNAMQFjYwuconxc4pQOhRv+yuhRuKFKfAvKTAh0FWVYwDA/jfFvix
wkreSVjdyh4O2lVYBZSi4nCpVR4I7Sc11AyDcAt4y+pxW0JEOSM=
=dc6T
-----END PGP SIGNATURE-----

--DWg365Y4B18r8evw--
