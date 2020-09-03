Return-Path: <SRS0=vQOp=CM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.9 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2857BC43461
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 07:28:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E385920737
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 07:27:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728193AbgICH16 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Sep 2020 03:27:58 -0400
Received: from mga07.intel.com ([134.134.136.100]:49043 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726022AbgICH15 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Sep 2020 03:27:57 -0400
IronPort-SDR: X7wd7duZ+Wv8hmkzMBbPVQIpxCeOsRq0oGc+aa4zncE5nmlzm0nuHI+zt+jIJCWsrM1MnppAnw
 H4yawxNk4Vdw==
X-IronPort-AV: E=McAfee;i="6000,8403,9732"; a="221746806"
X-IronPort-AV: E=Sophos;i="5.76,385,1592895600"; 
   d="scan'208";a="221746806"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2020 00:27:56 -0700
IronPort-SDR: Ze3ZybqgmXXV2HST0KQmgul6uR9hAPh6E6UsMzLx6EMFfvZfUTDbVKkqtQmSz+4SUv5x0FohOJ
 g/eqXS3+PNow==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,385,1592895600"; 
   d="scan'208";a="326108998"
Received: from allen-box.sh.intel.com (HELO [10.239.159.139]) ([10.239.159.139])
  by fmsmga004.fm.intel.com with ESMTP; 03 Sep 2020 00:27:53 -0700
Cc:     baolu.lu@linux.intel.com, CobeChen-oc <CobeChen-oc@zhaoxin.com>,
        RaymondPang-oc <RaymondPang-oc@zhaoxin.com>,
        Tony W Wang-oc <TonyWWang-oc@zhaoxin.com>,
        Ashok Raj <ashok.raj@intel.com>
Subject: =?UTF-8?B?UmU6IOetlOWkjTog562U5aSNOiBbUEFUQ0ggdjMgMi8yXSBpb21tdS92?=
 =?UTF-8?Q?t-d=3aAdd_support_for_probing_ACPI_device_in_RMRR?=
To:     FelixCui-oc <FelixCui-oc@zhaoxin.com>,
        Joerg Roedel <joro@8bytes.org>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        "kbuild@lists.01.org" <kbuild@lists.01.org>
References: <20200827100217.21324-1-FelixCui-oc@zhaoxin.com>
 <20200827100217.21324-3-FelixCui-oc@zhaoxin.com>
 <e5b1daaf-f073-94c9-714c-832b10d284f4@linux.intel.com>
 <cde22f0f02f94efcae8bf044e2cd9441@zhaoxin.com>
 <7e5f2c33-c6c3-f344-9014-1f6a306c55aa@linux.intel.com>
 <cfdd29a882d140e5aec2e8c3b77f4968@zhaoxin.com>
From:   Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <56fc76e5-a31c-36b6-c6f0-fd8370cd7a91@linux.intel.com>
Date:   Thu, 3 Sep 2020 15:22:14 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <cfdd29a882d140e5aec2e8c3b77f4968@zhaoxin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Felix,

On 9/2/20 11:24 AM, FelixCui-oc wrote:
> hi baolu,
> 
>> So you have a hidden device (invisible to host kernel). But you need to
> 
>>setup some identity mappings for this device, so that the firmware
>>could keep working, right?
> 
>>The platform designs this by putting that range in the RMRR table and
>>expecting the OS kernel to setup identity mappings during boot.
> 
>>Do I understand it right?
> 
> 
> Yes. What you understand is correct.

This appears to be a new usage model of RMRR. I need to discuss this
with the VT-d spec maintainer. Do you mind telling which platform are
you going to run this on? What is the motivation of creating such hidden
device?

Basically, RMRRs were added as work around for certain legacy device and
we have been working hard to fix those legacy devices so that RMRR are
no longer needed.

Best regards,
baolu
