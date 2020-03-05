Return-Path: <SRS0=j27y=4W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E461C3F2D2
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 17:04:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D57EF20870
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 17:04:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="FiF59DD7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726184AbgCEREN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Mar 2020 12:04:13 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:35008 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725944AbgCEREN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Mar 2020 12:04:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description;
        bh=vF3Qg1jYVPL0fMpAIJJ4hQLf8PLL9mugK11wImvRR4I=; b=FiF59DD7vx7aBlltd/4aw7x57/
        GaZd9usctGv0IU3Gl089qW9i9VcxMvq97k5+zt7P+tTeB0UTg3pyvjtMTKVaa6HVDvI8GwzqU2S13
        F1zzzkUHDo3n7j9zwXeZiJuSLU8RpMJCgIqqxUq3S5XUTuMz1SiMXsf6DAop0haWe7IgS42lp0V4D
        1ZyjHXa2tZWiSiN2mTNPkmPsmRPBqyj7mPDQR0wUJpoKsUdozDTNoTGxj09l/y5T9j+Xy6TlsjhMQ
        6NYn2Xy/k+vUzXzlyvbY7B46PWRy4tJqSUrerDFCyCe5DT6FUBa/8hJ0VyeJ2X5J+ni31FKBGWdCQ
        mWI35ZAw==;
Received: from [2601:1c0:6280:3f0:897c:6038:c71d:ecac]
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j9tuq-0007DD-EB; Thu, 05 Mar 2020 17:04:08 +0000
Subject: Re: mmotm 2020-03-03-22-28 uploaded (warning: objtool:)
To:     Peter Zijlstra <peterz@infradead.org>,
        Walter Wu <walter-zh.wu@mediatek.com>
Cc:     akpm@linux-foundation.org, broonie@kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-next@vger.kernel.org, mhocko@suse.cz,
        mm-commits@vger.kernel.org, sfr@canb.auug.org.au,
        Josh Poimboeuf <jpoimboe@redhat.com>, dvyukov@google.com
References: <20200304062843.9yA6NunM5%akpm@linux-foundation.org>
 <cd1c6bd2-3db3-0058-f3b4-36b2221544a0@infradead.org>
 <20200305081717.GT2596@hirez.programming.kicks-ass.net>
 <20200305081842.GB2619@hirez.programming.kicks-ass.net>
 <1583399782.17146.14.camel@mtksdccf07>
 <20200305095436.GV2596@hirez.programming.kicks-ass.net>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <eb96f240-63ba-c1b1-7696-07ace3ffe13b@infradead.org>
Date:   Thu, 5 Mar 2020 09:04:07 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200305095436.GV2596@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/5/20 1:54 AM, Peter Zijlstra wrote:
> On Thu, Mar 05, 2020 at 05:16:22PM +0800, Walter Wu wrote:
>> On Thu, 2020-03-05 at 09:18 +0100, Peter Zijlstra wrote:
>>> On Thu, Mar 05, 2020 at 09:17:17AM +0100, Peter Zijlstra wrote:
>>>> On Wed, Mar 04, 2020 at 09:34:49AM -0800, Randy Dunlap wrote:
>>>
>>>>> mm/kasan/common.o: warning: objtool: kasan_report()+0x13: call to report_enabled() with UACCESS enabled
>>>>
>>>> I used next/master instead, and found the below broken commit
>>>> responsible for this.

Yes, I see that same warning in linux-next of 20200305.

>>>> @@ -634,12 +637,20 @@ void kasan_free_shadow(const struct vm_struct *vm)
>>>>  #endif
>>>>  
>>>>  extern void __kasan_report(unsigned long addr, size_t size, bool is_write, unsigned long ip);
>>>> +extern bool report_enabled(void);
>>>>  
>>>> -void kasan_report(unsigned long addr, size_t size, bool is_write, unsigned long ip)
>>>> +bool kasan_report(unsigned long addr, size_t size, bool is_write, unsigned long ip)
>>>>  {
>>>> -	unsigned long flags = user_access_save();
>>>> +	unsigned long flags;
>>>> +
>>>> +	if (likely(!report_enabled()))
>>>> +		return false;
>>>
>>> This adds an explicit call before the user_access_save() and that is a
>>> straight on bug.
>>>
>> Hi Peter,
>>
>> Thanks for your help. Unfortunately, I don't reproduce it in our
>> environment, so I have asked Stephen, if I can reproduce it, then we
>> will send new patch.
> 
> The patch is trivial; and all you need is an x86_64 (cross) compiler to
> reproduce.
> 
> 
> diff --git a/mm/kasan/common.c b/mm/kasan/common.c
> index ad2dc0c9cc17..2906358e42f0 100644
> --- a/mm/kasan/common.c
> +++ b/mm/kasan/common.c
> @@ -618,16 +618,17 @@ extern bool report_enabled(void);
>  
>  bool kasan_report(unsigned long addr, size_t size, bool is_write, unsigned long ip)
>  {
> -	unsigned long flags;
> +	unsigned long flags = user_access_save();
> +	bool ret = false;
>  
> -	if (likely(!report_enabled()))
> -		return false;
> +	if (likely(report_enabled())) {
> +		__kasan_report(addr, size, is_write, ip);
> +		ret = true;
> +	}
>  
> -	flags = user_access_save();
> -	__kasan_report(addr, size, is_write, ip);
>  	user_access_restore(flags);
>  
> -	return true;
> +	return ret;
>  }
>  
>  #ifdef CONFIG_MEMORY_HOTPLUG
> 

and that fixes the warning.  Thanks.

Acked-by: Randy Dunlap <rdunlap@infradead.org> # build-tested

-- 
~Randy
