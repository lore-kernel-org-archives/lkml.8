Return-Path: <SRS0=2JZx=64=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B771C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 04:54:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4B878206D4
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 04:54:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589432069;
	bh=oy4/lv8AHd9PGxhDOzHaStidBms4v7G3TT6ctDddErY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=ZVHWfyA7uV6f7bV4rBszFKvLGjmqgcQQzO/YM+ifaO6PIqAjQJ3L9bLxEha2DJOHe
	 QmH04SKQXXwEUO0tB+XUKpGlmDVtU3myWkSm4oxIZ8eLhq/44qRsIqLUhqBUce3sCS
	 30N+orX7vEkMsWAX0SyusX5xRIjPNB8Nf/6R9xoU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726022AbgENEy2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 May 2020 00:54:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:38654 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725794AbgENEy2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 May 2020 00:54:28 -0400
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 48C5D2074A
        for <linux-kernel@vger.kernel.org>; Thu, 14 May 2020 04:54:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589432067;
        bh=oy4/lv8AHd9PGxhDOzHaStidBms4v7G3TT6ctDddErY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=NIdEIJ2Gz55uzRbDUMMmx24pcprVGuLa56NqcDWA2XMGw5FdSxliO7X2RhwCGuZlN
         ddSdUZcciOjJueVs+NZve9+wA7lWaLPtvSjmRR5y66hiJczBUMc7c8xFgh0jXzE4i7
         d2WQ9Qsc0DumGuvyZpuuydvYrI7MGEi3C/puK0Hk=
Received: by mail-wr1-f42.google.com with SMTP id w7so2071624wre.13
        for <linux-kernel@vger.kernel.org>; Wed, 13 May 2020 21:54:27 -0700 (PDT)
X-Gm-Message-State: AOAM533MlVOJUo55puHE9h9yjZwcClrNvsHy3Jxcmqp+RRhpqsPnFzaZ
        W9pDqxJANaKdOAL4W/6fFirdZFwvjJMLYx+eBvRIow==
X-Google-Smtp-Source: ABdhPJxd5aoScdXGSuKSUmruTwCo7by6+0UEqYlRYkSsPc2ywHg14tk9+UkW3t2uK9a8zXb1d5zTfAs9gEIIRtXwJ5o=
X-Received: by 2002:adf:f446:: with SMTP id f6mr3054627wrp.75.1589432065359;
 Wed, 13 May 2020 21:54:25 -0700 (PDT)
MIME-Version: 1.0
References: <20200505134354.774943181@linutronix.de> <20200505134906.128769226@linutronix.de>
In-Reply-To: <20200505134906.128769226@linutronix.de>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Wed, 13 May 2020 21:54:14 -0700
X-Gmail-Original-Message-ID: <CALCETrXNt4A8Gp-24Awgg+PFL2qwa20JKhFiYWbbnV1RefST4Q@mail.gmail.com>
Message-ID: <CALCETrXNt4A8Gp-24Awgg+PFL2qwa20JKhFiYWbbnV1RefST4Q@mail.gmail.com>
Subject: Re: [patch V4 part 3 29/29] x86/entry/32: Convert IRET exception to IDTENTRY_SW
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

On Tue, May 5, 2020 at 7:15 AM Thomas Gleixner <tglx@linutronix.de> wrote:
>
> From: Thomas Gleixner <tglx@linutronix.de>
>
> Convert the IRET exception handler to IDTENTRY_SW. This is slightly
> different than the conversions of hardware exceptions as the IRET exception
> is invoked via an exception table when IRET faults. So it just uses the
> IDTENTRY_SW mechanism for consistency. It does not emit ASM code as it does
> not fit the other idtentry exceptions.

Blech.  I should redo the 32-bit code to handle this the way the
64-bit code does and this can all be deleted.  But, for now:


Acked-by: Andy Lutomirski <luto@kernel.org>

However, maybe rename asm_exc_iret_error to avoid confusion?  It's not
really an exception entry.
