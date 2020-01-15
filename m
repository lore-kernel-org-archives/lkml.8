Return-Path: <SRS0=7RkH=3E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39E47C33C9E
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 01:52:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E799E214AF
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 01:52:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uFZWzzez"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728927AbgAOBw0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jan 2020 20:52:26 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:33511 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728834AbgAOBwZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jan 2020 20:52:25 -0500
Received: by mail-lf1-f66.google.com with SMTP id n25so11444991lfl.0
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jan 2020 17:52:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oXKHVjTE5Nw21ta6HwRqU340V5Tey9xgPPm24w/G8F8=;
        b=uFZWzzezm1sxsihg6k6KhkykaB23jIOQIkig6kbKFlK5U6GqfHyB2fkMZN5Zk+Tj6j
         RNJ2GTG+s0hBPXd26F2uc70+F5P7XGfJal5n0wDC5YO9p+iDZM+rTSjag6G1aEMyxJnJ
         zvMZ/R/+1vKHf6qMLHL30Nnw+kJU1Bpf9UCXrIBwfG/45wDx/xlczRrCtPXxjgsXp2QN
         IQfphm1NiQAZRJRKZwCxPU3QZEvkrXQzu2dCKuNMQbF7tl921A2Zvp/MmOCPEfz3r98s
         KouGGxrLiDGmBEAahPL1BtzsBlnHHROHInGcW/7VOgUBDOql3C0P2eDD4zN/jn70e18i
         Kmjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oXKHVjTE5Nw21ta6HwRqU340V5Tey9xgPPm24w/G8F8=;
        b=BIj7bOt4wn7X6oaSTq1KamLSEnrIG5BpdohTj8UOtNAbjlurOXC/1OhOAkRSzpuTtt
         9kMW538fXKJSsbJ/zIKJTjJJGfQtwiUogHCyvsRpG19K9REWu3IBpr0WkabOWiVctyph
         1Jz5oxesuWVfjZH5mdg03mgBncFFsdhhQaL2QSlI9JBNF4dpFyTcNxoDFLRuPYLMbelj
         dV0wdX846BkxiJhUhS2m7zK/vwMcKYDaCVxJdZ9DHIi9IDkpHCtfGPW5jDR+2H1x7+FT
         HMdUSyxkiKgsiDC3awV21uKiXw8n4SC4nd+7yNfba5pkOlUWiU/T0AGE479XYnHUG9Xb
         6hRg==
X-Gm-Message-State: APjAAAXXQMi+/EIhDYkE0svENvljQzbBa8FCFDVt0GtYEEamxMDk/7Oj
        yXwgvR2RSEmMovsgTG3H1f7ukMsQVZdaU5FI6+4=
X-Google-Smtp-Source: APXvYqxFd/oWVtEm5RMNMIQ9+twlJ4/Kwq9RcbH9xDtn0cWjS8Y4CV4Hc4zNoEeGna8TvYzAsyokvzxEsp12mWzebTg=
X-Received: by 2002:ac2:4422:: with SMTP id w2mr3324584lfl.178.1579053142405;
 Tue, 14 Jan 2020 17:52:22 -0800 (PST)
MIME-Version: 1.0
References: <c0460c78-b1a6-b5f7-7119-d97e5998f308@linux.intel.com>
 <c93309dc-b920-f5fa-f997-e8b2faf47b88@linux.intel.com> <20200108160713.GI2844@hirez.programming.kicks-ass.net>
 <cc239899-5c52-2fd0-286d-4bff18877937@linux.intel.com> <20200110140234.GO2844@hirez.programming.kicks-ass.net>
 <20200111005213.6dfd98fb36ace098004bde0e@kernel.org> <20200110164531.GA2598@kernel.org>
 <20200111084735.0ff01c758bfbfd0ae2e1f24e@kernel.org> <2B79131A-3F76-47F5-AAB4-08BCA820473F@fb.com>
 <5e191833.1c69fb81.8bc25.a88c@mx.google.com> <158a4033-f8d6-8af7-77b0-20e62ec913b0@linux.intel.com>
 <20200114122506.3cf442dc189a649d4736f86e@kernel.org> <CAADnVQLCtrvvagbbkZG4PyAKb2PWzUouxG3=nxvm8QdpgEWtGQ@mail.gmail.com>
 <81abaa29-d1be-a888-8b2f-fdf9b7e9fde8@linux.intel.com> <CAADnVQKddDCRV9Zp7N_TR51wc5rtRwFN-pSZHLiXDXe23+B_5Q@mail.gmail.com>
 <257a949a-b7cc-5ff1-6f1a-34bc44b1efc5@linux.intel.com>
