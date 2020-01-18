Return-Path: <SRS0=3sb/=3H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABAEDC33C9E
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Jan 2020 02:15:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80D602192A
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Jan 2020 02:15:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730613AbgARCPi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jan 2020 21:15:38 -0500
Received: from mga09.intel.com ([134.134.136.24]:25928 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727033AbgARCPi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jan 2020 21:15:38 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 17 Jan 2020 18:15:37 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,332,1574150400"; 
   d="scan'208";a="214686218"
Received: from allen-box.sh.intel.com (HELO [10.239.159.138]) ([10.239.159.138])
  by orsmga007.jf.intel.com with ESMTP; 17 Jan 2020 18:15:35 -0800
Cc:     baolu.lu@linux.intel.com, ashok.raj@intel.com,
        jacob.jun.pan@intel.com, kevin.tian@intel.com,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] iommu/vt-d: Remove unnecessary WARN_ON_ONCE()
To:     Joerg Roedel <joro@8bytes.org>
References: <20200116015236.4458-1-baolu.lu@linux.intel.com>
 <20200117095953.GB15760@8bytes.org>
From:   Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <b56e8a8f-acd7-b318-5a1c-f32c5a07657f@linux.intel.com>
Date:   Sat, 18 Jan 2020 10:14:11 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200117095953.GB15760@8bytes.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Joerg,

On 1/17/20 5:59 PM, Joerg Roedel wrote:
> On Thu, Jan 16, 2020 at 09:52:36AM +0800, Lu Baolu wrote:
>> Address field in device TLB invalidation descriptor is qualified
>> by the S field. If S field is zero, a single page at page address
>> specified by address [63:12] is requested to be invalidated. If S
>> field is set, the least significant bit in the address field with
>> value 0b (say bit N) indicates the invalidation address range. The
>> spec doesn't require the address [N - 1, 0] to be cleared, hence
>> remove the unnecessary WARN_ON_ONCE().
>>
>> Otherwise, the caller might set "mask = MAX_AGAW_PFN_WIDTH" in order
>> to invalidating all the cached mappings on an endpoint, and below
>> overflow error will be triggered.
>>
>> [...]
>> UBSAN: Undefined behaviour in drivers/iommu/dmar.c:1354:3
>> shift exponent 64 is too large for 64-bit type 'long long unsigned int'
>> [...]
>>
>> Reported-and-tested-by: Frank <fgndev@posteo.de>
>> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> 
> Does this need a Fixes and/or stable tag?
> 

This doesn't cause any errors, just an unnecessary checking of

	"0 & ((1UL << 64) - 1)"

in some cases.

> 
> Regards,
> 
> 	Joerg

Best regards,
baolu
