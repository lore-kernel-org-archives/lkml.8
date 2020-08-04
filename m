Return-Path: <SRS0=pusq=BO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32FDBC433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 06:11:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3B9762076E
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 06:11:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="GxbN4MBW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729313AbgHDGLw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Aug 2020 02:11:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728602AbgHDGLv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Aug 2020 02:11:51 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C03EFC06174A
        for <linux-kernel@vger.kernel.org>; Mon,  3 Aug 2020 23:11:50 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id 185so32012319ljj.7
        for <linux-kernel@vger.kernel.org>; Mon, 03 Aug 2020 23:11:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=YATFUmsQEtwZnfgWdl5UeyWgtQO3fVAktQVuTkdNN84=;
        b=GxbN4MBWT2QnFQZOx0XJ9UA0oemVZKu8DVMcXSsOQTdcD5FgLP+FKSLs1NUfxgZ1ym
         13SSwtjix3edIdHB/LzKs3oQPpp39yjbZz0rI2IhiLddmW+F8UNZh+wk+XgOcUFSgWpL
         KgS9WEfdPGYlDqwPVcA8ZupXspDOsB04Qv0+k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=YATFUmsQEtwZnfgWdl5UeyWgtQO3fVAktQVuTkdNN84=;
        b=cinXE3IDduiGQKqIghFxmSwhY8E5ekPL0UDuZRcV7b9/NzixxI0NGKYOpgkUcLJFK7
         VMpfUuwZ9hk9I2EMorS9m+s8p8eZWvImV2RzELSN97uOx1demOTl3YENuaMdrvq8TYyT
         NTiKwut/dl3WlAMPUUoZiKOS6wq2G0UUr4LvmvqmebdKl0RfLG++rhABaGip1tlRBLli
         qWOjlJHkI4zkkAagImlJSy8jp4H+gmS/JTJl8nGGDpQZY2wY333H7InjMXV3gOGI8DKC
         fcdGQSMUxGA1rxXv2QNQJq2FpeQX15An6pTrtHSqodJ/SKi5E7QO7HnltyPNKTwCOCaj
         /TmQ==
X-Gm-Message-State: AOAM533Nhl6oopfwRQQqPZjSWjd6Uq9731/m1I/DWCG+K2Q3WC/Hyanx
        axVkMnOjLAkw2F6v75zpBOH/fg==
X-Google-Smtp-Source: ABdhPJw9B+y91jBYvJrq3JdL+1NJK33QAr8Ejd8dI1ooDFvkOCojii4KB0OKr7Er4VMWcj3Xw/uijg==
X-Received: by 2002:a2e:93cd:: with SMTP id p13mr7914891ljh.460.1596521509227;
        Mon, 03 Aug 2020 23:11:49 -0700 (PDT)
Received: from [172.16.11.153] ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id l26sm2044101ljc.133.2020.08.03.23.11.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Aug 2020 23:11:46 -0700 (PDT)
Subject: Re: [RFC] saturate check_*_overflow() output?
To:     Kees Cook <keescook@chromium.org>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        linux-kernel@vger.kernel.org, kernel-hardening@lists.openwall.com
References: <202008031118.36756FAD04@keescook>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
Message-ID: <f177a821-74a3-e868-81d3-55accfb5b161@rasmusvillemoes.dk>
Date:   Tue, 4 Aug 2020 08:11:45 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <202008031118.36756FAD04@keescook>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/08/2020 20.29, Kees Cook wrote:
> Hi,
> 
> I wonder if we should explicitly saturate the output of the overflow
> helpers as a side-effect of overflow detection? 

Please no.

(That way the output
> is never available with a "bad" value, if the caller fails to check the
> result or forgets that *d was written...) since right now, *d will hold
> the wrapped value.

Exactly. I designed the fallback ones so they would have the same
semantics as when using gcc's __builtin_* - though with the "all
operands have same type" restriction, since it would be completely
unwieldy to handle stuff like (s8) + (u64) -> (s32) in macros.

> Also, if we enable arithmetic overflow detection sanitizers, we're going
> to trip over the fallback implementation (since it'll wrap and then do
> the overflow test in the macro).

Huh? The fallback code only ever uses unsigned arithmetic, precisely to
avoid triggering such warnings. Or are you saying there are some
sanitizers out there which also warn for, say, (~0u) + 1u? Yes,
detecting overflow/underflow for a (s32)-(s32)->(s32) without relying on
-fwrapv is a bit messy, but it's done and AFAIK works just fine even
with UBSAN enabled.


What we might do, to deal with the "caller fails to check the result",
is to add a

static inline bool __must_check must_check_overflow(bool b) { return
unlikely(b); }

and wrap all the final "did it overflow" results in that one - perhaps
also for the __builtin_* cases, I don't know if those are automatically
equipped with that attribute. [I also don't know if gcc propagates
likely/unlikely out to the caller, but it shouldn't hurt to have it
there and might improve code gen if it does.]

Rasmus

PS: Another reason not to saturate is that there are two extreme values,
and choosing between them makes the code very messy (especially when
using the __builtins). 5u-10u should saturate to 0u, not UINT_MAX, and
even for for underflowing a signed computation like INT_MIN + (-7); it
makes no sense for that to saturate to INT_MAX.
