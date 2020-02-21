Return-Path: <SRS0=1210=4J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EC00C35656
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 15:25:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3CF8820679
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 15:25:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729165AbgBUPZ0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Feb 2020 10:25:26 -0500
Received: from foss.arm.com ([217.140.110.172]:41760 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728970AbgBUPZZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Feb 2020 10:25:25 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 205251FB;
        Fri, 21 Feb 2020 07:25:25 -0800 (PST)
Received: from [10.1.196.105] (eglon.cambridge.arm.com [10.1.196.105])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1AB473F703;
        Fri, 21 Feb 2020 07:25:23 -0800 (PST)
Subject: Re: [PATCH v2] x86/resctrl: Preserve CDP enable over cpuhp
To:     Reinette Chatre <reinette.chatre@intel.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Fenghua Yu <fenghua.yu@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>
References: <20200214181600.38779-1-james.morse@arm.com>
 <214c845b-d093-bafc-02d0-dfd810283f1a@intel.com>
From:   James Morse <james.morse@arm.com>
Message-ID: <32c563f9-c645-5c04-ed0b-18b3348c9c7f@arm.com>
Date:   Fri, 21 Feb 2020 15:25:22 +0000
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <214c845b-d093-bafc-02d0-dfd810283f1a@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Reinette,

On 14/02/2020 19:24, Reinette Chatre wrote:
> On 2/14/2020 10:16 AM, James Morse wrote:
>> Resctrl assumes that all CPUs are online when the filesystem is
>> mounted, and that CPUs remember their CDP-enabled state over CPU
>> hotplug.
>>
>> This goes wrong when resctrl's CDP-enabled state changes while all
>> the CPUs in a domain are offline.
>>
>> When a domain comes online, enable (or disable!) CDP to match resctrl's
>> current setting.

>> diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>> index 064e9ef44cd6..5967320a1951 100644
>> --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>> +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>> @@ -1831,6 +1831,9 @@ static int set_cache_qos_cfg(int level, bool enable)
>>  	struct rdt_domain *d;
>>  	int cpu;
>>  
>> +	 /* CDP state is restored during cpuhp, which takes this lock */
>> +	lockdep_assert_held(&rdtgroup_mutex);
>> +
> 
> I think this hunk can be dropped. (1) The code path where this
> annotation is added is not part of this fix. (2) The comment implies
> that the taking of the mutex is something new/unique added in the CPU
> hotplug path but that is not accurate since this mutex is also taken in
> the only other existing call path of this snippet that is handling the
> mounting of the filesystem.

These things answer the question: "what stops rdt_domain_reconfigure_cdp() racing with
set_cache_qos_cfg() on the mount path, causing the wrong value to be restored?".

We can try and answer that in the commit message, or comments, but these will quickly be
lost, stale, or wrong.

These annotations serve as a comment, and let lockdep check its still true.
(I think you can never have enough lockdep annotations!)


> You do mention that these annotations is helpful for the MPAM work.

Indeed, it splits up the, er, "big RDT mutex", these annotations mean lockdep catches me
out if I do something wrong, and makes it very clear when changing something subtle.


> Could the annotations instead be added as a separate patch forming part
> of that work?

Ideally these things are there from the beginning. Adding them over time as part of other
reviewed patches works. I don't think adding them in one go before refactoring helps: you
wouldn't have the confidence that they were correct in the first place.

I'll drop these.


>>  	if (level == RDT_RESOURCE_L3)
>>  		update = l3_qos_cfg_update;
>>  	else if (level == RDT_RESOURCE_L2)
>> @@ -1859,6 +1862,21 @@ static int set_cache_qos_cfg(int level, bool enable)
>>  	return 0;
>>  }
>>  
>> +/* Restore the qos cfg state when a package comes online */
> 
> s/package/domain/? When, for example, considering L2 then "package" is
> not the right term to use.

Sure,


Thanks,

James
