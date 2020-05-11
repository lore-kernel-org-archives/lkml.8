Return-Path: <SRS0=ABJN=6Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E2B1C54E8D
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 22:18:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0CC0B206E6
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 22:18:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589235480;
	bh=MBHatxwDoIyD6uh00m5HuFdutrrX84YoaJnOUAb+G2w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=sk8VzhlHpSqYT9I99g83+PuFHJA9+cF36AViQlzD1NIFvCaN1rHb2b1uvorVnAR5c
	 CBcRmRpXdlj0GpzSoQ/5RfvMl3A26MRNZvJmWvU7C8Upq4xWSTwYUsNQm7VFbxf5x6
	 RlXUJh5dmh9CFMB+OQm28qczYkoj3WvJQPEhSJQ4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726017AbgEKWR7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 May 2020 18:17:59 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:34596 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725828AbgEKWR7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 18:17:59 -0400
Received: by mail-oi1-f195.google.com with SMTP id c12so15546950oic.1;
        Mon, 11 May 2020 15:17:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=rzMFWA1ZnkRS4Q0DpZb1ZXl62uf9QCHFsi7YkKI8qTU=;
        b=km+W7YWfycC8pxYRBgv6wEkz4Wyj6O7RG5MPn07qseLUQs0MVY2LdFYBIXlZJbAnZW
         /96FjHaP0lDWbifuWaQQp95O+Sw9GLi+ubmFMGeEvTbBFwW7G7q9mjMjPPbHZmX+LZYi
         zXWEX70wwZOK28I/NaeZYHuUrXuJMyFwcI50ZdyhlFDtn2OOzeJOuYflNqvHWZPoG/Ni
         81TLCL7rsQ1Abh2B/X4dkbrvTNuX/HsstmXkcHZkQ9NhdcajeltXMk+HNURaMXodJ4q0
         zbY94GorhSSQlpsWE85N5avxVB6JcThtwkAh9c3z3uj67elHQohNYT0xxXNTNgK57luF
         YRqw==
X-Gm-Message-State: AGi0PuaR05QfRhTwHe14B9fIbqYtCb9b9n9InwzOAw9oaC03vcBdhvi8
        b5XzRDFK1F0it0CFxBM4cw==
X-Google-Smtp-Source: APiQypK0TZHCKyJ3o83UAgu+4BaXew5kyfHBthWDWkDub8PJ/mLJuKeKeozKHpokZfteZCSegTZxMA==
X-Received: by 2002:aca:cc15:: with SMTP id c21mr22407701oig.120.1589235477409;
        Mon, 11 May 2020 15:17:57 -0700 (PDT)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id t13sm2995644otr.43.2020.05.11.15.17.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2020 15:17:56 -0700 (PDT)
Received: (nullmailer pid 14664 invoked by uid 1000);
        Mon, 11 May 2020 22:17:55 -0000
Date:   Mon, 11 May 2020 17:17:55 -0500
From:   Rob Herring <robh@kernel.org>
To:     Ben Levinsky <ben.levinsky@xilinx.com>
Cc:     ohad@wizery.com, bjorn.andersson@linaro.org,
        michal.simek@xilinx.com, jollys@xilinx.com, rajan.vaja@xilinx.com,
        mark.rutland@arm.com, linux-remoteproc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jason Wu <j.wu@xilinx.com>,
        Wendy Liang <jliang@xilinx.com>
Subject: Re: [PATCH v4 4/5] dt-bindings: remoteproc: Add documentation for
 ZynqMP R5 rproc bindings
Message-ID: <20200511221755.GA13585@bogus>
References: <1587749770-15082-1-git-send-email-ben.levinsky@xilinx.com>
 <1587749770-15082-5-git-send-email-ben.levinsky@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1587749770-15082-5-git-send-email-ben.levinsky@xilinx.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 24, 2020 at 10:36:09AM -0700, Ben Levinsky wrote:
> Add binding for ZynqMP R5 OpenAMP.
> 
> Represent the RPU domain resources in one device node. Each RPU
> processor is a subnode of the top RPU domain node.

This needs to be sorted out as part of the system DT effort that Xilinx 
is working on. I can't see this binding co-existing with it.

