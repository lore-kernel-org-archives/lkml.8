Return-Path: <SRS0=f73W=7K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B098C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 20:58:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 351C12075F
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 20:58:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590699522;
	bh=gIueZzkCj0HPcKgtDcgpsJz7kHyzA+CcNHEqtWW4l3w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=XbqAkGckOO89vhJRDFGyuUm1D36Wt0o26nRYro69Sn6ABGnR6L1V+Ubc8G7A24bbl
	 47eOGa1p3BYtTZ3izlOnnTI/67dfOjAZR6Maei9AmX6qfbN+94qo5laxCcYv/O2JxH
	 J+mg/w9E61aRQSzfRMcnvX07dA1h6NgQOiRn5bs8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407443AbgE1U6l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 May 2020 16:58:41 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:43192 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2407425AbgE1U6h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 16:58:37 -0400
Received: by mail-io1-f66.google.com with SMTP id h10so31733655iob.10;
        Thu, 28 May 2020 13:58:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=0OE13/YcfcuIgMOcZKAEHNiiPaiVI+IeYxI7zCjSk1Y=;
        b=eHhflt6j7P6aFkgCjwTGQlb2Cbcf18lN9nFJvg4jV/guWsn2FIfpW7rc1i1fm4m8+2
         GrQFOjp5qtT8JE2eFN9h1JNqj0cbyd82tn6M2jYQmwM4UdVy5Qru9TQK/4Ow3GSc201+
         wjOM6gkI6y8Uz6vKu4cUY0VWzlwVR8QYTyuCotvwXA7TZ5GlSR6kHxlQLkNZ/SbhL9fg
         qPUQ+v63niUAt4muK1xnr0yCYYCEmJ7dW/CWMnG9OIGvL1oOgzt4B9GZ/tZxZZ4yLHPb
         XY/A6AzFppdNYcmKYUK3eOj0gmXL816Cqe/gv+RilTRpPBk08nwh4l/OwoHS0bRV2Qv0
         Goyg==
X-Gm-Message-State: AOAM533KTZtLWN+25d2X3Iki13o0I6VkalBSU6rXY3Ar+Y4uiovNKNC/
        ElwLZ7PppdzTarC9I7UopA==
X-Google-Smtp-Source: ABdhPJyeGXf+N7QgJ4mdrW9SGDUzzeXHtJr/aHlTp3/e7mhh+MQQDOZnNRcPHGYNak1+8XA3c41Fkg==
X-Received: by 2002:a05:6602:22d6:: with SMTP id e22mr3936741ioe.128.1590699516559;
        Thu, 28 May 2020 13:58:36 -0700 (PDT)
Received: from xps15 ([64.188.179.252])
        by smtp.gmail.com with ESMTPSA id f10sm3607558ilj.85.2020.05.28.13.58.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2020 13:58:35 -0700 (PDT)
Received: (nullmailer pid 664152 invoked by uid 1000);
        Thu, 28 May 2020 20:58:34 -0000
Date:   Thu, 28 May 2020 14:58:34 -0600
From:   Rob Herring <robh@kernel.org>
To:     Anson Huang <Anson.Huang@nxp.com>
Cc:     daniel.lezcano@linaro.org, tglx@linutronix.de, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        ping.bai@nxp.com, aisheng.dong@nxp.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, Linux-imx@nxp.com
Subject: Re: [PATCH V2 1/3] dt-bindings: timer: Convert i.MX GPT to
 json-schema
Message-ID: <20200528205834.GA660327@bogus>
References: <1589860547-3207-1-git-send-email-Anson.Huang@nxp.com>
 <1589860547-3207-2-git-send-email-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1589860547-3207-2-git-send-email-Anson.Huang@nxp.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 19, 2020 at 11:55:45AM +0800, Anson Huang wrote:
