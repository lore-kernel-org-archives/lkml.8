Return-Path: <SRS0=rtH4=AH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3273EC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 08:33:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 10DD820775
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 08:33:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725853AbgFZIdB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jun 2020 04:33:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725275AbgFZIdB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jun 2020 04:33:01 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F03EC08C5C1
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jun 2020 01:33:01 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id F29A22A39A8
Subject: Re: [PATCH] platform/chrome: Clarify SPDX license with GPL-2.0-only
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Collabora Kernel ML <kernel@collabora.com>,
        groeck@chromium.org, Benson Leung <bleung@chromium.org>,
        Dmitry Torokhov <dtor@chromium.org>,
        Gwendal Grignou <gwendal@chromium.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Bernardo Perez Priego <bernardo.perez.priego@intel.com>,
        Daniel Campello <campello@chromium.org>,
        Enrico Granata <egranata@chromium.org>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Lee Jones <lee.jones@linaro.org>,
        Nick Crews <ncrews@chromium.org>,
        Pi-Hsun Shih <pihsun@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Wen Yang <wenyang@linux.alibaba.com>,
        Yicheng Li <yichengli@chromium.org>
References: <20200625170356.225136-1-enric.balletbo@collabora.com>
 <CAHp75VdY4TEKfZXDb-f-KC4G2XRJOdB-w4vegSWG9vULLqcUKw@mail.gmail.com>
 <20200626043358.GB175080@kroah.com>
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
Message-ID: <6eafe066-ce79-4fad-7a91-c75a564e6663@collabora.com>
Date:   Fri, 26 Jun 2020 10:32:55 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200626043358.GB175080@kroah.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 26/6/20 6:33, Greg Kroah-Hartman wrote:
> On Thu, Jun 25, 2020 at 10:06:03PM +0300, Andy Shevchenko wrote:
>> On Thu, Jun 25, 2020 at 9:25 PM Enric Balletbo i Serra
>> <enric.balletbo@collabora.com> wrote:
>>>
>>> Remove the ambiguity with GPL-2.0 and use an explicit GPL-2.0-only
>>> tag.
>>
>> Is there any? Last time IIRC Greg told me that in the kernel the old
>> and new variants are okay.
> 
> They are just fine, leave it alone, the in-kernel LICENSES/ files show
> the valid SPDX tags that the kernel allows at this point in time.
> 

I guess my confusion comes from seeing patch series doing this change in the ML
instead of really reading the documentation. If it's clear, and as per in-kernel
docs, it is, that a GPL-2.0 tag is a GPL-2.0 only license, that's fine with me.

> This is not worth the churn at all, once we get to complete coverage of
> all kernel files, then you can worry about trivial things like this.
> 

I don't have special interest on land this if it's clear (was not really clear
to me before the discussion). So, I'll drop that patch from my queue.

Thanks for the feedback,
 Enric

> thanks,
> 
> greg k-h
> 
