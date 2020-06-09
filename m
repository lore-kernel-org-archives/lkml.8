Return-Path: <SRS0=F/Af=7W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5622C433E1
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 16:25:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CEB8C20774
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 16:25:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728769AbgFIQZK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jun 2020 12:25:10 -0400
Received: from foss.arm.com ([217.140.110.172]:44788 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725894AbgFIQZK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jun 2020 12:25:10 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 69E5F1FB;
        Tue,  9 Jun 2020 09:25:09 -0700 (PDT)
Received: from [10.57.49.155] (unknown [10.57.49.155])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1B0BA3F73D;
        Tue,  9 Jun 2020 09:25:05 -0700 (PDT)
Subject: Re: [PATCH 2/2] arm-nommu: Add use_reserved_mem() to check if device
 support reserved memory
From:   Vladimir Murzin <vladimir.murzin@arm.com>
To:     Christoph Hellwig <hch@lst.de>,
        dillon min <dillon.minfei@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        linux@armlinux.org.uk, Kate Stewart <kstewart@linuxfoundation.org>,
        allison@lohutok.net, info@metux.net, tglx@linutronix.de,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-stm32@st-md-mailman.stormreply.com,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <1591605038-8682-1-git-send-email-dillon.minfei@gmail.com>
 <1591605038-8682-3-git-send-email-dillon.minfei@gmail.com>
 <90df5646-e0c4-fcac-d934-4cc922230dd2@arm.com>
 <CAL9mu0+__0Z3R3TcSrj9-kPxsyQHKS9WqK1u58P0dEZ+Jd-wbQ@mail.gmail.com>
 <20200609153646.GA17969@lst.de>
 <031034fb-b109-7410-3ff8-e78cd12a5552@arm.com>
Message-ID: <b0c85637-4646-614b-d406-49aa72ce52e1@arm.com>
Date:   Tue, 9 Jun 2020 17:25:04 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <031034fb-b109-7410-3ff8-e78cd12a5552@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/9/20 4:43 PM, Vladimir Murzin wrote:
> On 6/9/20 4:36 PM, Christoph Hellwig wrote:
>> On Tue, Jun 09, 2020 at 11:22:24PM +0800, dillon min wrote:
>>> Hi Vladimir,
>>>
>>> Thanks for reviewing.
>>>
>>> Hi Christoph Hellwig,
>>>
>>> I just want to know if kernel dma mapping/direct is focused on
>>> platforms with MMU.
>>> leave arch code to handle dma coherent memory management themself for
>>> no-MMU platform.
>>
>> No, I'd really like to consolidate everything that isn't overly
>> arch specific eventually.
>>
>>>
>>> so, you just return error code in kernel/dma/mapping.c,direct.c
>>> without CONFIG_MMU defined ?
>>> which means dma-direct mapping doesn't support !CONFIG_MMU is not a
>>> bug, but design as it's.
>>> or, just return error code currently, will add dma direct mapping
>>> support for !CONFIG_MMU in the
>>> future?
>>>
>>> As Vladimir Murzin's suggestion has changes in kernel code, I need
>>> your input to get
>>> the design goal about dma-direct mapping, thanks.
>>
>> Can someone repost the whole patch?
>>
> 
> Happy to repost as separate patch once dillon confirms it actually works.
> 
> Meanwhile, I'm trying to understand at which point we lost this 
> functionality for NOMMU... maybe it will become different patch :)
> 

mmap operation for dma-noop (ancestor of dma-direct) was proposed
in [1]. It was suggested to change dma_common_map() instead which
was implemented in 

07c75d7a6b9e ("drivers: dma-mapping: allow dma_common_mmap() for NOMMU")

that removed CONFIG_MMU drom dma_common_mmap(). Later

62fcee9a3bd7 ("dma-mapping: remove CONFIG_ARCH_NO_COHERENT_DMA_MMAP")

reintroduced CONFIG_MMU in dma_common_mmap().

Even though commit mentions ARM, I do not see how mmap would continue
to work for NOMMU with dma-direct. ARM NOMMU needs it's own DMA operations
only in cases where caches are implemented or active, in other cases it
fully relies on dma-direct.

It looks to me that we either should provide NOMMU variant for mmap in
dma/direct or (carefully) fix dma/mapping.

Thoughts?

[1] http://lists.infradead.org/pipermail/linux-arm-kernel/2017-January/480600.html

Vladimir

> Cheers
> Vladimir
> 

