Return-Path: <SRS0=sD2I=AF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02BFAC433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 14:25:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C9DDE20781
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 14:25:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390483AbgFXOZi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jun 2020 10:25:38 -0400
Received: from foss.arm.com ([217.140.110.172]:55658 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388115AbgFXOZh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 10:25:37 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 18AE11FB;
        Wed, 24 Jun 2020 07:25:37 -0700 (PDT)
Received: from [10.57.9.128] (unknown [10.57.9.128])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BE6E53F6CF;
        Wed, 24 Jun 2020 07:25:34 -0700 (PDT)
Subject: Re: [RESEND PATCH v5 3/5] drivers core: allow probe_err accept
 integer and pointer types
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Andrzej Hajda <a.hajda@samsung.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Jonas Karlman <jonas@kwiboo.se>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:DRM DRIVERS" <dri-devel@lists.freedesktop.org>,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Mark Brown <broonie@kernel.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>
References: <20200624114127.3016-1-a.hajda@samsung.com>
 <CGME20200624114136eucas1p1c84f81b1d78e2dbad7ac1b762f0a4b4f@eucas1p1.samsung.com>
 <20200624114127.3016-4-a.hajda@samsung.com>
 <2203e0c2-016b-4dbe-452d-63c857f06dd1@arm.com>
 <CAHp75VfpP1cGK3FvTL0hBudRY2N_7GpXYRuUHUCipz7X2sMLmQ@mail.gmail.com>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <be755825-b413-e5c1-7ea4-06506b20d1f0@arm.com>
Date:   Wed, 24 Jun 2020 15:25:33 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <CAHp75VfpP1cGK3FvTL0hBudRY2N_7GpXYRuUHUCipz7X2sMLmQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-06-24 13:55, Andy Shevchenko wrote:
> On Wed, Jun 24, 2020 at 3:37 PM Robin Murphy <robin.murphy@arm.com> wrote:
>> On 2020-06-24 12:41, Andrzej Hajda wrote:
>>> Many resource acquisition functions return error value encapsulated in
>>> pointer instead of integer value. To simplify coding we can use macro
>>> which will accept both types of error.
>>> With this patch user can use:
>>>        probe_err(dev, ptr, ...)
>>> instead of:
>>>        probe_err(dev, PTR_ERR(ptr), ...)
>>> Without loosing old functionality:
>>>        probe_err(dev, err, ...)
>>
>> Personally I'm not convinced that simplification has much value, and I'd
>> say it *does* have a significant downside. This:
>>
>>          if (IS_ERR(x))
>>                  do_something_with(PTR_ERR(x));
>>
>> is a familiar and expected pattern when reading/reviewing code, and at a
>> glance is almost certainly doing the right thing. If I see this, on the
>> other hand:
>>
>>          if (IS_ERR(x))
>>                  do_something_with(x);
> 
> I don't consider your arguments strong enough. You are appealing to
> one pattern vs. new coming *pattern* just with a different name and
> actually much less characters to parse. We have a lot of clean ups
> like this, have you protested against them? JFYI: they are now
> *established patterns* and saved a ton of LOCs in some of which even
> were typos.

I'm not against probe_err() itself, I think that stands to be a 
wonderfully helpful thing that will eliminate a hell of a lot of ugly 
mess from drivers. It's only the specific elision of 9 characters worth 
of "PTR_ERR()" in certain cases that I'm questioning. I mean, we've 
already got +20 characters leeway now that checkpatch has acknowledged 
all that blank space on the right-hand side of all my editor windows.

Sure, there's not necessarily anything bad about introducing a new 
pattern in itself, but it's not going to *replace* the existing pattern 
of "IS_ERR() pairs with PTR_ERR()", because IS_ERR() is used for more 
than driver probe error handling. Instead, everybody now has to bear in 
mind that the new pattern is "IS_ERR() pairs with PTR_ERR(), except 
sometimes when it doesn't - last time I looked only probe_err() was 
special, but maybe something's changed, I'll have to go check...", and 
that's just adding cognitive load for the sake of not even saving a 
linewrap any more.

First, the wave of Sparse errors from the build bots hits because it 
turns out casting arbitrary pointers appropriately is hard. As it washes 
past, the reality of authors' and maintainers' personal preferences 
comes to bear... some inevitably prefer to keep spelling out PTR_ERR() 
in probe_err() calls for the sake of clarity, bikeshedding ensues, and 
the checkpatch and Coccinelle armies mobilise to send unwanted patches 
changing things back and forth. Eventually, in all the confusion, a 
synapse misfires in a muddled developer's mind, an ERR_PTR value passed 
to kfree() "because kfree() is robust" slips through, and a bug is born. 
And there's the thing: inconsistency breeds bugs. Sometimes, of course, 
there are really good reasons to be inconsistent. Is 9 characters per 
line for a few hundred lines across the kernel tree really a really good 
reason?

The tersest code is not always the most maintainable. Consider that we 
could also save many more "tons of LoC" by rewriting an entire category 
of small if/else statements with ternaries. Would the overall effect on 
maintainability be positive? I don't think so.

And yeah, anyone who pipes up suggesting that places where an ERR_PTR 
value could be passed to probe_err() could simply refactor IS_ERR() 
checks with more uses of the god-awful PTR_ERR_OR_ZERO() obfuscator gets 
a long stare of disapproval...

Robin.

>> my immediate instinct is to be suspicious, and now I've got to go off
>> and double-check that if do_something_with() really expects a pointer
>> it's also robust against PTR_ERR values. Off-hand I can't think of any
>> APIs that work that way in the areas with which I'm familiar, so it
>> would be a pretty unusual and non-obvious thing.
> 
