Return-Path: <SRS0=gItQ=AO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BCF6C433DF
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 19:24:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EF7092084C
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 19:24:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Cn44muIG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726693AbgGCTYF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jul 2020 15:24:05 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:44071 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726147AbgGCTYF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jul 2020 15:24:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1593804244;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=szNrRUnXkU/wXzHhuSNno6tjLuDfKJplDbKwsteOMYc=;
        b=Cn44muIGd7b/9SqdrVoMXQsAvZaeUPROsL5+mJvZ3Bee1cKMxjoYMcslPg7xbKr/ypXCQT
        iXtG+moUHmfYcpw/N7CAhYJITcpLiRfhpqtLV9DKahrUwaS/882NbTKI6VR12/6REPTeCJ
        QA+uR7uTnRNcO1Y5Au+slo5/fo2/eYI=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-254-LA8dt4VBMMi-IGn8CdzAPQ-1; Fri, 03 Jul 2020 15:24:02 -0400
X-MC-Unique: LA8dt4VBMMi-IGn8CdzAPQ-1
Received: by mail-qv1-f69.google.com with SMTP id r19so21021906qvz.7
        for <linux-kernel@vger.kernel.org>; Fri, 03 Jul 2020 12:24:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=szNrRUnXkU/wXzHhuSNno6tjLuDfKJplDbKwsteOMYc=;
        b=PJmGNwZTRCNOPKArZo4VkwpQl6p3ymsgruOSOtG+MkskIITAdfsAlvzVRcDy825SEu
         KxY1kTSyHcujvqkNNFMyer+29KovyuJBRQYgYrTpNi59r7qUDUq6cuJb8w6AMhhgbECA
         5GYkoKXYZk1SxfICHyr9SOZSmloLVTCYrSk4CuLb7QB83sFQHDxLFjTd5ZyKOPpEGSpr
         4RhyC7ckezE+t6brmnMe9j3C6oZ7InYO7ZcMO9bktPAooiZWpzmDrixcIlv9jtCGfHuY
         dFZXK/gZ+6fCh/YxCKOtacLKMPEwutskOrmfi3FFUgGg+sIZ1rkzCCjlRFb4GA7I9Q23
         8OrQ==
X-Gm-Message-State: AOAM531lbIXhom5G//OqHuqP8dU25UqwOjOOKooNA1o2XSh1nsYttTMg
        cy4D58dWGsnC0nvezR/o9vr+pSqNWwnarwlWCl9o3e7L8G7ShvNj2dasuH22XJzqnfc3Ru4fvzT
        UW6GyvLR0/DSDlqHIwHALAHbG
X-Received: by 2002:ad4:5a46:: with SMTP id ej6mr36640572qvb.52.1593804241999;
        Fri, 03 Jul 2020 12:24:01 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJycF3wW8f/a2ysnQEJ8tVL7mhIPYBL3A4AysD41s2ds0xEgv4QKsUjP796I+99lamtaNozpzA==
X-Received: by 2002:ad4:5a46:: with SMTP id ej6mr36640550qvb.52.1593804241666;
        Fri, 03 Jul 2020 12:24:01 -0700 (PDT)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id i8sm11202871qtr.90.2020.07.03.12.24.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Jul 2020 12:24:01 -0700 (PDT)
Subject: Re: [PATCH v2] mm: initialize return of vm_insert_pages
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20200703155354.29132-1-trix@redhat.com>
 <20200703120436.4031b4ea23e28a3babca3d2d@linux-foundation.org>
From:   Tom Rix <trix@redhat.com>
Message-ID: <3fdd71e8-d149-888c-b7de-99e5f68871a0@redhat.com>
Date:   Fri, 3 Jul 2020 12:23:59 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200703120436.4031b4ea23e28a3babca3d2d@linux-foundation.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 7/3/20 12:04 PM, Andrew Morton wrote:
> On Fri,  3 Jul 2020 08:53:54 -0700 trix@redhat.com wrote:
>
>> From: Tom Rix <trix@redhat.com>
>>
>> clang static analysis reports a garbage return
>>
>> In file included from mm/memory.c:84:
>> mm/memory.c:1612:2: warning: Undefined or garbage value returned to caller [core.uninitialized.UndefReturn]
>>         return err;
>>         ^~~~~~~~~~
>>
>> The setting of err depends on a loop executing.
>> So initialize err.
>>
>> ...
>>
>> --- a/mm/memory.c
>> +++ b/mm/memory.c
>> @@ -1601,7 +1601,7 @@ int vm_insert_pages(struct vm_area_struct *vma, unsigned long addr,
>>  	return insert_pages(vma, addr, pages, num, vma->vm_page_prot);
>>  #else
>>  	unsigned long idx = 0, pgcount = *num;
>> -	int err;
>> +	int err = -EINVAL;
>>  
>>  	for (; idx < pgcount; ++idx) {
>>  		err = vm_insert_page(vma, addr + (PAGE_SIZE * idx), pages[idx]);
> If a caller were to ask vm_insert_pages() to insert zero pages, I
> suspect we should just return zero and set *num to zero.

That would be v1 of the patch.

For the loop to not execute *num/pgcount is initially 0, and *num = pgcount - idx is 0 on exit.

 

>

