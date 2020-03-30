Return-Path: <SRS0=Mt+e=5P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CE52C43331
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 15:40:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CBF262072E
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 15:40:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cogentembedded-com.20150623.gappssmtp.com header.i=@cogentembedded-com.20150623.gappssmtp.com header.b="wLYxigK6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729600AbgC3Pku (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Mar 2020 11:40:50 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:43373 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729512AbgC3Pku (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Mar 2020 11:40:50 -0400
Received: by mail-lj1-f194.google.com with SMTP id g27so18526135ljn.10
        for <linux-kernel@vger.kernel.org>; Mon, 30 Mar 2020 08:40:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=t2iNbIaFPnk3agPmyy1f+f0q6P2ipfzolZ/zq3qtBgg=;
        b=wLYxigK6ce75qGpQVnSi/ehLo4z7OsT1hrSFmQzM5G2J7uvGu8lIijCbRWbEojrbXq
         kqmsl+5VMg6AXIZjRN/Zdw66ryv0oO/cemWlBBimpcfoFvl703Se39hxEFb2XtmF48KS
         y4QiSGp0Moa2q1ldW5fva5xkY2ilW7Zi7cD4s3cPf6G7Q0BYv572i6RWHGPzdoNM/HLb
         cxehI6Tck5i7Vh/RFw9KTJi52Quo3qF2byF1X0hemUbBodnLuTs5B/Rx/0gmUS2hy0nl
         epTT123yy/3/NEVe/42SULBYmqNzqJGjValYNv6PUu7nkCq40WLQaYxU0cQHsWuUfp3x
         gb4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=t2iNbIaFPnk3agPmyy1f+f0q6P2ipfzolZ/zq3qtBgg=;
        b=k1mmLRD3t/KlSRYIbrMmeAQuYWk632qnxDBN/Q0XDGnXbX4/97vQn+Trzpypk+PJBc
         rUqpUX9OWaG5Z8ULKbRSD5GZKHgXSMyHL/3Ei7r5TOun+YATuKXs9c3uwvldpKMdOOds
         AfX3GJeAWCjCj2WjHdUHHB45DsRGg35/Cib1O3s36WoCcrKmS8Wzy+Z2SEB9kQi5pEZg
         10TQ/De5Ga9Ic7peQ3OFvNi6Xit0JnHDvjCvXFPNOOJAsKFwPlPJb5qRXleaTbZriiSw
         qfsHteexjMkkc00aEERNey5+WQhns2JK67Hsr4raawpdAn+xmpuTS9qVbbBJ3TFLG3P4
         A5Hg==
X-Gm-Message-State: AGi0PuZTy5QFa6UQSo7rYRHWOOQYewYcTMOku7vg0R0weeP6l0fQHBs4
        Mb97R6m/DjnET+fnW15lPnO954XQBA0yGg==
X-Google-Smtp-Source: APiQypJPHFDKHQw+TrwwyYGZNcQlOi1smRsTSQfYnqQixygLyK2V5znQplnhieo8RtEMVHG6wruZOQ==
X-Received: by 2002:a2e:7805:: with SMTP id t5mr7779439ljc.144.1585582846749;
        Mon, 30 Mar 2020 08:40:46 -0700 (PDT)
Received: from wasted.cogentembedded.com ([2a00:1fa0:654:d00e:d4e2:9dcc:b9fb:a661])
        by smtp.gmail.com with ESMTPSA id r2sm4384825lfn.35.2020.03.30.08.40.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 30 Mar 2020 08:40:45 -0700 (PDT)
Subject: Re: [PATCH 3/5] dt-bindings: Document Loongson PCI Host Controller
To:     Jiaxun Yang <jiaxun.yang@flygoat.com>, linux-mips@vger.kernel.org
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Huacai Chen <chenhc@lemote.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Andrew Murray <amurray@thegoodpenguin.co.uk>,
        Paul Burton <paulburton@kernel.org>, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20200330114239.1112759-1-jiaxun.yang@flygoat.com>
 <20200330114239.1112759-4-jiaxun.yang@flygoat.com>
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Organization: Cogent Embedded
Message-ID: <8ef09434-45bd-3704-6ff6-7469ebe55a4f@cogentembedded.com>
Date:   Mon, 30 Mar 2020 18:40:43 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <20200330114239.1112759-4-jiaxun.yang@flygoat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-MW
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/30/2020 02:42 PM, Jiaxun Yang wrote:

> PCI host controller found on Loongson PCHs and SoCs.
> 
> Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
> ---
>  .../devicetree/bindings/pci/loongson.yaml     | 52 +++++++++++++++++++
>  1 file changed, 52 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pci/loongson.yaml
> 
> diff --git a/Documentation/devicetree/bindings/pci/loongson.yaml b/Documentation/devicetree/bindings/pci/loongson.yaml
> new file mode 100644
> index 000000000000..623847980189
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pci/loongson.yaml
> @@ -0,0 +1,52 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/pci/loongson.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Loongson PCI Host Controller
> +
> +maintainers:
> +  - Jiaxun Yang <jiaxun.yang@flygoat.com>
> +
> +description: |+
> +  PCI host controller found on Loongson PCHs and SoCs.
> +
> +allOf:
> +  - $ref: /schemas/pci/pci-bus.yaml#
> +
> +properties:
> +  compatible:
> +    oneOf:
> +      - const: loongson,rs780e-pci
> +      - const: loongson,ls7a-pci
> +      - const: loongson,ls2k-pci
> +
> +  reg:
> +    minItems: 1
> +    maxItems: 2
> +    items:
> +      - description: CFG0 standard config space register
> +      - description: CFG1 extend config space register

   Extended?

> +
> +  ranges:
> +    maxItems: 3
> +
> +
> +required:
> +  - compatible
> +  - reg
> +  - ranges
> +
> +examples:
> +  - |
> +    pci@1a000000 {
> +      compatible = "loongson,rs780e-pci";
> +      device_type = "pci";
> +      #address-cells = <3>;
> +      #size-cells = <2>;
> +
> +      reg = <0x1a000000 0x2000000>;
> +      ranges = <0x02000000 0 0x40000000 0x40000000 0 0x40000000>;
> +    };
> +...

MBR, Sergei
