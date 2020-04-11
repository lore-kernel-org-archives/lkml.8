Return-Path: <SRS0=xbEg=53=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EB1BC2BA2B
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Apr 2020 07:14:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE277206F7
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Apr 2020 07:14:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=juliacomputing-com.20150623.gappssmtp.com header.i=@juliacomputing-com.20150623.gappssmtp.com header.b="kXVfw/kF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726204AbgDKHOT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Apr 2020 03:14:19 -0400
Received: from mail-il1-f171.google.com ([209.85.166.171]:36408 "EHLO
        mail-il1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726162AbgDKHOS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Apr 2020 03:14:18 -0400
Received: by mail-il1-f171.google.com with SMTP id p13so3811083ilp.3
        for <linux-kernel@vger.kernel.org>; Sat, 11 Apr 2020 00:14:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=juliacomputing-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=Fa9OKlPgIZsak2scOJMVIYdvh3KbHmtnaJtoH8ECQUs=;
        b=kXVfw/kF5eBaxzDv2RdRg4ZFnoDgQgTMISSlNx2qkoB9vyyQ9HYivF0/+IsZqQVx/i
         pCRxwTu6cQLwcwoS5sD56tZV+q47fcJTgnhr8rH5Iyw03kBTPikug6pcRbRy7ztC05pc
         G/VIGgCTNaRx6JGhShZ8sGcHHJs0dogWNHIEQKA8dYwjd3IITvZ5XOyYxLlQriZA/1ey
         Lq5p7IaFjCwtGNNEuk+gxR7S+abV0tBSwj3VKkPT7ykjVW5B4mzSIpxfBWxpqNqIjhIw
         wpS5UExRpyto6Xmj+OT47kJcxinSBkwNxlz8+QY8OfUlKrN/obcumn+D19H5yD4/fwya
         PtYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=Fa9OKlPgIZsak2scOJMVIYdvh3KbHmtnaJtoH8ECQUs=;
        b=c3gDhipcEiVack44papN1C7puH1MepMRcPYyMS+rbmHRyhKpZ3Y70JW8cDhkk0wFtr
         QZ45I/oR3RSDQT/t1BM2XkSYAkpu0ry587AkJvvwikeqtLVJzxKC5EjJeswc9lkET40d
         NlU91Vvs2BCT5lq6drmGHrmtmaTW/q4W9xzr7VWqlSZW/9Esw0uEtgi95fDrGYIZUg92
         lWZBAeZYqCbiKKmK5Ej+NlQW3CwmZA6EBx9M0mid/Km0QLesb+z59AEzqXWuedy/qJoq
         Eni5xdaIaqRrKHTjl5VIGdvpzdIjlnvCY9k5UQJ5OuJkeYh9dAj9gm4gUfplgl2Fwquw
         BBNQ==
X-Gm-Message-State: AGi0PubzmeDD3Oq74sEGcoc+9zh8/GZLGyQUYSJhNG7gBHqRocKri1WU
        f1xXWHf3m+e1ptZTQDXikEALq/QEUMA+0gA6d0umeGbFMVzxjg==
X-Google-Smtp-Source: APiQypJ8bBwlpWCEOAaP7pQmusztAtregiRXSth7aeBUBAsSi6NeAou1FzNCIAbLTy4fkplT61U92IwOnEzRYHaEo2M=
X-Received: by 2002:a92:250e:: with SMTP id l14mr8544680ill.201.1586589256485;
 Sat, 11 Apr 2020 00:14:16 -0700 (PDT)
MIME-Version: 1.0
From:   Keno Fischer <keno@juliacomputing.com>
Date:   Sat, 11 Apr 2020 03:13:40 -0400
Message-ID: <CABV8kRzzs5ktyJTrs+m1uY3QY1v+XS5NrOUB+H4CuhfRS_vvdw@mail.gmail.com>
Subject: ptrace and SIGNAL_UNKILLABLE
To:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc:     Jamie Iles <jamie.iles@oracle.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi folks,

I was seeing some unexpected hangs when ptracing
a buggy container init, that I didn't see when just running
it regularly. Some investigation pointed me to commit

[eb61b5911] signal: don't remove SIGNAL_UNKILLABLE for traced tasks

In particular, consider a container init that just segfaults:

segv.c:
int main(void) {
    return *((int*)-1);
}

$ gcc -o segv segv.c
unshare -p -U -r -f ./segv
Segmentation fault
$ strace -f unshare -p -U -r -f ./segv
[hangs]

The reason this hangs is that above commit prevents ptrace'd
tasks from having their SIGNAL_UNKILLABLE flag removed,
so when the SIGSEGV gets generated, that flag does not get
unset. When strace re-injects the SIGSEGV, it simply gets
ignored, the process re-enters user space and the whole
ordeal starts over.

I considered sending a patch that updates that code-path
to only preserve SIGNAL_UNKILLABLE for SIGTRAP
signals, but I figured that may yet be insufficient as well.

I think a proper solution would probably refactor the signal
code to allow the call side to decide whether or not to clear
this flag (such that ptrace could elect not to, but otherwise
the process is undisturbed), but I'm not familiar enough with
the code to attempt a patch for that.

If this is what's supposed to happen, or it is infeasible to
correct it, it would be useful to have a ptrace option that
can be set, to nevertheless make the injected signal final.
At the moment, I can't think of a good way to inject such a
signal.

Thanks,
Keno
