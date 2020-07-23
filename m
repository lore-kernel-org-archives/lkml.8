Return-Path: <SRS0=Rqeb=BC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75761C433EC
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 09:14:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 43CDF22BEF
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 09:14:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="KKpKKbbE";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="/NlnNn3/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728296AbgGWJOo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jul 2020 05:14:44 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:56480 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725911AbgGWJOn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jul 2020 05:14:43 -0400
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1595495682;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=V2ZK9/Df1B3F90/1wjoCaVFTYcpJBDi10j1OGUy5dnQ=;
        b=KKpKKbbEfyMcoyJpK6W9IaKitQ4a+4w4HvNli5SJQQSjag+4dCCmgJim58f9YEdTCeNwJW
        N0FU+dtille3S+mlEzs+FANAhh6ixjYqEngK/BFAFRJ9lzrQrIiYphSSoP+OOoMNbNgxgK
        T1ZajApV/5T1ua9CAgx1MXsh0DTu9OKx2bdvMF5uKnpSBuKI4BkemAk7GHqOiG5A38qggA
        Ss5vp81lE67Ys+v7WPbACgT0Cms3zcXLT/CYBLkyeEjO9Ube4KPEZbXpXKKvmYnlJYyV+7
        g3+JYPqIdEkyPoJodc7R25XJfFjVt+8uVvC9knf0VKOnr0FkuBdXe7mRnN3OKg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1595495682;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=V2ZK9/Df1B3F90/1wjoCaVFTYcpJBDi10j1OGUy5dnQ=;
        b=/NlnNn3/JeOA7lIaX6+hR0YBEWA11djJnxyA5bFSWWmCbG1mG4uaveUbtO7FF+sd0y3udL
        OQG3KWVMR85jdsCg==
To:     Nick Desaulniers <ndesaulniers@google.com>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>
Cc:     Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>,
        Christoph Lameter <cl@linux.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com,
        Nick Desaulniers <ndesaulniers@google.com>,
        Arnd Bergmann <arnd@arndb.de>,
        David Woodhouse <dwmw2@infradead.org>,
        Dmitry Golovin <dima@golovin.in>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH v3 11/11] x86: support i386 with Clang
In-Reply-To: <20200720204925.3654302-12-ndesaulniers@google.com>
References: <20200720204925.3654302-1-ndesaulniers@google.com> <20200720204925.3654302-12-ndesaulniers@google.com>
Date:   Thu, 23 Jul 2020 11:14:41 +0200
Message-ID: <87365izj7i.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Nick Desaulniers <ndesaulniers@google.com> writes:

I'm glad I looked myself at this.

> We also don't want to swap the use of "=q" with "=r". For 64b, it
> doesn't matter. For 32b, it's possible that a 32b register without a 8b
> lower alias (i.e. ESI, EDI, EBP) is selected which the assembler will
> then reject.

The above is really garbage.

We don't want? It's simply not possible to do so, because ...

64b,32b,8b. For heavens sake is it too much asked to write a changelog
with understandable wording instead of ambiguous abbreviations?

There is no maximum character limit for changelogs.

Thanks,

        tglx
