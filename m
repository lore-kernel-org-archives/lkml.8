Return-Path: <SRS0=n6RB=27=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63932C33CA3
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 11:40:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 437252077C
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 11:40:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727859AbgAJLkA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jan 2020 06:40:00 -0500
Received: from foss.arm.com ([217.140.110.172]:42862 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727812AbgAJLkA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jan 2020 06:40:00 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 75FAF1063;
        Fri, 10 Jan 2020 03:39:59 -0800 (PST)
Received: from [10.1.194.52] (e112269-lin.cambridge.arm.com [10.1.194.52])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 29DAA3F534;
        Fri, 10 Jan 2020 03:39:57 -0800 (PST)
Subject: Re: [PATCH v2 4/7] drm/panfrost: Add support for a second regulator
 for the GPU
To:     Rob Herring <robh+dt@kernel.org>,
        Nicolas Boichat <drinkcat@chromium.org>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Devicetree List <devicetree@vger.kernel.org>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        David Airlie <airlied@linux.ie>,
        lkml <linux-kernel@vger.kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Mark Brown <broonie@kernel.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>
References: <20200108052337.65916-1-drinkcat@chromium.org>
 <20200108052337.65916-5-drinkcat@chromium.org>
 <20200108132302.GA3817@sirena.org.uk>
 <CANMq1KBo8ND+YDHaCw3yZZ0RUr69-NSUcVbqu38DuZvHUB-LFw@mail.gmail.com>
 <CAL_JsqKvNBCVkiE4zKn0aXdrV4Ncx2bB6+KRpM+aPpMVzS4XbQ@mail.gmail.com>
From:   Steven Price <steven.price@arm.com>
Message-ID: <d580b57a-d3c8-ece2-19f3-211c52444bfd@arm.com>
Date:   Fri, 10 Jan 2020 11:39:56 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <CAL_JsqKvNBCVkiE4zKn0aXdrV4Ncx2bB6+KRpM+aPpMVzS4XbQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/01/2020 16:56, Rob Herring wrote:
> On Wed, Jan 8, 2020 at 4:52 PM Nicolas Boichat <drinkcat@chromium.org> wrote:
>>
>> On Wed, Jan 8, 2020 at 9:23 PM Mark Brown <broonie@kernel.org> wrote:
>>>
>>> On Wed, Jan 08, 2020 at 01:23:34PM +0800, Nicolas Boichat wrote:
>>>
>>>> Some GPUs, namely, the bifrost/g72 part on MT8183, have a second
>>>> regulator for their SRAM, let's add support for that.
>>>
>>>> +     pfdev->regulator_sram = devm_regulator_get_optional(pfdev->dev, "sram");
>>>> +     if (IS_ERR(pfdev->regulator_sram)) {
>>>
>>> This supply is required for the devices that need it so I'd therefore
>>> expect the driver to request the supply non-optionally based on the
>>> compatible string rather than just hoping that a missing regulator isn't
>>> important.
>>
>> That'd be a bit awkward to match, though... Currently all bifrost
>> share the same compatible "arm,mali-bifrost", and it'd seem
>> weird/wrong to match "mediatek,mt8183-mali" in this driver? I have no
>> idea if any other Mali implementation will require a second regulator,
>> but with the MT8183 we do need it, see below.
> 
> The current number of supported bifrost platforms is 0. It's only a
> matter of time until SoC specific compatibles need to be used in the
> driver. This is why we require them.
> 
> It could very well be that all bifrost implementations need 2
> supplies. On chip RAMs are very frequently a separate thing which are
> synthesized differently from logic. At least within a specific IP
> model, I somewhat doubt there's a variable number of supplies. It
> could be possible to connect both to the same supply, but the correct
> way to handle that is both -supply properties point to the same
> regulator.

To be honest I've no idea what different SoC designs have done, but one
of the intentions of core stacks was that sets of GPU cores would be on
different power supplies. (I think this is to avoid issues with inrush
current etc, but I'm not a hardware engineer). So I would expect designs
with a large number of cores to have more physical supplies than designs
with fewer cores.

However, from a driver perspective this is all meant to be hidden by the
hardware PDC which the GPU talks to. So the actual power up/down of the
supplies may be completely automatic and therefore not described in the
DT. So the actual number of software-controllable supplies could be 1 or
could be more if the individual physical supplies are visible to software.

The Hikey960 for instance hides everything behind a mailbox interface,
and it's simply a case of requesting a frequency.

Steve
