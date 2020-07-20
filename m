Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3537DC433E3
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 10:02:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 104DD21775
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 10:02:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="K2aqumUd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728321AbgGTKCF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 06:02:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728068AbgGTKCF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 06:02:05 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9A0EC061794
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jul 2020 03:02:04 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id u64so1406072qka.12
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jul 2020 03:02:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kNLa6DbnfflJZxio7nSoVpRAmped/CM3Jii16qxVH8o=;
        b=K2aqumUdkdkfWL/WYFdjPmHUIvgHuNnWbTcfybXEQ4Zy6ZPVO1psAQmo7+ngmfIt4l
         Sd/u9JIsXTWPhh3+BVQVSLWWU7tOHhjy1NAVlqxdNVvqXm6+DfpxGxS6uAQ8LZxSbn8e
         NwwcQSG6rEKDdFqiRsx/BG0S209IJFGWa6Ssa0aFH6pO8NsIDczigZZj69zoGVRrLrQP
         m8JiFvks0s4/GZYPKbInqB6lbq00tf5WTmDLDFbB0APim8tOjgmJja7j2B1/zNHuPypi
         H8Cbou2UgEMew6AYrkfPpytek4j+Jr0HW9E17sOXSdPjMg/HLD3sphM+nJ5HnNx2kBXv
         7Rtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kNLa6DbnfflJZxio7nSoVpRAmped/CM3Jii16qxVH8o=;
        b=m+BYWyi+i+h/VB3bxfW9i5BpYRgE55/e3APYwqeno7zMHgNOhvDMpz9esRIpSBXRCz
         sqHJRKSlD/Ge4v47iok4Xja25kkH3YOMSMkn/hivvo5kgB4pDFM1aCE+iNu8AKK1Jjfi
         2PuTvAJDZmy7Xqrf1VuObtsQ+EnDME17/7WleKeoKlaUhx/LeI5nBdpfgPgwVcmTedYd
         6nTufd4eciqYoGYffsjYMqJuZSTpI6LUmBgeZRtUm9K7ayx1TcMrbW92yqY70DhhpJlb
         eznw+KVwMazO9KQRgvU4ucZ5ySXkM2M2popHcMJawKY3Zd6BHeUNh0QkILTIykjif/5Q
         C5xg==
X-Gm-Message-State: AOAM5304g3dsnsl45Pily5Y+E/OKSFwuhdvw3Zjp8CdUbWRX0ONxLq+4
        xGWhskQaVkPvgrtSTSKku6Q1N0nIA0SZwTTyrB030g==
X-Google-Smtp-Source: ABdhPJzlce5APbWJyB4AjCjel5XdAzH6UzQF2gHKUEDGUyjuBdib2NK5LkhoTosWYdLfpJ8LgV+piw7KtWUQXAL2/Eo=
X-Received: by 2002:a37:4e58:: with SMTP id c85mr21469654qkb.8.1595239323431;
 Mon, 20 Jul 2020 03:02:03 -0700 (PDT)
MIME-Version: 1.0
References: <20200709132344.760-1-john.ogness@linutronix.de>
 <20200709132344.760-5-john.ogness@linutronix.de> <20200718121053.GA691245@elver.google.com>
 <20200719034312.GA566736@jagdpanzerIV.localdomain> <20200720064303.GA2144711@elver.google.com>
 <20200720084102.GC463@jagdpanzerIV.localdomain> <CANpmjNPbnwmHyif79MaXdA478UGUKysB=u=HmtBiD10PPPTEcw@mail.gmail.com>
In-Reply-To: <CANpmjNPbnwmHyif79MaXdA478UGUKysB=u=HmtBiD10PPPTEcw@mail.gmail.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Mon, 20 Jul 2020 12:01:51 +0200
Message-ID: <CACT4Y+ZjpFYKosvGNPPWYyfZaAh6+Gieh4zKH2JzdVmkhPCg6Q@mail.gmail.com>
Subject: Re: [PATCH v5 4/4] printk: use the lockless ringbuffer
To:     Marco Elver <elver@google.com>
Cc:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        John Ogness <john.ogness@linutronix.de>,
        Petr Mladek <pmladek@suse.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrea Parri <parri.andrea@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Paul McKenney <paulmck@kernel.org>, kexec@lists.infradead.org,
        LKML <linux-kernel@vger.kernel.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 20, 2020 at 11:41 AM Marco Elver <elver@google.com> wrote:
>
> On Mon, 20 Jul 2020 at 10:41, Sergey Senozhatsky
> <sergey.senozhatsky@gmail.com> wrote:
> >
> > On (20/07/20 08:43), Marco Elver wrote:
> > > On Sun, Jul 19, 2020 at 12:43PM +0900, Sergey Senozhatsky wrote:
> > >
> > > As I said, a number of debugging tools use them to format reports to be
> > > more readable (visually separate title and report body, and separate
> > > parts of the report). Also, such reports are often parsed by CI systems,
> > > and by changing the reports, these CI systems may break. But those are
> > > just the usecases I'm acutely aware of
> >
> > Can you give example of such CI systems? // that's a real question //
>
> None of ours should break; I agree the CI system is brittle if it
> relies on newlines. Parsed and displayed reports are changing, however
> -- what irks me is now all the reports sent to the LKML look ugly.
>
> Some random KASAN reports (just compare formatting):
> next (ugly): https://lore.kernel.org/lkml/000000000000c87b7305aadb6dba@google.com/
> mainline (normal):
> https://lore.kernel.org/lkml/000000000000f4ef6a05aa92ec6c@google.com/
>
> The same problem exists with lockdep reports, KCSAN reports, ... If
> newline-printks to insert blank lines are now banned, what are we to
> do? Send dozens of patches to switch everyone to printk(" \n")? Or
> some better suggestion? I cannot yet see how that is an improvement.
> (And if the behaviour is not reverted, please document the new
> behaviour.)
>
> That also doesn't yet address the ~400 other newline-printk users, and
> somebody needs to do the due diligence to understand if it's just a
> flush, or an intentional blank line.


Empty lines improve readability of long crash reports significantly.
New lines in sanitizer reports originated in Go race reports 7 years
ago and then spread to user-space ASAN/MSAN/TSAN b/c that was an
improvement and then were specifically added to kernel sanitizers.
This is even more important now that we have up to 5 stacks in KASAN
reports.
Please keep them.

Also having lots of printk("\n") sprinkled in kernel code and turning
them into no-op separately does not look like the right solution.
These printk("\n") are confusing and add clutter. A better solution
would be to remove these printk("\n") from the code. But this also
naturally allows selective removal. Say, keeping for sanitizers and
some other cases, but removing some that are not useful.
