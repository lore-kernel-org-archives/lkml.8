Return-Path: <SRS0=zXkI=7F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C56BC433E0
	for <linux-kernel@archiver.kernel.org>; Sat, 23 May 2020 01:01:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 65C1C2072C
	for <linux-kernel@archiver.kernel.org>; Sat, 23 May 2020 01:01:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=juliacomputing-com.20150623.gappssmtp.com header.i=@juliacomputing-com.20150623.gappssmtp.com header.b="d5llxUQO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387473AbgEWBBj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 May 2020 21:01:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731169AbgEWBBi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 May 2020 21:01:38 -0400
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com [IPv6:2607:f8b0:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90AD9C061A0E
        for <linux-kernel@vger.kernel.org>; Fri, 22 May 2020 18:01:38 -0700 (PDT)
Received: by mail-il1-x129.google.com with SMTP id m6so12606861ilq.7
        for <linux-kernel@vger.kernel.org>; Fri, 22 May 2020 18:01:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=juliacomputing-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=9jB6QrDgZByxg+pt4peCfWa82uuzeGjXGF0DmkbgQtU=;
        b=d5llxUQOkoKB6R0cp/rJ4jV/kyDK0SgaJwdQhwn+ecFXc+gGVLLfRHSRM2aDjrXabJ
         4Q++/gNepFhxRansUapiri5gxrkXNOIn8VVs1607kIfcxsJxRaEN2dElX79z7cUdsahH
         0PEyrL+Ts7hNvM94sR+RSEJV9zZdOAos9/VOTyT3jYnpnCK/jVpO4YgRSS8Q2+iykhbk
         2vP2tpQEFVm95E7bgxurKLw+Fn5VNHnUuujeKUQEMRhegTPkaOuJtUsyQZv4DB8MKkFn
         /WSaIiY083y1LVM6GtcwrGQjLd2oZD+yh7AHbb5KW+0j8Jzi7RUSKL+RhJ45wT3q9wJD
         jnfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=9jB6QrDgZByxg+pt4peCfWa82uuzeGjXGF0DmkbgQtU=;
        b=Itp8vt2jLSl/xoppngP/4eC2wPp0G1wOyMRd4mJoz6MaeSgo0UuOcl8uyETumZIN0b
         WJn3VJrQgoxAr0K4J4+XwCB8Z/XK5b62jAIVAc5SC9xQTxo/RAUToe29AGqWpEF5UkQ8
         QikNgO2l/lzayJpBxkmIkdNEb9yNOUbg6yqiMb+ymsHx2noYuATw7V5XotaiPwtPB5yQ
         dfbkRaxuqXHvdRX+x94YOzm/pwT5W3r2azK3mZ+aFKSnN4snkuvrqI0fsTVpWQ+zrr2j
         4LvAM23jebrlqSEaGLALOBfVPri3dL0m0md9ra48mmSqeGHvV3BBgsvlSlLeHwubujkF
         mm1g==
X-Gm-Message-State: AOAM5339lqA1CVell9tcgn8niAwNyMLcs4bWSAwqENxDqFlHHtulbz3W
        EynxV1G1nJbkELPyL8AlHd+EHThSR6576d1otqus3WKe
X-Google-Smtp-Source: ABdhPJw7iX7s2yMi6Rl4D0GaANdyKcUke/dejY2JEBE+hXX6jKQR9j2/+6B0U4C9JxxcCINBcnNm+h7kWstaL092BuE=
X-Received: by 2002:a92:3c0f:: with SMTP id j15mr15895265ila.201.1590195696808;
 Fri, 22 May 2020 18:01:36 -0700 (PDT)
MIME-Version: 1.0
From:   Keno Fischer <keno@juliacomputing.com>
Date:   Fri, 22 May 2020 21:01:01 -0400
Message-ID: <CABV8kRxA9mXPZwtYrjbAfOfFewhABHddipccgk-LQJO+ZYu4Xg@mail.gmail.com>
Subject: ptrace: seccomp: Return value when the call was already invalid
To:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc:     Oleg Nesterov <oleg@redhat.com>, Will Deacon <will@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Will Drewry <wad@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I'm seeing the following while porting a ptracer from
x86_64 to arm64 (cc'ing arm64 folks, but in this case
x86_64 is the odd one out, I think other archs would
be consistent with arm64).

Consider userspace code like the following:
```
int ret = syscall(-10, 0);
assert(ret == -ENOSYS);
```

(Never mind the fact that this is something userspace
shouldn't do, I saw this in our test suite that tests
corner cases where the ptracer shouldn't affect behavior).

Now, if we have a seccomp filter that simply does
SECCOMP_RET_TRACE, and a ptracer that simply
does PTRACE_CONT, then the assert will fire/fail on arm64,
but not on x86_64.

The reason this happens is that the return value gets set
early on x86_64, but this is not possible on arm64,
because doing so would clobber the first argument
register that it shares. As a result, no return value is
set and `ret` retains the value that the first syscall
argument used to have.

I can work around this of course, but I guess my
question is whether this is expected/ok,
or you would expect an active ptracer that does not
touch the registers not to affect behavior.

Interestingly, arm64 does do something different
if the syscall is -1 rather than -10, where early
in the ptrace stop it does.
```
/* set default errno for user-issued syscall(-1) */
if (scno == NO_SYSCALL)
    regs->regs[0] = -ENOSYS;
```

I'm not sure that's great either since the ptracer
may want to inspect x0 and arm64 does not
make orig_x0 available via ptrace. To me
this indicates that maybe this was intended
to apply to any syscall skipped here, not
just -1 (the different comes from the fact
that seccomp considers any negative
syscall a skip/fail, but on syscall-entry
stops arm64 only considers a literal -1
a skip).

On the other hand if this is deemed expected,
I'll go ahead and submit a man-page patch to at
least document this architecture difference.

Keno
