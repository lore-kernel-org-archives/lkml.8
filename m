Return-Path: <SRS0=wYIT=CC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A6F8C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 16:28:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 54DD9214F1
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 16:28:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726631AbgHXQ2L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Aug 2020 12:28:11 -0400
Received: from mx2.suse.de ([195.135.220.15]:47036 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727896AbgHXQ1z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Aug 2020 12:27:55 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 31DDFAF76;
        Mon, 24 Aug 2020 16:28:17 +0000 (UTC)
Subject: Re: [PATCH] x86/entry: Fix AC assertion
To:     Andrew Cooper <andrew.cooper3@citrix.com>, peterz@infradead.org
Cc:     x86@kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Andy Lutomirski <luto@kernel.org>
References: <20200824101428.GS1362448@hirez.programming.kicks-ass.net>
 <d2b0c6a5-19d8-f868-e092-e5c197ab0d0e@citrix.com>
 <20200824152135.GV1362448@hirez.programming.kicks-ass.net>
 <a79f11e4-2b9f-ea8d-a032-dee84a500f73@citrix.com>
From:   =?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>
Message-ID: <f2929b26-5321-a0cb-49af-778842ba1f82@suse.com>
Date:   Mon, 24 Aug 2020 18:27:46 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <a79f11e4-2b9f-ea8d-a032-dee84a500f73@citrix.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24.08.20 17:58, Andrew Cooper wrote:
> On 24/08/2020 16:21, peterz@infradead.org wrote:
>> On Mon, Aug 24, 2020 at 03:22:06PM +0100, Andrew Cooper wrote:
>>> On 24/08/2020 11:14, peterz@infradead.org wrote:
>>>> The WARN added in commit 3c73b81a9164 ("x86/entry, selftests: Further
>>>> improve user entry sanity checks") unconditionally triggers on my IVB
>>>> machine because it does not support SMAP.
>>>>
>>>> For !SMAP hardware we patch out CLAC/STAC instructions and thus if
>>>> userspace sets AC, we'll still have it set after entry.
>>> Technically, you don't patch in, rather than patch out.
>> True.
>>
>>>> Fixes: 3c73b81a9164 ("x86/entry, selftests: Further improve user entry sanity checks")
>>>> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
>>>> Acked-by: Andy Lutomirski <luto@kernel.org>
>>>> ---
>>>>   arch/x86/include/asm/entry-common.h |   11 +++++++++--
>>>>   1 file changed, 9 insertions(+), 2 deletions(-)
>>>>
>>>> --- a/arch/x86/include/asm/entry-common.h
>>>> +++ b/arch/x86/include/asm/entry-common.h
>>>> @@ -18,8 +18,15 @@ static __always_inline void arch_check_u
>>>>   		 * state, not the interrupt state as imagined by Xen.
>>>>   		 */
>>>>   		unsigned long flags = native_save_fl();
>>>> -		WARN_ON_ONCE(flags & (X86_EFLAGS_AC | X86_EFLAGS_DF |
>>>> -				      X86_EFLAGS_NT));
>>>> +		unsigned long mask = X86_EFLAGS_DF | X86_EFLAGS_NT;
>>>> +
>>>> +		/*
>>>> +		 * For !SMAP hardware we patch out CLAC on entry.
>>>> +		 */
>>>> +		if (boot_cpu_has(X86_FEATURE_SMAP))
>>>> +			mask |= X86_EFLAGS_AC;
>>> The Xen PV ABI clears AC on entry for 64bit guests, because Linux is
>>> actually running in Ring 3, and therefore susceptible to #AC's which
>>> wouldn't occur natively.
>> So do you then want it to be something like:
>>
>> 	if (boot_cpu_has(X86_FEATURE_SMAP) ||
>> 	    (IS_ENABLED(CONFIG_64_BIT) && boot_cpu_has(X86_FEATURE_XENPV)))
>>
>> ? Or are you fine with the proposed?
> 
> Dealers choice, but this option would be slightly better overall.
> 
> (Are there any other cases where Linux will be running in Ring 3?  I
> haven't been paying attention to recent changes in PVOps.)

I'm not aware of any other case running kernel code in ring 3.


Juergen
