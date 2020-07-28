Return-Path: <SRS0=jZ1s=BH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AF22C433E3
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 02:52:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 333C320714
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 02:52:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726967AbgG1Cw0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jul 2020 22:52:26 -0400
Received: from mga02.intel.com ([134.134.136.20]:11682 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726410AbgG1Cw0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 22:52:26 -0400
IronPort-SDR: QHtNdDhkiT8I8/zp93dQ73ZxQQsZFsBX6cLlpJXK3FD4a7tbAu+0jmdi1WrQFvm6d4c5FcdEsz
 7tbJ0ePaS13w==
X-IronPort-AV: E=McAfee;i="6000,8403,9695"; a="139176066"
X-IronPort-AV: E=Sophos;i="5.75,404,1589266800"; 
   d="scan'208";a="139176066"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jul 2020 19:52:25 -0700
IronPort-SDR: kVT+Jj3jiiE4C4mJPZ0JmNmCvf/xJemv7VYmNj69HcWNdoOTZD189vW7bc5chdG5f8kBb50yzC
 1KT3rDSrzLqQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,404,1589266800"; 
   d="scan'208";a="464289859"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga005.jf.intel.com with ESMTP; 27 Jul 2020 19:52:25 -0700
Received: from [10.226.38.26] (unknown [10.226.38.26])
        by linux.intel.com (Postfix) with ESMTP id 79832580295;
        Mon, 27 Jul 2020 19:52:09 -0700 (PDT)
Reply-To: vadivel.muruganx.ramuthevar@linux.intel.com
Subject: Re: [PATCH v7 0/2] phy: Add USB PHY support on Intel LGM SoC
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andriy Shevchenko <andriy.shevchenko@intel.com>,
        Felipe Balbi <balbi@kernel.org>, cheol.yong.kim@intel.com,
        qi-ming.wu@intel.com, yin1.li@intel.com, vkoul@kernel.org
References: <20200727100336.32153-1-vadivel.muruganx.ramuthevar@linux.intel.com>
 <CAHp75VeO86j-onVJX-M7YmOZeQuX=Jx58jnT3dLkwCsBom1aTQ@mail.gmail.com>
From:   "Ramuthevar, Vadivel MuruganX" 
        <vadivel.muruganx.ramuthevar@linux.intel.com>
Message-ID: <4354752f-3e36-fbf1-a863-495aff80dacb@linux.intel.com>
Date:   Tue, 28 Jul 2020 10:52:05 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAHp75VeO86j-onVJX-M7YmOZeQuX=Jx58jnT3dLkwCsBom1aTQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andy,

On 27/7/2020 7:09 pm, Andy Shevchenko wrote:
> On Mon, Jul 27, 2020 at 1:08 PM Ramuthevar,Vadivel MuruganX
> <vadivel.muruganx.ramuthevar@linux.intel.com> wrote:
>>
>> The USB PHY provides the optimized for low power dissipation while active, idle, or on standby.
>> Requires minimal external components, a single resistor, for best operation.
>> Supports 10/5-Gbps high-speed data transmission rates through 3-m USB 3.x cable
>> ---
> 
>> v7:
>>    - No Change
> 
> I guess it's not the correct changelog entry.
> You moved file to another subsystem, didn't you?

Already added in v5 changelog, kindly please see below , Thanks!

> 
>> v6:
>>    - No Change
>> v5:
>>    - As per Felipe and Greg's suggestion usb phy driver reviewed patches
>>      changed the folder from drivers/usb/phy to drivers/phy
>>    - Reviewed-By tag added in commit message
>> v4:
>>    - Andy's review comments addressed
>>    - drop the excess error debug prints
>>    - error check optimized
>>    - merge the split line to one line
>> v3:
>>    - Andy's review comments update
>>    - hardcode return value changed to actual return value from the callee
>>    - add error check is fixed according to the above
>>    - correct the assignment in redundant
>>    - combine the split line into one line
>> v2:
>>    - Address Phillip's review comments
>>    - replace devm_reset_control_get() by devm_reset_control_get_exclusive()
>>    - re-design the assert and deassert fucntion calls as per review comments
>>    - address kbuild bot warnings
>>    - add the comments
>> v1:
>>    - initial version
>>
>> ---
>> dt-bindings: usb: Add USB PHY support for Intel LGM SoC
>> v7:
>>    - Fixed the bot issue: usb-phy@e7e00000: '#phy-cells' is a required property
>> v6:
>>    - Fixed the bot issue.
>>    - replace node-name by usb-phy@ in example
>> v5:
>>    - Reviewed-By tag added
>> v4:
>>    - No Change
>> v3:
>>    - No Change
>> v2:
>>    - No Change
>> v1:
>>    - initial version
>>
>>
>> Ramuthevar Vadivel Murugan (2):
>>    dt-bindings: phy: Add USB PHY support for Intel LGM SoC
>>    phy: Add USB3 PHY support for Intel LGM SoC
>>
>>   .../devicetree/bindings/phy/intel,lgm-usb-phy.yaml |  58 +++++
>>   drivers/phy/Kconfig                                |  11 +
>>   drivers/phy/Makefile                               |   1 +
>>   drivers/phy/phy-lgm-usb.c                          | 278 +++++++++++++++++++++
>>   4 files changed, 348 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/phy/intel,lgm-usb-phy.yaml
>>   create mode 100644 drivers/phy/phy-lgm-usb.c
>>
>> --
>> 2.11.0
>>
> 
> 
