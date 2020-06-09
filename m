Return-Path: <SRS0=F/Af=7W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30C34C433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 02:33:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 02A7D2078C
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 02:33:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="AZabPOjD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727007AbgFICdK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jun 2020 22:33:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726765AbgFICdJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jun 2020 22:33:09 -0400
Received: from mail-qv1-xf43.google.com (mail-qv1-xf43.google.com [IPv6:2607:f8b0:4864:20::f43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D71E6C03E969
        for <linux-kernel@vger.kernel.org>; Mon,  8 Jun 2020 19:33:07 -0700 (PDT)
Received: by mail-qv1-xf43.google.com with SMTP id dp10so9380448qvb.10
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jun 2020 19:33:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=V6xaafWbMFLTJj9bTOgiL3M3d7/4Zw00NSSLyQeqs0s=;
        b=AZabPOjDFT57PLxFfg30BrUeYac6gtueUY2vxZTuxzHOv1M5JpRixiQawBLeo7Hc8F
         2gZkNLEDbHFkvrn4irjtoIRJezvv92xSGcA1k/jO1iPrNjJecWqkV0RMixkxt5wu6JwF
         mHCCN50GwcYYwReHhYvuCpkqZknHJoxa8U4J7CrOtYKWvU+8Xfw1lrVnMXSBVLK1CU0h
         CZcOeFO63qYTlvcEsrpCJy9uJEC+4Oe5n5I/fubUIFaid+z9UsqtQ1tk/X9EkRbvs2p3
         IXQJ9sxZq6cqlgvqai3vpb6zUmRcR9+iMZKnqVzDhMbSIOhvDHSU/qfIILCMl+wsR1ez
         ffMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=V6xaafWbMFLTJj9bTOgiL3M3d7/4Zw00NSSLyQeqs0s=;
        b=Qsw0NkCA5FKERwZJAWb4EWuDg9p0bRFzJGix8GKsFle5lL5IxeaTQu6/884A67ZlxH
         KEf36mhAQv5qEsTtmY2eJ07bfVsCeYALkbS0GJe0ZSBzXCbrlBLm18HilAjr4bNbva6r
         v1jQIHjYlj4gutEo+MYEmTcbbxAd0vNUZrtT5qYbBGpJajFPrizCdP2eKW4YVLQjADoZ
         rV7w7nyM2r1PsaOH813qbp/D4OP1aO7hPQRq91fKfacu2BHyjhx25kLsBpOT5xc0VDpY
         I8yktBnE8gDTqC+SmRwnovt7eR6Sp4UyAT4lk6Cstgkx75olN76E5bcBJKs3v+EvECmu
         W8ag==
X-Gm-Message-State: AOAM530OMOZq6Mq9E8BCVlUhQh6zrEHeRQbu4Il3cofFiXDosuWnjAOZ
        D2+ajtlbjkDNwz+NZRTtyWTr0A==
X-Google-Smtp-Source: ABdhPJxZBF3gb7PvZSegWXiI4FRXzZfPdqTPFZm8/EBj8k+YhyK6JjwS7IEpPmwVftYqWKgFuM4kYA==
X-Received: by 2002:a0c:e5c1:: with SMTP id u1mr1705953qvm.140.1591669987043;
        Mon, 08 Jun 2020 19:33:07 -0700 (PDT)
Received: from lca.pw (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id 79sm8304108qkf.48.2020.06.08.19.33.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2020 19:33:06 -0700 (PDT)
Date:   Mon, 8 Jun 2020 22:32:59 -0400
From:   Qian Cai <cai@lca.pw>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        X86 ML <x86@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
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
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Will Deacon <will@kernel.org>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Wei Liu <wei.liu@kernel.org>,
        Michael Kelley <mikelley@microsoft.com>,
        Jason Chen CJ <jason.cj.chen@intel.com>,
        Zhao Yakui <yakui.zhao@intel.com>,
        Alexander Potapenko <glider@google.com>
Subject: Re: [patch V9 10/39] x86/entry: Provide helpers for execute on
 irqstack
Message-ID: <20200609023259.GA3579@lca.pw>
References: <20200521200513.656533920@linutronix.de>
 <20200521202117.763775313@linutronix.de>
 <20200605171816.GA4259@lca.pw>
 <20200605173622.GL3976@hirez.programming.kicks-ass.net>
 <20200608160144.GA987@lca.pw>
 <87pna98ajt.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87pna98ajt.fsf@nanos.tec.linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 09, 2020 at 12:20:06AM +0200, Thomas Gleixner wrote:
> Qian,
> 
> can you please ensure that people who got cc'ed because the problem
> affects their subsystem are included on your replies even if you are
> replying to a different subthread?
> 
> I explicitely did:
> 
>      Cc:+ Alexander
> 
> at the very beginning of my reply:
> 
>    https://lore.kernel.org/r/87v9k3jdc6.fsf@nanos.tec.linutronix.de
> 
> to make you aware of that.
> 
> Yes, email sucks, but it sucks even more when people are careless.

Sorry, I will remeber that next time.

[]
> To get facts instead of useless loop theories, can you please apply the
> patch below, enable DEBUGFS and provide the output of
> 
>        /sys/kernel/debug/stackdepot/info
> 
> for a kernel before that change and after? Please read out that file at
> periodically roughly the same amounts of time after starting your test
> scenario.
> 
> Note, that I doubled the size of the stack depot so that we get real
> numbers and not the cutoff by the size limit. IOW, the warning should
> not trigger anymore. If it triggers nevertheless then the numbers will
> still tell us an interesting story.

Instead of running the whole testsuite, I just picked this single LTP
oom02 test which seems usually trigger it within the testsuite. Let me
know if this is insufficient (which indeed tell the big difference in
"Unique stacks"), and I am happy to run the whole things.

BAD: next-20200608
GOOD: next-20200528 (which does not include this series)

BAD (after boot)
# cat /sys/kernel/debug/stackdepot/info
Unique stacks: 33547
Depot index:   359
Depot offset:  6752

BAD (after oom02)
# cat /sys/kernel/debug/stackdepot/info
Unique stacks: 140476
Depot index:   2555
Depot offset:  9168

GOOD (after boot)
# cat /sys/kernel/debug/stackdepot/info
Unique stacks: 31112
Depot index:   317
Depot offset:  14384

GOOD (after oom02)
# cat /sys/kernel/debug/stackdepot/info
Unique stacks: 34176
Depot index:   354
Depot offset:  4032

BTW, I am happy to run another one using next-20200608 with just this
series reverted if you suspect there is something else going on between
those two trees.
