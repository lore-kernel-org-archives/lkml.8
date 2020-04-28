Return-Path: <SRS0=r24B=6M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 313F8C83004
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 10:00:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EF6AA20663
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 10:00:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ad1ZJrwL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727119AbgD1KAB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Apr 2020 06:00:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726932AbgD1KAA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 06:00:00 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41105C03C1A9;
        Tue, 28 Apr 2020 03:00:00 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id r26so2177844wmh.0;
        Tue, 28 Apr 2020 03:00:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=tm8QUuHypYdy6peDLxrq3qYWGCdtFGNET4j6OaIsk9k=;
        b=Ad1ZJrwLD9cCV39g73K95Ub4PqPOtRM7bPwvHFdVaz+X6IwPjG64p7ABxC3rxtgtwO
         iwEvDEZWFVRjbBttQmPUYXtsxVgBOFeHRWfJlI+tn0Fm24lSO+pksLAIsfjT1eCXYqRd
         OAIJw8ZkYDF1WO1eBEILaHS6T83r8yrpOieYwhC3Wv7wIK9+Mh16uHjXILCTrABuXFHu
         2dLLTbnPe3y4q5MSNAK9JR8vYiCMjl6wtlh7ua3kpcZtz/kTkt+qCoRRMl4eUDUlUQAo
         tSwgi28+QXlf7wRibE6Fw839OFuS0+Vr4TrrCpdFHp5Q/jAkcS8mtD/f7QoaI4VmtilN
         OY6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=tm8QUuHypYdy6peDLxrq3qYWGCdtFGNET4j6OaIsk9k=;
        b=Mts7jHXyTD4qv2XqMAEgpoA7HGgXM4RdOekXsZRrwfDTXxj9A7i/LpvGB1xf6MKMJQ
         AtaGhVaw9xoOeHrgNTISR5OxQwjOnPAWuVbfg5Y79H+Ku2g9qxMY9Z6pbSudqs15qbdP
         3yLrgBIu/NvDXTR4rV3GsG1NRrOtUPgUeE6oWWK/UUH9pMnEfS21ahv46o+2IR9P1/tO
         bXiXNZUiWVIYGtcLJXpH9fslkH8w4k1P/Q51zY6GhkzEqGlLpTbQKO6WEWNXdG3mXucF
         5sK3+jlOunn8OOhv7WubMrPNgV45Gve7qyKbh45SLiIHo6+rnj/l/KyZOd2tM5f1/R8P
         Hb7Q==
X-Gm-Message-State: AGi0PuaTLymbf2TjRrKCxjA2kOOtd9O129UamXQ9Qv+tnnqS7pnsLut1
        aU5AhbJM7jJ07hVYbIK9CnXGa6Zj
X-Google-Smtp-Source: APiQypIWJI1KCYKxCIxhBzkg+SuCGCYmxxz0XTo/fdyzr4E9mRlmNBRurfF/HAfitXzNcMMVI/9zSw==
X-Received: by 2002:a1c:9c0a:: with SMTP id f10mr3662331wme.139.1588067998846;
        Tue, 28 Apr 2020 02:59:58 -0700 (PDT)
Received: from localhost (p2E5BEDBA.dip0.t-ipconnect.de. [46.91.237.186])
        by smtp.gmail.com with ESMTPSA id i25sm2574222wml.43.2020.04.28.02.59.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Apr 2020 02:59:57 -0700 (PDT)
Date:   Tue, 28 Apr 2020 11:59:56 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Nagarjuna Kristam <nkristam@nvidia.com>
Cc:     balbi@kernel.org, gregkh@linuxfoundation.org, jonathanh@nvidia.com,
        mark.rutland@arm.com, robh+dt@kernel.org, kishon@ti.com,
        devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2 2/8] usb: gadget: tegra-xudc: Add vbus_draw support
Message-ID: <20200428095956.GB3592148@ulmo>
References: <1586939108-10075-1-git-send-email-nkristam@nvidia.com>
 <1586939108-10075-3-git-send-email-nkristam@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ZoaI/ZTpAVc4A5k6"
