Return-Path: <SRS0=iZC5=5S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96D72C43331
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 21:19:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D89A20737
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 21:19:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389346AbgDBVTL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Apr 2020 17:19:11 -0400
Received: from mga01.intel.com ([192.55.52.88]:49032 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732970AbgDBVTL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Apr 2020 17:19:11 -0400
IronPort-SDR: iGyh8JElyw2af+Xe3jBy2BLkISCB3p9knontwnd6oCgqYZ8QWmh+8lSAjk05XRf2wQxs0UOpOn
 eFKhfHXjz6bQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2020 14:19:10 -0700
IronPort-SDR: ElJsfs2xsoC8GvmhzJDVLvxw+RK8t6eHJy2WYVJoZ3H8QS+d0UpDaVMMYn4f+dt4T7K65KWjMx
 UX3888N5RLow==
X-IronPort-AV: E=Sophos;i="5.72,336,1580803200"; 
   d="scan'208";a="396509021"
Received: from rchatre-mobl.amr.corp.intel.com (HELO [10.251.27.29]) ([10.251.27.29])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2020 14:19:09 -0700
Subject: Re: [PATCH 2/2] x86/resctrl: Use appropriate API for strings
 terminated by newline
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     tglx@linutronix.de, fenghua.yu@intel.com, bp@alien8.de,
        tony.luck@intel.com, kuo-lang.tseng@intel.com, mingo@redhat.com,
        babu.moger@amd.com, hpa@zytor.com, x86@kernel.org,
        linux-kernel@vger.kernel.org
References: <cover.1585765499.git.reinette.chatre@intel.com>
 <2a51c327497738ad7012e4f185046c530dba4594.1585765499.git.reinette.chatre@intel.com>
 <20200402130625.GA1922688@smile.fi.intel.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
Message-ID: <720ab442-3e2e-bd6d-d35c-5cc5de1d9824@intel.com>
Date:   Thu, 2 Apr 2020 14:19:07 -0700
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200402130625.GA1922688@smile.fi.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andy,

(Your two responses have been merged)

On 4/2/2020 6:06 AM, Andy Shevchenko wrote:
> On Wed, Apr 01, 2020 at 11:30:48AM -0700, Reinette Chatre wrote:
>> The user input to files in the resctrl filesystem are expected to be
>> terminated with a newline. Testing the user input includes a test for
>> the presence of a newline and then replacing the newline with NUL
>> byte followed by comparison using strcmp().
>>
>> sysfs_streq() exists to test if strings are equal, treating both NUL and
>> newline-then-NUL as equivalent string terminations. Even more,
>> sysfs_match_string() exists to match a given string in an array using
>> sysfs_streq().
>>
>> Replace existing strcmp() comparisons of strings that are terminated
>> with a newline with more appropriate sysfs_streq() via the
>> sysfs_match_string() API that can perform the match across the different
>> mode strings that are already maintained in an array.
>>
>> Suggested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>> Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>
>> ---
>>  arch/x86/kernel/cpu/resctrl/rdtgroup.c | 25 +++++++++++++------------
>>  1 file changed, 13 insertions(+), 12 deletions(-)
>>
>> diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>> index fbee891a7d6e..623e33c0a290 100644
>> --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>> +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>> @@ -1412,11 +1412,11 @@ static ssize_t rdtgroup_mode_write(struct kernfs_open_file *of,
>>  	struct rdtgroup *rdtgrp;
>>  	enum rdtgrp_mode mode;
>>  	int ret = 0;
>> +	int user_m;
>>  

>
> ...and forgot to mention this...
>
> 	int user_m;
> 	int ret;
>

> 
>>  	/* Valid input requires a trailing newline */
>>  	if (nbytes == 0 || buf[nbytes - 1] != '\n')
>>  		return -EINVAL;
>> -	buf[nbytes - 1] = '\0';
> 
> The above test is not needed and comment now is misleading.
> WRT nbytes I believe that kernel fs code checks for that.

If nbytes is 0 it is still passed to this function. You are correct that
those tests are not needed though (if nbytes is 0 then
sysfs_match_string() will not find a match and return EINVAL via that path).

Thank you for catching this. I'll remove those unnecessary checks.

> 
>>  	rdtgrp = rdtgroup_kn_lock_live(of->kn);
>>  	if (!rdtgrp) {
>> @@ -1428,11 +1428,15 @@ static ssize_t rdtgroup_mode_write(struct kernfs_open_file *of,
>>  
>>  	mode = rdtgrp->mode;
>>  
>> -	if ((!strcmp(buf, "shareable") && mode == RDT_MODE_SHAREABLE) ||
>> -	    (!strcmp(buf, "exclusive") && mode == RDT_MODE_EXCLUSIVE) ||
>> -	    (!strcmp(buf, "pseudo-locksetup") &&
>> -	     mode == RDT_MODE_PSEUDO_LOCKSETUP) ||
>> -	    (!strcmp(buf, "pseudo-locked") && mode == RDT_MODE_PSEUDO_LOCKED))
>> +	user_m = sysfs_match_string(rdt_mode_str, buf);
>> +	if (user_m < 0) {
>> +		rdt_last_cmd_puts("Unknown or unsupported mode\n");
>> +		ret = user_m;
>> +		goto out;
>> +	}
> 
> You can do it the way
> 
> 	ret = sysfs_match_string(...);
> 	if (ret < 0) {
> 		...
> 	}
> 	user_m = ret;
>
> ...and this changes
>
> 	ret = 0;
>
> 

ok, I'll do it this way in the next version.

Thank you

Reinette

