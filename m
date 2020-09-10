Return-Path: <SRS0=87nF=CT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53ABFC433E2
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 17:13:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EFF33214F1
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 17:13:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XG1F0moH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726987AbgIJRM5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Sep 2020 13:12:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726612AbgIJRLf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 13:11:35 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D631BC061573
        for <linux-kernel@vger.kernel.org>; Thu, 10 Sep 2020 10:11:34 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id o5so7546576wrn.13
        for <linux-kernel@vger.kernel.org>; Thu, 10 Sep 2020 10:11:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=e7jefh25XCKZfPoIkRNxN7N4Tflp0SqsV/tI/tWYRzk=;
        b=XG1F0moHLQKlC3AzqilBlzA2HA0fK1G/k0lQDl+t35aFaRzrjooU2skfOKLerx6Zpr
         aU6YzU6ZJZ/zKaE8xcC+nNp0VAcKbPZuR5BZHuXK1f46JHA+yueimFnO63xfUaOObu2B
         a6KEqTqY8qvD8imR7OJy2tdob5sN4dHzBtqQ9OFtO1alOVwWU8wjmOzFcHO9bjUwDMCP
         872eO5nSO78xuXnQhncEZ1VUIIBsbB/7ORAtpx+i3CAvAnubYuxfBiDBrQh0RNYa1vGH
         pl2FeosyK0AxyAbc10rEw4avzsAxWRxIcKVeMMKiOA8kETxcpqtVxC1B/Uy1nrGlciAA
         Eetg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=e7jefh25XCKZfPoIkRNxN7N4Tflp0SqsV/tI/tWYRzk=;
        b=kUDg8S6fUWGzMEZ+bpIbwa2iXixlDi+uHF0mkZk2yIDJ2K3bKJK3NKWSeXvCMWVSbB
         ipHBBrdUwgkuJt6bA3bNcb4hxSM+B8XF7te4BKgHXTPKAPNK26VRrWqO2JE1eslCwYqY
         E2iTPWqnY3P99e+OMRck9JZ1Y46kNDa7Xrzh4xAc3hnQqy4kvMRLQD80oSm2z1wRSMq0
         JpslwVhGW8NXmqeOfcr9S/R4YNAUTPTLKWmqL8Ho/TD+tHQLuxLlMH10AjgtddgWkOJB
         D3hCNRWM49xkXIqLqTS4rnJa4HqLE32q5HXldQpfcPCNRkwMmt0Mm7kxIsZEdcmAbnZG
         q5dw==
X-Gm-Message-State: AOAM532LME/rRDRD81LMKKIgRm5POzYyMIycjIxqgFQFl7NacMatOR2E
        VLokipGDqQn/5K0iddA7WQlXp+PI56Tii/JQ0N/KVw==
X-Google-Smtp-Source: ABdhPJwtHTt5kfroDQYT7AFrVej7dGgwjf21yW5MaYlzGNNQRhDz4YP5JrYn6cWgBC7NRLjptYY2REfgsATBs5jY8V0=
X-Received: by 2002:adf:82b1:: with SMTP id 46mr10891426wrc.271.1599757893281;
 Thu, 10 Sep 2020 10:11:33 -0700 (PDT)
MIME-Version: 1.0
References: <20200908044228.61197-1-namhyung@kernel.org> <20200910155736.jadhmqvnqquammpn@two.firstfloor.org>
In-Reply-To: <20200910155736.jadhmqvnqquammpn@two.firstfloor.org>
From:   Ian Rogers <irogers@google.com>
Date:   Thu, 10 Sep 2020 10:11:21 -0700
Message-ID: <CAP-5=fUp90QrY+HcetpgZJeUn2fSqndRCZ8f1m=rFcEwO7ZZew@mail.gmail.com>
Subject: Re: [PATCHSET 0/4] perf stat: Add --multiply-cgroup option
To:     Andi Kleen <andi@firstfloor.org>
Cc:     Namhyung Kim <namhyung@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Stephane Eranian <eranian@google.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 10, 2020 at 8:57 AM Andi Kleen <andi@firstfloor.org> wrote:
>
> On Tue, Sep 08, 2020 at 01:42:24PM +0900, Namhyung Kim wrote:
> > When we profile cgroup events with perf stat, it's very annoying to
> > specify events and cgroups on the command line as it requires the
> > mapping between events and cgroups.  (Note that perf record can use
> > cgroup sampling but it's not usable for perf stat).
>
> The problem is real, but I don't really like your solution.
> The option is ugly. Should rather be solved with some suitable
> syntax in the expression parser to express: apply to all,
> instead of adding adhoc options like this.
>
> There are some additional problems that really need to be eventually
> solved too:
>
> - If you use the old syntax and some cgroups are not covered you don't
> get any warning. At least that should be fixed too.
>
> - And of course if everything works it is still very slow for the kernel
> because there are so many perf events to handle. Long term we probably
> need some more flexible way to just specify for given perf events which set of
> cgroups they should apply, so that sharing and low overhead monitoring
> of many cgroups is possible I hate to say it, but maybe some eBPF filter
> is the solution here.
>
> -Andi

Just to throw in some 2c worth. A nice thing about Namhyung's approach
is that it can apply for metrics, events and pfm-events. It would be
nice if there were a single option for specifying these, perhaps we
can figure one out.

One thought that came to mind based on Namhyung's multiply name was
and assuming a cgroup could be a modifier:

perf record -e cycles:G1

there could be equivalent to a new syntax of lists and multiplies of:

perf record -e [cycles]*[:G1]

This would allow expressions like:

perf record -e [{instructions,cycles},branches]*[:u,:k]

which would be equivalent to (showing the effect on sibling groups):

perf record -e {instructions:u,cycles:u},branches:u,{instructions:k,cycles:k},branches:k

Adding in cgroups makes a longer list of events:

perf record -e [{instructions,cycles},branches]*[:u,:k]*[:G1,:G2]

becomes:

perf record -e {instructions:u:G1,cycles:u:G1},branches:u:G1,{instructions:k:G1,cycles:k:G1},branches:k:G1,{instructions:u:G2,cycles:u:G2},branches:u:G2,{instructions:k:G2,cycles:k:G2},branches:k:G2

This is somewhat similar to Arnaldo's proposal but trying to make
things a bit more generic, avoiding overloading the use of sibling
groups, .. Perhaps there is a syntax that others prefer or could be
borrowed from a familiar source like a programming language.

I think for Namhyung's sake it is important not to get too distracted
by desires for better syntax, as this change makes a benefit in a way
that works with the existing flags. If it is accepted, the man pages
need to be updated.

Thanks,
Ian
