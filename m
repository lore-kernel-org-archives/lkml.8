Return-Path: <SRS0=aGSP=5L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85404C43331
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 00:10:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5CC5520714
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 00:10:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mcg2Bs1/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727606AbgCZAKc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Mar 2020 20:10:32 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:35583 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727525AbgCZAKc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Mar 2020 20:10:32 -0400
Received: by mail-pg1-f195.google.com with SMTP id 7so1984523pgr.2
        for <linux-kernel@vger.kernel.org>; Wed, 25 Mar 2020 17:10:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=2TLCIayFIh5w2c05KwNKqvVja8wF1oXdMguuXxf6c88=;
        b=mcg2Bs1/Nwi+ze10ARXtbL5aZ4s3WkjaFpQCuZL22Sr/57of9GKPV43s2w4UxOMBdI
         xWKBa9Z9Vx/ggJSwC+dcyIrGg39sNINmAfJTqyVRnZhzCQJD6Q9VR21Jq17cP6OtbLaZ
         Xi72XGXyLAKrT/95E43XifM36FwZ6b6OcD9gIVH/QAB5/U1l8gdJ1fl4nenE2jF6biNN
         Ko3yvp7K8DjUXwpIcI83p6TQjkVEheeVEN9r7CO5l2vx0x+2ZkgZwneMoFi2nBQViN3Z
         E48INybmpXNJi12nbXTBNHHZYxjN2K/0cmMNN2MMbq3GWdzT6aRVeqMgoFT1xh/lHyKP
         NbPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=2TLCIayFIh5w2c05KwNKqvVja8wF1oXdMguuXxf6c88=;
        b=RSkQltxLMmDgr1tm5F/3O7Dkdbf1dhDTu/F4i6HL71HoMNkEfAu6GMPWuBQ0NoCmQe
         uJkkOaVZ1r6p9MlPu+I2k9BeEEMJJhDqlJxz7PEQLzonuta7LDaez7odADv0oqX3tsMq
         N6Be+uWndLWueAQGmmQYBN+XZ9HLULbrg9+w4qE914aX11dnR2Glm05T4YNqujV1VG6F
         SeKPxLTg8ndYFRuzJLtakz5GOX52fguiF+eWBlUtWrLjEZUmNL3Lsbw93iE27pJH1KeS
         NUNanqRuq90uZBGG6bWbHdIiu6h7fewzAhnXQ/A1G0eSlXy56avlSe5vZVT/0EgHGKvD
         Xq5A==
X-Gm-Message-State: ANhLgQ3BlZxPBk/WosWh+XCgBemqDGybKd+b9kSv0Y0K9eBuLM4cVjbk
        DXi2ob46v9xQ19KpOMVhCNgmTA==
X-Google-Smtp-Source: ADFU+vueD5HKQNt112j2D/SR5oowg3NH7+PyYA8C/vR8DYdfCLRQnjxh6OczgKVDVdPopQiCWqM/jQ==
X-Received: by 2002:a63:6944:: with SMTP id e65mr5977248pgc.406.1585181428497;
        Wed, 25 Mar 2020 17:10:28 -0700 (PDT)
Received: from google.com ([2620:15c:202:201:bc61:d85d:eb16:9036])
        by smtp.gmail.com with ESMTPSA id d206sm229190pfd.160.2020.03.25.17.10.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Mar 2020 17:10:27 -0700 (PDT)
Date:   Wed, 25 Mar 2020 17:10:22 -0700
From:   Benson Leung <bleung@google.com>
To:     Prashant Malani <pmalani@chromium.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Benson Leung <bleung@chromium.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Guenter Roeck <groeck@chromium.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH v5 1/4] dt-bindings: Add cros-ec Type C port driver
Message-ID: <20200326001022.GA117276@google.com>
References: <20200316090021.52148-1-pmalani@chromium.org>
 <20200316090021.52148-2-pmalani@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="tThc/1wpZn/ma/RB"
Content-Disposition: inline
In-Reply-To: <20200316090021.52148-2-pmalani@chromium.org>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--tThc/1wpZn/ma/RB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Prashant,

On Mon, Mar 16, 2020 at 02:00:15AM -0700, Prashant Malani wrote:
> Some Chrome OS devices with Embedded Controllers (EC) can read and
> modify Type C port state.
>=20
> Add an entry in the DT Bindings documentation that lists out the logical
> device and describes the relevant port information, to be used by the
> corresponding driver.
>=20
> Signed-off-by: Prashant Malani <pmalani@chromium.org>

Reviewed-by: Benson Leung <bleung@chromium.org>

Hi Rob,

Will you go ahead and merge this through your tree for v5.7?

Thanks,
Benson

> ---
>=20
> Changes in v5:
> - Updated License identifier.
> - Updated DT example to be a full example.
>=20
> Changes in v4:
> - Rebased on top of usb-connector.yaml, so the connector property now
>   directly references the usb-connector DT binding.
>=20
>  .../bindings/chrome/google,cros-ec-typec.yaml | 54 +++++++++++++++++++
>  1 file changed, 54 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/chrome/google,cros-=
ec-typec.yaml
>=20
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
> --=20
> 2.25.1.481.gfbce0eb801-goog
>=20

--=20
Benson Leung
Staff Software Engineer
Chrome OS Kernel
Google Inc.
bleung@google.com
Chromium OS Project
bleung@chromium.org

--tThc/1wpZn/ma/RB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQQCtZK6p/AktxXfkOlzbaomhzOwwgUCXnvy7gAKCRBzbaomhzOw
wlL5AQCe/VHDNM66dRaoDQSNG5IZBjItx7VRHnBWlduXpWT1SwD/XH6Abd9zP4vz
zJvWwtwdlOCA4OtCkTb3NrcwSyvQowA=
=tVxd
-----END PGP SIGNATURE-----

--tThc/1wpZn/ma/RB--
