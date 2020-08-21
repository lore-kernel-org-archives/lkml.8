Return-Path: <SRS0=Oudi=B7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FEA0C433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 13:32:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6AECC2075E
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 13:32:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="S41w5fwx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728759AbgHUNcC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Aug 2020 09:32:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728508AbgHUNb4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Aug 2020 09:31:56 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E395C061574
        for <linux-kernel@vger.kernel.org>; Fri, 21 Aug 2020 06:31:55 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id x5so1881730wmi.2
        for <linux-kernel@vger.kernel.org>; Fri, 21 Aug 2020 06:31:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=/vzJF5387NyjF3nOJV/SJFXMwXDsvo3icVibo5VrwR8=;
        b=S41w5fwx7XkF3IGvGRMT/ai/JsOGs+u4u2juAxr8Au3+Sp8ii4yYkar2pJz1GXDo3B
         cjOKgtodJ5rH9hehhqHEFtjoSQLH7CeFm4WIqzOJxE3xX6Z0TToXlLlUAsW545MuZnnw
         01JWtE5ZfhkoNwaoqpsNdfBC0E5795Chxi8LXI8FE/MC8Lu38VZRoPawvSrQfWmLnlMu
         Vvr8PiM2J2tlNc2e/WCGTrT+IJc7djjGqjr6+QHtFHgT0yK7rD5iInk3srKW1olYK5vQ
         CRlYoHrQr3Xu40/UWxm8y87/bIOWU3oVv8pH+RABzs7sfK1WN3WiqfVItS3vxVLlPtIU
         R3Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=/vzJF5387NyjF3nOJV/SJFXMwXDsvo3icVibo5VrwR8=;
        b=n3+o7cgDUNPe0WoGwnvl4DXFW7fZD34gOwVo9uGCbbLd9/Do4OY6fgHzgC7F6HdVcP
         LOJkFeluqX/xvryXrwWIQrW1YJjM0w6O3YWKDqhWHPj+7Vn9agH/da5Y4C16kehfDc39
         KycZDw0eoOZNkvDANJSxvo0+sEziCPz7UP0TF1R79L+pztMnfOy/24m/Wn/8m0WrWnc0
         GCoGXBs6WbkzkuvFU6DEqbdAvCOpYMPx5RIT8DdeXX9mFkIXdAFOINzd4qO0PCmVDWzq
         P72QxXm1TnVmAC5bA6Mm8JfMAIhUw0x5KH23eHKHyT80fZSzYatYpEZEBzXbfMe95yZC
         arqQ==
X-Gm-Message-State: AOAM533e3DYsaZNE7RR1SxJwUuQa8VsbvzxR6WBPqx7Yg9gCHHAq0ktw
        wPQWq4KF6ek7fbcJpSc8HUGTnQ==
X-Google-Smtp-Source: ABdhPJyD82UgI6gRkwXYIbPhA4GpalKzTRLpfv0OggKxvX8FCT6/IBkP/oMec1mkiaZsOb7nRyET6w==
X-Received: by 2002:a1c:4e0c:: with SMTP id g12mr3223538wmh.136.1598016712736;
        Fri, 21 Aug 2020 06:31:52 -0700 (PDT)
Received: from holly.lan (cpc141214-aztw34-2-0-cust773.18-1.cable.virginm.net. [86.9.19.6])
        by smtp.gmail.com with ESMTPSA id v20sm4737033wrd.6.2020.08.21.06.31.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Aug 2020 06:31:51 -0700 (PDT)
Date:   Fri, 21 Aug 2020 14:31:49 +0100
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     peterz@infradead.org
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Kyle Huey <me@kylehuey.com>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        Robert O'Callahan <rocallahan@gmail.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        Brian Gerst <brgerst@gmail.com>,
        Andy Lutomirski <luto@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>
Subject: Re: [RFC][PATCH 4/7] x86/debug: Move historical SYSENTER junk into
 exc_debug_kernel()
Message-ID: <20200821133149.s6pq5wgo5v5iauij@holly.lan>
References: <20200820103832.486877479@infradead.org>
 <20200820104905.294802764@infradead.org>
 <20200820152828.tvluka3lvmzof5xt@holly.lan>
 <20200821101903.GK1362448@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200821101903.GK1362448@hirez.programming.kicks-ass.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 21, 2020 at 12:19:03PM +0200, peterz@infradead.org wrote:
> On Thu, Aug 20, 2020 at 04:28:28PM +0100, Daniel Thompson wrote:
> 
> > Specifically I've entered the kdb in pretty much the simplest way
> > possible: a direct call to kgdb_breakpoint() from a task context. I
> > generate a backtrace to illustrate this, just to give you a better
> > understanding of what might be happening) and then ran the single step.
> 
> 
> > + make -C .. O=$PWD x86_64_defconfig
> > + ../scripts/config --enable RUNTIME_TESTING_MENU
> > + ../scripts/config --enable DEBUG_INFO --enable DEBUG_FS --enable KALLSYMS_ALL --enable MAGIC_SYSRQ --enable KGDB --enable KGDB_TESTS --enable KGDB_KDB --enable KDB_KEYBOARD --enable LKDTM
> > + ../scripts/config --enable PROVE_LOCKING --enable DEBUG_ATOMIC_SLEEP
> > + make olddefconfig
> 
> 
> That asked me about a kgdb boottime selftest, which I figured was a good
> idea, but even without my patches that seems to fail, and fail so that
> it doesn't boot :/

If you are running to fork test (the F100 in the default test string of
kgdbts=V1F100 kgdbwait) then you will need rodata=off to avoid problems
setting or clearing breakpoints (you also need to have at last 100 calls
to fork for the test suite to complete; a modern kernel without the
excessive forking for hotplug will usually make it well into userspace
before racking up this many forks).

This will prevent the test suite from hanging the boot although I think
you will still see the still see the stacktrace from the hardware
watchpoint test (this is unrelated to current patchset).


Daniel.
