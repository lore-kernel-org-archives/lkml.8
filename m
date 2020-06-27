Return-Path: <SRS0=QqoS=AI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3A85C433DF
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Jun 2020 23:26:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 722182081A
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Jun 2020 23:26:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aYg4T2ji"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726726AbgF0X0I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Jun 2020 19:26:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726101AbgF0X0H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Jun 2020 19:26:07 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40CC3C061794
        for <linux-kernel@vger.kernel.org>; Sat, 27 Jun 2020 16:26:07 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id o11so12887969wrv.9
        for <linux-kernel@vger.kernel.org>; Sat, 27 Jun 2020 16:26:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=L4+B/5zRE6IlLNMawmOgQqKjyJjPtaf685ecf8wNhZ4=;
        b=aYg4T2jiVER7HPDQvi5XvY9tVi8U9mOpXgtzHE7zAx4mkd+JICwXTookoWRRZ9evnR
         WE6BP8j+c9rn+1LcxC7r6khQHfhwHKaJzpizkuwOuJP3HDY3npp90nZNhVCdvKFQnEhc
         nuK/tIfqPw1FRdxAKzb2FgKxXuQv46Hwoy5uy4VYn9RoswbT/ytPZzatiPRNlT/IOTTW
         +XXD9cctfl549JLoLpLR+AQVz7O0x8pe2f9YWP0s3T0IJcQUmNJdIzXa0tF55dHQXUR5
         O6Y/7UUbp6WQl/GC/hAoGt8olpw+fS6fC2op2WD0n3dY2fUtjMMPc3pst3hy9s02QQ/y
         qSGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=L4+B/5zRE6IlLNMawmOgQqKjyJjPtaf685ecf8wNhZ4=;
        b=bR0apNsgplZFN1Vq65OFwOnBTqOQHtfBNvSccCoIay5l9HTV9XF9JZ5dir7qe+whIa
         +SFBXQXIdTcPDE3dNu6/vdRxUyIRMIgbTYrsGh9ifGQdFa4YRz+dJm4J/3ResvOiEZqA
         a7QKSa6KpWL9MlCPxliuOqUbDtDOoFQC7Bc1OQgz9VTsHZgV9GYhakFg0UFzP/MgS/wf
         WqeAqAn9VfOyKyOf2FwSZZzNhaaGDyA3YgrAJPlTyJOqBLgang2BB/1bQ7yYx/SFWZSE
         UkM96Pza3P5lhAriySllOSZhDo56MEuCMIgMgq3nanDfdKPgi7BXGrkVBL+3AcGJ4Bup
         s0yQ==
X-Gm-Message-State: AOAM530BbGl9tHPPIlwRFaSQ4Ay1b9xw/CZfYfe8NStAJ7a20//oXbdk
        xgVCNujcQ1cM6QwiI1Ir7R9f36rpJCLEr8nG5kMrMpdG
X-Google-Smtp-Source: ABdhPJyX9erD70E2ASM3OudQcXPpzudIpg7Ycu3QUmrxsXDgqA7NlKnSee2DU1kTpllx4IMSOC3Hc6DTbJ5l9u4Wvp4=
X-Received: by 2002:a5d:4bd2:: with SMTP id l18mr10155439wrt.119.1593300365558;
 Sat, 27 Jun 2020 16:26:05 -0700 (PDT)
MIME-Version: 1.0
References: <20200626194720.2915044-1-jolsa@kernel.org> <20200626212522.GF818054@tassilo.jf.intel.com>
 <CAP-5=fVMs4Ok3=gYmzheNTzbBUGGHbCr0cpJSm9TV45aeZb4Ng@mail.gmail.com>
 <20200626215759.GG818054@tassilo.jf.intel.com> <20200627124821.GF29008@kernel.org>
In-Reply-To: <20200627124821.GF29008@kernel.org>
From:   Ian Rogers <irogers@google.com>
Date:   Sat, 27 Jun 2020 16:25:54 -0700
Message-ID: <CAP-5=fXxrNVfiCd6pVmM9BPErXcVU4PKgX8Fvbzq63H=xh=2Hw@mail.gmail.com>
Subject: Re: [RFC 00/10] perf tools: Add support to reuse metric
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Andi Kleen <ak@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Michael Petlan <mpetlan@redhat.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        John Garry <john.garry@huawei.com>,
        "Paul A. Clarke" <pc@us.ibm.com>,
        Stephane Eranian <eranian@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 27, 2020 at 5:48 AM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> Em Fri, Jun 26, 2020 at 02:57:59PM -0700, Andi Kleen escreveu:
> > > The name could be a metric or an event, the logic for each is quite
> >
> > I would say collisions are unlikely. Event names follow quite structured
> > patterns.
>
> And when introducing a new metric the build process can detect that
> clash and fail.
>
> > > different. You could look up an event and when it fails assume it was
> > > a metric, but I like the simplicity of this approach.
>
> > I don't think it's simpler for the user.
>
> Agreed.
>
> > > Maybe this
> > > change could be adopted more widely with something like "perf stat -e
> > > metric:IPC -a -I 1000" rather than the current "perf stat -M IPC -a -I
> > > 1000".
> >
> > I thought about just adding metrics to -e, without metric: of course.
>
> Ditto.

Thanks, while we're thinking about this I'd like there to be support
for flags on metrics. Such as 'perf stat -M IPC:u ...' where the ':u'
is specifying user only as with events.

Fwiw, another point of pain is lining up events with cgroups. Being
able to have the cgroup be a flag on an event or metric would be nice.

Ian

> - Arnaldo
