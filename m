Return-Path: <SRS0=IaiW=7B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B012C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 20:44:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5C16A2072C
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 20:44:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cloud.ionos.com header.i=@cloud.ionos.com header.b="FQe0MjcG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727915AbgESUop (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 May 2020 16:44:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726178AbgESUop (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 16:44:45 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8A1BC08C5C0
        for <linux-kernel@vger.kernel.org>; Tue, 19 May 2020 13:44:44 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id e2so528634eje.13
        for <linux-kernel@vger.kernel.org>; Tue, 19 May 2020 13:44:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=dq6MmhdpWQ1+/bRGvo1+D3PoQjZqRUNhhynsJHzN/po=;
        b=FQe0MjcG4whscE8IVfyV4VlGc3tcST52+5l9zaF0KYdWQx0mRv/SdrojWQ48X27S4s
         y2OhUrmOOcq0zaMcxZSEQlgurcXnTKVmbrKmjeLuOraKR0d+1g39eSYgA14gWgi5iUR/
         B+CWi3+KJKm6w4kamP2tAdlvNxEFDEJF7x+Hu9F+FC9hawHkCKgdgKV73Tgm/T5KsSQv
         mxqktlrUlbigRptZWRxN9kcgxVjmdkSRiOeDGI1gPeGQVoVByNV11ig4v93dnYXfL7TA
         +3erE6XLKYVfq6Ri2DNanvao5huYLPywXE7+Lieh/SegFxrXDaCgOa8x3HB9YvjoOdzk
         k9jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=dq6MmhdpWQ1+/bRGvo1+D3PoQjZqRUNhhynsJHzN/po=;
        b=rECY1T7rJJGA10X3+FwvzyF8fEV30CAuXe3nJoy7QAY9gs3tBeBz4zRgMFNXDEwOor
         bBz+XyY69Ocj9dkjj8aiUlGslaOFNVx2ohYjdoSOxVf8da9RtkCF+YNYN0WWuBFfNRDw
         E6kSAW5CtDPo8nYajrVRgtf4LQ+Svrab+k0QLAB7gTISayXgvMNvESZbX1/N29OCgwqq
         XfnSRmY9M9j2sZngEmDtlqko9AxB4PvOb5aPjjIGARhIcnbyurzdkseip1UAp59Lo/yn
         j38Fvww5csxqj4LpJpAmwj4D+7mlb3nEKf9ccVau7EoPNBp4JE0/9vfwBBm4n1tlClnk
         d9gg==
X-Gm-Message-State: AOAM530H3cmPb6n432fVQ6zL4iAKDzIwUfPDbZorL3GBd6PmSW+w6M3N
        QVyRnUm8zKODo4xxBwKM12GGHw==
X-Google-Smtp-Source: ABdhPJxUGhPiICPdGNolDiKXxtpOhf3bIWNrvgaBzk7d6QBG/xTMYRWkcmggAWAnW4QYUZy0/fXCmA==
X-Received: by 2002:a17:906:5f98:: with SMTP id a24mr1022006eju.214.1589921083352;
        Tue, 19 May 2020 13:44:43 -0700 (PDT)
Received: from ?IPv6:2001:16b8:4852:3600:e80e:f5df:f780:7d57? ([2001:16b8:4852:3600:e80e:f5df:f780:7d57])
        by smtp.gmail.com with ESMTPSA id by21sm283208ejb.93.2020.05.19.13.44.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 May 2020 13:44:42 -0700 (PDT)
Subject: Re: [PATCH 10/10] mm/migrate.c: call detach_page_private to cleanup
 code
From:   Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, david@fromorbit.com,
        hch@infradead.org, willy@infradead.org
References: <20200517214718.468-1-guoqing.jiang@cloud.ionos.com>
 <20200517214718.468-11-guoqing.jiang@cloud.ionos.com>
 <20200518221235.1fa32c38e5766113f78e3f0d@linux-foundation.org>
 <aade5d75-c9e9-4021-6eb7-174a921a7958@cloud.ionos.com>
