Return-Path: <SRS0=/Zd0=4O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D2F7C4BA21
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 19:31:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 18AEA24670
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 19:31:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fk3KALdk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727317AbgBZTbQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Feb 2020 14:31:16 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:35707 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727221AbgBZTbP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Feb 2020 14:31:15 -0500
Received: by mail-ed1-f68.google.com with SMTP id c7so221698edu.2
        for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2020 11:31:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tim9X+F9vYHdlPOoRw/qRUISublgBCciYQagSlRF/BQ=;
        b=fk3KALdk6grE6nY7sZB/mMhkpi/EHCV27nxRPV1AsjEZqMQpBreIX+rtoBJ44sqDsI
         vwaPGdgc9e+qyka2BcLNlAw6JmpyAGGFeMkNWbUTpaUbGv+vC490mp74n2El5r9njbus
         ZrytAHK6bEILXuEJk7nUY94hlCx9kNrpyoUxSmX6QzGbTH6kpoiNBAln+vygx0sG3UJd
         T5ZB/60MxFqThgIC7vlB7egYA6gXLZ+Np1G6L4KFxfD7ILoWF7nINBayxNrqJbENzIRx
         fMd+lYihMK62FUi+kkvaPGabjSMUzGSu9NiHxhrIG9ZUif+QJLbs1918ZJMIE1F52og8
         oTAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tim9X+F9vYHdlPOoRw/qRUISublgBCciYQagSlRF/BQ=;
        b=A6cGlpbumhoWFqpRAWUrWynAsVLo3Ecm5CkmgNu/XY1ZALDaI1vh3vduk+KRlV6A0q
         ddDHxGRMwr75pTBlg/6D2/KclfnWuvaoHqhd0NP0eSB6S7WqDusBrvSwvxFA7zBpr3NK
         zHOrxoRRzH5PmhkDf1mrTa5A5a01L/j62/mNDRK2lBw2HzPfD/z58RLC/dUoDJUTHAqO
         Gbm9bq5Y6aX7ueJy6V4xkI0Q2wi8nKyioaiAIPwrYVRbM8D68YyMCexoixXii1munKf3
         zqlvzm4iICBMB5eRW57J4qWKkqOef1sivVMvpzMNDOCOlREqPk706A1AK6T/JQMtBQQV
         TMNw==
X-Gm-Message-State: APjAAAX+366oR6lYNQykNw0eDivEBQwlIFjZ1fCDm7NLEvUEWO+QiHib
        Z2zbCI6DgOkvfLZZW37+st+ZHr0rkRT1rz+hps35hQ==
X-Google-Smtp-Source: APXvYqwmNhCu2uIrsQ/yh0E0Nvm1vihPuVgYoU5bhKWgxgTaUk6av22YZ6E1zy7BoNa+YEWmYIrDLkZXBKzLN79MMT8=
X-Received: by 2002:a17:906:b7c4:: with SMTP id fy4mr284770ejb.139.1582745473140;
 Wed, 26 Feb 2020 11:31:13 -0800 (PST)
MIME-Version: 1.0
References: <20200226134637.31670-1-lrizzo@google.com> <20200226134637.31670-2-lrizzo@google.com>
 <20200226161941.GZ18400@hirez.programming.kicks-ass.net>
In-Reply-To: <20200226161941.GZ18400@hirez.programming.kicks-ass.net>
From:   Luigi Rizzo <lrizzo@google.com>
Date:   Wed, 26 Feb 2020 11:31:01 -0800
Message-ID: <CAMOZA0LU_mGPre9gsJSZeG19fUjLWb+6xuG8-2yv5gJRHwWzqQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] kstats: kernel metric collector
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        naveen.n.rao@linux.ibm.com, ardb@kernel.org,
        Luigi Rizzo <rizzo@iet.unipi.it>,
        Paolo Abeni <pabeni@redhat.com>, giuseppe.lettieri@unipi.it,
        =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>,
        Jesper Dangaard Brouer <hawk@kernel.org>, mingo@redhat.com,
        acme@kernel.org, Steven Rostedt <rostedt@goodmis.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 26, 2020 at 8:19 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Wed, Feb 26, 2020 at 05:46:36AM -0800, Luigi Rizzo wrote:
> > kstats is a helper to accumulate in-kernel metrics (timestamps, sizes,
> > etc.) and show distributions through debugfs.
> > Set CONFIG_KSTATS=m or y to enable it.
> >
> > Creating a metric takes one line of code (and one to destroy it):
> >
> >   struct kstats *key = kstats_new("foo", 3 /* frac_bits */);
> >   ...
> >   kstats_delete(key);
> >
> > The following line records a u64 sample:
> >
> >   kstats_record(key, value);
> >
> > kstats_record() is cheap (5ns hot cache, 250ns cold cache). Samples are
> > accumulated in a per-cpu array with 2^frac_bits slots for each power
> > of 2. Using frac_bits = 3 gives about 30 slots per decade.
>
> So I think everybody + dog has written code like this, although I never
> bothered with the log2 based buckets myself. Nor have I ever bothered
> with doing a debugfs interface.

the above is perhaps one excellent argument to why it may deserve to be in:
so that people don't need to write the measurement code time and again,
or, as I have done myself multiple times, use some inferior hack (racy
counter, coarse buckets) or give up measuring things and rely on guessing.

> I find it very hard to convince myself something like this deserves to
> live upstream, vs. remaining in the local debug/hack toolbox.
>
> Tracing has an aggregator (histogram), you can dump the raw deltas, or
> you can hack up a custom aggregator in a few lines, or you do BPF if
> you're so inclined.

And this is possibly another good argument: sometimes the systems where it
would be interesting to collect data are not accessible to the developers with
skills to write the monitoring code and run a modified kernel.

cheers
luigi
