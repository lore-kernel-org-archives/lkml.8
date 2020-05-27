Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7BE6C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 12:06:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A8CC220657
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 12:06:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387564AbgE0MG0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 08:06:26 -0400
Received: from ppsw-31.csi.cam.ac.uk ([131.111.8.131]:50044 "EHLO
        ppsw-31.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725801AbgE0MGZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 08:06:25 -0400
X-Cam-AntiVirus: no malware found
X-Cam-ScannerInfo: http://help.uis.cam.ac.uk/email-scanner-virus
Received: from 88-109-182-220.dynamic.dsl.as9105.com ([88.109.182.220]:60340 helo=[192.168.1.219])
        by ppsw-31.csi.cam.ac.uk (smtp.hermes.cam.ac.uk [131.111.8.157]:465)
        with esmtpsa (PLAIN:amc96) (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        id 1jdup5-000CIv-LO (Exim 4.92.3)
        (return-path <amc96@hermes.cam.ac.uk>); Wed, 27 May 2020 13:06:15 +0100
Subject: Re: Possibility of conflicting memory types in lazier TLB mode?
To:     Andy Lutomirski <luto@kernel.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Dave Hansen <dave.hansen@intel.com>
Cc:     Rik van Riel <riel@surriel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>, X86 ML <x86@kernel.org>
References: <1589523957.s4pf3vd48l.astroid@bobo.none>
 <3b217554a8a337de544482d20ddf8f2152559cd3.camel@surriel.com>
 <1589595735.4zyv4epfsj.astroid@bobo.none>
 <CALCETrVfb6-c6c4qoLCcs3zJhvrBPGWH+WgD9k_gvLeXYnLL+Q@mail.gmail.com>
From:   Andrew Cooper <andrew.cooper3@citrix.com>
Message-ID: <6b6a6046-202d-719f-3152-7228ff164075@citrix.com>
Date:   Wed, 27 May 2020 13:06:14 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <CALCETrVfb6-c6c4qoLCcs3zJhvrBPGWH+WgD9k_gvLeXYnLL+Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-GB
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/05/2020 01:09, Andy Lutomirski wrote:
> [cc Andrew Cooper and Dave Hansen]
>
> On Fri, May 15, 2020 at 7:35 PM Nicholas Piggin <npiggin@gmail.com> wrote:
>> Excerpts from Rik van Riel's message of May 16, 2020 5:24 am:
>>> On Fri, 2020-05-15 at 16:50 +1000, Nicholas Piggin wrote:
>>>> But what about if there are (real, not speculative) stores in the
>>>> store
>>>> queue still on the lazy thread from when it was switched, that have
>>>> not
>>>> yet become coherent? The page is freed by another CPU and reallocated
>>>> for something that maps it as nocache. Do you have a coherency
>>>> problem
>>>> there?
>>>>
>>>> Ensuring the store queue is drained when switching to lazy seems like
>>>> it
>>>> would fix it, maybe context switch code does that already or you
>>>> have
>>>> some other trick or reason it's not a problem. Am I way off base
>>>> here?
>>> On x86, all stores become visible in-order globally.
>>>
>>> I suspect that
>>> means any pending stores in the queue
>>> would become visible to the rest of the system before
>>> the store to the "current" cpu-local variable, as
>>> well as other writes from the context switch code
>>> become visible to the rest of the system.
>>>
>>> Is that too naive a way of preventing the scenario you
>>> describe?
>>>
>>> What am I overlooking?
>> I'm concerned if the physical address gets mapped with different
>> cacheability attributes where that ordering is not enforced by cache
>> coherency
>>
>>  "The PAT allows any memory type to be specified in the page tables, and
>>  therefore it is possible to have a single physical page mapped to two
>>  or more different linear addresses, each with different memory types.
>>  Intel does not support this practice because it may lead to undefined
>>  operations that can result in a system failure. In particular, a WC
>>  page must never be aliased to a cacheable page because WC writes may
>>  not check the processor caches." -- Vol. 3A 11-35
>>
>> Maybe I'm over thinking it, and this would never happen anyway because
>> if anyone were to map a RAM page WC, they might always have to ensure
>> all processor caches are flushed first anyway so perhaps this is just a
>> non-issue?
>>
> After talking to Andrew Cooper (hi!), I think that, on reasonably
> modern Intel machines, WC memory is still *coherent* with the whole
> system -- it's just not ordered the usual way.

So actually, on further reading, Vol 3 11.3 states "coherency is not
enforced by the processor’s bus coherency protocol" and later in 11.3.1,
"The WC buffer is not snooped and thus does not provide data coherency".


So, it would seem like it is possible to engineer a situation where the
cache line is WB according to the caches, and has pending WC data in one
or more cores/threads.  The question is whether this manifests as a
problem in practice, or not.

When changing the memory type of a mapping, you typically need to do
break/flush/make to be SMP-safe.  The IPI, as well as the TLB flush are
actions which cause WC buffers to be flushed.

x86 will tolerate a make/flush sequence as well.  In this scenario, a
3rd core/thread could pick up the line via its WB property, use it, and
cause it to be written back, between the pagetable change and the IPI
hitting.

But does this matter?  WC is by definition weakly ordered writes for
more efficient bus usage.  The device at the far end can't tell whether
the incoming write was from a WC or a WB eviction, and any late WC
evictions are semantically indistinguishable from a general concurrency
hazards with multiple writers.

~Andrew
