Return-Path: <SRS0=sD2I=AF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60714C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 17:25:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 377C5212CC
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 17:25:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XEvBsXA4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405471AbgFXRZv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jun 2020 13:25:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405318AbgFXRZu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 13:25:50 -0400
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21B6AC061573
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jun 2020 10:25:49 -0700 (PDT)
Received: by mail-lf1-x144.google.com with SMTP id g2so1724048lfb.0
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jun 2020 10:25:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=V6tWQqT52wylP/JH88Myhi4OlexSJw9zpdaP4552z9c=;
        b=XEvBsXA4f1vGjDuptjsYSs9/a0ZEBQ6Tdm3ZCOnQ13GBZNcdgsyTrfDxoaCYSzC0NT
         W64485xGJ5Moz/nJfDrdU5P69uu3kfDXZPDnngCYZpIcrQMTjXDX3I/+AiK6a1WcuRed
         N8NCjO48gpfDRGKZ0bFXjWcrL5RTZmAxl5wYZc6U7JVZlwkPmDdq2GiZ5orXFfmYNjkZ
         tkQzfRXuOh52DnkLfXXpQ3PkDlVcb/QAGnogZoLOgsmdyuo4zlpxTqtjW46l+RxcALWw
         5Nra8lvsaM/PqfLxkmlRlvfYLIS/QJ94zbeROBLOz0b0vNryDHFRmQ09ZWUKICtLxN1n
         XOzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=V6tWQqT52wylP/JH88Myhi4OlexSJw9zpdaP4552z9c=;
        b=DhTGXg2lx1PeHxZ+NM5xm5/2FItHZtHapXX2w6osK3bP2n1ft3TrasD7Vvc+xdKszC
         x8XJRmyCTc8VU7tqplAdsceXR6BkkzjKkQvdvANhAyflY7Xz2voe9t4eHFqa1aHPh7rn
         sEwQQnUXQnXhEouWXTB3I3wVF5vmQc9fLHRMqTNVDiObo+lLpSFFG6sxfs1sZIM9e471
         X4zBQ6KZaFw2EX6/EN/nB+VTVsRgOzqgpDSZ2W6CeaEjX7jhwrN+rsT45pdiN1EYo3Pg
         O2XgY+KSDpLc2gcoTnWPPkCm+QIvMJzE8pT4F6SWz5sHC6s7UrwsGsOezX0voP6HsrrY
         6mpA==
X-Gm-Message-State: AOAM530/1NaZ6+Cd3+F8/DB4mguwnmA4Bv9eqZ2VQJRJMmMPEJRENo2n
        /AUpBXxbSbfhsVI0vLWtx08K2+kJnbicZssNS/U=
X-Google-Smtp-Source: ABdhPJxSVNVgt1Ha/ydkdexPv3kBOyHIwIjxPSUkNAFEmM8KzKstSoFkbhMzp0xvNGPuVktKR8u+1hMVZh3fJ341/nk=
X-Received: by 2002:a05:6512:54d:: with SMTP id h13mr16163673lfl.8.1593019547540;
 Wed, 24 Jun 2020 10:25:47 -0700 (PDT)
MIME-Version: 1.0
References: <20200624084524.259560-1-drinkcat@chromium.org> <20200624120408.12c8fa0d@oasis.local.home>
In-Reply-To: <20200624120408.12c8fa0d@oasis.local.home>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Wed, 24 Jun 2020 10:25:35 -0700
Message-ID: <CAADnVQKDJb5EXZtEONaXx4XHtMMgEezPOuRUvEo18Rc7K+2_Pw@mail.gmail.com>
Subject: Re: [PATCH] kernel/trace: Add TRACING_ALLOW_PRINTK config option
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Nicolas Boichat <drinkcat@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Peter Zijlstra <peterz@infradead.org>,
        Vinod Koul <vkoul@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Tiezhu Yang <yangtiezhu@loongson.cn>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Guilherme G . Piccoli" <gpiccoli@canonical.com>,
        Will Deacon <will@kernel.org>, dianders@chromium.org,
        Guenter Roeck <groeck@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 24, 2020 at 9:07 AM Steven Rostedt <rostedt@goodmis.org> wrote:
>
> On Wed, 24 Jun 2020 16:45:24 +0800
> Nicolas Boichat <drinkcat@chromium.org> wrote:
>
> > trace_printk is only meant as a debugging tool, and should never be
> > compiled into production code without source code changes, as
> > indicated by the warning that shows up on boot if any trace_printk
> > is called:
> >  **   NOTICE NOTICE NOTICE NOTICE NOTICE NOTICE NOTICE   **
> >  **                                                      **
> >  ** trace_printk() being used. Allocating extra memory.  **
> >  **                                                      **
> >  ** This means that this is a DEBUG kernel and it is     **
> >  ** unsafe for production use.                           **
> >
> > If this option is set to n, the kernel will generate a build-time
> > error if trace_printk is used.
> >
> > Signed-off-by: Nicolas Boichat <drinkcat@chromium.org>
>
> Interesting. Note, this will prevent modules with trace_printk from
> being loaded as well.

Nack.
The message is bogus. It's used in production kernels.
bpf_trace_printk() calls it.
