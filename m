Return-Path: <SRS0=EowN=3M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54E64C2D0DB
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jan 2020 13:52:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22D6520684
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jan 2020 13:52:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jWnQ47Uu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729154AbgAWNw0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jan 2020 08:52:26 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:59892 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726729AbgAWNw0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jan 2020 08:52:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1579787544;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FzK0nabFcVqCxu+Dc6EYvtOWvTDLB9MHtbAW7toY8PA=;
        b=jWnQ47Uuuy0UR+AUB7Gahh6BG9xCfkBLDQnVXMAcI1zh5dh6ggD/Wwj9qSDVaOYSwa3mgn
        UOZer9hlg5TG83SyCD6dtYb/syw91vKSAOUU9shFlPnaxBG8LKnSy3WXNZDtsBfJ1r5CR4
        FS9Z3YIXkhxStQL2nAvDdyy1wYjTUAA=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-174-ZiJkwW3FOwyTA2V4ZCYDKw-1; Thu, 23 Jan 2020 08:52:22 -0500
X-MC-Unique: ZiJkwW3FOwyTA2V4ZCYDKw-1
Received: by mail-wm1-f72.google.com with SMTP id t16so1056598wmt.4
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jan 2020 05:52:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=FzK0nabFcVqCxu+Dc6EYvtOWvTDLB9MHtbAW7toY8PA=;
        b=fa/bYEMi7qEoe27cvQjh/80ppOCX5+fvtUHvOlMFG+eqrsX80Q64qmyP1AzEx8KJ8T
         WhWNVNfFP75rJUQxp0Pw6zkAU2jOzfgOYJ1RoYwPiA2w7VaOfyn5+GhSjyX5ZJHbQXi+
         YUcsOBDoClEZkgJlKSbYladPeIaVnT/RdF7AaudIqSv1Qru1MkTpzp1GURy8eEHa+Ycl
         I49sWDyXvT/OzHt/kE90ILJAPjpfPO6W2JsbgsEoqABhaPqTgUeEc0g2SYwivcd1A6EX
         3DtfSwPTbOgRkASRCQBx20ATIJRrUa1VXkuTL3VvgS+3D8+i9WUWDWySnGD6A5ant5Bu
         MHZg==
X-Gm-Message-State: APjAAAUU9ysxa91odNet3r6atbaeWI/JGdX1ARbdqrkdM3+2kjwTDh0J
        5DqHKppavfEHjMsg5U50nXAGrtYGbMomptvcLUh0hwvAEc4/Dm4SbkUYK9f4+phdxcEI/JXS50A
        udX58URmEdt5Q1TPxPmgSKDI3
X-Received: by 2002:a1c:4008:: with SMTP id n8mr4342413wma.121.1579787540984;
        Thu, 23 Jan 2020 05:52:20 -0800 (PST)
X-Google-Smtp-Source: APXvYqwwuAHOv3mQdajAOj8Wx0mgp4dKgh3ugzrnb0nmfg+V0M9H/8uW8obx7N/CZnGLglD/gLhKTg==
X-Received: by 2002:a1c:4008:: with SMTP id n8mr4342396wma.121.1579787540799;
        Thu, 23 Jan 2020 05:52:20 -0800 (PST)
Received: from [192.168.1.81] (host81-140-166-164.range81-140.btcentralplus.com. [81.140.166.164])
        by smtp.gmail.com with ESMTPSA id l3sm3135558wrt.29.2020.01.23.05.52.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Jan 2020 05:52:20 -0800 (PST)
Subject: Re: [RFC v5 00/57] objtool: Add support for arm64
To:     Will Deacon <will@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        jpoimboe@redhat.com, peterz@infradead.org, raphael.gault@arm.com,
        catalin.marinas@arm.com
References: <20200109160300.26150-1-jthierry@redhat.com>
 <20200121103025.GC11154@willie-the-truck>
From:   Julien Thierry <jthierry@redhat.com>
Message-ID: <400d402d-c964-6f0c-2954-6f6afcb94635@redhat.com>
Date:   Thu, 23 Jan 2020 13:52:17 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <20200121103025.GC11154@willie-the-truck>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/21/20 10:30 AM, Will Deacon wrote:
> On Thu, Jan 09, 2020 at 04:02:03PM +0000, Julien Thierry wrote:
>> This patch series is the continuation of Raphael's work [1]. All the
>> patches can be retrieved from:
>> git clone -b arm64-objtool-v5 https://github.com/julien-thierry/linux.git
> 
> [...]
> 
>>    objtool: arm64: Decode unknown instructions
>>    objtool: arm64: Decode simple data processing instructions
>>    objtool: arm64: Decode add/sub immediate instructions
>>    objtool: arm64: Decode logical data processing instructions
>>    objtool: arm64: Decode system instructions not affecting the flow
>>    objtool: arm64: Decode calls to higher EL
>>    objtool: arm64: Decode brk instruction
>>    objtool: arm64: Decode instruction triggering context switch
>>    objtool: arm64: Decode branch instructions with PC relative immediates
>>    objtool: arm64: Decode branch to register instruction
>>    objtool: arm64: Decode basic load/stores
>>    objtool: arm64: Decode load/store with register offset
>>    objtool: arm64: Decode load/store register pair instructions
>>    objtool: arm64: Decode FP/SIMD load/store instructions
>>    objtool: arm64: Decode load/store exclusive
>>    objtool: arm64: Decode atomic load/store
>>    objtool: arm64: Decode pointer auth load instructions
>>    objtool: arm64: Decode load acquire/store release
>>    objtool: arm64: Decode load/store with memory tag
>>    objtool: arm64: Decode load literal
>>    objtool: arm64: Decode register data processing instructions
>>    objtool: arm64: Decode FP/SIMD data processing instructions
>>    objtool: arm64: Decode SVE instructions
> 
> That's a lot of decoding logic which we already have in
> arch/arm64/{kernel/insn.c,include/asm/insn.h}. I'd prefer to see this stuff
> reused or generated from a single source, since it's really easy to get it
> wrong, has a tendency to bitrot and is nasty to debug.
> 

The thing is that the code in those files is mostly encoding logic 
(motivated by BPF) rather than decoding (except for the instruction that 
might be trapped, but these rarely overlap with instructions that 
objtools cares about). I agree that ideally the decoding/encoding should 
be under arch/arm64/lib, I was just a bit weary introducing a lot of 
decoding code under arch/arm64 that wouldn't even be used in kernel code.

But I can make an attempt for the encode/decode lib and post it as part 
of the next version.

Cheers,

-- 
Julien Thierry

