Return-Path: <SRS0=SogR=6O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C43EC83003
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 02:13:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 75FAD208E0
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 02:13:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gil1/AM6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726782AbgD3CNP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Apr 2020 22:13:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726489AbgD3CNP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Apr 2020 22:13:15 -0400
Received: from mail-ua1-x92f.google.com (mail-ua1-x92f.google.com [IPv6:2607:f8b0:4864:20::92f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B90CBC035494
        for <linux-kernel@vger.kernel.org>; Wed, 29 Apr 2020 19:13:13 -0700 (PDT)
Received: by mail-ua1-x92f.google.com with SMTP id g35so1786137uad.0
        for <linux-kernel@vger.kernel.org>; Wed, 29 Apr 2020 19:13:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=USpZ4pvwqIEUr9tEKnLX8PoBi7NAoOdDwbwdhvLZQWI=;
        b=gil1/AM6k3vg+GgdV5w9g3cDkn1i6NMpnW/cZERDAzGWTxkX9lv8Lel5nifSNzrEKx
         mKi1KNg/p5F4wcFNobIANFFOyl/2IEP6n0GaiSP3Ec3z3bKHuBL0J/P/cJBPPBWqKIQP
         hnwksTAzGnnQc0XMuRaokzlh0WKXqW3S3XfLY2UgIjaJg1wE/+dpazgs3xDQdwMWWLK+
         YJgtpwi8K5Ef2HXW6yLfHjVdqOJGFdcosmtx1RLln6TsJ/g1vwIy1PUeMqH0ASBBQub0
         81Mb99kAHG+Cj0ZW+MAUBBhFVxPgi2c2IcYt2y8PHJdilmtkXY7M5RoP9vtvG1ycL+AO
         DJlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=USpZ4pvwqIEUr9tEKnLX8PoBi7NAoOdDwbwdhvLZQWI=;
        b=aK9GkDAPmlUSiI7f/LuCQs7ezMBcS+o0o+Y8ZIWckqFqb5lETor14yLynlcRaBxevV
         DzjCwWvY5a1E4hr33unhKQBmnchyEBs+49gpc5+ehkc0pFCLg9F4MLijxfr6l1yMd1jk
         Is7TAIZip59FhzjlVk/y7oE4kqms5pa4tnuai6QUiTBP2H7OBPS2TRJU5mdd3Bp37DDn
         oBJlaw9u0xanyV7MFeYG840JaVrv3pvQvjwxdQ5L6bR9MzhuxMjFk0BXJ/7wTDzRpEIR
         BNSfuXbY9bN1SwU3VNbk/6bNfxCr/1H4dgyX3prXKoBjrrdnkYLOPAu7rBHRO/hu8QP6
         wx0Q==
X-Gm-Message-State: AGi0PuYtCSMc5e87I/xkYG3dkj0o5BXrKq+dkSKsqfogGDLPS99aHSet
        83/Hydrso/Xa9F4zhB8DBxBSsNlbS9fujjLY5wOWWX1+
X-Google-Smtp-Source: APiQypIbG/6L0TZvHBa6FMRBOKoiWq+fYxcxdF+gcpGLbsbZTdIm6Z6ZtCML6OGX0/s1PJVHq+3QIIfVUayKB+tISJU=
X-Received: by 2002:ab0:25:: with SMTP id 34mr702016uai.63.1588212792192; Wed,
 29 Apr 2020 19:13:12 -0700 (PDT)
MIME-Version: 1.0
References: <20200418231908.152212-1-eranian@google.com> <20200428024744.GA703870@tassilo.jf.intel.com>
 <CABPqkBQkmPOM7xRkXFbtAtcLVdoJ=XY6uG3k3FoEAWABJaSCQA@mail.gmail.com> <20200430020901.GC874567@tassilo.jf.intel.com>
In-Reply-To: <20200430020901.GC874567@tassilo.jf.intel.com>
From:   Stephane Eranian <eranian@google.com>
Date:   Wed, 29 Apr 2020 19:13:01 -0700
Message-ID: <CABPqkBQakhL_zm+4Dt0y3hFcQ7iBh1H31HwyvfnH4kDa2M94SQ@mail.gmail.com>
Subject: Re: [PATCH] perf/script: remove extraneous newline in perf_sample__fprintf_regs()
To:     Andi Kleen <ak@linux.intel.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>, mingo@elte.hu,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Jiri Olsa <jolsa@redhat.com>, Ian Rogers <irogers@google.com>,
        "Liang, Kan" <kan.liang@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 29, 2020 at 7:09 PM Andi Kleen <ak@linux.intel.com> wrote:
>
> > I was under the impression that perf script was generating one line
> > per sample. Otherwise, seems hard to parse.
>
> That's only true for simple cases. A lot of the extended output options
> have long generated multiple lines. And of course call stacks always did.
>
> > Could you give me the cmdline options of perf script that justify the newline.
>
> e.g.  perf script -F iregs,uregs
>
But then it should only use the \n when needed.
It is a bit like perf stat printing cgroup as "" when not using cgroup
mode add a bunch of white spaces/tab at the end of the line for
nothing.

I also suggest that we improve perf stat/script output with an output
format that is easier to parse, such as JSON with name: value pairs.
that would avoid all these \n and
flaky parsing regexp or script I have seen, even internally.

> -Andi
