Return-Path: <SRS0=9JlO=3L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C567C33CAF
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 13:40:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C92820704
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 13:40:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727590AbgAVNkE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jan 2020 08:40:04 -0500
Received: from foss.arm.com ([217.140.110.172]:56732 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725790AbgAVNkE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jan 2020 08:40:04 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 991D3328;
        Wed, 22 Jan 2020 05:40:03 -0800 (PST)
Received: from [10.37.8.106] (unknown [10.37.8.106])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 740A23F52E;
        Wed, 22 Jan 2020 05:40:00 -0800 (PST)
Subject: Re: [PATCH v3 4/7] drm/panfrost: Add support for multiple regulators
To:     Nicolas Boichat <drinkcat@chromium.org>,
        Mark Brown <broonie@kernel.org>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Devicetree List <devicetree@vger.kernel.org>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        David Airlie <airlied@linux.ie>,
        lkml <linux-kernel@vger.kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Rob Herring <robh+dt@kernel.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>
References: <20200114071602.47627-1-drinkcat@chromium.org>
 <20200114071602.47627-5-drinkcat@chromium.org>
 <20200114151643.GW3897@sirena.org.uk>
 <CANMq1KC_-g45wdGgGiBmEyVXAJMkKwsJBJXGBHOMJk_=NyfpYw@mail.gmail.com>
From:   Steven Price <steven.price@arm.com>
Message-ID: <78d5d977-50d5-f28e-0c4c-fd1df9e868e9@arm.com>
Date:   Wed, 22 Jan 2020 13:40:03 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <CANMq1KC_-g45wdGgGiBmEyVXAJMkKwsJBJXGBHOMJk_=NyfpYw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/01/2020 04:37, Nicolas Boichat wrote:
> On Tue, Jan 14, 2020 at 10:16 PM Mark Brown <broonie@kernel.org> wrote:
>>
>> On Tue, Jan 14, 2020 at 03:15:59PM +0800, Nicolas Boichat wrote:
>>
>>>   - I couldn't find a way to detect the number of regulators in the
>>>     device tree, if we wanted to refuse to probe the device if there
>>>     are too many regulators, which might be required for safety, see
>>>     the thread on v2 [1].
>>
>> You'd need to enumerate all the properties of the device and look
>> for things matching *-supply.
> 
> I see ,-) I was hoping for something slightly cleaner, or maybe an
> existing function in the core.
> 
> Steven: How strongly do you feel about this? If so I can add that
> check in the next revision.

I'm not that strongly bothered about it - my only worry is that there 
may be hardware out there that might be broken by not activating a 
regulator. But I don't know how common this multi-regulator design is in 
practise.

Thanks,

Steve

> Also, just a heads-up, I'm out for the next 2 weeks, I'll send v4 after that.
> 
>>
>> Reviewed-by: Mark Brown <broonie@kernel.org>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
> 

