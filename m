Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBB1AC433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 09:41:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8EE86208E4
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 09:41:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cGw1MLyg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728268AbgGTJlI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 05:41:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728088AbgGTJlH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 05:41:07 -0400
Received: from mail-oi1-x242.google.com (mail-oi1-x242.google.com [IPv6:2607:f8b0:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3827C061794
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jul 2020 02:41:07 -0700 (PDT)
Received: by mail-oi1-x242.google.com with SMTP id x83so13916335oif.10
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jul 2020 02:41:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZlSWX3kEKIVtH3Ty/sQ1R+KtTQUTPa6eMcEinYxdwjs=;
        b=cGw1MLyg8nvEL2n5ObAVNMtFCCDs4tRZwFLvRut5ODbQeKh3ZN1feqi80KP/0+weXA
         zo/VbZgcLyQwKaeQw0fYG6sx2I8QjriLT4flEyy4c16kW4WEtYhcC8IeR0aDf3NNjpyZ
         hxkYfMZaWGurvdgZB0m7CWT/eMwL9+ZnYOUBsbRTVVjLlSllTkLS40RiyXzx6LhE88ge
         DBF6sXuhKoelMt07Ocgsf6yXVb44/rkOuM1kVyciCDwHm10kFptpxoPf5MNW7WEWJCWW
         y/2K6eGWHt5uHb5EYJcex9nMM5s3h1zJrOimRejUsM0VtOfwmrfZI14IeWv8jUMIZJ9L
         qWEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZlSWX3kEKIVtH3Ty/sQ1R+KtTQUTPa6eMcEinYxdwjs=;
        b=N9SnzNziTtLa9IulvOnymOtoCQJTHN5er0QgRZH7cGtryE5m6oryf/uDmrIMy0IEOX
         yZha4iVy2u040T3apFyAV7K/Ua3nAbTxIKtcENu1y3t8FMGz+OSjOF1OxZZyiMlKcTuv
         kuUfPU/glXbaHGGYmc9awfr3KEJ/97/smkU2JK+jFe6a7TPNj2vdALa+AF37lktmgZX4
         8hMxX2o+nRyGV6ibVNVUJdf3NPIY0dODQQr8MaFZ1XriYB2cLSiHYs1P67sZ2hwWvFaY
         iKkGwkQh+vYkHq3FVn3T7CFgAZHzCHVALU+YgM9HQpTPx0hblxD11iwnO9fbkEk/EVB/
         UI9Q==
X-Gm-Message-State: AOAM5317+WiEUCo8AdnVyffsCuHQk5fVyFX/vfiwMiE7fqd2xNCanUvN
        d0WRn2o1DQvIRt+KbgxDDOioLZLuojTLqOnPa3Egrg==
X-Google-Smtp-Source: ABdhPJw7Rpzewc4ms74dHaYrrggRaeNJqLHtIwdbLvxFsTbeqVUEjiuDarE9DlHUbYMVVBXXtBHfY7qNOkAXLP5EHi0=
X-Received: by 2002:aca:cf4f:: with SMTP id f76mr17083895oig.172.1595238066764;
 Mon, 20 Jul 2020 02:41:06 -0700 (PDT)
MIME-Version: 1.0
References: <20200709132344.760-1-john.ogness@linutronix.de>
 <20200709132344.760-5-john.ogness@linutronix.de> <20200718121053.GA691245@elver.google.com>
 <20200719034312.GA566736@jagdpanzerIV.localdomain> <20200720064303.GA2144711@elver.google.com>
 <20200720084102.GC463@jagdpanzerIV.localdomain>
In-Reply-To: <20200720084102.GC463@jagdpanzerIV.localdomain>
From:   Marco Elver <elver@google.com>
Date:   Mon, 20 Jul 2020 11:40:52 +0200
Message-ID: <CANpmjNPbnwmHyif79MaXdA478UGUKysB=u=HmtBiD10PPPTEcw@mail.gmail.com>
Subject: Re: [PATCH v5 4/4] printk: use the lockless ringbuffer
To:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Cc:     John Ogness <john.ogness@linutronix.de>,
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
        Dmitry Vyukov <dvyukov@google.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 20 Jul 2020 at 10:41, Sergey Senozhatsky
<sergey.senozhatsky@gmail.com> wrote:
>
> On (20/07/20 08:43), Marco Elver wrote:
> > On Sun, Jul 19, 2020 at 12:43PM +0900, Sergey Senozhatsky wrote:
> >
> > As I said, a number of debugging tools use them to format reports to be
> > more readable (visually separate title and report body, and separate
> > parts of the report). Also, such reports are often parsed by CI systems,
> > and by changing the reports, these CI systems may break. But those are
> > just the usecases I'm acutely aware of
>
> Can you give example of such CI systems? // that's a real question //

None of ours should break; I agree the CI system is brittle if it
relies on newlines. Parsed and displayed reports are changing, however
-- what irks me is now all the reports sent to the LKML look ugly.

Some random KASAN reports (just compare formatting):
next (ugly): https://lore.kernel.org/lkml/000000000000c87b7305aadb6dba@google.com/
mainline (normal):
https://lore.kernel.org/lkml/000000000000f4ef6a05aa92ec6c@google.com/

The same problem exists with lockdep reports, KCSAN reports, ... If
newline-printks to insert blank lines are now banned, what are we to
do? Send dozens of patches to switch everyone to printk(" \n")? Or
some better suggestion? I cannot yet see how that is an improvement.
(And if the behaviour is not reverted, please document the new
behaviour.)

That also doesn't yet address the ~400 other newline-printk users, and
somebody needs to do the due diligence to understand if it's just a
flush, or an intentional blank line.

Thanks,
-- Marco
