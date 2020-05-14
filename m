Return-Path: <SRS0=2JZx=64=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B854C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 04:57:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8647A206D8
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 04:57:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589432247;
	bh=Lte4B9W8zW8d5KMicJ/udk+nHQDdtuOAvFltY0KBD08=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=T3n/GL7HX8IKZQZYHcOsvMIRBED2wH6BWR3sqnNLXQQBvj3DS6Jeet3oTi0ghEJit
	 Cts07KvzUZMmlCYn+nfafv8ImJVUseYT6c3zHRavuTp9SjMzDKtOJxK/QwdJm4meeW
	 XjLA/jnMflVFlmdlMFQ5FFFt4zLBeXCPG89QTff4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726031AbgENE50 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 May 2020 00:57:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:40024 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725794AbgENE50 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 May 2020 00:57:26 -0400
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A3CFF20734
        for <linux-kernel@vger.kernel.org>; Thu, 14 May 2020 04:57:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589432245;
        bh=Lte4B9W8zW8d5KMicJ/udk+nHQDdtuOAvFltY0KBD08=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=O5Hv25Iey76uaYgemEZ9MYmy4MpRywmODNENvrAcPnWOOrJRPge/Te6sN9Cq5W0QM
         kuZCpppMj7/rPo1mK502CBWKBpRazvowvPpobQhb9aGPedBBlAnzrJ2v5yGJ99I3NG
         mtyCw3Y4NRtCJ7JrW4F0mdkLCRbjR56eh2xg4KPU=
Received: by mail-wm1-f51.google.com with SMTP id u16so30873054wmc.5
        for <linux-kernel@vger.kernel.org>; Wed, 13 May 2020 21:57:25 -0700 (PDT)
X-Gm-Message-State: AGi0PubsWLtteJVaW0euEhMC+56RLHkS4AzJygkjEFNe2dBlAlYImYW0
        8PC3exxQAPqGl8yylYjDjF6o/8xrbi5V+mtrP7k/Hg==
X-Google-Smtp-Source: APiQypKrIQvWFM7EQquJSqdEwgN5VUXbceYvnW5X+NMjZi66eekOuooPwPJgNozPSGt3hk+XzJQjmP7IJXx9UvGuW2Q=
X-Received: by 2002:a1c:2bc2:: with SMTP id r185mr22240467wmr.49.1589432244035;
 Wed, 13 May 2020 21:57:24 -0700 (PDT)
MIME-Version: 1.0
References: <20200505134926.578885807@linutronix.de> <20200505135313.410702173@linutronix.de>
In-Reply-To: <20200505135313.410702173@linutronix.de>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Wed, 13 May 2020 21:57:12 -0700
X-Gmail-Original-Message-ID: <CALCETrUYs65iSW5eeNLMtdAWuHFbg_ywE32whSh0kJ9JVZCbVw@mail.gmail.com>
Message-ID: <CALCETrUYs65iSW5eeNLMtdAWuHFbg_ywE32whSh0kJ9JVZCbVw@mail.gmail.com>
Subject: Re: [patch V4 part 4 01/24] x86/int3: Ensure that poke_int3_handler()
 is not traced
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

On Tue, May 5, 2020 at 7:15 AM Thomas Gleixner <tglx@linutronix.de> wrote:
>
> From: Thomas Gleixner <tglx@linutronix.de>
>
> In order to ensure poke_int3_handler() is completely self contained -- this
> is called while modifying other text, imagine the fun of hitting another
> INT3 -- ensure that everything it uses is not traced.
>
> The primary means here is to force inlining; bsearch() is notrace because
> all of lib/ is.


Acked-by: Andy Lutomirski <luto@kernel.org>
