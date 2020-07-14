Return-Path: <SRS0=dAmO=AZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82E97C433E8
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 03:52:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6602721927
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 03:52:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726859AbgGNDwj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jul 2020 23:52:39 -0400
Received: from mga04.intel.com ([192.55.52.120]:33887 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726542AbgGNDwi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jul 2020 23:52:38 -0400
IronPort-SDR: LFHS7HaIzUNVB09RD+AQp33K2Jvs+lrO6DHG5Kjh74AqNijQp49OHk86K8rFrcoKl/h6moQljJ
 wcnQJJvP3UFw==
X-IronPort-AV: E=McAfee;i="6000,8403,9681"; a="146269589"
X-IronPort-AV: E=Sophos;i="5.75,350,1589266800"; 
   d="scan'208";a="146269589"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2020 20:52:38 -0700
IronPort-SDR: huwuz6f1QU/7KnXgcpT+u1B+DoeMeKUYpakVrhoTU582qPP50vBE99ZEoXJsT88NMrfMkjpyVZ
 1kbKhglKXSyw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,350,1589266800"; 
   d="scan'208";a="281623310"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga003.jf.intel.com with ESMTP; 13 Jul 2020 20:52:36 -0700
Received: from [10.255.133.45] (vramuthx-MOBL1.gar.corp.intel.com [10.255.133.45])
        by linux.intel.com (Postfix) with ESMTP id 3A017580810;
        Mon, 13 Jul 2020 20:52:24 -0700 (PDT)
Reply-To: vadivel.muruganx.ramuthevar@linux.intel.com
Subject: Re: [PATCH v5 1/2] dt-bindings: phy: Add USB PHY support for Intel
 LGM SoC
To:     Rob Herring <robh@kernel.org>
Cc:     robh+dt@kernel.org, balbi@kernel.org, cheol.yong.kim@intel.com,
        gregkh@linuxfoundation.org, devicetree@vger.kernel.org,
        andriy.shevchenko@intel.com, qi-ming.wu@intel.com,
        p.zabel@pengutronix.de, yin1.li@intel.com, kishon@ti.com,
        linux-kernel@vger.kernel.org
References: <20200713085453.7353-1-vadivel.muruganx.ramuthevar@linux.intel.com>
 <20200713085453.7353-2-vadivel.muruganx.ramuthevar@linux.intel.com>
 <20200713150713.GA184301@bogus>
From:   "Ramuthevar, Vadivel MuruganX" 
        <vadivel.muruganx.ramuthevar@linux.intel.com>
Message-ID: <9941c14f-50b8-5824-cb65-428aa32b746c@linux.intel.com>
Date:   Tue, 14 Jul 2020 11:52:15 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200713150713.GA184301@bogus>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

On 13/7/2020 11:07 pm, Rob Herring wrote:
> On Mon, 13 Jul 2020 16:54:52 +0800, Ramuthevar,Vadivel MuruganX wrote:
>> From: Ramuthevar Vadivel Murugan <vadivel.muruganx.ramuthevar@linux.intel.com>
>>
>> Add the dt-schema to support USB PHY on Intel LGM SoC
>>
>> Signed-off-by: Ramuthevar Vadivel Murugan <vadivel.muruganx.ramuthevar@linux.intel.com>
>> Reviewed-by: Rob Herring <robh@kernel.org>
>> ---
>>   .../devicetree/bindings/phy/intel,lgm-usb-phy.yaml | 53 ++++++++++++++++++++++
>>   1 file changed, 53 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/phy/intel,lgm-usb-phy.yaml
>>
> 
> 
> My bot found errors running 'make dt_binding_check' on your patch:
> 
> Documentation/devicetree/bindings/phy/intel,lgm-usb-phy.yaml: $id: relative path/filename doesn't match actual path or filename
> 	expected: http://devicetree.org/schemas/phy/intel,lgm-usb-phy.yaml#
> 
> 
> See https://patchwork.ozlabs.org/patch/1327785
> 
> If you already ran 'make dt_binding_check' and didn't see the above
> error(s), then make sure dt-schema is up to date:
> 
> pip3 install git+https://github.com/devicetree-org/dt-schema.git@master --upgrade
> 
> Please check and re-submit.
Sure, will check and update, Thanks!

Regards
Vadivel
> 
