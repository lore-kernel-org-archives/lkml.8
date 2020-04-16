Return-Path: <SRS0=1dCa=6A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7580DC2BA2B
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 07:02:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5E1FE20787
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 07:02:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437553AbgDPHCA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Apr 2020 03:02:00 -0400
Received: from mga06.intel.com ([134.134.136.31]:47887 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2436624AbgDPHB4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 03:01:56 -0400
IronPort-SDR: Cf/ZWQB1NbiFBk8Ls5UO4dmS88HY4EUItmbn5FJglP2+G42bTlKLXweztmWTiJLfPB7Af/uOaO
 aSZV1Y4oyNGw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2020 00:01:53 -0700
IronPort-SDR: k/yOcRMuFyGyqEZZ2PfMRX65AImLqtwCpR3s3MdXAyaLGY25O9FqZsrOC3b/+ZrkqCTZzoTYju
 5I+9mdKSZJOg==
X-IronPort-AV: E=Sophos;i="5.72,390,1580803200"; 
   d="scan'208";a="257119822"
Received: from likexu-mobl1.ccr.corp.intel.com (HELO [10.238.4.236]) ([10.238.4.236])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2020 00:01:52 -0700
Subject: Re: [PATCH] x86, smpboot: Disable frequency invariance when it's
 unsupported
To:     Giovanni Gherdovich <ggherdovich@suse.cz>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Doug Smythies <dsmythies@telus.net>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        LKML <linux-kernel@vger.kernel.org>
References: <20200416020700.167294-1-like.xu@linux.intel.com>
 <1587017284.32139.20.camel@suse.cz>
From:   Like Xu <like.xu@linux.intel.com>
Organization: Intel OTC
Message-ID: <bf43772d-48e5-01d4-dd03-330110e487fa@linux.intel.com>
Date:   Thu, 16 Apr 2020 15:01:49 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <1587017284.32139.20.camel@suse.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020/4/16 14:08, Giovanni Gherdovich wrote:
> On Thu, 2020-04-16 at 10:12 +0800, Like Xu wrote:
>> On the Intel SNR processors such as "Intel Atom(R) C6562", the
>> turbo_freq for 4C turbo may be zero which causes a divide by zero
>> exception and blocks the boot process when arch_scale_freq_tick().
>>
>> When one of the preset base_freq or turbo_freq is meaningless,
>> we may disable frequency invariance.
>>
>> Fixes: 1567c3e3467c ("x86, sched: Add support for frequency invariance")
>> Signed-off-by: Like Xu <like.xu@linux.intel.com>
>> ---
>>   arch/x86/kernel/smpboot.c | 3 +++
>>   1 file changed, 3 insertions(+)
>>
>> diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
>> index fe3ab9632f3b..741367ce4d14 100644
>> --- a/arch/x86/kernel/smpboot.c
>> +++ b/arch/x86/kernel/smpboot.c
>> @@ -1958,6 +1958,9 @@ static bool core_set_max_freq_ratio(u64 *base_freq, u64 *turbo_freq)
>>   	*base_freq = (*base_freq >> 8) & 0xFF;      /* max P state */
>>   	*turbo_freq = (*turbo_freq >> 24) & 0xFF;   /* 4C turbo    */
>>   
>> +	if (*turbo_freq == 0 || *base_freq == 0)
>> +		return false;
>> +
>>   	return true;
>>   }
>>
> 
> Hello Like Xu,
> 
> thanks for reporting this and for the patch. My preferred solution for when
> the 4 cores turbo freq is detected as zero would be to look for the 1 core turbo
> frequency, as we're likely on a machine with less than 4 cores. Is that the
> case on your Atom C6562? I couldn't find it on ark.intel.com.

The Atom C6562 is "24 cores" based on 
https://www.intel.com/content/dam/www/public/us/en/documents/product-briefs/atom-p5900-product-brief.pdf

#define MSR_PLATFORM_INFO		0x000000ce

the value for this msr is 80820f9801600

#define MSR_TURBO_RATIO_LIMIT		0x000001ad

the value for this msr is 16

I know you didn't test your feature on this platform,
but combinations of other various values ​​are also possible
(unless it's made clear in the specification).

> 
> As per why I'd like to go with 1 core turbo instead of bailing out of freq
> invariance entirely, I've left a comment in the openSUSE bugzilla with some
> details: https://bugzilla.opensuse.org/show_bug.cgi?id=1166664#c35

> The relevant part is:
> 
> :: The fix in this case is to take the 1 core turbo as normalizing factor. The
> :: other choice would be to use the base frequency (no turbo at all), but using
> :: base freq for normalization means that the ratio becomes current_freq / base_freq
> :: which is an over-estimation, which leads the frequency governor to think the
> :: CPU is more loaded than it really is and raise the frequency a bit too
> :: aggressively. This is tolerable in performance-oriented servers but
> :: inappropriate on small machines with 2 cores."
> 
> Regarding base_freq being reported as zero, you're right, that can happen too
> and we've seen it in hypervisors.
> 
> I've just sent fixes for these two problems here:
> https://lore.kernel.org/lkml/20200416054745.740-1-ggherdovich@suse.cz/

Hence the "less than 4 cores" comment is weird for C6562
but the use of "1C turbo" looks good to me.

Thanks,
Like Xu

> 
> 
> Thanks,
> Giovanni Gherdovich
> 

