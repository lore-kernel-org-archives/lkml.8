Return-Path: <SRS0=Zj89=5W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9096C2BA19
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 08:39:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BFBF1206F5
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 08:39:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726638AbgDFIjk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Apr 2020 04:39:40 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:48264 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726533AbgDFIjk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Apr 2020 04:39:40 -0400
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 6516BEF633551400EA25;
        Mon,  6 Apr 2020 16:39:20 +0800 (CST)
Received: from [127.0.0.1] (10.133.217.205) by DGGEMS409-HUB.china.huawei.com
 (10.3.19.209) with Microsoft SMTP Server id 14.3.487.0; Mon, 6 Apr 2020
 16:39:12 +0800
Subject: Re: Why is text_mutex used in jump_label_transform for x86_64
To:     Peter Zijlstra <peterz@infradead.org>
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
From:   "chengjian (D)" <cj.chengjian@huawei.com>
Message-ID: <28edc3d5-83a3-43cb-3e64-7d0525d430f3@huawei.com>
Date:   Mon, 6 Apr 2020 16:39:11 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200320102709.GC20696@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [10.133.217.205]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2020/3/20 18:27, Peter Zijlstra wrote:
> It depends on the architecture details of how self-modifying code works.
> In particular, x86 is a variable instruction length architecture and
> needs extreme care -- it's implementation requires there only be a
> single text modifier at any one time, hence the use of text_mutex.
>
> ARM64 OTOH is, like most RISC based architectures, a fixed width
> instruction architecture. And in particular it can re-write certain
> (branch) instructions with impunity (see their
> aarch64_insn_patch_text_nosync()). Which is why they don't need
> additional serialization.

Hi, Peter

Thank you very much for your reply.

X86 is a variable-length instruction, only one byte modification of the 
instruction
can be regarded as atomic. so we must be very careful when modifying 
instructions
concurrently.

For other architectures such as ARM64, the modification of some 
instructions can be
considered atomic, (Eg. nop -> jmp/b). The set of instructions that can 
be executed
by one thread of execution as they are being modified by another thread 
of execution
without requiring explicit synchronization.

In ARM64 Architecture Reference Manual, I find that:
     Concurrent modification and execution of instructions can lead to 
the resulting instruction performing any behavior
     that can be achieved by executing any sequence of instructions that 
can be executed from the same Exception level,
     except where each of the instruction before modification and the 
instruction after modification is one of a B, BL, BRK,
     HVC, ISB, NOP, SMC, or SVC instruction.
     For the B, BL, BRK, HVC, ISB, NOP, SMC, and SVC instructions the 
architecture guarantees that, after modification of the
     instruction, behavior is consistent with execution of either:
     • The instruction originally fetched.
     • A fetch of the modified instruction

So we can safely modify jump_label for ARM64(from NOP to b or form b to 
NOP).

Is my understanding correct?



Thank You

     -- Cheng Jian


