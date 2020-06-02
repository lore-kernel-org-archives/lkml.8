Return-Path: <SRS0=QAx1=7P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1C6CC433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 21:59:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BA31F206C3
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 21:59:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728370AbgFBV7O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jun 2020 17:59:14 -0400
Received: from mga18.intel.com ([134.134.136.126]:43242 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726174AbgFBV7O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jun 2020 17:59:14 -0400
IronPort-SDR: dElcAWi28Km6PAC3X0ditRsmhEtJ8DZFh/OayJdrg3pjTzEKfcHJhc6Fjpyr8DubFQhEZPKh57
 L+UgGM+WFFUA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2020 14:59:13 -0700
IronPort-SDR: 30HUT4a4/VLihBK1M/xda1FpWKZkaHuth5wT7BgMsTRfoOaPtcGwmRiKZl3H/7sOptuvRbh0QW
 kSrCixErHZtg==
X-IronPort-AV: E=Sophos;i="5.73,466,1583222400"; 
   d="scan'208";a="272513315"
Received: from rchatre-mobl.amr.corp.intel.com (HELO [10.209.123.248]) ([10.209.123.248])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2020 14:59:13 -0700
Subject: Re: [PATCH] x86/resctrl: Fix memory bandwidth counter width for AMD
To:     Babu Moger <babu.moger@amd.com>, fenghua.yu@intel.com,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, x86@kernel.org,
        hpa@zytor.com, linux-kernel@vger.kernel.org
References: <159105232628.48268.7763865625735367523.stgit@naples-babu.amd.com>
 <63f23edd-39d3-0577-6e00-21066ddfe57f@intel.com>
 <05e11ddd-ca0b-e454-0152-6c83e7b7d719@amd.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
Message-ID: <296417cc-584f-158c-7d09-0c30a95f0192@intel.com>
Date:   Tue, 2 Jun 2020 14:59:12 -0700
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
MIME-Version: 1.0
In-Reply-To: <05e11ddd-ca0b-e454-0152-6c83e7b7d719@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Babu,

On 6/2/2020 10:33 AM, Babu Moger wrote:
> 
> 
> On 6/2/20 12:13 PM, Reinette Chatre wrote:
>> On 6/1/2020 4:00 PM, Babu Moger wrote:
>>> Memory bandwidth is calculated reading the monitoring counter
>>> at two intervals and calculating the delta. It is the software’s
>>> responsibility to read the count often enough to avoid having
>>> the count roll over _twice_ between reads.
>>>
>>> The current code hardcodes the bandwidth monitoring counter's width
>>> to 24 bits for AMD. This is due to default base counter width which
>>> is 24. Currently, AMD does not implement the CPUID 0xF.[ECX=1]:EAX
>>> to adjust the counter width. But, the AMD hardware supports much
>>> wider bandwidth counter with the default width of 44 bits.
>>>
>>> Kernel reads these monitoring counters every 1 second and adjusts the
>>> counter value for overflow. With 24 bits and scale value of 64 for AMD,
>>> it can only measure up to 1GB/s without overflowing. For the rates
>>> above 1GB/s this will fail to measure the bandwidth.
>>>
>>> Fix the issue setting the default width to 44 bits by adjusting the
>>> offset.
>>>
>>> AMD future products will implement the CPUID 0xF.[ECX=1]:EAX.
>>>
>>> Signed-off-by: Babu Moger <babu.moger@amd.com>
>>
>> There is no fixes tag but if I understand correctly this issue has been
>> present since AMD support was added to resctrl. This fix builds on top
>> of a recent feature addition and would thus not work for earlier
>> kernels. Are you planning to create a different fix for earlier kernels?
> 
> Yes. This was there from day one. I am going to back port to older kernels
> once we arrive on the final patch. Do we need fixes tag here?
> 

Yes, this needs a fixes tag. This would help the teams understand which
kernels should be fixed.

Reinette
