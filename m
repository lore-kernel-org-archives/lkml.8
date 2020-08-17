Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B585C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 06:34:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7828B20716
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 06:34:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726698AbgHQGel (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 02:34:41 -0400
Received: from mga02.intel.com ([134.134.136.20]:29037 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726308AbgHQGel (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 02:34:41 -0400
IronPort-SDR: cmlOTB20U6+aGWNrkyt4l331woEcF3rMtLDT5H2e0hElYXUwA+rUsSgxs8FOFAb69rGrdCDCEk
 ldVm3qiqZnXA==
X-IronPort-AV: E=McAfee;i="6000,8403,9715"; a="142473070"
X-IronPort-AV: E=Sophos;i="5.76,322,1592895600"; 
   d="scan'208";a="142473070"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2020 23:34:40 -0700
IronPort-SDR: gwU+YqHakrxXYPg87yVl7y8zF/uOp9f8rvbAPhtRTj+r4kLAW0Zm9ZLwOiMGl+h83jZ3OvzQZS
 EDPA8hL5fOkw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,322,1592895600"; 
   d="scan'208";a="400102512"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga001.fm.intel.com with ESMTP; 16 Aug 2020 23:34:39 -0700
Received: from [10.226.38.21] (unknown [10.226.38.21])
        by linux.intel.com (Postfix) with ESMTP id 92396580583;
        Sun, 16 Aug 2020 23:34:35 -0700 (PDT)
Reply-To: vadivel.muruganx.ramuthevar@linux.intel.com
Subject: Re: [PATCH v8 2/2] phy: Add USB3 PHY support for Intel LGM SoC
To:     Felipe Balbi <balbi@kernel.org>
Cc:     Kernel development list <linux-kernel@vger.kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>, vkoul@kernel.org,
        Greg KH <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Devicetree List <devicetree@vger.kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        andriy.shevchenko@intel.com, cheol.yong.kim@intel.com,
        qi-ming.wu@intel.com, yin1.li@intel.com
References: <20200817031249.36795-1-vadivel.muruganx.ramuthevar@linux.intel.com>
 <20200817031249.36795-3-vadivel.muruganx.ramuthevar@linux.intel.com>
 <CAH8TKc8giWkY8oNMKG97PYov0iN8f6TrA+PAsceSV0uwkO+qjQ@mail.gmail.com>
From:   "Ramuthevar, Vadivel MuruganX" 
        <vadivel.muruganx.ramuthevar@linux.intel.com>
Message-ID: <5b2930b1-469a-93ec-c7ec-7fcc01064e69@linux.intel.com>
Date:   Mon, 17 Aug 2020 14:34:34 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <CAH8TKc8giWkY8oNMKG97PYov0iN8f6TrA+PAsceSV0uwkO+qjQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Felipe,

On 17/8/2020 2:08 pm, Felipe Balbi wrote:
> Hi
> 
> On Mon, Aug 17, 2020 at 6:13 AM Ramuthevar,Vadivel MuruganX
>> diff --git a/drivers/phy/Makefile b/drivers/phy/Makefile
>> index c27408e4daae..90030ff299eb 100644
>> --- a/drivers/phy/Makefile
>> +++ b/drivers/phy/Makefile
>> @@ -1,4 +1,4 @@
>> -# SPDX-License-Identifier: GPL-2.0
>> +PDX-License-Identifier: GPL-2.0
> 
> you didn't try to compile your patch
Good catch, Thank you so much!!
after compiled by mistakenly removed 'S'.

Regards
Vadivel
> 
