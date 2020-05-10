Return-Path: <SRS0=j177=6Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FE37C54E8E
	for <linux-kernel@archiver.kernel.org>; Sun, 10 May 2020 21:16:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6253B20731
	for <linux-kernel@archiver.kernel.org>; Sun, 10 May 2020 21:16:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VS49VFY/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729327AbgEJVQS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 May 2020 17:16:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726955AbgEJVQS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 May 2020 17:16:18 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99B9EC061A0E
        for <linux-kernel@vger.kernel.org>; Sun, 10 May 2020 14:16:16 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id f23so2925728pgj.4
        for <linux-kernel@vger.kernel.org>; Sun, 10 May 2020 14:16:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=T1YHG/jLGkHW1PImDnhsEhSbbjf0GXZtQSdmka52FVw=;
        b=VS49VFY/Oq+4m3WwZ2fKvx3QyIVF/bDpqgcRZcwAU0Te9T9JCmMn7OeQZD/ahXHqIN
         21vBtDqOwAk3B1gSsA5jtI+w6jpu14GpuMIDezaUdQHJzneLLFH0tHYxLHOpnpXG+0em
         XkxLx+kPgDpncsYnVtRev75Odw8E+svyq+nPgAOMTnkYe9LJ/CI+MnEZxP0xQvy+j2BB
         Pn7ZGnWH7b7d5seQHL0PRkCrVpVW3CI+b0LZqmFw7vPf4G1L/91eQFzI10Pl71NAb338
         cZYY4t+ssuk3oVWUpfLsiAVWVhWCSRW20GgB95Xuq/aNbL/KWBcKCkDriUTYu34IIF7o
         55cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=T1YHG/jLGkHW1PImDnhsEhSbbjf0GXZtQSdmka52FVw=;
        b=hdXy+KOjbAnyeiBGpEbycZ3AyCiXSQMbHOSL1cH9D2DFa1EwRtj2dI6NfaTuIpCiEU
         43oo9fO36DZL4/CbtgtlIPGjeZbkOmj1Kz2lD7UJy0XJ4QiZ2j6UZv3Z5W0C5845py4M
         L1rHsqQrx65idA8P3+VB8lWE7DKV/KjjuYiqqtPzC4G0t6FnUCOiJNdQlDOIqcLvCr6/
         trd+HWtsdI90mfAbw4eqZc335N5L8knJMa2U+5cHFC2x3N7LhmXJiD6uurxJhA/EIOll
         6WoxjUPhMyeo4xD1dREmuHF2RM6FpuEDnKmH0a6jGpz5MbmWfst7xloBVj7kJ77fLhX7
         0xdQ==
X-Gm-Message-State: AGi0PubhIJ0PFR/NZnR+8nq3igQ42ZZHd00h3htDQ7N5ZqclaDQjtjYI
        gWp317r6mhUgE/tqVP0nByQXUd6EOP4=
X-Google-Smtp-Source: APiQypKrkelRsg4jpWb/3CfRd+k8ToIyn/Tjedf39t32eVsuwNLHPob1nds3UNl1seDI1A4MFj0mLA==
X-Received: by 2002:a62:e51a:: with SMTP id n26mr13180855pff.301.1589145375491;
        Sun, 10 May 2020 14:16:15 -0700 (PDT)
Received: from google.com ([2620:15c:202:201:bc61:d85d:eb16:9036])
        by smtp.gmail.com with ESMTPSA id 128sm7331566pfy.5.2020.05.10.14.16.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 May 2020 14:16:13 -0700 (PDT)
Date:   Sun, 10 May 2020 14:16:07 -0700
From:   Benson Leung <bleung@google.com>
To:     Prashant Malani <pmalani@chromium.org>
Cc:     linux-kernel@vger.kernel.org, bleung@chromium.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        "open list:USB TYPEC CLASS" <linux-usb@vger.kernel.org>
Subject: Re: [PATCH] usb: typec: mux: intel: Fix DP_HPD_LVL bit field
Message-ID: <20200510211607.GA200380@google.com>
References: <20200510203148.122364-1-pmalani@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ibTvN161/egqYuK8"
Content-Disposition: inline
In-Reply-To: <20200510203148.122364-1-pmalani@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ibTvN161/egqYuK8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Prashant,

On Sun, May 10, 2020 at 01:31:43PM -0700, Prashant Malani wrote:
> According to the PMC Type C Subsystem (TCSS) Mux programming guide rev
> 0.6, the PMC HPD request LVL bit field is bit 5.
> Fix the definition here to match the programming guide.
>=20
> Since this bit field is changing, explicitly define a field for the
> HPD_HIGH mode data bit.
>=20
> Signed-off-by: Prashant Malani <pmalani@chromium.org>
> Fixes: 6701adfa9693 ("usb: typec: driver for Intel PMC mux control")

Reviewed-by: Benson Leung <bleung@chromium.org>


> ---
>  drivers/usb/typec/mux/intel_pmc_mux.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/usb/typec/mux/intel_pmc_mux.c b/drivers/usb/typec/mu=
x/intel_pmc_mux.c
> index 67c5139cfa0d..15074aec94eb 100644
> --- a/drivers/usb/typec/mux/intel_pmc_mux.c
> +++ b/drivers/usb/typec/mux/intel_pmc_mux.c
> @@ -63,6 +63,7 @@ enum {
>  #define PMC_USB_ALTMODE_DP_MODE_SHIFT	8
> =20
>  /* TBT specific Mode Data bits */
> +#define PMC_USB_ALTMODE_HPD_HIGH	BIT(14)
>  #define PMC_USB_ALTMODE_TBT_TYPE	BIT(17)
>  #define PMC_USB_ALTMODE_CABLE_TYPE	BIT(18)
>  #define PMC_USB_ALTMODE_ACTIVE_LINK	BIT(20)
> @@ -75,7 +76,7 @@ enum {
> =20
>  /* Display HPD Request bits */
>  #define PMC_USB_DP_HPD_IRQ		BIT(5)
> -#define PMC_USB_DP_HPD_LVL		BIT(6)
> +#define PMC_USB_DP_HPD_LVL		BIT(4)
> =20
>  struct pmc_usb;
> =20
> @@ -158,8 +159,7 @@ pmc_usb_mux_dp(struct pmc_usb_port *port, struct type=
c_mux_state *state)
>  			 PMC_USB_ALTMODE_DP_MODE_SHIFT;
> =20
>  	if (data->status & DP_STATUS_HPD_STATE)
> -		req.mode_data |=3D PMC_USB_DP_HPD_LVL <<
> -				 PMC_USB_ALTMODE_DP_MODE_SHIFT;
> +		req.mode_data |=3D PMC_USB_ALTMODE_HPD_HIGH;
> =20
>  	return pmc_usb_command(port, (void *)&req, sizeof(req));
>  }
> --=20
> 2.26.2.645.ge9eca65c58-goog
>=20

--=20
Benson Leung
Staff Software Engineer
Chrome OS Kernel
Google Inc.
bleung@google.com
Chromium OS Project
bleung@chromium.org

--ibTvN161/egqYuK8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQQCtZK6p/AktxXfkOlzbaomhzOwwgUCXrhvFwAKCRBzbaomhzOw
wg7iAP0VvDuYdVZGybu1M8JMraNsEsSA1oCwk5V+hDxNHIzZGwEAmNVVIljQ+r00
GG9XXH8XILYOF5+VgRCYGRCMSnPl7wE=
=IJDh
-----END PGP SIGNATURE-----

--ibTvN161/egqYuK8--
