Return-Path: <SRS0=f73W=7K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E5EDC433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 08:51:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0CA342088E
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 08:51:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727973AbgE1IvU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 May 2020 04:51:20 -0400
Received: from mga06.intel.com ([134.134.136.31]:40848 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727088AbgE1IvT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 04:51:19 -0400
IronPort-SDR: +YJpdn432hBN1xQeaVk4+bFzKOrlOwWkWDICqjcPY6ekioQCBXOSmlIqet4BejN/mDvYI/me4l
 yO4y/FlDWrFg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2020 01:51:18 -0700
IronPort-SDR: vS7gHEZZyLCDe4Sgm3Yp3klFoGoW/MTi4toI8f5gPnWowX71A1x2JiLRWmCDDTc1EkMnHHnR3C
 dRfXlhaD3EZw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,444,1583222400"; 
   d="scan'208";a="267149507"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga003.jf.intel.com with ESMTP; 28 May 2020 01:51:18 -0700
Received: from [10.255.136.206] (ekotax-mobl.gar.corp.intel.com [10.255.136.206])
        by linux.intel.com (Postfix) with ESMTP id 5C3345805EF;
        Thu, 28 May 2020 01:51:16 -0700 (PDT)
Subject: Re: [PATCH] phy: intel: fix enum type mismatch warning
To:     Nathan Chancellor <natechancellor@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com
References: <20200527134518.908624-1-arnd@arndb.de>
 <20200527164035.GA1073507@ubuntu-s3-xlarge-x86>
From:   Dilip Kota <eswara.kota@linux.intel.com>
Message-ID: <f9ac4d6b-95a2-3ac3-8aeb-d9a73801b4b5@linux.intel.com>
Date:   Thu, 28 May 2020 16:51:15 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200527164035.GA1073507@ubuntu-s3-xlarge-x86>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 5/28/2020 12:40 AM, Nathan Chancellor wrote:
> On Wed, May 27, 2020 at 03:45:06PM +0200, Arnd Bergmann wrote:
>> clang points out that a local variable is initialized with
>> an enum value of the wrong type:
>>
>> drivers/phy/intel/phy-intel-combo.c:202:34: error: implicit conversion from enumeration type 'enum intel_phy_mode' to different enumeration type 'enum intel_combo_mode' [-Werror,-Wenum-conversion]
>>          enum intel_combo_mode cb_mode = PHY_PCIE_MODE;
>>                                ~~~~~~~   ^~~~~~~~~~~~~
>>
>>  From reading the code, it seems that this was not only the
>> wrong type, but not even supposed to be a code path that can
>> happen in practice.
>>
>> Change the code to have no default phy mode but instead return an
>> error for invalid input.
>>
>> Fixes: ac0a95a3ea78 ("phy: intel: Add driver support for ComboPhy")
>> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>> ---
>>   drivers/phy/intel/phy-intel-combo.c | 4 +++-
>>   1 file changed, 3 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/phy/intel/phy-intel-combo.c b/drivers/phy/intel/phy-intel-combo.c
>> index c2a35be4cdfb..04f7b0d08742 100644
>> --- a/drivers/phy/intel/phy-intel-combo.c
>> +++ b/drivers/phy/intel/phy-intel-combo.c
>> @@ -199,7 +199,7 @@ static int intel_cbphy_pcie_dis_pad_refclk(struct intel_cbphy_iphy *iphy)
>>   
>>   static int intel_cbphy_set_mode(struct intel_combo_phy *cbphy)
>>   {
>> -	enum intel_combo_mode cb_mode = PHY_PCIE_MODE;
>> +	enum intel_combo_mode cb_mode;
>>   	enum aggregated_mode aggr = cbphy->aggr_mode;
>>   	struct device *dev = cbphy->dev;
>>   	enum intel_phy_mode mode;
>> @@ -224,6 +224,8 @@ static int intel_cbphy_set_mode(struct intel_combo_phy *cbphy)
>>   
>>   		cb_mode = SATA0_SATA1_MODE;
>>   		break;
>> +	default:
>> +		return -EINVAL;
>>   	}
>>   
>>   	ret = regmap_write(cbphy->hsiocfg, REG_COMBO_MODE(cbphy->bid), cb_mode);
>> -- 
>> 2.26.2
>>
> I sent an almost identical patch:
>
> https://lore.kernel.org/lkml/20200523035043.3305846-1-natechancellor@gmail.com/
>
> I left out the default case since clang warns when a switch on an enum
> does not handle all the values (compile time scream) versus a run time
> scream like yours.
>
> I don't have a preference for either so:
>
> Reviewed-by: Nathan Chancellor <natechancellor@gmail.com>
Thanks for fixing it. I wrongly initiated it with PHY_PCIE_MODE instead 
of PCIE0_PCIE1_MODE to fix the compiler warnings. (On real time use 
case, cb_mode gets initialized with one of the switch case values, it 
never hits the default case, so I didn't add the default case.)

This patch looks good to fix the warnings.
Reviewed-by: Dilip Kota <eswara.kota@linux.intel.com>

Regards,
Dilip
