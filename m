Return-Path: <SRS0=sqqi=7C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EFC3C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 00:53:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A76EC2083E
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 00:53:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589936015;
	bh=lZUrvUEDCNeobszGeVZYyzrpiv45sDdfQ8G7wyO8IEo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=BRZi8IGUVJLVPHHqF16vLGt0W7FWeHG+wVopvWx4zWT76GOXmBslZEt5NSyzAmzDV
	 DTYu2xcK6LG43A+EOHd2OCAQVdCWYFvwGM+nkCqIJXb+ugVSh6064kRHYdcQ5lrZd6
	 vX/CNZKQJ5htTwmI2nOBFT6ZorA1IjnJigTiDN6o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727941AbgETAxe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 May 2020 20:53:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:56440 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726178AbgETAxe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 20:53:34 -0400
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9F0C2208A9
        for <linux-kernel@vger.kernel.org>; Wed, 20 May 2020 00:53:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589936013;
        bh=lZUrvUEDCNeobszGeVZYyzrpiv45sDdfQ8G7wyO8IEo=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Hvz4Ay3cPWARCj3G13zLIuvuWXJAoIfezNMYmt2nSULAvm5TLy5pG43JlL7gsmIzi
         tvKTxE9wiScIO9wyKSf5jcA1DgJfsKJpO/l1TEeCzuPxzqP6NCzuL2hzjjGkbxuzjr
         qfoksc5bIgJff64WMKdU+9E6clRdGnh693N63HXw=
Received: by mail-wr1-f45.google.com with SMTP id g12so176960wrw.1
        for <linux-kernel@vger.kernel.org>; Tue, 19 May 2020 17:53:33 -0700 (PDT)
X-Gm-Message-State: AOAM531CqqKZYQGIj6vLbhFGPhCIVWsMFKuiDZO76BxAb4T8QUwk20rd
        O86neQcnDyoNPEW+deC+szBmhiIG+iWKDKZRIWnoKw==
X-Google-Smtp-Source: ABdhPJzF+mTRmQ54+M9zBw524imzaRoYqXi76n7IfGv7DAMcZfhTY6ltQ972gf3YQalk1sXUEOHVM1/t+lM4djBLSTc=
X-Received: by 2002:adf:eccf:: with SMTP id s15mr1528932wro.70.1589936011820;
 Tue, 19 May 2020 17:53:31 -0700 (PDT)
MIME-Version: 1.0
References: <20200515234547.710474468@linutronix.de> <20200515235127.996226788@linutronix.de>
In-Reply-To: <20200515235127.996226788@linutronix.de>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Tue, 19 May 2020 17:53:20 -0700
X-Gmail-Original-Message-ID: <CALCETrVwTZA6OwrMDhhaNgpkvwsn9ajfuwrfH6xYExvCsFcXjQ@mail.gmail.com>
Message-ID: <CALCETrVwTZA6OwrMDhhaNgpkvwsn9ajfuwrfH6xYExvCsFcXjQ@mail.gmail.com>
Subject: Re: [patch V6 36/37] x86/entry: Move paranoid irq tracing out of ASM code
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

On Fri, May 15, 2020 at 5:11 PM Thomas Gleixner <tglx@linutronix.de> wrote:
>

I think something's missing here.  With this patch applied, don't we
get to exc_debug_kernel() -> handle_debug() without doing
idtentry_enter() or equivalent?  And that can even enable IRQs.

Maybe exc_debug_kernel() should wrap handle_debug() in some
appropriate _enter() / _exit() pair?

--Andy
