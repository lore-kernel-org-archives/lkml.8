Return-Path: <SRS0=4xmc=56=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75698C2BB1D
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 23:50:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4DF0F2076B
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 23:50:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586908204;
	bh=Ta/a/jsZTXWomQK9b0NQipsMBPIc66j48kQ7+U0J5Ek=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ehQqE99lIl6nnbFQds+KRWS4NAmQgjOnfp7w7vK611Z3lNPeinTisvqOD71Fq9Zj8
	 d9j58uH+5NeGgyFamkwqRXfCAYS9Zc/Hqv1ZGQS0W/IGvpf65nqb+zzQu7/9HJ2EJu
	 W5yGSj0O5OeqomwJEGsGCUSegrkH9KVErude2tic=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2634421AbgDNXuB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Apr 2020 19:50:01 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:42099 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731575AbgDNXtu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 19:49:50 -0400
Received: by mail-ot1-f68.google.com with SMTP id l21so1594100otd.9;
        Tue, 14 Apr 2020 16:49:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ErGz/RmN1nNcMdKysMZ4QZyfLOTmTqEmcgzrHidWa00=;
        b=ZWlJ/WpzzGu9qjM6IHUPGp3r7lcNJkd1Jz/xzLAVSkcFmlle0/tn4byoxvyup8gVxF
         QVCUtEzU5gBMY/AJ3x1AqFf93UKvnZsglCX7mfvtVQggSDqHVuOWVtVlptvz0JS8rZkN
         oRWMSGFgaM9mqxz6lxbcxVg/hHv5Kk0HXZtf8WVJe7aq1hGsAJ5elcURsdbVaffCh1NZ
         0WK7oNIK2GnKEG4ONV/2wAhDcQpndjuiBTi5XzCNPcwCe2zZdHPu6CFruRO3arwzfqX/
         NOQjg9xyfxz7F16hmNB8NPD9+c1uVFU/T/a/4HrONSxajZZp/CbXqaWVUhmKA0th6yeU
         dkVg==
X-Gm-Message-State: AGi0PuY14HRlCkA/ovHyYmvirOqpIjHJ1QUEFYq7k0/lCX8mrzxt7ft2
        Fq7Ivb/21VIvFSYZPVc2kA==
X-Google-Smtp-Source: APiQypJZufTrwX1G/fitQmoTtHPOYT+eQR62XJjFIzEKrvQjyVS3XgX0fIR0P3iFCf2lzUhQvtbcGw==
X-Received: by 2002:a9d:441:: with SMTP id 59mr10612961otc.236.1586908189851;
        Tue, 14 Apr 2020 16:49:49 -0700 (PDT)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id l7sm5632301otj.52.2020.04.14.16.49.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2020 16:49:49 -0700 (PDT)
Received: (nullmailer pid 28246 invoked by uid 1000);
        Tue, 14 Apr 2020 23:49:48 -0000
Date:   Tue, 14 Apr 2020 18:49:47 -0500
From:   Rob Herring <robh@kernel.org>
To:     Dhananjay Kangude <dkangude@cadence.com>
Cc:     linux-edac@vger.kernel.org, bp@alien8.de, mchehab@kernel.org,
        tony.luck@intel.com, james.morse@arm.com,
        linux-kernel@vger.kernel.org, mparab@cadence.com,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v3 1/2] dt-bindings: edac: Add cadence ddr mc support
Message-ID: <20200414234947.GA24554@bogus>
References: <20200406131341.1253-1-dkangude@cadence.com>
 <20200406131341.1253-2-dkangude@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200406131341.1253-2-dkangude@cadence.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 06, 2020 at 03:13:40PM +0200, Dhananjay Kangude wrote:
> Add documentation for cadence ddr memory controller EDAC DTS bindings
> 
> Signed-off-by: Dhananjay Kangude <dkangude@cadence.com>
> ---
>  .../devicetree/bindings/edac/cdns,ddr-edac.yaml    |   47 ++++++++++++++++++++
>  1 files changed, 47 insertions(+), 0 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/edac/cdns,ddr-edac.yaml
> 
> diff --git a/Documentation/devicetree/bindings/edac/cdns,ddr-edac.yaml b/Documentation/devicetree/bindings/edac/cdns,ddr-edac.yaml
> new file mode 100644
> index 0000000..30ea757
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/edac/cdns,ddr-edac.yaml
> @@ -0,0 +1,47 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/edac/cdns,ddr-edac.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Cadence DDR IP with ECC support (EDAC)
> +
> +description:
> +  This binding describes the Cadence DDR/LPDDR IP with ECC feature enabled
> +  to detect and correct CE/UE errors.
> +
> +maintainers:
> +  - Dhananjay Kangdue <dkangude@cadence.com>
> +
> +properties:
> +  compatible:
> +    enum:
> +      - cdns,ddr4-mc

Surely there's more than 1 version?

> +
> +  reg:
> +    minItems: 1
> +    maxItems: 2
> +    items:
> +      - description:
> +          Register block of DDR/LPDDR apb registers up to mapped area.
> +          Mapped area contains the register set for memory controller,
> +          phy and PI module register set doesn't part of this mapping.

doesn't part of this mapping?

Need a description for the 2nd region.

> +
> +  interrupts:
> +    maxItems: 1
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    edac: edac@fd100000 {

memory-controller@

> +        compatible = "cdns,ddr4-mc-edac";

Doesn't match.

> +        reg = <0xfd100000 0x4000>;
> +        interrupts = <0x00 0x01 0x04>;
> +    };
> +...
> -- 
> 1.7.1
> 
