Return-Path: <SRS0=XgUW=7G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80E9FC433E1
	for <linux-kernel@archiver.kernel.org>; Sun, 24 May 2020 19:02:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 615FA20812
	for <linux-kernel@archiver.kernel.org>; Sun, 24 May 2020 19:02:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cloud.ionos.com header.i=@cloud.ionos.com header.b="EihdGDV8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388029AbgEXTCO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 May 2020 15:02:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387959AbgEXTCO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 May 2020 15:02:14 -0400
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4745C05BD43
        for <linux-kernel@vger.kernel.org>; Sun, 24 May 2020 12:02:13 -0700 (PDT)
Received: by mail-ed1-x543.google.com with SMTP id e10so13383524edq.0
        for <linux-kernel@vger.kernel.org>; Sun, 24 May 2020 12:02:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=NdExbycL1SPe28Gb+MdOV9nbN2dI2hdaXFPv18IeMAg=;
        b=EihdGDV8DTCCItLUe55UOrENFyb05DSZZFt5otCI2w3esLVZRduPAy8kcVMgQxbbQA
         xrvdLIXUgxy+NtwjL6Tmi61NfUDG8uSN6PVorqtcU7wrOF1GyzNMLLedFfVMI0MITPQM
         g1KzX47Xw9oACK1tTfntYAJsdvZ1SLgavjlemJnNZqHsbppc96a6xyP/YsjIteoWHOoT
         /rMdjcVRaowknGg0F9QJzFuVSua6WfTVGj3IONKQ+AQ0muiNtPSwjX8/dUUM0CvvaZ2E
         4XN3wZEIE7V1REnfs10/U7RzieT8PB5OKxLdBb1AnNo9Ph19Zocu4kuOiU3TyMIkdBEU
         qRRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=NdExbycL1SPe28Gb+MdOV9nbN2dI2hdaXFPv18IeMAg=;
        b=bVSrTzkGUyJm/v8+/o1dUgOErRA84KEcLpbMnxhq5W3tLO0/TDRLQF8Afuymw4flvm
         LzkSLNGJDJbfgiN3zLN8LNrF6BTBuqjC6EPRgbqeqWnko1DDso8o78Y5XQd7tkPPpzHb
         PJqeSUr6E/RrVrzdACfvysmaCr2ONHDvLuDh2gL1BetA8LhH35W9fJUy3mFCBGio0Yg2
         w7ROv/QFALaZoLEMea4+Cac32gjGz+ddu2Tyno4lxviuQGiD+QKMoV5/I/TzbKnAgQ6N
         vf8HrCzL4ox9y7bUR4BXeZdwUh5EYgOfSiN06E5WYtGr9P7xPFkupOhb2ue5sNtNx5M6
         ESkA==
X-Gm-Message-State: AOAM531XqrIF9ala73KmPD5MZ5uEqpBgOgyerEzUDPhaohNU263CdTh8
        kv2WE3yrFVlYbhwZURuoLX4u6g==
X-Google-Smtp-Source: ABdhPJx70TkLhmO8i+OkEiZF8MWZU6qbvddsMCi218Rg7XEbcs0fAi1TS3ocdNoO6PZr3ncYMGS6lA==
X-Received: by 2002:aa7:d71a:: with SMTP id t26mr6719843edq.123.1590346932202;
        Sun, 24 May 2020 12:02:12 -0700 (PDT)
Received: from ?IPv6:2001:16b8:48bc:3c00:e80e:f5df:f780:7d57? ([2001:16b8:48bc:3c00:e80e:f5df:f780:7d57])
        by smtp.gmail.com with ESMTPSA id u17sm13588498ejg.1.2020.05.24.12.02.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 24 May 2020 12:02:11 -0700 (PDT)
Subject: Re: [PATCH 10/10] mm/migrate.c: call detach_page_private to cleanup
 code
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Dave Chinner <david@fromorbit.com>, viro@zeniv.linux.org.uk,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        hch@infradead.org, willy@infradead.org
References: <20200517214718.468-1-guoqing.jiang@cloud.ionos.com>
 <20200517214718.468-11-guoqing.jiang@cloud.ionos.com>
 <20200521225220.GV2005@dread.disaster.area>
 <906f7469-492d-febc-c7ed-b01830ae900d@cloud.ionos.com>
 <20200522165301.727977de1d39ac5bfb683ed0@linux-foundation.org>
From:   Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
Message-ID: <54e99e19-0e84-c85b-b3f5-aa2c14ec6d65@cloud.ionos.com>
Date:   Sun, 24 May 2020 21:02:10 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200522165301.727977de1d39ac5bfb683ed0@linux-foundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/23/20 1:53 AM, Andrew Morton wrote:
> On Fri, 22 May 2020 09:18:25 +0200 Guoqing Jiang <guoqing.jiang@cloud.ionos.com> wrote:
>
>>>> -	ClearPagePrivate(page);
>>>> -	set_page_private(newpage, page_private(page));
>>>> -	set_page_private(page, 0);
>>>> -	put_page(page);
>>>> +	set_page_private(newpage, detach_page_private(page));
>>> attach_page_private(newpage, detach_page_private(page));
>> Mattew had suggested it as follows, but not sure if we can reorder of
>> the setup of
>> the bh and setting PagePrivate, so I didn't want to break the original
>> syntax.
>>
>> @@ -797,11 +797,7 @@ static int __buffer_migrate_page(struct address_space *mapping,
>>           if (rc != MIGRATEPAGE_SUCCESS)
>>                   goto unlock_buffers;
>>    
>> -       ClearPagePrivate(page);
>> -       set_page_private(newpage, page_private(page));
>> -       set_page_private(page, 0);
>> -       put_page(page);
>> -       get_page(newpage);
>> +       attach_page_private(newpage, detach_page_private(page));
>>    
>>           bh = head;
>>           do {
>> @@ -810,8 +806,6 @@ static int __buffer_migrate_page(struct address_space *mapping,
>>    
>>           } while (bh != head);
>>    
>> -       SetPagePrivate(newpage);
>> -
>>           if (mode != MIGRATE_SYNC_NO_COPY)
> This is OK - coherency between PG_private and the page's buffer
> ring is maintained by holding lock_page().

Appreciate for your explanation.

Thanks,
Guoqing

> I have (effectively) applied the above change.
