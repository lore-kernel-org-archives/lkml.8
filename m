Return-Path: <SRS0=PfNx=4F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E80FEC34021
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 17:06:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC27B2064C
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 17:06:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="ffd4dHge"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728864AbgBQRGR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Feb 2020 12:06:17 -0500
Received: from mail-qv1-f68.google.com ([209.85.219.68]:41538 "EHLO
        mail-qv1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728142AbgBQRGR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Feb 2020 12:06:17 -0500
Received: by mail-qv1-f68.google.com with SMTP id s7so7871283qvn.8
        for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2020 09:06:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=L6P6i8QYBtrRLDhCjXcjIS4jJjXwildK8xh5dBjAjQw=;
        b=ffd4dHgeWvjZb9BGBU9kgw11/3oJ0Mb9QQlnBBDkZ0u0hR3L4PTyZ8LoixLO2Cj8YV
         O6mOO3+4CYI/akamAVpZ6f7V2T6GExd5S3TaZdPNnbyi0tsVKVQvKrJ+TpldSIENEfDo
         0afoQemXutfzDYbSevb4++hQ5x7Ij3dymdcxDToVUByCIdgF1/CXJdzjSVcVnHOL6J1Y
         e3C0sM0JZVXMBO3wgaJRIa1NtqhVrFT0zZ18Jy4y9Rj2wYfbjD8m7MEleGq6fuAX93lq
         JGqHg0KMMDLuMt1GCcQch6LooyUXn42ryvkpkQZQdgzllWwFYKIDpm7PyMA93hl2ib82
         OgPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=L6P6i8QYBtrRLDhCjXcjIS4jJjXwildK8xh5dBjAjQw=;
        b=Gh90TynAN7G+UkZYPGH/Mj/jB2jvv2MnISOtTi5nEmvG+xMQlGS8DKVqkQBKWxVnwM
         oFd5mKCnTdTSRKJCd4tnT2LclludgyBLZ2Ssq+crQb4hTeeJc8MGQUZkMVr5uFa1mka6
         xUgknFSwgjOKQlkODewJPRplLuAyBaOGkO7hxyuWll0D1eeMbcbWeJhxwbu440pxlSFB
         vmZSDo+7cMF4KKBOzkMsvqbZkxzL8nge7POOg61nZC5lEQd2maNe/KKc4kASbIFe6r8G
         o7yyuZju+5SNbrZYQb9gpTBLDXXisSdeHrUFkQSnh7rRc1eUR2pD5RW0bH4N7XIUCzpI
         9xBw==
X-Gm-Message-State: APjAAAWRkA6Aber50UC5VazgcBJEN5+Gmd0rZlnFVcdVDqoSx73Ah41j
        Vqw/SYE6weeRksqckLGvfq4OtQ==
X-Google-Smtp-Source: APXvYqyZvAkpULNjhb7N4xBJhjDjqP94Var1PtGA02WO4jZRgwD6CiTqtR1UVOIKnHCOGOZlIBqvVA==
X-Received: by 2002:a05:6214:707:: with SMTP id b7mr13001067qvz.97.1581959176043;
        Mon, 17 Feb 2020 09:06:16 -0800 (PST)
Received: from dhcp-41-57.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id w202sm514179qkb.89.2020.02.17.09.06.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 17 Feb 2020 09:06:15 -0800 (PST)
Message-ID: <1581959174.7365.88.camel@lca.pw>
Subject: Re: [PATCH v2] kcsan, trace: Make KCSAN compatible with tracing
From:   Qian Cai <cai@lca.pw>
To:     paulmck@kernel.org, Marco Elver <elver@google.com>
Cc:     andreyknvl@google.com, glider@google.com, dvyukov@google.com,
        kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org,
        rostedt@goodmis.org, mingo@redhat.com, x86@kernel.org
Date:   Mon, 17 Feb 2020 12:06:14 -0500
In-Reply-To: <20200214234004.GT2935@paulmck-ThinkPad-P72>
References: <20200214211035.209972-1-elver@google.com>
         <20200214234004.GT2935@paulmck-ThinkPad-P72>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6 (3.22.6-10.el7) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2020-02-14 at 15:40 -0800, Paul E. McKenney wrote:
> On Fri, Feb 14, 2020 at 10:10:35PM +0100, Marco Elver wrote:
> > Previously the system would lock up if ftrace was enabled together with
> > KCSAN. This is due to recursion on reporting if the tracer code is
> > instrumented with KCSAN.
> > 
> > To avoid this for all types of tracing, disable KCSAN instrumentation
> > for all of kernel/trace.
> > 
> > Furthermore, since KCSAN relies on udelay() to introduce delay, we have
> > to disable ftrace for udelay() (currently done for x86) in case KCSAN is
> > used together with lockdep and ftrace. The reason is that it may corrupt
> > lockdep IRQ flags tracing state due to a peculiar case of recursion
> > (details in Makefile comment).
> > 
> > Signed-off-by: Marco Elver <elver@google.com>
> > Reported-by: Qian Cai <cai@lca.pw>
> > Cc: Paul E. McKenney <paulmck@kernel.org>
> > Cc: Steven Rostedt <rostedt@goodmis.org>
> 
> Queued for review and further testing, thank you!
> 
> Qian, does this also fix things for you?

It works fine. Feel free to use,

Tested-by: Qian Cai <cai@lca.pw>

> 
> 							Thanx, Paul
> 
> > ---
> > v2:
> > *  Fix KCSAN+lockdep+ftrace compatibility.
> > ---
> >  arch/x86/lib/Makefile | 5 +++++
> >  kernel/kcsan/Makefile | 2 ++
> >  kernel/trace/Makefile | 3 +++
> >  3 files changed, 10 insertions(+)
> > 
> > diff --git a/arch/x86/lib/Makefile b/arch/x86/lib/Makefile
> > index 432a077056775..6110bce7237bd 100644
> > --- a/arch/x86/lib/Makefile
> > +++ b/arch/x86/lib/Makefile
> > @@ -8,6 +8,11 @@ KCOV_INSTRUMENT_delay.o	:= n
> >  
> >  # KCSAN uses udelay for introducing watchpoint delay; avoid recursion.
> >  KCSAN_SANITIZE_delay.o := n
> > +ifdef CONFIG_KCSAN
> > +# In case KCSAN+lockdep+ftrace are enabled, disable ftrace for delay.o to avoid
> > +# lockdep -> [other libs] -> KCSAN -> udelay -> ftrace -> lockdep recursion.
> > +CFLAGS_REMOVE_delay.o = $(CC_FLAGS_FTRACE)
> > +endif
> >  
> >  # Early boot use of cmdline; don't instrument it
> >  ifdef CONFIG_AMD_MEM_ENCRYPT
> > diff --git a/kernel/kcsan/Makefile b/kernel/kcsan/Makefile
> > index df6b7799e4927..d4999b38d1be5 100644
> > --- a/kernel/kcsan/Makefile
> > +++ b/kernel/kcsan/Makefile
> > @@ -4,6 +4,8 @@ KCOV_INSTRUMENT := n
> >  UBSAN_SANITIZE := n
> >  
> >  CFLAGS_REMOVE_core.o = $(CC_FLAGS_FTRACE)
> > +CFLAGS_REMOVE_debugfs.o = $(CC_FLAGS_FTRACE)
> > +CFLAGS_REMOVE_report.o = $(CC_FLAGS_FTRACE)
> >  
> >  CFLAGS_core.o := $(call cc-option,-fno-conserve-stack,) \
> >  	$(call cc-option,-fno-stack-protector,)
> > diff --git a/kernel/trace/Makefile b/kernel/trace/Makefile
> > index f9dcd19165fa2..6b601d88bf71e 100644
> > --- a/kernel/trace/Makefile
> > +++ b/kernel/trace/Makefile
> > @@ -6,6 +6,9 @@ ifdef CONFIG_FUNCTION_TRACER
> >  ORIG_CFLAGS := $(KBUILD_CFLAGS)
> >  KBUILD_CFLAGS = $(subst $(CC_FLAGS_FTRACE),,$(ORIG_CFLAGS))
> >  
> > +# Avoid recursion due to instrumentation.
> > +KCSAN_SANITIZE := n
> > +
> >  ifdef CONFIG_FTRACE_SELFTEST
> >  # selftest needs instrumentation
> >  CFLAGS_trace_selftest_dynamic.o = $(CC_FLAGS_FTRACE)
> > -- 
> > 2.25.0.265.gbab2e86ba0-goog
> > 
