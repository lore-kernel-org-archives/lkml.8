Return-Path: <SRS0=e3tL=6T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A462C47254
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 07:54:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1151920658
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 07:54:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728284AbgEEHyt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 May 2020 03:54:49 -0400
Received: from mga14.intel.com ([192.55.52.115]:54834 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725320AbgEEHyt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 May 2020 03:54:49 -0400
IronPort-SDR: iv+inoWeNZRFUtjePqUJenWPei2jidbpWcCdwjTxx7BhJop1Z4AhKP5Ui1OPs+bzTx3aOhp+Mk
 vdPUTcy3hYKw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2020 00:54:48 -0700
IronPort-SDR: unY5fCC7FpHtmrq19aiLl/M+8T7+XeyJOKYOTUXGAB2F+YWm2Zsei/nVSh3rqteJKseAzNNyUQ
 MXw1tT80NOPw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,354,1583222400"; 
   d="scan'208";a="460949449"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga005.fm.intel.com with ESMTP; 05 May 2020 00:54:45 -0700
Received: from [10.215.153.169] (ekotax-mobl.gar.corp.intel.com [10.215.153.169])
        by linux.intel.com (Postfix) with ESMTP id 25B1758048A;
        Tue,  5 May 2020 00:54:41 -0700 (PDT)
Subject: Re: [PATCH v7 3/3] phy: intel: Add driver support for ComboPhy
To:     Vinod Koul <vkoul@kernel.org>
Cc:     linux-kernel@vger.kernel.org, kishon@ti.com,
        devicetree@vger.kernel.org, lee.jones@linaro.org, arnd@arndb.de,
        robh@kernel.org, andriy.shevchenko@intel.com,
        cheol.yong.kim@intel.com, chuanhua.lei@linux.intel.com,
        qi-ming.wu@intel.com, yixin.zhu@intel.com
References: <cover.1588230494.git.eswara.kota@linux.intel.com>
 <af8a7d7025990d22f6062953247cf80e64c6fd2f.1588230494.git.eswara.kota@linux.intel.com>
 <20200504072923.GN1375924@vkoul-mobl>
 <f12e76ac-e0fd-4afa-e1cd-2b90f175adfd@linux.intel.com>
 <20200504092034.GS1375924@vkoul-mobl>
 <0de7ba47-bc98-9267-46b4-230a86151c2d@linux.intel.com>
 <20200505052122.GW1375924@vkoul-mobl>
From:   Dilip Kota <eswara.kota@linux.intel.com>
Message-ID: <dd259c37-d273-44d3-c095-8618264e3a19@linux.intel.com>
Date:   Tue, 5 May 2020 15:54:40 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200505052122.GW1375924@vkoul-mobl>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 5/5/2020 1:21 PM, Vinod Koul wrote:
> On 04-05-20, 17:32, Dilip Kota wrote:
>> On 5/4/2020 5:20 PM, Vinod Koul wrote:
>>> On 04-05-20, 16:26, Dilip Kota wrote:
>>>> On 5/4/2020 3:29 PM, Vinod Koul wrote:
>>>>> On 30-04-20, 15:15, Dilip Kota wrote:
>>>>>
>>>>>> +					  u32 mask, u32 val)
>>>>>> +{
>>>>>> +	u32 reg_val;
>>>>>> +
>>>>>> +	reg_val = readl(base + reg);
>>>>>> +	reg_val &= ~mask;
>>>>>> +	reg_val |= FIELD_PREP(mask, val);
>>>>>> +	writel(reg_val, base + reg);
>>>>> bypassing regmap here... why?
>>>> It is not regmap address, one of the below two addresses are passed to this
>>>> function.
>>> okay, perhaps add a comment somewhere that regmap is not used for this
>>> base?
>> I dont see a need of adding a comment, describing don't do regmap here.
> Driver uses regmap except here, which seems odd hence explanation
> required for this.
During the driver Probe, the register phandles are stored in regmap 
datatype variables and PHY core addresses are stored in iomem datatype.
Since then, regmap access is performed for the regmap datatype variables 
and readl/writel access is performed on the iomem datatype variables. 
And nowhere in the driver iomem datatype address are converted to regmap 
address and performed regmap access.

Driver is not doing any 'regmap_init' on any physical address. Driver is 
getting the register address phandle from the device tree node and 
performing the regmap access.
ret = fwnode_property_get_reference_args(fwnode, "intel,syscfg", NULL, 
1, 0, &ref);
[...]
cbphy->syscfg = device_node_to_regmap(to_of_node(ref.fwnode));

[...]
ret = fwnode_property_get_reference_args(fwnode, "intel,hsio", NULL, 1, 
0, &ref);
[...]

cbphy->hsiocfg = device_node_to_regmap(to_of_node(ref.fwnode));

[...]
cbphy->app_base = devm_platform_ioremap_resource_byname(pdev, "app");
  [...]
cbphy->cr_base = devm_platform_ioremap_resource_byname(pdev, "core");

The DT parsing logic in the driver is explaining why the PHY driver 
should do regmap access and to whom should be done. For this reason i am 
a bit puzzled to what more is needed to explain in the comments and 
where to add it.
Please let me know your view.

Regards,
Dilip
