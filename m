Return-Path: <SRS0=F/Af=7W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10BDFC433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 23:04:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D06A12072F
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 23:04:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591743892;
	bh=moczUC36VykAyFkoIp9pElBGUFPl9/IrhPvHfPQwVMQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=moQkcNiD139LncRZQTiXNREXzYqaIU9YqBlKhj1xY+AH8h9ibAdhTd64uO3y9/6i/
	 51WcZWTJDgpmnq+6dO17fmawYXsw+TWOpfN4L95au5D5z3rCeQC2igA6AszrEdG3vT
	 5yT664K4OPtcwq8A4sBFFUybX0GeROd/R8+/oTQY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729073AbgFIXEv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jun 2020 19:04:51 -0400
Received: from mail-io1-f45.google.com ([209.85.166.45]:33705 "EHLO
        mail-io1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728527AbgFIXEu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jun 2020 19:04:50 -0400
Received: by mail-io1-f45.google.com with SMTP id i25so92285iog.0;
        Tue, 09 Jun 2020 16:04:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=WM6pC+NaWV8CTga8ZnlVnJ5VfcCeVmRJv2RMndMJd+c=;
        b=jzXCWG7ox2YX3VCHAFJ1y5JpfNINBSH8K8H4lYwFFHKl2gnvZk5Zb+TrSRQOEQK/8c
         aOPIr7XRNldkMzYX08mw+OUmP9ibr1oUfExIQJxE+5tMGi17cw0Ywn85oUfhnnCkONbA
         D5kXXJ1+lsHM5Pm24tZbjM9KUiYYYtiF27YuEym/AFptq5Tk0k5J2ER7l8dXepKtYiJr
         Wds8F0dULw/acdEb5Ad8FsrYcb6vEL5wR95DndvErvXF2VCKlO3j2bnhxk7fHISDyQJp
         A2LcGq38TvQJZCGZpFCRVcYHezchUbaXlEu3qceTqzsFMQbOh7025E1eoHoi682gtPos
         JE2w==
X-Gm-Message-State: AOAM533ZZ0lnpPVEXvMfltf3cVfVPCG2GerKwKn6JYx8J30D4E5jgX6Q
        ce2mFyuV3q0pGqvtzsgcOLhkMGs=
X-Google-Smtp-Source: ABdhPJwOXnWBlPPjiKf9bCvET4uGRf1cCsJ6WSZ4GTiLWLE4BDf6KUE175QXCkWFOpZSmnTCvJL6mA==
X-Received: by 2002:a05:6638:272:: with SMTP id x18mr495856jaq.122.1591743889297;
        Tue, 09 Jun 2020 16:04:49 -0700 (PDT)
Received: from xps15 ([64.188.179.251])
        by smtp.gmail.com with ESMTPSA id g17sm9881885ilc.18.2020.06.09.16.04.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2020 16:04:48 -0700 (PDT)
Received: (nullmailer pid 1674233 invoked by uid 1000);
        Tue, 09 Jun 2020 23:04:47 -0000
Date:   Tue, 9 Jun 2020 17:04:47 -0600
From:   Rob Herring <robh@kernel.org>
To:     Roger Quadros <rogerq@ti.com>
Cc:     kishon@ti.com, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCHv2 1/3] dt-binding: phy: convert ti,omap-usb2 to YAML
Message-ID: <20200609230447.GA1670701@bogus>
References: <20200602114606.32045-1-rogerq@ti.com>
 <20200602114606.32045-2-rogerq@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200602114606.32045-2-rogerq@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 02, 2020 at 02:46:04PM +0300, Roger Quadros wrote:
> Move ti,omap-usb2 to its own YAML schema.
> 
> Signed-off-by: Roger Quadros <rogerq@ti.com>
> ---
>  .../devicetree/bindings/phy/ti,omap-usb2.yaml | 69 +++++++++++++++++++
>  .../devicetree/bindings/phy/ti-phy.txt        | 37 ----------
>  2 files changed, 69 insertions(+), 37 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/phy/ti,omap-usb2.yaml
> 
> diff --git a/Documentation/devicetree/bindings/phy/ti,omap-usb2.yaml b/Documentation/devicetree/bindings/phy/ti,omap-usb2.yaml
> new file mode 100644
> index 000000000000..2bbea8d2bcb1
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/phy/ti,omap-usb2.yaml
> @@ -0,0 +1,69 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/phy/ti,omap-usb2.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: OMAP USB2 PHY
> +
> +maintainers:
> + - Kishon Vijay Abraham I <kishon@ti.com>
> + - Roger Quadros <rogerq@ti.com>
> +
> +properties:
> +  compatible:
> +    items:
> +      - enum:
> +        - "ti,dra7x-usb2"
> +        - "ti,dra7x-usb2-phy2"
> +        - "ti,am654-usb2"
> +      - enum:
> +        - "ti,omap-usb2"

Don't need quotes on all these.

Otherwise,

Reviewed-by: Rob Herring <robh@kernel.org>
