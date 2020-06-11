Return-Path: <SRS0=NqQd=7Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E484C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 09:01:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 315E420747
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 09:01:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726918AbgFKJBf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jun 2020 05:01:35 -0400
Received: from mga03.intel.com ([134.134.136.65]:4803 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726790AbgFKJBf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jun 2020 05:01:35 -0400
IronPort-SDR: KvLf+9Ogvw8N0u0grp2RQ022H0ic5Sr4PBQLlChemjuIl8dBz0SOtnAgcmXptgmV4eHygKLvrx
 EWTACex7fAwQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2020 02:01:35 -0700
IronPort-SDR: 6ITRvQo4TaYdZoPDTI+zEjEv2DNIWe0IS8NPuGBRjpyrRvei3KLh76xmrcJ4dHShHvxTX7Ueog
 prduhYEpr2fQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,499,1583222400"; 
   d="scan'208";a="260442809"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga007.jf.intel.com with ESMTP; 11 Jun 2020 02:01:34 -0700
Received: from [10.214.154.243] (vramuthx-mobl1.gar.corp.intel.com [10.214.154.243])
        by linux.intel.com (Postfix) with ESMTP id 5024B580458;
        Thu, 11 Jun 2020 02:01:31 -0700 (PDT)
Reply-To: vadivel.muruganx.ramuthevar@linux.intel.com
Subject: Re: [PATCH v2 2/2] usb: phy: Add USB3 PHY support for Intel LGM SoC
To:     Andy Shevchenko <andriy.shevchenko@intel.com>
Cc:     linux-kernel@vger.kernel.org, balbi@kernel.org,
        p.zabel@pengutronix.de, gregkh@linuxfoundation.org,
        robh@kernel.org, devicetree@vger.kernel.org,
        linux-usb@vger.kernel.org, cheol.yong.kim@intel.com,
        qi-ming.wu@intel.com, yin1.li@intel.com
References: <20200611021246.3250-1-vadivel.muruganx.ramuthevar@linux.intel.com>
 <20200611021246.3250-3-vadivel.muruganx.ramuthevar@linux.intel.com>
 <20200611081254.GR2428291@smile.fi.intel.com>
 <21b5db0e-c45a-2255-0389-04b204685d63@linux.intel.com>
 <20200611085710.GV2428291@smile.fi.intel.com>
From:   "Ramuthevar, Vadivel MuruganX" 
        <vadivel.muruganx.ramuthevar@linux.intel.com>
Message-ID: <086e01da-a834-4745-022a-8d59c52f98d6@linux.intel.com>
Date:   Thu, 11 Jun 2020 17:01:29 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
MIME-Version: 1.0
In-Reply-To: <20200611085710.GV2428291@smile.fi.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andy,

  Thank you very much for prompt review comments...

On 11/6/2020 4:57 pm, Andy Shevchenko wrote:
> On Thu, Jun 11, 2020 at 04:36:29PM +0800, Ramuthevar, Vadivel MuruganX wrote:
>> On 11/6/2020 4:12 pm, Andy Shevchenko wrote:
>>> On Thu, Jun 11, 2020 at 10:12:46AM +0800, Ramuthevar,Vadivel MuruganX wrote:
>>>> From: Ramuthevar Vadivel Murugan <vadivel.muruganx.ramuthevar@linux.intel.com>
> 
> ...
> 
>>>> +	ret = readl_poll_timeout(ctrl1, val, val & SRAM_INIT_DONE,
>>>> +				 10, 10 * 1000);
>> exceeds more than 80 characters, so checkpatch throws warnings, to avoid
>> that move to next line.
> 
>>> On one line easier to read.
> 
> It's 82 characters. It's fine.
Noted.
> 
>>>> +	if (ret) {
>>>> +		dev_err(ta->phy.dev, "SRAM init failed, 0x%x\n", val);
>>>> +		return ret;
>>>> +	}
> 
> ...
> 
>>>> +	int ret = 0;
>>>
>>> Assignment is redundant.
>> so you mean , should be declared as
>> int ret;
>> right?
> 
> Right.
okay, Thanks!
> 
> ...
> 
>>>> +		dev_info(ta->phy.dev, "connected%s\n",
>>>> +			 flipped ? " flipped" : "");
>>>
>>> One line.
>> exceeds more than 80 characters, so checkpatch throw warnings, to avoid that
>> moved to next line.
> 
> It's fine to have on one line.
> 
> And by the way, try new checkpatch.
Sure , will try and fix it.

Regards
Vadivel
> 
> 
