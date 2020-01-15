Return-Path: <SRS0=7RkH=3E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 433B8C33CB3
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 09:45:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 18C002187F
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 09:45:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579081549;
	bh=TQOb4zgeCXG3lBNI7fgMzGAxcDUV9hyEnYwNbb9G8e4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=vCgZyoLqqgIcGZM3RwXPrstnsSHZNWEHnze5f7I+lIFJaGRiFX2RuKivqqlHqncdj
	 qw2Gb4dIJ+HoIOxxaPWp56iS0Jcj+o/Qs4q7QGbwjsBVzqMG/sTE53kiZEd1wz5o/0
	 pfrXqUss2XtW4Oo0uCjy1wsHz1PAufxiFGrFmTGY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729563AbgAOJps (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jan 2020 04:45:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:44476 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729505AbgAOJps (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jan 2020 04:45:48 -0500
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 28DB124655;
        Wed, 15 Jan 2020 09:45:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579081546;
        bh=TQOb4zgeCXG3lBNI7fgMzGAxcDUV9hyEnYwNbb9G8e4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=hX+lvCddJsSUCpId4xv9CqcR1fy1caHO+eqxJuoYSRyBOG5GE69c5XVkebnAsbl4o
         hRCkoMPC3oObsW6MerzPqLPDhnN1g++ssNP/xrFE3X4os8kdm5urcKN2NOXalziwlR
         lKk7LGBMvE2QVo0b+sJ+2QcZWP7pCm0PJMFTn79o=
Date:   Wed, 15 Jan 2020 18:45:38 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Alexey Budankov <alexey.budankov@linux.intel.com>
Cc:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
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
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 2/9] perf/core: open access for CAP_SYS_PERFMON
 privileged process
Message-Id: <20200115184538.bb8604e914dcc0eaeaf357fd@kernel.org>
In-Reply-To: <257a949a-b7cc-5ff1-6f1a-34bc44b1efc5@linux.intel.com>
References: <c0460c78-b1a6-b5f7-7119-d97e5998f308@linux.intel.com>
        <c93309dc-b920-f5fa-f997-e8b2faf47b88@linux.intel.com>
        <20200108160713.GI2844@hirez.programming.kicks-ass.net>
        <cc239899-5c52-2fd0-286d-4bff18877937@linux.intel.com>
        <20200110140234.GO2844@hirez.programming.kicks-ass.net>
        <20200111005213.6dfd98fb36ace098004bde0e@kernel.org>
        <20200110164531.GA2598@kernel.org>
        <20200111084735.0ff01c758bfbfd0ae2e1f24e@kernel.org>
        <2B79131A-3F76-47F5-AAB4-08BCA820473F@fb.com>
        <5e191833.1c69fb81.8bc25.a88c@mx.google.com>
        <158a4033-f8d6-8af7-77b0-20e62ec913b0@linux.intel.com>
        <20200114122506.3cf442dc189a649d4736f86e@kernel.org>
        <CAADnVQLCtrvvagbbkZG4PyAKb2PWzUouxG3=nxvm8QdpgEWtGQ@mail.gmail.com>
        <81abaa29-d1be-a888-8b2f-fdf9b7e9fde8@linux.intel.com>
        <CAADnVQKddDCRV9Zp7N_TR51wc5rtRwFN-pSZHLiXDXe23+B_5Q@mail.gmail.com>
        <257a949a-b7cc-5ff1-6f1a-34bc44b1efc5@linux.intel.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 14 Jan 2020 21:50:33 +0300
Alexey Budankov <alexey.budankov@linux.intel.com> wrote:

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

OK, anyway, for higher security, admin may not give CAP_SYS_PERFMON to
unpriviledged users, since it might allows users to analyze kernel, which
can lead security concerns.

> Sure, software cannot guarantee, but known software bugs could still be fixed,
> that's what I meant.

Agreed, bugs must be fixed anyway.

Thank you,

> > imo adding a cap just for pmc is pointless.
> > if you add a new cap it should cover all of sys_perf_event_open syscall.
> > subdividing it into sw vs hw counters, kprobe create vs enable, etc will
> > be the source of ongoing confusion. nack to such cap.
> > 
> 
> Well, as this patch set already covers complete perf_event_open functionality,
> and also eBPF related parts too, could you please review and comment on it?
> Does the patches 2/9 and 5/9 already bring all required extentions?
> 
> Thanks,
> Alexey


-- 
Masami Hiramatsu <mhiramat@kernel.org>
