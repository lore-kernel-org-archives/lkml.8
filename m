Return-Path: <SRS0=jZ1s=BH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E97ACC433EC
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 17:29:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C8A872078E
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 17:29:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance-com.20150623.gappssmtp.com header.i=@bytedance-com.20150623.gappssmtp.com header.b="QpVOd0ri"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732044AbgG1R3d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jul 2020 13:29:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731779AbgG1R3d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jul 2020 13:29:33 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 059A7C061794
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jul 2020 10:29:33 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id k1so176593pjt.5
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jul 2020 10:29:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=ZLAm0UNsU9AurhkkJhyjgn7LGZqLsl+Za6Ai2D7+yKc=;
        b=QpVOd0riv/H5tGlVfruBLK6E0SRS0sMIqRDCKfsVJdfM89o9Wz6a4HQVvEjNRQs+L1
         j9Mn2VdgZGy5OZm5UI0LoGCJnVYFS8aZxTXGqAD4lpoY1UOxyreO71Wbyy2hyR3+YJMp
         K8oygwB5fCUKfMCGyoNaJsCk00yW3RTh5fu0B1UoyvrCB1nNKLctoGKTGumebYDGOMvW
         EhhTkKtB/zxTyfPRapcSD6YiAmNxWQK+KMc5aIS+idJgcz6om1JGi7gt3nvAu6NKSvRT
         qoGNqVmJPcOvx9h05/t5sTkaCryLRF+MhsK1SQnQcdAJFo7wUp7Xxe63dlhfRqPlyQ6X
         UnZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=ZLAm0UNsU9AurhkkJhyjgn7LGZqLsl+Za6Ai2D7+yKc=;
        b=MoB9tjPDyTpQua5GYly86mCQgp5nupT47conZTOlZV6SoQGcAV0XQJX8yN1zsbUHyZ
         Ukc2Odh2Vw4t+h4bJumpt2X6LWdCGxITJ/ykKRzxSUIohTh+y5W5xRGpG6LyK551T61w
         Y8Da45phdw+CLuNI1npgtWknW3Qipmef87gntl9sZ9h15d1Q/rBfJoCBzhX+Dj90eXUM
         5SCbj/8lV8JK1+yv6/3lfnMrzufBWzca/KxA4txY6dkego2XOKqucXvQBQrFdvAK2KJJ
         ryEpK85s9ZULthRWzGxqQ61iSLM5DCEqAmzKJtWNqo3WNxga+jfvHEqbau3OVaI6v6eT
         zaXg==
X-Gm-Message-State: AOAM531pD5mCG4qWREecAYp3KEV0O5UwqJjJ7gqjKwyUdCS4QpkAGuyn
        Kl1NLIKOQ8QjuNlk4CdLHW7+mw==
X-Google-Smtp-Source: ABdhPJzfkUNTCfufy8jUF+tzXO/R5dvd1v3x4GEMQ5Djc1AKXxxYvQWgKphVwSCrQM6yu1Ncm+g3WQ==
X-Received: by 2002:a17:90a:65c7:: with SMTP id i7mr5458338pjs.103.1595957372517;
        Tue, 28 Jul 2020 10:29:32 -0700 (PDT)
Received: from [10.255.143.11] ([103.136.221.69])
        by smtp.gmail.com with ESMTPSA id d29sm18051592pgb.54.2020.07.28.10.29.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Jul 2020 10:29:32 -0700 (PDT)
Subject: Re: [External] Re: [PATCH 2/2] ftrace: setup correct flags before
 replace code of module rec
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     mingo@redhat.com, linux-kernel@vger.kernel.org,
        songmuchun@bytedance.com
References: <20200728102720.46837-1-zhouchengming@bytedance.com>
 <20200728102720.46837-2-zhouchengming@bytedance.com>
 <20200728090211.4c94a14d@oasis.local.home>
From:   Chengming Zhou <zhouchengming@bytedance.com>
Message-ID: <b5b242eb-f7d8-0367-f95e-e8db8cc1a083@bytedance.com>
Date:   Wed, 29 Jul 2020 01:29:28 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200728090211.4c94a14d@oasis.local.home>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


在 2020/7/28 下午9:02, Steven Rostedt 写道:
> On Tue, 28 Jul 2020 18:27:20 +0800
> Chengming Zhou <zhouchengming@bytedance.com> wrote:
>
>> When module loaded and enabled, we will use __ftrace_replace_code
>> for module if any ftrace_ops referenced it found. But we will get
>> wrong ftrace_addr for module rec in ftrace_get_addr_new, because
>> rec->flags has not been setup correctly.
>> So setup correct rec->flags when we call referenced_filters to find
>> ftrace_ops references it.
> This is somewhat correct ;-)
>
>> Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
>> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
>> ---
>>  kernel/trace/ftrace.c | 16 +++++++++++++---
>>  1 file changed, 13 insertions(+), 3 deletions(-)
>>
>> diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
>> index fca01a168ae5..00087dea0174 100644
>> --- a/kernel/trace/ftrace.c
>> +++ b/kernel/trace/ftrace.c
>> @@ -6190,8 +6190,17 @@ static int referenced_filters(struct dyn_ftrace *rec)
>>  	int cnt = 0;
>>  
>>  	for (ops = ftrace_ops_list; ops != &ftrace_list_end; ops = ops->next) {
>> -		if (ops_references_rec(ops, rec))
>> -		    cnt++;
>> +		if (ops_references_rec(ops, rec)) {
>> +			cnt++;
>> +			if (ops->flags & FTRACE_OPS_FL_DIRECT)
>> +				rec->flags |= FTRACE_FL_DIRECT;
> The above should be:
>
> 			if (WARN_ON_ONCE(ops->flags & FTRACE_OPS_FL_DIRECT))
> 				continue;
> 			cnt++;
>
> The direct flag is *very* special, and should not be set automatically
> like this.
>
> Probably should add the same kind of warning and skip for
> FTRACE_OPS_FL_IPMODIFY.
Ok, I think it's fine to warn and skip these ops.
>> +			if (ops->flags & FTRACE_OPS_FL_SAVE_REGS)
>> +				rec->flags |= FTRACE_FL_REGS;
> The above is definitely a bug fix. I'm thinking this patch should be
> broken up into two. One with just this update (and the clear below),
> and the rest later. As this should be backported to stable.

Yes, this bug cause a kernel crash on our server...

So I will send a bugfix patch just including this update and the clear
below.

>> +			if (cnt == 1 && ops->trampoline)
>> +				rec->flags |= FTRACE_FL_TRAMP;
>> +			else
>> +				rec->flags &= ~FTRACE_FL_TRAMP;
> The above is correct, but not critical that it would need to be
> backported.

I will put the rest in the second patch later.

Thanks!

>
> Thanks!
>
> -- Steve
>
>> +		}
>>  	}
>>  
>>  	return cnt;
>> @@ -6373,7 +6382,8 @@ void ftrace_module_enable(struct module *mod)
>>  			cnt += referenced_filters(rec);
>>  
>>  		/* This clears FTRACE_FL_DISABLED */
>> -		rec->flags = cnt;
>> +		rec->flags &= ~FTRACE_FL_DISABLED;
>> +		rec->flags += cnt;
>>  
>>  		if (ftrace_start_up && cnt) {
>>  			int failed = __ftrace_replace_code(rec, 1);
