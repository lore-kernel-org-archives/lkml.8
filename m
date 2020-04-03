Return-Path: <SRS0=4r1w=5T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FD81C2BA19
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 15:31:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7148120721
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 15:31:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404341AbgDCPbY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Apr 2020 11:31:24 -0400
Received: from mga03.intel.com ([134.134.136.65]:18868 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404342AbgDCPbV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Apr 2020 11:31:21 -0400
IronPort-SDR: SWjTOvpMierBDBsS9i9rwSXmIZtL34Xor79oDA/eVVZDdRVnAtGbdQn30FCWJEj6mYXah/OS3D
 otGDcBF6C6Tw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2020 08:31:20 -0700
IronPort-SDR: OMKQRF7Fa+iUbgQ+e6v2U6cpSieyKSM7XzJhJm5+LAmhFnsLxwCxnMzjTRjWC4Fu+rYiAQvKiH
 /Xks5XdYTiTw==
X-IronPort-AV: E=Sophos;i="5.72,340,1580803200"; 
   d="scan'208";a="329196150"
Received: from rchatre-mobl.amr.corp.intel.com (HELO [10.251.28.58]) ([10.251.28.58])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2020 08:31:20 -0700
Subject: Re: [PATCH 2/2] x86/resctrl: Support CPUID enumeration of MBM counter
 width
To:     Fenghua Yu <fenghua.yu@intel.com>
Cc:     tglx@linutronix.de, bp@alien8.de, tony.luck@intel.com,
        kuo-lang.tseng@intel.com, mingo@redhat.com, babu.moger@amd.com,
        hpa@zytor.com, x86@kernel.org, linux-kernel@vger.kernel.org
References: <cover.1585763047.git.reinette.chatre@intel.com>
 <76dc65631c373e0c1c9f3e8aaa768f022a2c989c.1585763047.git.reinette.chatre@intel.com>
 <20200403000527.GI188393@romley-ivt3.sc.intel.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
Message-ID: <83423890-c3f5-3794-8e8b-4c0ac124cd42@intel.com>
Date:   Fri, 3 Apr 2020 08:31:12 -0700
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200403000527.GI188393@romley-ivt3.sc.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Fenghua,

On 4/2/2020 5:05 PM, Fenghua Yu wrote:
> On Wed, Apr 01, 2020 at 10:51:02AM -0700, Reinette Chatre wrote:
>> The original Memory Bandwidth Monitoring (MBM) architectural
>> definition defines counters of up to 62 bits in the
>> IA32_QM_CTR MSR while the first-generation MBM implementation
>> uses statically defined 24 bit counters.
>>
>> @@ -856,6 +856,8 @@ static void init_speculation_control(struct cpuinfo_x86 *c)
>>  
>>  static void init_cqm(struct cpuinfo_x86 *c)
>>  {
>> +	c->x86_cache_mbm_width_offset = -1;
>> +
>>  	if (!cpu_has(c, X86_FEATURE_CQM_LLC)) {
>>  		c->x86_cache_max_rmid  = -1;
>>  		c->x86_cache_occ_scale = -1;
>> @@ -875,6 +877,9 @@ static void init_cqm(struct cpuinfo_x86 *c)
>>  
>>  		c->x86_cache_max_rmid  = ecx;
>>  		c->x86_cache_occ_scale = ebx;
>> +		/* EAX contents is only defined for Intel CPUs */
>> +		if (c->x86_vendor == X86_VENDOR_INTEL)
>> +			c->x86_cache_mbm_width_offset = eax & 0xff;
> 
> Is it reliable to read eax which is reserved on older platforms that
> don't support the feature?

The new ISE specification contains an architectural redefinition of EAX.

> 
> Seems the code assumes the reserved eax is 0 on those platforms. Is it
> reliable?

Testing on BDW, SKX, and CLX confirmed that EAX is 0. This addition thus
results in no functional change on these systems with them continuing to
use the original MBM width of 24.

Reinette