> Convert the i.MX GPT binding to DT schema format using json-schema.
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> ---
> Changes since V1:
> 	- remove unnecessary compatible item descriptions;
> 	- remove unnecessary maxItems for clocks/clock-names;
> ---
>  .../devicetree/bindings/timer/fsl,imxgpt.txt       | 45 ------------
>  .../devicetree/bindings/timer/fsl,imxgpt.yaml      | 80 ++++++++++++++++++++++
>  2 files changed, 80 insertions(+), 45 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/timer/fsl,imxgpt.txt
>  create mode 100644 Documentation/devicetree/bindings/timer/fsl,imxgpt.yaml
> 
> diff --git a/Documentation/devicetree/bindings/timer/fsl,imxgpt.txt b/Documentation/devicetree/bindings/timer/fsl,imxgpt.txt
> deleted file mode 100644
> index 5d8fd5b..0000000
> --- a/Documentation/devicetree/bindings/timer/fsl,imxgpt.txt
> +++ /dev/null
> @@ -1,45 +0,0 @@
> -Freescale i.MX General Purpose Timer (GPT)
> -
> -Required properties:
> -
> -- compatible : should be one of following:
> -  for i.MX1:
> -  - "fsl,imx1-gpt";
> -  for i.MX21:
> -  - "fsl,imx21-gpt";
> -  for i.MX27:
> -  - "fsl,imx27-gpt", "fsl,imx21-gpt";
> -  for i.MX31:
> -  - "fsl,imx31-gpt";
> -  for i.MX25:
> -  - "fsl,imx25-gpt", "fsl,imx31-gpt";
> -  for i.MX50:
> -  - "fsl,imx50-gpt", "fsl,imx31-gpt";
> -  for i.MX51:
> -  - "fsl,imx51-gpt", "fsl,imx31-gpt";
> -  for i.MX53:
> -  - "fsl,imx53-gpt", "fsl,imx31-gpt";
> -  for i.MX6Q:
> -  - "fsl,imx6q-gpt", "fsl,imx31-gpt";
> -  for i.MX6DL:
> -  - "fsl,imx6dl-gpt";
> -  for i.MX6SL:
> -  - "fsl,imx6sl-gpt", "fsl,imx6dl-gpt";
> -  for i.MX6SX:
> -  - "fsl,imx6sx-gpt", "fsl,imx6dl-gpt";
> -- reg : specifies base physical address and size of the registers.
> -- interrupts : should be the gpt interrupt.
> -- clocks : the clocks provided by the SoC to drive the timer, must contain
> -           an entry for each entry in clock-names.
> -- clock-names : must include "ipg" entry first, then "per" entry.
> -
> -Example:
> -
> -gpt1: timer@10003000 {
> -	compatible = "fsl,imx27-gpt", "fsl,imx21-gpt";
> -	reg = <0x10003000 0x1000>;
> -	interrupts = <26>;
> -	clocks = <&clks IMX27_CLK_GPT1_IPG_GATE>,
> -		 <&clks IMX27_CLK_PER1_GATE>;
> -	clock-names = "ipg", "per";
> -};
> diff --git a/Documentation/devicetree/bindings/timer/fsl,imxgpt.yaml b/Documentation/devicetree/bindings/timer/fsl,imxgpt.yaml
> new file mode 100644
> index 0000000..5479290
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/timer/fsl,imxgpt.yaml
> @@ -0,0 +1,80 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/timer/fsl,imxgpt.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Freescale i.MX General Purpose Timer (GPT)
> +
> +maintainers:
> +  - Sascha Hauer <s.hauer@pengutronix.de>
> +
> +properties:
> +  compatible:
> +    oneOf:
> +      - const: "fsl,imx1-gpt"
> +      - const: "fsl,imx21-gpt"
> +      - items:
> +          - const: "fsl,imx27-gpt"
> +          - const: "fsl,imx21-gpt"
> +      - const: "fsl,imx31-gpt"
> +      - items:
> +          - const: "fsl,imx25-gpt"
> +          - const: "fsl,imx31-gpt"
> +      - items:
> +          - const: "fsl,imx50-gpt"
> +          - const: "fsl,imx31-gpt"
> +      - items:
> +          - const: "fsl,imx51-gpt"
> +          - const: "fsl,imx31-gpt"
> +      - items:
> +          - const: "fsl,imx53-gpt"
> +          - const: "fsl,imx31-gpt"
> +      - items:
> +          - const: "fsl,imx6q-gpt"
> +          - const: "fsl,imx31-gpt"
> +      - const: "fsl,imx6dl-gpt"
> +      - items:
> +          - const: "fsl,imx6sl-gpt"
> +          - const: "fsl,imx6dl-gpt"
> +      - items:
> +          - const: "fsl,imx6sx-gpt"
> +          - const: "fsl,imx6dl-gpt"

Don't need quotes.

Group all the ones with the same fallback to a single 'items' list 
using enum for the first entry.

Rob
