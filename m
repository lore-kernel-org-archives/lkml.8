Return-Path: <SRS0=flzY=3U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA325C33CB2
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jan 2020 11:33:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C22B2206F0
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jan 2020 11:33:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728469AbgAaLdx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jan 2020 06:33:53 -0500
Received: from foss.arm.com ([217.140.110.172]:34496 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728325AbgAaLdx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jan 2020 06:33:53 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1B9C2106F;
        Fri, 31 Jan 2020 03:33:53 -0800 (PST)
Received: from [192.168.1.123] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E56053F67D;
        Fri, 31 Jan 2020 03:33:51 -0800 (PST)
Subject: Re: [PATCH] dma-debug: dynamic allocation of hash table
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Eric Dumazet <edumazet@google.com>, Christoph Hellwig <hch@lst.de>,
        Joerg Roedel <jroedel@suse.de>,
        Linux IOMMU <iommu@lists.linux-foundation.org>,
        Eric Dumazet <eric.dumazet@gmail.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <20200130191049.190569-1-edumazet@google.com>
 <e0a0ffa9-3721-4bac-1c8f-bcbd53d22ba1@arm.com>
 <CAMuHMdVSyD62nvRmN-v6CbJ2UyqH=d7xdVeCD8_X5us+mvCXUQ@mail.gmail.com>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <a305bd1f-8142-6557-4228-aae10c5114e1@arm.com>
Date:   Fri, 31 Jan 2020 11:33:48 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:68.0) Gecko/20100101
 Thunderbird/68.4.2
MIME-Version: 1.0
In-Reply-To: <CAMuHMdVSyD62nvRmN-v6CbJ2UyqH=d7xdVeCD8_X5us+mvCXUQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-01-31 9:06 am, Geert Uytterhoeven wrote:
> Hi Robin,
> 
> On Fri, Jan 31, 2020 at 12:46 AM Robin Murphy <robin.murphy@arm.com> wrote:
>> On 2020-01-30 7:10 pm, Eric Dumazet via iommu wrote:
>>> Increasing the size of dma_entry_hash size by 327680 bytes
>>> has reached some bootloaders limitations.
>>
>> [ That might warrant some further explanation - I don't quite follow how
>> this would relate to a bootloader specifically :/ ]
> 
> Increasing the size of a static array increases kernel size.
> Some (all? ;-) bootloaders have limitations on the maximum size of a
> kernel image they can boot (usually something critical gets overwritten
> when handling a too large image).  While boot loaders can be fixed and
> upgraded, this is usually much more cumbersome than updating the
> kernel.

Ah, OK - I'm all too familiar with bootloaders having image size limits, 
but I'm also used to implicitly-initialised statics being collected into 
a runtime-initialised .bss section, so I hadn't realised that there 
might still be platforms where that space is actually allocated in the 
image at link-time.

> Besides, a static array always consumes valuable unswapable memory,
> even when the feature would not be used (e.g. disabled by a command
> line option).

Indeed, and that alone might have been a reasonable rationale for the 
patch - I was merely querying the wording of the commit message, not its 
intent :)

Thanks,
Robin.
