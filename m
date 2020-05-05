Return-Path: <SRS0=e3tL=6T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB6BEC47254
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 20:39:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C323620752
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 20:39:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RuljQ/OX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729096AbgEEUjN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 May 2020 16:39:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726350AbgEEUjN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 May 2020 16:39:13 -0400
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F41A5C061A0F
        for <linux-kernel@vger.kernel.org>; Tue,  5 May 2020 13:39:12 -0700 (PDT)
Received: by mail-io1-xd29.google.com with SMTP id k6so3061132iob.3
        for <linux-kernel@vger.kernel.org>; Tue, 05 May 2020 13:39:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=U45TDLYumc2/K0rnmrk5/wRM/urCIpyQBeo6bZOouHs=;
        b=RuljQ/OXfBBYKN9lpJ8XXeJiYlk1FhYn9x6V4lz4W1KkSG3Msg/Hj1FE8vRSUrQR8I
         hwctAfVQNnCkhN0nSW+x3PBdUbVh8w5S0GF1oOVChy8I/tl89l0FtOoHi8RcYGoHq6BI
         WbPMQ+kuqqyx2neS5AOouOSK5bU5O0OvTfSEQL7WesJmzVPGo98hEaJgcQmDOFPz2it7
         kDTNTULXLeB84GDsFfVHVQ1WfUAOFEr/WVRr9eN8+7MTZRHvx8Ojwn0s8JEjQoHYZ/P0
         O0lT6C1UOxBXWTg7BZe/YdU7tYB1U0pjCJCNCpsDvPbJ2EzcFADz2keanNQl0QT3vsKx
         NjCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=U45TDLYumc2/K0rnmrk5/wRM/urCIpyQBeo6bZOouHs=;
        b=IaCxA9PiHf34M0YbNqHQuq2NaO7J57Ztpb5hTHlFrffut5rS6kI0YlqXHLPxOd1YWv
         0JycscQ4EoaLB4OCxLZddIeSIrjTeM3ew/qVRYWLDDu0rRppnzwYsej3K9T/2yRvdrGZ
         QXdpUfSQ1kr8aMBA1Ik1pM5DmnScUS/qRHmn0tIIRHsHhvoCmjStWM8/wmTV1a2iLHnR
         Wfm1Co7HE2wkJKn7KITy/pLsUt9oPVb4dYjdqUKIRuPNR+snwsXqqvgAx5SJp7YFs0cE
         1P8CV4K57UyXmN8HBiAOTL9zOTN0De7KHti7Oz+xXewVlE+WHBd6KekUp5FadZxYCSbx
         r99A==
X-Gm-Message-State: AGi0PuYjmeo/kfYGDi67wxXUmSBW6hMEaQ/ecfJlAJzhy9kMb4F48J/h
        8mU1bG9xksiEiESVayQ/drHYG4jn6nRceG0OwQ==
X-Google-Smtp-Source: APiQypIk0WCHK9kEO+y8L1VfUzkH9XXDLuobjN6N2h7Z1cHDypNLP1MtLtTic9XWU3qTWIA3DoD4nCWJ9BkKtjd54lU=
X-Received: by 2002:a02:415:: with SMTP id 21mr5516935jab.126.1588711152291;
 Tue, 05 May 2020 13:39:12 -0700 (PDT)
MIME-Version: 1.0
References: <20200505131602.633487962@linutronix.de> <20200505134059.970057117@linutronix.de>
In-Reply-To: <20200505134059.970057117@linutronix.de>
From:   Brian Gerst <brgerst@gmail.com>
Date:   Tue, 5 May 2020 16:39:01 -0400
Message-ID: <CAMzpN2i9bZhxagk1dNhHpZmYyHjNiPQU_yRmwY9y85LemkNFNw@mail.gmail.com>
Subject: Re: [patch V4 part 1 19/36] x86/entry: Exclude low level entry code
 from sanitizing
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
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
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Will Deacon <will@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 5, 2020 at 10:13 AM Thomas Gleixner <tglx@linutronix.de> wrote:
>
> The sanitizers are not really applicable to the fragile low level entry
> code. code. Entry code needs to carefully setup a normal 'runtime'
> environment.
>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> ---
>  arch/x86/entry/Makefile |    8 ++++++++
>  1 file changed, 8 insertions(+)
>
> --- a/arch/x86/entry/Makefile
> +++ b/arch/x86/entry/Makefile
> @@ -3,6 +3,14 @@
>  # Makefile for the x86 low level entry code
>  #
>
> +KASAN_SANITIZE := n
> +UBSAN_SANITIZE := n
> +KCOV_INSTRUMENT := n
> +
> +CFLAGS_REMOVE_common.o = $(CC_FLAGS_FTRACE) -fstack-protector -fstack-protector-strong
> +CFLAGS_REMOVE_syscall_32.o = $(CC_FLAGS_FTRACE) -fstack-protector -fstack-protector-strong
> +CFLAGS_REMOVE_syscall_64.o = $(CC_FLAGS_FTRACE) -fstack-protector -fstack-protector-strong

Is this necessary for syscall_*.o?  They just contain the syscall
tables (ie. data).

--
Brian Gerst
