Return-Path: <SRS0=gGKB=AY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E67EDC433E3
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 19:27:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C5A1320663
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 19:27:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="By574Lp8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726850AbgGMT1K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jul 2020 15:27:10 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:27661 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726356AbgGMT1K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jul 2020 15:27:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1594668427;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xO+Un2OH0Ygd9pT8h3KUtvCPfFokvondlCdEbacpId0=;
        b=By574Lp8wCORNo9JKeepjFrmY2P73E/rF8w0jtYy9l/Kt0+jSAEQgYItDjfduE9D7uyx1q
        T1YXSUCW4C+61peleIYDQjYNxfo8d2J/c69QhraZFDAo1mncqeASXlFDkkr6KK8yGXMtth
        kCCYfV8ltjH3GUw4y6zm8U0Z7kocLIk=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-475-5kXlGHyIMGOvI031kAFNMA-1; Mon, 13 Jul 2020 15:27:06 -0400
X-MC-Unique: 5kXlGHyIMGOvI031kAFNMA-1
Received: by mail-qk1-f197.google.com with SMTP id i145so11528991qke.2
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jul 2020 12:27:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=xO+Un2OH0Ygd9pT8h3KUtvCPfFokvondlCdEbacpId0=;
        b=iJDC+qwV9SDD8oqZbo6jK+c1B9yUAHBB60WqAZLBkiiOo1cqdtOZu0cKIeztfGLoyY
         +SgUlB4FyqKLNYLcanrs5471SMyp5Hsa8vwMtkpkPLtBQUXqdNCZHgzeLMjFJKGn9RJv
         xJ2zc7V6N7S9JjuVesyccjTv6OHNjwhcL07itVl8aJtBNlf1q+u3iLFIvMiZ+Lc+dMgt
         lgMLorSdQ+TJZftJcqHtU8hFD4DlGBBdld/E2Lf9uj80ygcE3i61zryX/RqeKw032Top
         zc7E/DmxEfdSMCZXUDfYRWIt9ajsSmzG5i8HA+5ijm7LPvxMR91IY/RKf1hBlqj9WWFE
         IaNw==
X-Gm-Message-State: AOAM530tntrI6cmKUMA6hnn5yzNAH55MJPcnlrCv4f2xHXvBgx0+GLQN
        5YoxHBcwFUL5iSMM6sSoIIfCU6VMeu0xztpk/H1aN3ksEZW1iy+u1T2nWJPfx6/MSGa/bVnUdkX
        Q0QVUG5/2GjargJ/qsYDNUtQm
X-Received: by 2002:ae9:ee06:: with SMTP id i6mr1184264qkg.132.1594668425452;
        Mon, 13 Jul 2020 12:27:05 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyQ1kpy/BZm1NeI0BzQS5sxow+0BkG/MrwnEXJ+rAqrAzjkoAgFIMtaKwTN1WNEEJnqzXDJKA==
X-Received: by 2002:ae9:ee06:: with SMTP id i6mr1184254qkg.132.1594668425165;
        Mon, 13 Jul 2020 12:27:05 -0700 (PDT)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id p186sm20172406qkf.33.2020.07.13.12.27.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Jul 2020 12:27:04 -0700 (PDT)
Subject: Re: [PATCH] decompress_bunzip2: fix sizeof type in start_bunzip
To:     hpa@zytor.com, alain@knaff.lu
Cc:     linux-kernel@vger.kernel.org
References: <20200712125952.8809-1-trix@redhat.com>
 <639c8ef5-2755-7172-fbb8-ce45c8637feb@zytor.com>
 <9af191c2-0f2c-7637-433a-b557a07590ca@redhat.com>
 <EE11D4F0-8DA4-4030-800E-516423293987@zytor.com>
From:   Tom Rix <trix@redhat.com>
Message-ID: <6a73bb96-1390-ecca-2429-12b71e2aefc2@redhat.com>
Date:   Mon, 13 Jul 2020 12:27:02 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <EE11D4F0-8DA4-4030-800E-516423293987@zytor.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 7/12/20 3:21 PM, hpa@zytor.com wrote:
> On July 12, 2020 8:12:43 AM PDT, Tom Rix <trix@redhat.com> wrote:
>> On 7/12/20 6:09 AM, H. Peter Anvin wrote:
>>> On 2020-07-12 05:59, trix@redhat.com wrote:
>>>> From: Tom Rix <trix@redhat.com>
>>>>
>>>> clang static analysis flags this error
>>>>
>>>> lib/decompress_bunzip2.c:671:13: warning: Result of 'malloc' is
>> converted
>>>>   to a pointer of type 'unsigned int', which is incompatible with
>> sizeof
>>>>   operand type 'int' [unix.MallocSizeof]
>>>>         bd->dbuf = large_malloc(bd->dbufSize * sizeof(int));
>>>>                    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>>>>
>>>> Reviewing the bunzip_data structure, the element dbuf is type
>>>>
>>>> 	/* Intermediate buffer and its size (in bytes) */
>>>> 	unsigned int *dbuf, dbufSize;
>>>>
>>>> So change the type in sizeof to 'unsigned int'
>>>>
>>> You must be kidding.
>>>
>>> If you want to change it, change it to sizeof(bd->dbuf) instead, but
>> this flag
>>> is at least in my opinion a total joke. For sizeof(int) !=
>> sizeof(unsigned
>>> int) is beyond bizarre, no matter how stupid the platform.
>> Using the actual type is more correct that using a type of the same
>> size.
>>
>> trix
>>
>>> 	-hpa
>>>
> "More correct?" All it is is more verbose.
>
> Using the sizeof of the actual object at least adds some actual safety.

Sorry, I am being pedantic, I mean anything that produces the correct assembly is correct. But there are different path to being correct.  The path I was suggesting to follow the type of the element/final pointer when allocating an memory.

large_malloc(bd->dbufSize * sizeof(*bd->dbuf)) would also work

I will respin.

trix

