Return-Path: <SRS0=kGB5=CE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1ABAAC433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 17:20:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EA0842078D
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 17:20:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c3gUSVlD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727043AbgHZRUs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Aug 2020 13:20:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725995AbgHZRUo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Aug 2020 13:20:44 -0400
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 736B1C061574;
        Wed, 26 Aug 2020 10:20:44 -0700 (PDT)
Received: by mail-qt1-x841.google.com with SMTP id t23so2025818qto.3;
        Wed, 26 Aug 2020 10:20:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=wSED4ESvd7iAdE/O7jBMYhtVsvuSpxlXjFlIkcHc+zM=;
        b=c3gUSVlDW5AcjSvdZVhlSt1dPojJYuyaw6hvXfSRDxI/PzBa7l/l20B7Vxg4LCukI4
         0pURKybdgjCf5+OwBPA1uaHRRZSTF2zAgVrU+j4WIg94xvku1pGhJKSon32WxUWgP+0R
         lJjWoVqlLsbR81J9dmyK5QJz8pyy+dj9L+vK2WHkozMYDyio8+L/C1WazoAqzSZt8vXK
         gcp/bMLOvoCPQ+OcfNLnSDc1m9K9BIv+YLV6YuGGFmA9psovlKlgBps9HCQ98B/a5SCI
         9yRizlesPEY5i2P8RijrCtGhnYuuyPBCrPQP3uQBA0Tz/1HBwl8gPs8UrBOKazwSypJZ
         0F7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=wSED4ESvd7iAdE/O7jBMYhtVsvuSpxlXjFlIkcHc+zM=;
        b=tEGNd5q7KusKVVjgEJpVXtbBhmJMfeALj4CVk5lrBkdxMT4o9407P90bXStebAcDfJ
         hbpP4fIypZsQjD+c8EUAd++GhxX7ndwniJdhzOA2AwDGw/PEUHjer9jXx/avLNK6GoiS
         DA2E0PCPgnVsZ6WeW+NqqtsNFb4TuEyYSOHv52b7sugi4W2MVe6wmV9JKRmi3EULdvxB
         n1n/PJklISF0L5WDIZJDKaeB5BmA0ONS3+ou/oNEgtgRfEcYJAb3f4QE9CcV7If9CFBO
         bGg3qkT6cIM5d4JLMgvZDU2adK7jxuAX5CL3hYE3bkoDAMTmeg1ssBHGyBLui3gPe1XL
         +VpA==
X-Gm-Message-State: AOAM530KAyBAKb6nUKgLsu3ZMgMLVMvdGNzUfa92dOSRD6YGBsPuGIVi
        w7qJ1a37mz+WYtp2RaMe26c=
X-Google-Smtp-Source: ABdhPJzG8WHg8V2HrVwKceC5v/SufchJ1BjCTQXaSsVpduhD3FVXXV5jBbqbGxM/fegiME+/a/jpDQ==
X-Received: by 2002:aed:2821:: with SMTP id r30mr14914331qtd.3.1598462442746;
        Wed, 26 Aug 2020 10:20:42 -0700 (PDT)
Received: from [192.168.1.181] (pool-173-75-208-99.phlapa.fios.verizon.net. [173.75.208.99])
        by smtp.gmail.com with ESMTPSA id d8sm2432241qtn.70.2020.08.26.10.20.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Aug 2020 10:20:42 -0700 (PDT)
Subject: Re: [GIT PULL] USB fixes for 5.9-rc3
To:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Greg KH <gregkh@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        USB <linux-usb@vger.kernel.org>,
        Ilja Van Sprundel <ivansprundel@ioactive.com>,
        Kees Cook <keescook@chromium.org>,
        Felipe Balbi <balbi@kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
References: <20200826134315.GA3882506@kroah.com>
 <CGME20200826150239eucas1p24c59716cc31edfeb2eece84d97936b93@eucas1p2.samsung.com>
 <1425ab4f-ef7e-97d9-238f-0328ab51eb35@samsung.com>
 <20200826153347.GB4187816@kroah.com>
 <CAHp75VepkugjZ4pvdNgxzT4T83ewL1AFtSZZtVq6aL+7=sqskA@mail.gmail.com>
 <de6aea2f-5f31-4391-0c36-8fd5fd63ab05@samsung.com>
From:   Brooke Basile <brookebasile@gmail.com>
Message-ID: <c8c7edb3-c9b9-58cb-ceb7-4b573b78a4f6@gmail.com>
Date:   Wed, 26 Aug 2020 13:20:41 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <de6aea2f-5f31-4391-0c36-8fd5fd63ab05@samsung.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/26/20 12:17 PM, Marek Szyprowski wrote:
> Hi Andy,
> 
> On 26.08.2020 17:53, Andy Shevchenko wrote:
>> On Wed, Aug 26, 2020 at 6:36 PM Greg KH <gregkh@linuxfoundation.org> wrote:
>>> On Wed, Aug 26, 2020 at 05:02:38PM +0200, Marek Szyprowski wrote:
>>>> On 26.08.2020 15:43, Greg KH wrote:
>>>>
>>>>> Brooke Basile (2):
>>>>>          USB: gadget: u_f: add overflow checks to VLA macros
>>>> Sorry, but the above patch breaks USB Ethernet Gadget operation. It also
>>>> didn't get the proper testing in linux-next (next-20200826 is the first
>>>> one with this patch).
>>>>
>>>> This is how it explodes on Samsung Exynos (ARM 32bit) based board with
>>>> g_ether module loaded:
>>> Odd, for a "normal" descriptor, the logic should have remained the same
>>> as without this patch.
>>> Brooke, any ideas?
>> I have an idea.
>>
>> Does below fix this?
> 
> Yep, that's it. I've also moved offset assignment in the first part
> after size_t size = array_size(n, sizeof(type));
> 
> Feel free to add:
> 
> Reported-by: Marek Szyprowski <m.szyprowski@samsung.com>
> 
> Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>
> 
> Thanks!
> 
> Best regards
> 
Ah, I see.  My apologies, I don't know how I was able to miss something 
like this when building/testing...

Thank you for testing and reporting the issue.

Best,
Brooke Basile
