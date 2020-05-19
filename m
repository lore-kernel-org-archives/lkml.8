Return-Path: <SRS0=IaiW=7B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03F92C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 11:02:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CB2E420709
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 11:02:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cloud.ionos.com header.i=@cloud.ionos.com header.b="Z00PO0N8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728662AbgESLCa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 May 2020 07:02:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726466AbgESLC3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 07:02:29 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47F2FC061A0C
        for <linux-kernel@vger.kernel.org>; Tue, 19 May 2020 04:02:29 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id u188so3031246wmu.1
        for <linux-kernel@vger.kernel.org>; Tue, 19 May 2020 04:02:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=s52mlTsjUnN/hszSD3ntozNUhM7CeKTjB2swQFJ/VzE=;
        b=Z00PO0N8bwJyW34sYknRVpaPebRO0XK1OTBruW9R958GWNdQABdXjhXKCj3an1V0mo
         wrpsjmdnoDOoQLEt+Ol72QBaSG4HdL9aqEnleXM4LD2BKyLCn1p43cN+/4kOpxt7QbgJ
         X01f+NwoGBjRxQVNwYiZefffVXfX54+cQXe9q6MHzbh/girOJQajR+d0ypFYK0hSNV1k
         4Kc78Xv3TbqKnjxjZ21yb7fOLyGbXCgOxFL4RDiRt6eNcdM/C+HefxzI+niJVTO5ABMB
         5Pjx94ww1pHP5bU/1BbVR/msjiSoXW9LbwSkoIHRac27xV4UFOe9f+rMLIXa2WB95yJW
         gSeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=s52mlTsjUnN/hszSD3ntozNUhM7CeKTjB2swQFJ/VzE=;
        b=DDvAEWU6oM88L5E1Z8nzPgcAEfnX1IR3qm6kruQ1HZrQ3Ucrw5sLnnC4VWECdiJc0Y
         euSYpb/MkE5bnTt4spvTOx7ITdV983CiRFZq2c1Q3nX1pqcReuT6fKJAtBgF2dkNXoI4
         DgiGykiyFLr61vc0sDc+QZ9RIdXw7j0iAvPWzW27DB+JIxWyex+1eEuFpQjgi258hchY
         dwe/H7/KIlhAHYwrSIXlDd18NFlgmGyqvrLtBp8WiDLHfgG13c9KvHUMuYWai6qmCRPQ
         oRVVgL/v6R4Aq182sIQmqO995KjneNtzSI7EouvEGAheREjYGlpcuFl+ZV/HoYIYHqDd
         OvFQ==
X-Gm-Message-State: AOAM533YtLEnrV3j4Aj6skQnRlhGSD4ysASf0s7FOzq27HuQ7lNLqhzS
        vENLPuBLa+iblYQXtHnAUP2ACw==
X-Google-Smtp-Source: ABdhPJxe0tKAyuywYHm+UA8QhlNek+QE4HYepKMS2CYRkPo3zEkUlfBFZUqqlsgVFKXTnrO2ho9M8Q==
X-Received: by 2002:a1c:1983:: with SMTP id 125mr4741395wmz.43.1589886147933;
        Tue, 19 May 2020 04:02:27 -0700 (PDT)
Received: from ?IPv6:2001:16b8:4852:3600:e80e:f5df:f780:7d57? ([2001:16b8:4852:3600:e80e:f5df:f780:7d57])
        by smtp.gmail.com with ESMTPSA id v5sm20365386wrr.93.2020.05.19.04.02.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 May 2020 04:02:27 -0700 (PDT)
Subject: Re: [PATCH 10/10] mm/migrate.c: call detach_page_private to cleanup
 code
To:     Gao Xiang <hsiangkao@gmx.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, viro@zeniv.linux.org.uk,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        david@fromorbit.com, hch@infradead.org, willy@infradead.org
References: <20200517214718.468-1-guoqing.jiang@cloud.ionos.com>
 <20200517214718.468-11-guoqing.jiang@cloud.ionos.com>
 <20200518221235.1fa32c38e5766113f78e3f0d@linux-foundation.org>
 <aade5d75-c9e9-4021-6eb7-174a921a7958@cloud.ionos.com>
 <20200519100612.GA3687@hsiangkao-HP-ZHAN-66-Pro-G1>
