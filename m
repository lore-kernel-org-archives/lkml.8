Return-Path: <SRS0=boYM=7Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25D8FC433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 12:09:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ECD8320679
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 12:09:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="G1QU3vuR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726141AbgFCMJP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jun 2020 08:09:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725854AbgFCMJO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jun 2020 08:09:14 -0400
Received: from mail-oi1-x243.google.com (mail-oi1-x243.google.com [IPv6:2607:f8b0:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8859BC08C5C0
        for <linux-kernel@vger.kernel.org>; Wed,  3 Jun 2020 05:09:14 -0700 (PDT)
Received: by mail-oi1-x243.google.com with SMTP id a21so1564459oic.8
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jun 2020 05:09:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CrQWsWD5f9oeeT83eEC6g4ZTyQnFkgomgZ4RHURPls8=;
        b=G1QU3vuRDgU7d9EFOz8Il6JhI0WYQ3SyhlHzhs2PnR2EVXIG4ZkaTyMQpiqkolTNKb
         3UBZ+cJTgq5MCTu6tIcMZXN+6Fhh3AMfljKDtofc7oJREvHUmNYpMjfLFAXI1JiaEMin
         fYJEltyVaasmgS7nL4+Ljm6cxC2kJnqAF2/dI9UgGKfO6ouUN4peo4Fi71FSLaw5JUQ2
         HRbVGJvr3l9NMIwD2UUAU3cSRhmNRTBTBZEo/rFUo6apLamKq1kI3RwLiDiqmQGt6CJY
         VUW0SUVqM28QTfpBh9W8k6LLcUFwYqfsZ0I/LXb8l8fADT6rtFm1ueuOXjityTH0LLgX
         UvPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CrQWsWD5f9oeeT83eEC6g4ZTyQnFkgomgZ4RHURPls8=;
        b=C4QQJLwseBHmDGBrvk/SzDUotkYtBBTKzTge8p4susDnNikTfBL4z/O4GB/K3k4Krj
         p/LSHLhlSctm2oDbREVzCC/cNn/Nzh6OW2AHWVLzLTfl5t8PB1nOes1YN6RHddK9tVCe
         luZemx15fpWgKc/xz1bnxuSHv8+rx4O0CFjFtSJjQpPS2hf0zh71ffVMNB3HACBAMgOg
         PNUyiSujZl2YhEahUtRJhCrG1gUODfulXHCPZsJlxTf9k8k31u9iG9NPn2wWXGlV4FFc
         5c8Klv+BAWwLlZNGKtUVG9Gygteny93YyKdIUw0Us91bWlDOFGyU18AQFLzDTLNOxLkI
         y0Xg==
X-Gm-Message-State: AOAM531ZtF/KdUa/OoIBrqC31lbWtpv9Qs0Awyh0cBmaHWIx8LhKWqDL
        pdbd9+TIDr9u4aw9F893iICOofH/IOlYMuXDtbV2Jg==
X-Google-Smtp-Source: ABdhPJxp8hoGIwSSFjosL+uHENxReOsBVLdShAhQxvchCh3kB2VaoWT/4mDpLnVNZcQu5J63pygpoOOsDgWv8Zs0Aks=
X-Received: by 2002:a05:6808:3ac:: with SMTP id n12mr4385422oie.172.1591186148832;
 Wed, 03 Jun 2020 05:09:08 -0700 (PDT)
MIME-Version: 1.0
References: <20200603114014.152292216@infradead.org> <20200603120037.GA2570@hirez.programming.kicks-ass.net>
 <20200603120818.GC2627@hirez.programming.kicks-ass.net>
In-Reply-To: <20200603120818.GC2627@hirez.programming.kicks-ass.net>
From:   Marco Elver <elver@google.com>
Date:   Wed, 3 Jun 2020 14:08:57 +0200
Message-ID: <CANpmjNOxLkqh=qpHQjUC_bZ0GCjkoJ4NxF3UuNGKhJSvcjavaA@mail.gmail.com>
Subject: Re: [PATCH 0/9] x86/entry fixes
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Will Deacon <will@kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 3 Jun 2020 at 14:08, Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Wed, Jun 03, 2020 at 02:00:37PM +0200, Peter Zijlstra wrote:
> > On Wed, Jun 03, 2020 at 01:40:14PM +0200, Peter Zijlstra wrote:
> > > The first patch is a fix for x86/entry, I'm quicky runing out of brown paper bags again :/
> > >
> > > The rest goes on top of these:
> > >
> > >   https://lkml.kernel.org/r/20200602173103.931412766@infradead.org
> > >   https://lkml.kernel.org/r/20200602184409.22142-1-elver@google.com
> > >
> > > patches from myself and Marco that enable *SAN builds. So far GCC-KASAN seen to
> > > behave quite well, I've yet to try UBSAN.
> >
> > GCC10 + UBSAN:
> >
> > vmlinux.o: warning: objtool: match_held_lock()+0x1b2: call to __ubsan_handle_type_mismatch_v1() leaves .noinstr.text section
> > vmlinux.o: warning: objtool: rcu_nmi_enter()+0x234: call to __ubsan_handle_out_of_bounds() leaves .noinstr.text section
> > vmlinux.o: warning: objtool: __rcu_is_watching()+0x59: call to __ubsan_handle_out_of_bounds() leaves .noinstr.text section
> >
> > All of them are marked noinstr. So I suppose UBSAN is just buggered in
> > GCC :-/
>
> CLANG11 + UBSAN:
>
> vmlinux.o: warning: objtool: exc_nmi()+0x1c3: call to __ubsan_handle_load_invalid_value() leaves .noinstr.text section
> vmlinux.o: warning: objtool: poke_int3_handler()+0x72: call to __ubsan_handle_load_invalid_value() leaves .noinstr.text section
> vmlinux.o: warning: objtool: mce_check_crashing_cpu()+0x71: call to __ubsan_handle_load_invalid_value() leaves .noinstr.text section
> vmlinux.o: warning: objtool: lock_is_held_type()+0x95: call to __ubsan_handle_out_of_bounds() leaves .noinstr.text section
> vmlinux.o: warning: objtool: rcu_nmi_enter()+0xba: call to __ubsan_handle_out_of_bounds() leaves .noinstr.text section
> vmlinux.o: warning: objtool: __rcu_is_watching()+0x2c: call to __ubsan_handle_out_of_bounds() leaves .noinstr.text section
>
> IOW, UBSAN appears to be completely hosed.

What is the .config you used? I somehow can't reproduce. I've applied
the patches on top of -tip/master.

Thanks,
-- Marco
