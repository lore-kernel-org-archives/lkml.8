Return-Path: <SRS0=gGKB=AY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84EAFC433E3
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 18:28:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6519520738
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 18:28:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594664918;
	bh=L3/edC+2NRfg6uFXps6lVYnWiIWMhRS2PHX+qAXrlok=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=JvgaVgfv+tgC7ky9z/B4/E05WDJ+6VhBX3VdS+FKLodfAobAMphrDFh8RJvafbCkE
	 oVu7K5VuquFzu0T6sU6r9+ltO8zeDs+AAQLljRMYtgi9CmL+bvkHybNSrIxjGS4hBP
	 nJKnrjL5RmPr01O6jIgDoYIszOeXpzpGqhfGLlFs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726506AbgGMS2h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jul 2020 14:28:37 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:39842 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726058AbgGMS2g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jul 2020 14:28:36 -0400
Received: by mail-io1-f67.google.com with SMTP id f23so14565713iof.6;
        Mon, 13 Jul 2020 11:28:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=exzPzBz5rQz6yIUMzfndVvT7Bt4rufTcgf1jSTFAjaU=;
        b=WvoJAVlGVQAUNKrA8YzN3PZiILhesDuMKo4jqH0SIQRVc0uKD01lz9s6XK7MApJLZG
         c1sFI4496/a2DjvkrAfv4TPkDmloUOt+omY93H8HQHybODGQ/WQDi1xGr1iv8FhQdrvA
         NEQgt7BXkzQA1GEXIkMdqjsNWxk+AbVcpcjxhhJtGsGwIyZynry5QppOdwalzq1vDU98
         ZefP0oS47cH4HL1KAtBdkWMDr9Zs2LQRI96HKxn5R5z17so/2LDvIMHWVxW+DcKwLmVL
         eVvE97Q4IZRQUPOh7iQg+/h1YoGcv0ktDJp7GBkZSOfLpBgQ7i1xqfM0Qhm/P+7PURrq
         Hciw==
X-Gm-Message-State: AOAM530lEzF5W+Ocgbu9T/8DclkGZZ8X1uEL6SRpC5juHTqX6+CWPzQ5
        rNZsN7xPxAkcGvSaT0NVDl4E8kp9nw==
X-Google-Smtp-Source: ABdhPJx/RSgVGDz76Jr+1HIdObjieMEVPnIaoLCgXhk0khUXgjR8OPb24ZvuverYsFMOBnulNbjmyA==
X-Received: by 2002:a05:6638:11cb:: with SMTP id g11mr1566054jas.14.1594664915892;
        Mon, 13 Jul 2020 11:28:35 -0700 (PDT)
Received: from xps15 ([64.188.179.252])
        by smtp.gmail.com with ESMTPSA id o16sm8451566ilt.59.2020.07.13.11.28.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2020 11:28:35 -0700 (PDT)
Received: (nullmailer pid 499962 invoked by uid 1000);
        Mon, 13 Jul 2020 18:28:34 -0000
Date:   Mon, 13 Jul 2020 12:28:34 -0600
From:   Rob Herring <robh@kernel.org>
To:     Suman Anna <s-anna@ti.com>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Lokesh Vutla <lokeshvutla@ti.com>,
        Grzegorz Jaszczyk <grzegorz.jaszczyk@linaro.org>,
        linux-remoteproc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 3/6] dt-bindings: remoteproc: Add common TI SCI rproc
 bindings
Message-ID: <20200713182834.GA494208@bogus>
References: <20200612224914.7634-1-s-anna@ti.com>
 <20200612224914.7634-4-s-anna@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200612224914.7634-4-s-anna@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 12, 2020 at 05:49:11PM -0500, Suman Anna wrote:
> Add a bindings document that lists the common TI SCI properties
> used by the K3 R5F and DSP remoteproc devices.
> 
> Signed-off-by: Suman Anna <s-anna@ti.com>
> ---
> v3: New Patch refactoring out the common ti-sci-proc properties
> 
>  .../bindings/remoteproc/ti,k3-sci-proc.yaml   | 51 +++++++++++++++++++
>  1 file changed, 51 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/remoteproc/ti,k3-sci-proc.yaml
> 
> diff --git a/Documentation/devicetree/bindings/remoteproc/ti,k3-sci-proc.yaml b/Documentation/devicetree/bindings/remoteproc/ti,k3-sci-proc.yaml
> new file mode 100644
> index 000000000000..883b6e9b5282
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/remoteproc/ti,k3-sci-proc.yaml
> @@ -0,0 +1,51 @@
> +# SPDX-License-Identifier: (GPL-2.0-only or BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/remoteproc/ti,k3-sci-proc.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Common TI K3 remote processor device bindings
> +
> +maintainers:
> +  - Suman Anna <s-anna@ti.com>
> +
> +description: |
> +  The TI K3 family of SoCs usually have one or more remote processor sub-systems
> +  like the dual-core R5F sub-system or a C66x or C71x DSP processor subsystem.
> +  The device management of these remote processors is managed by a dedicated
> +  System Processor, and the communication with that processor is managed through
> +  the TI-SCI protocol.
> +
> +  Each remote processor device node should define a common set of properties
> +  that allows the System Processor firmware to perform the device management
> +  such as powering the IPs, asserting/deasserting the resets for each of these
> +  processors.
> +
> +properties:
> +  ti,sci:
> +    $ref: /schemas/types.yaml#/definitions/phandle
> +    description:
> +      Should be a phandle to the TI-SCI System Controller node
> +
> +  ti,sci-dev-id:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description: |
> +      Should contain the TI-SCI device id corresponding to the remote processor
> +      core. Please refer to the corresponding System Controller documentation
> +      for valid values.
> +
> +  ti,sci-proc-ids:
> +    description: Should contain a single tuple of <proc_id host_id>.
> +    allOf:

You can drop allOf now.

> +      - $ref: /schemas/types.yaml#/definitions/uint32-array
> +      - maxItems: 1
> +        items:

You don't need 'maxItems' or 1st 'items' here.

> +          items:
> +            - description: TI-SCI processor id for the remote processor device
> +            - description: TI-SCI host id to which processor control
> +                           ownership should be transferred to
> +
> +required:
> +  - ti,sci
> +  - ti,sci-dev-id
> +  - ti,sci-proc-ids
> -- 
> 2.26.0
> 
