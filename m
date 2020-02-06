Return-Path: <SRS0=za8s=32=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 980D6C35247
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 20:47:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6DE44218AC
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 20:47:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581022029;
	bh=7J8NePqtdzYSyVac95J46nuNxiPor8ST71BVygX8b1w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=NriIkeLZtyOoj3s9tBUNjnomLZjM3qZjvxmKRrhnyDjce7pUDw2Z5vO7K57LQUL1e
	 l4AF/EsVvwQ/ljKXIOkRQi6NJrwRqH3fiJ4gHv5ea2hvWLorMSQMwbjdZTCnyd2gnn
	 OIauAnfZQ8u99rYqIyV2SMF2jAWMNcdprOVDb5nY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728092AbgBFUrI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Feb 2020 15:47:08 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:39073 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728030AbgBFUpt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Feb 2020 15:45:49 -0500
Received: by mail-pl1-f196.google.com with SMTP id g6so36273plp.6;
        Thu, 06 Feb 2020 12:45:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=jLTew4RI9WjJuJSt4kCXOUmH0fL8LgaBZiB6Bzr7kEA=;
        b=fwRg3olFzBfrB26C7HS3fBqTOXwbRh+U/p5j3iFAP85QOTI4Q7kVaBflQsPfPe0Q+7
         sSlpitSs29IG2Adkj+DkMrxfVGWzp6lJ7Z+Gb9pqPhbRNnADEqfRtFlIOjDSivWegRCx
         Phb95HYpQtnlm4hiilfy/Zm+cpIYhbYU54SoODdeM9kP8kudlIzkk2ejTXzs0ZIddO95
         sOPHyxh4z8Te0F3lWyjrxMQjPtdExxTkk02VvUAQUNFLPIRtVhl081j3VXJZ1vlq+TF6
         ZzPmTvn882qoegz44bVCGY0Vr1+3RJ++Vi8/6n9vufrm99+OVJYvvVU0UK/T+CrKB0TJ
         vKjQ==
X-Gm-Message-State: APjAAAVtKeO57znbD1UoWpOlpBsuNuqaXRlj1Tun5usu6PFZYK4/sRja
        Qevi93vuPR73iCFJfqljppngfEP6wg==
X-Google-Smtp-Source: APXvYqw6qAQzrK7/A43W1PRNx0n+Xqq5FVNHJDtNv3UuBTkDbhgXyrKY1gkrAw4vlw7S1s6iKvUhQQ==
X-Received: by 2002:a17:902:8498:: with SMTP id c24mr5869574plo.233.1581021949049;
        Thu, 06 Feb 2020 12:45:49 -0800 (PST)
Received: from rob-hp-laptop (63-158-47-182.dia.static.qwest.net. [63.158.47.182])
        by smtp.gmail.com with ESMTPSA id q21sm270965pff.105.2020.02.06.12.45.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Feb 2020 12:45:48 -0800 (PST)
Received: (nullmailer pid 12394 invoked by uid 1000);
        Thu, 06 Feb 2020 17:48:26 -0000
Date:   Thu, 6 Feb 2020 17:48:26 +0000
From:   Rob Herring <robh@kernel.org>
To:     min.li.xe@renesas.com
Cc:     mark.rutland@arm.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: ptp: Add IDT 82P33 based PTP clock
Message-ID: <20200206174826.GA6395@bogus>
References: <1580326471-5389-1-git-send-email-min.li.xe@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1580326471-5389-1-git-send-email-min.li.xe@renesas.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 29, 2020 at 02:34:31PM -0500, min.li.xe@renesas.com wrote:
> From: Min Li <min.li.xe@renesas.com>
> 
> Add device tree binding doc for the PTP clock based on IDT 82P33
> Synchronization Management Unit (SMU).
> 
> Signed-off-by: Min Li <min.li.xe@renesas.com>
> ---
>  .../devicetree/bindings/ptp/ptp-idt82p33.yaml      | 47 ++++++++++++++++++++++
>  1 file changed, 47 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/ptp/ptp-idt82p33.yaml
> 
> diff --git a/Documentation/devicetree/bindings/ptp/ptp-idt82p33.yaml b/Documentation/devicetree/bindings/ptp/ptp-idt82p33.yaml
> new file mode 100644
> index 0000000..11d1b40
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/ptp/ptp-idt82p33.yaml
> @@ -0,0 +1,47 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/ptp/ptp-idt82p33.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: IDT 82P33 PTP Clock Device Tree Bindings
> +
> +description: |
> +  IDT 82P33XXX Synchronization Management Unit (SMU) based PTP clock
> +
> +maintainers:
> +  - Min Li <min.li.xe@renesas.com>
> +
> +properties:
> +  compatible:
> +    enum:
> +      - idt,82p33810
> +      - idt,82p33813
> +      - idt,82p33814
> +      - idt,82p33831
> +      - idt,82p33910
> +      - idt,82p33913
> +      - idt,82p33914
> +      - idt,82p33931
> +
> +  reg:
> +    maxItems: 1
> +    description:
> +      I2C slave address of the device.

Can drop the description. That's every device.

> +
> +required:
> +  - compatible
> +  - reg
> +
> +examples:
> +  - |
> +    i2c@1 {
> +        compatible = "abc,acme-1234";
> +        reg = <0x01 0x400>;

Just do:

i2c {

Eventually undocumented compatibles are going to throw warnings.

> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +        phc@51 {
> +            compatible = "idt,82p33810";
> +            reg = <0x51>;
> +        };
> +    };
> -- 
> 2.7.4
> 
