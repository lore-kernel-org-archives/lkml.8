Return-Path: <SRS0=PxPh=37=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C504C352A3
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 14:28:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6213720714
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 14:28:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="joB7El9A"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729738AbgBKO2k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Feb 2020 09:28:40 -0500
Received: from mail-qk1-f173.google.com ([209.85.222.173]:46882 "EHLO
        mail-qk1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728339AbgBKO2k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Feb 2020 09:28:40 -0500
Received: by mail-qk1-f173.google.com with SMTP id g195so10189322qke.13
        for <linux-kernel@vger.kernel.org>; Tue, 11 Feb 2020 06:28:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=gOs5a+mgKve4DnZzNf0lqUu/OQjXvBUZNfAzTYDDF2Y=;
        b=joB7El9ADY1cF0Yk+MwRZHoeiuiwh5j8aAJY7MKimmI67xe9ldLwveNUuTqP38qbjY
         9a2Y2EJ39JpHU0fM16QkHDa9liX/Smnge0/bzRsjhK334pOd0DvjIJOtZnI9gUElWKBL
         1dTUtiTPWlPzBV9ZX2XGX/OGNaN6eMMVllWuIMxnokd3+ylFS3w282dtsYmuD+rf0539
         UV2u5Wk/pjL4Gk+Q3CNdhaw0cC+3SlyvizVJePcfHb9mhv/p2kJupsawMuc3vEaca0Jf
         DOPbCB+THOVl4wcrDPgy3QLCBt2/wwcxiqyjd630oBLcfUMHF8Lvb7tce6r3NvgbIsSZ
         MXjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=gOs5a+mgKve4DnZzNf0lqUu/OQjXvBUZNfAzTYDDF2Y=;
        b=Rgi2sVAhhLrvnoTU/FX2EzG7XOSryrY7D7kONl8zrOjHLLnoy6HQzvmTPbOWjjmOhN
         Q16hsrZ0LW0JalccQi75hGUl27dAKgTggJ+eKYTxL35njCpOFc6WfZr02aE5D69AKpuG
         AHVELbi1OJMkRrFfMJhO9nVcou51gkrp0EM36rr8enP7lkun+kVxqMnS2mG5HjoE8YDy
         GjnSDfE1MTY2c+V2wYivBsfVjHUIBKxA3Ii61vIGTpemzukjbt6UA/0UFj+1v+pAuIP7
         pa6zaHa2GjUro4S2aN+JKa9DSD5xyrAUSeRMPyXMJJ5HsJBLALAnk2Lpy0DVU2So0A54
         WhqQ==
X-Gm-Message-State: APjAAAXVPYP4o/gkvYMR5JoE79IxCkLYV1isdM8C9YgdLRRBMi+O65/0
        yN5pNP5l/ZEp/es2W+Eqi3E=
X-Google-Smtp-Source: APXvYqx1Y7n3hqbF0FyRaxCDLSdG5+1LUj4bmV+2b4sHNmefefkPfUy6o5R9e/p/Kz0GiwrNzck8VA==
X-Received: by 2002:a37:de16:: with SMTP id h22mr2919327qkj.400.1581431317390;
        Tue, 11 Feb 2020 06:28:37 -0800 (PST)
Received: from quaco.ghostprotocols.net ([179.97.37.151])
        by smtp.gmail.com with ESMTPSA id m68sm2090912qke.17.2020.02.11.06.28.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Feb 2020 06:28:36 -0800 (PST)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 0B44040A7D; Tue, 11 Feb 2020 11:28:34 -0300 (-03)
Date:   Tue, 11 Feb 2020 11:28:33 -0300
To:     Marek Majkowski <marek@cloudflare.com>
Cc:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Ivan Babrou <ivan@cloudflare.com>,
        kernel-team <kernel-team@cloudflare.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>, sashal@kernel.org,
        Kenton Varda <kenton@cloudflare.com>
Subject: Re: perf not picking up symbols for namespaced processes
Message-ID: <20200211142833.GC32066@kernel.org>
References: <CABWYdi1ZKR=jmKnjoJTik08Q9uJBvyZ4W0C29iPiUJ5ef1obvw@mail.gmail.com>
 <20191205123302.GA25750@kernel.org>
 <CABWYdi1+E7MQD8mC2xQfSP0m9_WFdx9mbLkw-36tJ8EtLaw2Jg@mail.gmail.com>
 <CAJPywTKC8=O0zmNm-W4OUENpoZfrbr1Ts38gQw2ZA608_u5wpw@mail.gmail.com>
 <20200204192657.GB1554679@krava>
 <CAJPywTKuu+RPsspAT4Z_243KvtchTe7p7c4DpvG07Nv5A67fnw@mail.gmail.com>
 <20200211134624.GA32066@kernel.org>
 <CAJPywTLH9=MzX_LYns3PGsY1z3ko_BijET4bn__7zcQf5+QHyA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJPywTLH9=MzX_LYns3PGsY1z3ko_BijET4bn__7zcQf5+QHyA@mail.gmail.com>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Feb 11, 2020 at 01:54:33PM +0000, Marek Majkowski escreveu:
> On Tue, Feb 11, 2020 at 1:46 PM Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com> wrote:
> > Em Tue, Feb 11, 2020 at 10:06:35AM +0000, Marek Majkowski escreveu:
> > > On Tue, Feb 4, 2020 at 7:27 PM Jiri Olsa <jolsa@redhat.com> wrote:
> > > > > 11913 openat(AT_FDCWD, "/proc/9512/ns/mnt", O_RDONLY) = 197
> > > > > 11913 setns(197, CLONE_NEWNS) = 0
> > > > > 11913 stat("/home/marek/bin/runsc-debug", 0x7fffffff8480) = -1 ENOENT
> > > > > (No such file or directory)
> > > > > 11913 setns(196, CLONE_NEWNS) = 0

> > > > could you guys please share more details on what you run exactly,
> > > > and perhaps that change you mentioned?

> > > I was debugging gvisor (runsc), which does execve(/proc/self/exe), and
> > > then messes up with its mount namespace. The effect is that the binary
> > > running doesn't exist in the mount namespace. This confuses perf,
> > > which fails to load symbols for that process.

> > > To my understanding, by default, perf looks for the binary in the
> > > process mount namespace. In this case clearly the binary wasn't there.
> > > Ivan wrote a rough patch [1], which I just confirmed works. The patch
> > > attempts, after a failure to load binary from pids mount namespace, to
> > > load binary from the default mount namespace (the one running perf).

> > > [1] https://lkml.org/lkml/2019/12/5/878

> > That is a fallback that works in this specific case, and, with a warning
> > or some explicitely specified option makes perf work with this specific
> > usecase, but either a warning ("fallback to root namespace binary
> > /foo/bar") or the explicit option, please, is that what that patch does?

> You got it right, custom patch, to do something custom (look up in top
> mount ns) yet on failure. I'm not sure how to make it more generic.

We have buildids in binaries:

[acme@quaco ~]$ file /bin/bash
/bin/bash: ELF 64-bit LSB pie executable, x86-64, version 1 (SYSV), dynamically linked, interpreter /lib64/ld-linux-x86-64.so.2, for GNU/Linux 3.2.0, BuildID[sha1]=0cb50a07a621d02a0d2c7efec6743fddec845bfb, stripped
[acme@quaco ~]$ file /lib64/libc-2.29.so
/lib64/libc-2.29.so: ELF 64-bit LSB shared object, x86-64, version 1 (GNU/Linux), dynamically linked, interpreter /lib64/ld-linux-x86-64.so.2, BuildID[sha1]=7ddecbbf9f22ec76c9e4a256fd1c06004a1907ce, for GNU/Linux 3.2.0, not stripped, too many notes (256)
[acme@quaco ~]$

We need to get this somehow from a given executable map, this comes and
goes in situations like this :-\

I.e. this info is in an ELF section:

[acme@quaco ~]$ readelf -SW /bin/bash | grep build-id
  [ 4] .note.gnu.build-id NOTE            0000000000000340 000340 000024 00   A  0   0  4
[acme@quaco ~]$

Somebody needs to associate that with that executable mmap at load time,
so that perf gets it via PERF_RECORD_MMAP3 instead of having to try,
optimistically, to get it from the binary (that may not be there when we
try to read it, or maybe in some place like you describe in this
message, or...) when generating its build-id perf.data header section:

[acme@seventh ~]$ perf record stress-ng --cpu 1 --timeout 1s
stress-ng: info:  [17622] dispatching hogs: 1 cpu
stress-ng: info:  [17622] successful run completed in 1.02s
[ perf record: Woken up 1 times to write data ]
[ perf record: Captured and wrote 0.159 MB perf.data (4105 samples) ]
[acme@seventh ~]$ perf buildid-list
e9e69be73f7c5a4cee110ced52409371e95fe2a8 [kernel.kallsyms]
7133e5dbdfae821a9bbe4ba5467e49f6cf166e1d /usr/bin/stress-ng
bd5e36f101b175755c7943105390078dff596657 /usr/lib64/ld-2.29.so
1e292b30223c69eff986710c62eda48c561d43ca [vdso]
b8d7438178da8f84d89869addf6b5e36d356c555 /usr/lib64/libm-2.29.so
7ddecbbf9f22ec76c9e4a256fd1c06004a1907ce /usr/lib64/libc-2.29.so
[acme@seventh ~]$ file /usr/bin/stress-ng
/usr/bin/stress-ng: ELF 64-bit LSB pie executable, x86-64, version 1 (SYSV), dynamically linked, interpreter /lib64/ld-linux-x86-64.so.2, for GNU/Linux 3.2.0, BuildID[sha1]=7133e5dbdfae821a9bbe4ba5467e49f6cf166e1d, stripped, too many notes (256)
[acme@seventh ~]$
 
> Furthermore, there is one more use case this patch doesn't support:
> namely a situation when the binary is reachable in some mount
> namespace, but not under sensible path. This can happen when we launch
> a command under gvisor. Gvisor-sandbox runs under empty mount
> namespace, the binary is delivered over 9p from gvisor-gofer process,
> from potentially arbitrary path. In that scenario we have three mount
> namespaces: the empty one running process, another one with access to
> the binary, and host one.
 
> I have two ideas how to solve the symbol discovery here:
>  (a) give perf an explicit link (potentially including mount namespace
> pid) to the binary
>  (b) supply perf with /tmp/perf-<pid>.map file with symbols, extracted
> via some external helper.
> 
> I tried (b) but failed, I'm not sure how to produce perf-pid.map from
> a proper binary, using basic tools like readelf.

Have you looked at:

[acme@quaco ~]$ perf report -h symfs

 Usage: perf report [<options>]

        --symfs <directory>
                          Look for files with symbols relative to this directory

[acme@quaco ~]$

?

- Arnaldo
