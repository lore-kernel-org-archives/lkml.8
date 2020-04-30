Return-Path: <SRS0=SogR=6O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CED34C83000
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 14:31:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9F489206D9
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 14:31:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="njQiGucT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728319AbgD3Obm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Apr 2020 10:31:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726910AbgD3Obl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Apr 2020 10:31:41 -0400
Received: from mail-yb1-xb41.google.com (mail-yb1-xb41.google.com [IPv6:2607:f8b0:4864:20::b41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48535C035494
        for <linux-kernel@vger.kernel.org>; Thu, 30 Apr 2020 07:31:41 -0700 (PDT)
Received: by mail-yb1-xb41.google.com with SMTP id b17so3267565ybq.13
        for <linux-kernel@vger.kernel.org>; Thu, 30 Apr 2020 07:31:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ShpsY/1pJ/oL50FAYiypemqFtyyn+iEopdvwAgjtnWk=;
        b=njQiGucTY/Fcx1F70f7DUaQQLzyx70VAnvdtKsxXqx0EfsK0FpYiX4C1nk/54HfW1t
         l885kcsHegRF/Qqcoti/QIXdSB8lcAkRjsZ//vLFKMpo0tSpt1/Qpr5NPDney8Ni/sv6
         +vaBH8bAq9FRYTJXBauxBNGVN9NXeIdi77vWO73cClugQDFJq7GuOXBd9L11u9O0M+VT
         La+Eq+fSlZNvJRNZ0qcPNLnUdoExccZ1hXtbhjqH+yPST0Yx7w4W8rdnewNwGYOeVtl/
         UAtHetFNhQlaQXAvYWe0w3Wp1qv1TLwdFXqJ0cPCZKIz2bsmssWUyOy67sqwL8gD8KWG
         5FFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ShpsY/1pJ/oL50FAYiypemqFtyyn+iEopdvwAgjtnWk=;
        b=jfVBzutKg9spdXYAcJP/poF7OoWThr6JmZODI7tVkh1RrhGzh3GNo8Vz0btgy//u6p
         oDoRr6EnZ+tRS1egtx4tqRxhj9JbKUz34YQ6hHnFazmg8dJZOPoKD2SYgNcFq7Y/bmAm
         0WZdP3vv4N3DRdhDbfsE4rcBT7uEJdWB19QCsWsN8JHvrpsFVoIXlEgax9hbFiKjnKjk
         1EnzW+3aUakwDug8P9xtlTSTs9vUBRE7ZU5+1PgrZKxk8mUQPTAgcOJl4UaK0/CM3wDn
         xVTUZ7Npv3CBzLJ4gAshNnCgsgpqtVd5E/h/U8sSZ0WfWKE/Vo4cjZ66P1ZfMHvWq0rU
         r1Kg==
X-Gm-Message-State: AGi0PuanghM+StaYcZtmqKJnFl60xtqWdIZHVE4jbY5YbP/zd35NLqkk
        /8TSmTYQNsuX91F1/Qk9vdexP6mZylbDSnPdOsiLkg==
X-Google-Smtp-Source: APiQypIe3dmiMibw9PRRB87OPeY7rTmED5SwuKDs6yxYJYHcEEpHUkJQkigv0bjCDoXofbPXXXqjONR/KcNnEfE+Wtk=
X-Received: by 2002:a25:3d86:: with SMTP id k128mr6420171yba.403.1588257100261;
 Thu, 30 Apr 2020 07:31:40 -0700 (PDT)
MIME-Version: 1.0
References: <20200430075144.132716-1-irogers@google.com> <20200430075144.132716-13-irogers@google.com>
 <6a3d68fd-c489-c0d5-8612-69f15be1bf64@huawei.com>
In-Reply-To: <6a3d68fd-c489-c0d5-8612-69f15be1bf64@huawei.com>
From:   Ian Rogers <irogers@google.com>
Date:   Thu, 30 Apr 2020 07:31:29 -0700
Message-ID: <CAP-5=fUA3UDNdreJBhdLBPgyFUutN_qUqaL-Diu3yihSDc_niw@mail.gmail.com>
Subject: Re: [PATCH v3 12/12] perf test: improve pmu event metric testing
To:     John Garry <john.garry@huawei.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Kan Liang <kan.liang@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Haiyan Song <haiyanx.song@intel.com>,
        Jin Yao <yao.jin@linux.intel.com>,
        Song Liu <songliubraving@fb.com>,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>,
        Leo Yan <leo.yan@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Paul Clarke <pc@us.ibm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        kajoljain <kjain@linux.ibm.com>,
        "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>,
        Stephane Eranian <eranian@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 30, 2020 at 4:44 AM John Garry <john.garry@huawei.com> wrote:
>
> On 30/04/2020 08:51, Ian Rogers wrote:
> > Add a basic floating point number test to expr.
> > Break pmu-events test into 2 and add a test to verify that all pmu metric
> > expressions simply parse.
>
> Could we add also add something in jevents to ensure this?

I think it is an interesting possibility. Instead of strings we could
also parse the metrics into C functions, that could cause build time
errors at least for the simple expressions. An issue I've faced is
that if jevents fails, such as a json parse error, it has an exit code
of 0 and creates an empty map file. This allows the build to proceed
but with the pmu-events functionality broken. I'd prefer a build to
fail as early as possible.

Thanks,
Ian

> Thanks,
> John
>
>   Try to parse all metric ids/events, failing if
> > metrics for the current architecture fail to parse.
> >
