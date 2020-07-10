Return-Path: <SRS0=2Lxt=AV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D63E2C433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 16:31:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B598720657
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 16:31:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="OashMJfM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728212AbgGJQbA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jul 2020 12:31:00 -0400
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:3136 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726920AbgGJQa6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jul 2020 12:30:58 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5f0897550003>; Fri, 10 Jul 2020 09:29:09 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Fri, 10 Jul 2020 09:30:58 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Fri, 10 Jul 2020 09:30:58 -0700
Received: from [10.26.72.135] (172.20.13.39) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 10 Jul
 2020 16:30:56 +0000
Subject: Re: [PATCH v2 4/6] devres: handle zero size in devm_kmalloc()
To:     Bartosz Golaszewski <brgl@bgdev.pl>
CC:     Jonathan Corbet <corbet@lwn.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Jean Delvare <jdelvare@suse.com>,
        linux-doc <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        <linux-hwmon@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
References: <20200629065008.27620-1-brgl@bgdev.pl>
 <20200629065008.27620-5-brgl@bgdev.pl>
 <5c2e7514-b6d0-1331-37b0-d17a0cdb9693@nvidia.com>
 <CAMRc=Mf1Laqa65hEOG3iLSQu6J-u5yHmrMNh8NMJmt3amw2A6Q@mail.gmail.com>
 <9cd4521b-aba0-616b-8957-8f21b9ba3068@nvidia.com>
 <CAMRc=Md+iHTeaYi1F-ykb3HaDTBoiGuNr7s224ay9Jgfhy1TcA@mail.gmail.com>
From:   Jon Hunter <jonathanh@nvidia.com>
Message-ID: <c780f571-9aef-d02a-a9c0-677f6c1f7a0b@nvidia.com>
Date:   Fri, 10 Jul 2020 17:30:54 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <CAMRc=Md+iHTeaYi1F-ykb3HaDTBoiGuNr7s224ay9Jgfhy1TcA@mail.gmail.com>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1594398549; bh=wPbMvPXTwmmZyNSlsW+QBsjbAUy/OrrNRVHRg/UgtC4=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=OashMJfMHNodUZ63liXAW3lX8xNoFwNA2F0TimvpIET1HqnGobjCjh6h87sXKCJql
         tDhnHi1dCFssHAeIFR5AHL/q3c37gKZ//xE+w12I6lP8mUC/zpJcTK6aGhcTLaHQmI
         uIlhILBmtYgv0x3rTVPkBghDJFD5j2S5nLKktfY+G3nCpS/BdW/eUXhXNMgJx7TY0V
         ulE96GaL52cPLA5o64y0xhHsfpCvXHzPuCw1iCWn5E8qhM2MPwgjUSCHq6IJ+JYVTf
         1Gx1Bs8swFAWDSWul6nQAZi84ZRGcRumhRM/M7mlfRXvMLBv9ZaCyIpb5WXruCMI7X
         JkfNQG7rQAxPQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 10/07/2020 17:24, Bartosz Golaszewski wrote:
> On Fri, Jul 10, 2020 at 6:11 PM Jon Hunter <jonathanh@nvidia.com> wrote:
>>
>>
>> On 10/07/2020 17:03, Bartosz Golaszewski wrote:
>>> On Fri, Jul 10, 2020 at 3:46 PM Jon Hunter <jonathanh@nvidia.com> wrote:
>>>>
>>>> Hi Bartosz,
>>>>
>>>> On 29/06/2020 07:50, Bartosz Golaszewski wrote:
>>>>> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
>>>>>
>>>>> Make devm_kmalloc() behave similarly to non-managed kmalloc(): return
>>>>> ZERO_SIZE_PTR when requested size is 0. Update devm_kfree() to handle
>>>>> this case.
>>>>>
>>>>> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
>>>>> ---
>>>>>  drivers/base/devres.c | 9 ++++++---
>>>>>  1 file changed, 6 insertions(+), 3 deletions(-)
>>>>>
>>>>> diff --git a/drivers/base/devres.c b/drivers/base/devres.c
>>>>> index 1df1fb10b2d9..ed615d3b9cf1 100644
>>>>> --- a/drivers/base/devres.c
>>>>> +++ b/drivers/base/devres.c
>>>>> @@ -819,6 +819,9 @@ void *devm_kmalloc(struct device *dev, size_t size, gfp_t gfp)
>>>>>  {
>>>>>       struct devres *dr;
>>>>>
>>>>> +     if (unlikely(!size))
>>>>> +             return ZERO_SIZE_PTR;
>>>>> +
>>>>>       /* use raw alloc_dr for kmalloc caller tracing */
>>>>>       dr = alloc_dr(devm_kmalloc_release, size, gfp, dev_to_node(dev));
>>>>>       if (unlikely(!dr))
>>>>> @@ -950,10 +953,10 @@ void devm_kfree(struct device *dev, const void *p)
>>>>>       int rc;
>>>>>
>>>>>       /*
>>>>> -      * Special case: pointer to a string in .rodata returned by
>>>>> -      * devm_kstrdup_const().
>>>>> +      * Special cases: pointer to a string in .rodata returned by
>>>>> +      * devm_kstrdup_const() or NULL/ZERO ptr.
>>>>>        */
>>>>> -     if (unlikely(is_kernel_rodata((unsigned long)p)))
>>>>> +     if (unlikely(is_kernel_rodata((unsigned long)p) || ZERO_OR_NULL_PTR(p)))
>>>>>               return;
>>>>>
>>>>>       rc = devres_destroy(dev, devm_kmalloc_release,
>>>>
>>>>
>>>> This change caught a bug in one of our Tegra drivers, which I am in the
>>>> process of fixing. Once I bisected to this commit it was easy to track
>>>> down, but I am wondering if there is any reason why we don't add a
>>>> WARN_ON() if size is 0 in devm_kmalloc? It was essentially what I ended
>>>> up doing to find the bug.
>>>>
>>>> Jon
>>>>
>>>> --
>>>> nvpublic
>>>
>>> Hi Jon,
>>>
>>> this is in line with what the regular kmalloc() does. If size is zero,
>>> it returns ZERO_SIZE_PTR. It's not an error condition. Actually in
>>> user-space malloc() does a similar thing: for size == 0 it allocates
>>> one-byte and returns a pointer to it (at least in glibc).
>>
>>
>> Yes that's fine, I was just wondering if there is any reason not to WARN
>> as well?
>>
>> Cheers
>> Jon
>>
> 
> Why? Nothing bad happens. Regular kmalloc() doesn't warn, why should
> devm_kmalloc() do?


Simply because it is easier to track down a bug. In my case the NULL
pointer crash did not occur until entering suspend when the memory, that
was allocated at probe time, was first actually accessed. So it was not
immediately obvious which call to devm_kmalloc caused the problem.
Anyway, if kmalloc does not warn either, then fine, it was purely a
question.

Jon

-- 
nvpublic
