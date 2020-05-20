Return-Path: <SRS0=sqqi=7C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 497D6C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 00:32:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 22E512083E
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 00:32:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589934757;
	bh=d0jrmBGquTgDXWOFwkyLLuDxr4VT46/MGEM6yZgUXmg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=0TQDugoPnUaFLi2ewJ9wiJE3iBURn588AcKSqn4agYcUhLRN26/eMtpnIIyM3Hq5+
	 PUh6eeunZDV1I+kgXQKSnrVyfeXNAZf/Qlt/K42RWchGtlUxPKnBs10NFGoMH7bL2i
	 p/jcqDVVf2f9TwF/Pz58Kl6WcRnhBZpVEeVADOr4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728566AbgETAcg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 May 2020 20:32:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:45520 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726379AbgETAcg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 20:32:36 -0400
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7740020878
        for <linux-kernel@vger.kernel.org>; Wed, 20 May 2020 00:32:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589934755;
        bh=d0jrmBGquTgDXWOFwkyLLuDxr4VT46/MGEM6yZgUXmg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ZUfVqIbinHXhst0UAm2pZq3i10tHRBFEJsiJ2DE+eUjYK9GOGUUzcr1+r/sEVa+ci
         4gBicc5SBRLaRVLppxLniEZLM7gfxVlmpHPHx18M2X1QDqbRSUuSPckn+QnMB1R0a+
         f3YEmBS52CK1AitjPddKJkmd/A81ZHAZf5+YTAws=
Received: by mail-wm1-f41.google.com with SMTP id t8so1848525wmi.0
        for <linux-kernel@vger.kernel.org>; Tue, 19 May 2020 17:32:35 -0700 (PDT)
X-Gm-Message-State: AOAM532oeRS3V6fZEKFI+mpQnH5DgPEg0JtOOIqJJOOyXchrQ2iHcegF
        EnXNeNKNrrL3Qb4EXYKonD4BSoXG843x8/2luRz5oQ==
X-Google-Smtp-Source: ABdhPJw/93SRdRyXHGe0TxJC2o0fMyqFnfMuNES7xI6meEy1aM8ByNgIiDiAfb2FM2K1V1p34BSJZ4/4WKTKS8PTwMU=
X-Received: by 2002:a05:600c:2299:: with SMTP id 25mr1977081wmf.138.1589934753959;
 Tue, 19 May 2020 17:32:33 -0700 (PDT)
MIME-Version: 1.0
References: <20200515234547.710474468@linutronix.de> <20200515235127.498652915@linutronix.de>
In-Reply-To: <20200515235127.498652915@linutronix.de>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Tue, 19 May 2020 17:32:22 -0700
X-Gmail-Original-Message-ID: <CALCETrXnRSCpRMNnQG0Pb-DHAscb5QAv3-G9eCZYtkHAFNp0Bg@mail.gmail.com>
Message-ID: <CALCETrXnRSCpRMNnQG0Pb-DHAscb5QAv3-G9eCZYtkHAFNp0Bg@mail.gmail.com>
Subject: Re: [patch V6 31/37] x86/entry: Remove the apic/BUILD interrupt leftovers
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

On Fri, May 15, 2020 at 5:10 PM Thomas Gleixner <tglx@linutronix.de> wrote:
>
>
> Remove all the code which was there to emit the system vector stubs. All
> users are gone.
>
> Move the now unused GET_CR2_INTO macro muck to head_64.S where the last
> user is. Fixup the eye hurting comment there while at it.

Acked-by: Andy Lutomirski <luto@kernel.org>
