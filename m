Return-Path: <SRS0=4r1w=5T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB4C3C43331
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 08:01:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9FFE206F8
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 08:01:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dsTA2xtz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389448AbgDCIBr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Apr 2020 04:01:47 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:60129 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727431AbgDCIBr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Apr 2020 04:01:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1585900906;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=t0lsX/x9+PyHMjEl9oBBvGBVzDFKOmYTP+L6m59O3mk=;
        b=dsTA2xtzHAe1pnKcVxnW/MyEX+nnZG75It+mst4S2Gvj+RMtw/uwoBZO8/4jviUoDWW5di
        kCbmGMV5xozCILGWPCoI/IyotPV7bD48I9nBjUa+TxtJ+YZQYLH+J9zWD5cFztg0LQIHzZ
        9Uk+fZoF6MA7LnQbBEfWt6eWLHWtyp8=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-93-YHeymKviMRy45qvE9OcUrg-1; Fri, 03 Apr 2020 04:01:41 -0400
X-MC-Unique: YHeymKviMRy45qvE9OcUrg-1
Received: by mail-wr1-f69.google.com with SMTP id l17so2705063wro.3
        for <linux-kernel@vger.kernel.org>; Fri, 03 Apr 2020 01:01:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=t0lsX/x9+PyHMjEl9oBBvGBVzDFKOmYTP+L6m59O3mk=;
        b=cGI+i2qIx9QXP13nj6o8v5+G4barXzQjEWckxiQYbih08tF8eMYdlag4aZxa4o0Pxx
         1fKtkdWOHXEWk+qGxou+exz4d5pCWe2fOo5hpb9g0QvOHwTfj0aIK5sDKZbK8m0r4KVj
         ED7jMixslKwBX5BTCUc1ynoPMKTjUmt3qESAL9qwQAS/7zdvovx9awGXKcTGOs4nLVsS
         hjuc5x/7cKnNobUgsKPnOsJfYYtQ+qDjdnGms93UJs8S/5iwK5rTFUlhpuvtQ+FB9N0Y
         2I9CodVKzNAgRYzaBwFAUJwK7sbO9HXSC/5EpOP4hElWn1jOqer/2+7feSXtLEuvOYix
         bR3g==
X-Gm-Message-State: AGi0PuYdE12hneG4KCzRfnbO93EpNHFiap2m7KMqKWikRUwndSXP45zr
        jVWNx3ti1MsmeziDZ0G/QsHkAmnpvjoXIVqylGheiz0TAdt+MU9bpSqC18vXFIwFFWjDPL2HvBO
        VVnTfklfvSHqQHc6T7IsKABKT
X-Received: by 2002:a1c:ac8a:: with SMTP id v132mr7102695wme.62.1585900900726;
        Fri, 03 Apr 2020 01:01:40 -0700 (PDT)
X-Google-Smtp-Source: APiQypLyHlb5IXsfAhPUTh9sLO0yVHO17ALsitrpsruGRbKl+AB2Mc4icG7UPpGLjoE7E14Y4REO/w==
X-Received: by 2002:a1c:ac8a:: with SMTP id v132mr7102673wme.62.1585900900503;
        Fri, 03 Apr 2020 01:01:40 -0700 (PDT)
Received: from ?IPv6:2a01:cb14:58d:8400:ecf6:58e2:9c06:a308? ([2a01:cb14:58d:8400:ecf6:58e2:9c06:a308])
        by smtp.gmail.com with ESMTPSA id w67sm10653663wmb.41.2020.04.03.01.01.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Apr 2020 01:01:39 -0700 (PDT)
Subject: Re: [PATCH 3/7] objtool: Add support for intra-function calls
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     Alexandre Chartre <alexandre.chartre@oracle.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, peterz@infradead.org,
        tglx@linutronix.de
References: <20200402082220.808-1-alexandre.chartre@oracle.com>
 <20200402082220.808-4-alexandre.chartre@oracle.com>
 <db508586-258a-0616-d649-e76e95df9611@redhat.com>
 <20200402154919.2c6shw4hfreagchg@treble>
From:   Julien Thierry <jthierry@redhat.com>
Message-ID: <3d075cb2-8d99-5ab7-4842-efef1964247d@redhat.com>
Date:   Fri, 3 Apr 2020 09:01:38 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200402154919.2c6shw4hfreagchg@treble>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/2/20 4:49 PM, Josh Poimboeuf wrote:
> On Thu, Apr 02, 2020 at 01:53:49PM +0100, Julien Thierry wrote:
>> Hi Alexandre,
>>
>> I ran into the limitation of intra-function call for the arm64 support but
>> didn't take the time to make a clean patch to support them properly.
> 
> Can you give an example of where arm64 uses intra-function calls?  It
> sounds sketchy to me :-)  Is it really needed/useful?
> 

So the most notable/necessary one(s) is the one in tramp_ventry [1]. 
This macro is used as the begining of exception handlers for exceptions 
coming from userland. It was added as part of the mitigations of spectre 
(v1???).

To give some context, x30 is the register that "ret" instruction will 
use as return address, "bl" is the equivalent of x86 "call" and sets x30 
before jumping to the target address. (However, it doesn't have a 
special semantic for exception returns)

Note: I believe the comment about the return "stack" is about processor 
internal state (speculative thingies and all) rather than the actual 
stack, since the stack is untouched by that code. But I don't know the 
actual details.


There are also some in arch/arm64/crypto/crct10dif-ce-core.o , which is 
probably full of fast, smart and optimized code I don't understand :) . 
So I wouldn't feel confident commenting on whether those intra-function 
calls are needed or not.


Last I found is in qcom_link_stack_sanitization() [2], but that's just a 
workaround for a very specific hardware. In my local tree I just put the 
function as STACK_FRAME_NON_STANDARD. But the code just saves the return 
address, has 16 call instructions that just call the instruction after 
them, restores the return address and lets the C-function return 
normally (and it somehow fixes something for that hardware).


Those are the ones I stumbled on. So yes, it a bit sketchy, corner case 
code, but it's there and unlikely to go away.


[1] 
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/arm64/kernel/entry.S?h=v5.6#n803

[2] 
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/arm64/kernel/cpu_errata.c?h=v5.6#n195

Cheers,

-- 
Julien Thierry

