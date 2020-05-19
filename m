Return-Path: <SRS0=IaiW=7B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60956C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 17:50:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2FEFA207D4
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 17:50:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gsvMz+El"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729465AbgESRuv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 May 2020 13:50:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726059AbgESRuu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 13:50:50 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81EE3C08C5C0
        for <linux-kernel@vger.kernel.org>; Tue, 19 May 2020 10:50:50 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id e16so357368wra.7
        for <linux-kernel@vger.kernel.org>; Tue, 19 May 2020 10:50:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=PbPg6e3tpwQoLhlHES85OSbrJPFtIH1dskfrL5pZa0g=;
        b=gsvMz+El9W8nBMj9LNZ/yIaRn8k5v2h8C5y2xVUx9mublrH6HS607efXt4E7hz8wai
         votGfGXIhb9XxP5R6+fE6v1My39B9J4Gggj+sLOtpd8dHzK6ybh98IHWDDKNRrYv2Rb1
         j5+5o6h9+HeTYT+dR7g5xHrxrM1MlBHfI1hKBZi8T2FIh5v1fcfbJLBJ9dff8EQcKIMq
         BCHzcAGioBkgnxJJt1ABHlhCE7SgUb27IXqsl1vKnMQUdWAoqllDJtdD1agDT7vG4dJk
         KNjQXKsXWfCWepZnrFby/mOfz6Qv9D2kJz2r4t9QSEJ+gJ+kwwDL6+by7WqQ5+/NfaKA
         K1FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=PbPg6e3tpwQoLhlHES85OSbrJPFtIH1dskfrL5pZa0g=;
        b=JF+pO2KpWIE+Guk6dzMCnpOpwVOt0Qd8qyxLQXh7HPioKI7Oy55+rB0ZsobwHqZpRk
         Y40HMBHhv96htDW5cPhFKyfj0DkSYMDM+zDfFP96pe8MPGAx/FZ9hUSVd97XoAPHYDmt
         EjeoZy/miOSan1LZdgrPiOBqxs34CNN26YhpA6SxGloCSgUQf1jFc4EYIC7+KF+vWRuR
         8qUmdJSivsnAig7wWqnO267ZZHVm3eAdbhpVRMaBlLHqWYB/D4hsfneF4sUZEvxabXr6
         KS3vhkA9HY2SBE6+JZP05EhUvctf6tlv/4SHdxiTFIotSVXQDTZQ7yvMc9puMh0W4Icz
         GfKA==
X-Gm-Message-State: AOAM532xGA8aYNCvidHP5p45uISkC+n/PsHBvlolLWjAw86HUyC+Zi3I
        MzLIHcCiwoKhS/BubAK1IeE=
X-Google-Smtp-Source: ABdhPJyrG40EGugT2m+AdghxNUP6ys8Qt7gvRmotVcHZ5t309c/cAyW4dYJt81ruzXFmcLhCIv0XkQ==
X-Received: by 2002:a5d:5588:: with SMTP id i8mr41638wrv.223.1589910649108;
        Tue, 19 May 2020 10:50:49 -0700 (PDT)
Received: from [10.230.188.43] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id z132sm519806wmc.29.2020.05.19.10.50.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 May 2020 10:50:48 -0700 (PDT)
Subject: Re: [PATCH 00/11] arm/arm64: Turning IPIs into normal interrupts
To:     Marc Zyngier <maz@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Sumit Garg <sumit.garg@linaro.org>, kernel-team@android.com,
        Russell King <linux@arm.linux.org.uk>,
        Jason Cooper <jason@lakedaemon.net>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will@kernel.org>
References: <20200519161755.209565-1-maz@kernel.org>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <d1ac7873-0f02-dbe0-dd3c-4fd14a87cf03@gmail.com>
Date:   Tue, 19 May 2020 10:50:46 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Firefox/68.0 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200519161755.209565-1-maz@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/19/2020 9:17 AM, Marc Zyngier wrote:
> For as long as SMP ARM has existed, IPIs have been handled as
> something special. The arch code and the interrupt controller exchange
> a couple of hooks (one to generate an IPI, another to handle it).
> 
> Although this is perfectly manageable, it prevents the use of features
> that we could use if IPIs were Linux IRQs (such as pseudo-NMIs). It
> also means that each interrupt controller driver has to follow an
> architecture-specific interface instead of just implementing the base
> irqchip functionnalities. The arch code also duplicates a number of
> things that the core irq code already does (such as calling
> set_irq_regs(), irq_enter()...).
> 
> This series tries to remedy this on arm/arm64 by offering a new
> registration interface where the irqchip gives the arch code a range
> of interrupts to use for IPIs. The arch code requests these as normal
> interrupts.
> 
> The bulk of the work is at the interrupt controller level, where all 3
> irqchips used on arm64 get converted.
> 
> Finally, the arm64 code drops the legacy registration interface. The
> same thing could be done on 32bit as well once the two remaining
> irqchips using that interface get converted.
> 
> There is probably more that could be done: statistics are still
> architecture-private code, for example, and no attempt is made to
> solve that (apart from hidding the IRQs from /proc/interrupt).
> 
> This has been tested on a bunch of 32 and 64bit guests.

Does this patch series change your position on this patch series

https://lore.kernel.org/linux-arm-kernel/20191023000547.7831-3-f.fainelli@gmail.com/T/

or is this still a no-no?

> 
> Marc Zyngier (11):
>   genirq: Add fasteoi IPI flow
>   genirq: Allow interrupts to be excluded from /proc/interrupts
>   arm64: Allow IPIs to be handled as normal interrupts
>   ARM: Allow IPIs to be handled as normal interrupts
>   irqchip/gic-v3: Describe the SGI range
>   irqchip/gic-v3: Configure SGIs as standard interrupts
>   irqchip/gic: Refactor SMP configuration
>   irqchip/gic: Configure SGIs as standard interrupts
>   irqchip/gic-common: Don't enable SGIs by default
>   irqchip/bcm2836: Configure mailbox interrupts as standard interrupts
>   arm64: Kill __smp_cross_call and co
> 
>  arch/arm/Kconfig                  |   1 +
>  arch/arm/include/asm/smp.h        |   5 +
>  arch/arm/kernel/smp.c             |  97 +++++++++++---
>  arch/arm64/Kconfig                |   1 +
>  arch/arm64/include/asm/irq_work.h |   4 +-
>  arch/arm64/include/asm/smp.h      |   6 +-
>  arch/arm64/kernel/smp.c           |  98 +++++++++++----
>  drivers/irqchip/irq-bcm2836.c     | 151 ++++++++++++++++++----
>  drivers/irqchip/irq-gic-common.c  |   3 -
>  drivers/irqchip/irq-gic-v3.c      | 109 ++++++++++------
>  drivers/irqchip/irq-gic.c         | 203 ++++++++++++++++++------------
>  include/linux/irq.h               |   4 +-
>  kernel/irq/chip.c                 |  26 ++++
>  kernel/irq/debugfs.c              |   1 +
>  kernel/irq/proc.c                 |   2 +-
>  kernel/irq/settings.h             |   7 ++
>  16 files changed, 515 insertions(+), 203 deletions(-)
> 

-- 
Florian
