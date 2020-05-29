Return-Path: <SRS0=LUA0=7L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C614CC433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 07:38:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A66592074D
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 07:38:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="LpUx1Wnc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725833AbgE2Hi3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 May 2020 03:38:29 -0400
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:18465 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725768AbgE2HiV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 May 2020 03:38:21 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5ed0bb980002>; Fri, 29 May 2020 00:36:56 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Fri, 29 May 2020 00:38:20 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Fri, 29 May 2020 00:38:20 -0700
Received: from [10.2.62.53] (172.20.13.39) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 29 May
 2020 07:38:20 +0000
Subject: Re: [PATCH] staging: gasket: Convert get_user_pages*() -->
 pin_user_pages*()
To:     Souptick Joarder <jrdr.linux@gmail.com>,
        Dan Carpenter <dan.carpenter@oracle.com>
CC:     Rob Springer <rspringer@google.com>,
        Todd Poynor <toddpoynor@google.com>, <benchan@chromium.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        "open list:ANDROID DRIVERS" <devel@driverdev.osuosl.org>,
        <linux-kernel@vger.kernel.org>
References: <1590613362-27495-1-git-send-email-jrdr.linux@gmail.com>
 <20200528110408.GJ30374@kadam>
 <CAFqt6zaKWBQTy9XfvxwVAvzGS+gz9Qv1gL8Bv1VxLq+THYf+Aw@mail.gmail.com>
 <CAFqt6zbtg0NWbAnDGPC0ZddEiTeohz=8JN+S_KxqM0bnnvar3g@mail.gmail.com>
X-Nvconfidentiality: public
From:   John Hubbard <jhubbard@nvidia.com>
Message-ID: <52f75ec4-a2a0-f979-a3b9-ef016b88907c@nvidia.com>
Date:   Fri, 29 May 2020 00:38:20 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
MIME-Version: 1.0
In-Reply-To: <CAFqt6zbtg0NWbAnDGPC0ZddEiTeohz=8JN+S_KxqM0bnnvar3g@mail.gmail.com>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1590737816; bh=XWCdO8mYOyEYgSPs/AOwnpRK3mO1gnW/W16YV5NbFoI=;
        h=X-PGP-Universal:Subject:To:CC:References:X-Nvconfidentiality:From:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=LpUx1Wncnmb399lTdHKiChW4/LIM/4KS90LFgdoM3OW6sX5VfId8KEPOTovNg/NKD
         e98V/5wu2deHhZOAfccSC4jlEHLf3K/ZDbRg7s6b1xkuN+Xw1ko1+pUogIi4nDHe2c
         N3jXmEhUoHB3tqGc/WjC1cYYv6XpDeEobHRH66FaDOT6/C9rRqG3AVbjTovluE0jcu
         4elCV1sbxRwbg9R354aIkaKBxrjHwffvXUBicyehr0YDFOtd2erEeK+EqqCRCBW/vy
         0ZrmJKVnl/OPnO8vNTMMdBn8fWW9JyBhuMhXkgVSNlmYQWF+Po+3iwMgS7nyZ31RMe
         X40kvrJCuDxtQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-05-28 23:27, Souptick Joarder wrote:
> On Fri, May 29, 2020 at 11:46 AM Souptick Joarder <jrdr.linux@gmail.com> wrote:
>>
>> On Thu, May 28, 2020 at 4:34 PM Dan Carpenter <dan.carpenter@oracle.com> wrote:
>>>
>>> On Thu, May 28, 2020 at 02:32:42AM +0530, Souptick Joarder wrote:
>>>> This code was using get_user_pages_fast(), in a "Case 2" scenario
>>>> (DMA/RDMA), using the categorization from [1]. That means that it's
>>>> time to convert the get_user_pages_fast() + put_page() calls to
>>>> pin_user_pages_fast() + unpin_user_page() calls.
>>>
>>> You are saying that the page is used for DIO and not DMA, but it sure
>>> looks to me like it is used for DMA.
>>
>> No, I was referring to "Case 2" scenario in change log which means  it is
>> used for DMA, not DIO.

Hi,

Dan, I also uncertain as to how you read this as referring to DIO. Case 2 is
DMA or RDMA, and in fact the proposed commit log says both of those things:
Case 2 and DMA/RDMA. I don't see "DIO" anywhere here...


>>
>>>
>>>     503                          /* Map the page into DMA space. */
>>>     504                          ptes[i].dma_addr =
>>>     505                                  dma_map_page(pg_tbl->device, page, 0, PAGE_SIZE,
>>>     506                                               DMA_BIDIRECTIONAL);
>>>
>>> To be honest, that starting paragraph was confusing.  At first I thought
>>> you were saying gasket was an RDMA driver. :P  I shouldn't have to read
>>> a different document to understand the commit message.  It should be
>>> summarized enough and the other documentation is supplemental.
>>>
>>> "In 2019 we introduced pin_user_pages() and now we are converting
>>> get_user_pages() to the new API as appropriate".
>>
>> As all other similar conversion have similar change logs, so I was trying
>> to maintain the same. John might have a different opinion on this.
> 
> For example, I was referring to few recent similar commits for change logs.
> 
> http://lkml.kernel.org/r/20200519002124.2025955-5-jhubbard@nvidia.com
> https://lore.kernel.org/r/20200518015237.1568940-1-jhubbard@nvidia.com
> 
> 
>>
>> John, Any further opinion ??


Well, I've gotten away with the current wording for quite a few patches so
far, but that sure doesn't mean it's perfect! :)

Maybe adding the words that Dan suggests, above, will suffice? Here:

 >>> "In 2019 we introduced pin_user_pages() and now we are converting
 >>> get_user_pages() to the new API as appropriate".


thanks,
-- 
John Hubbard
NVIDIA
