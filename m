Return-Path: <SRS0=F+sq=6U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15114C47256
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 18:06:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E79392087E
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 18:06:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hTnD7UKu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729827AbgEFSGl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 May 2020 14:06:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728082AbgEFSGk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 May 2020 14:06:40 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8A92C061A0F
        for <linux-kernel@vger.kernel.org>; Wed,  6 May 2020 11:06:40 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id t11so1470133pgg.2
        for <linux-kernel@vger.kernel.org>; Wed, 06 May 2020 11:06:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=FE2Opx3hl+uW9jxp1ZVpnasVASKfoo+q149+dKG+qhY=;
        b=hTnD7UKuMzIgfb5irQV+tZgWTnCYthgLCG21//72Z4Wio0uJW/dBsPCdj3wbKSnlE1
         vXYCSuIrPhejTchJur0h3EB072yeY2noMGfG7bevc++IXG64YfO8eCkJGZj1QlSAdzJL
         9l4CwFe9uWCtFWouHMu6CYCvLqj4skiIXD3wi8ea4U58AvmWMdSJOIg+jMrE1OTj66Pa
         Hc4cC+Kj4OP2CC2uWDlNQ/4xVSrMXjd4jbXX8uyvozgmWRL7oJScP+DJtmij6M/ymSaO
         /F0AsmB07ttNqKmiT39sdTnD2hKA8HSD8k7V/5B1DojDvm/vxAjIC3cHVnFR/Y8hKx2y
         pMCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=FE2Opx3hl+uW9jxp1ZVpnasVASKfoo+q149+dKG+qhY=;
        b=c5qQ6szH+FvWWOBr6M/99ElTqYzajHdvAMp/uNG6UcynXOGMRBpzkl5RDC7ZPsBtPF
         0z269kPPFSijKCRPXeFwwbZBrgqrwuwbEqn86687VbXL/alICYmXoCp4r++Q9s2WfVHE
         XdS07m+oBQCk0GJCqvFdCLh2kFN4KjVj0jhbRZmsugqJOKb/9fVgpNBaJTVHAYxRXaaW
         DfthA5YiVCIELZ8bDKbyftJchSo4XK7AIXjlW0wXo0GIFfsgKeK7fUoETFgxoiWmzmNb
         ToC1bq2SMNcfPz9r6UOO3iI7xo1McLJZAXNI5SEB81Ffo/UToJIF3tb2nUzBnDHgZe5+
         DDxQ==
X-Gm-Message-State: AGi0Pub8MxdXNmAGoT2dZx6Ge8fskcOW+ID0l2YmwNvq5Fkc4dYedPB6
        BjBN57gtFp7lmA7eAuSm2MHieg==
X-Google-Smtp-Source: APiQypLsrgGXX0cuoyAtpxCXsjMUB+pCfX4jIYB7vsfKEQH7brHN2pyTA23mas7aRrd9qaBbObi80w==
X-Received: by 2002:a62:8741:: with SMTP id i62mr9894246pfe.7.1588788399619;
        Wed, 06 May 2020 11:06:39 -0700 (PDT)
Received: from google.com ([2620:15c:202:201:bc61:d85d:eb16:9036])
        by smtp.gmail.com with ESMTPSA id w12sm2432267pfq.133.2020.05.06.11.06.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 May 2020 11:06:38 -0700 (PDT)
Date:   Wed, 6 May 2020 11:06:32 -0700
From:   Benson Leung <bleung@google.com>
To:     Prashant Malani <pmalani@chromium.org>
Cc:     linux-kernel@vger.kernel.org, heikki.krogerus@linux.intel.com,
        twawrzynczak@chromium.org, Benson Leung <bleung@chromium.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Guenter Roeck <groeck@chromium.org>,
        Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH 1/2] dt-bindings: chrome: Add cros-ec-typec mux props
Message-ID: <20200506180632.GA112329@google.com>
References: <20200422222242.241699-1-pmalani@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="C7zPtVaVf+AK4Oqc"
Content-Disposition: inline
In-Reply-To: <20200422222242.241699-1-pmalani@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--C7zPtVaVf+AK4Oqc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Prashant,

On Wed, Apr 22, 2020 at 03:22:39PM -0700, Prashant Malani wrote:
> Add properties for mode, orientation and USB data role switches for
> Type C connectors. When available, these will allow the Type C connector
> class port driver to configure the various switches according to USB PD
> information (like orientation, alt mode etc.) provided by the Chrome OS
> EC controller.
>=20
> Signed-off-by: Prashant Malani <pmalani@chromium.org>

Acked-By: Benson Leung <bleung@chromium.org>


Thanks,
Benson

> ---
>  .../bindings/chrome/google,cros-ec-typec.yaml | 27 ++++++++++++++++++-
>  1 file changed, 26 insertions(+), 1 deletion(-)
>=20
> diff --git a/Documentation/devicetree/bindings/chrome/google,cros-ec-type=
c.yaml b/Documentation/devicetree/bindings/chrome/google,cros-ec-typec.yaml
> index 6d7396ab8bee..b5814640aa32 100644
> --- a/Documentation/devicetree/bindings/chrome/google,cros-ec-typec.yaml
> +++ b/Documentation/devicetree/bindings/chrome/google,cros-ec-typec.yaml
> @@ -21,7 +21,21 @@ properties:
>      const: google,cros-ec-typec
> =20
>    connector:
> -    $ref: /schemas/connector/usb-connector.yaml#
> +    allOf:
> +      - $ref: /schemas/connector/usb-connector.yaml#
> +      - type: object
> +        properties:
> +          mode-switch:
> +            description: Reference to a DT node for the USB Type C Multi=
plexer
> +              controlling the data lines routing for this connector.
> +
> +          orientation-switch:
> +            description: Reference to a DT node for the USB Type C orien=
tation
> +              switch for this connector.
> +
> +          usb-role-switch:
> +            description: Reference to a DT node for the USB Data role sw=
itch
> +              for this connector.
> =20
>  required:
>    - compatible
> @@ -49,6 +63,17 @@ examples:
>              data-role =3D "dual";
>              try-power-role =3D "source";
>            };
> +
> +          connector@1 {
> +            compatible =3D "usb-c-connector";
> +            reg =3D <1>;
> +            power-role =3D "dual";
> +            data-role =3D "host";
> +            try-power-role =3D "source";
> +            mode-switch =3D <&typec_mux>;
> +            orientation-switch =3D <&typec_orientation_switch>;
> +            usb-role-switch =3D <&typec_mux>;
> +          };
>          };
>        };
>      };
> --=20
> 2.26.1.301.g55bc3eb7cb9-goog
>=20

--=20
Benson Leung
Staff Software Engineer
Chrome OS Kernel
Google Inc.
bleung@google.com
Chromium OS Project
bleung@chromium.org

--C7zPtVaVf+AK4Oqc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQQCtZK6p/AktxXfkOlzbaomhzOwwgUCXrL8qAAKCRBzbaomhzOw
wjVLAQDAT6R1kgL+06r1tSeEIB9nl4MxBCCxuzFDH+IkrY00OQEA3cKAH7Ac/jOR
UAz3ne6IqKpqgoS8M5v5+AaZ2pBXJgQ=
=aGiA
-----END PGP SIGNATURE-----

--C7zPtVaVf+AK4Oqc--
