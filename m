Return-Path: <SRS0=PJcK=74=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44FB3C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 14:57:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1CDE920644
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 14:57:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="n5s0/8gx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730870AbgFOO52 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jun 2020 10:57:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730701AbgFOO50 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 10:57:26 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2E33C061A0E
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jun 2020 07:57:26 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id l17so15950116qki.9
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jun 2020 07:57:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=08f0E4d1bwVGcK92LZLgsimdGdtdg5Nb5qVsheDv8nM=;
        b=n5s0/8gxWICXkiIRyxsPMOCPRZJrLxXd4xZAL/CxAaJdn6OJHMv5ok3hbyF39WBwID
         Rgx4dhjj2T8iwG1zh5nMhNczVyUNWi3b0yoPtk3BXo6bYTg60Tdtl95IQcA0isMjNrzH
         bswHZN2ZrAyBQE2IacANevmn4h2KU9dYxKk8qGUlfmZcLRuk2ZK3Rwt309WQeZKw7f1p
         p8iDuj5QM8QGdiV062HLEk6tSHaF5qDPTwYCVq3g3vKuWfXAqKVPhWo72PEY/QfUSIWu
         MWvb1tCEcGg5IuP9v+zzp/QzXsbJdx3xGBbNCyGSFghyCtg1QSr/tB3myQIE00ReaG1B
         SPKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=08f0E4d1bwVGcK92LZLgsimdGdtdg5Nb5qVsheDv8nM=;
        b=lf+7Ji64IHufZhkV37ypgEw84mBRo5nkLBOKhkYdcCWp4O8u9Ul4dny6ytwEXn+xsV
         tv9Zse4t7nnJhAMCDL4IA61tJsQ60c05PgztdC5Em0PoxyWwoM4dtDvg2qP6mroKHiz9
         0i7LRvqijrzIW6FXHZ+58J6gbuYA9fcK6l6+OCRoDcyfUDw+B3YiryHkoR6ywDPCQ8F3
         sIIh0oXSj3nmT7lrap4Y2OPgSZd8kRMCJJexAv+VR2JzNGdlXqJRbgFhUQPY4M2XRfQt
         6Ksi7SvjOub9SGugzl55dGkccPXbqceotjtYbSEvw0LKEAwXd89Q3tRZ61rnIq2k3M5e
         WF2g==
X-Gm-Message-State: AOAM530ZdhGbMSbYd33B86SsdIFW2ht9/jC/DADvDtNy+YZxX7SszMpx
        qFftldYraVM79XUL0aPs+JKGKA==
X-Google-Smtp-Source: ABdhPJxpOsry1yNx7TCREH06ffr7AfMA7W0HDZ5XSNfs6PHbV7y78O6dcMIEw2EDUQIlx14femYuPg==
X-Received: by 2002:a37:4656:: with SMTP id t83mr15544636qka.126.1592233045781;
        Mon, 15 Jun 2020 07:57:25 -0700 (PDT)
