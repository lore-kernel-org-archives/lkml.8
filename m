Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0F02C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 19:33:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9376B2067D
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 19:33:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LWJedSK7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732811AbgF2TdO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 15:33:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733234AbgF2Tcp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 15:32:45 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DDE0C0307AF
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 08:55:50 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id q5so17044284wru.6
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 08:55:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZLYf85kR83hcUBrWvAXG8Wj7+vy80vScSZPRychjVjA=;
        b=LWJedSK7vsBqcOAmUtGOZfumg1m6WZSEpuhdmRAZmilonlGtrZ+oyu4Xmq4qljvXoz
         fxFmvJ8dcvonuqckrIidX/9KdbFm4+bh3/izrA9XHkRvWc3/iDt9uwaOcc1ykoLVTyNf
         l82zMGLrTJ25BETRb/Efx3mAGjQSdoQkMl9OzYSpqqNKEeLC2Fc5LKTv4uKVg6ckhMj/
         lskq7ye7Eyddf5MSKTzh1a9kEbgaioraiu4/pmNoC5NeU5xoEnujNhFEB8NU+VKbszRl
         x3j3zt80UZa2rD5u4GNWyG146Vr1EuG/uhncqg/fHQyFVr8Flr8TpyI59Z7krJmMqBmk
         zTNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZLYf85kR83hcUBrWvAXG8Wj7+vy80vScSZPRychjVjA=;
        b=Ivklo+SHhXxzSQzRlGwK46KmwlfuND7RpvDyVC26eU8gHQaAMFQHmJhHGT+tolEAX2
         7vNLVP00XlV+rXK3dbAddO7nmY6HxCJ4bhps3gLJk6BroB/R4jCUJ0C0034putHe9YD4
         hI/U7IAUgXgOBDDgMTaPk04QguN0AvlO70GdJBZBtj602K1UaTmc0ppVkgaZHwWm6hPq
         JOx/btoKk9aYWokZRbUVbJsflvbR1vz/fh8cZOydT2okHQ1Q+7BJkLiPKOdA1J0RBRn3
         cEgXthSJ9Bj84dCjgsXvOVQMxgt/h/r+DeqEhxmcfZ4bwABHtnEHwnazhzicWHxHfwG8
         xCOg==
X-Gm-Message-State: AOAM531ZcGobE8OfGoBodzqTQs6AgaPx5e12gUmxHX6zMGq+V3E+d2NN
        18dKntmI6PQUs3xHjQbYxLY6t2ElqK4/nU7UxjnXpg==
X-Google-Smtp-Source: ABdhPJz9h6Cq1FWLxlQEINaOnw/gdytwi8Ik6QwjWFXm6YyNY7WE8CKP9YxrAml4Sjw812CKlTvMnxmA4R2YZ4kzcbg=
X-Received: by 2002:adf:df03:: with SMTP id y3mr16828999wrl.376.1593446149156;
 Mon, 29 Jun 2020 08:55:49 -0700 (PDT)
MIME-Version: 1.0
References: <20200626194720.2915044-1-jolsa@kernel.org> <20200626194720.2915044-8-jolsa@kernel.org>
 <CAP-5=fUB3cs7Px6NkpBtWaWdR5-qQGAd2hAGjQjyMJt=bDKXOA@mail.gmail.com> <20200628215507.GM2988321@krava>
In-Reply-To: <20200628215507.GM2988321@krava>
From:   Ian Rogers <irogers@google.com>
Date:   Mon, 29 Jun 2020 08:55:37 -0700
Message-ID: <CAP-5=fWLYkxYbc8Qtk331X4_HudO=NukEzSDiJXF=rf2Tghovg@mail.gmail.com>
Subject: Re: [PATCH 07/10] perf tools: Collect other metrics in struct metric_expr
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Jiri Olsa <jolsa@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Michael Petlan <mpetlan@redhat.com>,
        Andi Kleen <ak@linux.intel.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        John Garry <john.garry@huawei.com>,
        "Paul A. Clarke" <pc@us.ibm.com>,
        Stephane Eranian <eranian@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 28, 2020 at 2:55 PM Jiri Olsa <jolsa@redhat.com> wrote:
>
> On Fri, Jun 26, 2020 at 02:10:57PM -0700, Ian Rogers wrote:
> > On Fri, Jun 26, 2020 at 12:48 PM Jiri Olsa <jolsa@kernel.org> wrote:
> > >
> > > Add 'other' metrics into struct metric_expr object,
> > > so they are accessible when computing the metric.
> > >
> > > Storing just name and expression itself, so the metric
> > > can be resolved and computed.
> >
> > Nit, other vs something like referenced_metric but otherwise lgtm.
>
> I'd like to keep metric prefix
>
>   struct metric_ref ?

Sounds good to me. Thanks,
Ian

> jirka
>
