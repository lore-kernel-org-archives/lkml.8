Return-Path: <SRS0=kup7=A2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 722BFC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 12:06:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 59547206F5
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 12:06:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730713AbgGOMGp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jul 2020 08:06:45 -0400
Received: from mga11.intel.com ([192.55.52.93]:14845 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726968AbgGOMGp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jul 2020 08:06:45 -0400
IronPort-SDR: Vx8j0hTTgBKzg4Wad8mCzqjiC1VZXyuxmxthphyNDrOfZeLBDMmJxFwc6sEuDAszOnBbhyzivw
 xxKhlhWD3I4w==
X-IronPort-AV: E=McAfee;i="6000,8403,9682"; a="147135166"
X-IronPort-AV: E=Sophos;i="5.75,355,1589266800"; 
   d="scan'208";a="147135166"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2020 05:06:44 -0700
IronPort-SDR: faeyB3IMe/BtLdb+j4n6CkkThfOUBGwBiFQkcSGjZwB4KQSP4ZjVogTspzuKABs1ytBQlkHl0N
 VRvkbieiCiCA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,355,1589266800"; 
   d="scan'208";a="316682650"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga008.jf.intel.com with ESMTP; 15 Jul 2020 05:06:44 -0700
Received: from [10.255.187.149] (vramuthx-MOBL1.gar.corp.intel.com [10.255.187.149])
        by linux.intel.com (Postfix) with ESMTP id C453258081E;
        Wed, 15 Jul 2020 05:06:41 -0700 (PDT)
Reply-To: vadivel.muruganx.ramuthevar@linux.intel.com
Subject: Re: [PATCH v6 1/2] dt-bindings: phy: Add USB PHY support for Intel
 LGM SoC
To:     Rob Herring <robh@kernel.org>
Cc:     cheol.yong.kim@intel.com, qi-ming.wu@intel.com, yin1.li@intel.com,
        robh+dt@kernel.org, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org, kishon@ti.com,
        andriy.shevchenko@intel.com, devicetree@vger.kernel.org,
        p.zabel@pengutronix.de, balbi@kernel.org
References: <20200714042621.25850-1-vadivel.muruganx.ramuthevar@linux.intel.com>
 <20200714042621.25850-2-vadivel.muruganx.ramuthevar@linux.intel.com>
 <20200714180152.GA2633416@bogus>
From:   "Ramuthevar, Vadivel MuruganX" 
        <vadivel.muruganx.ramuthevar@linux.intel.com>
Message-ID: <8576d5b2-2269-c7e4-5386-85406916ef74@linux.intel.com>
Date:   Wed, 15 Jul 2020 20:06:40 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200714180152.GA2633416@bogus>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

On 15/7/2020 2:01 am, Rob Herring wrote:
> On Tue, 14 Jul 2020 12:26:20 +0800, Ramuthevar,Vadivel MuruganX wrote:
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
> /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/phy/intel,lgm-usb-phy.example.dt.yaml: usb-phy@e7e00000: '#phy-cells' is a required property
> 
> 
> See https://patchwork.ozlabs.org/patch/1328612
> 
> If you already ran 'make dt_binding_check' and didn't see the above
> error(s), then make sure dt-schema is up to date:
I didn't see the issue after upgraded version of pip3 also.

Thanks!

> 
> pip3 install git+https://github.com/devicetree-org/dt-schema.git@master --upgrade
> 
> Please check and re-submit.
> 
