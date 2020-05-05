Return-Path: <SRS0=e3tL=6T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 482E5C47247
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 07:50:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1F9FA20721
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 07:50:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="AfFlJyDH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728402AbgEEHub (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 May 2020 03:50:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725320AbgEEHua (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 May 2020 03:50:30 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73DC3C061A0F
        for <linux-kernel@vger.kernel.org>; Tue,  5 May 2020 00:50:30 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id j5so705411wrq.2
        for <linux-kernel@vger.kernel.org>; Tue, 05 May 2020 00:50:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=MSMf6NiPVJnfJUkRuy1vWS4FDE59P/dUzj8a3c84Uy0=;
        b=AfFlJyDHY0paFWCrZ8xD58DgWRkVthJOn81gxjoEuzWs7GciAKwq+4bML/GzGrichu
         61GfVAOt8HHRRt0cvSzty0QjWPKMaZXthuszlQ2ZhmM4J+iHVNzJfC7bixlC5yt8DVa0
         babf1bwoiGGBrB84Xe303mLvmbHkM/YWEc1jw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=MSMf6NiPVJnfJUkRuy1vWS4FDE59P/dUzj8a3c84Uy0=;
        b=pTEkqs3lUgTLPDFYCI8nwZULfpzqBXN6LKEEApfro5kk73vRsWu1zp79tZjDSylzaz
         jRLjVn+aDqA7HDtrjpxLeuvOh8ZLwzTdcPa3oTWZsDberunr8cRllN8FwL1pZ7PR7KO9
         m3Xdc2u/buymqJdrvqoPjkQ8c65Vdyvw+171iAYV8AoBnw9MTGxTbN5fTg/BGvGxoDe8
         0m+CPp6QJ8k3KBy7fmReqNforFOb4ZehBAkZnlEGQVLDuATx5BO5xsL3Aw3ouE8DcGSc
         XQlS260mtV6WkeCpkitsKamxboYcTcZ1AnS0trWLMkiw7oSo/PWNWX/+fi5J2pXXwI4c
         5cvA==
X-Gm-Message-State: AGi0Pua4d8BbXew51mitUV9+zPmM0yQcI48NaFB013MWJLRTiYfLcpxK
        CKLb4V41Duh2O1TyvbAwssHd1Q==
X-Google-Smtp-Source: APiQypJTM8quZSuTyhLXS9x2vuM40w03b/aC6rKa7CNq1YCilAX+AJ+wko84ndoM+KGU/y1l5CjN0A==
X-Received: by 2002:adf:a2d7:: with SMTP id t23mr2116540wra.402.1588665029135;
        Tue, 05 May 2020 00:50:29 -0700 (PDT)
Received: from [192.168.1.149] (ip-5-186-116-45.cgn.fibianet.dk. [5.186.116.45])
        by smtp.gmail.com with ESMTPSA id x16sm1772440wrn.76.2020.05.05.00.50.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 May 2020 00:50:28 -0700 (PDT)
Subject: Re: [PATCH v4 14/18] static_call: Add static_cond_call()
To:     Peter Zijlstra <peterz@infradead.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
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
 <a53369f3-665a-af0e-efad-09ae456af847@rasmusvillemoes.dk>
 <20200504201445.GQ3762@hirez.programming.kicks-ass.net>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
Message-ID: <6cb31c72-ce0e-7923-daca-ce5ef414940b@rasmusvillemoes.dk>
Date:   Tue, 5 May 2020 09:50:26 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200504201445.GQ3762@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/05/2020 22.14, Peter Zijlstra wrote:
> On Mon, May 04, 2020 at 09:20:03AM +0200, Rasmus Villemoes wrote:
> 
>>
>> Indeed, that is horrible. And it "fixes" the argument evaluation by
>> changing the !HAVE_STATIC_CALL case to match the HAVE_STATIC_CALL, not
>> the other way around,
> 
> Correct; making it the other way is far more 'interesting'. It would
> basically mean combining the static_branch and static_call, but that
> would also make it less optimal for simple forwarding cases.

Yes, I can see how implementing that would be quite hard.

>> which means that it is not a direct equivalent to the
>>
>>   if (foo)
>>      foo(a, b, c)
>>
>> [which pattern of course has the READ_ONCE issue, but each individual
>> existing site with that may be ok for various reasons].
>>
>> Is gcc smart enough to change the if (!func) to a jump across the
>> function call (but still evaluting side effects in args), or is
>> __static_call_nop actually emitted and called?
> 
> I was hoping it would be clever, but I just tried (find below) and it is
> not -- although there's always hoping a newer version / clang might be
> smarter.
> 
> It does indeed emit the nop function :/

Hm.

>> If the latter, then one
>> might as well patch the write-side to do "WRITE_ONCE(foo, func ? :
>> __static_call_nop)" and elide the test from __static_cond_call() - in
>> fact, that just becomes a single READ_ONCE. [There's probably some
>> annoying issue with making sure static initialization of foo points at
>> __static_call_nop].
> 
> But that would not give a more clever compiler the ability to do the
> 'right' thing here..

True. However, I think it's unlikely we'll see a compiler being that
clever anytime soon.

Anyway, it's hard to judge what version of the !HAVE_STATIC_CALL
implementation is best when there's no !HAVE_STATIC_CALL use cases to
look at. I just want to ensure that whatever limitations or gotchas
(e.g., "arguments are evaluated regardless of NULLness of func", or
alternatively "arguments must not have side effects") it ends up with
get documented.

> 
> #define __static_cond_call(name) \
> ({ \
> 	void *func = READ_ONCE(name.func); \
> 	if (!func) \
> 		func = &__static_call_nop; \
> 	(typeof(__SCT__##name)*)func; \
> })

I think you can just make it

#define __static_cond_call(name) \
( \
(typeof(__SCT__##name)*) ((void *)name.func ? : (void *)__static_call_nop) \
)

but that simplification is not enough to make gcc change its mind about
how to compile it :( But I'm guessing that various sanitizers or static
checkers might complain about the UB.

Rasmus
