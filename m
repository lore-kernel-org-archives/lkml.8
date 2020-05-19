Return-Path: <SRS0=IaiW=7B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BB06C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 19:47:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3B8C0206C3
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 19:47:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="p1lO8gQM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727084AbgESTrw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 May 2020 15:47:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726348AbgESTrv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 15:47:51 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8889C08C5C0
        for <linux-kernel@vger.kernel.org>; Tue, 19 May 2020 12:47:51 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id ci23so134132pjb.5
        for <linux-kernel@vger.kernel.org>; Tue, 19 May 2020 12:47:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=CgyntvvUzH1XXLBzT1ZgjwhZo6axGQJQNJMNpQq/mjY=;
        b=p1lO8gQM6mxvNv1BlHL2svVHbsP69QZ+XlG0COlRjlYM1DGwsqpnqMh/39++m5KE96
         9n9ZehwfzYN68t7s0KmT0fNOdJ850WfDjLWMRxprnwcCwXNUa+oe4f7TLA117mDNkBiY
         Fy4wvZ/eetly/jy2W6QHjqCgRMNox+JXoD7UOl+aDpZPISswLph6t/i6Szubr3feo3H5
         22bmwheyp0Vyy0Jq1xHQ/y9ulpgwj32vBWubfmcAokQg8qPyC16CdKJx8pSM0bZdMn62
         1+avZfYvheGKN0BzDIFCBnObRRrfeeNSFzCkEPoAms2Dj7pbE1prWTkrtEEQ7Kdpf5do
         xfzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=CgyntvvUzH1XXLBzT1ZgjwhZo6axGQJQNJMNpQq/mjY=;
        b=nRx26pJdG7+BHdPbQXm3IN8QqV47OvL4I35PMNG4v43MjofsnNV5I6YwlVlLnMVkpp
         gyaLVSxovgCsImNyVYxbKB+e/eEtCVz1Phg8YSJOKpMachNvu4HEHWdx/nep6p70yGfQ
         Ex9B/ETgepPvJGjNzFDjucOUvbPVcT15pjPxgGQMRhhOPU8RabcMvMYLhGw91Glgk9Kg
         e2ZloILuWyQBbmHbWUZrchiSmEITWWSlcaglyOOZ3Din6IO7YBzNuOHmXUEMUdxhN5in
         0QE2BfUHePyY6wU0YxIWrAMDg88+wSyZLZ4L+v8Vnq9FhFjFk3miNP7mHQFpTuQYHDa+
         L0bQ==
X-Gm-Message-State: AOAM532ywWD+uSZp7mltlgcfhehr/50WSF9fYZtX70MwYRZ4QTDycQGa
        IV6UANrPvTwW4k5wfJ2AkY4=
X-Google-Smtp-Source: ABdhPJz81uFcj5ZQa6mkGTcmojKcSVnPbx9vOLpey0COrD8CM1hoAIfQebh1Ek7hG9dQucZqv5U15g==
X-Received: by 2002:a17:902:c281:: with SMTP id i1mr1004179pld.177.1589917671065;
        Tue, 19 May 2020 12:47:51 -0700 (PDT)
Received: from [10.230.188.43] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id u5sm236045pfu.198.2020.05.19.12.47.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 May 2020 12:47:50 -0700 (PDT)
Subject: Re: [PATCH 00/11] arm/arm64: Turning IPIs into normal interrupts
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     Marc Zyngier <maz@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Sumit Garg <sumit.garg@linaro.org>, kernel-team@android.com,
        Russell King <linux@arm.linux.org.uk>,
        Jason Cooper <jason@lakedaemon.net>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will@kernel.org>
References: <20200519161755.209565-1-maz@kernel.org>
 <d1ac7873-0f02-dbe0-dd3c-4fd14a87cf03@gmail.com>
Message-ID: <7b06f351-40f3-74c3-5d16-d7d58ab490b6@gmail.com>
Date:   Tue, 19 May 2020 12:47:44 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Firefox/68.0 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <d1ac7873-0f02-dbe0-dd3c-4fd14a87cf03@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/19/2020 10:50 AM, Florian Fainelli wrote:
> 
> 
> On 5/19/2020 9:17 AM, Marc Zyngier wrote:
>> For as long as SMP ARM has existed, IPIs have been handled as
>> something special. The arch code and the interrupt controller exchange
>> a couple of hooks (one to generate an IPI, another to handle it).
>>
>> Although this is perfectly manageable, it prevents the use of features
>> that we could use if IPIs were Linux IRQs (such as pseudo-NMIs). It
>> also means that each interrupt controller driver has to follow an
>> architecture-specific interface instead of just implementing the base
>> irqchip functionnalities. The arch code also duplicates a number of
>> things that the core irq code already does (such as calling
>> set_irq_regs(), irq_enter()...).
>>
>> This series tries to remedy this on arm/arm64 by offering a new
>> registration interface where the irqchip gives the arch code a range
>> of interrupts to use for IPIs. The arch code requests these as normal
>> interrupts.
>>
>> The bulk of the work is at the interrupt controller level, where all 3
>> irqchips used on arm64 get converted.
>>
>> Finally, the arm64 code drops the legacy registration interface. The
>> same thing could be done on 32bit as well once the two remaining
>> irqchips using that interface get converted.
>>
>> There is probably more that could be done: statistics are still
>> architecture-private code, for example, and no attempt is made to
>> solve that (apart from hidding the IRQs from /proc/interrupt).
>>
>> This has been tested on a bunch of 32 and 64bit guests.
> 
> Does this patch series change your position on this patch series
> 
> https://lore.kernel.org/linux-arm-kernel/20191023000547.7831-3-f.fainelli@gmail.com/T/
> 
> or is this still a no-no?

Our firmware specifies SGI interrupts with the first interrupt cell
specifier set to 2, so changing GIC_IRQ_TYPE_SGI to 2 allows me to use a
nearly unmodified firmware with your changes, sweet! I know this is not
supposed to be used that way, but the temptation was too big.

FWIW, on ARM64:

Tested-by: Florian Fainelli <f.fainelli@gmail.com>
-- 
Florian