Received: from lca.pw (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id e53sm12573062qtk.50.2020.06.15.07.57.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2020 07:57:25 -0700 (PDT)
Date:   Mon, 15 Jun 2020 10:57:18 -0400
From:   Qian Cai <cai@lca.pw>
To:     Marco Elver <elver@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        the arch/x86 maintainers <x86@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Will Deacon <will@kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@google.com>
Subject: Re: [PATCH 0/8] x86/entry: KCSAN/KASAN/UBSAN vs noinstr
Message-ID: <20200615145718.GA1091@lca.pw>
References: <20200604102241.466509982@infradead.org>
 <CANpmjNPEXdGV-ZRYrVieJJsA01QATH+1vUixirocwKGDMsuEWQ@mail.gmail.com>
 <CANpmjNP2ayM6Oehw08yFM4+5xTjXWcCT7P3u7FL=cCMxFJNkXw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANpmjNP2ayM6Oehw08yFM4+5xTjXWcCT7P3u7FL=cCMxFJNkXw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 15, 2020 at 12:07:34PM +0200, 'Marco Elver' via kasan-dev wrote:
> On Thu, 4 Jun 2020 at 13:01, Marco Elver <elver@google.com> wrote:
> >
> > On Thu, 4 Jun 2020 at 12:25, Peter Zijlstra <peterz@infradead.org> wrote:
> > >
> > > Hai,
> > >
> > > Here's the remaining few patches to make KCSAN/KASAN and UBSAN work with noinstr.
> >
> > Thanks for assembling the series!
> >
> > For where it's missing (1,2,3 and last one):
> >
> > Acked-by: Marco Elver <elver@google.com>
> 
> Where was this series supposed to go? I can't find it on any tree yet.
> 
> How urgent is this? Boot-test seems fine without this, but likely
> doesn't hit the corner cases. Syzbot will likely find them, and if we
> noticeably end up breaking various sanitizers without this, I'd
> consider this urgent.

Today's linux-next had a lot of those with this .config,

https://raw.githubusercontent.com/cailca/linux-mm/master/x86.config

Wondering if this patchset will cure them all?

vmlinux.o: warning: objtool: exc_invalid_op()+0x337: call to __asan_report_load8_noabort() leaves .noinstr.text section
vmlinux.o: warning: objtool: exc_double_fault()+0x217: call to __asan_report_store4_noabort() leaves .noinstr.text section
vmlinux.o: warning: objtool: exc_int3()+0x376: call to __asan_report_load8_noabort() leaves .noinstr.text section
vmlinux.o: warning: objtool: sync_regs()+0xcd: call to __asan_report_store_n_noabort() leaves .noinstr.text section
vmlinux.o: warning: objtool: fixup_bad_iret()+0x13a: call to __asan_report_load8_noabort() leaves .noinstr.text section
vmlinux.o: warning: objtool: exc_debug()+0x280: call to __asan_report_load4_noabort() leaves .noinstr.text section
vmlinux.o: warning: objtool: default_do_nmi()+0x233: call to __asan_report_load8_noabort() leaves .noinstr.text section
vmlinux.o: warning: objtool: exc_nmi()+0x67: call to __kasan_check_read() leaves .noinstr.text section
vmlinux.o: warning: objtool: poke_int3_handler()+0x3d1: call to __asan_report_load8_noabort() leaves .noinstr.text section
vmlinux.o: warning: objtool: mce_check_crashing_cpu()+0x60: call to __kasan_check_read() leaves .noinstr.text section
vmlinux.o: warning: objtool: mce_setup()+0x1c: call to memset() leaves .noinstr.text section
vmlinux.o: warning: objtool: do_machine_check()+0xd3: call to mce_rdmsrl() leaves .noinstr.text section
vmlinux.o: warning: objtool: exc_machine_check()+0x2a1: call to __asan_report_store4_noabort() leaves .noinstr.text section
vmlinux.o: warning: objtool: exc_page_fault()+0xc4e: call to __asan_report_load8_noabort() leaves .noinstr.text section
vmlinux.o: warning: objtool: lockdep_hardirqs_on()+0x3a9: call to __asan_report_store8_noabort() leaves .noinstr.text section
vmlinux.o: warning: objtool: lockdep_hardirqs_off()+0x24a: call to __asan_report_store8_noabort() leaves .noinstr.text section
vmlinux.o: warning: objtool: match_held_lock()+0x4df: call to __asan_report_load8_noabort() leaves .noinstr.text section
vmlinux.o: warning: objtool: lock_is_held_type()+0x230: call to __asan_report_store4_noabort() leaves .noinstr.text section
vmlinux.o: warning: objtool: debug_lockdep_rcu_enabled()+0xcd: call to __asan_report_load4_noabort() leaves .noinstr.text section
vmlinux.o: warning: objtool: rcu_dynticks_eqs_enter()+0x1c: call to __kasan_check_write() leaves .noinstr.text section
vmlinux.o: warning: objtool: rcu_dynticks_eqs_exit()+0x20: call to __kasan_check_write() leaves .noinstr.text section
vmlinux.o: warning: objtool: rcu_eqs_exit.constprop.72()+0x24d: call to __asan_report_load8_noabort() leaves .noinstr.text section
vmlinux.o: warning: objtool: rcu_eqs_enter.constprop.73()+0x250: call to __asan_report_load8_noabort() leaves .noinstr.text section
vmlinux.o: warning: objtool: rcu_nmi_exit()+0x1f2: call to __asan_report_load8_noabort() leaves .noinstr.text section
vmlinux.o: warning: objtool: rcu_irq_exit()+0xd1: call to __ubsan_handle_load_invalid_value() leaves .noinstr.text section
vmlinux.o: warning: objtool: rcu_nmi_enter()+0x184: call to __asan_report_load8_noabort() leaves .noinstr.text section
vmlinux.o: warning: objtool: rcu_irq_enter()+0xd1: call to __ubsan_handle_load_invalid_value() leaves .noinstr.text section
vmlinux.o: warning: objtool: __rcu_is_watching()+0x20: call to __kasan_check_read() leaves .noinstr.text section
vmlinux.o: warning: objtool: debug_locks_off()+0x19: call to __kasan_check_write() leaves .noinstr.text section
