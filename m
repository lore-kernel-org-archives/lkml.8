Return-Path: <SRS0=CVC0=7X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10028C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 15:14:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DC928206F4
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 15:14:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ipyMb0wx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730081AbgFJPOR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jun 2020 11:14:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728095AbgFJPOQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jun 2020 11:14:16 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45AE3C03E96B;
        Wed, 10 Jun 2020 08:14:16 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id y17so2685554wrn.11;
        Wed, 10 Jun 2020 08:14:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=u6ZBh3xhLtnUwFe/9xqitT47OizAqnS3qUaRaKdrxcw=;
        b=ipyMb0wxF/MyREsILFzJtU8gHR5aUzsw0s0daHQqbH7uM6WRpP4JA8biPGvx8slP/V
         I0ugUP+QkSviFaGewLZ7pkZDezLRPWJhkHHM9Tk5c+n71n0DtHxjMvPScHnKH0k6O5mH
         KmQQT2TZpS4YDkm6EmYgdbeqjUsWK6Uzi00K4yIAovFk+l+h+7mo9fi46jcudyPX8LZO
         Y9ITq0aKrxNUYNWfa2g1FCNXrmgLA/ea+u8h4C3gvRf6tf2Pb7eAh5Erqfrk7924IGfl
         u/RIs41wmg7mUAcuVwwAHIUU1/11Cn8/DacYgHMyVhCCQ3BBvlNqPtVbx646WTFjYOrB
         w7SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=u6ZBh3xhLtnUwFe/9xqitT47OizAqnS3qUaRaKdrxcw=;
        b=sTn30x5Cm2FCx9b2NJX+S89MCOIXVqVr8kqErxvwvyfMxZ948KrJty8Sga3imCiH8R
         lF/tb1D5OiO4HK0WPAmp1C22+qh9dQf84tHPAZPWm2X+jut4BG+6rcWr2aRv7FnrydnM
         6Xut8OCo4oTLfCFffEfajqYbQdmdK+UTwtoUcm0tYpet/3g1FzM4oA1+Y7CZV7sJ8400
         hRCMGK8npdJO4QQxuHSKrc913ZEPI7jqmXCVnzgJ9syHv8jQft5UHEyYCTgCjAXPNZq7
         Oo3P/V9+wT93qFB95mlXrr8V9fWuO3CkPE+UdKvTYHoOlbfpp8fSgdU0ZY+UiUqVFdLl
         fEXA==
X-Gm-Message-State: AOAM532wiDgr28Ntm/93w9t+7Pjby6f9xHm6WnEuiWlARPXOvXHmXJJE
        rKvGAwadsc+WJBk1tP9kOSiuR63Z
X-Google-Smtp-Source: ABdhPJw8Odfle0VCYRg7uO5cn7CQ/GpvarHxi2OiUUCx4yB1jEgciHij0GrTptZw8PPkEqtzM34CxQ==
X-Received: by 2002:adf:ecc2:: with SMTP id s2mr4721645wro.60.1591802054688;
        Wed, 10 Jun 2020 08:14:14 -0700 (PDT)
Received: from [192.168.1.3] (ip68-111-84-250.oc.oc.cox.net. [68.111.84.250])
        by smtp.gmail.com with ESMTPSA id v19sm26227wml.26.2020.06.10.08.14.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Jun 2020 08:14:13 -0700 (PDT)
Subject: Re: [PATCH 2/2] clk: bcm63xx-gate: add BCM6318 support
To:     =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
        =?UTF-8?Q?=c3=81lvaro_Fern=c3=a1ndez_Rojas?= <noltari@gmail.com>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        bcm-kernel-feedback-list <bcm-kernel-feedback-list@broadcom.com>,
        Julia Lawall <julia.lawall@lip6.fr>,
        Jonas Gorski <jonas.gorski@gmail.com>,
        kbuild test robot <lkp@intel.com>,
        linux-clk <linux-clk@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20200609113049.4035426-1-noltari@gmail.com>
 <20200609113049.4035426-3-noltari@gmail.com>
 <1367fcf3-24ed-9106-a329-da5f8e168e17@gmail.com>
 <3E897527-55EB-47DB-99ED-C737725F0F9E@gmail.com>
 <CAAdtpL7dUZ2RqkrqSxiZxDbp4qY-KdtSc7CyuR+rbnRRA2Yvrw@mail.gmail.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <93c429b1-31f4-95c2-1bd9-b3756b396f3a@gmail.com>
Date:   Wed, 10 Jun 2020 08:14:09 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Firefox/68.0 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <CAAdtpL7dUZ2RqkrqSxiZxDbp4qY-KdtSc7CyuR+rbnRRA2Yvrw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/10/2020 1:29 AM, Philippe Mathieu-Daudé wrote:
> Hi,
> 
> On Wed, Jun 10, 2020 at 8:13 AM Álvaro Fernández Rojas
> <noltari@gmail.com> wrote:
>>
>> Hi Florian,
>>
>>> El 10 jun 2020, a las 4:27, Florian Fainelli <f.fainelli@gmail.com> escribió:
>>>
>>>
>>>
>>> On 6/9/2020 4:30 AM, Álvaro Fernández Rojas wrote:
>>>> +static const struct clk_bcm63xx_table_entry bcm6318_clocks[] = {
>>>> +    { .name = "adsl_asb", .bit = 0, },
>>>> +    { .name = "usb_asb", .bit = 1, },
>>>> +    { .name = "mips_asb", .bit = 2, },
>>>> +    { .name = "pcie_asb", .bit = 3, },
>>>> +    { .name = "phymips_asb", .bit = 4, },
>>>> +    { .name = "robosw_asb", .bit = 5, },
>>>> +    { .name = "sar_asb", .bit = 6, },
>>>> +    { .name = "sdr_asb", .bit = 7, },
>>>> +    { .name = "swreg_asb", .bit = 8, },
>>>> +    { .name = "periph_asb", .bit = 9, },
>>>> +    { .name = "cpubus160", .bit = 10, },
>>>> +    { .name = "adsl", .bit = 11, },
>>>> +    { .name = "sar124", .bit = 12, },
>>>
>>> Nit: this should be sar125
>>
>> Nice catch, I will fix this in v2.
>>
>>>
>>>> +    { .name = "mips", .bit = 13, .flags = CLK_IS_CRITICAL, },
>>>> +    { .name = "pcie", .bit = 14, },
>>>> +    { .name = "robosw250", .bit = 16, },
>>>> +    { .name = "robosw025", .bit = 17, },
>>>> +    { .name = "sdr", .bit = 19, .flags = CLK_IS_CRITICAL, },
>>>> +    { .name = "usb", .bit = 20, },
>>>
>>> This should probably be "usbd" to indicate this is the USB device clock
>>> (not host)
>>
>> Ok, I will change it. I got confused by the fact that both (usbd and usbh) were present on 6318_map_part.h:
>> #define USBD_CLK_EN         (1 << 20)
>> #define USBH_CLK_EN         (1 << 20)
> 
> Is there a datasheet to verify that?

Not a public one, but I can confirm this is correct given the internal
datasheet.
-- 
Florian
