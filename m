Return-Path: <SRS0=EowN=3M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 065D7C33CB6
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jan 2020 15:11:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D1EFD21835
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jan 2020 15:11:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WQYyGWnp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728899AbgAWPLn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jan 2020 10:11:43 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:30362 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726240AbgAWPLm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jan 2020 10:11:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1579792301;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=G0UV4KnB1lt7EMsASswd8dWEm02CKeOR2gA8iM2LVcI=;
        b=WQYyGWnpQ88Iji73ef73styg+omxBP0+gbiEK5aMGxzusjb6yMrArWhLkogNIXa3UVindP
        gW4uudQF5U0p6p2rR7lp3U3R6W30kaAg3vyx+nHVm2VSSFtQ4djKLS6rPFWRnuBiqkVQ8J
        s7pzdfX0OgUZbUHj7FJ1SIvjNIowDxs=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-2--pTQctVxPEKacXU9gvjBXA-1; Thu, 23 Jan 2020 10:11:25 -0500
X-MC-Unique: -pTQctVxPEKacXU9gvjBXA-1
Received: by mail-wr1-f70.google.com with SMTP id h30so1935330wrh.5
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jan 2020 07:11:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=G0UV4KnB1lt7EMsASswd8dWEm02CKeOR2gA8iM2LVcI=;
        b=U5jwoTEW7QVTmvDIy3/An88C0/YIxNYbksOJaBZIUN+fnm1rL0GVgAKtA1Pdrp3ZZo
         xGjOHIlS5ha6aDBoGjjU8REmb9k9y7RBLXoNraY9MUFIKb4/nAUMKqaYoaM/wr+gBpWI
         +CgLZiXbA51UMWPcMio1Q5A8Ns/1OlfoGNRtr4F63mrtg2DQFiAIill7Ul2vZGFzdhdu
         mWWPqzR22JRMwgsV6Xeq6uIssUBANlT1MBPgDgi9mb+EN00wU4qIGQriaO5pAj7KwNJz
         T/OUXAcH950yzobNnqYht/INH5NnHrF9snyJ/euO1x0TyHkcMmvsqCeDILzNS2wSbBLC
         veug==
X-Gm-Message-State: APjAAAUrtFmI4w7Dn/lAM3XHUVzGydQdamWO0LJIhW4PLhjj/QNtvert
        meOHuFzzk6ewX05cnn4CJuRfV3eaZXUF/evUrgc2foPQMjUSXDqReXNoRDfLsQgYhH4oLV1tB42
        YvwhKGOUMkGJiNnc30oN3Ooq5
X-Received: by 2002:a05:600c:2059:: with SMTP id p25mr4912889wmg.161.1579792282960;
        Thu, 23 Jan 2020 07:11:22 -0800 (PST)
X-Google-Smtp-Source: APXvYqyuG8AqgpsWohRveZfsCX1EDtHU8w7RprAsRh0cBlav4qVZZ5HalRTUC8mBUSmFThwXkidyhg==
X-Received: by 2002:a05:600c:2059:: with SMTP id p25mr4912872wmg.161.1579792282748;
        Thu, 23 Jan 2020 07:11:22 -0800 (PST)
Received: from [192.168.1.81] (host81-140-166-164.range81-140.btcentralplus.com. [81.140.166.164])
        by smtp.gmail.com with ESMTPSA id k16sm3720036wru.0.2020.01.23.07.11.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Jan 2020 07:11:22 -0800 (PST)
Subject: Re: [RFC v5 00/57] objtool: Add support for arm64
To:     Will Deacon <will@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        jpoimboe@redhat.com, peterz@infradead.org, raphael.gault@arm.com,
        catalin.marinas@arm.com
References: <20200109160300.26150-1-jthierry@redhat.com>
 <20200121103025.GC11154@willie-the-truck>
 <400d402d-c964-6f0c-2954-6f6afcb94635@redhat.com>
 <20200123143503.GA19649@willie-the-truck>
From:   Julien Thierry <jthierry@redhat.com>
Message-ID: <ad6f3a12-60b9-f2d8-b0c9-0de59c0e0c2c@redhat.com>
Date:   Thu, 23 Jan 2020 15:11:20 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <20200123143503.GA19649@willie-the-truck>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/23/20 2:35 PM, Will Deacon wrote:
> On Thu, Jan 23, 2020 at 01:52:17PM +0000, Julien Thierry wrote:
>>
>>
>> On 1/21/20 10:30 AM, Will Deacon wrote:
>>> On Thu, Jan 09, 2020 at 04:02:03PM +0000, Julien Thierry wrote:
>>>> This patch series is the continuation of Raphael's work [1]. All the
>>>> patches can be retrieved from:
>>>> git clone -b arm64-objtool-v5 https://github.com/julien-thierry/linux.git
>>>
>>> [...]
>>>
>>>>     objtool: arm64: Decode unknown instructions
>>>>     objtool: arm64: Decode simple data processing instructions
>>>>     objtool: arm64: Decode add/sub immediate instructions
>>>>     objtool: arm64: Decode logical data processing instructions
>>>>     objtool: arm64: Decode system instructions not affecting the flow
>>>>     objtool: arm64: Decode calls to higher EL
>>>>     objtool: arm64: Decode brk instruction
>>>>     objtool: arm64: Decode instruction triggering context switch
>>>>     objtool: arm64: Decode branch instructions with PC relative immediates
>>>>     objtool: arm64: Decode branch to register instruction
>>>>     objtool: arm64: Decode basic load/stores
>>>>     objtool: arm64: Decode load/store with register offset
>>>>     objtool: arm64: Decode load/store register pair instructions
>>>>     objtool: arm64: Decode FP/SIMD load/store instructions
>>>>     objtool: arm64: Decode load/store exclusive
>>>>     objtool: arm64: Decode atomic load/store
>>>>     objtool: arm64: Decode pointer auth load instructions
>>>>     objtool: arm64: Decode load acquire/store release
>>>>     objtool: arm64: Decode load/store with memory tag
>>>>     objtool: arm64: Decode load literal
>>>>     objtool: arm64: Decode register data processing instructions
>>>>     objtool: arm64: Decode FP/SIMD data processing instructions
>>>>     objtool: arm64: Decode SVE instructions
>>>
>>> That's a lot of decoding logic which we already have in
>>> arch/arm64/{kernel/insn.c,include/asm/insn.h}. I'd prefer to see this stuff
>>> reused or generated from a single source, since it's really easy to get it
>>> wrong, has a tendency to bitrot and is nasty to debug.
>>>
>>
>> The thing is that the code in those files is mostly encoding logic
>> (motivated by BPF) rather than decoding (except for the instruction that
>> might be trapped, but these rarely overlap with instructions that objtools
>> cares about). I agree that ideally the decoding/encoding should be under
>> arch/arm64/lib, I was just a bit weary introducing a lot of decoding code
>> under arch/arm64 that wouldn't even be used in kernel code.
> 
> Hmm, but kprobes decodes instructions somehow :p
> 
> Not saying you have to refactor everything, but I'd hope you could reuse
> some of the aarch64_insn_is* and aarch64_insn_extract* functions at least.
> 

Oh, you're right, there seem to be more than what I remembered. There is 
probably a bunch of things I can reuse (and I'll feel more at ease with 
that rather than introducing a whole bunch of new code :D ).

Thanks,

-- 
Julien Thierry

