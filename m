Return-Path: <SRS0=8dav=5Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 180D4C2D0EC
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 01:17:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EAB20206A1
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 01:17:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726444AbgDHBRa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Apr 2020 21:17:30 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:12693 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726406AbgDHBR3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Apr 2020 21:17:29 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id CE0E864582508C10A993;
        Wed,  8 Apr 2020 09:17:26 +0800 (CST)
Received: from [127.0.0.1] (10.133.217.205) by DGGEMS401-HUB.china.huawei.com
 (10.3.19.201) with Microsoft SMTP Server id 14.3.487.0; Wed, 8 Apr 2020
 09:17:15 +0800
Subject: Re: Why is text_mutex used in jump_label_transform for x86_64
To:     Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
CC:     <andrew.murray@arm.com>, <bristot@redhat.com>,
        <jakub.kicinski@netronome.com>, Kees Cook <keescook@chromium.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        "Xiexiuqi (Xie XiuQi)" <xiexiuqi@huawei.com>,
        Li Bin <huawei.libin@huawei.com>, <bobo.shaobowang@huawei.com>,
        "chengjian (D)" <cj.chengjian@huawei.com>
References: <f7f686f2-4f28-1763-dd19-43eff6a5a8f2@huawei.com>
 <20200320102709.GC20696@hirez.programming.kicks-ass.net>
 <28edc3d5-83a3-43cb-3e64-7d0525d430f3@huawei.com>
 <20200406091551.GG20730@hirez.programming.kicks-ass.net>
 <20200406141020.GB3178@willie-the-truck>
From:   "chengjian (D)" <cj.chengjian@huawei.com>
Message-ID: <de85ea66-59b6-d86c-e46f-8354c7e894d7@huawei.com>
Date:   Wed, 8 Apr 2020 09:17:15 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200406141020.GB3178@willie-the-truck>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [10.133.217.205]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2020/4/6 22:10, Will Deacon wrote:
> On Mon, Apr 06, 2020 at 11:15:51AM +0200, Peter Zijlstra wrote:
>> On Mon, Apr 06, 2020 at 04:39:11PM +0800, chengjian (D) wrote:
>>> On 2020/3/20 18:27, Peter Zijlstra wrote:
>>>> It depends on the architecture details of how self-modifying code works.
>>>> In particular, x86 is a variable instruction length architecture and
>>>> needs extreme care -- it's implementation requires there only be a
>>>> single text modifier at any one time, hence the use of text_mutex.
>>>>
>>>> ARM64 OTOH is, like most RISC based architectures, a fixed width
>>>> instruction architecture. And in particular it can re-write certain
>>>> (branch) instructions with impunity (see their
>>>> aarch64_insn_patch_text_nosync()). Which is why they don't need
>>>> additional serialization.
>>> Hi, Peter
>>>
>>> Thank you very much for your reply.
>>>
>>> X86 is a variable-length instruction, only one byte modification of the
>>> instruction
>>> can be regarded as atomic. so we must be very careful when modifying
>>> instructions
>>> concurrently.
>> Close enough.
>>
>>> For other architectures such as ARM64, the modification of some instructions
>>> can be
>>> considered atomic, (Eg. nop -> jmp/b). The set of instructions that can be
>>> executed
>>> by one thread of execution as they are being modified by another thread of
>>> execution
>>> without requiring explicit synchronization.
>>>
>>> In ARM64 Architecture Reference Manual, I find that:
>>>      Concurrent modification and execution of instructions can lead to the
>>> resulting instruction performing any behavior
>>>      that can be achieved by executing any sequence of instructions that can
>>> be executed from the same Exception level,
>>>      except where each of the instruction before modification and the
>>> instruction after modification is one of a B, BL, BRK,
>>>      HVC, ISB, NOP, SMC, or SVC instruction.
>>>      For the B, BL, BRK, HVC, ISB, NOP, SMC, and SVC instructions the
>>> architecture guarantees that, after modification of the
>>>      instruction, behavior is consistent with execution of either:
>>>      • The instruction originally fetched.
>>>      • A fetch of the modified instruction
>>>
>>> So we can safely modify jump_label for ARM64(from NOP to b or form b to
>>> NOP).
>>>
>>> Is my understanding correct?
>> I think so; but I'm really not much of an ARM64 person. FWIW I think I
>> remember Will saying the same is true of ARM (32bit) and they could
>> implement the same optimization, but so far nobody has bothered doing
>> so. But please, ask an ARM64 maintainer and don't take my word for this.
> On 32-bit there are complications with Thumb-2 instructions where you can
> have a mixture of 16-bit and 32-bit encodings, so you have to be pretty
> careful there.
>
> For arm64, we have aarch64_insn_patch_text_nosync() which we use to toggle
> jump labels.
>
> Will
>
> .


Hi, Peter and Will

     I have learned.

     I truly appreciate your timely help.


     Thanks a lot.

     -- Cheng Jian


