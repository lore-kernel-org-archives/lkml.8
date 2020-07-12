Return-Path: <SRS0=5Khs=AX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA52AC433E3
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Jul 2020 15:13:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 96462206B6
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Jul 2020 15:13:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cuQvyvS6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729003AbgGLPNA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 12 Jul 2020 11:13:00 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:42887 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728826AbgGLPMy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Jul 2020 11:12:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1594566773;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NZm5xGXGIsTfeQaPHTSVnSl1UUxikxu7jO8zjXTvbMg=;
        b=cuQvyvS6BWuqK0RnGKNQa7kveYINSiL6M1PYtPrxZbLYzfNL/TiKrWGGEyxqMCP1FSG6gV
        eg7sC9ZHdJz+o5F2K5CBd3Nqy040tOVx/UYrHFZh3t3kFtLPkRNhPHhl4A8OXnwSApgJCn
        5KEVcE5QQgf4NjSX/1hFi5nnWOtGyDo=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-199-TQxMkJo3NNCS6wrenqPZwg-1; Sun, 12 Jul 2020 11:12:47 -0400
X-MC-Unique: TQxMkJo3NNCS6wrenqPZwg-1
Received: by mail-qt1-f199.google.com with SMTP id x6so8325728qtf.2
        for <linux-kernel@vger.kernel.org>; Sun, 12 Jul 2020 08:12:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=NZm5xGXGIsTfeQaPHTSVnSl1UUxikxu7jO8zjXTvbMg=;
        b=ZnOfvsUv4xFUKoTl+09J/13t0b3GMc+3clQ9THU1YKf+8yrBdRpoojGRBL9eGa3Olk
         fN5ZIJDV8RFvhEgOcl1/VscUyt807p7TRCYGEiTomaRPPMTqdmrAoT9ofM+dGBFAnwhh
         /epjzQkaf8adP/Ugp2aUmEZH03O2UQhLtzeBujIY6ojlLvJZh5UNb9r9z3dglm84BT7v
         WNMkkNi6o7GWtMLVvnrBrDFLal5hemMj6YOMKxervZobTUdWIxAV9NQ99FWZ/HIHX9H7
         6ZpFUGOfbP49DByWc7tdMDwv1DftqQ50cIUoWwOAbdapHJHbaEwQBipAfyjA25tBodf0
         ZZyA==
X-Gm-Message-State: AOAM5306dwHAvhObmNDFYpfSpcurUAt2IMNwSP771v9v4RFVo4fN0uwA
        D4YrpTNvk9utdG/nYQFVJBVuPU5LoDVxMU/nGoSk5GIjHZbqsCbZJC7xvxfye2eo5dilyC0klaP
        ICdL9Mqy835g8JuQs4u/vzI5g
X-Received: by 2002:a0c:8b4a:: with SMTP id d10mr75669743qvc.31.1594566766118;
        Sun, 12 Jul 2020 08:12:46 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxof3kIA9KQH9Uz3TMrMaWXi5uVTUSUayn/bQ9qpSptU5kRHRyiS4JyiTCOnYzaR+1VriKdew==
X-Received: by 2002:a0c:8b4a:: with SMTP id d10mr75669730qvc.31.1594566765897;
        Sun, 12 Jul 2020 08:12:45 -0700 (PDT)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id 23sm14431251qkl.52.2020.07.12.08.12.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 12 Jul 2020 08:12:44 -0700 (PDT)
Subject: Re: [PATCH] decompress_bunzip2: fix sizeof type in start_bunzip
To:     "H. Peter Anvin" <hpa@zytor.com>, alain@knaff.lu
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20200712125952.8809-1-trix@redhat.com>
 <639c8ef5-2755-7172-fbb8-ce45c8637feb@zytor.com>
From:   Tom Rix <trix@redhat.com>
Message-ID: <9af191c2-0f2c-7637-433a-b557a07590ca@redhat.com>
Date:   Sun, 12 Jul 2020 08:12:43 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <639c8ef5-2755-7172-fbb8-ce45c8637feb@zytor.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 7/12/20 6:09 AM, H. Peter Anvin wrote:
> On 2020-07-12 05:59, trix@redhat.com wrote:
>> From: Tom Rix <trix@redhat.com>
>>
>> clang static analysis flags this error
>>
>> lib/decompress_bunzip2.c:671:13: warning: Result of 'malloc' is converted
>>   to a pointer of type 'unsigned int', which is incompatible with sizeof
>>   operand type 'int' [unix.MallocSizeof]
>>         bd->dbuf = large_malloc(bd->dbufSize * sizeof(int));
>>                    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>>
>> Reviewing the bunzip_data structure, the element dbuf is type
>>
>> 	/* Intermediate buffer and its size (in bytes) */
>> 	unsigned int *dbuf, dbufSize;
>>
>> So change the type in sizeof to 'unsigned int'
>>
> You must be kidding.
>
> If you want to change it, change it to sizeof(bd->dbuf) instead, but this flag
> is at least in my opinion a total joke. For sizeof(int) != sizeof(unsigned
> int) is beyond bizarre, no matter how stupid the platform.

Using the actual type is more correct that using a type of the same size.

trix

> 	-hpa
>

