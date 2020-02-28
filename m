Return-Path: <SRS0=RI2K=4Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEE9FC3F2CE
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 03:09:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3C872469D
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 03:09:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730654AbgB1DJH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 22:09:07 -0500
Received: from mga04.intel.com ([192.55.52.120]:52592 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730569AbgB1DJH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 22:09:07 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 27 Feb 2020 19:09:06 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,493,1574150400"; 
   d="scan'208";a="232410956"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga008.fm.intel.com with ESMTP; 27 Feb 2020 19:09:06 -0800
Received: from [10.226.38.23] (unknown [10.226.38.23])
        by linux.intel.com (Postfix) with ESMTP id 9638158045A;
        Thu, 27 Feb 2020 19:09:00 -0800 (PST)
Subject: Re: [PATCH v11 1/2] dt-bindings: spi: Add schema for Cadence QSPI
 Controller driver
To:     Rob Herring <robh@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        broonie@kernel.org, vigneshr@ti.com, robh+dt@kernel.org,
        devicetree@vger.kernel.org, simon.k.r.goldschmidt@gmail.com,
        dinguyen@kernel.org, tien.fong.chee@intel.com, marex@denx.de,
        mark.rutland@arm.com, linux-mtd@lists.infradead.org,
        dwmw2@infradead.org, richard@nod.at, computersforpeace@gmail.com,
        boris.brezillon@free-electrons.com, cyrille.pitchen@atmel.com,
        david.oberhollenzer@sigma-star.at, miquel.raynal@bootlin.com,
        tudor.ambarus@gmail.com, cheol.yong.kim@intel.com,
        qi-ming.wu@intel.com
References: <20200227062708.21544-1-vadivel.muruganx.ramuthevar@linux.intel.com>
 <20200227062708.21544-2-vadivel.muruganx.ramuthevar@linux.intel.com>
 <20200227170748.GA19661@bogus>
From:   "Ramuthevar, Vadivel MuruganX" 
        <vadivel.muruganx.ramuthevar@linux.intel.com>
Message-ID: <3ec7c41f-f074-3b0a-25c6-1ac04f524bbb@linux.intel.com>
Date:   Fri, 28 Feb 2020 11:08:59 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
MIME-Version: 1.0
In-Reply-To: <20200227170748.GA19661@bogus>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

On 28/2/2020 1:07 AM, Rob Herring wrote:
> On Thu, 27 Feb 2020 14:27:07 +0800, "Ramuthevar,Vadivel MuruganX" wrote:
>> From: Ramuthevar Vadivel Murugan <vadivel.muruganx.ramuthevar@linux.intel.com>
>>
>> Add dt-bindings documentation for Cadence-QSPI controller to support
>> spi based flash memories.
>>
>> Signed-off-by: Ramuthevar Vadivel Murugan <vadivel.muruganx.ramuthevar@linux.intel.com>
>> ---
>>   .../devicetree/bindings/mtd/cadence-quadspi.txt    |  67 ----------
>>   .../devicetree/bindings/spi/cdns,qspi-nor.yaml     | 142 +++++++++++++++++++++
>>   2 files changed, 142 insertions(+), 67 deletions(-)
>>   delete mode 100644 Documentation/devicetree/bindings/mtd/cadence-quadspi.txt
>>   create mode 100644 Documentation/devicetree/bindings/spi/cdns,qspi-nor.yaml
>>
> My bot found errors running 'make dt_binding_check' on your patch:

Thanks!,  Sorry for the trouble , next time will run and fix it up.

Regards
Vadivel
>
> warning: no schema found in file: Documentation/devicetree/bindings/spi/cdns,qspi-nor.yaml
> /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/spi/cdns,qspi-nor.yaml: ignoring, error in schema: patternProperties: cdns,read-delay
> Documentation/devicetree/bindings/display/simple-framebuffer.example.dts:21.16-37.11: Warning (chosen_node_is_root): /example-0/chosen: chosen node must be at root node
> /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/spi/cdns,qspi-nor.yaml: patternProperties:cdns,read-delay: {'description': 'Delay in 4 microseconds, read capture logic, in clock cycles.'} is not valid under any of the given schemas (Possible causes of the failure):
> 	/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/spi/cdns,qspi-nor.yaml: patternProperties:cdns,read-delay: 'not' is a required property
>
> Documentation/devicetree/bindings/Makefile:12: recipe for target 'Documentation/devicetree/bindings/spi/cdns,qspi-nor.example.dts' failed
> make[1]: *** [Documentation/devicetree/bindings/spi/cdns,qspi-nor.example.dts] Error 1
> Makefile:1263: recipe for target 'dt_binding_check' failed
> make: *** [dt_binding_check] Error 2
>
> See https://patchwork.ozlabs.org/patch/1245559
> Please check and re-submit.
