Return-Path: <SRS0=wESH=6W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EE09C38A2A
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 23:53:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 755D324958
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 23:53:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588982000;
	bh=ShlmSSYoZM/4KVSCon78C6OJGXgAfXrm+T81mzLuWPw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=QWUl0u1uRISoJwk32lzv6k6F3nswhkhjPQMKwnQcOI6lXTKFpy0fU0WBV6sxk/AD2
	 Q0Y6kXFfraghNNFIWiRQaAIlUHAInO13yqMZLKMXCTMRcq1DRMbUkLXG3mdEWi+2V7
	 s9blG2SB1YMNdj/vBfJqG1KKROc1CrzsjaVQ9a6Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728378AbgEHXxT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 May 2020 19:53:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:55684 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727878AbgEHXxS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 19:53:18 -0400
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1C6042173E
        for <linux-kernel@vger.kernel.org>; Fri,  8 May 2020 23:53:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588981998;
        bh=ShlmSSYoZM/4KVSCon78C6OJGXgAfXrm+T81mzLuWPw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=n9D//HxEgwGYRXgRcsG3JRKq4w6a8alFjKJwQTMSBxIosataRm+U04vlHtZ3QiDPy
         hc4pTv3LfB/awZ0phNvSPvbYP3FdBnamj604NaDyGvMkSCIyjNChgWtyiKoWwork7u
         EcpSeIbFLNLB5hOPy+TTj8OUbvjTUDIT+69Q6izo=
Received: by mail-wr1-f52.google.com with SMTP id e16so3854931wra.7
        for <linux-kernel@vger.kernel.org>; Fri, 08 May 2020 16:53:18 -0700 (PDT)
X-Gm-Message-State: AGi0PuZOYH4Q6qe6tTys09DsDUI3W7ylolKS0w6oplq3kXFTSMLtBtG8
        o+Rtg4XBkD/r3/AljEet9T4Q3kl2/o+50GQ/eypElA==
X-Google-Smtp-Source: APiQypLiN19kbzcdasktac/S2PjgXFAT+6IXCH3zMVMKE/A51GS2xk4EfodmyQvY7BtBRgu0KkORc7ULRJXdf0XOz1k=
X-Received: by 2002:a5d:62cc:: with SMTP id o12mr5447139wrv.75.1588981996655;
 Fri, 08 May 2020 16:53:16 -0700 (PDT)
MIME-Version: 1.0
References: <20200505134112.272268764@linutronix.de> <20200505134340.227579223@linutronix.de>
In-Reply-To: <20200505134340.227579223@linutronix.de>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Fri, 8 May 2020 16:53:05 -0700
X-Gmail-Original-Message-ID: <CALCETrWJDdxnP5pJQinMkyL+mb3th1tWGY7psYqod8nDnrV2YQ@mail.gmail.com>
Message-ID: <CALCETrWJDdxnP5pJQinMkyL+mb3th1tWGY7psYqod8nDnrV2YQ@mail.gmail.com>
Subject: Re: [patch V4 part 2 01/18] x86/entry/64: Move non entry code into
 .text section
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

On Tue, May 5, 2020 at 7:14 AM Thomas Gleixner <tglx@linutronix.de> wrote:
>
> All ASM code which is not part of the entry functionality can move out into
> the .text section. No reason to keep it in the non-instrumentable entry
> section.

Ick.  How about just moving that code into another file altogether?

> +.pushsection .text, "ax"
>  SYM_FUNC_START(native_load_gs_index)
>         FRAME_BEGIN
>         pushfq
> @@ -1058,6 +1063,7 @@ SYM_FUNC_START(native_load_gs_index)
>         ret
>  SYM_FUNC_END(native_load_gs_index)
>  EXPORT_SYMBOL(native_load_gs_index)
> +.popsection

native_load_gs_index is toast if it gets instrumented in the wrong way.
