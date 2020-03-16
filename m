Return-Path: <SRS0=ltrd=5B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0596AC2BB1D
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 15:14:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D095C2051A
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 15:14:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jODSjjQ0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731820AbgCPPO0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Mar 2020 11:14:26 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:38561 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731740AbgCPPOZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Mar 2020 11:14:25 -0400
Received: by mail-qt1-f195.google.com with SMTP id e20so14472238qto.5;
        Mon, 16 Mar 2020 08:14:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ixSqifDu9ZEefUiTiNVPd6ssEpIkNW/tDU5FVkyvqtI=;
        b=jODSjjQ0stgdcIWw5FmNkmjAJbTA++R+6bwpB71tEMevOeCcXd6xRVARjGV6eA0CIi
         ff/X0cqc3mG5P8xo3ALlOOD9yIN1eKOZnl+XS/gir3lTYF6EHyDVA05tqdoM6knnVx4v
         4rqF4mQv2EsNdCTTlmer+lofMTczcxeWTk9EWJszdxQxitwWB+JzL1s/INbWDK+pVd9K
         O3//Ds8qzs5cZbx9oW6HTLeEP45LAAhcYTX2WDK1/mYZTi+h/Ck95PmuDg9/CEaZ3m2p
         BSKg7H8zJVrxufhYNbUJEFK+QPj5SmObaORY5xRgPytcv17CrRenHsis4z5cBxO8yxF4
         5zCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ixSqifDu9ZEefUiTiNVPd6ssEpIkNW/tDU5FVkyvqtI=;
        b=o3Jjli9GSVx/tll2kaP4ErsfHyr42HWHh2L7q1EU+xwSRvdCgi3zRZ3QELCwM6dNY0
         z2qv1xQQqhGBkJlbtPYrOR7P78WDcDWcAYu9tscvTBUcirqImigtZU0cyda1xrrTSAza
         MrVXg+2zHI2AhQlRVeG74fzcvaGLfCeI6WVCYxdjy3vewO4kV8pA7Be0ZJQVOuFENq9R
         ILzxYJAuBdFmoajw4RYLPSCOLqNT50vpCl+9Vvb7ydASkmbRrr0RAIPWi+sM5fd9RaJd
         IiGCdHVCJP2gssUJg5MKMvT4yMY2CvfWmMpzrPNLvgldxU9tX/zP4jxjOrWvdnj8VR7v
         L4YA==
X-Gm-Message-State: ANhLgQ0SjnM9A+Vt5YSgDx+7bfqWWNWOAUTHkBszrH5hcUcc1/FpPeup
        ePkA5rlnA57jwiG+Fxn3S4MPlnQZs9QgKBzBoPE=
X-Google-Smtp-Source: ADFU+vtaag5GWTvm5ae+UqCD8pDJpDkpGX5U8Xx5cRDVwrLRbKT5Gb0dsxv/L7NnGU4/QwOiZhjTd9NsL1SQAbY2uyA=
X-Received: by 2002:ac8:683:: with SMTP id f3mr540411qth.356.1584371664321;
 Mon, 16 Mar 2020 08:14:24 -0700 (PDT)
MIME-Version: 1.0
References: <20200316090021.52148-1-pmalani@chromium.org> <20200316090021.52148-2-pmalani@chromium.org>
In-Reply-To: <20200316090021.52148-2-pmalani@chromium.org>
From:   Enric Balletbo Serra <eballetbo@gmail.com>
Date:   Mon, 16 Mar 2020 16:14:13 +0100
Message-ID: <CAFqH_50eGjYu7dHFW82CY4-EyDtq+AF+6tHCAjKbaAjW5_7WYA@mail.gmail.com>
Subject: Re: [PATCH v5 1/4] dt-bindings: Add cros-ec Type C port driver
To:     Prashant Malani <pmalani@chromium.org>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Benson Leung <bleung@chromium.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Guenter Roeck <groeck@chromium.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Prashant,

Missatge de Prashant Malani <pmalani@chromium.org> del dia dl., 16 de
mar=C3=A7 2020 a les 10:02:
>
> Some Chrome OS devices with Embedded Controllers (EC) can read and
> modify Type C port state.
>
> Add an entry in the DT Bindings documentation that lists out the logical
> device and describes the relevant port information, to be used by the
> corresponding driver.
>
> Signed-off-by: Prashant Malani <pmalani@chromium.org>

After Rob review, it can go together with the other patches through
the chrome-platform tree. From my side:

Reviewed-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>

> ---
>
> Changes in v5:
> - Updated License identifier.
> - Updated DT example to be a full example.
>
> Changes in v4:
> - Rebased on top of usb-connector.yaml, so the connector property now
>   directly references the usb-connector DT binding.
>
>  .../bindings/chrome/google,cros-ec-typec.yaml | 54 +++++++++++++++++++
>  1 file changed, 54 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/chrome/google,cros-=
ec-typec.yaml
>
> diff --git a/Documentation/devicetree/bindings/chrome/google,cros-ec-type=
c.yaml b/Documentation/devicetree/bindings/chrome/google,cros-ec-typec.yaml
> new file mode 100644
> index 0000000000000..6d7396ab8beec
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/chrome/google,cros-ec-typec.yaml
> @@ -0,0 +1,54 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/chrome/google,cros-ec-typec.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Google Chrome OS EC(Embedded Controller) Type C port driver.
> +
> +maintainers:
> +  - Benson Leung <bleung@chromium.org>
> +  - Prashant Malani <pmalani@chromium.org>
> +
> +description:
> +  Chrome OS devices have an Embedded Controller(EC) which has access to
> +  Type C port state. This node is intended to allow the host to read and
> +  control the Type C ports. The node for this device should be under a
> +  cros-ec node like google,cros-ec-spi.
> +
> +properties:
> +  compatible:
> +    const: google,cros-ec-typec
> +
> +  connector:
> +    $ref: /schemas/connector/usb-connector.yaml#
> +
> +required:
> +  - compatible
> +
> +examples:
> +  - |+
> +    spi0 {
> +      #address-cells =3D <1>;
> +      #size-cells =3D <0>;
> +
> +      cros_ec: ec@0 {
> +        compatible =3D "google,cros-ec-spi";
> +        reg =3D <0>;
> +
> +        typec {
> +          compatible =3D "google,cros-ec-typec";
> +
> +          #address-cells =3D <1>;
> +          #size-cells =3D <0>;
> +
> +          connector@0 {
> +            compatible =3D "usb-c-connector";
> +            reg =3D <0>;
> +            power-role =3D "dual";
> +            data-role =3D "dual";
> +            try-power-role =3D "source";
> +          };
> +        };
> +      };
> +    };
> --
> 2.25.1.481.gfbce0eb801-goog
>
