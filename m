Return-Path: <SRS0=sqB7=5R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 132C2C43331
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 23:23:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D352B20719
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 23:23:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585783392;
	bh=VhzqTsnz/T/+BidZ1A4y3an2jgdEdwLBWXgZ5XzetHY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=p2teuvuHByMTOeV9A9fxWetbK6utYG0bBd3P8RnfaOtKGdT0T3GOR+Jht9KlnX/Zh
	 02qpzoNJfnyY90eWUvsczV1QfHBfgtBg0pBFZ/zHD8qVRpgn7mwhqsYJl7V0FL6E+Q
	 hFCxHK9aizjBbbCDG/upjLImKCicq44mgaZT8Uso=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733220AbgDAXXL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Apr 2020 19:23:11 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:51042 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732661AbgDAXXL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Apr 2020 19:23:11 -0400
Received: by mail-wm1-f65.google.com with SMTP id t128so1538707wma.0
        for <linux-kernel@vger.kernel.org>; Wed, 01 Apr 2020 16:23:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dDAACjP4TIjj9agQcJymjJZ69K6FdetqjWTukZDZNJk=;
        b=aseFLMWyrjFkgkY1+1sTjRyZrbAOdrcJIsJG7qzoseth81lc8m24+eB4zgCVjRzdyA
         VgWpn96YQaCnoLviLtEdsn8VwGqoiAXktF6im5uGe/52S61eLCHzdQi6NF0eZgkzck6e
         jhjoV2mzZmnA7xw+UpGazmPBpxNHq4l0cZT5XvVs+4/1OJxB6KDyXeexr4UzxocV570u
         PocdppxyLOxQMP2TH+luAQmXz7M5x0UDM3Jw4YVO5BntNMRoYxMd8abHfq010vuHlVpj
         7wPhqECgh+m3RdmPeY/IM1mHDA5tPPBhTd8NAUiY96m9LkuynV3Scx4xFIDZDpDNvgqg
         F48A==
X-Gm-Message-State: AGi0PubKHz9ZWlDcYHhCSOGFbzxMmDZg/1M9gZ+lkotOnLWOzUBPixo7
        djZaB/TywlLr1kG7LySwkmO00OmZnLItvYpycYVUOA==
X-Google-Smtp-Source: APiQypJkW+SlTSyISfjFqw954bU3US46peD8uLmsxnEGYY6QEhnbr06G4CGAI/aiWnDgrJ6T8ez26aJWEfN16kEgRFg=
X-Received: by 2002:a7b:c105:: with SMTP id w5mr371860wmi.168.1585783389504;
 Wed, 01 Apr 2020 16:23:09 -0700 (PDT)
MIME-Version: 1.0
References: <20200325124536.2800725-1-namhyung@kernel.org> <20200325124536.2800725-7-namhyung@kernel.org>
 <20200330163058.GC4576@kernel.org> <20200330164312.GD4576@kernel.org>
In-Reply-To: <20200330164312.GD4576@kernel.org>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Thu, 2 Apr 2020 08:22:58 +0900
Message-ID: <CAM9d7cgtEXGZL+GZeLy1RmoU=jB4BfLApbsV9F=iDx6cqMh_5A@mail.gmail.com>
Subject: Re: [PATCH 6/9] perf record: Support synthesizing cgroup events
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Ingo Molnar <mingo@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnaldo,

On Tue, Mar 31, 2020 at 1:43 AM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> Em Mon, Mar 30, 2020 at 01:30:58PM -0300, Arnaldo Carvalho de Melo escreveu:
> > Em Wed, Mar 25, 2020 at 09:45:33PM +0900, Namhyung Kim escreveu:
> > > Synthesize cgroup events by iterating cgroup filesystem directories.
> > > The cgroup event only saves the portion of cgroup path after the mount
> > > point and the cgroup id (which actually is a file handle).
> >
> > Breaks the build on alpine linux (musl libc):
> >
> >   CC       /tmp/build/perf/util/srccode.o
> >   CC       /tmp/build/perf/util/synthetic-events.o
> > util/synthetic-events.c: In function 'perf_event__synthesize_cgroup':
> > util/synthetic-events.c:427:22: error: field 'fh' has incomplete type
> >    struct file_handle fh;
> >                       ^
> > util/synthetic-events.c:441:6: error: implicit declaration of function 'name_to_handle_at' [-Werror=implicit-function-declaration]
> >   if (name_to_handle_at(AT_FDCWD, path, &handle.fh, &mount_id, 0) < 0) {
> >       ^
> > util/synthetic-events.c:441:2: error: nested extern declaration of 'name_to_handle_at' [-Werror=nested-externs]
> >   if (name_to_handle_at(AT_FDCWD, path, &handle.fh, &mount_id, 0) < 0) {
> >   ^
> >   CC       /tmp/build/perf/util/data.o
> > cc1: all warnings being treated as errors
> > mv: can't rename '/tmp/build/perf/util/.synthetic-events.o.tmp': No such file or directory
> >
> >
> > I'm trying to fix
>
> musl libc up to 1.2.21 (IIRC) lacks name_to_handle_at and its structs,
> then from the one that is in alpine linux 3.10 the error changes to:
>
>   CC       /tmp/build/perf/util/cloexec.o
> util/synthetic-events.c:427:22: error: field 'fh' with variable sized type 'struct file_handle' not at the end of a struct or class is a GNU
>       extension [-Werror,-Wgnu-variable-sized-type-not-at-end]
>                 struct file_handle fh;
>                                    ^
> 1 error generated.
> mv: can't rename '/tmp/build/perf/util/.synthetic-events.o.tmp': No such file or directory
> make[4]: *** [/git/linux/tools/build/Makefile.build:97: /tmp/build/perf/util/synthetic-events.o] Error 1
> make[4]: *** Waiting for unfinished jobs....
> make[3]: *** [/git/linux/tools/build/Makefile.build:139: util] Error 2
> make[2]: *** [Makefile.perf:617: /tmp/build/perf/perf-in.o] Error 2
> make[1]: *** [Makefile.perf:225: sub-make] Error 2
> make: *** [Makefile:70: all] Error 2
> make: Leaving directory '/git/linux/tools/perf'
> + exit 1
> [root@quaco ~]#
>
> So probably we'll need a feature test to catch this and do some
> workaround or disable the feature on such systems, providing some
> warning.
>
> I left the container build tests running to see if some other system has
> problems with this, perhaps the ones with uCLibc or some older glibc,
> we'll see.
>
> So far all the alpine versions failed with the above problems and ALT
> Linux p8 and p9 built without problems.

Hmm.. right, the CONFIG_FHANDLE can be turned off or old systems
lack support.  I'll send a patch for the feature test soon.

Thanks
Namhyung
