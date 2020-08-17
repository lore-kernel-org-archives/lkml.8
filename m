Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 056C7C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 05:31:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D63A4206FA
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 05:31:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726476AbgHQFb5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 01:31:57 -0400
Received: from out30-44.freemail.mail.aliyun.com ([115.124.30.44]:49324 "EHLO
        out30-44.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726267AbgHQFb4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 01:31:56 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R621e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04394;MF=laijs@linux.alibaba.com;NM=1;PH=DS;RN=13;SR=0;TI=SMTPD_---0U5xbPkm_1597642278;
Received: from C02XQCBJJG5H.local(mailfrom:laijs@linux.alibaba.com fp:SMTPD_---0U5xbPkm_1597642278)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 17 Aug 2020 13:31:46 +0800
Subject: Re: [PATCH V3 0/3] x86/entry: simply stack switching when exception
 on userspace
To:     Lai Jiangshan <jiangshanlai@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Jann Horn <jannh@google.com>,
        Dave Hansen <dave.hansen@linux.intel.com>
References: <CALCETrWx66qLc-NiwKS_Zu=BP8JDTzfeUO7A2vDd01kXNmiNiA@mail.gmail.com>
 <20200817062355.2884-1-jiangshanlai@gmail.com>
From:   Lai Jiangshan <laijs@linux.alibaba.com>
Message-ID: <879c4480-9629-9a9c-ce93-f72118f068db@linux.alibaba.com>
Date:   Mon, 17 Aug 2020 13:31:18 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200817062355.2884-1-jiangshanlai@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Deeply sorry, the cover-letter was forgotten to send to LKML.

Here it is:

On 2020/8/17 14:23, Lai Jiangshan wrote:
> From: Lai Jiangshan <laijs@linux.alibaba.com>
> 
> 7f2590a110b8("x86/entry/64: Use a per-CPU trampoline stack for IDT entries")
> has resulted that when exception on userspace, the kernel (error_entry)
> always push the pt_regs to entry stack(sp0), and then copy them to the
> kernel stack.
> 
> And recent x86/entry work makes interrupt also use idtentry
> and makes all the interrupt code save the pt_regs on the sp0 stack
> and then copy it to the thread stack like exception.
> 
> This is hot path (page fault, ipi), such overhead should be avoided.
> And the original interrupt_entry directly switches to kernel stack
> and pushes pt_regs to kernel stack. We should do it for error_entry.
> This is the job of patch1.
> 
> Patch 2-3 simplify stack switching for .Lerror_bad_iret by just doing
> all the work in one function (fixup_bad_iret()).
> 
> The patch set is based on v5.9-rc1
> 
> Changed from V1:
> 	based on tip/master -> based on tip/x86/entry
> 
> 	patch 1 replaces the patch1,2 of V1, it borrows the
> 	original interrupt_entry's code into error_entry.
> 
> 	patch2-4 is V1's patch3-5, unchanged (but rebased)
> 
> Changed from V2:
> 	(re-)based on v5.9-rc1
> 	drop the patch4 of V2 patchset
> 
> Cc: Andy Lutomirski <luto@kernel.org>,
> Cc: Thomas Gleixner <tglx@linutronix.de>,
> Cc: Ingo Molnar <mingo@redhat.com>,
> Cc: Borislav Petkov <bp@alien8.de>,
> Cc: x86@kernel.org,
> Cc: "H. Peter Anvin" <hpa@zytor.com>,
> Cc: Peter Zijlstra <peterz@infradead.org>,
> Cc: Alexandre Chartre <alexandre.chartre@oracle.com>,
> Cc: "Eric W. Biederman" <ebiederm@xmission.com>,
> Cc: Jann Horn <jannh@google.com>,
> Cc: Dave Hansen <dave.hansen@linux.intel.com>
> 
> 
> Lai Jiangshan (3):
>    x86/entry: avoid calling into sync_regs() when entering from userspace
>    x86/entry: directly switch to kernel stack when .Lerror_bad_iret
>    x86/entry: remove unused sync_regs()
> 
>   arch/x86/entry/entry_64.S    | 52 +++++++++++++++++++++++-------------
>   arch/x86/include/asm/traps.h |  1 -
>   arch/x86/kernel/traps.c      | 22 +++------------
>   3 files changed, 38 insertions(+), 37 deletions(-)
> 
