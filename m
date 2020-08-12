Return-Path: <SRS0=ZArZ=BW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58F21C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Aug 2020 15:34:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 317C6207DA
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Aug 2020 15:34:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m0CKfSDr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726521AbgHLPeB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Aug 2020 11:34:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726226AbgHLPeA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Aug 2020 11:34:00 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F1ACC061383
        for <linux-kernel@vger.kernel.org>; Wed, 12 Aug 2020 08:34:00 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id c16so2714047ejx.12
        for <linux-kernel@vger.kernel.org>; Wed, 12 Aug 2020 08:34:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=m+2qVHlDZpY7hx9L3KMg3fe8c3A5JPSpPG3a+ctXXAY=;
        b=m0CKfSDryPPtkng12FCAgfBja3BVI2AmhARiFxnpFU8MkvZk8n4EV6onExKL8Ln0jS
         xmf0JKUtBAI3yHddlf3Ej0jYPr0ylVMYE5B5LAB12sAS0HNzbRZpMaot7KnmbPvcqEMg
         2yfTjklAnGlK5+g/+zzqdob2UEdKQM8ScIqAGJQL73cHnfU+O8UXlkdCNiHDd2zYGJGW
         pdJGsxs6rJFu7mb9WrJiqQPjF1ZAdIONSfFNACGIydJspHOpsHqnfQVOBEH3b337aSIH
         mFMgRh/dos+z2zLWYum63y5ceaJvFFv0WINBSViZOKtcN4RqoC/73xgVegG82uMECTZd
         wudA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:cc:references:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-transfer-encoding:content-language;
        bh=m+2qVHlDZpY7hx9L3KMg3fe8c3A5JPSpPG3a+ctXXAY=;
        b=B4Jjj/r1LOYAb6eFmwitmOMSAcDq6gBFjYRwyCcknI9039o87a+Av1J5/0r4XbkUiZ
         jSTueE4bIiGE62mKBvo6ZGKRdSbe7bbY4/oV817WiotPUomQ+1gkDfAzUBt9QNHYL7Oz
         lRrJbp6Imo8QWBlM+o6kXXx1ofYixmzWLQhtu4e2oiYryM5vO9FcEziRq2X+dRzvl02l
         HJP0fEDPpnnf25QNkibqIdzf0LPzf/WhrozIw+sYpvNChZSscc+GMY5ag/LDWG2T6u4I
         BcGLcNC7GPwIlPIZmyAva2m8CZqF5JXJT79JSG52tXgSIYgl9mOlEQqPXLDvnfBvPmi2
         75IA==
X-Gm-Message-State: AOAM532XFZICCz1l6Nt3rIbjzFSVLA+y2WTRwlXxPC0Hy0M91hP4MO6d
        tNexmTt5cZWsV/IqZE9SFf0=
X-Google-Smtp-Source: ABdhPJzPWeKt4CeauJw6Lhyn5G4LPcMjQUCGwNmBjAvHlQ3upLq09MpfkXFz5KzwkqWy22XqHbGIBw==
X-Received: by 2002:a17:906:1986:: with SMTP id g6mr372317ejd.404.1597246438814;
        Wed, 12 Aug 2020 08:33:58 -0700 (PDT)
Received: from ?IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7? ([2a02:908:1252:fb60:be8a:bd56:1f94:86e7])
        by smtp.gmail.com with ESMTPSA id gl20sm1826200ejb.86.2020.08.12.08.33.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Aug 2020 08:33:58 -0700 (PDT)
Reply-To: christian.koenig@amd.com
Subject: Re: [PATCH] drm/amdgpu: adjust the pid in the grab_id trace point
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     christian.koenig@amd.com, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Shashank.Sharma@amd.com, daniel.vetter@ffwll.ch,
        alexander.deucher@amd.com
References: <20200807133658.1866-1-christian.koenig@amd.com>
 <20200807133658.1866-2-christian.koenig@amd.com>
 <20200812141755.GA8136@home.goodmis.org>
 <e48b6300-7ba7-f2fc-b7f7-a205d32607a4@gmail.com>
 <20200812111920.06efa663@oasis.local.home>
From:   =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <8f262830-7e73-09aa-e790-7222ab66038d@gmail.com>
Date:   Wed, 12 Aug 2020 17:33:54 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200812111920.06efa663@oasis.local.home>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 12.08.20 um 17:19 schrieb Steven Rostedt:
> On Wed, 12 Aug 2020 16:36:36 +0200
> Christian König <ckoenig.leichtzumerken@gmail.com> wrote:
>
>> Am 12.08.20 um 16:17 schrieb Steven Rostedt:
>>> On Fri, Aug 07, 2020 at 03:36:58PM +0200, Christian König wrote:
>>>> Trace something useful instead of the pid of a kernel thread here.
>>>>
>>>> Signed-off-by: Christian König <christian.koenig@amd.com>
>>>> ---
>>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h | 1 +
>>>>    1 file changed, 1 insertion(+)
>>>>
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h
>>>> index 5da20fc166d9..07f99ef69d91 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h
>>>> @@ -228,6 +228,7 @@ TRACE_EVENT(amdgpu_vm_grab_id,
>>>>    			     ),
>>>>    
>>>>    	    TP_fast_assign(
>>>> +			   __entry->ent.pid = vm->task_info.pid;
>>> If the ent.pid is not the pid you are interested in for this trace event, just
>>> add a "pid" field to the trace event and place it there. Do not modify the
>>> generic pid that is recorded, as we would like that to be consistent for all
>>> trace events.
>> The problem my userspace guys have is that this doesn't work with
>> "trace-cmd -P $pid".
>>
>> But I think I can teach them how filters work :)
> Yep, trace-cmd record -e event -f "pid == $pid"
>
>>> The "ent.pid" turns into "common_pid" in the field, leaving "pid" free to use.
>>> Other trace events (like sched_waking) record a pid field that is not the same
>>> as the pid of the executing task.
>> Yes, we thought about this alternative as well.
>>
>>> The "ent.pid" should always be the pid of the task that executed the event.
>> Why? For the case here we just execute a work item in the background for
>> an userspace process.
>>
>> Tracing the pid of the worker pool which executes it doesn't seem to
>> make to much sense.
> Maybe not for you, but it does for me. All trace events show what
> happened when it happened and who executed it. I like to see what
> worker threads are executing. I may filter on the worker thread, and by
> changing the ent.pid, I wont see what it is doing.

That's enough explanation for me. Going with the separate pid field then.

Thanks,
Christian.

>
> That said, I think I may add a feature to a trace evnt for a special filter
> to say, "test field to the set_event_pid", and if it exists in that
> file to include that event in the filtered trace. This would include
> sched_waking trace events as well.
>
> That way "trace-cmd record -P $pid" will still work for your case.
>
> -- Steve

