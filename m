Return-Path: <SRS0=0sZ+=6V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0253AC38A24
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 18:04:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C73D12145D
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 18:04:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588874688;
	bh=T9rkg8uqlS5E7KWzJgD3COhvBHTW96g2v1NcZviUg6k=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=bGA4ZD8go161vBSBgxIaSTnf0+fK+0gGAfB5HUKN978WsYkrlF3WI/J40bWD0mkjG
	 NSHPFba3RuuF5umlmoksrvbEhDDiMwotX0OiqArE8AD9naiit/OxrwOq8nA+/Qjv55
	 /1a2T9/Z7EveGOTDG9n1zwDZmCQgsPG2f2dOHfec=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728366AbgEGSEs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 May 2020 14:04:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:58144 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728324AbgEGSEr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 14:04:47 -0400
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BDA492145D
        for <linux-kernel@vger.kernel.org>; Thu,  7 May 2020 18:04:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588874687;
        bh=T9rkg8uqlS5E7KWzJgD3COhvBHTW96g2v1NcZviUg6k=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=wim1l6W3chef9YaxPnPte9jBg7O7X2C0S+yMJ2W/MJsIXE2vKjs2z1x+SpYyDOQUX
         +I0qKKYVJQ7yqw9eSVUcCpfj8wbSrL3ndjSfZzGmJIvzA0JrIXsIYahOt/bWGMhW6P
         TaXLHSVd0UWntiK+0d3keJ/c17psVGGCSZk0DgMc=
Received: by mail-wm1-f54.google.com with SMTP id 188so7551637wmc.2
        for <linux-kernel@vger.kernel.org>; Thu, 07 May 2020 11:04:46 -0700 (PDT)
X-Gm-Message-State: AGi0PuYasp6CSCZ/O49KZ+nRHt9WUpC+Zaw38OSy9MwjFGsbg87K+7ab
        quzR9BEPOiPW3sbzZ/yEGZlWKCjygaSYBrD8FuZXaw==
X-Google-Smtp-Source: APiQypIc/fzuVPEMb5iaQFfb3GsJ/KtVABEVlHy/7XBj1SRGVAjFihWffkPiWu63VKj0SJuTwDFUfnhMUoClw4MWgN0=
X-Received: by 2002:a7b:c5d3:: with SMTP id n19mr4587126wmk.21.1588874685305;
 Thu, 07 May 2020 11:04:45 -0700 (PDT)
MIME-Version: 1.0
References: <20200505131602.633487962@linutronix.de> <20200505134101.525508608@linutronix.de>
In-Reply-To: <20200505134101.525508608@linutronix.de>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Thu, 7 May 2020 11:04:34 -0700
X-Gmail-Original-Message-ID: <CALCETrXfemPJrVx+Nfp7k_PvKGezSK46_+dL5oNNV3o5i1qWVw@mail.gmail.com>
Message-ID: <CALCETrXfemPJrVx+Nfp7k_PvKGezSK46_+dL5oNNV3o5i1qWVw@mail.gmail.com>
Subject: Re: [patch V4 part 1 35/36] x86: Replace ist_enter() with nmi_enter()
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
        "Peter Zijlstra (Intel)" <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 5, 2020 at 7:14 AM Thomas Gleixner <tglx@linutronix.de> wrote:
>
> From: Peter Zijlstra <peterz@infradead.org>
>
> A few exceptions (like #DB and #BP) can happen at any location in the code,
> this then means that tracers should treat events from these exceptions as
> NMI-like. The interrupted context could be holding locks with interrupts
> disabled for instance.
>
> Similarly, #MC is an actual NMI-like exception.

Is it permissible to send a signal from inside nmi_enter()?  I imagine
so, but I just want to make sure.

--Andy
