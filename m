Return-Path: <SRS0=IaiW=7B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC611C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 07:36:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A9AB6204EF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 07:36:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cloud.ionos.com header.i=@cloud.ionos.com header.b="Zfm+GoDG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728475AbgESHgF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 May 2020 03:36:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725996AbgESHgE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 03:36:04 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2140EC061A0C
        for <linux-kernel@vger.kernel.org>; Tue, 19 May 2020 00:36:03 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id h4so1935776wmb.4
        for <linux-kernel@vger.kernel.org>; Tue, 19 May 2020 00:36:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=2I0Cwdw6DhsE7UCLIzHUkREHb8Z7quMrqFm7k861wNU=;
        b=Zfm+GoDGAh6O02kDPdw+5lm+mfVDoQFoQhO59WXiVOjRyP70rU3Q68xjWYdAH/lRcE
         gOSWlKUSr7lDTl+t8mLf8NlPFysXqalk8HsdRai1ewWANsIf79IfTkkk292KkmnyCG9t
         y6enMk0cUjyajrdDRsPizDqg8pEIpcARF25oD+vUqk23qIx9hJFUHLT4ZjFu2nFvMkzY
         +hqC2D146wcsXnAvkXXdfAhaOig6kK9oSpOm6mBDf/6chopXBgF23EhSrA/sAMAQQfdP
         GSk+lGzF/sqWsdgYckZgGDRxvGIzc1t1lEAaa7iQRmx/BQMN06FajyELdZtWSi7MAhkQ
         C6lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=2I0Cwdw6DhsE7UCLIzHUkREHb8Z7quMrqFm7k861wNU=;
        b=GwAcP+EcgCqgYVLwz8z61XN5N+3hGkajoPv9o9brNgn06B4ETKl0XuayooYExVW9S5
         xNiUhfa8gOu5ZBlOEG89fomGiGUGNAwwMV6jOWwElo+zaIU/Y7svOY7waBiMYFBXYJJV
         VT7dGak7BZDKcs0E0MNUuLKzBYQk45VMEWKcV9K+440AR7y0XuMaN2YUJItVJnDyA65+
         yK4N3nXIwan74X073lHLw4zmytQYaxrg4Wlu6fuGN8l6CR7ZXhIg4pn8jc8T0THkyTAq
         1KlIbZD8I13lk6lS+S0lHI3b14T8SYZ5gDtYZHiRStTQan+Leuf1lYhd4x5nbTRRodHP
         i0VQ==
X-Gm-Message-State: AOAM531M85lJ5YlSZMMcvbW3GkCYHBUDkhwGbE686siAl5EJSgPHWWFs
        KmCQ+ZCRJB0O5kWSN24NN8U1gA==
X-Google-Smtp-Source: ABdhPJzIrzt6E86Ntqvw6Kik1NO2R+nekuZj+7j8JCrJZslvo541OcVjHEtEOWZiZNG8sG5Enxlwxw==
X-Received: by 2002:a1c:3585:: with SMTP id c127mr3784958wma.34.1589873760226;
        Tue, 19 May 2020 00:36:00 -0700 (PDT)
Received: from ?IPv6:2001:16b8:4852:3600:e80e:f5df:f780:7d57? ([2001:16b8:4852:3600:e80e:f5df:f780:7d57])
        by smtp.gmail.com with ESMTPSA id n9sm19679494wrv.43.2020.05.19.00.35.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 May 2020 00:35:59 -0700 (PDT)
Subject: Re: [PATCH 10/10] mm/migrate.c: call detach_page_private to cleanup
 code
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, david@fromorbit.com,
        hch@infradead.org, willy@infradead.org
References: <20200517214718.468-1-guoqing.jiang@cloud.ionos.com>
 <20200517214718.468-11-guoqing.jiang@cloud.ionos.com>
 <20200518221235.1fa32c38e5766113f78e3f0d@linux-foundation.org>
From:   Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
Message-ID: <aade5d75-c9e9-4021-6eb7-174a921a7958@cloud.ionos.com>
Date:   Tue, 19 May 2020 09:35:59 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200518221235.1fa32c38e5766113f78e3f0d@linux-foundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/19/20 7:12 AM, Andrew Morton wrote:
> On Sun, 17 May 2020 23:47:18 +0200 Guoqing Jiang <guoqing.jiang@cloud.ionos.com> wrote:
>
>> We can cleanup code a little by call detach_page_private here.
>>
>> ...
>>
>> --- a/mm/migrate.c
>> +++ b/mm/migrate.c
>> @@ -804,10 +804,7 @@ static int __buffer_migrate_page(struct address_space *mapping,
>>   	if (rc != MIGRATEPAGE_SUCCESS)
>>   		goto unlock_buffers;
>>   
>> -	ClearPagePrivate(page);
>> -	set_page_private(newpage, page_private(page));
>> -	set_page_private(page, 0);
>> -	put_page(page);
>> +	set_page_private(newpage, detach_page_private(page));
>>   	get_page(newpage);
>>   
>>   	bh = head;
> mm/migrate.c: In function '__buffer_migrate_page':
> ./include/linux/mm_types.h:243:52: warning: assignment makes integer from pointer without a cast [-Wint-conversion]
>   #define set_page_private(page, v) ((page)->private = (v))
>                                                      ^
> mm/migrate.c:800:2: note: in expansion of macro 'set_page_private'
>    set_page_private(newpage, detach_page_private(page));
>    ^~~~~~~~~~~~~~~~
>
> The fact that set_page_private(detach_page_private()) generates a type
> mismatch warning seems deeply wrong, surely.
>
> Please let's get the types sorted out - either unsigned long or void *,
> not half-one and half-the other.  Whatever needs the least typecasting
> at callsites, I suggest.

Sorry about that, I should notice the warning before. I will double 
check if other
places need the typecast or not, then send a new version.

> And can we please implement set_page_private() and page_private() with
> inlined C code?  There is no need for these to be macros.

Just did a quick change.

-#define page_private(page)             ((page)->private)
-#define set_page_private(page, v)      ((page)->private = (v))
+static inline unsigned long page_private(struct page *page)
+{
+       return page->private;
+}
+
+static inline void set_page_private(struct page *page, unsigned long 
priv_data)
+{
+       page->private = priv_data;
+}

Then I get error like.

fs/erofs/zdata.h: In function ‘z_erofs_onlinepage_index’:
fs/erofs/zdata.h:126:8: error: lvalue required as unary ‘&’ operand
   u.v = &page_private(page);
         ^

I guess it is better to keep page_private as macro, please correct me in 
case I
missed something.

Thanks,
Guoqing

