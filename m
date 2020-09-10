Return-Path: <SRS0=87nF=CT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6AE2C433E2
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 02:04:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8F1DF206DB
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 02:04:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="u/iv2lgV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729521AbgIJCEo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Sep 2020 22:04:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729935AbgIJBph (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Sep 2020 21:45:37 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EE89C061342
        for <linux-kernel@vger.kernel.org>; Wed,  9 Sep 2020 18:45:37 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id 34so3344154pgo.13
        for <linux-kernel@vger.kernel.org>; Wed, 09 Sep 2020 18:45:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=srlzi6kO9KxXkI8QJDt5Z43HoR7v2ko9LYXQ8jt4y44=;
        b=u/iv2lgVycfu88AolfBLdcxoQkKwFXlBKbtJ8zj8UK6eoFLqKxQheAfb05BlbcjwKz
         G8IsBcKBAAda2DaUi0COUFu04Hgo/bR90dfH8TpuflZRaHnC1khAEnRbSFJQPHZdmbOU
         52oCPFtp2JMMYx+7+DIob4TqY2CPbrFgfDAD4HYjqQ0FZNHOF9gB/q+C2Fs3bpOQg0YE
         hue7OYmW6G4eWQeXxXOT1y6I0qdgh2BpgOh4Ybit8LKhLF1Gi1vG2NHllpk0fVbF9hS8
         f0vWsNBOavuocqCQkz3yBm5hrrBsPxXEPuV1wvG1Tk++5ZE9iciU1ZSfbVrnFoMcVRO7
         rjYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=srlzi6kO9KxXkI8QJDt5Z43HoR7v2ko9LYXQ8jt4y44=;
        b=RkdOxXI5C4zaiXNb9DIec+Cbg/SdQS+oGJ63qkH6PiKvQS0vKBq6QBOeiJJSzweZXU
         vLI86bB9HuT0njKQQXsS3vqnE6wvs4JFn8JRbo0Ee2tNRL/TNALPctgi+UflmwxrOo+J
         jJDEiDMYde1JZ2SanLAkyM9bGi67TAV+NkODYZ3UqGmxq8yrWQlyNoJDn6mMjnPcCRsD
         PzkLBS20erHT9PJY/CYDrHk80x4ZogUQ/HmXleUrH1Xo9DoNXAMFt+71GA6acEqRKtWe
         2c7mADynioRawJJwmVTJ5GH0DG/Dp5qgKMLqsMy5L05E6+JQThrpbt0GXgWJcdGSiRG0
         p9xg==
X-Gm-Message-State: AOAM5304fV3LUr7SpIzaCi/wWRhzUBCOsRK5K/3eGwEIedWFMHleadK1
        N2gXcZA1CP+FSpHlP5asXKtfVA==
X-Google-Smtp-Source: ABdhPJyqpWOeqHuTEIwwj1uDXktA1dBPRjOp1EaAUDe2coNSXU+KFMxtpo7uhsAAcumooCW0G+ElHQ==
X-Received: by 2002:a62:b407:: with SMTP id h7mr3166747pfn.134.1599702336093;
        Wed, 09 Sep 2020 18:45:36 -0700 (PDT)
Received: from [192.168.1.11] ([71.212.141.89])
        by smtp.gmail.com with ESMTPSA id s20sm3936396pfu.112.2020.09.09.18.45.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Sep 2020 18:45:35 -0700 (PDT)
Subject: Re: [PATCH v2 0/2] MTE support for KVM guest
To:     Andrew Jones <drjones@redhat.com>,
        Steven Price <steven.price@arm.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Marc Zyngier <maz@kernel.org>, Will Deacon <will@kernel.org>,
        "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
        Peter Maydell <Peter.Maydell@arm.com>, qemu-devel@nongnu.org,
        Dave Martin <Dave.Martin@arm.com>,
        Juan Quintela <quintela@redhat.com>,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org
References: <20200904160018.29481-1-steven.price@arm.com>
 <20200909152540.ylnrljd6aelxoxrf@kamzik.brq.redhat.com>
From:   Richard Henderson <richard.henderson@linaro.org>
Message-ID: <5cb1d7ed-54a5-4337-6c3d-2e3e7df89f17@linaro.org>
Date:   Wed, 9 Sep 2020 18:45:33 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200909152540.ylnrljd6aelxoxrf@kamzik.brq.redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/9/20 8:25 AM, Andrew Jones wrote:
>>  * Provide a KVM-specific method to extract the tags from guest memory.
>>    This might also have benefits in terms of providing an easy way to
>>    read bulk tag data from guest memory (since the LDGM instruction
>>    isn't available at EL0).
> 
> Maybe we need a new version of KVM_GET_DIRTY_LOG that also provides
> the tags for all addresses of each dirty page.

KVM_GET_DIRTY_LOG just provides one bit per dirty page, no?  Then VMM copies
the data out from its local address to guest memory.

There'd be no difference with or without tags, afaik.  It's just about how VMM
copies the data, with or without tags.

>>  * Provide support for user space setting the TCMA0 or TCMA1 bits in
>>    TCR_EL1. These would allow the VMM to generate pointers which are not
>>    tag checked.
> 
> So this is necessary to allow the VMM to keep tag checking enabled for
> itself, plus map guest memory as PROT_MTE, and write to that memory when
> needed? 

I don't see a requirement for the VMM to set TCMA0.


r~
