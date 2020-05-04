Return-Path: <SRS0=VwT+=6S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DFD7C3A5A9
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 07:20:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E322F20721
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 07:20:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="dBDouQ+k"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727977AbgEDHUH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 May 2020 03:20:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726515AbgEDHUH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 May 2020 03:20:07 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13C3BC061A0E
        for <linux-kernel@vger.kernel.org>; Mon,  4 May 2020 00:20:07 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id x17so19592801wrt.5
        for <linux-kernel@vger.kernel.org>; Mon, 04 May 2020 00:20:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=r5Eb2cb9CEtLZKCdXljzvPF0qrOQKbRCYhU5bBtwDRw=;
        b=dBDouQ+kI5lBhrPP0D6YZIyCNozA5sE1edwVigm58hy5SMk/HKMeNNvhJ1NUXnBmmn
         l909no4r78lShUfHPPW4l8WwAIqvD9usGlf/fUdzMfZBLE9hpyjJ1K0XnRa34oIOT7WC
         AK52giKBjQGYC1WliGR4pgxHI5SWKUW4iGV4Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=r5Eb2cb9CEtLZKCdXljzvPF0qrOQKbRCYhU5bBtwDRw=;
        b=QIiZTuW20JPb1wdIXUHR6pqqZ4Zedb6Ibf5glFWIIvtb/+3jthWN6zJASNUAotBV7P
         7nZqVSKa9efEGtuQ/t8L/mvM/aLyE33PgDGN6xbcnNBjSiKflzTNlk2uGLalFeNdpANa
         /7Pu9HdqJ5BTqXesZyFal1caYKYuTnvq5wqK7++RjWnaGmV7Wiuj5kYN/OELwX1pGPaR
         6LP8PAGozT4Q9PvwQrYIaEaQo1jhak7Zc75Uocshy4BB32nQXhqtn2zt0WZlJX+7BIHK
         ZQa8X1cZ2427YxPWKXPq+3W/hthfshsw3Sz+VxXHN6Mnoxp3PFK1ku1tCqI+dydChXsE
         RxOw==
X-Gm-Message-State: AGi0PuYLM9nicojoIciByS/YAMEHcrGhMyHDsIJTzM52vj/tAlI3nCqr
        DrooTVLk4RHfgZhjEKlLWemozg==
X-Google-Smtp-Source: APiQypLqvplkESHstF8neGqeECT1JIoalNhHnF7IDhYb6hQYVQ6i01QktZrA3/DpDJKvyBZhjm1dIg==
X-Received: by 2002:adf:d4d0:: with SMTP id w16mr17658165wrk.264.1588576805813;
        Mon, 04 May 2020 00:20:05 -0700 (PDT)
Received: from [192.168.1.149] (ip-5-186-116-45.cgn.fibianet.dk. [5.186.116.45])
        by smtp.gmail.com with ESMTPSA id l6sm17714393wrb.75.2020.05.04.00.20.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 May 2020 00:20:05 -0700 (PDT)
Subject: Re: [PATCH v4 14/18] static_call: Add static_cond_call()
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, rostedt@goodmis.org,
        mhiramat@kernel.org, bristot@redhat.com, jbaron@akamai.com,
        torvalds@linux-foundation.org, tglx@linutronix.de,
        mingo@kernel.org, namit@vmware.com, hpa@zytor.com, luto@kernel.org,
        ard.biesheuvel@linaro.org, jpoimboe@redhat.com,
        pbonzini@redhat.com, mathieu.desnoyers@efficios.com
References: <20200501202849.647891881@infradead.org>
 <20200501202944.593400184@infradead.org>
 <1238787e-d97d-f09b-d76d-2df2dc273f4b@rasmusvillemoes.dk>
 <20200503125813.GL3762@hirez.programming.kicks-ass.net>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
Message-ID: <a53369f3-665a-af0e-efad-09ae456af847@rasmusvillemoes.dk>
Date:   Mon, 4 May 2020 09:20:03 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200503125813.GL3762@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/05/2020 14.58, Peter Zijlstra wrote:
> On Sat, May 02, 2020 at 03:08:00PM +0200, Rasmus Villemoes wrote:
>> On 01/05/2020 22.29, Peter Zijlstra wrote:

>>> +#define static_cond_call(name)						\
>>> +	if (STATIC_CALL_KEY(name).func)					\
>>> +		((typeof(STATIC_CALL_TRAMP(name))*)(STATIC_CALL_KEY(name).func))
>>> +
>>
>> This addresses neither the READ_ONCE issue nor the fact that,
>> AFAICT, the semantics of
>>
>>   static_cond_call(foo)(i++)
>>
>> will depend on CONFIG_HAVE_STATIC_CALL.
> 
> True.
> 
> So there is something utterly terrible we can do to address both:
> 
> void __static_call_nop(void)
> {
> }
> 
> #define __static_cond_call(name) \
> ({ \
> 	void *func = READ_ONCE(STATIC_CALL_KEY(name).func); \
> 	if (!func) \
> 		func = &__static_call_nop; \
> 	(typeof(STATIC_CALL_TRAMP(name))*)func; \
> })
> 
> #define static_cond_call(name) (void)__static_cond_call(name)
> 
> This gets us into Undefined Behaviour territory, but it ought to work.
> 
> It adds the READ_ONCE(), and it cures the argument evaluation issue.

Indeed, that is horrible. And it "fixes" the argument evaluation by
changing the !HAVE_STATIC_CALL case to match the HAVE_STATIC_CALL, not
the other way around, which means that it is not a direct equivalent to the

  if (foo)
     foo(a, b, c)

[which pattern of course has the READ_ONCE issue, but each individual
existing site with that may be ok for various reasons].

Is gcc smart enough to change the if (!func) to a jump across the
function call (but still evaluting side effects in args), or is
__static_call_nop actually emitted and called? If the latter, then one
might as well patch the write-side to do "WRITE_ONCE(foo, func ? :
__static_call_nop)" and elide the test from __static_cond_call() - in
fact, that just becomes a single READ_ONCE. [There's probably some
annoying issue with making sure static initialization of foo points at
__static_call_nop].

And that brings me to the other issue I raised - do you have a few
examples of call sites that could use this, so we can see disassembly
before/after? I'm still concerned that, even if there are no
side-effects in the arguments, you still force the compiler to
spill/shuffle registers for call/restore unconditionally, whereas with a
good'ol if(), all that work is guarded by the load+test.

Rasmus
