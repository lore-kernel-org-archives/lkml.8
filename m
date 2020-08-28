Return-Path: <SRS0=aBbL=CG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2779C433E6
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 18:24:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 653EB2074A
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 18:24:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="iAZqOWHa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728061AbgH1SYQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Aug 2020 14:24:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728033AbgH1SYM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Aug 2020 14:24:12 -0400
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com [IPv6:2607:f8b0:4864:20::d42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2EB4C06121B
        for <linux-kernel@vger.kernel.org>; Fri, 28 Aug 2020 11:24:11 -0700 (PDT)
Received: by mail-io1-xd42.google.com with SMTP id s1so2335143iot.10
        for <linux-kernel@vger.kernel.org>; Fri, 28 Aug 2020 11:24:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ZM5mfU0mJWLmXTIkhtggdad2TvAnKJMT9PhjMvl0vFM=;
        b=iAZqOWHafDQ0/xgiCmVLbfj7ZoImaMO14djUfGGO9kW3ciKL2lpsPJdi3xphkD6r4i
         yprM9qrpdTeIAcAkl5x7AARstyczAuaaLjFfMxxtXYzMKOeLKCzB2V/pziUpJO2LY7gr
         VIbSQ/czRXqRm0D9lHwEV5EvzX/n/8ops2mwCQwr+3n7EInyGINfuUC3S8qviQ/YmUes
         YLuPAYQXdlZq2e/WhT4XMUhQkv4vxoCK7YC+ImIJE7igTsLY4u6MNAt3JgQiNM8/Mv8k
         soKvfMahIZvIZmL4t6elibt7CuQioMN0sAJFSuHlBL/gvS7Ii+DIByXfGr+aCVX3m9eK
         WJZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ZM5mfU0mJWLmXTIkhtggdad2TvAnKJMT9PhjMvl0vFM=;
        b=AHXGpKyxoVQzpRWUmarqbVA7E4rHiYvwoANDLr/hxP0XYG02t4Kt3LHJoAMhY80kPs
         chDX+WKEte6PNCbdvzjjM7B/y26dQUVnHqcKyHqjiLCYLF3CPglAEB0Xbijw280fSEgr
         w8Lj0wo5/aUrTqpbeuKxyy2LTgGY6BQiQmYD233ZiFfM80pyh5CgL6HZqfhvHAYw4ofs
         fN0OqGl3KXkgWRt/2vQ5IQ1S5bhymAA8PWJMqXF0dYZoAZOR0PLPjZHUD8z7gofS4iSO
         ea7dIEE7UcRnDVS0+40SJ+mew3O4fN1SKhcUoOo/tkFNQ/TrEQgyBIvqQ3dDHCLCwO0U
         7/vA==
X-Gm-Message-State: AOAM533gDFdchi7kPhLD1/96RvvKHwzkX+YVt5wcxCsHWV4B/RDe8+LF
        BuZp3BMSmR+vuynzT7eFA6DEtw==
X-Google-Smtp-Source: ABdhPJwgd/WMTv7qcfgWBRRgARSe0GutcufYk/oyDu/iTiFlUkbewv6BRWnL3NOHNbqbsjnF4Y3KdA==
X-Received: by 2002:a6b:bc82:: with SMTP id m124mr16222iof.172.1598639050796;
        Fri, 28 Aug 2020 11:24:10 -0700 (PDT)
Received: from [192.168.1.58] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id c16sm75221ila.29.2020.08.28.11.24.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Aug 2020 11:24:10 -0700 (PDT)
Subject: Re: [PATCH v8 3/4] mm/madvise: introduce process_madvise() syscall:
 an external memory hinting API
To:     Arnd Bergmann <arnd@arndb.de>, Minchan Kim <minchan@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        linux-mm <linux-mm@kvack.org>,
        Linux API <linux-api@vger.kernel.org>,
        Oleksandr Natalenko <oleksandr@redhat.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Tim Murray <timmurray@google.com>,
        Sandeep Patil <sspatil@google.com>,
        Sonny Rao <sonnyrao@google.com>,
        Brian Geffon <bgeffon@google.com>,
        Michal Hocko <mhocko@suse.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Shakeel Butt <shakeelb@google.com>,
        John Dias <joaodias@google.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Jann Horn <jannh@google.com>,
        alexander.h.duyck@linux.intel.com,
        SeongJae Park <sj38.park@gmail.com>,
        David Rientjes <rientjes@google.com>,
        Arjun Roy <arjunroy@google.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Christian Brauner <christian@brauner.io>,
        Daniel Colascione <dancol@google.com>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        SeongJae Park <sjpark@amazon.de>,
        linux-man <linux-man@vger.kernel.org>
References: <20200622192900.22757-1-minchan@kernel.org>
 <20200622192900.22757-4-minchan@kernel.org>
 <CAK8P3a0Mnp2ekmX-BX9yr+N8fy2=gBtASELLXoa9uGSpSS9aOA@mail.gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <9c339413-68c7-344e-dd01-327cb988d385@kernel.dk>
Date:   Fri, 28 Aug 2020 12:24:08 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAK8P3a0Mnp2ekmX-BX9yr+N8fy2=gBtASELLXoa9uGSpSS9aOA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/28/20 11:40 AM, Arnd Bergmann wrote:
> On Mon, Jun 22, 2020 at 9:29 PM Minchan Kim <minchan@kernel.org> wrote:
>> So finally, the API is as follows,
>>
>>      ssize_t process_madvise(int pidfd, const struct iovec *iovec,
>>                unsigned long vlen, int advice, unsigned int flags);
> 
> I had not followed the discussion earlier and only now came across
> the syscall in linux-next, sorry for stirring things up this late.
> 
>> diff --git a/arch/x86/entry/syscalls/syscall_64.tbl b/arch/x86/entry/syscalls/syscall_64.tbl
>> index 94bf4958d114..8f959d90338a 100644
>> --- a/arch/x86/entry/syscalls/syscall_64.tbl
>> +++ b/arch/x86/entry/syscalls/syscall_64.tbl
>> @@ -364,6 +364,7 @@
>>  440    common  watch_mount             sys_watch_mount
>>  441    common  watch_sb                sys_watch_sb
>>  442    common  fsinfo                  sys_fsinfo
>> +443    64      process_madvise         sys_process_madvise
>>
>>  #
>>  # x32-specific system call numbers start at 512 to avoid cache impact
>> @@ -407,3 +408,4 @@
>>  545    x32     execveat                compat_sys_execveat
>>  546    x32     preadv2                 compat_sys_preadv64v2
>>  547    x32     pwritev2                compat_sys_pwritev64v2
>> +548    x32     process_madvise         compat_sys_process_madvise
> 
> I think we should not add any new x32-specific syscalls. Instead I think
> the compat_sys_process_madvise/sys_process_madvise can be
> merged into one.
> 
>> +       mm = mm_access(task, PTRACE_MODE_ATTACH_FSCREDS);
>> +       if (IS_ERR_OR_NULL(mm)) {
>> +               ret = IS_ERR(mm) ? PTR_ERR(mm) : -ESRCH;
>> +               goto release_task;
>> +       }
> 
> Minor point: Having to use IS_ERR_OR_NULL() tends to be fragile,
> and I would try to avoid that. Can mm_access() be changed to
> itself return PTR_ERR(-ESRCH) instead of NULL to improve its
> calling conventions? I see there are only three other callers.
> 
> 
>> +       ret = import_iovec(READ, vec, vlen, ARRAY_SIZE(iovstack), &iov, &iter);
>> +       if (ret >= 0) {
>> +               ret = do_process_madvise(pidfd, &iter, behavior, flags);
>> +               kfree(iov);
>> +       }
>> +       return ret;
>> +}
>> +
>> +#ifdef CONFIG_COMPAT
> ...
>> +
>> +       ret = compat_import_iovec(READ, vec, vlen, ARRAY_SIZE(iovstack),
>> +                               &iov, &iter);
>> +       if (ret >= 0) {
>> +               ret = do_process_madvise(pidfd, &iter, behavior, flags);
>> +               kfree(iov);
>> +       }
> 
> Every syscall that passes an iovec seems to do this. If we make import_iovec()
> handle both cases directly, this syscall and a number of others can
> be simplified, and you avoid the x32 entry point I mentioned above
> 
> Something like (untested)
> 
> index dad8d0cfaaf7..0de4ddff24c1 100644
> --- a/lib/iov_iter.c
> +++ b/lib/iov_iter.c
> @@ -1683,8 +1683,13 @@ ssize_t import_iovec(int type, const struct
> iovec __user * uvector,
>  {
>         ssize_t n;
>         struct iovec *p;
> -       n = rw_copy_check_uvector(type, uvector, nr_segs, fast_segs,
> -                                 *iov, &p);
> +
> +       if (in_compat_syscall())
> +               n = compat_rw_copy_check_uvector(type, uvector, nr_segs,
> +                                                fast_segs, *iov, &p);
> +       else
> +               n = rw_copy_check_uvector(type, uvector, nr_segs,
> +                                         fast_segs, *iov, &p);
>         if (n < 0) {
>                 if (p != *iov)
>                         kfree(p);

Doesn't work for the async case, where you want to be holding on to the
allocated iovec. But in general I think it's a good helper for the sync
case, which is by far the majority.

-- 
Jens Axboe