Message-ID: <4b367950-bc52-af31-818e-2b668bf08409@cloud.ionos.com>
Date:   Tue, 19 May 2020 22:44:42 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <aade5d75-c9e9-4021-6eb7-174a921a7958@cloud.ionos.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,

On 5/19/20 9:35 AM, Guoqing Jiang wrote:
> On 5/19/20 7:12 AM, Andrew Morton wrote:
>> On Sun, 17 May 2020 23:47:18 +0200 Guoqing Jiang 
>> <guoqing.jiang@cloud.ionos.com> wrote:
>>
>>> We can cleanup code a little by call detach_page_private here.
>>>
>>> ...
>>>
>>> --- a/mm/migrate.c
>>> +++ b/mm/migrate.c
>>> @@ -804,10 +804,7 @@ static int __buffer_migrate_page(struct 
>>> address_space *mapping,
>>>       if (rc != MIGRATEPAGE_SUCCESS)
>>>           goto unlock_buffers;
>>>   -    ClearPagePrivate(page);
>>> -    set_page_private(newpage, page_private(page));
>>> -    set_page_private(page, 0);
>>> -    put_page(page);
>>> +    set_page_private(newpage, detach_page_private(page));
>>>       get_page(newpage);
>>>         bh = head;
>> mm/migrate.c: In function '__buffer_migrate_page':
>> ./include/linux/mm_types.h:243:52: warning: assignment makes integer 
>> from pointer without a cast [-Wint-conversion]
>>   #define set_page_private(page, v) ((page)->private = (v))
>>                                                      ^
>> mm/migrate.c:800:2: note: in expansion of macro 'set_page_private'
>>    set_page_private(newpage, detach_page_private(page));
>>    ^~~~~~~~~~~~~~~~
>>
>> The fact that set_page_private(detach_page_private()) generates a type
>> mismatch warning seems deeply wrong, surely.
>>
>> Please let's get the types sorted out - either unsigned long or void *,
>> not half-one and half-the other.  Whatever needs the least typecasting
>> at callsites, I suggest.
>
> Sorry about that, I should notice the warning before. I will double 
> check if other
> places need the typecast or not, then send a new version.

Only this patch missed the typecast. I guess I just need to send an 
updated patch
to replace this one (I am fine to send a new patch set if you want), 
sorry again for
the trouble.

>
>> And can we please implement set_page_private() and page_private() with
>> inlined C code?  There is no need for these to be macros.
>
> Just did a quick change.
>
> -#define page_private(page)             ((page)->private)
> -#define set_page_private(page, v)      ((page)->private = (v))
> +static inline unsigned long page_private(struct page *page)
> +{
> +       return page->private;
> +}
> +
> +static inline void set_page_private(struct page *page, unsigned long 
> priv_data)
> +{
> +       page->private = priv_data;
> +}
>
> Then I get error like.
>
> fs/erofs/zdata.h: In function ‘z_erofs_onlinepage_index’:
> fs/erofs/zdata.h:126:8: error: lvalue required as unary ‘&’ operand
>   u.v = &page_private(page);
>         ^
>
> I guess it is better to keep page_private as macro, please correct me 
> in case I
> missed something.

Lost of problems need to be fixed if change page_private to inline 
function, so I
think it is better to keep it and only convert set_page_private.

mm/compaction.c: In function ‘isolate_migratepages_block’:
./include/linux/compiler.h:287:20: error: lvalue required as unary ‘&’ 
operand
    __read_once_size(&(x), __u.__c, sizeof(x));  \
                     ^
./include/linux/compiler.h:293:22: note: in expansion of macro ‘__READ_ONCE’
  #define READ_ONCE(x) __READ_ONCE(x, 1)
                       ^~~~~~~~~~~
mm/internal.h:293:34: note: in expansion of macro ‘READ_ONCE’
  #define page_order_unsafe(page)  READ_ONCE(page_private(page))


Thanks,
Guoqing
