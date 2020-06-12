Return-Path: <SRS0=ixK5=7Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 585D8C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 16:57:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 30FFE20801
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 16:57:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dX91GOcM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726319AbgFLQ5X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jun 2020 12:57:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726089AbgFLQ5W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jun 2020 12:57:22 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10090C03E96F
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jun 2020 09:57:21 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id h5so10449213wrc.7
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jun 2020 09:57:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=hdftdNmWNoYmI9KOCEdF8TYF1SQt9boCMGPOgmJ5aMc=;
        b=dX91GOcMpW17ERW/nwCFP38SsYVXilVSIcTeNTtYN2smr2Rcg4eXcMZvw1rl62ZyBc
         rTFpJX1DqOFgImEcxpGnYl+l+ssxPce1MlL3+MAyPh3qGz2hxrSW+XYBIf/idOhlp1SS
         VAv992HGJjQOtLagc1cesdCgFGhNue5vvBsPVlu3N9TjW3Gvtfn1/MtAW39ZZYNSHJCc
         J02akL1SvACXIS0D2bTdYVe+HdY+Z/0W2CkCSmCbfPqyfPafKf5R+YKgGOYZ4t2f9vNB
         FsLda7913vY5QR0YdtdnaPeaoMSf3ao7GZ8zXVeqIOE69heJeBx7NlDWVfFWzMzjTxfb
         wZnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=hdftdNmWNoYmI9KOCEdF8TYF1SQt9boCMGPOgmJ5aMc=;
        b=uiC+GEJg9WjpFxnwslLYVWyvdJpRAHyUxM2PdeC31QpkeiMszv4thQO/3+X2SwFEyk
         tB9GtdTzcWS0zFmVlA3X9vgTDY0HE7+KgY2GTb6kCMuUONsuEpvzXr9h0uJd43LsY3yG
         ub5d1pV8KyvTzV/JrUd3XgTOdC/U0d2vHt/KevDwThpCRESdEj3iJ6b+VBDEmbpv29Bu
         1ZmVq18LBkOpA3CEetdTC0mwMKgcns5MHD7yj/IcjsAnoolWMbZKLy1887FIgzfT6G8r
         pnLHe+Xc+sk0xukIK9vc7pBl+r0rsj6evstcTaet22pHTcAEEOqcYbcNGzOe6rcGL6HN
         yWGQ==
X-Gm-Message-State: AOAM533bFPVmxvYuk7yc4LzTUMyxXqNgqK6R45NZw9T80miuVLIcv7+h
        goLc4XicSmlZUxmmL7pQo9ezjg3k
X-Google-Smtp-Source: ABdhPJyNmXM4qc3epdwtYo7bfs1VS3PSIkiDLC+pYnmFfKcklyuurpjoWjZQBuTaqU080fJh/c4sqQ==
X-Received: by 2002:adf:c391:: with SMTP id p17mr15094247wrf.243.1591981040526;
        Fri, 12 Jun 2020 09:57:20 -0700 (PDT)
Received: from [192.168.1.3] (ip68-111-84-250.oc.oc.cox.net. [68.111.84.250])
        by smtp.gmail.com with ESMTPSA id b201sm9481064wmb.36.2020.06.12.09.57.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Jun 2020 09:57:19 -0700 (PDT)
Subject: Re: [PATCH 00/11] arm/arm64: Turning IPIs into normal interrupts
To:     Marc Zyngier <maz@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Sumit Garg <sumit.garg@linaro.org>, kernel-team@android.com,
        Russell King <linux@arm.linux.org.uk>,
        Jason Cooper <jason@lakedaemon.net>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will@kernel.org>
References: <20200519161755.209565-1-maz@kernel.org>
 <d1ac7873-0f02-dbe0-dd3c-4fd14a87cf03@gmail.com>
 <20200612104918.3829bb26@why>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <0acfca3f-38fb-774c-aaab-53bc8cdbd13b@gmail.com>
Date:   Fri, 12 Jun 2020 09:57:16 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Firefox/68.0 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200612104918.3829bb26@why>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/12/2020 2:49 AM, Marc Zyngier wrote:
> Hi Florian,
> 
> On Tue, 19 May 2020 10:50:46 -0700
> Florian Fainelli <f.fainelli@gmail.com> wrote:
> 
>> On 5/19/2020 9:17 AM, Marc Zyngier wrote:
>>> For as long as SMP ARM has existed, IPIs have been handled as
>>> something special. The arch code and the interrupt controller exchange
>>> a couple of hooks (one to generate an IPI, another to handle it).
>>>
>>> Although this is perfectly manageable, it prevents the use of features
>>> that we could use if IPIs were Linux IRQs (such as pseudo-NMIs). It
>>> also means that each interrupt controller driver has to follow an
>>> architecture-specific interface instead of just implementing the base
>>> irqchip functionnalities. The arch code also duplicates a number of
>>> things that the core irq code already does (such as calling
>>> set_irq_regs(), irq_enter()...).
>>>
>>> This series tries to remedy this on arm/arm64 by offering a new
>>> registration interface where the irqchip gives the arch code a range
>>> of interrupts to use for IPIs. The arch code requests these as normal
>>> interrupts.
>>>
>>> The bulk of the work is at the interrupt controller level, where all 3
>>> irqchips used on arm64 get converted.
>>>
>>> Finally, the arm64 code drops the legacy registration interface. The
>>> same thing could be done on 32bit as well once the two remaining
>>> irqchips using that interface get converted.
>>>
>>> There is probably more that could be done: statistics are still
>>> architecture-private code, for example, and no attempt is made to
>>> solve that (apart from hidding the IRQs from /proc/interrupt).
>>>
>>> This has been tested on a bunch of 32 and 64bit guests.  
>>
>> Does this patch series change your position on this patch series
>>
>> https://lore.kernel.org/linux-arm-kernel/20191023000547.7831-3-f.fainelli@gmail.com/T/
>>
>> or is this still a no-no?
> 
> I don't think this series changes anything. There is no easy way to
> reserve SGIs in a way that would work for all combination of OS and FW,
> and the prospect of sending SGIs between S and NS has already been
> dubious (yes, the GIC architecture allows it, but it has been written
> by people who have never designed any large piece of SW).

That is fair enough, we have transitioned since then to using SPIs and
that appears to work nicely for what we want to do without requiring
your patch series.

In premise it is still possible for someone to specify 0x561 as the
first interrupt cell specifier  in the Device Tree in order to specify a
SGI interrupt and this will happily be parsed as a valid interrupt.

It would most likely fail some time later while trying to set the
interrupt type though. I do not think you can do better than this, as
there is no way for you to know the caller of gic_irq_domain_translate()
and reject them.
-- 
Florian
