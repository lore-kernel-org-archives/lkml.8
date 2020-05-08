Return-Path: <SRS0=wESH=6W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D57D9C38A2A
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 09:06:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A5CDD20731
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 09:06:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="WRAF6P7L"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726689AbgEHJGX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 May 2020 05:06:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725710AbgEHJGW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 05:06:22 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4090C05BD43
        for <linux-kernel@vger.kernel.org>; Fri,  8 May 2020 02:06:20 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id h4so9432656wmb.4
        for <linux-kernel@vger.kernel.org>; Fri, 08 May 2020 02:06:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=0CqA4loPPF6E9eRXK//8n8vhiVSDlCCFO/sM8CaSqh8=;
        b=WRAF6P7Lzru/RsZhpQYVK5RwPfEBjpOEykwS4VrYsy4B//Gt6tVM2KVh57a55HIaM3
         1W4mLA5CwGi9YD0K2VSlC/AUQv+LqfM2ISYrHX7bfEzmDA18RFN88UwsibUkQ2QshHoK
         ss9zWRXeWSW5u5R8LOVDLiQr76U3G37B1CJt0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=0CqA4loPPF6E9eRXK//8n8vhiVSDlCCFO/sM8CaSqh8=;
        b=D1n3hMbBV9vrFEjadwnNgONCdEDBj2rRjlbT6ErSk+DcPaAUl7TTUI32ykLKw78X9N
         lenxZzw5JIn/yuSPtN+3RnQqnO8XLQecdMzppt7Hoff7OSlkcGatkuqwpVl+Td9yiW9k
         ppYfDZw5pp3Ut/cetjmGvPi3BSBvw3J06eLBCk0Q+s75dd6kc5hpRtJ4czLAiMaND9lo
         diLD2UgCjxO4qgzIfX5jtL6sFGNGpYzfp+rmpS+jAzh0HjEUCYyLA55pRW5VTOmJtIww
         28iAdgqkNAqBhLFeVh+lfbCVX0Ye3CzDBEG+bwYF49o49/00yfnDtlJDC0rtc7MFiQ9j
         PIvQ==
X-Gm-Message-State: AGi0PuYKDo6bKBhxSR9N+dB7zQRJUXlu3p/dM2jbfy5ZLlOVf8TLJMj7
        vmb5jSocR4hcgFrvjcwm2e8ozw==
X-Google-Smtp-Source: APiQypLVvi+Bp9Vcj2EZuKj4RL6kT3nDbXIZhn3/hZqczJTU9pHhYbcjYTgRY/zA6TvfD6PzDmcX/w==
X-Received: by 2002:a7b:c5d3:: with SMTP id n19mr7929862wmk.21.1588928779186;
        Fri, 08 May 2020 02:06:19 -0700 (PDT)
Received: from [192.168.1.149] (ip-5-186-116-45.cgn.fibianet.dk. [5.186.116.45])
        by smtp.gmail.com with ESMTPSA id c19sm1981766wrb.89.2020.05.08.02.06.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 May 2020 02:06:18 -0700 (PDT)
Subject: Re: [PATCH] sched/fair: Return true,false in
 voluntary_active_balance()
To:     Peter Zijlstra <peterz@infradead.org>,
        Jason Yan <yanaijie@huawei.com>
Cc:     mingo@redhat.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        linux-kernel@vger.kernel.org, Julia.Lawall@lip6.fr
References: <20200507110625.37254-1-yanaijie@huawei.com>
 <20200508081629.GN5298@hirez.programming.kicks-ass.net>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
Message-ID: <005a3e5c-9362-dc63-4bf0-7ffdb1b2949d@rasmusvillemoes.dk>
Date:   Fri, 8 May 2020 11:06:17 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200508081629.GN5298@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/05/2020 10.16, Peter Zijlstra wrote:
> On Thu, May 07, 2020 at 07:06:25PM +0800, Jason Yan wrote:
>> Fix the following coccicheck warning:
>>
>> kernel/sched/fair.c:9375:9-10: WARNING: return of 0/1 in function
>> 'voluntary_active_balance' with return type bool
> 
> That's not a warning, that's a broken cocinelle script, which if these
> stupid patches don't stop, I'm going to delete myself!


I was wondering why I got cc'ed here. Then it dawned on me. What can I
say, I was young.

Ack on nuking it.

Rasmus

