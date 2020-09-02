Return-Path: <SRS0=728o=CL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C84BC433E2
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 14:02:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2C2A22078E
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 14:02:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="u/ECkouu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727825AbgIBOCL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Sep 2020 10:02:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727788AbgIBNsd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Sep 2020 09:48:33 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42C13C061249
        for <linux-kernel@vger.kernel.org>; Wed,  2 Sep 2020 06:48:33 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id v196so2199794pfc.1
        for <linux-kernel@vger.kernel.org>; Wed, 02 Sep 2020 06:48:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=xd7AHzDtIyZlpZS0jrqbDaapoC0gS56v5nmmsQBYFnw=;
        b=u/ECkouufZaO6tvNEBl6baa+lzjzWhQhAWe3jkf/n5qq2ul5Uk6xj9NWCnEJ5JOdqF
         N+tJhIvTzeKtRTyRgOlxX+AmLFT2d7woNVz0h6U2NLQjgwK6yYQ6WkURTRKrxihF3frC
         eP/XrkbRviguHHheSC0UrfkUNjsqxtWwKfdT4Rbhdy/M9bEE4xTc/lA9FEbc5toqRPBb
         IraH/rsuaqeVRSttSV48VX+/4Pq+euQryIXJfOKJVTBMHJPGgc4LVtiO8CIgb3GA9A3A
         mZJTAUiUNSpcJ36AxN4xZrW8+Z95nVd41wk8h1tQ9VxQs3vqQk7ffKPeSOV4eqBGMuOd
         jvJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=xd7AHzDtIyZlpZS0jrqbDaapoC0gS56v5nmmsQBYFnw=;
        b=iUHwavN5qBXmr6y9kZTUVQts4SUnPnPuy3VNt+vwyndXRtZCPKo53p52pxYYMbWAms
         LLsZj2WL/D/d3ZIuesqD7gRmXujznoIzO/FSNBH9AnQYweTAORVzPIPefP7b3lgwH+CB
         NOYofATbGfdeSXQKBfT9XgDNn1w/hB0AHSL4Ul3vHxU9QqbGUIHKcgDJzOgIRyFMN5yH
         llkDjz4678vbR7NjQ7mL0RcILrL58JHfqFoFHdYLdrBIgg67WPkVJC2zrXLyT9yKwcvL
         tV3xgL4RIMrT58hvb7pkolwumI/1Uz99aD7tCyKmV4k5ZPP9Zc8Hz3PG8M8ShvwhHwrL
         OyZQ==
X-Gm-Message-State: AOAM531jwvhVcWEXikPSn7RCK6zouYLJqKrJRtDrRuUL8YUiueTneU5Y
        houbU68V1kMqY4ESRQJXgZQ=
X-Google-Smtp-Source: ABdhPJx9UfrcD7tmpH8QWvQqmC/Xr04CHBNYUEdwQj/owEIGpYcT7SAlbb8Da3e5UbOHJVmFD6rBDQ==
X-Received: by 2002:a63:174d:: with SMTP id 13mr1966537pgx.231.1599054512132;
        Wed, 02 Sep 2020 06:48:32 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id m19sm4628836pjq.18.2020.09.02.06.48.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Sep 2020 06:48:31 -0700 (PDT)
Subject: Re: [PATCH v2 10/11] lockdep: Only trace IRQ edges
To:     peterz@infradead.org
Cc:     linux-kernel@vger.kernel.org, mingo@kernel.org, will@kernel.org,
        npiggin@gmail.com, elver@google.com, jgross@suse.com,
        paulmck@kernel.org, rostedt@goodmis.org, rjw@rjwysocki.net,
        joel@joelfernandes.org, svens@linux.ibm.com, tglx@linutronix.de,
        davem@davemloft.net
References: <20200821084738.508092956@infradead.org>
 <20200821085348.723775490@infradead.org>
 <20200902042137.GA163925@roeck-us.net>
 <20200902090935.GW1362448@hirez.programming.kicks-ass.net>
 <20200902091247.GX35926@hirez.programming.kicks-ass.net>
From:   Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
Message-ID: <559ff09a-275b-21bf-15f1-daa0d02d1c76@roeck-us.net>
Date:   Wed, 2 Sep 2020 06:48:30 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200902091247.GX35926@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/2/20 2:12 AM, peterz@infradead.org wrote:
> On Wed, Sep 02, 2020 at 11:09:35AM +0200, peterz@infradead.org wrote:
>> On Tue, Sep 01, 2020 at 09:21:37PM -0700, Guenter Roeck wrote:
>>> [    0.000000] WARNING: CPU: 0 PID: 0 at kernel/locking/lockdep.c:4875 check_flags.part.39+0x280/0x2a0
>>> [    0.000000] DEBUG_LOCKS_WARN_ON(lockdep_hardirqs_enabled())
>>
>>> [    0.000000] [<00000000004cff18>] lock_acquire+0x218/0x4e0
>>> [    0.000000] [<0000000000d740c8>] _raw_spin_lock+0x28/0x40
>>> [    0.000000] [<00000000009870f4>] p1275_cmd_direct+0x14/0x60
>>
>> Lol! yes, I can see that going side-ways... let me poke at that.
> 
> I suspect this will do.
> 
> diff --git a/arch/sparc/prom/p1275.c b/arch/sparc/prom/p1275.c
> index 889aa602f8d8..7cfe88e30b52 100644
> --- a/arch/sparc/prom/p1275.c
> +++ b/arch/sparc/prom/p1275.c
> @@ -38,7 +38,7 @@ void p1275_cmd_direct(unsigned long *args)
>  	unsigned long flags;
> 
>  	local_save_flags(flags);
> -	local_irq_restore((unsigned long)PIL_NMI);
> +	arch_local_irq_restore((unsigned long)PIL_NMI);
>  	raw_spin_lock(&prom_entry_lock);
> 
>  	prom_world(1);
> 
No, that doesn't help. Even removing that line entirely doesn't help.
The problem seems to be that interrupts are not enabled in the first
place. But why wasn't this a problem before ?

Guenter
