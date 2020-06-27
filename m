Return-Path: <SRS0=QqoS=AI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 432D9C433DF
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Jun 2020 16:13:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1E13620724
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Jun 2020 16:13:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726382AbgF0QNv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Jun 2020 12:13:51 -0400
Received: from smtp02.smtpout.orange.fr ([80.12.242.124]:52598 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725864AbgF0QNu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Jun 2020 12:13:50 -0400
Received: from [192.168.42.210] ([93.22.39.177])
        by mwinf5d03 with ME
        id wGDk2200B3pKrM103GDkec; Sat, 27 Jun 2020 18:13:48 +0200
X-ME-Helo: [192.168.42.210]
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sat, 27 Jun 2020 18:13:48 +0200
X-ME-IP: 93.22.39.177
Subject: Re: [PATCH v2] dma-pool: Fix too large DMA pools on medium systems
To:     Christoph Hellwig <hch@lst.de>, Guenter Roeck <linux@roeck-us.net>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        David Rientjes <rientjes@google.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
References: <20200608132217.29945-1-geert@linux-m68k.org>
 <20200620200936.GA106151@roeck-us.net> <20200624073815.GE18609@lst.de>
From:   Marion & Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Message-ID: <6473db8e-4116-c994-aa08-6b50a6c609fb@wanadoo.fr>
Date:   Sat, 27 Jun 2020 18:13:43 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200624073815.GE18609@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Le 24/06/2020 à 09:38, Christoph Hellwig a écrit :
> Hi Guenter,
>
> can you try the patch below?  This just converts the huge allocations
> in mptbase to use GFP_KERNEL.  Christophe (added to Cc) actually has
> a scripted conversion for the rest that he hasn't posted yet, so I'll
> aim for the minimal version here.

Hi,

I'm sorry, but I will not send pci_ --> dma_ conversion for this driver.
I'm a bit puzzled by some choice of GFP_KERNEL and GFP_ATOMIC that not 
all that obvious to me.

I'll try to send some patches for other easier drivers in the coming weeks.

Best regards,

CJ

