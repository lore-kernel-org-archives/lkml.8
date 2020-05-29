Return-Path: <SRS0=LUA0=7L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C7FEC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 08:00:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 74A54206A1
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 08:00:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="DRyH6k0v"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725939AbgE2IAX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 May 2020 04:00:23 -0400
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:5888 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725355AbgE2IAX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 May 2020 04:00:23 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5ed0c10b0000>; Fri, 29 May 2020 01:00:11 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Fri, 29 May 2020 01:00:22 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Fri, 29 May 2020 01:00:22 -0700
Received: from [10.2.62.53] (172.20.13.39) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 29 May
 2020 08:00:22 +0000
Subject: Re: [PATCH] staging: gasket: Convert get_user_pages*() -->
 pin_user_pages*()
To:     Dan Carpenter <dan.carpenter@oracle.com>,
        Souptick Joarder <jrdr.linux@gmail.com>
CC:     "open list:ANDROID DRIVERS" <devel@driverdev.osuosl.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        <linux-kernel@vger.kernel.org>,
        Rob Springer <rspringer@google.com>,
        Todd Poynor <toddpoynor@google.com>
References: <1590613362-27495-1-git-send-email-jrdr.linux@gmail.com>
 <20200528110408.GJ30374@kadam>
 <CAFqt6zaKWBQTy9XfvxwVAvzGS+gz9Qv1gL8Bv1VxLq+THYf+Aw@mail.gmail.com>
 <CAFqt6zbtg0NWbAnDGPC0ZddEiTeohz=8JN+S_KxqM0bnnvar3g@mail.gmail.com>
 <20200529074658.GM30374@kadam>
X-Nvconfidentiality: public
From:   John Hubbard <jhubbard@nvidia.com>
Message-ID: <88daa048-7fc3-2d46-d582-02a7aaa7a970@nvidia.com>
Date:   Fri, 29 May 2020 01:00:22 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
MIME-Version: 1.0
In-Reply-To: <20200529074658.GM30374@kadam>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1590739211; bh=vhBpXVZGiT9PxDZjUGkjOLEAXZrix22qc70Hb8992VU=;
        h=X-PGP-Universal:Subject:To:CC:References:X-Nvconfidentiality:From:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=DRyH6k0vexcFUfjYgZogoJtWjLGPUbkTK/d6PJ7MTCCKtYPBrQ6VI1CkcSD/ds4BO
         rrHYsDx0XrTYx/Xv20LQkHyw1cNrMDCDPo94rBT4SkkcwCxh4AqUu3gqN9zkTFFMS3
         f6LzBkDYj31XG5Ed+WEb6FBKxQCeLf1lJ8OmECo6kDKPRfOIeER6yBo6kvdcKc2i4l
         YnxGFdVJoSf/KOlk/lj1KQcC9XKMK6r/s9QgHVbhiJvW5cE/ALVs1s5ozTt+Y7Ocqy
         4pS9eJqcWJJknpENobGsj+d/lSmIz88lbQHyBo1kdiEBaJ8FTZXDsdw0SdJsM7fcM+
         s6x6G/187YRzA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-05-29 00:46, Dan Carpenter wrote:
> On Fri, May 29, 2020 at 11:57:09AM +0530, Souptick Joarder wrote:
>> On Fri, May 29, 2020 at 11:46 AM Souptick Joarder <jrdr.linux@gmail.com> wrote:
>>>
>>> On Thu, May 28, 2020 at 4:34 PM Dan Carpenter <dan.carpenter@oracle.com> wrote:
>>>>
>>>> On Thu, May 28, 2020 at 02:32:42AM +0530, Souptick Joarder wrote:
>>>>> This code was using get_user_pages_fast(), in a "Case 2" scenario
>>>>> (DMA/RDMA), using the categorization from [1]. That means that it's
>>>>> time to convert the get_user_pages_fast() + put_page() calls to
>>>>> pin_user_pages_fast() + unpin_user_page() calls.
>>>>
>>>> You are saying that the page is used for DIO and not DMA, but it sure
>>>> looks to me like it is used for DMA.
>>>
>>> No, I was referring to "Case 2" scenario in change log which means  it is
>>> used for DMA, not DIO.
> 
> You can't use pin_user_pages() for DMA.  This was second reason that I
> was confused.


OK, now it is getting interesting!


> 
> mm/gup.c
>    2863  /**
>    2864   * pin_user_pages_fast() - pin user pages in memory without taking locks
>    2865   *
>    2866   * @start:      starting user address
>    2867   * @nr_pages:   number of pages from start to pin
>    2868   * @gup_flags:  flags modifying pin behaviour
>    2869   * @pages:      array that receives pointers to the pages pinned.
>    2870   *              Should be at least nr_pages long.
>    2871   *
>    2872   * Nearly the same as get_user_pages_fast(), except that FOLL_PIN is set. See
>    2873   * get_user_pages_fast() for documentation on the function arguments, because
>    2874   * the arguments here are identical.
>    2875   *
>    2876   * FOLL_PIN means that the pages must be released via unpin_user_page(). Please
>    2877   * see Documentation/core-api/pin_user_pages.rst for further details.
>    2878   *
>    2879   * This is intended for Case 1 (DIO) in Documentation/core-api/pin_user_pages.rst. It
>             ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>    2880   * is NOT intended for Case 2 (RDMA: long-term pins).
>             ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^


I'm trying to figure out why I wrote that. It seems just wrong, because once the
page is dma-pinned, it will work just fine for either Case 1 or Case 2. hmmm, I
think this was from a few design ideas ago, when we were still working through the
FOLL_LONGTERM and FOLL_PIN thoughts and how the pin_user_pages*() API set should
look.

At this point, it's looking very much like a (my) documentation bug: all 4 of the
"intended for Case 1 (DIO)" comments in mm/gup.c probably need to be simply deleted.
Good catch.



>    2881   */
>    2882  int pin_user_pages_fast(unsigned long start, int nr_pages,
>    2883                          unsigned int gup_flags, struct page **pages)
>    2884  {
>    2885          /* FOLL_GET and FOLL_PIN are mutually exclusive. */
>    2886          if (WARN_ON_ONCE(gup_flags & FOLL_GET))
>    2887                  return -EINVAL;
>    2888
>    2889          gup_flags |= FOLL_PIN;
>    2890          return internal_get_user_pages_fast(start, nr_pages, gup_flags, pages);
>    2891  }
>    2892  EXPORT_SYMBOL_GPL(pin_user_pages_fast);
> 
> regards,
> dan carpenter
> 

thanks,
-- 
John Hubbard
NVIDIA