From:   Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
Message-ID: <d731fde0-6503-42f5-67b3-a4359a06bbb6@cloud.ionos.com>
Date:   Tue, 19 May 2020 13:02:26 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200519100612.GA3687@hsiangkao-HP-ZHAN-66-Pro-G1>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/19/20 12:06 PM, Gao Xiang wrote:
> On Tue, May 19, 2020 at 09:35:59AM +0200, Guoqing Jiang wrote:
>> On 5/19/20 7:12 AM, Andrew Morton wrote:
>>> On Sun, 17 May 2020 23:47:18 +0200 Guoqing Jiang <guoqing.jiang@cloud.ionos.com> wrote:
>>>
>>>> We can cleanup code a little by call detach_page_private here.
>>>>
>>>> ...
>>>>
>>>> --- a/mm/migrate.c
>>>> +++ b/mm/migrate.c
>>>> @@ -804,10 +804,7 @@ static int __buffer_migrate_page(struct address_space *mapping,
>>>>    	if (rc != MIGRATEPAGE_SUCCESS)
>>>>    		goto unlock_buffers;
>>>> -	ClearPagePrivate(page);
>>>> -	set_page_private(newpage, page_private(page));
>>>> -	set_page_private(page, 0);
>>>> -	put_page(page);
>>>> +	set_page_private(newpage, detach_page_private(page));
>>>>    	get_page(newpage);
>>>>    	bh = head;
>>> mm/migrate.c: In function '__buffer_migrate_page':
>>> ./include/linux/mm_types.h:243:52: warning: assignment makes integer from pointer without a cast [-Wint-conversion]
>>>    #define set_page_private(page, v) ((page)->private = (v))
>>>                                                       ^
>>> mm/migrate.c:800:2: note: in expansion of macro 'set_page_private'
>>>     set_page_private(newpage, detach_page_private(page));
>>>     ^~~~~~~~~~~~~~~~
>>>
>>> The fact that set_page_private(detach_page_private()) generates a type
>>> mismatch warning seems deeply wrong, surely.
>>>
>>> Please let's get the types sorted out - either unsigned long or void *,
>>> not half-one and half-the other.  Whatever needs the least typecasting
>>> at callsites, I suggest.
>> Sorry about that, I should notice the warning before. I will double check if
>> other
>> places need the typecast or not, then send a new version.
>>
>>> And can we please implement set_page_private() and page_private() with
>>> inlined C code?  There is no need for these to be macros.
>> Just did a quick change.
>>
>> -#define page_private(page)Â Â Â Â Â Â Â Â Â Â Â Â  ((page)->private)
>> -#define set_page_private(page, v)Â Â Â Â Â  ((page)->private = (v))
>> +static inline unsigned long page_private(struct page *page)
>> +{
>> +Â Â Â Â Â Â  return page->private;
>> +}
>> +
>> +static inline void set_page_private(struct page *page, unsigned long
>> priv_data)
>> +{
>> +Â Â Â Â Â Â  page->private = priv_data;
>> +}
>>
>> Then I get error like.
>>
>> fs/erofs/zdata.h: In function â€˜z_erofs_onlinepage_indexâ€™:
>> fs/erofs/zdata.h:126:8: error: lvalue required as unary â€˜&â€™ operand
>> Â  u.v = &page_private(page);
>> Â Â Â Â Â Â Â  ^
>>
>> I guess it is better to keep page_private as macro, please correct me in
>> case I
>> missed something.
> I guess that you could Cc me in the reply.

Sorry for not do that ...

> In that case, EROFS uses page->private as an atomic integer to
> trace 2 partial subpages in one page.
>
> I think that you could also use &page->private instead directly to
> replace &page_private(page) here since I didn't find some hint to
> pick &page_private(page) or &page->private.

Thanks for the input, I just did a quick test, so need to investigate more.
And I think it is better to have another thread to change those macros to
inline function, then fix related issues due to the change.

> In addition, I found some limitation of new {attach,detach}_page_private
> helper (that is why I was interested in this series at that time [1] [2],
> but I gave up finally) since many patterns (not all) in EROFS are
>
> io_submit (origin, page locked):
> attach_page_private(page);
> ...
> put_page(page);
>
> end_io (page locked):
> SetPageUptodate(page);
> unlock_page(page);
>
> since the page is always locked, so io_submit could be simplified as
> set_page_private(page, ...);
> SetPagePrivate(page);
> , which can save both one temporary get_page(page) and one
> put_page(page) since it could be regarded as safe with page locked.

The SetPageUptodate is not called inside {attach,detach}_page_private,
I could probably misunderstand your point, maybe you want the new pairs
can handle the locked page, care to elaborate more?

> btw, I noticed the patchset versions are PATCH [3], RFC PATCH [4],
> RFC PATCH v2 [5], RFC PATCH v3 [6], PATCH [7]. Although I also
> noticed the patchset title was once changed, but it could be some
> harder to trace the whole history discussion.
>
> [1] https://lore.kernel.org/linux-fsdevel/20200419051404.GA30986@hsiangkao-HP-ZHAN-66-Pro-G1/
> [2] https://lore.kernel.org/linux-fsdevel/20200427025752.GA3979@hsiangkao-HP-ZHAN-66-Pro-G1/
> [3] https://lore.kernel.org/linux-fsdevel/20200418225123.31850-1-guoqing.jiang@cloud.ionos.com/
> [4] https://lore.kernel.org/linux-fsdevel/20200426214925.10970-1-guoqing.jiang@cloud.ionos.com/
> [5] https://lore.kernel.org/linux-fsdevel/20200430214450.10662-1-guoqing.jiang@cloud.ionos.com/
> [6] https://lore.kernel.org/linux-fsdevel/20200507214400.15785-1-guoqing.jiang@cloud.ionos.com/
> [7] https://lore.kernel.org/linux-fsdevel/20200517214718.468-1-guoqing.jiang@cloud.ionos.com/

All the cover letter of those series are here.

RFC V3:https://lore.kernel.org/lkml/20200507214400.15785-1-guoqing.jiang@cloud.ionos.com/
RFC V2:https://lore.kernel.org/lkml/20200430214450.10662-1-guoqing.jiang@cloud.ionos.com/
RFC:https://lore.kernel.org/lkml/20200426214925.10970-1-guoqing.jiang@cloud.ionos.com/

And the latest one:

https://lore.kernel.org/lkml/20200430214450.10662-1-guoqing.jiang@cloud.ionos.com/


Thanks,
Guoqing
