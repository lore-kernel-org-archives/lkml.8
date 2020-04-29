Return-Path: <SRS0=ObIu=6N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8D42C83000
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 18:42:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CE2932072A
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 18:42:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727032AbgD2SmG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Apr 2020 14:42:06 -0400
Received: from mga07.intel.com ([134.134.136.100]:19663 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726481AbgD2SmF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Apr 2020 14:42:05 -0400
IronPort-SDR: 3A0ySfikSO6rqK6P190+42619h6h73IbUuc186G2miZ/8gFjd6+qAFsWQsNBAixdI5PPaZUkOK
 0+CG/WUGX22w==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2020 11:42:04 -0700
IronPort-SDR: Zyukxp0GZrKgrYBy2Q4V3lJkWfXkgn0LdHF9H7i4bh8DKSAOKpNLMjRZbQKit/XJdmqPFHgC1w
 sAaF0CAN+6/A==
X-IronPort-AV: E=Sophos;i="5.73,332,1583222400"; 
   d="scan'208";a="432657402"
Received: from rchatre-mobl.amr.corp.intel.com (HELO [10.255.229.38]) ([10.255.229.38])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2020 11:42:04 -0700
Subject: Re: [PATCH 2/2] x86/resctrl: Support CPUID enumeration of MBM counter
 width
To:     Borislav Petkov <bp@alien8.de>
Cc:     tglx@linutronix.de, fenghua.yu@intel.com, tony.luck@intel.com,
        kuo-lang.tseng@intel.com, mingo@redhat.com, babu.moger@amd.com,
        hpa@zytor.com, x86@kernel.org, linux-kernel@vger.kernel.org
References: <cover.1585763047.git.reinette.chatre@intel.com>
 <76dc65631c373e0c1c9f3e8aaa768f022a2c989c.1585763047.git.reinette.chatre@intel.com>
 <20200429181149.GE16407@zn.tnic>
From:   Reinette Chatre <reinette.chatre@intel.com>
Message-ID: <6fb58472-88f2-925b-3a4e-4692957a9582@intel.com>
Date:   Wed, 29 Apr 2020 11:42:03 -0700
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200429181149.GE16407@zn.tnic>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Borislav,

On 4/29/2020 11:11 AM, Borislav Petkov wrote:
> On Wed, Apr 01, 2020 at 10:51:02AM -0700, Reinette Chatre wrote:
>> diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
>> index 4cdb123ff66a..8552d2fadc15 100644
>> --- a/arch/x86/kernel/cpu/common.c
>> +++ b/arch/x86/kernel/cpu/common.c
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
> Remind me again pls why is all this RDT stuff replicated per CPU instead
> of it being properly detected somewhere down in resctrl_late_init()?
> 
> Looking at get_rdt_resources(), it kinda wants to have that in there
> too?
> 
> IOW, how about moving all that gunk in init_cqm() to resctrl/ where it
> truly belongs? Doesn't have to be this patchset but this patchset can
> start moving it...

I am not familiar with the history to clarify to you why the RDT feature
enumeration is not consistent. Even so, there was an effort to
consolidate this in [1] but it was found to go against the goal of
centralizing the CPUID information [2] and was not pursued further. I
would be happy to revisit this if this is the direction that you prefer.
This would essentially be resubmitting [1] though. Do you expect that
this change would receive a different reception at this time?

Thank you

Reinette


[1]
https://lore.kernel.org/lkml/1560705250-211820-2-git-send-email-fenghua.yu@intel.com/

[2]
https://lore.kernel.org/lkml/alpine.DEB.2.21.1906162141301.1760@nanos.tec.linutronix.de/




