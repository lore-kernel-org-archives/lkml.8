Return-Path: <SRS0=ne2O=7T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	HK_RANDOM_FROM,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45268C433E0
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Jun 2020 03:02:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1D941206F0
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Jun 2020 03:02:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728549AbgFFDCZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Jun 2020 23:02:25 -0400
Received: from mga14.intel.com ([192.55.52.115]:15561 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728390AbgFFDCY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jun 2020 23:02:24 -0400
IronPort-SDR: KyvzVIMYi4Vqt+/KENsCsMhCdAtarSf8JJykwdgxV8g8GfaiiSY8v5WFV+VTFHykrvvpMYQvCp
 by4W48p3MEfA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2020 20:02:22 -0700
IronPort-SDR: Z9HrgzCzjS5Cz81PKTZSVw9qZ0pyvQCJEvGRPUrnmB4B4p9C/6sIgfVak/Qe0p3cq33NlkV2Zv
 2l5IcKWaom7w==
X-IronPort-AV: E=Sophos;i="5.73,478,1583222400"; 
   d="scan'208";a="446111559"
Received: from xiaoyaol-mobl.ccr.corp.intel.com (HELO [10.249.169.79]) ([10.249.169.79])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2020 20:02:19 -0700
Subject: Re: [PATCH] x86/split_lock: Sanitize userspace and guest error output
To:     Prarit Bhargava <prarit@redhat.com>, linux-kernel@vger.kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        Tony Luck <tony.luck@intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Rahul Tanwar <rahul.tanwar@linux.intel.com>,
        Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>
References: <20200605114459.22200-1-prarit@redhat.com>
 <96b5c5fa-6b4e-a5f4-34cc-682477a27370@intel.com>
 <3e1f1fac-fa46-7a2a-1424-d5c931e521d7@redhat.com>
From:   Xiaoyao Li <xiaoyao.li@intel.com>
Message-ID: <6d8e658b-8ffb-2af7-de94-d01c5fdd5789@intel.com>
Date:   Sat, 6 Jun 2020 11:02:17 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
MIME-Version: 1.0
In-Reply-To: <3e1f1fac-fa46-7a2a-1424-d5c931e521d7@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/6/2020 12:42 AM, Prarit Bhargava wrote:
> 
> 
> On 6/5/20 11:29 AM, Xiaoyao Li wrote:
>> On 6/5/2020 7:44 PM, Prarit Bhargava wrote:
>>> There are two problems with kernel messages in fatal mode that
>>> were found during testing of guests and userspace programs.
>>>
>>> The first is that no kernel message is output when the split lock detector
>>> is triggered with a userspace program.  As a result the userspace process
>>> dies from receiving SIGBUS with no indication to the user of what caused
>>> the process to die.
>>>
>>> The second problem is that only the first triggering guest causes a kernel
>>> message to be output because the message is output with pr_warn_once().
>>> This also results in a loss of information to the user.
>>>
>>> While fixing these I noticed that the same message was being output
>>> three times so I'm cleaning that up too.
>>>
>>> Fix fatal mode output, and use consistent messages for fatal and
>>> warn modes for both userspace and guests.
>>>
>>> Signed-off-by: Prarit Bhargava <prarit@redhat.com>
>>> Cc: Thomas Gleixner <tglx@linutronix.de>
>>> Cc: Ingo Molnar <mingo@redhat.com>
>>> Cc: Borislav Petkov <bp@alien8.de>
>>> Cc: x86@kernel.org
>>> Cc: "H. Peter Anvin" <hpa@zytor.com>
>>> Cc: Tony Luck <tony.luck@intel.com>
>>> Cc: "Peter Zijlstra (Intel)" <peterz@infradead.org>
>>> Cc: Sean Christopherson <sean.j.christopherson@intel.com>
>>> Cc: Rahul Tanwar <rahul.tanwar@linux.intel.com>
>>> Cc: Xiaoyao Li <xiaoyao.li@intel.com>
>>> Cc: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
>>> Cc: Dave Hansen <dave.hansen@linux.intel.com>
>>> ---
>>>    arch/x86/kernel/cpu/intel.c | 24 ++++++++++--------------
>>>    1 file changed, 10 insertions(+), 14 deletions(-)
>>>
>>> diff --git a/arch/x86/kernel/cpu/intel.c b/arch/x86/kernel/cpu/intel.c
>>> index 166d7c355896..463022aa9b7a 100644
>>> --- a/arch/x86/kernel/cpu/intel.c
>>> +++ b/arch/x86/kernel/cpu/intel.c
>>> @@ -1074,10 +1074,14 @@ static void split_lock_init(void)
>>>        split_lock_verify_msr(sld_state != sld_off);
>>>    }
>>>    -static void split_lock_warn(unsigned long ip)
>>> +static bool split_lock_warn(unsigned long ip, int fatal)
>>>    {
>>> -    pr_warn_ratelimited("#AC: %s/%d took a split_lock trap at address: 0x%lx\n",
>>> -                current->comm, current->pid, ip);
>>> +    pr_warn_ratelimited("#AC: %s/%d %ssplit_lock trap at address: 0x%lx\n",
>>> +                current->comm, current->pid,
>>> +                sld_state == sld_fatal ? "fatal " : "", ip);
>>> +
>>> +    if (sld_state == sld_fatal || fatal)
>>> +        return false;
>>>          /*
>>>         * Disable the split lock detection for this task so it can make
>>> @@ -1086,18 +1090,13 @@ static void split_lock_warn(unsigned long ip)
>>>         */
>>>        sld_update_msr(false);
>>>        set_tsk_thread_flag(current, TIF_SLD);
>>> +    return true;
>>>    }
>>>      bool handle_guest_split_lock(unsigned long ip)
>>>    {
>>> -    if (sld_state == sld_warn) {
>>> -        split_lock_warn(ip);
>>> +    if (split_lock_warn(ip, 0))
>>>            return true;
>>> -    }
>>> -
>>> -    pr_warn_once("#AC: %s/%d %s split_lock trap at address: 0x%lx\n",
>>> -             current->comm, current->pid,
>>> -             sld_state == sld_fatal ? "fatal" : "bogus", ip);
>>>          current->thread.error_code = 0;
>>>        current->thread.trap_nr = X86_TRAP_AC;
>>> @@ -1108,10 +1107,7 @@ EXPORT_SYMBOL_GPL(handle_guest_split_lock);
>>>      bool handle_user_split_lock(struct pt_regs *regs, long error_code)
>>>    {
>>> -    if ((regs->flags & X86_EFLAGS_AC) || sld_state == sld_fatal)
>>> -        return false;
>>> -    split_lock_warn(regs->ip);
>>> -    return true;
>>> +    return split_lock_warn(regs->ip, regs->flags & X86_EFLAGS_AC);
>>
>> It's incorrect. You change the behavior that it will print the split lock
>> warning even when CPL 3 Alignment Check is turned on.
> 
> Do you want the message to be displayed in the fatal case of CPL 3 Alignment check?
> 

No. It should never be displayed if #AC happens in CPL 3 and 
X86_EFLAGS_AC is set. In this case, an unaligned access triggers #AC 
regardless of #LOCK prefix. What's more, even there is a #LOCK prefix, 
we still cannot tell the cause because we don't know the priority of 
legacy alignment check #AC and split lock #AC.

If you do want a message, we can only say "unaligned access at address xxx".

