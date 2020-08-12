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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9941AC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Aug 2020 14:36:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 723472078B
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Aug 2020 14:36:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KfP8+LSt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726529AbgHLOgn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Aug 2020 10:36:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726485AbgHLOgm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Aug 2020 10:36:42 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBF03C061383
        for <linux-kernel@vger.kernel.org>; Wed, 12 Aug 2020 07:36:41 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id g19so2506940ejc.9
        for <linux-kernel@vger.kernel.org>; Wed, 12 Aug 2020 07:36:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=oup0ovJVk0ZzLFn1WFt+Fd6kUmlpI1Q5XsgroeR5poY=;
        b=KfP8+LStZaPc5Z+kDwKBbf3a3PVcSEbFW9YQWnzb2ElK6LQrgREOBBD0OVufN2AGhz
         R9blIm3AcWsvYq3uhNlwIA9SARzAoMl0OSLYBYPJsDuevSTlZ5Fh0UHeTpoPIzyKi1N3
         BsGgEYk955QLOnC0FWMjt2OCpALHYSgk3t9zM4SAZ6ujzFN2DKbcbru2Q//CssA+mIOw
         IXfJMtg34u/gDJojAf94by279UTzeVv+LIcg4Ks2lubF0GldE/KSGNv90ATkdBkZ9EhY
         8WoXcfEq0uCIj7xFvirx6myWruJxK276cy7pJIZYtqNESxGvsWZlCVeDgQqiJcrehcgY
         nhaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:cc:references:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-transfer-encoding:content-language;
        bh=oup0ovJVk0ZzLFn1WFt+Fd6kUmlpI1Q5XsgroeR5poY=;
        b=JEVpF++C5ROFfUVz8vPFYusyVgk2TgfwLuul4NWBldwQbLpTdD2EcbsM4N2Qa9cexq
         wPdJpRz4EfEdQccc8BZMdeEApPqiIRHcmYsl7SETa1rufTgijBI4j915zH95vbtdxfQ6
         t3W9dn/sietkCyWIc8NoppBYLw/KAA73HKuqAGJR0Vxd9IuHA3kSdQRT0DtVrwXW82zp
         rDD01N/va55bivf6zuSec7GWdPJqA4NnUPDiynlVBVh4G6pkYS2YSaTYZzLF1oNOUW/v
         Hlv/TMxnRkoEl958sIZ87aDYy9RuU8WiFc/BCTXJ30NDtu9B/804aPKBcl34YWnAW44p
         DjRg==
X-Gm-Message-State: AOAM532ytnniAIIjMe2k17vTB7yhhttzcYakvgY9aRLd15VvKXfGOMj8
        Gf5yOIuNWm2ROmOicjSNCjMvMgXU
X-Google-Smtp-Source: ABdhPJysEoEMFd2mgwOJBkeM4ZYhPcKueFh0f2ifqETzuCgD9ec1eNIUPqGaAlnjposVrUwWwh4sxw==
X-Received: by 2002:a17:906:3ac4:: with SMTP id z4mr71162ejd.65.1597243000527;
        Wed, 12 Aug 2020 07:36:40 -0700 (PDT)
Received: from ?IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7? ([2a02:908:1252:fb60:be8a:bd56:1f94:86e7])
        by smtp.gmail.com with ESMTPSA id p16sm1681003ejd.27.2020.08.12.07.36.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Aug 2020 07:36:39 -0700 (PDT)
Reply-To: christian.koenig@amd.com
Subject: Re: [PATCH] drm/amdgpu: adjust the pid in the grab_id trace point
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Shashank.Sharma@amd.com,
        daniel.vetter@ffwll.ch, alexander.deucher@amd.com
References: <20200807133658.1866-1-christian.koenig@amd.com>
 <20200807133658.1866-2-christian.koenig@amd.com>
 <20200812141755.GA8136@home.goodmis.org>
From:   =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <e48b6300-7ba7-f2fc-b7f7-a205d32607a4@gmail.com>
Date:   Wed, 12 Aug 2020 16:36:36 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200812141755.GA8136@home.goodmis.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 12.08.20 um 16:17 schrieb Steven Rostedt:
> On Fri, Aug 07, 2020 at 03:36:58PM +0200, Christian König wrote:
>> Trace something useful instead of the pid of a kernel thread here.
>>
>> Signed-off-by: Christian König <christian.koenig@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h
>> index 5da20fc166d9..07f99ef69d91 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h
>> @@ -228,6 +228,7 @@ TRACE_EVENT(amdgpu_vm_grab_id,
>>   			     ),
>>   
>>   	    TP_fast_assign(
>> +			   __entry->ent.pid = vm->task_info.pid;
> If the ent.pid is not the pid you are interested in for this trace event, just
> add a "pid" field to the trace event and place it there. Do not modify the
> generic pid that is recorded, as we would like that to be consistent for all
> trace events.

The problem my userspace guys have is that this doesn't work with 
"trace-cmd -P $pid".

But I think I can teach them how filters work :)

> The "ent.pid" turns into "common_pid" in the field, leaving "pid" free to use.
> Other trace events (like sched_waking) record a pid field that is not the same
> as the pid of the executing task.

Yes, we thought about this alternative as well.

> The "ent.pid" should always be the pid of the task that executed the event.

Why? For the case here we just execute a work item in the background for 
an userspace process.

Tracing the pid of the worker pool which executes it doesn't seem to 
make to much sense.

Thanks for the quick reply,
Christian.

>
> -- Steve
>
>
>>   			   __entry->pasid = vm->pasid;
>>   			   __assign_str(ring, ring->name)
>>   			   __entry->vmid = job->vmid;
>> -- 
>> 2.17.1

