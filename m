Return-Path: <SRS0=2JZx=64=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 737C4C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 20:12:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4BFCB2065F
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 20:12:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727885AbgENUMD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 May 2020 16:12:03 -0400
Received: from mga17.intel.com ([192.55.52.151]:50069 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726128AbgENUMD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 May 2020 16:12:03 -0400
IronPort-SDR: f6VJMqpyNQnFXOYsA3gpv1ZVmEQWAD2TET9jw1am37ZfxrM/xDL9j/hXwm+a56MinDzRufPVtK
 z7uKZkWdUuLg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2020 13:12:02 -0700
IronPort-SDR: 3YwbjKvUIn8yjyXLkPLXwcFHK6Z3y60aShjP7PRQCK2VPMeH32Wif231YQZsmZiPc8e8+k1IzP
 uORq3w5aSpHA==
X-IronPort-AV: E=Sophos;i="5.73,392,1583222400"; 
   d="scan'208";a="280974194"
Received: from rchatre-mobl.amr.corp.intel.com (HELO [10.254.66.120]) ([10.254.66.120])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2020 13:12:02 -0700
Subject: Re: [PATCH V3 2/4] x86/resctrl: Enumerate per-thread MBA
To:     Babu Moger <babu.moger@amd.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "fenghua.yu@intel.com" <fenghua.yu@intel.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "tony.luck@intel.com" <tony.luck@intel.com>
Cc:     "kuo-lang.tseng@intel.com" <kuo-lang.tseng@intel.com>,
        "ravi.v.shankar@intel.com" <ravi.v.shankar@intel.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "hpa@zytor.com" <hpa@zytor.com>, "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <cover.1588808537.git.reinette.chatre@intel.com>
 <3a9c21e1b8108094d9132ca0c0271e8c7b93c847.1588808538.git.reinette.chatre@intel.com>
 <eefd2231-cdbe-1250-3069-bb9204c940c1@amd.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
Message-ID: <e8b35231-f94e-ba25-125d-12819478bb24@intel.com>
Date:   Thu, 14 May 2020 13:12:01 -0700
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <eefd2231-cdbe-1250-3069-bb9204c940c1@amd.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Babu,

On 5/14/2020 12:04 PM, Babu Moger wrote:
> 
> 
>> -----Original Message-----
>> From: Reinette Chatre <reinette.chatre@intel.com>
>> Sent: Wednesday, May 6, 2020 6:50 PM
>> To: tglx@linutronix.de; fenghua.yu@intel.com; bp@alien8.de;
>> tony.luck@intel.com
>> Cc: kuo-lang.tseng@intel.com; ravi.v.shankar@intel.com; mingo@redhat.com;
>> Moger, Babu <Babu.Moger@amd.com>; hpa@zytor.com; x86@kernel.org;
>> linux-kernel@vger.kernel.org; Reinette Chatre <reinette.chatre@intel.com>
>> Subject: [PATCH V3 2/4] x86/resctrl: Enumerate per-thread MBA
>>
>> From: Fenghua Yu <fenghua.yu@intel.com>
>>

...

>> diff --git a/arch/x86/kernel/cpu/scattered.c b/arch/x86/kernel/cpu/scattered.c
>> index 62b137c3c97a..bccfc9ff3cc1 100644
>> --- a/arch/x86/kernel/cpu/scattered.c
>> +++ b/arch/x86/kernel/cpu/scattered.c
>> @@ -35,6 +35,7 @@ static const struct cpuid_bit cpuid_bits[] = {
>>  	{ X86_FEATURE_CDP_L3,		CPUID_ECX,  2, 0x00000010, 1
>> },
>>  	{ X86_FEATURE_CDP_L2,		CPUID_ECX,  2, 0x00000010, 2
>> },
>>  	{ X86_FEATURE_MBA,		CPUID_EBX,  3, 0x00000010, 0 },
>> +	{ X86_FEATURE_PER_THREAD_MBA,	CPUID_ECX,  0, 0x00000010, 3
>> },
> 
> This is a CPUID feature. You can actually detect this feature without
> checking vendor model in patch @1. This patch looks good to me.
> 

This feature is different from the feature introduced in patch 1.

Reinette
