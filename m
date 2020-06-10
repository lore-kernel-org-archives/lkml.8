Return-Path: <SRS0=CVC0=7X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD8E0C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 01:06:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 87D2D206C3
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 01:06:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726122AbgFJBGp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jun 2020 21:06:45 -0400
Received: from mga14.intel.com ([192.55.52.115]:22909 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726016AbgFJBGo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jun 2020 21:06:44 -0400
IronPort-SDR: Bbj9fit/WQmiNdhHZ18Z2M/6t2ayw4Ba8S0caoj7ZbYlVujV2yPrXvjdRG2tLBNJdeYnKLNtGk
 T2mmOOoR+H1A==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2020 18:06:43 -0700
IronPort-SDR: cBww2uFpyUwLqQE3n0LavVVjC4gKq5MVZcVFC81JfRDr3eCz5+ooYv2iw6/YnxCxtI8cBgtXUv
 wEN6FffG92gQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,494,1583222400"; 
   d="scan'208";a="289014515"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga002.jf.intel.com with ESMTP; 09 Jun 2020 18:06:43 -0700
Received: from [10.255.176.176] (unknown [10.255.176.176])
        by linux.intel.com (Postfix) with ESMTP id DF8C3580698;
        Tue,  9 Jun 2020 18:06:40 -0700 (PDT)
Reply-To: vadivel.muruganx.ramuthevar@linux.intel.com
Subject: Re: [PATCH v1 2/2] usb: phy: Add USB3 PHY support for Intel LGM SoC
To:     Philipp Zabel <p.zabel@pengutronix.de>,
        linux-kernel@vger.kernel.org, balbi@kernel.org
Cc:     gregkh@linuxfoundation.org, robh@kernel.org,
        devicetree@vger.kernel.org, linux-usb@vger.kernel.org,
        cheol.yong.kim@intel.com, qi-ming.wu@intel.com, yin1.li@intel.com,
        andriy.shevchenko@intel.com
References: <20200609110850.43469-1-vadivel.muruganx.ramuthevar@linux.intel.com>
 <20200609110850.43469-3-vadivel.muruganx.ramuthevar@linux.intel.com>
 <d2f30dbde89050e428b61092a1e5bbcf8d257129.camel@pengutronix.de>
From:   "Ramuthevar, Vadivel MuruganX" 
        <vadivel.muruganx.ramuthevar@linux.intel.com>
Message-ID: <1ecf98d8-25f5-8f2b-1b6b-8d6f8f758761@linux.intel.com>
Date:   Wed, 10 Jun 2020 09:06:40 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
MIME-Version: 1.0
In-Reply-To: <d2f30dbde89050e428b61092a1e5bbcf8d257129.camel@pengutronix.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Philipp,

Thank you very much for review comments and your time...

On 9/6/2020 8:14 pm, Philipp Zabel wrote:
>> +
>> +	for (i = 0; i < ARRAY_SIZE(CTL_RESETS); i++) {
>> +		resets[i] = devm_reset_control_get(dev, CTL_RESETS[i]);
> Please use devm_reset_control_get_exclusive() instead.
Noted, will use it.
> 
>> +		if (IS_ERR(resets[i])) {
>> +			dev_err(dev, "%s reset not found\n", CTL_RESETS[i]);
>> +			return PTR_ERR(resets[i]);
>> +		}
>> +		reset_control_assert(resets[i]);
>> +	}
> You should request all reset controls first, and only then start
> asserting / deasserting, otherwise you may end up with partially
> asserted resets in case a later reset control is not found.
Agreed!, re-write the assert/de-assert logic as you have suggested.
> 
>> +
>> +	for (i = 0; i < ARRAY_SIZE(PHY_RESETS); i++) {
>> +		ta->resets[i] = devm_reset_control_get(dev, PHY_RESETS[i]);
> Same as above.
> 
>> +		if (IS_ERR(ta->resets[i])) {
>> +			dev_err(dev, "%s reset not found\n", PHY_RESETS[i]);
>> +			return PTR_ERR(ta->resets[i]);
>> +		}
>> +		reset_control_assert(ta->resets[i]);
>> +	}
>> +
>> +	for (i = 0; i < ARRAY_SIZE(CTL_RESETS); i++)
>> +		reset_control_deassert(resets[i]);
>> +	/* Need to wait at least 20us before de-assert the PHY */
>> +	usleep_range(20, 100);
> This waits 20us after de-asserting the reset, not before. Is this in the
> correct place?
yes, you are right, it's in wrong place, Thanks!

Regards
Vadivel
> 
