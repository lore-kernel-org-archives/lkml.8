Return-Path: <SRS0=PJcK=74=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1424C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 14:35:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7B22620679
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 14:35:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="dt0mlxnY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730642AbgFOOf5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jun 2020 10:35:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728326AbgFOOf4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 10:35:56 -0400
Received: from merlin.infradead.org (unknown [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34DABC061A0E
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jun 2020 07:35:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=CNJqcR8O2MGARUu3ztkILAgDD+9fnJBIlgO1t0ryM7s=; b=dt0mlxnY4n62j+Mv9nWzG0NHIt
        GW7jHe0cvEGK/PGx78zFjelxRFOSgYF5DPbekiklRes1pvymE1cukvtIujxjGquOjJYgNBVZfafIx
        SZwLnDJJErabrmLdwmjEuwUKtM9N1snlkOJIoybprJuBLmDW282HTQ0e1xh2F5d4yLIyc12v+kzNO
        Br3OxdwBD6qUwEuewPhVY8U/3pKyTbpE8t4G48RnSjrv0xoGAaqGOQR0cKJivsY2+8Xg7F9GwvShn
        dYNt0KeTJSYaUyVgm/1pHhcYzxlFljQwsvsszM9L+1ysfiiL2QUtMYErSYTJAzzXVdn1D0a5GyBON
        6olVAOfQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jkqCr-0006Q2-GC; Mon, 15 Jun 2020 14:35:25 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id E119C301A32;
        Mon, 15 Jun 2020 16:35:23 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id C7117203B8172; Mon, 15 Jun 2020 16:35:23 +0200 (CEST)
Date:   Mon, 15 Jun 2020 16:35:23 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Marco Elver <elver@google.com>
Cc:     Dmitry Vyukov <dvyukov@google.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Alexander Potapenko <glider@google.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>
Subject: Re: [PATCH -tip v3 1/2] kcov: Make runtime functions
 noinstr-compatible
Message-ID: <20200615143523.GE2554@hirez.programming.kicks-ass.net>
References: <CACT4Y+Zwm47qs8yco0nNoD_hFzHccoGyPznLHkBjAeg9REZ3gA@mail.gmail.com>
 <CANpmjNPNa2f=kAF6c199oYVJ0iSyirQRGxeOBLxa9PmakSXRbA@mail.gmail.com>
 <CACT4Y+Z+FFHFGSgEJGkd+zCBgUOck_odOf9_=5YQLNJQVMGNdw@mail.gmail.com>
 <20200608110108.GB2497@hirez.programming.kicks-ass.net>
 <20200611215538.GE4496@worktop.programming.kicks-ass.net>
 <CACT4Y+aKVKEp1yoBYSH0ebJxeqKj8TPR9MVtHC1Mh=jgX0ZvLw@mail.gmail.com>
 <20200612114900.GA187027@google.com>
 <CACT4Y+bBtCbEk2tg60gn5bgfBjARQFBgtqkQg8VnLLg5JwyL5g@mail.gmail.com>
 <CANpmjNM+Tcn40MsfFKvKxNTtev-TXDsosN+z9ATL8hVJdK1yug@mail.gmail.com>
 <20200615142949.GT2531@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200615142949.GT2531@hirez.programming.kicks-ass.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 15, 2020 at 04:29:50PM +0200, Peter Zijlstra wrote:
> Let me go look at your KCSAN thing now...

vmlinux.o: warning: objtool: idtentry_enter_cond_rcu()+0x16: call to is_idle_task() leaves .noinstr.text section

---
diff --git a/include/linux/sched.h b/include/linux/sched.h
index b62e6aaf28f03..a7abc18a7d0ad 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1663,7 +1663,7 @@ extern struct task_struct *idle_task(int cpu);
  *
  * Return: 1 if @p is an idle task. 0 otherwise.
  */
-static inline bool is_idle_task(const struct task_struct *p)
+static __always_inline bool is_idle_task(const struct task_struct *p)
 {
 	return !!(p->flags & PF_IDLE);
 }
