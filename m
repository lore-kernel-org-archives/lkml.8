Return-Path: <SRS0=sqqi=7C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28DF8C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 00:30:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DCAF320708
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 00:30:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589934658;
	bh=IdKlOjcnp7gTR0MZGzUExPCTFZFEUt8s/UCERCdITGs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=DLN9rq/2cbu90Jo7V2+mAA4FcyczrVcojyWCj+palOvo9KbQkqfENmOVqFUD6v3If
	 Hhy/CAmYs9KjrIJ5zbR/mChDjm3aMe9D2lbbkikQRMiPOMxOXjX4z0ZbK5nmm/8Q0O
	 fa4uJKc+2wWj7lOp6dm7i2eXFs3eQ+ok5s7e7ca0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728465AbgETAa6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 May 2020 20:30:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:43216 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728371AbgETAav (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 20:30:51 -0400
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 15A0D20873
        for <linux-kernel@vger.kernel.org>; Wed, 20 May 2020 00:30:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589934651;
        bh=IdKlOjcnp7gTR0MZGzUExPCTFZFEUt8s/UCERCdITGs=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=JX874BmGZAM6sq3Jy8T6kJcVyduKrKeFsEDJjle2fiVIRQsrwySWEvYs/8ExrgrU9
         GBzdA0eakOcBHgqCJwN+PsM5Wa/mCz573a9QZPxSzKMVy7xJ8aChCcNeXCr3B4ygL7
         Na1X/M2y/y/PTGQRS2ln21T2acH8ZDQvaNhElftA=
Received: by mail-wr1-f45.google.com with SMTP id v12so1288179wrp.12
        for <linux-kernel@vger.kernel.org>; Tue, 19 May 2020 17:30:51 -0700 (PDT)
X-Gm-Message-State: AOAM532/uLjoIC6v/B5YSJ8Dg2t6M+vDdR3eNymROXRQ1+8iwX+HXbL3
        vZUoSNuDZ6/BYdNw9gR5sPZSxtpnoqaBF3IsSiqnmg==
X-Google-Smtp-Source: ABdhPJz4SScRClG9+FY2bdUwrH/CT8Xfngef2cn9NrEmrWVCgU07Mg4YFEOVXkx9MZElnCTDh4UFQEwNs40GWJ96Ylw=
X-Received: by 2002:adf:fe45:: with SMTP id m5mr1411855wrs.257.1589934649517;
 Tue, 19 May 2020 17:30:49 -0700 (PDT)
MIME-Version: 1.0
References: <20200515234547.710474468@linutronix.de> <20200515235127.007113214@linutronix.de>
In-Reply-To: <20200515235127.007113214@linutronix.de>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Tue, 19 May 2020 17:30:38 -0700
X-Gmail-Original-Message-ID: <CALCETrU4fu-GokwC5jUshwQ2e84qAj_+HJc7gKsdA7Ra=-iTGw@mail.gmail.com>
Message-ID: <CALCETrU4fu-GokwC5jUshwQ2e84qAj_+HJc7gKsdA7Ra=-iTGw@mail.gmail.com>
Subject: Re: [patch V6 26/37] x86/entry: Convert various system vectors
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
> Convert various system vectors to IDTENTRY_SYSVEC
>   - Implement the C entry point with DEFINE_IDTENTRY_SYSVEC
>   - Emit the ASM stub with DECLARE_IDTENTRY_SYSVEC
>   - Remove the ASM idtentries in 64bit
>   - Remove the BUILD_INTERRUPT entries in 32bit
>   - Remove the old prototypes
>
> No functional change.

Acked-by: Andy Lutomirski <luto@kernel.org>
