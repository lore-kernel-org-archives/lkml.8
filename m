Return-Path: <SRS0=RE5T=7A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5157C433E2
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 20:43:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 90477206D4
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 20:43:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589834587;
	bh=DVpqsXwckSCUbAJoI8aDzAaM3G/Kl8m8ZNDDVrz/OeU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=OngD0PBN50eQpv/bvKJYFajbI/BK8votj+HBGlz3k+PgfEyuvk38wcMut99wWIKev
	 R+cprfJ/l5mjjcFPYtjQCm/y429/oeqL7POejS551TOWMptRWhK+ZAO2Dw06He98t5
	 2j+FEIGZ+po9okSDg+zNc2nkRSiqbpnp/l/GAvI8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727957AbgERUnH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 May 2020 16:43:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:60166 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727037AbgERUnG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 16:43:06 -0400
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5E1DF20756
        for <linux-kernel@vger.kernel.org>; Mon, 18 May 2020 20:43:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589834585;
        bh=DVpqsXwckSCUbAJoI8aDzAaM3G/Kl8m8ZNDDVrz/OeU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=clKX/hUxYgFS2FFs8J3IDHgLC/wBOtPCM7cN4hkBHup2WFFRJBBlFYMS7no6yHv+u
         kDuqqHtH61NuCg1fqB0rdA9fSWpMcuDa8N/GoCWwVujIqUgLtYysUFvrbsAZPYiI5g
         mUs76enQ6tuPUrEpsw16/Z4o6M6HAMId3ffPB4Xw=
Received: by mail-wm1-f53.google.com with SMTP id m12so862310wmc.0
        for <linux-kernel@vger.kernel.org>; Mon, 18 May 2020 13:43:05 -0700 (PDT)
X-Gm-Message-State: AOAM532X3XwwUVdWxbXl5nW+WB38Z4xtDcWuyaWwMKnW07J8q0qgZCYf
        yx4nrQ8fwX4OwjyIf/ZxF0C6tfLo2WOSnQZEQskIrg==
X-Google-Smtp-Source: ABdhPJw+pnVx9jgNe6Ljpq4BSZjMEWHBDxTURrm0IbPOmjOd+hx1REtWyjfWXvQ7ibqaNxC225g6lK4eEbesnQ4jEYk=
X-Received: by 2002:a1c:9989:: with SMTP id b131mr1246250wme.176.1589834583789;
 Mon, 18 May 2020 13:43:03 -0700 (PDT)
MIME-Version: 1.0
References: <20200515234547.710474468@linutronix.de> <20200515235124.783722942@linutronix.de>
 <CALCETrW2negGYRSQ8dqFVdiWGtYpYf6nKe5_hkotNv0e5mNBxA@mail.gmail.com>
 <87zha7c5h5.fsf@nanos.tec.linutronix.de> <CALCETrVuA25n_d-3KMvvDxuqZeBEEYb6n=QAXOhBFkgS1Dk+UA@mail.gmail.com>
 <877dx9zn47.fsf@nanos.tec.linutronix.de>
In-Reply-To: <877dx9zn47.fsf@nanos.tec.linutronix.de>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Mon, 18 May 2020 13:42:52 -0700
X-Gmail-Original-Message-ID: <CALCETrW9sCjeRgNZ4h4f-zNzheerxWxEvUyCaPkO1nHqV99EpQ@mail.gmail.com>
Message-ID: <CALCETrW9sCjeRgNZ4h4f-zNzheerxWxEvUyCaPkO1nHqV99EpQ@mail.gmail.com>
Subject: Re: [patch V6 04/37] x86: Make hardware latency tracing explicit
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Andy Lutomirski <luto@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
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
        "Peter Zijlstra (Intel)" <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 18, 2020 at 1:03 AM Thomas Gleixner <tglx@linutronix.de> wrote:
>
> Andy Lutomirski <luto@kernel.org> writes:
> > On Sun, May 17, 2020 at 1:48 AM Thomas Gleixner <tglx@linutronix.de> wrote:
> >> Remember this is about ensuring that all the state is properly
> >> established before any of this instrumentation muck can happen.
> >>
> >> DR7 handling is specific to #DB and done even before nmi_enter to
> >> prevent recursion.
> >
> > So why is this change needed?
>
> We really want nmi_enter() to be the carefully crafted mechanism which
> establishes correct state in whatever strange context the exception
> hits. Not more, not less.
>
> Random instrumentation has absolutely no business there and I went a
> long way to make sure that this is enforcible by objtool.
>
> Aside of that the tracing which is contained in nmi_enter() is about
> taking timestamps for hardware latency detection. If someone runs
> hardware latency detection with active break/watchpoints then I really
> can't help it.
>

Okay.  I'll stop looking for the bug you're fixing, then.
