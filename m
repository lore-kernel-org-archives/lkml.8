Return-Path: <SRS0=qBN/=CU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBA89C43461
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Sep 2020 00:32:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 98AD721D81
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Sep 2020 00:32:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599784329;
	bh=UiJ+tjUwdN6I83bQ9lMpiASXNuSfegaRd4S0aUWadTU=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:List-ID:From;
	b=BQtNTKDxaI8MqNgIvhISuQEafWxUA9kW/UpHS6E3kAQR18MuUqb5luubDzGerVuCr
	 Y7zjXflI6nCQREVTj8nzKDOXNUvxJh/RuDNbglnv9NikRUzyDvGB5VdofevxFKXg2a
	 caUzVerOS8NIilIgqq0OdgwYu4jLTIw9HBUVEV1A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725781AbgIKAcH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Sep 2020 20:32:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:35016 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725290AbgIKAcF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 20:32:05 -0400
Received: from localhost (c-67-164-102-47.hsd1.ca.comcast.net [67.164.102.47])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B8D98208FE;
        Fri, 11 Sep 2020 00:32:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599784324;
        bh=UiJ+tjUwdN6I83bQ9lMpiASXNuSfegaRd4S0aUWadTU=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=Eu+3wmxKLdizAwL0WtecMunAz7AMBTRx0ZYAsLft15R+arAc7TxeCxdThSIFanSM8
         T2X8/ijD01PUwmgb9eyNyA9v0csJNtrEuFJBrat5ofOKaKNf61vRT+qD+mXQIKbfec
         xVHBtdz4/AsKGZAkyBQeA00hNWXWVmE/dTqa11mA=
Date:   Thu, 10 Sep 2020 17:32:02 -0700 (PDT)
From:   Stefano Stabellini <sstabellini@kernel.org>
X-X-Sender: sstabellini@sstabellini-ThinkPad-T480s
To:     Ben Levinsky <ben.levinsky@xilinx.com>
cc:     punit1.agrawal@toshiba.co.jp, stefanos@xilinx.com,
        michals@xilinx.com, devicetree@vger.kernel.org,
        emooring@xilinx.com, michael.auchter@ni.com,
        mathieu.poirier@linaro.org, linux-remoteproc@vger.kernel.org,
        linux-kernel@vger.kernel.org, jliang@xilinx.com,
        robh+dt@kernel.org, Jason Wu <j.wu@xilinx.com>,
        Michal Simek <michal.simek@xilinx.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v13 4/5] dt-bindings: remoteproc: Add documentation for
 ZynqMP R5 rproc bindings
