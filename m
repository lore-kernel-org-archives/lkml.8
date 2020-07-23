Return-Path: <SRS0=Rqeb=BC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBD09C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 15:46:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CB5A7206D8
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 15:46:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729554AbgGWPqs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jul 2020 11:46:48 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:49972 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727108AbgGWPqr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jul 2020 11:46:47 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id A53852985CE
Subject: Re: [PATCH] dt-bindings: power: rockchip: Convert to json-schema
To:     Rob Herring <robh@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Collabora Kernel ML <kernel@collabora.com>,
        dianders@chromium.org, heiko@sntech.de,
        Caesar Wang <wxt@rock-chips.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org
References: <20200715170216.2875868-1-enric.balletbo@collabora.com>
 <20200721032536.GA3476792@bogus>
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
Message-ID: <9fa390ef-068f-82b0-2317-64f3ffc4864f@collabora.com>
Date:   Thu, 23 Jul 2020 17:46:41 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200721032536.GA3476792@bogus>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

Thank you for your review.

On 21/7/20 5:25, Rob Herring wrote:
> On Wed, Jul 15, 2020 at 07:02:16PM +0200, Enric Balletbo i Serra wrote:
>> Convert the soc/rockchip/power_domain.txt binding document to json-schema
>> and move to the power bindings directory.
>>
>> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
>> ---
>>
>>  .../power/rockchip,power-controller.yaml      | 154 ++++++++++++++++++
>>  .../bindings/soc/rockchip/power_domain.txt    | 136 ----------------
>>  2 files changed, 154 insertions(+), 136 deletions(-)
>>  create mode 100644 Documentation/devicetree/bindings/power/rockchip,power-controller.yaml
>>  delete mode 100644 Documentation/devicetree/bindings/soc/rockchip/power_domain.txt
>>
>> diff --git a/Documentation/devicetree/bindings/power/rockchip,power-controller.yaml b/Documentation/devicetree/bindings/power/rockchip,power-controller.yaml
>> new file mode 100644
>> index 000000000000..af50cf2b3e63
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/power/rockchip,power-controller.yaml
>> @@ -0,0 +1,154 @@
>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/power/rockchip,power-controller.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Rockchip Power Domains
>> +
>> +maintainers:
>> +  - Caesar Wang <wxt@rock-chips.com>
>> +  - Heiko Stuebner <heiko@sntech.de>
>> +
>> +description: |
>> +  Rockchip processors include support for multiple power domains which can be
>> +  powered up/down by software based on different application scenes to save power.
>> +
>> +  Power domains contained within power-controller node are generic power domain
>> +  providers documented in Documentation/devicetree/bindings/power/power-domain.yaml.
>> +
>> +  IP cores belonging to a power domain should contain a 'power-domains'
>> +  property that is a phandle for the power domain node representing the domain.
>> +
>> +properties:
>> +  power-controller:
>> +    type: object
>> +    description: List of power domains provided by this controller.
>> +
>> +    properties:
>> +      compatible:
>> +        enum:
>> +          - rockchip,px30-power-controller
>> +          - rockchip,rk3036-power-controller
>> +          - rockchip,rk3066-power-controller
>> +          - rockchip,rk3128-power-controller
>> +          - rockchip,rk3188-power-controller
>> +          - rockchip,rk3228-power-controller
>> +          - rockchip,rk3288-power-controller
>> +          - rockchip,rk3328-power-controller
>> +          - rockchip,rk3366-power-controller
>> +          - rockchip,rk3368-power-controller
>> +          - rockchip,rk3399-power-controller
>> +
>> +      reg:
>> +        description: |
>> +          Power domain index. Valid values are defined in:
>> +          "include/dt-bindings/power/px30-power.h" - for PX30 type power domain.
>> +          "include/dt-bindings/power/rk3036-power.h" - for RK3036 type power domain.
>> +          "include/dt-bindings/power/rk3066-power.h" - for RK3066 type power domain.
>> +          "include/dt-bindings/power/rk3128-power.h" - for RK3128 type power domain.
>> +          "include/dt-bindings/power/rk3188-power.h" - for RK3188 type power domain.
>> +          "include/dt-bindings/power/rk3228-power.h" - for RK3228 type power domain.
>> +          "include/dt-bindings/power/rk3288-power.h" - for RK3288 type power domain.
>> +          "include/dt-bindings/power/rk3328-power.h" - for RK3328 type power domain.
>> +          "include/dt-bindings/power/rk3366-power.h" - for RK3366 type power domain.
>> +          "include/dt-bindings/power/rk3368-power.h" - for RK3368 type power domain.
>> +          "include/dt-bindings/power/rk3399-power.h" - for RK3399 type power domain.
>> +        maxItems: 1
>> +
>> +      clocks:
>> +        description: |
>> +          A number of phandles to clocks that need to be enabled while power domain
>> +          switches state.
>> +      pm_qos:
>> +        description: |
>> +          A number of phandles to qos blocks which need to be saved and restored
>> +          while power domain switches state.
>> +
>> +      power-supply: true
>> +
>> +    required:
>> +      - compatible
>> +      - reg
> 
> You need:
> 
>        additionalProperties: false
> 
> (with indentation). Then you will get a bunch of errors as you are 
> missing a level of nodes. 

