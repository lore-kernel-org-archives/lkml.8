Return-Path: <SRS0=vQOp=CM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42DE6C43461
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 22:03:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0E80F20678
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 22:03:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KSOF4MSb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729234AbgICWDv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Sep 2020 18:03:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726891AbgICWDo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Sep 2020 18:03:44 -0400
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBE81C061244
        for <linux-kernel@vger.kernel.org>; Thu,  3 Sep 2020 15:03:43 -0700 (PDT)
Received: by mail-ed1-x542.google.com with SMTP id g4so4237592edk.0
        for <linux-kernel@vger.kernel.org>; Thu, 03 Sep 2020 15:03:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qVIO+W41RwcDMaSobjfrJM37v+XlNEpsXghdOpMJtkI=;
        b=KSOF4MSbX4S87IQK+in03uGEn+ytQl9cZGyW6vDNozCbdjEAgInLMiYQKelxpagMl5
         df9b/zV8SpGeA2iaUig0Q+MwFtCPZ28+WIKxq9eXlq/Wqd7GExFDfcGlLp8y1mAoy6te
         zS6jijDRaye7xBQSACfoereqL7Lz3JDY21FkaYI+Fw7k67Kt0rdnapLXNgJhXsHyhm7Y
         hlEeZ4lRpKgWRNSwYIyS0ZNPVsv/wZ3NStKIflMJS4q4+n12JbEG9GPG0Q5FVCgUqH5k
         1+abDI3c1WFNhWHsCv2v/A8XJ1YBYFMlewBw3NbKj1gZ1Og8okZuumffy5glY7Vb2XSt
         +iTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qVIO+W41RwcDMaSobjfrJM37v+XlNEpsXghdOpMJtkI=;
        b=oEYmFmBicryonyrIvRQS9r93QwBAiKVD/uiagyLlmMtpjnYh7oteM1sNHhJx4aY5LB
         m6GQU+7hYnNm79ra5SFVKJZtAK1LeTJzS2uzigPC8+j6jJ6ICmsl1ti6BLnZ0Ff0KGXi
         nlM8QxHNZAKFrq0QW+OYsObL3Sx7WewUo1jQDneGeFpEHQs57Jz+AW/WnYbDsn2t8bDt
         JhJ9+9NhJfOHI2J8pGxXsPTaPXWoz3oay8ZKI3wN7fMbj/XRr67XLjtA7/V+3xVmnbBJ
         +/xKoPQs9kOOofZxQFbmmaD+VSHxdBI1XVr4eM8xqt45lAFGl8lEkLIH7FCYNJqdWfgW
         nKYg==
X-Gm-Message-State: AOAM531ft7/JSuAHCYMKWd2ft4+i7X9EFsTuqdwLVXaqfdghfvxQSohh
        lZpFe4PDf9RAlMDfSSJ6ohnIeedGznxulyFXx2o29A==
X-Google-Smtp-Source: ABdhPJz8wZUegnpJXZZBut1xff7mQk50TpWZj/RnJoIZEh3bEYGVn9VJa+mmP5IBGCFzg96FVhHvLJwNs9ID1NpA3wM=
X-Received: by 2002:a50:e004:: with SMTP id e4mr5429575edl.114.1599170621796;
 Thu, 03 Sep 2020 15:03:41 -0700 (PDT)
MIME-Version: 1.0
References: <20200624203200.78870-1-samitolvanen@google.com>
 <20200903203053.3411268-1-samitolvanen@google.com> <20200903203053.3411268-6-samitolvanen@google.com>
 <202009031450.31C71DB@keescook>
In-Reply-To: <202009031450.31C71DB@keescook>
From:   Sami Tolvanen <samitolvanen@google.com>
Date:   Thu, 3 Sep 2020 15:03:30 -0700
Message-ID: <CABCJKueF1RbpOKHsA8yS_yMujzHi8dzAVz8APwpMJyMTTGhmDA@mail.gmail.com>
Subject: Re: [PATCH v2 05/28] objtool: Add a pass for generating __mcount_loc
To:     Kees Cook <keescook@chromium.org>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        linux-arch <linux-arch@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kbuild <linux-kbuild@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, linux-pci@vger.kernel.org,
        X86 ML <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 3, 2020 at 2:51 PM Kees Cook <keescook@chromium.org> wrote:
>
> On Thu, Sep 03, 2020 at 01:30:30PM -0700, Sami Tolvanen wrote:
> > From: Peter Zijlstra <peterz@infradead.org>
> >
> > Add the --mcount option for generating __mcount_loc sections
> > needed for dynamic ftrace. Using this pass requires the kernel to
> > be compiled with -mfentry and CC_USING_NOP_MCOUNT to be defined
> > in Makefile.
> >
> > Link: https://lore.kernel.org/lkml/20200625200235.GQ4781@hirez.programming.kicks-ass.net/
> > Signed-off-by: Peter Zijlstra <peterz@infradead.org>
>
> Hmm, I'm not sure why this hasn't gotten picked up yet. Is this expected
> to go through -tip or something else?

Note that I picked up this patch from Peter's original email, to which
I included a link in the commit message, but it wasn't officially
submitted as a patch. However, the previous discussion seems to have
died, so I included the patch in this series, as it cleanly solves the
problem of whitelisting non-call references to __fentry__. I was
hoping for Peter and Steven to comment on how they prefer to proceed
here.

Sami