Content-Disposition: inline
In-Reply-To: <1586939108-10075-3-git-send-email-nkristam@nvidia.com>
User-Agent: Mutt/1.13.1 (2019-12-14)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ZoaI/ZTpAVc4A5k6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 15, 2020 at 01:55:02PM +0530, Nagarjuna Kristam wrote:
> Register vbus_draw to gadget ops and update corresponding vbus
> draw current to usb_phy.
>=20
> Signed-off-by: Nagarjuna Kristam <nkristam@nvidia.com>
> ---
> V2:
>  - Patch re-based.
> ---
>  drivers/usb/gadget/udc/tegra-xudc.c | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
>=20
> diff --git a/drivers/usb/gadget/udc/tegra-xudc.c b/drivers/usb/gadget/udc=
/tegra-xudc.c
> index 52a6add..9d3c109 100644
> --- a/drivers/usb/gadget/udc/tegra-xudc.c
> +++ b/drivers/usb/gadget/udc/tegra-xudc.c
> @@ -492,6 +492,7 @@ struct tegra_xudc {
>  	bool powergated;
> =20
>  	struct usb_phy **usbphy;
> +	struct usb_phy *curr_usbphy;
>  	struct notifier_block vbus_nb;
> =20
>  	struct completion disconnect_complete;
> @@ -719,6 +720,7 @@ static int tegra_xudc_vbus_notify(struct notifier_blo=
ck *nb,
>  	if (!xudc->suspended && phy_index !=3D -1) {
>  		xudc->curr_utmi_phy =3D xudc->utmi_phy[phy_index];
>  		xudc->curr_usb3_phy =3D xudc->usb3_phy[phy_index];
> +		xudc->curr_usbphy =3D usbphy;
>  		schedule_work(&xudc->usb_role_sw_work);
>  	}
> =20
> @@ -2042,6 +2044,19 @@ static int tegra_xudc_gadget_stop(struct usb_gadge=
t *gadget)
>  	return 0;
>  }
> =20
> +static int tegra_xudc_gadget_vbus_draw(struct usb_gadget *gadget,
> +						unsigned int m_a)
> +{
> +	struct tegra_xudc *xudc =3D to_xudc(gadget);
> +
> +	dev_dbg(xudc->dev, "%s: %u mA\n", __func__, m_a);
> +
> +	if (xudc->curr_usbphy->chg_type =3D=3D SDP_TYPE)
> +		usb_phy_set_power(xudc->curr_usbphy, m_a);

Do we need to propagate the error code here in case the USB PHY for some
reason doesn't support the given current? Or is it guaranteed that we
always do support whatever is passed in here?

Regardless of whether we support it or not, it might still be useful to
add proper handling, if for nothing else but to set a good example.

Thierry

--ZoaI/ZTpAVc4A5k6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl6n/pwACgkQ3SOs138+
s6HV4w/+Kh8/1qiFfVfFtWh49TeX/icuvedDrV4bIynZR70lHjKGgcQtJWzsl8ni
iDKtOJjTncd4O2qdSRId28a8LkdnhcgzehP5k43Oaq/LZQWhvFUn37xn+Fe7ELsn
D/lFytyqrePe0fWrIZiYejVCilPO+m/xz5JhkSnWxOy7FjmBBLWKjG3x9W6aNbU1
gaVzP5p0OJmOB+JXofiJM8myD+vypiUZ6y/zbKbdFi6zgw0snfSu2l3xuQKSuME2
uS+FmMhY/c4fqvc2iqNemxGv6JWQuN7Li2u/nfhPeZG8asgumTuDBjeOYKtRbpo9
80xmG8VImnB+RY8uqw6+MUQoemTcyVdY80pUc/q4DdOp1vdH3GQmoUoE8ge8bYqD
U87hN5v5Grsjw5kvMCTfxO5DKjYlyozc4UvKXM4M6joKNQZCPHZwOdMhs59VjqhY
McZOfzR2HlepxmDJJwQnrGn1vGG1w1v/RtgFv2FDo68AzkqxjMs+HszqFkYGr9Sk
vZXUb+vEXZw99ghBZQW0eoORnvOffPpXKh4JMOdVauhXqHjYKuRKCod8Nh0T3GnV
2GJhBHz9rrdDqrm8kPGwPMDC7Axtz4PGhxjxFMDf6Vt47E7cjsG5xz6TOCsAndLF
mN9CD/UwVKMH7FXexoRl9rWrIO5HjuUOx3umGI4D/ZMhfe5Pg8w=
=Gwck
-----END PGP SIGNATURE-----

--ZoaI/ZTpAVc4A5k6--
