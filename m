Return-Path: <SRS0=IaiW=7B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F639C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 12:28:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 29CE920825
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 12:28:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="jtcR0oks"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728887AbgESM2N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 May 2020 08:28:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726196AbgESM2M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 08:28:12 -0400
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8BD1C08C5C0
        for <linux-kernel@vger.kernel.org>; Tue, 19 May 2020 05:28:12 -0700 (PDT)
Received: by mail-qt1-x833.google.com with SMTP id n22so8438359qtv.12
        for <linux-kernel@vger.kernel.org>; Tue, 19 May 2020 05:28:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=cbjlO/cLct6CcWqznimUl6b8xW3XlbVQzwh8BjQnE2k=;
        b=jtcR0oksYl2AthtyLV6Bs4EZ8fL/4fhwnYGvGE+kBKYPQkabZkMki4jmsR3yXDQJqa
         vDFQ4MRwiUoPK1JSych6nKBlE2+yvGPLTYm4YyF3gCdhX8xcktVS/IwNGmwSNTfdZr2h
         HlFRCb1+Rvl3/fx2BL8vo0q+g+kOKe+Bc+lCk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=cbjlO/cLct6CcWqznimUl6b8xW3XlbVQzwh8BjQnE2k=;
        b=np8gvqDX8KCISYK3ZPFdbPRmE0DkGbB0TTCN9PZGxhop4QAHvSRNYPgIHimkEpg77v
         4D/JxfIzKLHTAhxw22YeNlLvp6W6lphhwQJRPJivmEy766Vz2+Ud0k2uIH3Gbk9o086Q
         0UMsOl2YkiQY+HRqcJKt3IeR2+KRBtrJ3L6S5z4Tt/txus/qa7jZcx2+/7oLdrB+EUa5
         FMknlxUZTUjlmuN4/lrp8xpeagnVDX4siPgX1+b/yzvosVtzOTYPy0asWiESqXcsWWYX
         Gr3r2O+CKLOn7EbuM/J6GZepFbY8Fz5lVtye3jkDZWhtWmZeBonDrkWjE6Q1FbU4FK8T
         UcZw==
X-Gm-Message-State: AOAM531v9GeYS0IJ6Ru8cNG2g/Swbf4kHW8/58fWGysBVI5e+lhHYwrE
        lRRlT6r6nn4HXDRN4uRT/YNJvw==
X-Google-Smtp-Source: ABdhPJxrKhSq2gcAcxUiYHUIYYCpSUcfWJl/cqZpA1Sjo7NmZ87M8y6hTQWyANZv/C1mFhntEgwRmA==
X-Received: by 2002:ac8:4e38:: with SMTP id d24mr21687305qtw.343.1589891291430;
        Tue, 19 May 2020 05:28:11 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id h18sm10482674qkh.3.2020.05.19.05.28.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2020 05:28:10 -0700 (PDT)
Date:   Tue, 19 May 2020 08:28:10 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Andy Lutomirski <luto@kernel.org>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        Brian Gerst <brgerst@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Will Deacon <will@kernel.org>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Wei Liu <wei.liu@kernel.org>,
        Michael Kelley <mikelley@microsoft.com>,
        Jason Chen CJ <jason.cj.chen@intel.com>,
        Zhao Yakui <yakui.zhao@intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>
Subject: Re: [patch V6 00/37] x86/entry: Rework leftovers and merge plan
Message-ID: <20200519122810.GA49651@google.com>
References: <20200515234547.710474468@linutronix.de>
 <20200516171845.GM2869@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200516171845.GM2869@paulmck-ThinkPad-P72>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 16, 2020 at 10:18:45AM -0700, Paul E. McKenney wrote:
> On Sat, May 16, 2020 at 01:45:47AM +0200, Thomas Gleixner wrote:
> 
> [ . . . ]
> 
> >   - noinstr-rcu-nmi-2020-05-15
> > 
> >     Based on the core/rcu branch in the tip tree. It has merged in
> >     noinstr-lds-2020-05-15 and contains the nmi_enter/exit() changes along
> >     with the noinstr section changes on top.
> > 
> >     This tag is intended to be pulled by Paul into his rcu/next branch so
> >     he can sort the conflicts and base further work on top.
> 
> And this sorting process is now allegedly complete and available on the
> -rcu tree's "dev" branch.  As you might have guessed, the major source
> of conflicts were with Joel's patches, including one conflict that was
> invisible to "git rebase":
> 
> 1b2530e7d0c3 ("Revert b8c17e6664c4 ("rcu: Maintain special bits at bottom of ->dynticks counter")
> 03f31532d0ce ("rcu/tree: Add better tracing for dyntick-idle")
> a309d5ce2335 ("rcu/tree: Clean up dynticks counter usage")
> 5c6e734fbaeb ("rcu/tree: Remove dynticks_nmi_nesting counter")
> 
> This passes modest rcutorture testing.  So far, so good!  ;-)

Also I double checked these patches in the rcu/dev branch. It looks good to
me, thanks for resolving the conflicts!!

 - Joel

