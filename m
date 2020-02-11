Return-Path: <SRS0=PxPh=37=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B478C3B187
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 23:25:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62F622086A
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 23:25:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581463528;
	bh=8+QEMo0KaGrsQjqAphm6GxLxfHtuCWMrnJmpQjbwK/g=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=SeYlhB5+cMs6E/qj29N060Jx/AYSmlFQPmW7+D1NTH5H866YGnGrbsvWONczHe1HK
	 0zROwg+sFbmUR0Fh8mYzyDhSVkGdPSxMrQxiPYCzWUeE1yho0fEH748I1yhbLBfTxN
	 sMt4XDLdAtd5cqsokmFklxsdOCyaIQkZ5dlxcIEg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727949AbgBKXZ1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Feb 2020 18:25:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:49768 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727597AbgBKXZ1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Feb 2020 18:25:27 -0500
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 886FF20842;
        Tue, 11 Feb 2020 23:25:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581463526;
        bh=8+QEMo0KaGrsQjqAphm6GxLxfHtuCWMrnJmpQjbwK/g=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=U5XTL5riMETDn7faoSi8Pnp1Px8TtrAUjPASWkZ48Csm8C17M0h/f5H02c1oTu7Bj
         YLCaTDvUcL0k0QGpOtCw1hr4BFTTipSyF4zvsxGjFqNkpCQz6svyCfp+ycKAnP8zjp
         XJPgTZqSgSJ75nAOl+T1YBlRCwO8V2cunXC07l4k=
Received: by mail-qt1-f176.google.com with SMTP id e21so187717qtp.13;
        Tue, 11 Feb 2020 15:25:26 -0800 (PST)
X-Gm-Message-State: APjAAAXrkuJynduuEysHq34SG0pNlSXqutZ3CubcImPyAY4MoyNh3HxD
        aGW9ZKWy4UU3ZuDG6dCFTHoOowoRwB9INARm/g==
X-Google-Smtp-Source: APXvYqxNVEgCDQaNqwwCDpPOOn1rWM3YviMqI1BKXSNbUv+rnUKBni0IKUOeGhgwCvMRU7d2XppHctvfNrj2CeTDLd0=
X-Received: by 2002:ac8:1415:: with SMTP id k21mr4831678qtj.300.1581463525519;
 Tue, 11 Feb 2020 15:25:25 -0800 (PST)
MIME-Version: 1.0
References: <20200207203752.209296-1-pmalani@chromium.org> <20200207203752.209296-2-pmalani@chromium.org>
In-Reply-To: <20200207203752.209296-2-pmalani@chromium.org>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Tue, 11 Feb 2020 17:25:13 -0600
X-Gmail-Original-Message-ID: <CAL_JsqKnQDhnb14TsOeHhXS0UAX6kexe44pfOntrbEcxB0CC9A@mail.gmail.com>
Message-ID: <CAL_JsqKnQDhnb14TsOeHhXS0UAX6kexe44pfOntrbEcxB0CC9A@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] dt-bindings: Add cros-ec Type C port driver
To:     Prashant Malani <pmalani@chromium.org>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        heikki.krogerus@intel.com,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Benson Leung <bleung@chromium.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, Guenter Roeck <groeck@chromium.org>,
        Mark Rutland <mark.rutland@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 7, 2020 at 2:39 PM Prashant Malani <pmalani@chromium.org> wrote:
>
> Some Chrome OS devices with Embedded Controllers (EC) can read and
> modify Type C port state.
>
> Add an entry in the DT Bindings documentation that lists out the logical
> device and describes the relevant port information, to be used by the
> corresponding driver.
>
> Signed-off-by: Prashant Malani <pmalani@chromium.org>
> ---
>
> Changes in v2:
> - No changes. Patch first introduced in v2 of series.
>
>  .../bindings/chrome/google,cros-ec-typec.yaml | 77 +++++++++++++++++++
>  1 file changed, 77 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/chrome/google,cros-ec-typec.yaml
>
> diff --git a/Documentation/devicetree/bindings/chrome/google,cros-ec-typec.yaml b/Documentation/devicetree/bindings/chrome/google,cros-ec-typec.yaml
> new file mode 100644
> index 00000000000000..46ebcbe76db3c2
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/chrome/google,cros-ec-typec.yaml
> @@ -0,0 +1,77 @@
> +# SPDX-License-Identifier: GPL-2.0
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
> +  port:
> +    description: A node that represents a physical Type C port on the
> +      device.
> +    type: object
> +    properties:
> +      port-number:
> +        description: The number used by the Chrome OS EC to identify
> +          this type C port.
> +        $ref: /schemas/types.yaml#/definitions/uint32
> +      power-role:
> +        description: Determines the power role that the Type C port will
> +          adopt.
> +        oneOf:
> +          - items:
> +            - const: sink
> +            - const: source
> +            - const: dual
> +      data-role:
> +        description: Determines the data role that the Type C port will
> +          adopt.
> +        oneOf:
> +          - items:
> +            - const: host
> +            - const: device
> +            - const: dual
> +      try-power-role:
> +        description: Determines the preferred power role of the Type C port.
> +        oneOf:
> +          - items:
> +            - const: sink
> +            - const: source
> +            - const: dual
> +
> +    required:
> +      - port-number
> +      - power-role
> +      - data-role
> +      - try-power-role
> +
> +required:
> +  - compatible
> +  - port
> +
> +examples:
> +  - |+
> +    typec {
> +      compatible = "google,cros-ec-typec";
> +
> +      port@0 {

'port' is reserved for OF graph binding which this is not.

> +        port-number = <0>;
> +        power-role = "dual";
> +        data-role = "dual";
> +        try-power-role = "source";

These are usb-connector binding properties, but this is not a
usb-connector node. However, I think it should be. The main thing to
work out seems to be have multiple connectors.

With your binding, how does one associate the USB host controller with
each port/connector? That's a solved problem with the connector
binding.

Rob