Hmm, for some reason adding "additionalProperties: false" with indentation,
doesn't give me any error. I'll double check my environment but I might be
something silly.

> The 'power-controller' node doesn't have 
> 'reg' for example. You'll need to use 'patternProperties' with '^pd_'.
> 
> And to describe the nested power domains, you have to describe yet 
> another level. You can do a $ref with something like:
> 
> $ref: '#/properties/power-controller/patternProperties/^pd_'
> 
> That creates a circular reference though and I'm not sure what will 
> happen. :)
> 
>> +
>> +additionalProperties: false
>> +
>> +examples:
>> +  - |
>> +    #include <dt-bindings/clock/rk3399-cru.h>
>> +    #include <dt-bindings/power/rk3399-power.h>
>> +
>> +    soc {
>> +        #address-cells = <2>;
>> +        #size-cells = <2>;
>> +
>> +        qos_iep: qos@ffa98000 {
>> +            compatible = "syscon";
> 
> This will generate a warning now. 'syscon' should not be used alone.
> 

What to do in such cases? I mean the rk3399.dtsi device-tree is like this, so
wrong, should I create a new compatible?

Thanks,
Enric

>> +            reg = <0x0 0xffa98000 0x0 0x20>;
>> +        };
>> +
>> +        qos_rga_r: qos@ffab0000 {
>> +            compatible = "syscon";
>> +            reg = <0x0 0xffab0000 0x0 0x20>;
>> +        };
>> +
>> +        qos_rga_w: qos@ffab0080 {
>> +            compatible = "syscon";
>> +            reg = <0x0 0xffab0080 0x0 0x20>;
>> +        };
>> +
>> +        qos_video_m0: qos@ffab8000 {
>> +            compatible = "syscon";
>> +            reg = <0x0 0xffab8000 0x0 0x20>;
>> +        };
>> +
>> +        qos_video_m1_r: qos@ffac0000 {
>> +            compatible = "syscon";
>> +            reg = <0x0 0xffac0000 0x0 0x20>;
>> +        };
>> +
>> +        qos_video_m1_w: qos@ffac0080 {
>> +            compatible = "syscon";
>> +            reg = <0x0 0xffac0080 0x0 0x20>;
>> +        };
>> +
>> +        power-management@ff310000 {
>> +            compatible = "rockchip,rk3399-pmu", "syscon", "simple-mfd";
>> +            reg = <0x0 0xff310000 0x0 0x1000>;
>> +
>> +            power-controller {
>> +                compatible = "rockchip,rk3399-power-controller";
>> +                #power-domain-cells = <1>;
>> +                #address-cells = <1>;
>> +                #size-cells = <0>;
>> +
>> +                /* These power domains are grouped by VD_CENTER */
>> +                pd_iep@RK3399_PD_IEP {
>> +                    reg = <RK3399_PD_IEP>;
>> +                    clocks = <&cru ACLK_IEP>,
>> +                             <&cru HCLK_IEP>;
>> +                    pm_qos = <&qos_iep>;
>> +                };
>> +                pd_rga@RK3399_PD_RGA {
>> +                    reg = <RK3399_PD_RGA>;
>> +                    clocks = <&cru ACLK_RGA>,
>> +                             <&cru HCLK_RGA>;
>> +                    pm_qos = <&qos_rga_r>,
>> +                             <&qos_rga_w>;
>> +                };
>> +                pd_vcodec@RK3399_PD_VCODEC {
>> +                    reg = <RK3399_PD_VCODEC>;
>> +                    clocks = <&cru ACLK_VCODEC>,
>> +                             <&cru HCLK_VCODEC>;
>> +                    pm_qos = <&qos_video_m0>;
>> +                };
>> +                pd_vdu@RK3399_PD_VDU {
>> +                    reg = <RK3399_PD_VDU>;
>> +                    clocks = <&cru ACLK_VDU>,
>> +                             <&cru HCLK_VDU>;
>> +                    pm_qos = <&qos_video_m1_r>,
>> +                             <&qos_video_m1_w>;
>> +                };
>> +            };
>> +        };
>> +    };
> 
