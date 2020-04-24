Return-Path: <SRS0=nwpL=6I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5048CC55191
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 14:37:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1EE8A2075A
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 14:37:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=axtens.net header.i=@axtens.net header.b="HDLuxwmJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727059AbgDXOhK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Apr 2020 10:37:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726813AbgDXOhJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Apr 2020 10:37:09 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 620D6C09B045
        for <linux-kernel@vger.kernel.org>; Fri, 24 Apr 2020 07:37:09 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id c21so2980599plz.4
        for <linux-kernel@vger.kernel.org>; Fri, 24 Apr 2020 07:37:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=axtens.net; s=google;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=KAaTm0Hse3RKPU7ib8Tu6J/z1e4Og8KZuvKFi+it9Vo=;
        b=HDLuxwmJR50W3E49SGVN/oDlnnLAtNHvQyQ27E7eb5YXWVEV4pAvtnxiN5ry50pNwz
         Br5lHFZxTjO2q2DEornfTe3o0GF8g9Pt+pryH5EFlNeb7pctZLroFi9VoLp2x8ckMPH5
         BD+T6J/+jQQ+++enfBOWxatDr7K+PkssrakbQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=KAaTm0Hse3RKPU7ib8Tu6J/z1e4Og8KZuvKFi+it9Vo=;
        b=MHP+ygOALWTBd8l4X7L9co05LD8hFKV19ebc0QrHmIYF3cRNH7J1lT2rfggxl/Fff/
         3XvsDHfS25p9ZwUe9f/onlfui+xENFNrrRhNishcZjA6t28gmebIIsne7iotTITcf8fo
         6cqztqNp/K0w1nzZsgSgW2pe43bxK3FXHzbBREmnOUHGAJJRjoJTQsgHY3c+h2YlkjPR
         rjESADdfsSlinQx9OswI+isCZ2pCX/QUbVsxRLXUci1NH+hXupaVNzBJLxcBJr6jEFMj
         mDnYojScl3tTeqgZ1tHWfiGbpW5mwRcMv05mai6IXI6/gYIsf2FDmxsbrMOzIjoeDN4x
         sM4w==
X-Gm-Message-State: AGi0PubjCa7OhosHPj1vl5GK1gRHAuQd9BX40bNe3Abvyyck0Lx2PXoh
        4qC2PG661njvtom8Kwqpf3oz/g==
X-Google-Smtp-Source: APiQypIBpqHawmogrqSBDaFcH0lKU8ACC1fhiCqtIrIxnhrMJkb/TPamldj/LttAAONccIxVA4xNxw==
X-Received: by 2002:a17:90b:374f:: with SMTP id ne15mr6294987pjb.181.1587739028730;
        Fri, 24 Apr 2020 07:37:08 -0700 (PDT)
Received: from localhost (2001-44b8-1113-6700-fd06-aa7b-7508-4b8b.static.ipv6.internode.on.net. [2001:44b8:1113:6700:fd06:aa7b:7508:4b8b])
        by smtp.gmail.com with ESMTPSA id p190sm6182787pfp.207.2020.04.24.07.37.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Apr 2020 07:37:07 -0700 (PDT)
From:   Daniel Axtens <dja@axtens.net>
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, Linux-MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>
Subject: Re: [PATCH v3 3/3] kasan: initialise array in kasan_memcmp test
In-Reply-To: <CACT4Y+b7omyQ0bBBApOs5O_m0MDZWjoBi3QV6MxG4h_14gUa2g@mail.gmail.com>
References: <20200423154503.5103-1-dja@axtens.net> <20200423154503.5103-4-dja@axtens.net> <CACT4Y+b7omyQ0bBBApOs5O_m0MDZWjoBi3QV6MxG4h_14gUa2g@mail.gmail.com>
Date:   Sat, 25 Apr 2020 00:37:04 +1000
Message-ID: <877dy5t0fj.fsf@dja-thinkpad.axtens.net>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dmitry Vyukov <dvyukov@google.com> writes:

> On Thu, Apr 23, 2020 at 5:45 PM Daniel Axtens <dja@axtens.net> wrote:
>>
>> memcmp may bail out before accessing all the memory if the buffers
>> contain differing bytes. kasan_memcmp calls memcmp with a stack array.
>> Stack variables are not necessarily initialised (in the absence of a
>> compiler plugin, at least). Sometimes this causes the memcpy to bail
>> early thus fail to trigger kasan.
>>
>> Make sure the array initialised to zero in the code.
>>
>> No other test is dependent on the contents of an array on the stack.
>>
>> Cc: Andrey Ryabinin <aryabinin@virtuozzo.com>
>> Cc: Alexander Potapenko <glider@google.com>
>> Cc: Dmitry Vyukov <dvyukov@google.com>
>> Signed-off-by: Daniel Axtens <dja@axtens.net>
>> Reviewed-by: Dmitry Vyukov <dvyukov@google.com>
>> ---
>>  lib/test_kasan.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/lib/test_kasan.c b/lib/test_kasan.c
>> index 939f395a5392..7700097842c8 100644
>> --- a/lib/test_kasan.c
>> +++ b/lib/test_kasan.c
>> @@ -638,7 +638,7 @@ static noinline void __init kasan_memcmp(void)
>>  {
>>         char *ptr;
>>         size_t size = 24;
>> -       int arr[9];
>> +       int arr[9] = {};
>>
>>         pr_info("out-of-bounds in memcmp\n");
>>         ptr = kmalloc(size, GFP_KERNEL | __GFP_ZERO);
>
> My version of this function contains the following below:
>
> memset(arr, 0, sizeof(arr));
>
> What am I missing?

Ah! It turns out I accidentally removed the memset in patch 1. No idea
why I did that. I'll fix up patch 1 to not remove the memset and drop
this patch.

Daniel
