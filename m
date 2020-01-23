Return-Path: <SRS0=EowN=3M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22BF8C2D0DB
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jan 2020 11:45:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6FF824685
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jan 2020 11:45:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AN5LvWBI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729275AbgAWLp5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jan 2020 06:45:57 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:35853 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726729AbgAWLpz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jan 2020 06:45:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1579779954;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OrVyjo0oqyywlytVkCXxXhcblo/6CF8e8F0Ha+//2Ek=;
        b=AN5LvWBImkhc3bO0epvNrVk7tpkZMfvMrhrlUNnCM28Xr8mvUO5z0HOAoeWiKyyOxP5Niu
        0F9Cz2fapzMM8e5kQP6PoWvuCiuZB//7U4r4wfHZsLYDvHri8IkrbRXAgjialFoOL3hNeX
        f3NSBIGGf81mCL3vU3ClteiNvh2UNRE=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-193-ZJNA4eyTNkCCOvPPuycR7g-1; Thu, 23 Jan 2020 06:45:50 -0500
X-MC-Unique: ZJNA4eyTNkCCOvPPuycR7g-1
Received: by mail-wm1-f71.google.com with SMTP id l11so615574wmi.0
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jan 2020 03:45:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=OrVyjo0oqyywlytVkCXxXhcblo/6CF8e8F0Ha+//2Ek=;
        b=pUJFIgi48HhG/ZbRiwHtQYe7o6TwMoW8UkgUtOOsX+LpZ/2a9K4leMq5Ujo/BuIKTI
         fNgtIhzpROAYNc4mTLhamR5hfoI/4iMgGrllmZBNuC8Dy3l+tXcVSsMDwFtRhuRJLc1K
         owUG3sH1LrJXk8617EU/RGbImmpQyQsDvNiiYbgDPW8QqSsggmKjK5vVBJMIjXbd1/vf
         irLJa4MBSUyrchu8qNhimqDC910FPhp3IjhsY5otGRChw1yRPfDQOBXmGJAfki7REy4K
         k81ffj3hJk8Rk/7+yCdJQSj6P/nap4gZD1MhZHP9eAXQvOHHzEd5VyMHzt0TWxV7gnI5
         6O8w==
X-Gm-Message-State: APjAAAVgQSdRYP7B5++IAI9msI9bAa6iYddd4fo33ajqvgx+BjA9MgpZ
        o6ojPFsOTQ/ltUpl/f/jIppZGG+WLphVRZE83zyvTMToZMnhkVnzqidKKRNQrj9Dd0Bq6aKnsrl
        YVgG98R+Jtefz9Lw5BqYfDtxx
X-Received: by 2002:a1c:67c3:: with SMTP id b186mr3757816wmc.36.1579779949711;
        Thu, 23 Jan 2020 03:45:49 -0800 (PST)
X-Google-Smtp-Source: APXvYqy2/RO25x3GfNc/hah6VfoFxhZcx6jhmB2U+pGiK4uHFhpzGYFNDnmyuXKIw0WXa3XSq+SyYA==
X-Received: by 2002:a1c:67c3:: with SMTP id b186mr3757800wmc.36.1579779949529;
        Thu, 23 Jan 2020 03:45:49 -0800 (PST)
Received: from [192.168.1.81] (host81-140-166-164.range81-140.btcentralplus.com. [81.140.166.164])
        by smtp.gmail.com with ESMTPSA id x11sm2750016wre.68.2020.01.23.03.45.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Jan 2020 03:45:49 -0800 (PST)
Subject: Re: [RFC v5 08/57] objtool: Make ORC support optional
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        peterz@infradead.org, raphael.gault@arm.com,
        catalin.marinas@arm.com, will@kernel.org
References: <20200109160300.26150-1-jthierry@redhat.com>
 <20200109160300.26150-9-jthierry@redhat.com>
 <20200121163747.kbasjd2wn4q44vcf@treble>
From:   Julien Thierry <jthierry@redhat.com>
Message-ID: <7d1df0d8-87ee-01c1-1fdb-7d25e1dc4f5b@redhat.com>
Date:   Thu, 23 Jan 2020 11:45:48 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <20200121163747.kbasjd2wn4q44vcf@treble>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/21/20 4:37 PM, Josh Poimboeuf wrote:
> On Thu, Jan 09, 2020 at 04:02:11PM +0000, Julien Thierry wrote:
>> diff --git a/tools/objtool/Makefile b/tools/objtool/Makefile
>> index d2a19b0bc05a..24d653e0b6ec 100644
>> --- a/tools/objtool/Makefile
>> +++ b/tools/objtool/Makefile
>> @@ -6,6 +6,10 @@ ifeq ($(ARCH),x86_64)
>>   ARCH := x86
>>   endif
>>   
>> +ifeq ($(ARCH),x86)
>> +OBJTOOL_ORC := y
>> +endif
> 
> I think this should check SRCARCH instead, a la:
> 
>    https://lkml.kernel.org/r/d5d11370ae116df6c653493acd300ec3d7f5e925.1579543924.git.jpoimboe@redhat.com
> 

Yes, thanks for pointing it out.

-- 
Julien Thierry

