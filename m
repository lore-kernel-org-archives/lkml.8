Return-Path: <SRS0=S/iQ=BK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4247C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 08:19:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7924D20829
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 08:19:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DqPl2iuN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731962AbgGaITh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jul 2020 04:19:37 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:28176 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731682AbgGaITg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jul 2020 04:19:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1596183574;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jfFMjT41x32JmXGU4h8v9Y4PzlKoVZrgQhXXJtzjd24=;
        b=DqPl2iuNeMAIHmUm7+kWio6PwGCMFirpvU+Pg+mS8FkiTv2xRJA0yFgb4fLGZNO2KE4yAb
        MHA15Uzhq5RgjrNQZPilTGDm9Zg8YkR9zYcXtyd/AURjrLC9Fy43uaxOWFKNpDu7MM2HDM
        0FP96m2mjxF4ikpvJfM4KO5wrGDvckA=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-9-WgvKttdvNsubI0NEnjlo4Q-1; Fri, 31 Jul 2020 04:19:30 -0400
X-MC-Unique: WgvKttdvNsubI0NEnjlo4Q-1
Received: by mail-wr1-f71.google.com with SMTP id z12so8892213wrl.16
        for <linux-kernel@vger.kernel.org>; Fri, 31 Jul 2020 01:19:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=jfFMjT41x32JmXGU4h8v9Y4PzlKoVZrgQhXXJtzjd24=;
        b=kwDPldkObU14rzvziyCLEf8qXNQ+PAeFqGMdhbyhp9QVLh3nYKrDK8uH5zaakshPzK
         bbXKEVu/ZSq1iOt9GxWnEIRB+1kvW6EtAsi8uNUbJlQcPY5aKGPp4G+t8qZASYdeSxLJ
         nZt1YKIsSCapcHiim/c570l61PjedKsM1DNDy7zoRjuMW5yQvzJZ2zjlq9+mswZLU01a
         cQ0c7BVBLjFRiPFfiTexuY7iPsHMCnRl1Ufxrc9BCCNHO10acFmb+01IiuMBymKRhRnr
         Gt4q2iZT8DqtOhLTathW0uyLI4j6U/Rc4Px/frR6ctAgA95Nh3m/sBp/HrVFFYUy0AN2
         lpdw==
X-Gm-Message-State: AOAM530v0bazuyFKEzo7o01cEfMQBh6KZlJ4kgPgN8oND+df0S87xtIf
        ArYjUPT4MYKQCN2zGgPU6FFLWNgQzZbWAGYLywNf89uXntSiRjDN9CNCihJxp/dgbXznWZZGgos
        cnILzoLy+no5/L3nWHRLjgB/n
X-Received: by 2002:a7b:c316:: with SMTP id k22mr2710962wmj.41.1596183569058;
        Fri, 31 Jul 2020 01:19:29 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwkSafGFHyjbCKRO5npiw4aj8riuizOGooQrO23LAmIE9oUXkmBZn/NeB028W2r8C5RaLFZXw==
X-Received: by 2002:a7b:c316:: with SMTP id k22mr2710951wmj.41.1596183568884;
        Fri, 31 Jul 2020 01:19:28 -0700 (PDT)
Received: from ?IPv6:2a01:cb14:499:3d00:cd47:f651:9d80:157a? ([2a01:cb14:499:3d00:cd47:f651:9d80:157a])
        by smtp.gmail.com with ESMTPSA id p22sm10822051wmc.38.2020.07.31.01.19.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 31 Jul 2020 01:19:27 -0700 (PDT)
Subject: Re: [PATCH v3 2/4] objtool: Move orc outside of check
To:     Miroslav Benes <mbenes@suse.cz>
Cc:     Josh Poimboeuf <jpoimboe@redhat.com>, peterz@infradead.org,
        linux-kernel@vger.kernel.org
References: <20200730094143.27494-1-jthierry@redhat.com>
 <20200730094143.27494-3-jthierry@redhat.com>
 <20200730095759.GH2655@hirez.programming.kicks-ass.net>
 <dfe69c8f-db70-8366-5601-2592409ce7a0@redhat.com>
 <20200730132237.GM2655@hirez.programming.kicks-ass.net>
 <3af41a3b-a4b9-8120-3ac0-c9ce13770628@redhat.com>
 <20200730141526.lr33zv4ffa3rdygp@treble>
 <7f7a7196-8b28-cd55-0685-799766bb6d4c@redhat.com>
 <alpine.LSU.2.21.2007310949020.19678@pobox.suse.cz>
From:   Julien Thierry <jthierry@redhat.com>
Message-ID: <c3b0636e-3f32-8349-3e86-277da8c54606@redhat.com>
Date:   Fri, 31 Jul 2020 09:19:27 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <alpine.LSU.2.21.2007310949020.19678@pobox.suse.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/31/20 8:56 AM, Miroslav Benes wrote:
> On Thu, 30 Jul 2020, Julien Thierry wrote:
> 
>>
>>
>> On 7/30/20 3:15 PM, Josh Poimboeuf wrote:
>>> On Thu, Jul 30, 2020 at 02:29:20PM +0100, Julien Thierry wrote:
>>>>
>>>>
>>>> On 7/30/20 2:22 PM, peterz@infradead.org wrote:
>>>>> On Thu, Jul 30, 2020 at 01:40:42PM +0100, Julien Thierry wrote:
>>>>>>
>>>>>>
>>>>>> On 7/30/20 10:57 AM, peterz@infradead.org wrote:
>>>>>>> On Thu, Jul 30, 2020 at 10:41:41AM +0100, Julien Thierry wrote:
>>>>>>>> +		if (file->elf->changed)
>>>>>>>> +			return elf_write(file->elf);
>>>>>>>> +		else
>>>>>>>> +			return 0;
>>>>>>>>       }
>>>>>>>
>>>>>>> I think we can do without that else :-)
>>>>>>>
>>>>>>
>>>>>> I did wonder and was not 100% confident about it, but the orc gen will
>>>>>> always change the file, correct?
>>>>>
>>>>> Not if it already has orc, iirc.
>>>>>
>>>>> But what I was trying to say is that:
>>>>>
>>>>>   if (file->elf->changed)
>>>>>    return elf_write(file->elf)
>>>>>
>>>>>   return 0;
>>>>>
>>>>> is identical code and, IMO, easier to read.
>>>>>
>>>>
>>>> Much easier yes, I'll change it.
>>>
>>> But I think file->elf->changed can be assumed at this point anyway, so
>>> it could just be an unconditional
>>>
>>>   return elf_write(file->elf);
>>>
>>
>> I'll triple check whether that's the case and remove the if if possible.
> 
> I think it is the case. And even if not, it would only cause a pointless
> call to elf_update() in the end and that should not do any harm anyway if
> I am not mistaken.
> 
> However, I think there is a problem with the rebase on top of the current
> code. The patch moves elf_write() call to orc_gen.c which was ok before
> Peterz introduced elf_write_insn() et al. We need to keep elf_write() in
> check.c for this case too.
> 

Yes, you're right. Looks like I messed things up with the rebase. That 
means I might have to move the elf_write() to builtin-check.c.

Thanks for pointing it out.

-- 
Julien Thierry