In-Reply-To: <20200904143209.31235-5-ben.levinsky@xilinx.com>
Message-ID: <alpine.DEB.2.21.2009101725520.28991@sstabellini-ThinkPad-T480s>
References: <20200904143209.31235-1-ben.levinsky@xilinx.com> <20200904143209.31235-5-ben.levinsky@xilinx.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 4 Sep 2020, Ben Levinsky wrote:
> Add binding for ZynqMP R5 OpenAMP.
> 
> Represent the RPU domain resources in one device node. Each RPU
> processor is a subnode of the top RPU domain node.
> 
> Signed-off-by: Jason Wu <j.wu@xilinx.com>
> Signed-off-by: Wendy Liang <jliang@xilinx.com>
> Signed-off-by: Michal Simek <michal.simek@xilinx.com>
> 
> Signed-off-by: Ben Levinsky <ben.levinsky@xilinx.com>
> ---
> v3:
> - update zynqmp_r5 yaml parsing to not raise warnings for extra
>   information in children of R5 node. The warning "node has a unit
>   name, but no reg or ranges property" will still be raised though 
>   as this particular node is needed to describe the
>   '#address-cells' and '#size-cells' information.
> v4::
> - remove warning '/example-0/rpu@ff9a0000/r5@0: 
>   node has a unit name, but no reg or ranges property'
>   by adding reg to r5 node.
> v5:
> - update device tree sample and yaml parsing to not raise any warnings
> - description for memory-region in yaml parsing
> - compatible string in yaml parsing for TCM
> v6:
> - remove coupling TCM nodes with remoteproc 
> - remove mailbox as it is optional not needed
> v7:
> - change lockstep-mode to xlnx,cluster-mode
> v9:
> - show example IPC nodes and tcm bank nodes
> v11:
> - add property meta-memory-regions to illustrate link
>   between r5 and TCM banks
> - update so no warnings from 'make dt_binding_check'
> ---
>  .../xilinx,zynqmp-r5-remoteproc.yaml          | 123 ++++++++++++++++++
>  1 file changed, 123 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/remoteproc/xilinx,zynqmp-r5-remoteproc.yaml
> 
> diff --git a/Documentation/devicetree/bindings/remoteproc/xilinx,zynqmp-r5-remoteproc.yaml b/Documentation/devicetree/bindings/remoteproc/xilinx,zynqmp-r5-remoteproc.yaml
> new file mode 100644
> index 000000000000..148374c61908
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/remoteproc/xilinx,zynqmp-r5-remoteproc.yaml
> @@ -0,0 +1,123 @@
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
> +  Note that the Linux has global addressing view of the R5-related memory (TCM)
> +  so the absolute address ranges are provided in TCM reg's.
> +maintainers:
> +  - Ed Mooring <ed.mooring@xilinx.com>
> +  - Ben Levinsky <ben.levinsky@xilinx.com>
> +
> +properties:
> +  compatible:
> +    const: "xlnx,zynqmp-r5-remoteproc-1.0"
> +
> +  lockstep-mode:
> +    description:
> +      R5 core configuration (split is 0 or lock-step and 1)
> +    maxItems: 1
> +
> +  interrupts:
> +    description:
> +      Interrupt mapping for remoteproc IPI. It is required if the
> +      user uses the remoteproc driver with the RPMsg kernel driver.
> +    maxItems: 6
> +
> +  memory-region:
> +    description:
> +      collection of memory carveouts used for elf-loading and inter-processor
> +      communication.
> +    maxItems: 4
> +    minItems: 4
> +  meta-memory-regions:
> +    description:
> +      collection of memories that are not present in the top level memory
> +      nodes' mapping. For example, R5s' TCM banks. These banks are needed
> +      for R5 firmware meta data such as the R5 firmware's heap and stack
> +  pnode-id:
> +    maxItems: 1
> +  mboxes:
> +    maxItems: 2
> +  mbox-names:
> +    maxItems: 2
> +
> +examples:
> +  - |
> +     reserved-memory {
> +          #address-cells = <1>;
> +          #size-cells = <1>;
> +          ranges;
> +          elf_load: rproc@3ed000000 {
> +               no-map;
> +               reg = <0x3ed00000 0x40000>;
> +          };
> +     };
> +     rpu {
> +          compatible = "xlnx,zynqmp-r5-remoteproc-1.0";
> +          #address-cells = <1>;
> +          #size-cells = <1>;
> +          ranges;
> +          lockstep-mode = <0>;
> +          r5_0 {
> +               ranges;
> +               #address-cells = <1>;
> +               #size-cells = <1>;
> +               memory-region = <&elf_load>;
> +               meta-memory-regions = <0x40 0x41>;
> +               pnode-id = <0x7>;

I can see you are expecting a link from this node to the tcm nodes in
the driver, but I can't find such a link in this example.


> +          };
> +     };
> +
> +     /*
> +      * Below nodes are required if using TCM to load R5 firmware
> +      * if not, then either do not provide nodes are label as disabled in
> +      * status property
> +      */
> +     tcm_0a@ffe00000 {
> +         reg = <0xffe00000 0x10000>;
> +         pnode-id = <0xf>;
> +         no-map;
> +         status = "okay";
> +         phandle = <0x40>;
> +         compatible = "xlnx,tcm";
> +     };
> +     tcm_1a@ffe20000 {
> +         reg = <0xffe20000 0x10000>;
> +         pnode-id = <0x10>;
> +         no-map;
> +         status = "okay";
> +         compatible = "xlnx,tcm";
> +         phandle = <0x41>;
> +     };
> +
> +     /*
> +      * Below nodes are required for IPC, as Xilinx Kernel
> +      * can potentially have other applications that use CMA
> +      * and conflict from hardware design. With that in mind,
> +      * explicitly state the address spaces for the IPC remoteproc
> +      * mechanisms.
> +      *
> +      * If IPC not required and only elf-loading then these are not needed.
> +      */
> +     rpu0vdev0vring0: rpu0vdev0vring0@3ed40000 {
> +         no-map;
> +         reg = <0x3ed40000 0x4000>;
> +     };
> +     rpu0vdev0vring1: rpu0vdev0vring1@3ed44000 {
> +         no-map;
> +         reg = <0x3ed44000 0x4000>;
> +     };
> +     rpu0vdev0buffer: rpu0vdev0buffer@3ed48000 {
> +         no-map;
> +         reg = <0x3ed48000 0x100000>;
> +     };

Shouldn't they be under reserved-memory?
