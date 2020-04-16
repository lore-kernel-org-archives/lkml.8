Return-Path: <SRS0=1dCa=6A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A177C2BA2B
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 06:57:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 57D5F214D8
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 06:57:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437789AbgDPG5e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Apr 2020 02:57:34 -0400
Received: from mga14.intel.com ([192.55.52.115]:6493 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2437733AbgDPG5V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 02:57:21 -0400
IronPort-SDR: +Wv6HHtlVkWnxRXH8fIrJlhvYdens/L3RkKikIN4oApRMStU7G+ONyjiy6idPL8ATVQgYTEYmC
 crZYvxWxd4Cg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2020 23:57:20 -0700
IronPort-SDR: cl4aemAJ34kAwBAz6G19L8mgX7CcTBJHKqHNEBgRKlva0yxQ0IzbXFTQeUTdjMLI6xlBV9Kn8k
 7ltNEdAcyz0g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,390,1580803200"; 
   d="scan'208";a="245901134"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga008.fm.intel.com with ESMTP; 15 Apr 2020 23:57:20 -0700
Received: from [10.213.149.31] (ekotax-mobl.gar.corp.intel.com [10.213.149.31])
        by linux.intel.com (Postfix) with ESMTP id D725F5802C9;
        Wed, 15 Apr 2020 23:57:17 -0700 (PDT)
Subject: Re: [PATCH v5 1/4] mfd: syscon: Add fwnode_to_regmap
To:     Lee Jones <lee.jones@linaro.org>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        kishon@ti.com, robh@kernel.org, andriy.shevchenko@intel.com,
        cheol.yong.kim@intel.com, chuanhua.lei@linux.intel.com,
        qi-ming.wu@intel.com, yixin.zhu@intel.com
References: <cover.1585103753.git.eswara.kota@linux.intel.com>
 <9953bb25281397553cb87b09d641c968d8432dd9.1585103753.git.eswara.kota@linux.intel.com>
 <20200415093116.GH2167633@dell>
From:   Dilip Kota <eswara.kota@linux.intel.com>
Message-ID: <0adafade-7228-58d3-3db0-b06325712468@linux.intel.com>
Date:   Thu, 16 Apr 2020 14:57:16 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200415093116.GH2167633@dell>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 4/15/2020 5:31 PM, Lee Jones wrote:
> On Wed, 25 Mar 2020, Dilip Kota wrote:
>
>> Traverse regmap handle entry from firmware node handle.
>>
>> Signed-off-by: Dilip Kota <eswara.kota@linux.intel.com>
>> ---
>> Changes on v5:
>>    No changes
>>
>> Changes on v4:
>>    No changes
>>
>>   drivers/mfd/syscon.c       | 8 ++++++++
>>   include/linux/mfd/syscon.h | 6 ++++++
>>   2 files changed, 14 insertions(+)
> I think you'll find it very difficult to have a patch merged if you do
> not send it to any Maintainers of the associated subsystem(s).
Sorry, i completely missed adding the system configuration Maintainers. 
I was completely thinking about the PHY driver( in doing changes and 
upgrades) while sending the patches.
I have noticed it, and already sent v6 patch series by adding you and 
arnd@arndb.de

"[RESEND PATCH v6 0/4] Add Intel ComboPhy driver"
Snippet from the mail.

"Re-sending the patches v6 by adding the system configuration Maintainers,
which i missed to add them."

Regards,
Dilip

>
> Did you use `scripts/get_maintainer.pl` at all?
>
