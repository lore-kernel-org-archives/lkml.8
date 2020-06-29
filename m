Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E1B8C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 23:22:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 72CED20781
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 23:22:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cIXvVaSa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728556AbgF2XWx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 19:22:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726746AbgF2XWv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 19:22:51 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBDB7C061755
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 16:22:51 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id b16so8535746pfi.13
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 16:22:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=vosq3jM/Z3IP3Dh+gOgBhDGbMDQnYun30kIMF/La9o4=;
        b=cIXvVaSaQc5ILuJaRDR/wexJyYUN6n9xmX1Wz1HZxX80qts79UYOAhmSOBvWwYqI7g
         K9PB0H/wRCjKRAO+cLvtThHz32uLW5TIi6DgUzJTqZ9fuQUJDhotTkH9WXj6wAdvFPZE
         mwnev4Gi9EJBfAoFdE9KkeinMzAXYcwYebrUgBNbU/saUchbLqgoZ1oKO4V680pigEzj
         xrpYdpei+CQX0Rc5BW6sXS7yeV+GyYg2idYnOO9vrB8+HscqnaiJT0cJiUo6bv11ew4J
         MnJ68nn/9iGBayeJds85Ayzcn8jWktIo61przQX4SFL9ddvG6d9vRq01144dk5rq0wXq
         gwwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=vosq3jM/Z3IP3Dh+gOgBhDGbMDQnYun30kIMF/La9o4=;
        b=tFRkbe89FECMIR+QBHcqC4Ave2Vl9BwvLX/fyBgLEdlP12Z4hPCLmTgd6R7ajY52zM
         gN/FzNJ4NLjCoypbImT/RGFeghStxl0a4KKuyncEMlQkpmSYv8jtJT87a/SLGdIDctYK
         m/3tUL6SUSZxOdBjvcBoPUPjgj+5a6nLsM9UDZ3wovgOU8C/PqElVSsXTIocaV3AVWLM
         06cyeUvk7jbYl0/WtFwW0HtgtFNwNyWdsNdZFkte8diItqqIGUyoUeBoaARl/h4pGzUv
         iJsVanNZ+Ao+FE5/pK9FHyxng9bKpi2sq717dNRv7cZcu1ibGC7EV74HNBQe5NsJ+s96
         Qm8A==
X-Gm-Message-State: AOAM533S9Vb2lk+aS718GvlUjxebbEzA69WwZXDPFBWzrYbzVDkSEGoG
        0pt99aLtFx0V1OuDH4AURmW1dQ==
X-Google-Smtp-Source: ABdhPJx3JO3u4fG6Fd9hfA+ttXXsBjo2Fr8PGnVv+moeh/cJBgY7JGWNYXy+Pe70NRofreAkTSmyaQ==
X-Received: by 2002:a65:6883:: with SMTP id e3mr12506452pgt.5.1593472971349;
        Mon, 29 Jun 2020 16:22:51 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id n137sm638694pfd.194.2020.06.29.16.22.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2020 16:22:50 -0700 (PDT)
Date:   Mon, 29 Jun 2020 16:22:50 -0700 (PDT)
X-Google-Original-Date: Mon, 29 Jun 2020 16:22:41 PDT (-0700)
Subject:     Re: [PATCH V2] riscv: Fixup compile error BUILD_BUG_ON failed
In-Reply-To: <20200629012524.c941a5f18aa7f312d325f714@kernel.org>
CC:     guoren@kernel.org, greentime.hu@sifive.com,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Paul Walmsley <paul.walmsley@sifive.com>, anup@brainfault.org,
        linux-csky@vger.kernel.org, zong.li@sifive.com,
        guoren@linux.alibaba.com
