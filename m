Return-Path: <SRS0=ObIu=6N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E6B6C83000
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 19:32:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 07453205C9
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 19:32:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dI1whMTa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726858AbgD2Tcv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Apr 2020 15:32:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726554AbgD2Tcu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Apr 2020 15:32:50 -0400
Received: from mail-vs1-xe41.google.com (mail-vs1-xe41.google.com [IPv6:2607:f8b0:4864:20::e41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4BCEC03C1AE
        for <linux-kernel@vger.kernel.org>; Wed, 29 Apr 2020 12:32:50 -0700 (PDT)
Received: by mail-vs1-xe41.google.com with SMTP id s11so2196042vsm.3
        for <linux-kernel@vger.kernel.org>; Wed, 29 Apr 2020 12:32:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vrgxe9ifjEnyPmXmvPhvUyY/XI0D3egtea2Iq4Vnzx8=;
        b=dI1whMTatmml5O41FPYCNwjpGiABq/GMGOrZM3DUvNHp7OltmJ9mTgz5r2xW9wlUtW
         gwYSrlEfK3RKwDSjYkvUcOYZIbLmqZcnCY7wT5UKmT7J44EzyFoBGAfkoqpZoXxVIYnC
         BvFmsLJDRF0nOnK9yACo3R2P8pzqK88vM/vAxx0eeR8tMnGTcpoIKUit129f7zjiatxk
         IUUz3jqHazCvR+k+CJGxpFzL+uho2N6srSoIzzlEiMlkaCK93VQZP5LtErQHEpuQKGLy
         QBPgsYpytDwHnDJnkika3fg+74jJoDciriL01Wc/BS0cJ5b8Yv1xiNw9euYmmY5ZlF7+
         Fs9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vrgxe9ifjEnyPmXmvPhvUyY/XI0D3egtea2Iq4Vnzx8=;
        b=lkqkiegNJWi/iVSjVdvF+8l32VKd3oGSvCc2T8PsiYgPfFtbFZBnB2WYV54yklO+et
         caQx0r8q84qY1Q/g1kxn6QM5jahMrHL85mHTwb+Ezzy5EFr6Q21SPhR+n0DIHqID1bD6
         A7ug2i5osMxuoXBjeTob5nwh9blpiLqecBoyi+7AKQCOTClfAMDJ++v0VqEaJjwPP7b5
         T+cd5aXyH+NhQpZf0Rmv5EXFPoYp3TE+pjrlxTC8zgna4k10pK8JR5QL0J7TGu/zX0QY
         m85cT/d0FlHa7jMm7fddwSAyETWs0OAqKbZXIr6g7FpZNcTFMBCJOxPvRwGFnaKL/jhL
         lehQ==
X-Gm-Message-State: AGi0PuYqXluov3g+qrDTVaa4nqpIm2QU9w5nLltcQ2wo6YFzO0NG/n1U
        rq/8EBmtry8cqgLzD7kKDb2IWGLlAOr8b7byP5y/63L0
X-Google-Smtp-Source: APiQypKqcWf5YB/ZPuN+OgQKgk1NHPqQn9fq4ey82QS8PyvF94UlRXjbXQP1hapdO1DVfU+2JoAXZh1t/I6lCsPLq8M=
X-Received: by 2002:a67:ffcf:: with SMTP id w15mr4867058vsq.213.1588188769592;
 Wed, 29 Apr 2020 12:32:49 -0700 (PDT)
MIME-Version: 1.0
References: <20200418231908.152212-1-eranian@google.com> <20200428024744.GA703870@tassilo.jf.intel.com>
In-Reply-To: <20200428024744.GA703870@tassilo.jf.intel.com>
From:   Stephane Eranian <eranian@google.com>
Date:   Wed, 29 Apr 2020 12:32:38 -0700
Message-ID: <CABPqkBQkmPOM7xRkXFbtAtcLVdoJ=XY6uG3k3FoEAWABJaSCQA@mail.gmail.com>
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

On Mon, Apr 27, 2020 at 7:47 PM Andi Kleen <ak@linux.intel.com> wrote:
>
> On Sat, Apr 18, 2020 at 04:19:08PM -0700, Stephane Eranian wrote:
> > When printing iregs, there was a double newline printed because
> > perf_sample__fprintf_regs() was printing its own and then at the
> > end of all fields, perf script was adding one.
> > This was causing blank line in the output:
>
> I don't think the patch is quite correct because there could be
> other fields after it, and they need to be separated by a
> new line too.
>
> e.g. i suspect if someone prints iregs,uregs or iregs,brstack
> or something else that is printed in process_event after *regs
> you would get garbled output.
>
I was under the impression that perf script was generating one line
per sample. Otherwise, seems hard to parse.
Could you give me the cmdline options of perf script that justify the newline.
 Thanks.

> So you have to track if the newline is needed or not.
>
> -Andi
