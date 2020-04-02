Return-Path: <SRS0=iZC5=5S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D079C43331
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 08:17:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 30AA22078E
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 08:17:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QcDEQzZi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387748AbgDBIRB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Apr 2020 04:17:01 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:24432 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2387695AbgDBIRA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Apr 2020 04:17:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1585815419;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=adQQTRL13HX85W9rTbiS6VARbFJqWcwGdSb1q2fioec=;
        b=QcDEQzZi9IjPomfWFSojQ/3VtjeK4uGADgBMB4NyAvtpYVLWy1hTBc7K3TjpmpCVz9z9N4
        OLOtvPVNtwepVI5Qyo+DVn7rtBxE6DSkdNoECITsypxYBeV3Nh4zoY1SSs9rQlOCcFb/ta
        jSvvBMUrmA7RNU2btzQv3imYkATiuM8=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-169-FYtsRmTYML2sJhLx53iyRQ-1; Thu, 02 Apr 2020 04:16:54 -0400
X-MC-Unique: FYtsRmTYML2sJhLx53iyRQ-1
Received: by mail-wm1-f70.google.com with SMTP id s22so714511wmh.8
        for <linux-kernel@vger.kernel.org>; Thu, 02 Apr 2020 01:16:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=adQQTRL13HX85W9rTbiS6VARbFJqWcwGdSb1q2fioec=;
        b=gnlYiBN81lYJ0D0lKLcqkM8y/6x7agYBX4w4ESwBp1e8f6gCLn0c9XPoNqKGw8T+5W
         kmzRzJQcNll2TOHI32a576byqxifBpw0/fPgQQrrD3PVJR0TTetxh7pQfFaqQNpHMmXF
         mu87atbIgnqYNgnpVhmHcdAnOoTSjjA8kDcdM9QUToqoiMq9pF8v2K9j3EwefAeLSyN/
         ko7XAM083J44NevbskYmL6NN2VSeFNqgF1z3Ex0Gq0J4AFbOIhMCwjYn9TrZd8JtTzuh
         rAdS3Dd45aPZj4NsYyP07kDTxMenzpjmV5M3yXlBaRbCS6N6B679W5GzUUiU0vWitv6H
         dKTA==
X-Gm-Message-State: AGi0PuYBBZBPGAW1GNULonnoXLFNbA5z9TiIQ8K54rWQaZUIUgL+vQE6
        vb7aygPNWrfFg5i/BfppkArRooUaXKlN3e7XUtmziL4Iu3Hf2TaloJSTLk98QB8GNRCqxuUzrSB
        MoCW3Zx02DD0GpmyG7V6Y8xwX
X-Received: by 2002:a7b:c343:: with SMTP id l3mr2333014wmj.38.1585815413320;
        Thu, 02 Apr 2020 01:16:53 -0700 (PDT)
X-Google-Smtp-Source: APiQypLU9B7TUBflkZhN1rOBH8BTpMKrs1CkvuyQFyDj2i9rlAK/HNjsW1RrHesMK2nTLFpxWUOu0Q==
X-Received: by 2002:a7b:c343:: with SMTP id l3mr2332999wmj.38.1585815413097;
        Thu, 02 Apr 2020 01:16:53 -0700 (PDT)
Received: from ?IPv6:2a01:cb14:58d:8400:ecf6:58e2:9c06:a308? ([2a01:cb14:58d:8400:ecf6:58e2:9c06:a308])
        by smtp.gmail.com with ESMTPSA id q4sm10375039wmj.1.2020.04.02.01.16.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Apr 2020 01:16:52 -0700 (PDT)
Subject: Re: [PATCH v2] objtool,ftrace: Implement UNWIND_HINT_RET_OFFSET
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Josh Poimboeuf <jpoimboe@redhat.com>, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, x86@kernel.org, mhiramat@kernel.org,
        mbenes@suse.cz, Steven Rostedt <rostedt@goodmis.org>
References: <20200330200254.GV20713@hirez.programming.kicks-ass.net>
 <20200331111652.GH20760@hirez.programming.kicks-ass.net>
 <20200331202315.zialorhlxmml6ec7@treble>
 <20200331204047.GF2452@worktop.programming.kicks-ass.net>
 <20200331211755.pb7f3wa6oxzjnswc@treble>
 <20200331212040.7lrzmj7tbbx2jgrj@treble>
 <20200331222703.GH2452@worktop.programming.kicks-ass.net>
 <d2cad75e-1708-f0bf-7f88-194bcb29e61d@redhat.com>
 <20200401170910.GX20730@hirez.programming.kicks-ass.net>
 <684d6e29-4a01-b4a5-f906-7bdee5ad108f@redhat.com>
 <20200402075036.GA20730@hirez.programming.kicks-ass.net>
From:   Julien Thierry <jthierry@redhat.com>
Message-ID: <30b3df44-6254-b5a7-2f5d-0bc071adb00e@redhat.com>
Date:   Thu, 2 Apr 2020 09:16:50 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200402075036.GA20730@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/2/20 8:50 AM, Peter Zijlstra wrote:
> On Thu, Apr 02, 2020 at 07:41:46AM +0100, Julien Thierry wrote:
>> On 4/1/20 6:09 PM, Peter Zijlstra wrote:
> 
>>> The code in question (x86's sync_core()), is an exception return to
>>> self. It pushes an exception frame that points to right after the
>>> exception return instruction.
>>>
>>> This is the only usage of IRET in STT_FUNC symbols.
>>>
>>> So rather than teaching objtool how to interpret the whole
>>> push;push;push;push;push;iret sequence, teach it how big the frame is
>>> (arch_exception_frame_size) and let it continue.
>>>
>>> All the other (real) IRETs are in STT_NOTYPE in the entry assembly.
>>>
>>
>> Right, I see.. However I'm not completely convinced by this. I must admit I
>> haven't followed the whole conversation, but what was the issue with the
>> HINT_IRET_SELF? It seemed more elegant, but I might be missing some context.
> 
> https://lkml.kernel.org/r/20200331211755.pb7f3wa6oxzjnswc@treble
> 
> Josh didn't think it was worth it, I think.
> 
>> Otherwise, it might be worth having a comment in the code to point that this
>> only handles the sync_core() case.
> 
> I can certainly do that. Does ARM have any ERETs sprinkled around in
> places it should not have? That is, is this going to be a problem for
> you?
> 

I had a quick look and I don't think there are ERETS in function 
symbols. And, worst case scenario, I could also just keep the arm64 
decoder making ERETS as INSN_CONTEXT_SWITCH as I didn't need more 
semantics so far (and arm64 ERET don't affect the stack anyway).

After you pointed out this only affect this very specific pattern, I 
admit that my concerns are more about "not having weird stuff in the 
generic part".
If it's too much of a hassle I can understand if you prefer to just put 
a comment. But if most of this can be kept to the arch specific decoder 
I think it'd be nicer :) .

>> Also, instead of adding a special "arch_exception_frame_size", I could
>> suggest:
>> - Picking this patch [1] from a completely arbitrary source
>> - Getting rid of INSN_STACK type, any instruction could then include stack
>> ops on top of their existing semantics, they can just have an empty list if
>> they don't touch SP/BP
>> - x86 decoder adds a stack_op to the iret to modify the stack pointer by the
>> right amount
> 
> That's not the worst idea, lemme try that.
> 

Thanks, keep me in Cc if you post a new version using that!

Cheers,

-- 
Julien Thierry

