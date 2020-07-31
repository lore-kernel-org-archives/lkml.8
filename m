Return-Path: <SRS0=S/iQ=BK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6034C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 04:00:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BDAA42072A
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 04:00:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance-com.20150623.gappssmtp.com header.i=@bytedance-com.20150623.gappssmtp.com header.b="SeUXU1Ot"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725910AbgGaEAQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jul 2020 00:00:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725554AbgGaEAQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jul 2020 00:00:16 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7C2EC061574
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jul 2020 21:00:15 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id k13so8352166plk.13
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jul 2020 21:00:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=eOrHHEoLbmShZn06KY0pJBvl5BkGI3eW5SQrWZnkh+k=;
        b=SeUXU1OtZXoWO6ae494d5HYy+HUe0M+mNFo026ChmcqHBAjcDs9V80/uhRP4a7PKjb
         qXbYeRuXgDE4s7IQenxwhYy6uFhklQHZKvhbmOspwLZj1UI+wztYWXayBG/l5gis8xTa
         f+i2JDgwOI5xmwctq1flN6q4eVaLXD5tQ2s/qJwT86hsUEihzpMY83aov2TOYy0Fxwtt
         4tfLLZh7lpBfhCWe0jShT59UOskPmyAbzO4CGARlv8Yjqy/yqwW5N7R3/YJ10WlaURHz
         nUlWlptQYZpQLvyXtYLdfVcmcbezVxVG0arkuLMzni2s0EIOsvsc+d7qpcuASOoOlozZ
         18gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=eOrHHEoLbmShZn06KY0pJBvl5BkGI3eW5SQrWZnkh+k=;
        b=WHzx3zQZHTZK9TO9EuHWxQHrrCxfskCCpuageMWtlW8Qq2bWUh1BbyMSkgCBD8niVo
         TIUr5DpO0EISHHLioMs/O/sJ8jHZybyFAId7JJADFYxIQN/Zs3gKK+ZJ4YqZ6DLTaNgH
         fDFjIZJ1TlxzX9JFWLSSiEiDbyf+d2GD/jfjXEZ/+ekjeU1Hb/3tJak5RYQg1/rseyeS
         JFNflySn/dGwIn7dZx4wdj2xVIOHaZqsOGWSZm9Xh8vaWNDEH0c8Cd0eQ+4xBRm5E7v7
         IC/pQN9YZPWG4x0Rm0nUWGMnwGfJ118VyVKnY0AcpV8SCLswPghVCNw7nNBpuyvl9/nQ
         RG9g==
X-Gm-Message-State: AOAM533d4zEtz2OD6j2+57rGtY5kYTYbtFfHClXD+DxlNDEWZ7rh+z2+
        PHx2qR9XoOwIwLzGbuWzXED1AiGgBYqJWTUC
X-Google-Smtp-Source: ABdhPJypDiBZdUEFJHNXox9cuGIFsD4pvvvYPGbty0wVpHF8S7scd+2yhjLSPoCPxE58vNL7G9kE4A==
X-Received: by 2002:a05:6a00:2295:: with SMTP id f21mr1875024pfe.51.1596168015171;
        Thu, 30 Jul 2020 21:00:15 -0700 (PDT)
Received: from [10.91.184.194] ([103.136.220.73])
        by smtp.gmail.com with ESMTPSA id y10sm8077014pff.187.2020.07.30.21.00.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Jul 2020 21:00:14 -0700 (PDT)
Subject: Re: [External] Re: [PATCH 1/2] ftrace: clear module from hash of all
 ftrace ops
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     mingo@redhat.com, linux-kernel@vger.kernel.org,
        songmuchun@bytedance.com
References: <20200728102720.46837-1-zhouchengming@bytedance.com>
 <20200728085320.6b04e03f@oasis.local.home>
 <557fa115-1247-e058-4a18-e73f6fb7d636@bytedance.com>
 <20200728132630.678f94f7@oasis.local.home>
From:   Chengming Zhou <zhouchengming@bytedance.com>
Message-ID: <2d058d75-9f63-ff29-0bca-5ac267bc0bf2@bytedance.com>
Date:   Fri, 31 Jul 2020 12:00:11 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200728132630.678f94f7@oasis.local.home>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


在 2020/7/29 上午1:26, Steven Rostedt 写道:
> On Wed, 29 Jul 2020 00:59:33 +0800
> Chengming Zhou <zhouchengming@bytedance.com> wrote:
>
>
>>> i.e.
>>>
>>>   # echo some_module_function > set_ftrace_filter
>>>   # rmmod module_with_that_function
>>>   # insmod module_with_same_address_of_function
>>>   # echo function > current_tracer
>>>
>>> Now the tr->ops->hash would still have the function of the original
>>> module.  
>> I thought all ftrace_ops has non empty func_hash are on the ftrace 
>> global list...
> Nope, the two are disjoint.
>
>> Well, so I just leave this function unmodified.
>>
>> Just call that new function register_ftrace_ops_hash() from 
>> ftrace_release_mod.
> I would say to have anything that uses one of the
> ftrace_set_filter/notrace* functions, to also register itself for
> module removal.
>
> 	register_ftrace_mod_removal(struct ftrace_ops *ops);
>
> and then also have a unregister_ftrace_mod_removal() as there needs to
> be a way to remove it from the list before the ops gets freed.
>
> Then these functions would add the ops to a list, and this list is
> traversed to remove modules. The trace_arrays can register their ops
> too, so you can update that function.
>
> -- Steve


I thought about this, and at last I think you are right that it's better
the owner of the hash

do the ip clean work instead of the ftrace system...  so we should fix
kprobe's handling

of module going, not in ftrace.

Thanks!

>
>> Thanks!
>>
>>> Either have all owners of ftrace_ops handle this case, or add a helper
>>> function to handle it for them. But using ftarce_ops_list is the wrong
>>> place to do it.
>>>
>>> -- Steve
>>>
>>>  
>>>> +	mutex_lock(&ftrace_lock);
>>>> +
>>>> +	do_for_each_ftrace_op(op, ftrace_ops_list) {
>>>> +		if (!op->func_hash)
>>>>   			continue;
>>>> -		mutex_lock(&tr->ops->func_hash->regex_lock);
>>>> -		clear_mod_from_hash(pg, tr->ops->func_hash->filter_hash);
>>>> -		clear_mod_from_hash(pg, tr->ops->func_hash->notrace_hash);
>>>> -		mutex_unlock(&tr->ops->func_hash->regex_lock);
>>>> -	}
>>>> -	mutex_unlock(&trace_types_lock);
>>>> +		mutex_lock(&op->func_hash->regex_lock);
>>>> +		clear_mod_from_hash(pg, op->func_hash->filter_hash);
>>>> +		clear_mod_from_hash(pg, op->func_hash->notrace_hash);
>>>> +		mutex_unlock(&op->func_hash->regex_lock);
>>>> +	} while_for_each_ftrace_op(op);
>>>> +
>>>> +	mutex_unlock(&ftrace_lock);
>>>>   }
>>>>   
>>>>   static void ftrace_free_mod_map(struct rcu_head *rcu)  
