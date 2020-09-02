Return-Path: <SRS0=728o=CL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A977C433E2
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 16:24:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 83BB72072A
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 16:24:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727824AbgIBQYb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Sep 2020 12:24:31 -0400
Received: from mx2.suse.de ([195.135.220.15]:49004 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726310AbgIBQYa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Sep 2020 12:24:30 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id BD49CAD03;
        Wed,  2 Sep 2020 16:24:29 +0000 (UTC)
Subject: Re: [PATCH 01/13] x86/entry: Fix AC assertion
To:     Brian Gerst <brgerst@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     the arch/x86 maintainers <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Kyle Huey <me@kylehuey.com>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        Robert O'Callahan <rocallahan@gmail.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Andy Lutomirski <luto@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Andrew Cooper <Andrew.Cooper3@citrix.com>
References: <20200902132549.496605622@infradead.org>
 <20200902133200.666781610@infradead.org>
 <CAMzpN2i9C5Sj-M0b9Y7VtOphDJs2Z9NPux9Dg347PSeNBaXRMQ@mail.gmail.com>
From:   =?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>
Message-ID: <c6915915-1c94-70cf-453d-861a4ca2da4c@suse.com>
Date:   Wed, 2 Sep 2020 18:24:27 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <CAMzpN2i9C5Sj-M0b9Y7VtOphDJs2Z9NPux9Dg347PSeNBaXRMQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02.09.20 17:58, Brian Gerst wrote:
> On Wed, Sep 2, 2020 at 9:38 AM Peter Zijlstra <peterz@infradead.org> wrote:
>>
>> From: Peter Zijlstra <peterz@infradead.org>
>>
>> The WARN added in commit 3c73b81a9164 ("x86/entry, selftests: Further
>> improve user entry sanity checks") unconditionally triggers on my IVB
>> machine because it does not support SMAP.
>>
>> For !SMAP hardware we patch out CLAC/STAC instructions and thus if
>> userspace sets AC, we'll still have it set after entry.
>>
>> Fixes: 3c73b81a9164 ("x86/entry, selftests: Further improve user entry sanity checks")
>> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
>> Acked-by: Andy Lutomirski <luto@kernel.org>
>> ---
>>   arch/x86/include/asm/entry-common.h |   11 +++++++++--
>>   1 file changed, 9 insertions(+), 2 deletions(-)
>>
>> --- a/arch/x86/include/asm/entry-common.h
>> +++ b/arch/x86/include/asm/entry-common.h
>> @@ -18,8 +18,16 @@ static __always_inline void arch_check_u
>>                   * state, not the interrupt state as imagined by Xen.
>>                   */
>>                  unsigned long flags = native_save_fl();
>> -               WARN_ON_ONCE(flags & (X86_EFLAGS_AC | X86_EFLAGS_DF |
>> -                                     X86_EFLAGS_NT));
>> +               unsigned long mask = X86_EFLAGS_DF | X86_EFLAGS_NT;
>> +
>> +               /*
>> +                * For !SMAP hardware we patch out CLAC on entry.
>> +                */
>> +               if (boot_cpu_has(X86_FEATURE_SMAP) ||
>> +                   (IS_ENABLED(CONFIG_64_BIT) && boot_cpu_has(X86_FEATURE_XENPV)))
>> +                       mask |= X86_EFLAGS_AC;
> 
> Is the explicit Xen check necessary?  IIRC the Xen hypervisor will
> filter out the SMAP bit in the cpuid pvop.

Right, and this test will nevertheless result in setting AC in the mask.
IIRC this was the main objective here.


Juergen