From:   Palmer Dabbelt <palmerdabbelt@google.com>
To:     mhiramat@kernel.org
Message-ID: <mhng-37e70bbc-2616-41e6-bc8a-f144ca647c97@palmerdabbelt-glaptop1>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 28 Jun 2020 09:25:24 PDT (-0700), mhiramat@kernel.org wrote:
> On Sun, 28 Jun 2020 16:07:37 +0000
> guoren@kernel.org wrote:
>
>> From: Guo Ren <guoren@linux.alibaba.com>
>>
>> Unfortunately, the current code couldn't be compiled:
>>
>>   CC      arch/riscv/kernel/patch.o
>> In file included from ./include/linux/kernel.h:11,
>>                  from ./include/linux/list.h:9,
>>                  from ./include/linux/preempt.h:11,
>>                  from ./include/linux/spinlock.h:51,
>>                  from arch/riscv/kernel/patch.c:6:
>> In function ‘fix_to_virt’,
>>     inlined from ‘patch_map’ at arch/riscv/kernel/patch.c:37:17:
>> ./include/linux/compiler.h:392:38: error: call to ‘__compiletime_assert_205’ declared with attribute error: BUILD_BUG_ON failed: idx >= __end_of_fixed_addresses
>>   _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
>>                                       ^
>> ./include/linux/compiler.h:373:4: note: in definition of macro ‘__compiletime_assert’
>>     prefix ## suffix();    \
>>     ^~~~~~
>> ./include/linux/compiler.h:392:2: note: in expansion of macro ‘_compiletime_assert’
>>   _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
>>   ^~~~~~~~~~~~~~~~~~~
>> ./include/linux/build_bug.h:39:37: note: in expansion of macro ‘compiletime_assert’
>>  #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
>>                                      ^~~~~~~~~~~~~~~~~~
>> ./include/linux/build_bug.h:50:2: note: in expansion of macro ‘BUILD_BUG_ON_MSG’
>>   BUILD_BUG_ON_MSG(condition, "BUILD_BUG_ON failed: " #condition)
>>   ^~~~~~~~~~~~~~~~
>> ./include/asm-generic/fixmap.h:32:2: note: in expansion of macro ‘BUILD_BUG_ON’
>>   BUILD_BUG_ON(idx >= __end_of_fixed_addresses);
>>   ^~~~~~~~~~~~
>>
>> Because fix_to_virt(, idx) needs a const value, not a dynamic variable of
>> reg-a0 or BUILD_BUG_ON failed with "idx >= __end_of_fixed_addresses".
>
> Looks good to me :)
>
> Reviewed-by: Masami Hiramatsu <mhiramat@kernel.org>

Is there a configuration that runs into this bug?  It's not showing up for me,
and I generally try to add regressions to my test suite.

> Thanks!
>
>>
>> Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
>> Cc: Masami Hiramatsu <mhiramat@kernel.org>
>> Cc: Zong Li <zong.li@sifive.com>
>> ---
>> Changelog V2:
>>  - Use __always_inline as same as fix_to_virt
>>  - Use const "const unsigned int" for 2th param
>>
>> Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
>> ---
>>  arch/riscv/kernel/patch.c | 8 ++++++--
>>  1 file changed, 6 insertions(+), 2 deletions(-)
>>
>> diff --git a/arch/riscv/kernel/patch.c b/arch/riscv/kernel/patch.c
>> index d4a64df..3179a4e 100644
>> --- a/arch/riscv/kernel/patch.c
>> +++ b/arch/riscv/kernel/patch.c
>> @@ -20,7 +20,12 @@ struct patch_insn {
>>  };
>>
>>  #ifdef CONFIG_MMU
>> -static void *patch_map(void *addr, int fixmap)
>> +/*
>> + * The fix_to_virt(, idx) needs a const value (not a dynamic variable of
>> + * reg-a0) or BUILD_BUG_ON failed with "idx >= __end_of_fixed_addresses".
>> + * So use '__always_inline' and 'const unsigned int fixmap' here.
>> + */
>> +static __always_inline void *patch_map(void *addr, const unsigned int fixmap)
>>  {
>>  	uintptr_t uintaddr = (uintptr_t) addr;
>>  	struct page *page;
>> @@ -37,7 +42,6 @@ static void *patch_map(void *addr, int fixmap)
>>  	return (void *)set_fixmap_offset(fixmap, page_to_phys(page) +
>>  					 (uintaddr & ~PAGE_MASK));
>>  }
>> -NOKPROBE_SYMBOL(patch_map);
>>
>>  static void patch_unmap(int fixmap)
>>  {
>> --
>> 2.7.4
>>
