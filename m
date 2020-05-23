Return-Path: <SRS0=zXkI=7F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDE6FC433E0
	for <linux-kernel@archiver.kernel.org>; Sat, 23 May 2020 05:36:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BF6B62067B
	for <linux-kernel@archiver.kernel.org>; Sat, 23 May 2020 05:36:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=juliacomputing-com.20150623.gappssmtp.com header.i=@juliacomputing-com.20150623.gappssmtp.com header.b="qMvYuAdV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387581AbgEWFg0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 May 2020 01:36:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387448AbgEWFg0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 May 2020 01:36:26 -0400
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com [IPv6:2607:f8b0:4864:20::d44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BF9CC061A0E
        for <linux-kernel@vger.kernel.org>; Fri, 22 May 2020 22:36:26 -0700 (PDT)
Received: by mail-io1-xd44.google.com with SMTP id u23so699487iot.12
        for <linux-kernel@vger.kernel.org>; Fri, 22 May 2020 22:36:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=juliacomputing-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DVZxSzwA9CzmHdFAV6csNI6NcE4soWE2wwHJyC9WY5Q=;
        b=qMvYuAdVwUstM5eZ8s2mMEM8Ffoq9J6r6BAyMyrup91tDDA2gOAopct2F0cZeqIG2c
         jdFWXURIwOl3uGtdzoV2oSU2My6F9wuXgNOf4Zn/m3U3FR7bweX3y2OxhXQZtlcJV643
         rgQnusORMVgBOBmlHc9W2xK7eD4i/MXNnK4/huoRCnAC/YQihLlMnHsxmbH/00rLYj8q
         lJAsW+qLpmbowd+K6xXi6jiN3uqHow/zv4bxty46haOCK09jGM++retbTy4gpqKDO/th
         nlNvn/OQUi+OkcsOVosZJoCTmb08UCzjNz/LLGkS9cEkT1lByiRcoa2fA94Gx9FU7tvy
         kbbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DVZxSzwA9CzmHdFAV6csNI6NcE4soWE2wwHJyC9WY5Q=;
        b=WcUnXSGDYIpSN11d+opDdQM+vpLRTnB9hWxygBTTL3GN0j209tWyaZBu1oBEoQ2NPq
         yXAEvzRxGPBHt8gzURGCCiRCQs5pJq7u6IQcpxvoGXOfjWL0IsOLUgxjG2ZueWt9KBse
         ad6ZJxe/PozJO5EhMczX/crblSeewoL/r/JGtH8pr1itRaGIPQKX+QRHf8cuFH4spogY
         eZcxREnhpmKke1fsDbTCOeW3z690zBdRZmOZNosC2QcMHRUnIS8qP+5EIvMKKMZhjWFU
         JCcX962cPwl1GYIjyDn1au/vQVUIA5AF8S/SL25nuf6nuhBHZSgCH4COGnPmjv5U6xJl
         2ymw==
X-Gm-Message-State: AOAM531s2kKNddpSeWGblJY0RrZlEoxbjku///ydaF0+jkCwjfqAVu07
        EdKi1jDuoLLitzzRcZsd5QaP+w23toqYyqvXp8+hkA==
X-Google-Smtp-Source: ABdhPJygfAADWFIVVeKLOzuHLZ54mAL22TlmO1KsSyLvvSTqwOCPP4AqjyPGea1zXbUC8Ho43ZWh/OFlOSyZa62I/GE=
X-Received: by 2002:a02:245:: with SMTP id 66mr764401jau.69.1590212185421;
 Fri, 22 May 2020 22:36:25 -0700 (PDT)
MIME-Version: 1.0
References: <CABV8kRz0mKSc=u1LeonQSLroKJLOKWOWktCoGji2nvEBc=e7=w@mail.gmail.com>
 <20200519081551.GA9980@willie-the-truck> <CABV8kRzYzBrdzC1_opmmdpW63N2htfOsAUZ+RjiSDsy=SJW6Yg@mail.gmail.com>
 <20200520174149.GB27629@willie-the-truck>
In-Reply-To: <20200520174149.GB27629@willie-the-truck>
From:   Keno Fischer <keno@juliacomputing.com>
Date:   Sat, 23 May 2020 01:35:49 -0400
Message-ID: <CABV8kRzjCCsjVeRsBD7U_Lo0==sBw9EKm=1z7g=60KyJvJLZBQ@mail.gmail.com>
Subject: Re: arm64: Register modification during syscall entry/exit stop
To:     Will Deacon <will@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Kyle Huey <khuey@pernos.co>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I got bitten by this again, so I decided to write up a simple example
that shows the problem:

https://gist.github.com/Keno/cde691b26e32373307fb7449ad305739

This runs the same child twice. First vanilla where it prints "Hello world".
The second time, using a textbook ptrace example, to only print "world".
The problem here is that by the time the ptracer gets around to restoring
the registers, it's no longer in a syscall stop, so the write to x7 does not
get ignored and the correct value of x7 gets clobbered.
I copied the syscall definition from musl, so the compiler thinks x7 is
live, and we can see an assertion.

Output on my machine (will depend on compiler version, etc.):
```
$ gcc -g3 -O3 ptrace_lies.c
$ ./a.out
Hello World
World
a.out: ptrace_lies.c:49: do_child: Assertion `v3 == values[2]' failed.
a.out: ptrace_lies.c:134: main: Assertion `WIFEXITED(status) &&
WEXITSTATUS(status) == 0' failed.
Aborted (core dumped)
```

However, I don't think that whether or not the compiler thinks that x7 is
live is the problem here. The problem is entirely that this mechanism
prevents the ptracer from precisely controlling the register state. While
basic ptracers don't need this feature (strace),
more advanced ptracers (think criu, etc.) absolutely do want to precisely
control what the register state is.
The ptracer I'm working on (https://rr-project.org/)
happens to be an extreme case of this, where it wants *bitwise* equivalent
register states such that it can run the same code many times and get
the exact same results.

Also, if the issue was just that the kernel clobbered x7, that would be fine
we could deal with that no problem. However, it's much worse than that,
because the behavior of the kernel with respect to x7 depends on what
kind of ptrace stop we're in and even worse, in some kinds of stop,
there's absolutely no way to get at the actual value of x7.

> Hmm, does that actually result in the SVC instruction getting inlined? I
> think that's quite dangerous, since we document that we can trash the SVE
> register state on a system call, for example. I'm also surprised that
> the register variables are honoured by compilers if that inlining can occur.

I haven't gotten to trying SVE yet, so I appreciate the warning :). That said,
deterministic clobbering of registers is fine. Even changing the registers to
random junk is fine. We're happy to read those registers through ptrace.
The problem here is that the kernel lies about what the contents of the x7
register is and discards any writes to it.

I really hope we can come up with a solution here, I'm already dreading
the next time I unexpectedly run into this and have to add yet
another special case :(.

Keno
