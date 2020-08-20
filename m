Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B316C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 22:43:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 20AD820738
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 22:43:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597963403;
	bh=5xHB7attkpmdUNvdTySFDMgYf8GNV6BlGCYBOuLcHEc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=QdS9gSsakW2mCAacOVBRnhtZWpD1TgEhN4CDt1i6pPITH52jfMAon9A4oqxHkelp5
	 5RA8wZE7VzIGmwklSsmUqzsNUnqtngUoOh3jzorRbggHqyjDkjct/xsqsVXvBmz7xD
	 UD69Rpsld7O7MSCVkNKUjcSa+Bqiw8OGRL8dbLi4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728580AbgHTWnV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 18:43:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:45312 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728477AbgHTWnV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 18:43:21 -0400
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 248BA22B40
        for <linux-kernel@vger.kernel.org>; Thu, 20 Aug 2020 22:43:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597963400;
        bh=5xHB7attkpmdUNvdTySFDMgYf8GNV6BlGCYBOuLcHEc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=COYHVBXO3lN06Rb02cRiYn5f/fqzDSmlDtxTdw1OZp0e9jpSARPBBrCgxDlqxBLz8
         3zUefbTY6RZimHz3I2/okoRrPpv88Ovypw14zYVVXm/XzNuCCy22hRi0qNBQST53YK
         /tCG9XElPADBs8w74fIZAZbk6itbOWNkyAxd3fps=
Received: by mail-wr1-f44.google.com with SMTP id 88so189626wrh.3
        for <linux-kernel@vger.kernel.org>; Thu, 20 Aug 2020 15:43:20 -0700 (PDT)
X-Gm-Message-State: AOAM532AQUC/Th4z/vftcadPJQRJRURjHf7AXOUKKjUugPOW42inopCi
        oS0IJm/oyaXvnCmXvIOY+y6nnQlATI6gXDF1uFHXCw==
X-Google-Smtp-Source: ABdhPJyIgAqsMA8JsQyikj/7ZlGQn610nb8EEcUeoTdpgwBdv87N4yg0Jjwegi5kVutkq43iZp2VoPR538rleGH4AVg=
X-Received: by 2002:adf:cc88:: with SMTP id p8mr7829wrj.70.1597963398679; Thu,
 20 Aug 2020 15:43:18 -0700 (PDT)
MIME-Version: 1.0
References: <8b9bd05f187231df008d48cf818a6a311cbd5c98.1597882384.git.luto@kernel.org>
 <20200820084427.GO2674@hirez.programming.kicks-ass.net>
In-Reply-To: <20200820084427.GO2674@hirez.programming.kicks-ass.net>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Thu, 20 Aug 2020 15:43:07 -0700
X-Gmail-Original-Message-ID: <CALCETrXkZdR4Vvk1UXeWapHrBug+d6Nr-=VcbFHzw8PKzvLJCw@mail.gmail.com>
Message-ID: <CALCETrXkZdR4Vvk1UXeWapHrBug+d6Nr-=VcbFHzw8PKzvLJCw@mail.gmail.com>
Subject: Re: [PATCH] x86/debug: Allow a single level of #DB recursion
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Andy Lutomirski <luto@kernel.org>, X86 ML <x86@kernel.org>,
        Kyle Huey <me@kylehuey.com>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        "Robert O'Callahan" <rocallahan@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
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
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Will Deacon <will@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        stable <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 20, 2020 at 1:44 AM <peterz@infradead.org> wrote:
>
> On Wed, Aug 19, 2020 at 05:15:43PM -0700, Andy Lutomirski wrote:
> > +static __always_inline void debug_enter(unsigned long *dr6, unsigned long *dr7)
> > +{
> > +     *dr6 = debug_read_clear_dr6();
> >  }
> >
> >  static __always_inline void debug_exit(unsigned long dr7)
> >  {
> > -     local_db_restore(dr7);
> >  }
>
> That's all unused after this patch, might as well remove it.

Whoops.
