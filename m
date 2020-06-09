Return-Path: <SRS0=F/Af=7W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CFF4C433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 15:44:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4FB2D2074B
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 15:44:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730911AbgFIPoD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jun 2020 11:44:03 -0400
Received: from foss.arm.com ([217.140.110.172]:44310 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728903AbgFIPn7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jun 2020 11:43:59 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E60621FB;
        Tue,  9 Jun 2020 08:43:58 -0700 (PDT)
Received: from [10.57.49.155] (unknown [10.57.49.155])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2950B3F66F;
        Tue,  9 Jun 2020 08:43:55 -0700 (PDT)
Subject: Re: [PATCH 2/2] arm-nommu: Add use_reserved_mem() to check if device
 support reserved memory
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
From:   Vladimir Murzin <vladimir.murzin@arm.com>
Message-ID: <031034fb-b109-7410-3ff8-e78cd12a5552@arm.com>
Date:   Tue, 9 Jun 2020 16:43:54 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20200609153646.GA17969@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/9/20 4:36 PM, Christoph Hellwig wrote:
> On Tue, Jun 09, 2020 at 11:22:24PM +0800, dillon min wrote:
>> Hi Vladimir,
>>
>> Thanks for reviewing.
>>
>> Hi Christoph Hellwig,
>>
>> I just want to know if kernel dma mapping/direct is focused on
>> platforms with MMU.
>> leave arch code to handle dma coherent memory management themself for
>> no-MMU platform.
> 
> No, I'd really like to consolidate everything that isn't overly
> arch specific eventually.
> 
>>
>> so, you just return error code in kernel/dma/mapping.c,direct.c
>> without CONFIG_MMU defined ?
>> which means dma-direct mapping doesn't support !CONFIG_MMU is not a
>> bug, but design as it's.
>> or, just return error code currently, will add dma direct mapping
>> support for !CONFIG_MMU in the
>> future?
>>
>> As Vladimir Murzin's suggestion has changes in kernel code, I need
>> your input to get
>> the design goal about dma-direct mapping, thanks.
> 
> Can someone repost the whole patch?
> 

Happy to repost as separate patch once dillon confirms it actually works.

Meanwhile, I'm trying to understand at which point we lost this 
functionality for NOMMU... maybe it will become different patch :)

Cheers
Vladimir
