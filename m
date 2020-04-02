Return-Path: <SRS0=iZC5=5S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6777CC43331
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 15:16:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D3502073B
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 15:16:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=metafoo.de header.i=@metafoo.de header.b="PUkyZjKG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389201AbgDBPQu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Apr 2020 11:16:50 -0400
Received: from www381.your-server.de ([78.46.137.84]:47294 "EHLO
        www381.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389159AbgDBPQt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Apr 2020 11:16:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=metafoo.de;
         s=default2002; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
        MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=WYf1ogi8qwXr1Ma6iwc6C03qL42/5kPc3Gq7upiuE2U=; b=PUkyZjKGKz4NcqJc2AO2B5Z1X3
        9LVSoOBE2WqcOR4z7C6dXTv4KEw3pXn1UDPxxfjMlWOHRKSsBB//QTTrQ4dSFfuRYd7td4r+PC9On
        zg9Zzn5admshXSbcTiXNWUsQHnGqcCuxAdEnRePY94QUMwGY3kB4clNhHIJpo/kzHAgZqB5wlETmd
        zdiwv/OpcnR3Cy3JL80DfHAqTPIrT+TagwhjH2NOGm/QViU7OqVYasazs9BGESlvmtsNHI3MBXWf1
        n4m9JuMGgZW2U29h2v5BSFy/TA90ptes1aBHvQ/htu5SkJri4/C1YsgF0M0IA6Y2Nhj50tg275BYI
        eNbPpsWw==;
Received: from sslproxy01.your-server.de ([78.46.139.224])
        by www381.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <lars@metafoo.de>)
        id 1jK1aI-0002eQ-Rr; Thu, 02 Apr 2020 17:16:47 +0200
Received: from [82.135.64.109] (helo=[192.168.178.20])
        by sslproxy01.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <lars@metafoo.de>)
        id 1jK1aI-0004uI-Kz; Thu, 02 Apr 2020 17:16:46 +0200
Subject: Re: [RFC] genirq: prevent allocated_irqs from being smaller than
 NR_IRQS
To:     Marcelo Schmitt <marcelo.schmitt1@gmail.com>,
        linux-kernel@vger.kernel.org
Cc:     tglx@linutronix.de
References: <20200402150820.GB5886@smtp.gmail.com>
From:   Lars-Peter Clausen <lars@metafoo.de>
Message-ID: <66fabdd6-7815-1ede-9a45-45fdb2b6d5b2@metafoo.de>
Date:   Thu, 2 Apr 2020 17:16:44 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200402150820.GB5886@smtp.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Authenticated-Sender: lars@metafoo.de
X-Virus-Scanned: Clear (ClamAV 0.102.2/25770/Thu Apr  2 14:58:54 2020)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/2/20 5:08 PM, Marcelo Schmitt wrote:
> Hi,
>
> I was trying to understand IRQ initialization when suddenly got
> intrigued about the declaration of the "allocated_irqs" bitmap at
> kernel/irq/irqdesc.c. The size of allocated_irqs is defined by
> IRQ_BITMAP_BITS, which in turn is passed to BITS_TO_LONGS to calculate
> the actual number of IRQs the system may have. If I got it right, there
> should be one entry at allocated_irqs for each possible IRQ line. At
> kernel/irq/internals.h, IRQ_BITMAP_BITS is defined to be NR_IRQS (or
> NR_IRQS plus a high constant in the case of sparse IRQs), which most
> architectures seem to define as being the actual number of IRQs a board
> has.
>
> #ifdef CONFIG_SPARSE_IRQ
> # define IRQ_BITMAP_BITS (NR_IRQS + 8196)
> #else
> # define IRQ_BITMAP_BITS NR_IRQS
> #endif
>
> The thing I'm troubled about is that BITS_TO_LONGS divides
> IRQ_BITMAP_BITS by sizeof(long) * 8, which makes it possible for the
> size of allocated_irqs to be smaller than NR_IRQS.
>
> For instance, if !CONFIG_SPARSE_IRQ, sizeof(long) == 8, and NR_IRQS is
> defined as 16, then IRQ_BITMAP_BITS would be equal to
> (16 + 64 - 1)/64 = 1. Even if CONFIG_SPARSE_IRQ is defined, a device
> with a large number of IRQ lines would end up with a small bitmap for
> allocated_irqs.
>
> I thought NR_IRQS would be multiplied by the number of bits it uses.
> Something like:
>
> #ifdef CONFIG_SPARSE_IRQ
> # define IRQ_BITMAP_BITS (NR_IRQS * BITS_PER_TYPE(long) + 8196)
> #else
> # define IRQ_BITMAP_BITS (NR_IRQS * BITS_PER_TYPE(long))
> #endif
>
> Anyhow, IRQ_BITMAP_BITS is also used to limit the maximum number of IRQs
> at irqdesc.c. If my understanding of nr_irqs is correct, it would make
> sense to change some sanity checks at early_irq_init() too.
>
> Does anyone mind giving me some advice on how allocated_irqs is
> initialized with a suitable size to support the number of interrupt
> lines a board may have?

Maybe I'm missing something, but allocated_irqs is a bitmap. This means 
each bit corresponds to one IRQ. if sizeof(long) is 8 and allocated_irqs 
is sized to be one long that means it is large enough for 64 IRQs.

- Lars

