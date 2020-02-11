Return-Path: <SRS0=PxPh=37=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7426C352A3
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 13:54:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F9D0215A4
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 13:54:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="QPIcUPlj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729819AbgBKNys (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Feb 2020 08:54:48 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:34323 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729072AbgBKNyq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Feb 2020 08:54:46 -0500
Received: by mail-qk1-f196.google.com with SMTP id c20so4104010qkm.1
        for <linux-kernel@vger.kernel.org>; Tue, 11 Feb 2020 05:54:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kUEK8TJG3HW4/QEJnT3xYjJ/ktutD7806Zzni08iMh0=;
        b=QPIcUPljLhySpgzdyvXe84XApk9o0l4drWX96OHa66NRIGTCepjhS1dN+xCMvSjy5M
         q1i5UGJaxPLnvjACynnW5g2BAF0QUsh0vplMCzf2OpO1q7ckggJyTaFNZCrV9/GTmEo2
         KZnBd5XO2WEn6KiqDhtCkdoifhNFHADuWBUJc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kUEK8TJG3HW4/QEJnT3xYjJ/ktutD7806Zzni08iMh0=;
        b=blbJqxwxkBkoLFVTGdo4Rqq6l5H5baizahZ7BtR372Tr5JVDAQHn+ZKuEf6xCuv+fh
         TBqb2EAihzad4+9Bcit5k0tmiUsiMighi1lmXoJ9is6iYSuDBiiTUEpxVQSF/Zbrnj0U
         ec3FB7FqBJJ7wfrfXpafdEchJbZDneYn6jJ1GHrTucpAut9lo60z/mDALBwmFrBz8KfC
         uAlVv7v5W+6VkAOewRQgVUHyuOnNypxVgGFShT+dAtvUZxjM217RBCkuF25HhAlpn48A
         vfad14Zpe0V1eD4XAX9QCcfKr8HaiHBqJ30DaQBUb+XJMHB+DOuHlQ4pFJGaJ3PTJSOI
         4Olg==
X-Gm-Message-State: APjAAAVTTF+5C4VFhBmMqp7zo/bEVRyoQYC/XnPHlm0h66vTazXrUabG
        l2QwvVKv/48133KLmf6KRrc3MkonhOJKDomaA/hOjQ==
X-Google-Smtp-Source: APXvYqy3KpjYsRIXOcOaKACNBEpNGMeOQPERng6xt64GNqZu/t49qAAanTkAtHq8ZueV3BMYu5TnLM86aaVaezn80as=
X-Received: by 2002:a37:ad4:: with SMTP id 203mr2827671qkk.235.1581429285007;
 Tue, 11 Feb 2020 05:54:45 -0800 (PST)
MIME-Version: 1.0
References: <CABWYdi1ZKR=jmKnjoJTik08Q9uJBvyZ4W0C29iPiUJ5ef1obvw@mail.gmail.com>
 <20191205123302.GA25750@kernel.org> <CABWYdi1+E7MQD8mC2xQfSP0m9_WFdx9mbLkw-36tJ8EtLaw2Jg@mail.gmail.com>
 <CAJPywTKC8=O0zmNm-W4OUENpoZfrbr1Ts38gQw2ZA608_u5wpw@mail.gmail.com>
 <20200204192657.GB1554679@krava> <CAJPywTKuu+RPsspAT4Z_243KvtchTe7p7c4DpvG07Nv5A67fnw@mail.gmail.com>
 <20200211134624.GA32066@kernel.org>
In-Reply-To: <20200211134624.GA32066@kernel.org>
From:   Marek Majkowski <marek@cloudflare.com>
Date:   Tue, 11 Feb 2020 13:54:33 +0000
Message-ID: <CAJPywTLH9=MzX_LYns3PGsY1z3ko_BijET4bn__7zcQf5+QHyA@mail.gmail.com>
Subject: Re: perf not picking up symbols for namespaced processes
To:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Cc:     Jiri Olsa <jolsa@redhat.com>, Ivan Babrou <ivan@cloudflare.com>,
        kernel-team <kernel-team@cloudflare.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>, sashal@kernel.org,
        Kenton Varda <kenton@cloudflare.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 11, 2020 at 1:46 PM Arnaldo Carvalho de Melo
<arnaldo.melo@gmail.com> wrote:
>
> Em Tue, Feb 11, 2020 at 10:06:35AM +0000, Marek Majkowski escreveu:
> > Jirka,
> >
> > On Tue, Feb 4, 2020 at 7:27 PM Jiri Olsa <jolsa@redhat.com> wrote:
> > > > 11913 openat(AT_FDCWD, "/proc/9512/ns/mnt", O_RDONLY) = 197
> > > > 11913 setns(197, CLONE_NEWNS) = 0
> > > > 11913 stat("/home/marek/bin/runsc-debug", 0x7fffffff8480) = -1 ENOENT
> > > > (No such file or directory)
> > > > 11913 setns(196, CLONE_NEWNS) = 0
> > >
> > > hi,
> > > could you guys please share more details on what you run exactly,
> > > and perhaps that change you mentioned?
> >
> > I was debugging gvisor (runsc), which does execve(/proc/self/exe), and
> > then messes up with its mount namespace. The effect is that the binary
> > running doesn't exist in the mount namespace. This confuses perf,
> > which fails to load symbols for that process.
> >
> > To my understanding, by default, perf looks for the binary in the
> > process mount namespace. In this case clearly the binary wasn't there.
> > Ivan wrote a rough patch [1], which I just confirmed works. The patch
> > attempts, after a failure to load binary from pids mount namespace, to
> > load binary from the default mount namespace (the one running perf).
> >
> > [1] https://lkml.org/lkml/2019/12/5/878
>
> That is a fallback that works in this specific case, and, with a warning
> or some explicitely specified option makes perf work with this specific
> usecase, but either a warning ("fallback to root namespace binary
> /foo/bar") or the explicit option, please, is that what that patch does?

You got it right, custom patch, to do something custom (look up in top
mount ns) yet on failure. I'm not sure how to make it more generic.

Furthermore, there is one more use case this patch doesn't support:
namely a situation when the binary is reachable in some mount
namespace, but not under sensible path. This can happen when we launch
a command under gvisor. Gvisor-sandbox runs under empty mount
namespace, the binary is delivered over 9p from gvisor-gofer process,
from potentially arbitrary path. In that scenario we have three mount
namespaces: the empty one running process, another one with access to
the binary, and host one.

I have two ideas how to solve the symbol discovery here:
 (a) give perf an explicit link (potentially including mount namespace
pid) to the binary
 (b) supply perf with /tmp/perf-<pid>.map file with symbols, extracted
via some external helper.

I tried (b) but failed, I'm not sure how to produce perf-pid.map from
a proper binary, using basic tools like readelf.
