Return-Path: <SRS0=1210=4J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 244B3C35646
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 17:07:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 061B6222C4
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 17:07:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728135AbgBURHB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Feb 2020 12:07:01 -0500
Received: from mga11.intel.com ([192.55.52.93]:21383 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726829AbgBURHB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Feb 2020 12:07:01 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 Feb 2020 09:06:44 -0800
X-IronPort-AV: E=Sophos;i="5.70,469,1574150400"; 
   d="scan'208";a="229906480"
Received: from unknown (HELO [10.24.14.134]) ([10.24.14.134])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 21 Feb 2020 09:06:43 -0800
Subject: Re: [PATCH v2] x86/resctrl: Preserve CDP enable over cpuhp
To:     James Morse <james.morse@arm.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Fenghua Yu <fenghua.yu@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>
References: <20200214181600.38779-1-james.morse@arm.com>
 <214c845b-d093-bafc-02d0-dfd810283f1a@intel.com>
 <32c563f9-c645-5c04-ed0b-18b3348c9c7f@arm.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
Message-ID: <6e9f1a93-9665-6bef-7285-5f4de920471a@intel.com>
Date:   Fri, 21 Feb 2020 09:06:41 -0800
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.2
MIME-Version: 1.0
In-Reply-To: <32c563f9-c645-5c04-ed0b-18b3348c9c7f@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi James,

On 2/21/2020 7:25 AM, James Morse wrote:
> Hi Reinette,
> 
> On 14/02/2020 19:24, Reinette Chatre wrote:
>> On 2/14/2020 10:16 AM, James Morse wrote:
>>> Resctrl assumes that all CPUs are online when the filesystem is
>>> mounted, and that CPUs remember their CDP-enabled state over CPU
>>> hotplug.
>>>
>>> This goes wrong when resctrl's CDP-enabled state changes while all
>>> the CPUs in a domain are offline.
>>>
>>> When a domain comes online, enable (or disable!) CDP to match resctrl's
>>> current setting.
> 
>>> diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>>> index 064e9ef44cd6..5967320a1951 100644
>>> --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>>> +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>>> @@ -1831,6 +1831,9 @@ static int set_cache_qos_cfg(int level, bool enable)
>>>  	struct rdt_domain *d;
>>>  	int cpu;
>>>  
>>> +	 /* CDP state is restored during cpuhp, which takes this lock */
>>> +	lockdep_assert_held(&rdtgroup_mutex);
>>> +
>>
>> I think this hunk can be dropped. (1) The code path where this
>> annotation is added is not part of this fix. (2) The comment implies
>> that the taking of the mutex is something new/unique added in the CPU
>> hotplug path but that is not accurate since this mutex is also taken in
>> the only other existing call path of this snippet that is handling the
>> mounting of the filesystem.
> 
> These things answer the question: "what stops rdt_domain_reconfigure_cdp() racing with
> set_cache_qos_cfg() on the mount path, causing the wrong value to be restored?".
> 
> We can try and answer that in the commit message, or comments, but these will quickly be
> lost, stale, or wrong.
> 
> These annotations serve as a comment, and let lockdep check its still true.
> (I think you can never have enough lockdep annotations!)

I agree that lockdep annotations are valuable. My comment was specific
to this one hunk, not all lockdep annotations in your patch. Please
consider my comment in the spirit of patch guidance (per
Documentation/process/submitting-patches.rst) noting that all logical
changes should be in separate patches. This specific hunk is unrelated
to the bug being fixed in this patch but can surely be done in a
separate patch submitted together with this fix.

>> You do mention that these annotations is helpful for the MPAM work.
> 
> Indeed, it splits up the, er, "big RDT mutex", these annotations mean lockdep catches me
> out if I do something wrong, and makes it very clear when changing something subtle.
> 
> 
>> Could the annotations instead be added as a separate patch forming part
>> of that work?
> 
> Ideally these things are there from the beginning. Adding them over time as part of other
> reviewed patches works. I don't think adding them in one go before refactoring helps: you
> wouldn't have the confidence that they were correct in the first place.
> 
> I'll drop these.

My comment was just specific to the one lockdep annotation added to an
area that was unrelated to the bugfix. I noticed that you removed all
annotations in your new version, that was not my intention. You could
surely keep the lockdep annotation that is in the new code path
introduced in this fix and a separate patch with the other lockdep
annotation would also be welcome (with accurate comment).

Thank you

Reinette
