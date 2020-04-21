Return-Path: <SRS0=8uoY=6F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A9CDC54FC9
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 04:06:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0434F206CD
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 04:06:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726462AbgDUEGZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Apr 2020 00:06:25 -0400
Received: from mga17.intel.com ([192.55.52.151]:53853 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725283AbgDUEGY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Apr 2020 00:06:24 -0400
IronPort-SDR: gCNpke3e6SB3YvskM0uZMBXJfNVYz5y2hIhG4RMG99Nz27aWAwn/YjqpFD3P+iWtc3PCDES+oi
 T+nzmKWR6r0g==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2020 21:06:24 -0700
IronPort-SDR: jQ5S4iO8mBHoBUGFUFbqLCye4VRHBbTzfry3odGoq4oSZv2cVmTs/VUczYKTJgJF0TMaPfAvOF
 XnS0sxdN8wrA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,408,1580803200"; 
   d="scan'208";a="456615581"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga006.fm.intel.com with ESMTP; 20 Apr 2020 21:06:24 -0700
Received: from [10.214.151.210] (ekotax-mobl.gar.corp.intel.com [10.214.151.210])
        by linux.intel.com (Postfix) with ESMTP id 9F3295802C9;
        Mon, 20 Apr 2020 21:06:19 -0700 (PDT)
Subject: Re: [RESEND PATCH v6 1/4] mfd: syscon: Add fwnode_to_regmap
To:     Lee Jones <lee.jones@linaro.org>
Cc:     linux-kernel@vger.kernel.org, kishon@ti.com,
        devicetree@vger.kernel.org, arnd@arndb.de, robh@kernel.org,
        andriy.shevchenko@intel.com, cheol.yong.kim@intel.com,
        chuanhua.lei@linux.intel.com, qi-ming.wu@intel.com,
        yixin.zhu@intel.com
References: <cover.1585889042.git.eswara.kota@linux.intel.com>
 <9c58aeb1561f28f302921d54aee75942545c4971.1585889042.git.eswara.kota@linux.intel.com>
 <20200417093551.GH2167633@dell>
From:   Dilip Kota <eswara.kota@linux.intel.com>
Message-ID: <d5b7eb87-7468-a1c4-bf19-d676c8e9c49d@linux.intel.com>
Date:   Tue, 21 Apr 2020 12:06:18 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200417093551.GH2167633@dell>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 4/17/2020 5:35 PM, Lee Jones wrote:
> On Mon, 06 Apr 2020, Dilip Kota wrote:
>
>> Traverse regmap handle entry from firmware node handle.
>>
>> Signed-off-by: Dilip Kota <eswara.kota@linux.intel.com>
>> ---
>> Changes on v5:
>>    No changes
>>    
>> Changes on v5:
>>    No changes
>>
>> Changes on v4:
>>    No changes
>>
>>   drivers/mfd/syscon.c       | 8 ++++++++
>>   include/linux/mfd/syscon.h | 6 ++++++
>>   2 files changed, 14 insertions(+)
>>
>> diff --git a/drivers/mfd/syscon.c b/drivers/mfd/syscon.c
>> index 3a97816d0cba..e085c50816b9 100644
>> --- a/drivers/mfd/syscon.c
>> +++ b/drivers/mfd/syscon.c
>> @@ -178,6 +178,14 @@ struct regmap *device_node_to_regmap(struct device_node *np)
>>   }
>>   EXPORT_SYMBOL_GPL(device_node_to_regmap);
>>   
>> +struct regmap *fwnode_to_regmap(struct fwnode_handle *fwnode)
>> +{
>> +	struct device_node *np = to_of_node(fwnode);
> You are assuming that the fwnode was Device Tree pointer.
>
> The point of a fwnode is that it could be one of multiple types.
>
> What if it was a pointer to an ACPI property?
Yes, i missed to check in other perspective. Thanks for pointing it.
While going through the System control driver to address the query, i 
noticed that System Control
driver is talking with 'of' framework only. (No ACPI)

So, i think to add a defensive check and return error pointer if 
'to_of_node' returns NULL
As System control Driver cannot talk with ACPI, so fwnode_to_regmap() 
cannot talk and return error.

Or, the other option is removing the 'fwnode_to_regmap()' definition 
itself, to avoid confusion as fwnode can
point to 'OF', 'ACPI'or 'swnode'.

But, i feel return error for ACPI or oother, looks better because 
'device_node' has fwnode pointer. And provide description
in the header file, mentioning function is success for 'OF' and returns 
error for the rest.

Regards,
Dilip

>
>
