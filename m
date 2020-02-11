Return-Path: <SRS0=PxPh=37=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93353C352A3
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 13:46:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62BCA20714
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 13:46:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W20jeNcD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728723AbgBKNq2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Feb 2020 08:46:28 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:46483 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727779AbgBKNq2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Feb 2020 08:46:28 -0500
Received: by mail-qt1-f193.google.com with SMTP id e21so3925025qtp.13
        for <linux-kernel@vger.kernel.org>; Tue, 11 Feb 2020 05:46:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=TQjrRYBQgNu22Yu5TuB1IALhpcVLswinVmpWMZoh7QI=;
        b=W20jeNcDFxXtwP90Aq4vDRmKH82/qSMzW/Hq0xGnX5KBBnJhTx1bMSwwzp/HilQQ2R
         vndfW6jy55/+tS+Cx7/sfWSDKVVuYbN+DCt12yW8/iBH6RoMMyeibZ+AchR8asNL/dRs
         iJ77BEZXdFVgDuR6WBovNZDGhlYQBvhanZujz/uamK94F3lcayltXlVvH04hQ+zL9Cnk
         lUXhv81z1Fp8XqSxsIALjkA3a8y9wEv9qUNNjucPO87nksR+7Qmi8hXOUaCV2pPjAPRK
         +3o8gwR/d8oj/l3PhqnjspquYT3Fa4WYz/sDmUtQXy2iUrrROLYOAmAS2NjHARAMJEYr
         SPYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=TQjrRYBQgNu22Yu5TuB1IALhpcVLswinVmpWMZoh7QI=;
        b=bjim1HrIcR04JZCrKV7lluP1Umsq6uvqyDrFUqqtBFYAKqZU7kKkFoPE5WgDd1hreH
         DtTnzmDTBPqxPur9n7DWWlrLdab/NwM/BaP0MjcQRz0IP+ms3joezXPDmcHSEnom/hAl
         AMeKktMBHWqaE1QJSknf+97rWMUyhBW1r9u40+XPtAO7SYj1z4aQRzhexaCsl5b2QTTR
         SriNQcUb6MCmynimM4w1IbpylXv+j5YI/kGLtf+347vat6d6qt+zT71a/MpxKBjfHGPy
         RKNMhS+WP/ePdRXcAWo7W6cdJJQ0epG8r7Kzq0ZLASQZxt8fdd9fNBWiZW3Eobq4he7u
         f+nQ==
X-Gm-Message-State: APjAAAUkoyXKs0tnXjjDL09BoscXqqc6lNVD0SZqSDKDWeW0axzxTDHX
        /8pgj/ejA88X15lcio0GGFU=
X-Google-Smtp-Source: APXvYqymE7hVmjKA4y9KEECJWuSfRA1BEusXP0BD+tG/76sK9Ogw1v4G/kR9pzNtzRz3nwNzVComKw==
X-Received: by 2002:ac8:7217:: with SMTP id a23mr2511705qtp.241.1581428787324;
        Tue, 11 Feb 2020 05:46:27 -0800 (PST)
Received: from quaco.ghostprotocols.net ([179.97.37.151])
        by smtp.gmail.com with ESMTPSA id v55sm2269572qtc.1.2020.02.11.05.46.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Feb 2020 05:46:26 -0800 (PST)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 6523E40A7D; Tue, 11 Feb 2020 10:46:24 -0300 (-03)
Date:   Tue, 11 Feb 2020 10:46:24 -0300
To:     Marek Majkowski <marek@cloudflare.com>
Cc:     Jiri Olsa <jolsa@redhat.com>, Ivan Babrou <ivan@cloudflare.com>,
        kernel-team <kernel-team@cloudflare.com>,
        Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>, sashal@kernel.org,
        Kenton Varda <kenton@cloudflare.com>
Subject: Re: perf not picking up symbols for namespaced processes
Message-ID: <20200211134624.GA32066@kernel.org>
References: <CABWYdi1ZKR=jmKnjoJTik08Q9uJBvyZ4W0C29iPiUJ5ef1obvw@mail.gmail.com>
 <20191205123302.GA25750@kernel.org>
 <CABWYdi1+E7MQD8mC2xQfSP0m9_WFdx9mbLkw-36tJ8EtLaw2Jg@mail.gmail.com>
 <CAJPywTKC8=O0zmNm-W4OUENpoZfrbr1Ts38gQw2ZA608_u5wpw@mail.gmail.com>
 <20200204192657.GB1554679@krava>
 <CAJPywTKuu+RPsspAT4Z_243KvtchTe7p7c4DpvG07Nv5A67fnw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJPywTKuu+RPsspAT4Z_243KvtchTe7p7c4DpvG07Nv5A67fnw@mail.gmail.com>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Feb 11, 2020 at 10:06:35AM +0000, Marek Majkowski escreveu:
> Jirka,
> 
> On Tue, Feb 4, 2020 at 7:27 PM Jiri Olsa <jolsa@redhat.com> wrote:
> > > 11913 openat(AT_FDCWD, "/proc/9512/ns/mnt", O_RDONLY) = 197
> > > 11913 setns(197, CLONE_NEWNS) = 0
> > > 11913 stat("/home/marek/bin/runsc-debug", 0x7fffffff8480) = -1 ENOENT
> > > (No such file or directory)
> > > 11913 setns(196, CLONE_NEWNS) = 0
> >
> > hi,
> > could you guys please share more details on what you run exactly,
> > and perhaps that change you mentioned?
> 
> I was debugging gvisor (runsc), which does execve(/proc/self/exe), and
> then messes up with its mount namespace. The effect is that the binary
> running doesn't exist in the mount namespace. This confuses perf,
> which fails to load symbols for that process.
> 
> To my understanding, by default, perf looks for the binary in the
> process mount namespace. In this case clearly the binary wasn't there.
> Ivan wrote a rough patch [1], which I just confirmed works. The patch
> attempts, after a failure to load binary from pids mount namespace, to
> load binary from the default mount namespace (the one running perf).
> 
> [1] https://lkml.org/lkml/2019/12/5/878

That is a fallback that works in this specific case, and, with a warning
or some explicitely specified option makes perf work with this specific
usecase, but either a warning ("fallback to root namespace binary
/foo/bar") or the explicit option, please, is that what that patch does?

- Arnaldo
