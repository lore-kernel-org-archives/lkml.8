Return-Path: <SRS0=+W6S=BJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21EFCC433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 13:45:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EF8F020829
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 13:45:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XZyBA8iH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727883AbgG3Npy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jul 2020 09:45:54 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:42692 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726535AbgG3Npx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jul 2020 09:45:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1596116751;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=N18kbwNayNCSq56otQGns/biTl+P88TmaRVZCSCurk8=;
        b=XZyBA8iHEBNDC0Ml03AJkndb9Mu6CdquDXRffqPonEmMJHx1dysQ71CCnufAklwSZhCITA
        hPsVtdLspO9hudyNRsIbHCZ+8TKQwXATHiBdaT7ptRUKJ1GrRBgfC6OPvtyfsIiXa890aq
        CPTAQpaCUiSRHpotDRWyDmcyAbebXhU=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-231-JF7Sn9QkMqC8a4saeXcTQA-1; Thu, 30 Jul 2020 09:45:48 -0400
X-MC-Unique: JF7Sn9QkMqC8a4saeXcTQA-1
Received: by mail-wm1-f71.google.com with SMTP id u68so1406346wmu.3
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jul 2020 06:45:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=N18kbwNayNCSq56otQGns/biTl+P88TmaRVZCSCurk8=;
        b=esYS3Od6QUf9CBEsNMXacveGxgsFGY/EE7+ud9C+81gdtEhZXgbQQwqqNsWNH/mdA7
         1UJYe8SFjh9k38O8dBuEqZU/TbdJ3L9dRILxg6eLv7Tu3yd/tzHmH8SGZzIdvv7ndEQY
         H8dPi1V0VT4loumI0Gv4IYLW5WddgJWw/s06YRi0skmv7okTY9fgDhMZimuqWgIOJ4mZ
         EsfafgkhcisUHTPZCFus/L4ujOxcZSs78mI1lQtqKIMWtOlOTV2WnXK4N/sx6XsgjHzk
         k+7rrG4ByTVrg4vbfYagzna0ylPU0SggofEbcIZB7r5BuMseVqgJ+Viaq13WtvZTisAL
         vC8Q==
X-Gm-Message-State: AOAM531MuqLriIuhuj1W3bgbZkeS8p5MIvJvnXAdrB4BFfHXwcNr/nrr
        95PPJo8GnqT/mVEP/8xNrSEXjEAQm5oFEmjeUIyaeKgG7hYj690Bz7aNWfvH9f1PaIuFyJtGhN1
        SgvE1Vg78Apf9yOIo86a5VS2Y
X-Received: by 2002:a1c:5603:: with SMTP id k3mr13225214wmb.22.1596116747898;
        Thu, 30 Jul 2020 06:45:47 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx7QV2KGledFSsRmiFdDDc7hjFzmkKD0YzI7Gb7ntuMmeeaxHhIejGzW4kXKCPdUiMRjqUl9Q==
X-Received: by 2002:a1c:5603:: with SMTP id k3mr13225196wmb.22.1596116747726;
        Thu, 30 Jul 2020 06:45:47 -0700 (PDT)
Received: from ?IPv6:2a01:cb14:499:3d00:cd47:f651:9d80:157a? ([2a01:cb14:499:3d00:cd47:f651:9d80:157a])
        by smtp.gmail.com with ESMTPSA id o7sm9439445wrv.50.2020.07.30.06.45.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Jul 2020 06:45:47 -0700 (PDT)
Subject: Re: [PATCH v3 4/4] objtool: orc_gen: Move orc_entry out of
 instruction structure
To:     peterz@infradead.org
Cc:     linux-kernel@vger.kernel.org, jpoimboe@redhat.com,
        mhelsley@vmware.com, mbenes@suse.cz
References: <20200730094143.27494-1-jthierry@redhat.com>
 <20200730094143.27494-5-jthierry@redhat.com>
 <20200730100304.GI2655@hirez.programming.kicks-ass.net>
 <e4e239ad-120e-bd8f-4128-6976146c8512@redhat.com>
 <20200730133343.GN2655@hirez.programming.kicks-ass.net>
From:   Julien Thierry <jthierry@redhat.com>
Message-ID: <0280367f-3839-acad-799a-ecc2756c1846@redhat.com>
Date:   Thu, 30 Jul 2020 14:45:46 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200730133343.GN2655@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/30/20 2:33 PM, peterz@infradead.org wrote:
> On Thu, Jul 30, 2020 at 01:40:48PM +0100, Julien Thierry wrote:
>>
>>
>> On 7/30/20 11:03 AM, peterz@infradead.org wrote:
>>> On Thu, Jul 30, 2020 at 10:41:43AM +0100, Julien Thierry wrote:
>>>> One orc_entry is associated with each instruction in the object file,
>>>> but having the orc_entry contained by the instruction structure forces
>>>> architectures not implementing the orc subcommands to provide a dummy
>>>> definition of the orc_entry.
> 
>> I guess I forgot about the usecase of running objtool on vmlinux...
> 
> Right, and LTO builds will even do ORC at that level.
> 
>> On a kernel build for x86_64 defconfig, the difference in time seems to be
>> withing the noise.
> 
> Good.
> 
>> But I agree the proposed code is not ideal and on the other we've tried
>> avoiding #ifdef in the code. Ideally I'd have an empty orc_entry definition
>> when SUBCMD_ORC is not implemented.
>>
>> Would you have a suggested approach to do that?
> 
> How ugly is having that:
> 
> struct orc_entry { };
> 
> ?

Not sure I am understanding the suggestion. Without #ifdef this will 
conflict with the definition in <asm/orc_types.h> for x86. Or every arch 
needs to provide their own <asm/orc_types.h> and definition of struct 
orc_entry, even if they don't implement the orc subcommand.

Which would be preferable? #ifdef? or arch provided definition? (or 
something I have not thought of)

-- 
Julien Thierry

