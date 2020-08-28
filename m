Return-Path: <SRS0=aBbL=CG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 526ECC433E6
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 14:23:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 19D5C2054F
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 14:23:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727040AbgH1OXG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Aug 2020 10:23:06 -0400
Received: from foss.arm.com ([217.140.110.172]:50506 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725857AbgH1OXF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Aug 2020 10:23:05 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E69C11FB;
        Fri, 28 Aug 2020 07:23:04 -0700 (PDT)
Received: from [192.168.2.22] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 774ED3F71F;
        Fri, 28 Aug 2020 07:23:03 -0700 (PDT)
Subject: Re: [PATCH 2/6] ARM: dts: arm: Fix SP804 users
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Haojian Zhuang <haojian.zhuang@linaro.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Liviu Dudau <liviu.dudau@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>
References: <20200826183805.19369-1-andre.przywara@arm.com>
 <20200826183805.19369-3-andre.przywara@arm.com>
 <CACRpkdZx3GUaAk=2pEEEGvxH6nUt-UVZh=mTG1VV9ZBevGVU5w@mail.gmail.com>
From:   =?UTF-8?Q?Andr=c3=a9_Przywara?= <andre.przywara@arm.com>
Organization: ARM Ltd.
Message-ID: <31a5ac94-fd79-9532-0ac3-7c0be2de823a@arm.com>
Date:   Fri, 28 Aug 2020 15:22:46 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <CACRpkdZx3GUaAk=2pEEEGvxH6nUt-UVZh=mTG1VV9ZBevGVU5w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/08/2020 15:03, Linus Walleij wrote:

Hi,

> On Wed, Aug 26, 2020 at 8:38 PM Andre Przywara <andre.przywara@arm.com> wrote:
> 
>> The SP804 DT nodes for Realview, MPS2 and VExpress were not complying
>> with the binding: it requires either one or three clocks, but does not
>> allow exactly two clocks.
>>
>> Simply duplicate the first clock to satisfy the binding requirement.
>> For MPS2, we triple the clock, and add the clock-names property, as this
>> is required by the Linux primecell driver.
>> Try to make the clock-names more consistent on the way.
>>
>> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> 
> Acked-by: Linus Walleij <linus.walleij@linaro.org>

Thanks!

> 
> This looks good to me, shall I simply apply this patch to my
> Versatile tree (I suppose Sudeep should ack it too) or are
> you sending it upstream to the soc tree?

If you want to take it (and Sudeep is OK with it), I am happy with that.
The DTs should work either way, so there is no dependency or anything.
One patch less to carry around for me ;-)
Just sent a v2 with your ACK, so please pick this one.

Thanks,
Andre
