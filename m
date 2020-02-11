Return-Path: <SRS0=PxPh=37=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 555F3C352A3
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 10:06:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 213CD2086A
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 10:06:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="qftOSpm6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728156AbgBKKGq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Feb 2020 05:06:46 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:43978 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727264AbgBKKGq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Feb 2020 05:06:46 -0500
Received: by mail-qt1-f196.google.com with SMTP id d18so7457226qtj.10
        for <linux-kernel@vger.kernel.org>; Tue, 11 Feb 2020 02:06:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FhWcZb4/vDUUKrqNOiBWVX9k45dIhS2uPcoT5/+VJdk=;
        b=qftOSpm6devyYeZL7hFoKhny/GyTfM7ivFBXO4L4B35swa60u8djtiglSUOK6b0t0+
         g96TifieG5DdeZcPGgGKcw7FLIKGJ9eTpvVmrffsOM0SNGYTVnDlrm+idu+hURZbSCTL
         bJR27nkFP6K7egNCl0UO6RdRXTq8daK9x2C10=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FhWcZb4/vDUUKrqNOiBWVX9k45dIhS2uPcoT5/+VJdk=;
        b=CWztYAZXCgqhNzHJ8Qeyfk5odE1urDz4Pdzfwqmoc0QOByoJPflwVGroGJbAfd4UDH
         PCtJWr/tRXGe9Co8tHsDaNz+jXjE/uKwZ0qc06dI9rRcOT/yC55CxfB7wUqOEJJ3dKSc
         hf+WUogG963X68NskxqqZuoYPW2vjnKAf+BhZm0fTSk4PmQxiIpwjyCzSLU6MIu0g2hu
         Y5cGIPY4GkeBSc3OWJSSvUxuhn6iDCwCjZIdL1e/DPws04ZRxtZtFEbF+ba4k2BQiYzX
         kp4juT1JyV9OimR7K0koK1bvj0xSJ/NzJa9O8DuVg6Ohj/5648PH7ObYhYfpv3+DaXJM
         QZCw==
X-Gm-Message-State: APjAAAWnQDQr/SorjaIvFuGVkUYCP0KfNftJg7aF55JXkRoi2foSem9F
        ahwU9l9+ojl1PwibykhNzZqUmC8kzcSfAAPGRlDoDQ==
X-Google-Smtp-Source: APXvYqxCG0ZPphjcEoKpJJiotsjqd9YtYvcKrxfujOFBGwJGO10fZZkMU8+3M5/sqXGHlHeOlPcZIPWJq94B3UpHQ2g=
X-Received: by 2002:ac8:8d6:: with SMTP id y22mr1583188qth.85.1581415603366;
 Tue, 11 Feb 2020 02:06:43 -0800 (PST)
MIME-Version: 1.0
References: <CABWYdi1ZKR=jmKnjoJTik08Q9uJBvyZ4W0C29iPiUJ5ef1obvw@mail.gmail.com>
 <20191205123302.GA25750@kernel.org> <CABWYdi1+E7MQD8mC2xQfSP0m9_WFdx9mbLkw-36tJ8EtLaw2Jg@mail.gmail.com>
 <CAJPywTKC8=O0zmNm-W4OUENpoZfrbr1Ts38gQw2ZA608_u5wpw@mail.gmail.com> <20200204192657.GB1554679@krava>
In-Reply-To: <20200204192657.GB1554679@krava>
From:   Marek Majkowski <marek@cloudflare.com>
Date:   Tue, 11 Feb 2020 10:06:35 +0000
Message-ID: <CAJPywTKuu+RPsspAT4Z_243KvtchTe7p7c4DpvG07Nv5A67fnw@mail.gmail.com>
Subject: Re: perf not picking up symbols for namespaced processes
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Ivan Babrou <ivan@cloudflare.com>,
        kernel-team <kernel-team@cloudflare.com>,
        Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
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

Jirka,

On Tue, Feb 4, 2020 at 7:27 PM Jiri Olsa <jolsa@redhat.com> wrote:
> > 11913 openat(AT_FDCWD, "/proc/9512/ns/mnt", O_RDONLY) = 197
> > 11913 setns(197, CLONE_NEWNS) = 0
> > 11913 stat("/home/marek/bin/runsc-debug", 0x7fffffff8480) = -1 ENOENT
> > (No such file or directory)
> > 11913 setns(196, CLONE_NEWNS) = 0
>
> hi,
> could you guys please share more details on what you run exactly,
> and perhaps that change you mentioned?

I was debugging gvisor (runsc), which does execve(/proc/self/exe), and
then messes up with its mount namespace. The effect is that the binary
running doesn't exist in the mount namespace. This confuses perf,
which fails to load symbols for that process.

To my understanding, by default, perf looks for the binary in the
process mount namespace. In this case clearly the binary wasn't there.
Ivan wrote a rough patch [1], which I just confirmed works. The patch
attempts, after a failure to load binary from pids mount namespace, to
load binary from the default mount namespace (the one running perf).

[1] https://lkml.org/lkml/2019/12/5/878

Marek
