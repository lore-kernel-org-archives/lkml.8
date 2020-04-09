Return-Path: <SRS0=n+Ub=5Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C17B5C2BB86
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 13:59:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91C0C20730
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 13:59:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=verdurent-com.20150623.gappssmtp.com header.i=@verdurent-com.20150623.gappssmtp.com header.b="FxVC96kM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727049AbgDIN74 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Apr 2020 09:59:56 -0400
Received: from mail-ua1-f68.google.com ([209.85.222.68]:34291 "EHLO
        mail-ua1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726951AbgDIN7z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Apr 2020 09:59:55 -0400
Received: by mail-ua1-f68.google.com with SMTP id d23so3964565uak.1
        for <linux-kernel@vger.kernel.org>; Thu, 09 Apr 2020 06:59:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=verdurent-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6jkl82fMmpPtjMZVRujvoQOTRneX3UQjhsTCNuv3S3s=;
        b=FxVC96kMHeavDRhR9NWDUmy5X49gFWh+0HDbaZ+6UAnMrYLIJRBzFUzjIg5nPzxoBt
         5TBgUZVAHEdP1R0TyuZ9lnFvvuIHvJBobOtbitVPPXKY/vCVO3XVZYahbUJoDoTnPZNZ
         yqxmWfG17xufkMVcpF2SWFHvkVpXZk7zp+AM0WYwKew0o4xf3jubzWh/IKVh692yiXTG
         BK/OC78W9NuBBh4XwFtoL0dnoumlFR41FMU//UDE4T5k8Iae0juCPjjByqkCIX5G+Lve
         FjYpYaR8S3OAGW8iSoabqVJmnJk8LaYyh56y27V3s/ThIjWI03x7Dfs5AkWDG1u28hQI
         W+ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6jkl82fMmpPtjMZVRujvoQOTRneX3UQjhsTCNuv3S3s=;
        b=kmqve16uetWOPqYyMM7fEWPl6mY+Kv8YVw0puLQ+ZzONNWqlJk8Rz8x5q5u4WoWruw
         oKucfJTAAJubgw8068+9vaP6VVHiXIH1fDBSDhWhiehLDoD+br9DltxB0zQ3jVAUoxpm
         lEjn2N+KrBI4A5ru0kW93qHFZ3Fqd+3EaXdMbXoVBtogYpxtFd9DjOpC93SqYdHdDKax
         rUeoTyDRBlgnvzPtR4U1NMG2GCwXPkj/0kVqL6xPBQdOBUgvNDfNjdclY9Jn1ZP2Sw5+
         5kfx2yVLYBU1sqQ+Eo3SZK34CZYv08LC1pXBqKGsEz1HGtTj8ZLgUeA33necv435HLKo
         2mEw==
X-Gm-Message-State: AGi0PuYR2s9oVuSPVxlBJd4lNnj+mLGvzzZpzvO4FhNnTXwEOtfbGI+M
        ZZi+nEUDAJAkWcaJeSZV+IP+Huzoepgwwey8nJ4g5w==
X-Google-Smtp-Source: APiQypIDFpo4gH1UScb4MbAQVnWTILN06mQONvAjwMuBOpgK2p9AlvbueRBggIkJbzWGyZJKZKNcrD7wzAfLjecKsWE=
X-Received: by 2002:ab0:608b:: with SMTP id i11mr9020160ual.94.1586440794633;
 Thu, 09 Apr 2020 06:59:54 -0700 (PDT)
MIME-Version: 1.0
References: <1586402293-30579-1-git-send-email-Anson.Huang@nxp.com>
In-Reply-To: <1586402293-30579-1-git-send-email-Anson.Huang@nxp.com>
From:   Amit Kucheria <amit.kucheria@verdurent.com>
Date:   Thu, 9 Apr 2020 19:29:43 +0530
Message-ID: <CAHLCerNonZ7qJi8Qihmj87QteEnxTF0PRS6vw5GPemMurOfS9Q@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: thermal: Convert i.MX8MM to json-schema
To:     Anson Huang <Anson.Huang@nxp.com>
Cc:     Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>, kernel@pengutronix.de,
        Fabio Estevam <festevam@gmail.com>,
        Linux PM list <linux-pm@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        lakml <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        dl-linux-imx <Linux-imx@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Anson,

On Thu, Apr 9, 2020 at 8:56 AM Anson Huang <Anson.Huang@nxp.com> wrote:
>
> Convert the i.MX8MM thermal binding to DT schema format using json-schema

Would it be possible to have a single yaml file for all i.MX thermal
sensors by playing with required and optional properties ?

> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> ---
>  .../devicetree/bindings/thermal/imx8mm-thermal.txt | 15 ------
>  .../bindings/thermal/imx8mm-thermal.yaml           | 53 ++++++++++++++++++++++
>  2 files changed, 53 insertions(+), 15 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/thermal/imx8mm-thermal.txt
>  create mode 100644 Documentation/devicetree/bindings/thermal/imx8mm-thermal.yaml
>
> diff --git a/Documentation/devicetree/bindings/thermal/imx8mm-thermal.txt b/Documentation/devicetree/bindings/thermal/imx8mm-thermal.txt
> deleted file mode 100644
> index 3629d3c..0000000
> --- a/Documentation/devicetree/bindings/thermal/imx8mm-thermal.txt
> +++ /dev/null
> @@ -1,15 +0,0 @@
> -* Thermal Monitoring Unit (TMU) on Freescale i.MX8MM SoC
> -
> -Required properties:
> -- compatible : Must be "fsl,imx8mm-tmu" or "fsl,imx8mp-tmu".
> -- reg : Address range of TMU registers.
> -- clocks : TMU's clock source.
> -- #thermal-sensor-cells : Should be 0 or 1. See ./thermal.txt for a description.
> -
> -Example:
> -tmu: tmu@30260000 {
> -       compatible = "fsl,imx8mm-tmu";
> -       reg = <0x30260000 0x10000>;
> -       clocks = <&clk IMX8MM_CLK_TMU_ROOT>;
> -       #thermal-sensor-cells = <0>;
> -};
> diff --git a/Documentation/devicetree/bindings/thermal/imx8mm-thermal.yaml b/Documentation/devicetree/bindings/thermal/imx8mm-thermal.yaml
> new file mode 100644
> index 0000000..53a42b3
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/thermal/imx8mm-thermal.yaml
> @@ -0,0 +1,53 @@
> +# SPDX-License-Identifier: GPL-2.0
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/thermal/imx8mm-thermal.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: NXP i.MX8M Mini Thermal Binding
> +
> +maintainers:
> +  - Anson Huang <Anson.Huang@nxp.com>
> +
> +properties:
> +  compatible:
> +    oneOf:
> +      - items:
> +          - enum:
> +              - fsl,imx8mm-tmu
> +              - fsl,imx8mp-tmu
> +  reg:
> +    description: |
> +      Address range of TMU registers.
> +    maxItems: 1
> +  clocks:
> +    description: |
> +      TMU's clock source.
> +    maxItems: 1
> +
> +  # See ./thermal.txt for details

Don't point to thermal.txt anymore. thermal.txt will be replaced by
thermal-*.yaml files at some point soon.

> +  "#thermal-sensor-cells":
> +    enum:
> +      - 0

Don't you have multiple sensors connected to this controller? In that
case, 0 won't be a valid value.

> +      - 1
> +
> +required:
> +  - compatible
> +  - reg
> +  - clocks
> +  - '#thermal-sensor-cells'
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/clock/imx8mm-clock.h>
> +
> +    tmu: tmu@30260000 {
> +         compatible = "fsl,imx8mm-tmu";
> +         reg = <0x30260000 0x10000>;
> +         clocks = <&clk IMX8MM_CLK_TMU_ROOT>;
> +         #thermal-sensor-cells = <0>;
> +    };
> +
> +...
> --
> 2.7.4
>
