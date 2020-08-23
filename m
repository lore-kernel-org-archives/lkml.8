Return-Path: <SRS0=TdnH=CB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01D82C433E1
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Aug 2020 23:01:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CE11820724
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Aug 2020 23:01:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598223698;
	bh=uIozQjH4sJMFEtlil87O9vMH7tgYAD4fbTQ4Y7hSR1A=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=DiJG/GlGbOVQcRdqcWBVlhm1amyeQRqDq/0rEy70J8w3z3AoSvCfAQQQZXcyXUm80
	 Vwp5NObJxQZzJqz6bWgBRKZtjUPszYzk/8SMQBlq2iU1ZuUhu+zvntDEevIT5KCq70
	 PDFClvQiCEA67e/xjcg/lfb/YgCOOMilAJ32SP2c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726950AbgHWXBh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Aug 2020 19:01:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:35210 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726631AbgHWXBh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Aug 2020 19:01:37 -0400
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 722F520768
        for <linux-kernel@vger.kernel.org>; Sun, 23 Aug 2020 23:01:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598223696;
        bh=uIozQjH4sJMFEtlil87O9vMH7tgYAD4fbTQ4Y7hSR1A=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=o3Hzhb0eZNmdy41TDKHPXtlCbqf/kILQve41+HJMAem+pUiHvLymALgk5OmZz32dR
         guADt+SPC56+X+h0a55FIzgGGr0Jhj8XAJUaTJoI0cCtEodCjPliQJh5DrHWsNhf7m
         Ma3ArnaLhJYC9FkAInmn7wj4yptPDQOmsZx4LOOw=
Received: by mail-wr1-f47.google.com with SMTP id a15so6874834wrh.10
        for <linux-kernel@vger.kernel.org>; Sun, 23 Aug 2020 16:01:36 -0700 (PDT)
X-Gm-Message-State: AOAM530ZeUyWOOjnm5jgVj+Z+g/E2MjgHBE/be77rts2W2nSamvCrg8B
        PoR+J6paHeTKly5nELkVcxkYxMXMBhcJUhBXS7zFdA==
X-Google-Smtp-Source: ABdhPJw/e7WuyQb73fVLpX70mVy6DyaoG51HgfKj0IODmT0P7DTkHaZhDk4x5BKmsFSIgvGRBwwluUXsMOqlaXdgAZQ=
X-Received: by 2002:a5d:400e:: with SMTP id n14mr3077705wrp.75.1598223695033;
 Sun, 23 Aug 2020 16:01:35 -0700 (PDT)
MIME-Version: 1.0
References: <20200821093912.815135402@infradead.org> <20200821102052.910320981@infradead.org>
In-Reply-To: <20200821102052.910320981@infradead.org>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Sun, 23 Aug 2020 16:01:23 -0700
X-Gmail-Original-Message-ID: <CALCETrWLj=jAyDqOz4D5aXoa8b-qxSvZauHAbu56rOyXWyRNKw@mail.gmail.com>
Message-ID: <CALCETrWLj=jAyDqOz4D5aXoa8b-qxSvZauHAbu56rOyXWyRNKw@mail.gmail.com>
Subject: Re: [PATCH v2 3/8] x86/debug: Move kprobe_debug_handler() into exc_debug_kernel()
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Kyle Huey <me@kylehuey.com>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        "Robert O'Callahan" <rocallahan@gmail.com>,
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
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Daniel Thompson <daniel.thompson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 21, 2020 at 3:21 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> Kprobes are on kernel text, and thus only matter for #DB-from-kernel.
> Kprobes are ordered before the generic notifier, preserve that order.
>

Acked-by: Andy Lutomirski <luto@kernel.org>
