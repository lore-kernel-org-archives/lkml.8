Return-Path: <SRS0=3e5Q=77=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EF1AC433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 09:28:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3A05F21974
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 09:28:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729144AbgFRJ2g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jun 2020 05:28:36 -0400
Received: from foss.arm.com ([217.140.110.172]:46806 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728943AbgFRJ2e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jun 2020 05:28:34 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5C7EC1045;
        Thu, 18 Jun 2020 02:28:33 -0700 (PDT)
Received: from [192.168.1.84] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 483DF3F6CF;
        Thu, 18 Jun 2020 02:28:32 -0700 (PDT)
Subject: Re: [PATCH v3] drm/panfrost: Reduce the amount of logs on deferred
 probe
To:     Rob Herring <robh@kernel.org>
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>
References: <20200527200544.7849-1-krzk@kernel.org>
 <20200527204334.GA15485@kevin> <20200617141547.GA30516@kozik-lap>
 <b41bfead-7b73-be78-c63f-79a0a7e23b2a@arm.com>
 <CAL_JsqLrFFOVQVR0dWbru6bJvz7sXs8v6Op-hiNgdMwH3N=2Fw@mail.gmail.com>
From:   Steven Price <steven.price@arm.com>
Message-ID: <cd609ad6-9672-9fdd-e693-f15395cb6fd0@arm.com>
Date:   Thu, 18 Jun 2020 10:28:31 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <CAL_JsqLrFFOVQVR0dWbru6bJvz7sXs8v6Op-hiNgdMwH3N=2Fw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/06/2020 20:57, Rob Herring wrote:
> On Wed, Jun 17, 2020 at 8:36 AM Steven Price <steven.price@arm.com> wrote:
>>
>> On 17/06/2020 15:15, Krzysztof Kozlowski wrote:
>>> On Wed, May 27, 2020 at 04:43:34PM -0400, Alyssa Rosenzweig wrote:
>>>> Reviewed-by: Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>
>>>>
>>>> On Wed, May 27, 2020 at 10:05:44PM +0200, Krzysztof Kozlowski wrote:
>>>>> There is no point to print deferred probe (and its failures to get
>>>>> resources) as an error.  Also there is no need to print regulator errors
>>>>> twice.
>>>>>
>>>>> In case of multiple probe tries this would pollute the dmesg.
>>>>>
>>>>> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
>>>>> Reviewed-by: Steven Price <steven.price@arm.com>
>>>>>
>>>>> ---
>>>>>
>>>>> Changes since v2:
>>>>> 1. Rebase
>>>>> 2. Add Steven's review
>>>>>
>>>>> Changes since v1:
>>>>> 1. Remove second error message from calling panfrost_regulator_init()
>>>>> ---
>>>>>    drivers/gpu/drm/panfrost/panfrost_device.c | 8 ++++----
>>>>>    1 file changed, 4 insertions(+), 4 deletions(-)
>>>>>
>>>
>>> Hi Rob, Tomeu and Steven,
>>>
>>> You're listed as maintainers for panfrost. Is anyone going to pick this
>>> up?
>>
>> I'm only a reviewer so I've been leaving it for Rob or Tomeu, but I can
>> pick it up if Rob/Tomeu are happy for me to do that.
>>
>>> Maybe I sent it to wrong mailing list or forgot about anything?
>>
>> No, there's actually a few Panfrost commits waiting, it was on my todo
>> list to ask if Rob/Tomeu needed some help with merging patches.
> 
> Please do, I haven't had the cycles for panfrost lately.
> 
> Rob
> 

Ok, this patch is pushed to drm-misc-next. I'll dig through my emails 
for the other patches which are pending and take a look at them too.

Steve
