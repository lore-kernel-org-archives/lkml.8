Return-Path: <SRS0=jpuI=BA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18A39C433E5
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 16:40:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ECC4C2064C
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 16:40:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="dQ0GU478"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729955AbgGUQki (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jul 2020 12:40:38 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:47476 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728127AbgGUQkh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jul 2020 12:40:37 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 06LGeY1G007122;
        Tue, 21 Jul 2020 11:40:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1595349634;
        bh=/eWIZiT9XrKPExqrtdoAjWkZM5HC4IrH8rHoLYS97yU=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=dQ0GU478dbIU8wptojg4ymDv20hcvdwhowYka4hGCclz/Zj5XUfpVC7KPJ1lPxg45
         XGmfIaaXbQ+tqefdoH0Kigh/mbWsiUzl93LRdZvy4BPKpAGqRC4R6tQ3sJpYcS6jPU
         bIYNBAuOh9qG534n0KoLUtewBbyoJE/C/6Ipl9zs=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTP id 06LGeXXS047591;
        Tue, 21 Jul 2020 11:40:33 -0500
Received: from DFLE110.ent.ti.com (10.64.6.31) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Tue, 21
 Jul 2020 11:40:33 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Tue, 21 Jul 2020 11:40:33 -0500
Received: from [10.250.34.248] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 06LGeX4R041637;
        Tue, 21 Jul 2020 11:40:33 -0500
Subject: Re: [PATCH v4 3/6] dt-bindings: remoteproc: Add common TI SCI rproc
 bindings
To:     Rob Herring <robh+dt@kernel.org>, Lokesh Vutla <lokeshvutla@ti.com>
CC:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        "open list:REMOTE PROCESSOR (REMOTEPROC) SUBSYSTEM" 
        <linux-remoteproc@vger.kernel.org>, <devicetree@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20200717234800.9423-1-s-anna@ti.com>
 <20200717234800.9423-4-s-anna@ti.com>
 <CAL_JsqLnPQNZ7KhqfPwiMCJESYrD9_UN2gwc_hj9=WOJM8NQQw@mail.gmail.com>
From:   Suman Anna <s-anna@ti.com>
Message-ID: <647642d5-5021-363f-c9c9-3714a826436c@ti.com>
Date:   Tue, 21 Jul 2020 11:40:33 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAL_JsqLnPQNZ7KhqfPwiMCJESYrD9_UN2gwc_hj9=WOJM8NQQw@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

On 7/21/20 10:53 AM, Rob Herring wrote:
> On Fri, Jul 17, 2020 at 5:48 PM Suman Anna <s-anna@ti.com> wrote:
>>
>> Add a bindings document that lists the common TI SCI properties
>> used by the K3 R5F and DSP remoteproc devices.
>>
>> Signed-off-by: Suman Anna <s-anna@ti.com>
>> ---
>> v4: Addressed both of Rob's review comments on ti,sci-proc-ids property
>> v3: https://patchwork.kernel.org/patch/11602317/
>>
>>   .../bindings/remoteproc/ti,k3-sci-proc.yaml   | 48 +++++++++++++++++++
>>   1 file changed, 48 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/remoteproc/ti,k3-sci-proc.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/remoteproc/ti,k3-sci-proc.yaml b/Documentation/devicetree/bindings/remoteproc/ti,k3-sci-proc.yaml
>> new file mode 100644
>> index 000000000000..0dca2ffdbc48
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/remoteproc/ti,k3-sci-proc.yaml
>> @@ -0,0 +1,48 @@
>> +# SPDX-License-Identifier: (GPL-2.0-only or BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/remoteproc/ti,k3-sci-proc.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Common TI K3 remote processor device bindings
>> +
>> +maintainers:
>> +  - Suman Anna <s-anna@ti.com>
>> +
>> +description: |
>> +  The TI K3 family of SoCs usually have one or more remote processor sub-systems
>> +  like the dual-core R5F sub-system or a C66x or C71x DSP processor subsystem.
>> +  The device management of these remote processors is managed by a dedicated
>> +  System Processor, and the communication with that processor is managed through
>> +  the TI-SCI protocol.
>> +
>> +  Each remote processor device node should define a common set of properties
>> +  that allows the System Processor firmware to perform the device management
>> +  such as powering the IPs, asserting/deasserting the resets for each of these
>> +  processors.
>> +
>> +properties:
>> +  ti,sci:
>> +    $ref: /schemas/types.yaml#/definitions/phandle
>> +    description:
>> +      Should be a phandle to the TI-SCI System Controller node
>> +
>> +  ti,sci-dev-id:
>> +    $ref: /schemas/types.yaml#/definitions/uint32
>> +    description: |
>> +      Should contain the TI-SCI device id corresponding to the remote processor
>> +      core. Please refer to the corresponding System Controller documentation
>> +      for valid values.
> 
> These also apply on Lokesh's series converting ti,sci-int[ra]
> bindings. Please rework to use for both.

OK.

> 
>> +
>> +  ti,sci-proc-ids:
>> +    description: Should contain a single tuple of <proc_id host_id>.
>> +    $ref: /schemas/types.yaml#/definitions/uint32-array
>> +    items:
>> +      - description: TI-SCI processor id for the remote processor device
>> +      - description: TI-SCI host id to which processor control ownership
>> +                     should be transferred to

This property is not required for the ti,sci-int[ra].

I can plan to move this to a common location like 
Documentation/devicetree/bindings/arm/keystone/ and let the individual 
bindings define the required properties. Does that sound ok to you?

regards
Suman

>> +
>> +required:
>> +  - ti,sci
>> +  - ti,sci-dev-id
>> +  - ti,sci-proc-ids
>> --
>> 2.26.0
>>

