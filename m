Return-Path: <SRS0=g10L=63=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 646F0C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 18:43:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 13993205ED
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 18:43:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EhETGKly"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390203AbgEMSnB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 May 2020 14:43:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1732218AbgEMSnA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 May 2020 14:43:00 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F94FC061A0C
        for <linux-kernel@vger.kernel.org>; Wed, 13 May 2020 11:43:00 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id g14so12513324wme.1
        for <linux-kernel@vger.kernel.org>; Wed, 13 May 2020 11:43:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=NTHZ/EmLIP+E6b63/qkBsQOKznY5Nc0LePxERT+sG40=;
        b=EhETGKly6kuyqOSqmqSrUao4vz15YN/LBkRa7dUNII/WmdhkEb/s6r9kfliELLboaG
         Kg5G0o92en0oNDm2mmR67HmHopu33qZ1LjYDncw3QaYG6yOypV8yGkCDqgVljQ4o8gIW
         toI/aGVZ1rHqe0rLZ8tnom6TyvdHipuTi6C4dauwelmz/VqVYRSkkA7wngaCo4xgg2qZ
         4/v87QBRTza+Xtjmljf+t2wZQVJbd7ACeLu0ywg+JwevO2HyCndajHhNTHqpWxx6bqwy
         odfqRePUacTQaKtkoLzfJ6MrNJlT59z9rV84EK1TjSxAZSv1p3M3eNt29OlE2t2TFcwC
         uM5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=NTHZ/EmLIP+E6b63/qkBsQOKznY5Nc0LePxERT+sG40=;
        b=QkW1lLjIR1a6q3OvCGsqPREPxR4vYECFUiTyv8LDWTCEDDlowESep+F+VHmfzKP64l
         nSu5wzGy/ZyQyj73bvSrVOogmOwmr66VAiI/lZ29zETXFFphc7qkN3cjTb7G6aJnoLJq
         BwjXvtCJeWafVGF2gGUNBG8U8mvPUHq+kVzcbV3fLC95jfZIU6/aNeIYVJXVm8UEAJ0V
         43yYokg0zgdUUkOaLs76G9tDwa9rin3jRTBEvmfU3cOrC8a5S9YceHLdBr2ZNp6PJU1c
         Lj06+1nwmcaTfTpdnRrQRtXD8uUPO2Juu++GjPQJIBCTKlHVdpk2BcYkWFI3xrjVr19F
         DJTw==
X-Gm-Message-State: AGi0PuZsioV7CFWRfVTKHumQXykekCXWP2tY6fJE/ZglggK9KVcKCroL
        bOA4Pn+Ob3lZRGkVnTXGeGeExDZ/
X-Google-Smtp-Source: APiQypKCqBNPjb/EH3rVGDgcO/+lWyv83TIJCCFbLYOlPVpY/nOantl4BW0weuT6zGdwvQPfgrkhiQ==
X-Received: by 2002:a1c:99d3:: with SMTP id b202mr45962354wme.126.1589395379379;
        Wed, 13 May 2020 11:42:59 -0700 (PDT)
Received: from ?IPv6:2a00:23c6:9e09:2900:3d38:90c1:858b:902e? ([2a00:23c6:9e09:2900:3d38:90c1:858b:902e])
        by smtp.gmail.com with ESMTPSA id n13sm507549wrs.2.2020.05.13.11.42.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 May 2020 11:42:58 -0700 (PDT)
Subject: Re: x86/smp: adding new trace points
To:     Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org
Cc:     mingo@redhat.com, hpa@zytor.com, x86@kernel.org,
        Steven Rostedt <rostedt@goodmis.org>,
        Will Deacon <will@kernel.org>
References: <4d54953b-f968-63f5-569f-9e09bc0f361c@gmail.com>
 <b638ef03-04c2-94bf-f026-a01691888624@gmail.com>
 <87y2pw2fav.fsf@nanos.tec.linutronix.de>
 <b3e3c317-17e4-081f-0bb6-3e6f291f8b86@gmail.com>
 <87sgg323bf.fsf@nanos.tec.linutronix.de>
From:   Wojciech Kudla <wk.kernel@gmail.com>
Message-ID: <56b36edb-1ff8-a154-d3c5-d2304e3554c0@gmail.com>
Date:   Wed, 13 May 2020 19:42:57 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <87sgg323bf.fsf@nanos.tec.linutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/05/2020 17:43, Thomas Gleixner wrote:
> Wojciech Kudla <wk.kernel@gmail.com> writes:
>> On 13/05/2020 13:24, Thomas Gleixner wrote:
>>
>>> Why would the SMP call function single interrupt go through the
>>> PLATFORM_IPI_VECTOR? It goes as the name says through the
>>> CALL_FUNCTION_SINGLE_VECTOR.
>>>
>>
>> Wrong vector, my bad.
>>
>> However 2) still stands in my opinion. We don't have "ipi raise" trace
>> point for x86.  RESCHEDULE_VECTOR, CALL_FUNCTION_SINGLE_VECTOR, as
>> well as TLB invalidation vectors are essentially
>> inter-processor-interrupts if I'm not mistaken.  Would a patch adding
>> such trace point be considered here?
> 
> Maybe.
> 
> Though that IPI tracing is inconsistent across architectures. I'm not
> really interested to have yet another x86 variant which is slightly
> different than anything else.
> 
> ARM and ARM64 share generic tracepoints for that, though the actual
> tracepoint invocation is in the architecture specific code.
> 
> If at all we really want to have the common IPIs which are required for
> SMP support covered by generic tracepoints and have them in the generic
> code and not sprinkled all over arch/*

How about we add ipi:ipi_raise trace points before:
- arch_send_call_function_single_ipi(), and 
- arch_send_call_function_ipi_mask()

Would that be a good starting point to introduce more generic IPI tracing?

Thanks,
Wojtek

