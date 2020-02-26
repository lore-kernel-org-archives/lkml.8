Return-Path: <SRS0=/Zd0=4O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E2B5C4BA18
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 17:26:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CBF98222C2
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 17:26:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Oqz14OHi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726773AbgBZR0g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Feb 2020 12:26:36 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:43452 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726687AbgBZR0g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Feb 2020 12:26:36 -0500
Received: by mail-ed1-f66.google.com with SMTP id dc19so4718372edb.10
        for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2020 09:26:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=u6NFKZzpCKzAm09UV+6OqhLyyOr9a9s3KYdDjjgRVgU=;
        b=Oqz14OHitpVB9YhQkwhsBoBrMUI9vWzQrOJAlr4WSqNywbJDSzqm+UuHZx3oZJDV6v
         WVFKHshigY/3B9acvFOVldncB8OJVY3uIbMcOdZaDkmApMH5M7tUJbqNUjGmqp1dI5fB
         YxoWO9DfRSfweyNryHPcSbyLNXJrCAYkmMnidvqba2yVMP0jzINQF7v/ScwltfHcI4q5
         kdG/Y2g+jNgQoNqQfW4Qj+QkLtEQ7qbk715cJURbqWQcrSMiIlSk/LAADDVZo3hTa0rb
         jXkaAWbCqk0OQ8W+yjOdMerZYw8lk6us9SpoMN6lTu9E3yunpWHvxWpENmW+CAz0Xvz/
         qEyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=u6NFKZzpCKzAm09UV+6OqhLyyOr9a9s3KYdDjjgRVgU=;
        b=JwZoJkIw611HQaqZC59St8OKpvlTE45wt41RqvkcqeSZtMKsCcvKOi3RA0j+mfCms/
         FhptNf3qEZLaubCFvcF0XAz6EsIKaSuygQzCADPY/cvjSaU9cwQ34/T9w5N4w+RENWCN
         TF1vBSVwqM18Sukp6AWB0fNG4/9IxJdIvZ8Ii+D3+ERhpt2g690/KQ4qpcBTVqKGGt/q
         T+hodRFgLZclgog9bM+Rdqw0ScqwB/cp0XbRGiNKSs0u2mFl0uiJxk1Dy04h6qGy8w/5
         dFfiCFp80/tBSfcjj6S5IZULFEb7qxW5xjKS56CaUfI2kNSEnVFpxbK0evuFYj+Cgn9E
         vFCA==
X-Gm-Message-State: APjAAAUPB9Nlpr2qFGa+qTqykFcZrlB8/wSsYm65wB4OryUuqfDLQoze
        FBdMzE20Pzer5NGTuqwur4Fh1GIjoRnuwi5WB2xwvQ==
X-Google-Smtp-Source: APXvYqzA+U2tOD6ym1ptFsTq19xZniuF8RsVzypQKRFfH0LYNBF80/VOiS/C4U72OssZ+bLkwOjtgEDd0ofQrNDFuBg=
X-Received: by 2002:aa7:c2cb:: with SMTP id m11mr369181edp.89.1582737994055;
 Wed, 26 Feb 2020 09:26:34 -0800 (PST)
MIME-Version: 1.0
References: <20200226135027.34538-1-lrizzo@google.com> <87ftexz93y.fsf@toke.dk>
In-Reply-To: <87ftexz93y.fsf@toke.dk>
From:   Luigi Rizzo <lrizzo@google.com>
Date:   Wed, 26 Feb 2020 09:26:22 -0800
Message-ID: <CAMOZA0Lzf2r7rFvgBEWpf-B=wXvyED2CxfzuO7qUA_qVsNtL7g@mail.gmail.com>
Subject: Re: [PATCH v3 0/2] kstats: kernel metric collector
To:     =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>
Cc:     linux-kernel@vger.kernel.org,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        naveen.n.rao@linux.ibm.com, ardb@kernel.org,
        Luigi Rizzo <rizzo@iet.unipi.it>,
        Paolo Abeni <pabeni@redhat.com>, giuseppe.lettieri@unipi.it,
        Jesper Dangaard Brouer <hawk@kernel.org>, mingo@redhat.com,
        acme@kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        peterz@infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[this reply also addresses comments from Alexei and Peter]

On Wed, Feb 26, 2020 at 7:00 AM Toke H=C3=B8iland-J=C3=B8rgensen <toke@redh=
at.com> wrote:
>
> Luigi Rizzo <lrizzo@google.com> writes:
>
> > This patchset introduces a small library to collect per-cpu samples and
> > accumulate distributions to be exported through debugfs.
> >
> > This v3 series addresses some initial comments (mostly style fixes in t=
he
> > code) and revises commit logs.
>
> Could you please add a proper changelog spanning all versions of the
> patch as you iterate?

Will do (v2->v3 was just a removal of stray Change-Id from the log messages=
)

> As for the idea itself; picking up this argument you made on v1:
>
> > The tracepoint/kprobe/kretprobe solution is much more expensive --
> > from my measurements, the hooks that invoke the various handlers take
> > ~250ns with hot cache, 1500+ns with cold cache, and tracing an empty
> > function this way reports 90ns with hot cache, 500ns with cold cache.
>
> I think it would be good if you could include an equivalent BPF-based
> implementation of your instrumentation example so people can (a) see the
> difference for themselves and get a better idea of how the approaches
> differ in a concrete case and (b) quantify the difference in performance
> between the two implementations.

At the moment, a bpf version is probably beyond my skills and goals,
but I hope the
following comments can clarify the difference in approach/performance:

-  my primary goal, implemented in patch 1/2, is to have this code embedded=
 in
  the kernel, _always available_ , even to users without the skills to
hack up the
  necessary bpf code, or load a bpf program (which may not be allowed in
  certain environments), and eventually replace and possibly improve custom
  variants of metric collections which we already have (or wished to,
but don't have
  because there wasn't a convenient library to use for them).

- I agree that this code can be recompiled in bpf (using a
  BPF_MAP_TYPE_PERCPU_ARRAY for storage, and kstats_record() and
  ks_show_entry() should be easy to convert).

- the runtime cost and complexity of hooking bpf code is still a bit
unclear to me.
  kretprobe or tracepoints are expensive, I suppose that some lean hook
  replace register_kretprobe() may exist and the difference from inline
  annotations would be marginal (we'd still need to put in the hooks around
  the code we want to time, though, so it wouldn't be a pure bpf solution).
  Any pointers to this are welcome; Alexei mentioned fentry/fexit and
  bpf trampolines, but I haven't found an example that lets me do something
  equivalent to kretprobe (take a timestamp before and one after a function
  without explicit instrumentation)

- I still see some huge differences in usability, and this is in my opinion
  one very big difference between the two approaches. The systems where dat=
a
  collection may be of interest are not necessarily accessible to developer=
s
  with the skills to write custom bpf code, or load bpf modules
(security policies
  may prevent that). One thing is to tell a sysadmin to run
  "echo trace foo > /sys/kernel/debug/kstats/_config"
  or "watch grep CPUS /sys/kernel/debug/kstats/bar",
  another one is to tell them to load a bpf program (or write their own one=
).

thanks for the feedback
luigi
