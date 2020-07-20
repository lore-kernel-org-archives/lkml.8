Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C222AC433E3
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 09:23:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A1E602176B
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 09:23:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="jm0wsL/N";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="PhOAz/NP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728112AbgGTJXQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 05:23:16 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:56320 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728017AbgGTJXQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 05:23:16 -0400
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1595236993;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=g9BNAc85U7zjpSEDSfX62xvbyUEcp+gIOP471mP4nTA=;
        b=jm0wsL/NI+UtXEk9215WIQhOEpwW4iQZptuYBnRfUdN9VoE0HgdaQQciiNlYcYG6WkvR/F
        NxMF7kCpLhkU2Nw8tqyG7jHj0dltSxf57M9+WzCOHOCwEZufuEbt7v1j7neTIMsLjirP0R
        df1nWCPIY+LYytI1h5+2XP0nn0Y+6nRwtOHk7rPMFJZwhMyADGZ+M+IlyroTyryi7SzRZ/
        7YnJcBpxisaMFjqLA4/N9AkE0H0OQcrh6K/zLhHox/5JHAY57WDLbKF9Z/JJ43+GhKk53b
        VLIB++aFNksw2F9hRxu7IfjiCh8uzvulz2EZX+fB2YG06C1KpDZC0iHYsC3t7g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1595236993;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=g9BNAc85U7zjpSEDSfX62xvbyUEcp+gIOP471mP4nTA=;
        b=PhOAz/NPRfnvR/VW+21DZgtdobYVbCKiQuopwntd9GWEaikRV4Y6q7S5ncz/S60pmTn2dD
        vvQMaYZ5uDN+f1Bg==
To:     Andy Lutomirski <luto@kernel.org>,
        Gabriel Krisman Bertazi <krisman@collabora.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, kernel@collabora.com,
        Matthew Wilcox <willy@infradead.org>,
        Andrew Lutomirski <luto@kernel.org>,
        Paul Gofman <gofmanp@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        "open list\:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>, Shuah Khan <shuah@kernel.org>
Subject: Re: [PATCH v4 1/2] kernel: Implement selective syscall userspace redirection
In-Reply-To: <CALCETrWdCN5KsRUkrb8VoYGRBhy71P-MAHGWhuJ5y4Z3vByyvg@mail.gmail.com>
References: <20200716193141.4068476-1-krisman@collabora.com> <20200716193141.4068476-2-krisman@collabora.com> <CALCETrWdCN5KsRUkrb8VoYGRBhy71P-MAHGWhuJ5y4Z3vByyvg@mail.gmail.com>
Date:   Mon, 20 Jul 2020 11:23:13 +0200
Message-ID: <874kq2o7zy.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Andy Lutomirski <luto@kernel.org> writes:
> On Thu, Jul 16, 2020 at 12:31 PM Gabriel Krisman Bertazi
> <krisman@collabora.com> wrote:
> The amount of syscall entry wiring that arches need to do is IMO
> already a bit out of hand.  Should we instead rename TIF_SECCOMP to
> TIF_SYSCALL_INTERCEPTION and have one generic callback that handles
> seccomp and this new thing?

The right way to go is to consolidate all the stupidly different
entry/exit work handling implementations and have exactly one in generic
code, i.e. what I posted a few days ago.

Then we can make new features only available in the generic version by
hiding the new functionality in the core code and not exposing the
functions to architecture implementations.

Making it easy for architectures to keep their own variant forever just
proliferates the mess we have right now.

Thanks,

        tglx
