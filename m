Return-Path: <SRS0=2Lxt=AV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12F0DC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 21:10:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D61B620748
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 21:10:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726353AbgGJVKQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jul 2020 17:10:16 -0400
Received: from foss.arm.com ([217.140.110.172]:40532 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726129AbgGJVKQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jul 2020 17:10:16 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7A6B41FB;
        Fri, 10 Jul 2020 14:10:15 -0700 (PDT)
Received: from [192.168.122.166] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 226F93F9AB;
        Fri, 10 Jul 2020 14:10:15 -0700 (PDT)
Subject: Re: [PATCH 0/4] dma-pool: Fix atomic pool selection
To:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>, hch@lst.de,
        Robin Murphy <robin.murphy@arm.com>,
        David Rientjes <rientjes@google.com>,
        iommu@lists.linux-foundation.org
Cc:     linux-rpi-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20200709161903.26229-1-nsaenzjulienne@suse.de>
From:   Jeremy Linton <jeremy.linton@arm.com>
Message-ID: <c28da389-dae5-9bc8-61f1-d40da086c5c4@arm.com>
Date:   Fri, 10 Jul 2020 13:52:59 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200709161903.26229-1-nsaenzjulienne@suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,


I have merged this to a 5.8 tree along with "dma-pool: Only allocate 
from CMA when in the same memory zone" and tested it in various ACPI/DT 
combinations, particularly on the RPI4. It seems to be working fine.

So thanks for your time and effort clearing this up!

Tested-by: Jeremy Linton <jeremy.linton@arm.com>


On 7/9/20 11:19 AM, Nicolas Saenz Julienne wrote:
> This is my attempt at fixing one of the regressions we've seen[1] after
> the introduction of per-zone atomic pools.
> 
> This combined with "dma-pool: Do not allocate pool memory from CMA"[2]
> should fix the boot issues on Jeremy's RPi4 setup.
> 
> [1] https://lkml.org/lkml/2020/7/2/974
> [2] https://lkml.org/lkml/2020/7/8/1108
> 
> ---
> 
> Nicolas Saenz Julienne (4):
>    dma-direct: Provide function to check physical memory area validity
>    dma-pool: Get rid of dma_in_atomic_pool()
>    dma-pool: Introduce dma_guess_pool()
>    dma-pool: Make sure atomic pool suits device
> 
>   include/linux/dma-direct.h |  1 +
>   kernel/dma/direct.c        |  2 +-
>   kernel/dma/pool.c          | 76 +++++++++++++++++++++++++++-----------
>   3 files changed, 56 insertions(+), 23 deletions(-)
> 

