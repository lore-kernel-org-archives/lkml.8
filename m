Return-Path: <SRS0=e3tL=6T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1EDBC47254
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 19:57:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A6FAA20752
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 19:57:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="D/CUUgV+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729051AbgEET5v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 May 2020 15:57:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726350AbgEET5v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 May 2020 15:57:51 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21E43C061A0F
        for <linux-kernel@vger.kernel.org>; Tue,  5 May 2020 12:57:51 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id f8so1288136plt.2
        for <linux-kernel@vger.kernel.org>; Tue, 05 May 2020 12:57:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+jBR7bx06JBk3b0Box7GE19GyYRN4IAfI1SXCDy+ZVs=;
        b=D/CUUgV+4QUr72gT1aXLHHu9Kd+oRs7SqSXsIFWGpsYW1trbgyX4otdQnlkn9W+m3W
         tsGjCncvtWcszh2yfgrMJDHI2YKZmFxGcpugbH5Pyu/d0ptqy6Cnpukh0MQ3R76D2uo6
         NzIZKFfRgoO1tLM4+aOrznPaVGQ6tiYi45YCKbVAYZglUp2ucfTfAZNWtKcJLnXCczhD
         y2+7zjuLHjqZUiqfCa89nny8eSv12f5/SOAj4to3t0oJGE7IBcnwRzYHp8DnbaEOG5Og
         26VKkB2hLRfi0Wg05uhTUGg9ySNaKgr8KQHH4/h8Pw60Ci07YicM4FMNcayt4hK6hsyl
         32EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+jBR7bx06JBk3b0Box7GE19GyYRN4IAfI1SXCDy+ZVs=;
        b=W7C17LN0eyu8/ZR49x/sVNGKoHbsk7qgbDAfZfC3HppJKflbMQ1fcyFyNk6yWq0zRy
         X8INxt6uR7YadiLQrk5u1qJHI9ZGTALQHLaIN4vTvO4j26mD6+VY6hdc6s9T7zepr7pl
         kozk42p4SuKrC5LS9EVgxRkiFhnMYMxrswX4SrXqmFaz/2bctaMwlgw6Rve121Uk09gH
         ReR0eFqErLH2tB4sYOVOjGJ/c14IH0NhvlMuBaHNLeKdZdxAKohPhc+IzTE2mJGexwmk
         v5WN390ZKivwbf21JV6QgMpGXph3kKx3a++X3ukEZde2CFOlTRUSE1eFVo6bpHRsNbHJ
         Lyzg==
X-Gm-Message-State: AGi0Pua+430ZdC+WYkTqIpTkP7vumFYDyrxaorCKFGqrymYkpAlbCEqK
        j6fUclfAG8eBuYUT22Rs8YqrjKKbbJTcliFRH+h4nbTByxw=
X-Google-Smtp-Source: APiQypLSG+qS3SzQAnHi3qMXZk1rnABm6T4db+mHV8vCmFHO1+gIBvWnBRFmcRuqOif4K1BHGOvNCYp2DEcoxBgOtKs=
X-Received: by 2002:a17:902:eb54:: with SMTP id i20mr2500038pli.179.1588708670198;
 Tue, 05 May 2020 12:57:50 -0700 (PDT)
MIME-Version: 1.0
References: <20200501202849.647891881@infradead.org> <20200503125813.GL3762@hirez.programming.kicks-ass.net>
 <a53369f3-665a-af0e-efad-09ae456af847@rasmusvillemoes.dk> <20200504201445.GQ3762@hirez.programming.kicks-ass.net>
 <20200505093625.GE5298@hirez.programming.kicks-ass.net> <CAKwvOd=cP8UCX0+5pZ3AqzvOM8LKzLJJ_heDhrghqJdOnHoGMg@mail.gmail.com>
 <CAKwvOdkL+2Gvn2mkZ8cdHN=1F5cHQHii57ocD0RFeLJxEt=TUQ@mail.gmail.com>
 <CAHk-=wiUd=fcpegFLK4VK9iFfrO5BmpGKDszGpuyJkDdz4JaoQ@mail.gmail.com> <656098739.766.1588705237442.JavaMail.zimbra@efficios.com>
In-Reply-To: <656098739.766.1588705237442.JavaMail.zimbra@efficios.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 5 May 2020 12:57:39 -0700
Message-ID: <CAKwvOdnLze0e3Vwmb1Xdqwcwe9h6gnAwGnt3ksiNX7ENb_3Y9w@mail.gmail.com>
Subject: Re: [PATCH v4 14/18] static_call: Add static_cond_call()
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        x86 <x86@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        bristot <bristot@redhat.com>, jbaron <jbaron@akamai.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, Nadav Amit <namit@vmware.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Andy Lutomirski <luto@kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        "H.J. Lu" <hjl.tools@gmail.com>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 5, 2020 at 12:00 PM Mathieu Desnoyers
<mathieu.desnoyers@efficios.com> wrote:
>
> ----- On May 5, 2020, at 2:48 PM, Linus Torvalds torvalds@linux-foundation.org wrote:
> [...]
> >
> > Your initial reaction that "you can't compile away the read and the
> > test of NULL" was correct, I think.
>
> I suspect this pattern of "if (func != NULL) func(...)" could be semantically
> changed to just invoking an empty function which effectively does nothing.
> This would remove the need to do a pointer check in the first place. But maybe
> I'm missing something subtle about why it has not been done in this context.

Good idea, this eliminates the check: https://godbolt.org/z/Xugo9w
but you still have an indirect tail call (I think a direct tail call
is the desired solution?)
-- 
Thanks,
~Nick Desaulniers