> 
> Signed-off-by: Ben Levinsky <ben.levinsky@xilinx.com>
> Signed-off-by: Jason Wu <j.wu@xilinx.com>
> Signed-off-by: Wendy Liang <jliang@xilinx.com>
> Signed-off-by: Michal Simek <michal.simek@xilinx.com>
> ---
> Changes since v2:
> - update zynqmp_r5 yaml parsing to not raise warnings for extra
>   information in children of R5 node. The warning "node has a unit
>   name, but no reg or ranges property" will still be raised though 
>   as this particular node is needed to describe the
>   '#address-cells' and '#size-cells' information.
> Changes since 3:
> - remove warning '/example-0/rpu@ff9a0000/r5@0:
>   node has a unit name, but no reg or ranges property'
>   by adding reg to r5 node.
> ---
> 
>  .../remoteproc/xilinx,zynqmp-r5-remoteproc.yaml    | 127 +++++++++++++++++++++
>  1 file changed, 127 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/remoteproc/xilinx,zynqmp-r5-remoteproc.yaml
> 
> diff --git a/Documentation/devicetree/bindings/remoteproc/xilinx,zynqmp-r5-remoteproc.yaml b/Documentation/devicetree/bindings/remoteproc/xilinx,zynqmp-r5-remoteproc.yaml
> new file mode 100644
> index 0000000..41520b6
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/remoteproc/xilinx,zynqmp-r5-remoteproc.yaml
> @@ -0,0 +1,127 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: "http://devicetree.org/schemas/remoteproc/xilinx,zynqmp-r5-remoteproc.yaml#"
> +$schema: "http://devicetree.org/meta-schemas/core.yaml#"
> +
> +title: Xilinx R5 remote processor controller bindings
> +
> +description:
> +  This document defines the binding for the remoteproc component that loads and
> +  boots firmwares on the Xilinx Zynqmp and Versal family chipset.
> +
> +maintainers:
> +  - Ed Mooring <ed.mooring@xilinx.com>
> +  - Ben Levinsky <ben.levinsky@xilinx.com>
> +
> +properties:
> +  compatible:
> +    const: "xlnx,zynqmp-r5-remoteproc-1.0"
> +
> +  core_conf:
> +    description:
> +      R5 core configuration (valid string - split or lock-step)
> +    maxItems: 1
> +
> +  interrupts:
> +    description:
> +      Interrupt mapping for remoteproc IPI. It is required if the
> +      user uses the remoteproc driver with the RPMsg kernel driver.
> +    maxItems: 6
> +
> +  memory-region:
> +    maxItems: 4
> +    minItems: 4
> +  pnode-id:
> +    maxItems: 1

What is this?

> +  mboxes:
> +    maxItems: 2
> +  mbox-names:
> +    maxItems: 2
> +
> +  r5@0:
> +    type: object
> +    required:
> +        - '#address-cells'
> +        - '#size-cells'
> +        - pnode-id
> +examples:
> +  - |
> +     reserved-memory {
> +          #address-cells = <1>;
> +          #size-cells = <1>;
> +          ranges;
> +          rpu0vdev0vring0: rpu0vdev0vring0@3ed40000 {
> +               no-map;
> +               reg = <0x3ed40000 0x4000>;
> +          };
> +          rpu0vdev0vring1: rpu0vdev0vring1@3ed44000 {
> +               no-map;
> +               reg = <0x3ed44000 0x4000>;
> +          };
> +          rpu0vdev0buffer: rpu0vdev0buffer@3ed48000 {
> +               no-map;
> +               reg = <0x3ed48000 0x100000>;
> +          };
> +          rproc_0_reserved: rproc@3ed000000 {
> +               no-map;
> +               reg = <0x3ed00000 0x40000>;
> +          };
> +     };
> +     rpu: rpu@ff9a0000 {
> +          compatible = "xlnx,zynqmp-r5-remoteproc-1.0";
> +          #address-cells = <1>;
> +          #size-cells = <1>;
> +          ranges;
> +          core_conf = "split";

If split, then where is the 2nd core?

> +          reg = <0xFF9A0000 0x10000>;
> +          r5_0: r5@0 {

Unit-addresses are based on 'reg' values.

> +               ranges;
> +               #address-cells = <1>;
> +               #size-cells = <1>;
> +               reg = <0xFF9A0100 0x1000>;
> +               memory-region = <&rproc_0_reserved>, <&rpu0vdev0buffer>, <&rpu0vdev0vring0>, <&rpu0vdev0vring1>;
> +               pnode-id = <0x7>;
> +               mboxes = <&ipi_mailbox_rpu0 0>, <&ipi_mailbox_rpu0 1>;
> +               mbox-names = "tx", "rx";
> +               tcm_0_a: tcm_0@0 {
> +                    #address-cells = <1>;
> +                    #size-cells = <1>;
> +                    reg = <0xFFE00000 0x10000>;
> +                    pnode-id = <0xf>;

These nodes probably need some sort of compatible. And don't the TCMs 
have different addresses for R5 vs. the A cores?

> +               };
> +               tcm_0_b: tcm_0@1 {
> +                    #address-cells = <2>;
> +                    #size-cells = <2>;
> +                    reg = <0xFFE20000 0x10000>;
> +                    pnode-id = <0x10>;
> +               };
> +          };
> +     };
> +
> +
> +     zynqmp_ipi1 {
> +          compatible = "xlnx,zynqmp-ipi-mailbox";
> +          interrupt-parent = <&gic>;
> +          interrupts = <0 29 4>;
> +          xlnx,ipi-id = <7>;
> +          #address-cells = <1>;
> +          #size-cells = <1>;
> +          ranges;
> +
> +          /* APU<->RPU0 IPI mailbox controller */
> +          ipi_mailbox_rpu0: mailbox@ff90000 {
> +               reg = <0xff990600 0x20>,
> +                     <0xff990620 0x20>,
> +                     <0xff9900c0 0x20>,
> +                     <0xff9900e0 0x20>;
> +               reg-names = "local_request_region",
> +                        "local_response_region",
> +                        "remote_request_region",
> +                        "remote_response_region";
> +               #mbox-cells = <1>;
> +               xlnx,ipi-id = <1>;
> +          };
> +     };
> +
> +...
> -- 
> 2.7.4
> 
