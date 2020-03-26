Return-Path: <SRS0=aGSP=5L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A131C43331
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 18:09:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 70B3C20722
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 18:09:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="oxTllWop"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728445AbgCZSJx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Mar 2020 14:09:53 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:40438 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726267AbgCZSJx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Mar 2020 14:09:53 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 02QI9fkO005199;
        Thu, 26 Mar 2020 13:09:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1585246181;
        bh=p3uCdd3lNgStEmVbRoGU3tYob5tHrXuUe3dGhywOrXc=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=oxTllWopocVS+boJ3JwFLjfj7+B7KNkWnWw8YgaE1/SQv0c0QnjdnCkH705FazV7R
         TzUrv+kqFB8IHVRP6nI68IeE5MeJJd5ArtvJbBzzK862KXr7G1Wgeo25yevhkuoeQP
         UXyQy2H94/jn8WXIcWpg0S8Jz07hnbU0N1hAX+HQ=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 02QI9fj9094474
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 26 Mar 2020 13:09:41 -0500
Received: from DLEE102.ent.ti.com (157.170.170.32) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Thu, 26
 Mar 2020 13:09:41 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Thu, 26 Mar 2020 13:09:41 -0500
Received: from [10.250.86.212] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 02QI9eb5072144;
        Thu, 26 Mar 2020 13:09:41 -0500
Subject: Re: [PATCH 3/7] dt-bindings: remoteproc: Add bindings for R5F
 subsystem on TI K3 SoCs
To:     Rob Herring <robh@kernel.org>
CC:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Lokesh Vutla <lokeshvutla@ti.com>,
        <linux-remoteproc@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <20200324201819.23095-1-s-anna@ti.com>
 <20200324201819.23095-4-s-anna@ti.com> <20200326162802.GA32328@bogus>
From:   Suman Anna <s-anna@ti.com>
Message-ID: <90bae05e-dd47-5b71-07a7-5c3efd929143@ti.com>
Date:   Thu, 26 Mar 2020 13:09:40 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20200326162802.GA32328@bogus>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

On 3/26/20 11:28 AM, Rob Herring wrote:
> On Tue, 24 Mar 2020 15:18:15 -0500, Suman Anna wrote:
>> The Texas Instruments K3 family of SoCs have one or more dual-core
>> Arm Cortex R5F processor subsystems/clusters (R5FSS). The clusters
>> can be split between multiple voltage domains as well. Add the device
>> tree bindings document for these R5F subsystem devices. These R5F
>> processors do not have an MMU, and so require fixed memory carveout
>> regions matching the firmware image addresses. The nodes require more
>> than one memory region, with the first memory region used for DMA
>> allocations at runtime. The remaining memory regions are reserved
>> and are used for the loading and running of the R5F remote processors.
>> The R5F processors can also optionally use any internal on-chip SRAM
>> memories either for executing code or using it as fast-access data.
>>
>> The added example illustrates the DT nodes for the single R5FSS device
>> present on K3 AM65x family of SoCs.
>>
>> Signed-off-by: Suman Anna <s-anna@ti.com>
>> ---
>> Hi Rob,
>>
>> The dt_bindings_check seems to throw couple of warnings around the
>> usage of ranges because the tooling is adding the #address-cells
>> and #size-cells of 1 by default, whereas our actual code uses 2.
>> No issues are found with dtbs_check.
>>
>> regards
>> Suman
>>
>>  .../bindings/remoteproc/ti,k3-r5f-rproc.yaml  | 338 ++++++++++++++++++
>>  1 file changed, 338 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/remoteproc/ti,k3-r5f-rproc.yaml
>>
> 
> My bot found errors running 'make dt_binding_check' on your patch:
> 
> Documentation/devicetree/bindings/remoteproc/ti,k3-r5f-rproc.example.dts:23.13-20: Warning (ranges_format): /example-0/reserved-memory:ranges: empty "ranges" property but its #address-cells (2) differs from /example-0 (1)
> Documentation/devicetree/bindings/remoteproc/ti,k3-r5f-rproc.example.dts:23.13-20: Warning (ranges_format): /example-0/reserved-memory:ranges: empty "ranges" property but its #size-cells (2) differs from /example-0 (1)
> Documentation/devicetree/bindings/remoteproc/ti,k3-r5f-rproc.example.dts:54.13-56.72: Warning (ranges_format): /example-0/interconnect@100000:ranges: "ranges" property has invalid length (72 bytes) (parent #address-cells == 1, child #address-cells == 2, #size-cells == 2)

I only saw these, because the generated example dts is using cell values
of 1. I tried adding them using 2 in my example, but then it complains
about duplicate properties. I do not know how to fix these though. Same
with the K3 DSP bindings patches as well.

> /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/remoteproc/ti,k3-r5f-rproc.example.dt.yaml: interconnect@100000: $nodename:0: 'interconnect@100000' does not match '^(bus|soc|axi|ahb|apb)(@[0-9a-f]+)?$'
> /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/remoteproc/ti,k3-r5f-rproc.example.dt.yaml: interconnect@28380000: $nodename:0: 'interconnect@28380000' does not match '^(bus|soc|axi|ahb|apb)(@[0-9a-f]+)?$'
> /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/remoteproc/ti,k3-r5f-rproc.example.dt.yaml: mcu-ram@41c00000: 'r5f-sram@0' does not match any of the regexes: '^([a-z]*-)?sram(-section)?@[a-f0-9]+$', 'pinctrl-[0-9]+'
> /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/remoteproc/ti,k3-r5f-rproc.example.dt.yaml: mcu-ram@41c00000: $nodename:0: 'mcu-ram@41c00000' does not match '^sram(@.*)?'

These node names are already upstream. Do I just update the example or
the upstream dts also needs fixing?

> 
> See https://patchwork.ozlabs.org/patch/1260966
> 
> If you already ran 'make dt_binding_check' and didn't see the above
> error(s), then make sure dt-schema is up to date:
> 
> pip3 install git+https://github.com/devicetree-org/dt-schema.git@master --upgrade

Thanks, will upgrade my dt-schema.

regards
Suman
