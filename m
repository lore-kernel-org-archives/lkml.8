Return-Path: <SRS0=RE5T=7A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2F4BC433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 20:45:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B8CB82075F
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 20:45:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="GyymXkan"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726628AbgERUpX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 May 2020 16:45:23 -0400
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:16615 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726250AbgERUpX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 16:45:23 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5ec2f3550000>; Mon, 18 May 2020 13:43:01 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Mon, 18 May 2020 13:45:23 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Mon, 18 May 2020 13:45:23 -0700
Received: from [10.2.55.90] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 18 May
 2020 20:45:23 +0000
Subject: Re: [RFC] mm/gup.c: Use gup_flags as parameter instead of passing
 write flag
To:     Souptick Joarder <jrdr.linux@gmail.com>,
        Matthew Wilcox <willy@infradead.org>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        Linux-MM <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
References: <1589831903-27800-1-git-send-email-jrdr.linux@gmail.com>
 <20200518201737.GV16070@bombadil.infradead.org>
 <CAFqt6zbcn5kEbtY1fod4yy_PETKX8zVM2NjsY0HHyOixiu2q4w@mail.gmail.com>
X-Nvconfidentiality: public
From:   John Hubbard <jhubbard@nvidia.com>
Message-ID: <975cc333-e9f4-29e4-db0e-00ea8b8a7c25@nvidia.com>
Date:   Mon, 18 May 2020 13:45:22 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <CAFqt6zbcn5kEbtY1fod4yy_PETKX8zVM2NjsY0HHyOixiu2q4w@mail.gmail.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1589834581; bh=ETg7oDnQAPuL0vMyRI/CbHbu8E+SOEsdUwm22tCAnLU=;
        h=X-PGP-Universal:Subject:To:CC:References:X-Nvconfidentiality:From:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=GyymXkanZutr+09L/dWOeefPVDI//sAgZNsA8dPfSFpciSS58Q3CIzlVjLHO76Nhp
         50i0yZV+QYWQFd0OExdjQsfvMRIvReSnHxRr11TPIsBv73/9IKW0FqpoVSvjqPyxQo
         lJKwxgvG2ju8DvL8E9XuHg2knObVvmuPk8Zcz9yfFE+xOEp+STwT3C1WpSSBmD2jmI
         PQ25nQfHUXY2GqTf+HmPKaurXX+Y5D9d+e6wjlaw17BbpdHq1UNmHjG0PFt4Nmxmy3
         iPIpsagw8tzOTmyVb8lDdrP3OV5kldhRe+VW/kDSn6Tv6QAn5kyTOHtt5zYM8wu3LO
         C71DsYpo5n6Tg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-05-18 13:44, Souptick Joarder wrote:
> On Tue 19 May, 2020, 1:47 AM Matthew Wilcox, <willy@infradead.org> wrote:
>>
>> On Tue, May 19, 2020 at 01:28:23AM +0530, Souptick Joarder wrote:
>>> The idea is to get rid of write parameter. Instead caller will pass
>>> FOLL_WRITE to __get_user_pages_fast(). This will not change any
>>> functionality of the API. Once it is upstream all the callers will
>>> be changed to pass FOLL_WRITE.
>>
>> Uhh ... until you change all the callers, haven't you just broken all
>> the callers?
> 
> All the callers have called the API with either 1 or 0.  I think, it's
> not going to break
> any of the callers.

Maybe so, but it's still "wrong" to do that, because it only works more
or less accidentally. That is, it works in spite of a type safety
violation. So we don't want to do that sort of thing unless there is
a compelling reason.

In addition to that, I am at the exact moment putting together a minor
refactoring of this function, because I need a FOLL_PIN variant:
__pin_user_pages_fast(), as part of my work to change over a few dozen
gup call sites to pin_user_pages*().

(In fact, I was wondering whether to stick with the "write" parameter, for
the new __pin_user_pages_fast(), or go with gup_flags. That could go either
way: gup_flags provides a nicer API, but "write" matches the existing
callers.)

So in other words, if you do go out and change all the call sites (there only
seem to be about 7, outside of gup.c, actually), that's going to conflict
a little bit with what I'm doing here.

So, how would you like proceed? If you want to do the full conversion
(which really should include the call sites), it would be easier for me
if you based it on my upcoming small patchset, which I expect to post
shortly (later today).

thanks,
-- 
John Hubbard
NVIDIA

> 
>>
>>> -int __get_user_pages_fast(unsigned long start, int nr_pages, int write,
>>> -                       struct page **pages)
>>> +int __get_user_pages_fast(unsigned long start, int nr_pages,
>>> +                     unsigned int gup_flags, struct page **pages)
>>>   {
>>>        unsigned long len, end;
>>>        unsigned long flags;
>>> @@ -2685,10 +2692,7 @@ int __get_user_pages_fast(unsigned long start, int nr_pages, int write,
>>>         * Internally (within mm/gup.c), gup fast variants must set FOLL_GET,
>>>         * because gup fast is always a "pin with a +1 page refcount" request.
>>>         */
>>> -     unsigned int gup_flags = FOLL_GET;
>>> -
>>> -     if (write)
>>> -             gup_flags |= FOLL_WRITE;
>>> +     gup_flags |= FOLL_GET;
> 

