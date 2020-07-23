Return-Path: <SRS0=Rqeb=BC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8D71C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 09:17:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B3270206F4
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 09:17:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="IFX39bQo";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="apwUhPyj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728001AbgGWJRn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jul 2020 05:17:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725911AbgGWJRn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jul 2020 05:17:43 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6AE1C0619DC
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jul 2020 02:17:42 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1595495860;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=rDOwKC2fAP8MWrkPzgYFdS4Z3n00CBgEPZ5FRmy5cmw=;
        b=IFX39bQov/ALgcbGLQ0Eq8NHzQplhkLWOvUE9zO+xlmJcF6r3EaMQ1+17d7hetsoxBGDkH
        jTJvGZNruDrfDAxA20yDQSmbiOxBOQTiA+ZrhS7qq1CpO+EuC9k6nl77NqDALe0Bkh/JFr
        qjIvFfaSegIjoBrUvrgzR6uPbuy3GgRmIThRqM5GKXYDoVMuPZgFxVzncJFDsNkYPiBO3b
        jJGO1tMaHCvqmlUuVcGIfoXoXSstNA9w+AblvAfJgMTwTWbmKyUjcgycBPFK5LJUYQo1LP
        ZmO5XPm3R6vmWhJDRUpI/ppd+taKC+Ldi7IfccnhMgp8MxfEsRrXVnarzz99YQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1595495860;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=rDOwKC2fAP8MWrkPzgYFdS4Z3n00CBgEPZ5FRmy5cmw=;
        b=apwUhPyjVF5F9GP0Dxv1aCOOX9VvqUScT6Pg3fh1kw6pOyQ6nj0j+/91C8+QcZfY9iBk0f
        +bVNYbGLn7BUW8Cg==
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
In-Reply-To: <87365izj7i.fsf@nanos.tec.linutronix.de>
References: <20200720204925.3654302-1-ndesaulniers@google.com> <20200720204925.3654302-12-ndesaulniers@google.com> <87365izj7i.fsf@nanos.tec.linutronix.de>
Date:   Thu, 23 Jul 2020 11:17:39 +0200
Message-ID: <87zh7qy4i4.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thomas Gleixner <tglx@linutronix.de> writes:
> Nick Desaulniers <ndesaulniers@google.com> writes:
>
> I'm glad I looked myself at this.
>
>> We also don't want to swap the use of "=q" with "=r". For 64b, it
>> doesn't matter. For 32b, it's possible that a 32b register without a 8b
>> lower alias (i.e. ESI, EDI, EBP) is selected which the assembler will
>> then reject.
>
> The above is really garbage.
>
> We don't want? It's simply not possible to do so, because ...
>
> 64b,32b,8b. For heavens sake is it too much asked to write a changelog
> with understandable wording instead of ambiguous abbreviations?
>
> There is no maximum character limit for changelogs.

Gah. Hit send too fast.

>> With this, Clang can finally build an i386 defconfig.

With what? I can't find anything which explains the solution at the
conceptual level. Sigh.

Thanks,

        tglx

