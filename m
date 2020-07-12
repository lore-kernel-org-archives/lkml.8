Return-Path: <SRS0=5Khs=AX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC0ADC433E0
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Jul 2020 06:28:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A69DC2064B
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Jul 2020 06:28:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728256AbgGLG2F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 12 Jul 2020 02:28:05 -0400
Received: from mga04.intel.com ([192.55.52.120]:2580 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727777AbgGLG2F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Jul 2020 02:28:05 -0400
IronPort-SDR: HFRbNzhrP6KBOK52Qo95GGT2hMIts0V5EkmVz6af6eU51o7k4lxICVynkuhy5wInu/x7jGjFPl
 +AdR2Im9N3Sg==
X-IronPort-AV: E=McAfee;i="6000,8403,9679"; a="145961691"
X-IronPort-AV: E=Sophos;i="5.75,342,1589266800"; 
   d="scan'208";a="145961691"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2020 23:28:04 -0700
IronPort-SDR: jta/V1Sug1pMVA1ET3+5ROYvLrxcNCtmfOK63Rq6vuxcaM/qA7wphpSOhaOx16Y/djzJ2x3AEG
 YPfwgWyZe68Q==
X-IronPort-AV: E=Sophos;i="5.75,342,1589266800"; 
   d="scan'208";a="323935304"
Received: from kaiguo-mobl.ccr.corp.intel.com (HELO [10.255.29.88]) ([10.255.29.88])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2020 23:28:02 -0700
Subject: Re: kvm crash on 5.7-rc1 and later
To:     Peter Zijlstra <peterz@infradead.org>,
        Woody Suwalski <terraluna977@gmail.com>
Cc:     pbonzini@redhat.com, LKML <linux-kernel@vger.kernel.org>,
        fenghua.yu@intel.com, Thomas Gleixner <tglx@linutronix.de>,
        Sean Christopherson <sean.j.christopherson@intel.com>
References: <9178ae3e-db32-c64b-7caf-737f3bc3ba8e@gmail.com>
 <20200711182158.GF597537@hirez.programming.kicks-ass.net>
From:   Xiaoyao Li <xiaoyao.li@intel.com>
Message-ID: <b1d4e747-0c6d-b9f8-d795-1f4ed9e2420b@intel.com>
Date:   Sun, 12 Jul 2020 14:27:59 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200711182158.GF597537@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/12/2020 2:21 AM, Peter Zijlstra wrote:
> On Fri, Jul 03, 2020 at 11:15:31AM -0400, Woody Suwalski wrote:
>> I am observing a 100% reproducible kvm crash on kernels starting with
>> 5.7-rc1, always with the same opcode 0000.
>> It happens during wake up from the host suspended state. Worked OK on 5.6
>> and older.
>> The host is based on Debian testing, Thinkpad T440, i5 cpu.
>>
>> [   61.576664] kernel BUG at arch/x86/kvm/x86.c:387!
>> [   61.576672] invalid opcode: 0000 [#1] PREEMPT SMP NOPTI
>> [   61.576678] CPU: 0 PID: 3851 Comm: qemu-system-x86 Not tainted 5.7-pingu
>> #0
>> [   61.576680] Hardware name: LENOVO 20B6005JUS/20B6005JUS, BIOS GJETA4WW
>> (2.54 ) 03/27/2020
>> [   61.576700] RIP: 0010:kvm_spurious_fault+0xa/0x10 [kvm]
>>
>> Crash results in a dead kvm and occasionally a very unstable system.
>>
>> Bisecting the problem between v5.6 and v5.7-rc1 points to
>>
>> commit 6650cdd9a8ccf00555dbbe743d58541ad8feb6a7
>> Author: Peter Zijlstra (Intel) <peterz@infradead.org>
>> Date:   Sun Jan 26 12:05:35 2020 -0800
>>
>>      x86/split_lock: Enable split lock detection by kernel
>>
>> Reversing that patch seems to actually "cure" the issue.
>>
>> The problem is present in all kernels past 5.7-rc1, however the patch is not
>> reversing directly in later source trees, so can not retest the logic on
>> recent kernels.
>>
>> Peter, would you have idea how to debug that (or even better - would you
>> happen to know the fix)?
>>
>> I have attached dmesg logs from a "good" 5.6.9 kernel, and then "bad" 5.7.0
>> and 5.8-rc3
> 
> I have no clue about kvm. Nor do I actually have hardware with SLD on.
> I've Cc'ed a bunch of folks who might have more ideas.
> 

I think this bug is the same as the one found by Sean, and is already 
fixed in 5.8-rc4.

https://lore.kernel.org/kvm/20200605192605.7439-1-sean.j.christopherson@intel.com/