In-Reply-To: <257a949a-b7cc-5ff1-6f1a-34bc44b1efc5@linux.intel.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Tue, 14 Jan 2020 17:52:10 -0800
Message-ID: <CAADnVQKSb8ZEq7mG0XwGx_btLxoEU5XDTu_p6eseDGuO-G+5tw@mail.gmail.com>
Subject: Re: [PATCH v4 2/9] perf/core: open access for CAP_SYS_PERFMON
 privileged process
To:     Alexey Budankov <alexey.budankov@linux.intel.com>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        Song Liu <songliubraving@fb.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        "jani.nikula@linux.intel.com" <jani.nikula@linux.intel.com>,
        "joonas.lahtinen@linux.intel.com" <joonas.lahtinen@linux.intel.com>,
        "rodrigo.vivi@intel.com" <rodrigo.vivi@intel.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        "james.bottomley@hansenpartnership.com" 
        <james.bottomley@hansenpartnership.com>,
        Serge Hallyn <serge@hallyn.com>,
        James Morris <jmorris@namei.org>,
        Will Deacon <will.deacon@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Robert Richter <rric@kernel.org>, Jiri Olsa <jolsa@redhat.com>,
        Andi Kleen <ak@linux.intel.com>,
        Stephane Eranian <eranian@google.com>,
        Igor Lubashev <ilubashe@akamai.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Andy Lutomirski <luto@amacapital.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 14, 2020 at 10:50 AM Alexey Budankov
<alexey.budankov@linux.intel.com> wrote:
>
>
> On 14.01.2020 21:06, Alexei Starovoitov wrote:
> > On Tue, Jan 14, 2020 at 1:47 AM Alexey Budankov
> > <alexey.budankov@linux.intel.com> wrote:
> >>>>
> >>>> As we talked at RFC series of CAP_SYS_TRACING last year, I just expected
> >>>> to open it for enabling/disabling kprobes, not for creation.
> >>>>
> >>>> If we can accept user who has no admin priviledge but the CAP_SYS_PERFMON,
> >>>> to shoot their foot by their own risk, I'm OK to allow it. (Even though,
> >>>> it should check the max number of probes to be created by something like
> >>>> ulimit)
> >>>> I think nowadays we have fixed all such kernel crash problems on x86,
> >>>> but not sure for other archs, especially on the devices I can not reach.
> >>>> I need more help to stabilize it.
> >>>
> >>> I don't see how enable/disable is any safer than creation.
> >>> If there are kernel bugs in kprobes the kernel will crash anyway.
> >>> I think such partial CAP_SYS_PERFMON would be very confusing to the users.
> >>> CAP_* is about delegation of root privileges to non-root.
> >>> Delegating some of it is ok, but disallowing creation makes it useless
> >>> for bpf tracing, so we would need to add another CAP later.
> >>> Hence I suggest to do it right away instead of breaking
> >>> sys_perf_even_open() access into two CAPs.
> >>>
> >>
> >> Alexei, Masami,
> >>
> >> Thanks for your meaningful input.
> >> If we know in advance that it still can crash the system in some cases and on
> >> some archs, even though root fully controls delegation thru CAP_SYS_PERFMON,
> >> such delegation looks premature until the crashes are avoided. So it looks like
> >> access to eBPF for CAP_SYS_PERFMON privileged processes is the subject for
> >> a separate patch set.
> >
> > perf_event_open is always dangerous. sw cannot guarantee non-bugginess of hw.
>
> Sure, software cannot guarantee, but known software bugs could still be fixed,
> that's what I meant.
>
> > imo adding a cap just for pmc is pointless.
> > if you add a new cap it should cover all of sys_perf_event_open syscall.
> > subdividing it into sw vs hw counters, kprobe create vs enable, etc will
> > be the source of ongoing confusion. nack to such cap.
> >
>
> Well, as this patch set already covers complete perf_event_open functionality,
> and also eBPF related parts too, could you please review and comment on it?
> Does the patches 2/9 and 5/9 already bring all required extentions?

yes. the current patches 2 and 5 look good to me.
I would only change patch 1 to what Andy was proposing earlier:

static inline bool perfmon_capable(void)
{
if (capable_noaudit(CAP_PERFMON))
  return capable(CAP_PERFMON);
if (capable_noaudit(CAP_SYS_ADMIN))
  return capable(CAP_SYS_ADMIN);

return capable(CAP_PERFMON);
}
I think Andy was trying to preserve the order of audit events.

I'm also suggesting to drop SYS from the cap name. It doesn't add any value
to the name.
