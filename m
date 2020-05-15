Return-Path: <SRS0=BsgQ=65=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49DCFC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 05:40:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 149F720671
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 05:40:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589521202;
	bh=Ie/JTAhXDnOg+pAfpYp95/kDbcERYOP5umwIBu5IN4c=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=Clu/A7rcrIj0DiWtKTpeeYatlwwkRooHtK3z5KFu+bgrLhWgZMZoeusu93AYp6MUJ
	 r6iwM8rdGdCkuy9Qwna6nEevZwBMpYZyuvYNa3k4Z2yAbBnI/Xx/Mzk8Q5OP+32Sdb
	 Vw7Jx7B911r0AqzdCuoXSNvzrWLTZOvEtBIb3WpM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726664AbgEOFkB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 May 2020 01:40:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:46388 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725899AbgEOFkA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 May 2020 01:40:00 -0400
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 342EC20787
        for <linux-kernel@vger.kernel.org>; Fri, 15 May 2020 05:40:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589521200;
        bh=Ie/JTAhXDnOg+pAfpYp95/kDbcERYOP5umwIBu5IN4c=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=FYj8hgBM4YpyGUzGmtMhPMyBMC3GhAJnQ2EyH1+cSx5QlXamEc1PJLEj/ruIWkMgt
         Te6DxotShXiBmAhQ2DOJNs1f5TCxG0i9xCd48fE8p56WvUNZHqmsEexKBLBpLks/zd
         Oiczi+ieqW8rAE5w9LAAfkwWmo8L0XVu76YLdlfc=
Received: by mail-wr1-f45.google.com with SMTP id 50so1917990wrc.11
        for <linux-kernel@vger.kernel.org>; Thu, 14 May 2020 22:40:00 -0700 (PDT)
X-Gm-Message-State: AOAM532QCPwgwLAjuibWhwDoTlr6BT/SiE/uMr1i6Zs0iETpqbuw/iqw
        1e7Ki3gU2OpUqiMS3ynEdw6v3xgyxRsqzV0RNdM72g==
X-Google-Smtp-Source: ABdhPJxPs2A2vJtlQFcodeaRVydOCVotTvolEOxcboYqeQr0mt8fem1KbbLwrZ1WryBEmYDX/JqvkC8telU+JG62nCU=
X-Received: by 2002:adf:f446:: with SMTP id f6mr2173928wrp.75.1589521198720;
 Thu, 14 May 2020 22:39:58 -0700 (PDT)
MIME-Version: 1.0
References: <20200505134926.578885807@linutronix.de> <20200505135315.380927730@linutronix.de>
In-Reply-To: <20200505135315.380927730@linutronix.de>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Thu, 14 May 2020 22:39:46 -0700
X-Gmail-Original-Message-ID: <CALCETrXbfcqTPwSzicbphxMCCBDfFv=zxtUVdWm9Z+xWAtB_vw@mail.gmail.com>
Message-ID: <CALCETrXbfcqTPwSzicbphxMCCBDfFv=zxtUVdWm9Z+xWAtB_vw@mail.gmail.com>
Subject: Re: [patch V4 part 4 21/24] x86/traps: Address objtool noinstr
 complaints in #DB
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

On Tue, May 5, 2020 at 7:16 AM Thomas Gleixner <tglx@linutronix.de> wrote:
>
> The functions invoked from handle_debug() can be instrumented. Tell objtool
> about it.

Acked-by: Andy Lutomirski <luto@kernel.org>
