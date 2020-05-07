Return-Path: <SRS0=0sZ+=6V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28FC8C38A24
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 17:56:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F308F2145D
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 17:56:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588874163;
	bh=Ju2hWiKFj3oHKpYAyY0jgL+OEIu/kKfswtVG9Uw9VUg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=zKKvrHT91zezEJiu1tliFWimXy8rLYYI1IZMaYu4CN+UqvaJdI58GVY5I6ERWn3EU
	 GNSzMBz+XI30+7Ep+d94QbxPECOcv93PvG9+VeT2n1oaJGxOoey6KDhaiyh76hSMs5
	 e8uCb2iiq2fqAWC/LyDD9RbfzbN8tEDBKM3MQZwI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728130AbgEGR4C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 May 2020 13:56:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:45578 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726320AbgEGR4B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 13:56:01 -0400
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0C68621473
        for <linux-kernel@vger.kernel.org>; Thu,  7 May 2020 17:56:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588874161;
        bh=Ju2hWiKFj3oHKpYAyY0jgL+OEIu/kKfswtVG9Uw9VUg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=qPaizVSIxUfJTRePqtUsFCmPCgnabWGlDVh03fpQ89uokt/Gl8imcpEZYp306+lH5
         gxhmvcxJ2Xye2bJsPoYbY8DirlSg3n5ncvrQVJzsfcQal2jsFyCMhzyTJY8XO0hp2X
         s6Ojb7CKOwKBCoY0WWFHMKmDYz4sFyVW+bNVYzm0=
Received: by mail-wm1-f44.google.com with SMTP id h4so7540910wmb.4
        for <linux-kernel@vger.kernel.org>; Thu, 07 May 2020 10:56:00 -0700 (PDT)
X-Gm-Message-State: AGi0PuZ4IOArt1DFrSXMrBtVWDlpdMWzsEE2G6SCtEi3Qp5uG3a/UKuQ
        ebhLnOgsREYQbscNhnCf+PQj8DvR2pS4FP/SwJvxxA==
X-Google-Smtp-Source: APiQypKy7RbYUczYMGVUdYhc9NxrFHVmgaOodGQy6PYtdslBgsHIS1PzSwf+neRuXSxqP+wRZ0y2ii6TplEMxQspqE8=
X-Received: by 2002:a7b:c74d:: with SMTP id w13mr11231529wmk.36.1588874159550;
 Thu, 07 May 2020 10:55:59 -0700 (PDT)
MIME-Version: 1.0
References: <20200505131602.633487962@linutronix.de> <20200505134100.270771162@linutronix.de>
In-Reply-To: <20200505134100.270771162@linutronix.de>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Thu, 7 May 2020 10:55:47 -0700
X-Gmail-Original-Message-ID: <CALCETrU7rf8cizYM1v0Rb6LzufLEbNcAS6Ebx_BW=+3Svk+F2g@mail.gmail.com>
Message-ID: <CALCETrU7rf8cizYM1v0Rb6LzufLEbNcAS6Ebx_BW=+3Svk+F2g@mail.gmail.com>
Subject: Re: [patch V4 part 1 22/36] tracing: Provide lockdep less
 trace_hardirqs_on/off() variants
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
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
        Will Deacon <will@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 5, 2020 at 7:13 AM Thomas Gleixner <tglx@linutronix.de> wrote:
>
> trace_hardirqs_on/off() is only partially safe vs. RCU idle. The tracer
> core itself is safe, but the resulting tracepoints can be utilized by
> e.g. BPF which is unsafe.
>
> Provide variants which do not contain the lockdep invocation so the lockdep
> and tracer invocations can be split at the call site and placed properly.
>
> The new variants also do not use rcuidle as they are going to be called
> from entry code after/before context tracking.

I can't quite follow this.  Are you saying that the new variants are
intended to be called by the entry code in a context where tracing is
acceptable and that the lockdep part will still be called in a context
where tracing is not acceptable?

--Andy
