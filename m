Return-Path: <SRS0=gmpU=CI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 694C0C433E6
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Aug 2020 04:41:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3C6A2208DB
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Aug 2020 04:41:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oIvGVXCN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726078AbgH3Ek5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Aug 2020 00:40:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725815AbgH3Ekz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Aug 2020 00:40:55 -0400
Received: from mail-il1-x143.google.com (mail-il1-x143.google.com [IPv6:2607:f8b0:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7059CC061573
        for <linux-kernel@vger.kernel.org>; Sat, 29 Aug 2020 21:40:55 -0700 (PDT)
Received: by mail-il1-x143.google.com with SMTP id q14so3947708ilm.2
        for <linux-kernel@vger.kernel.org>; Sat, 29 Aug 2020 21:40:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HHWDMq/nbO4xHE4a0KqcQiAEa78+4OGfNY+553VihpA=;
        b=oIvGVXCNlLGgwIZeCgWK+LINRZM6tE8Fy0EICDHiZqnaqDcBZaxirt4X7zZZzXpN+I
         m8Iye277Hzg8IzN5WcPFqm8R4U6o2lTwrv3mdi7/6zbfNOjMYPDr5sS7JcFV/Fi1d8W7
         mqQY5NKNRemjIm9VF6eEebcNaXWrLLkQuUo2sFAG5ZQn+hGVFpCIvDkIup35FPjeVnb9
         paGHyjWKtJeVeEBs8VS0C1x7Y0wo8oAGImx2vzHQM9JrYO8SKn/QNdx+FdJ1DSfqCfFW
         1JmSo6quY+Drh2k5ofagjJUCfAzcxBGe5tNyct5JFg5EhiVlgPVNIxQN3m+MFghZ/reK
         /abg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HHWDMq/nbO4xHE4a0KqcQiAEa78+4OGfNY+553VihpA=;
        b=JUn8qBEul35RBi69dYhRBhF5erbOwHgHDjl/X4NRueEtuRhpXp8tZzSfNhZ7N9GcV3
         Ys44nEGucwVjThUPCK5eS/fLRovQgxFDAz13BpUKZ5HjT4l6E8OanFKXiQJKGpk77k9p
         j3miePHJ0Kj9w9xIQ/S38UIBWTdhdLDWFtNmkkjwqFv57q5BoUXsHkjVELjTJvPQSCaP
         GiNilYRXdP+xPYq/hi7Q/NwoW517N1ZBIEJSeGi2fsm5MXGD9PTMTOr8Wng8jWeu971O
         Bg6G+Rud7MZzx77lyY6oOFpZZ/AgwYy5zzHUECTjTU5tcPqkZDsaqpZnHnVyCRFjLz41
         z0rA==
X-Gm-Message-State: AOAM532o0WmsbU0Zv1nrZM4G+2pgIVJheF9+NJihkgZP24i/j0x1BB76
        dGnxwt86kFqeAwb/PhLtDRe1gkSh4MxHYCERzQ==
X-Google-Smtp-Source: ABdhPJyswRQJrqQ6CNwwCr4ZFRbkXMz3EXEYiZmPALIPayfK8vBxYKHmTP+7ld1GVqWc67Sn09tff89X/btVnlDY8DI=
X-Received: by 2002:a92:6a09:: with SMTP id f9mr4725159ilc.273.1598762453371;
 Sat, 29 Aug 2020 21:40:53 -0700 (PDT)
MIME-Version: 1.0
References: <CALCETrWXvAMA7tQ3XZdAk2FixKfzQ_0fBmyNVyyPHVAomLvrWQ@mail.gmail.com>
In-Reply-To: <CALCETrWXvAMA7tQ3XZdAk2FixKfzQ_0fBmyNVyyPHVAomLvrWQ@mail.gmail.com>
From:   Brian Gerst <brgerst@gmail.com>
Date:   Sun, 30 Aug 2020 00:40:42 -0400
Message-ID: <CAMzpN2hmR+0-Yse1csbiVOiqgZ0e+VRkCBBXUKoPSTSMOOOFAQ@mail.gmail.com>
Subject: Re: ptrace_syscall_32 is failing
To:     Andy Lutomirski <luto@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>, X86 ML <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 29, 2020 at 12:52 PM Andy Lutomirski <luto@kernel.org> wrote:
>
> Seems to be a recent regression, maybe related to entry/exit work changes.
>
> # ./tools/testing/selftests/x86/ptrace_syscall_32
> [RUN]    Check int80 return regs
> [OK]    getpid() preserves regs
> [OK]    kill(getpid(), SIGUSR1) preserves regs
> [RUN]    Check AT_SYSINFO return regs
> [OK]    getpid() preserves regs
> [OK]    kill(getpid(), SIGUSR1) preserves regs
> [RUN]    ptrace-induced syscall restart
>     Child will make one syscall
> [RUN]    SYSEMU
> [FAIL]    Initial args are wrong (nr=224, args=10 11 12 13 14 4289172732)
> [RUN]    Restart the syscall (ip = 0xf7f3b549)
> [OK]    Restarted nr and args are correct
> [RUN]    Change nr and args and restart the syscall (ip = 0xf7f3b549)
> [OK]    Replacement nr and args are correct
> [OK]    Child exited cleanly
> [RUN]    kernel syscall restart under ptrace
>     Child will take a nap until signaled
> [RUN]    SYSCALL
> [FAIL]    Initial args are wrong (nr=29, args=0 0 0 0 0 4289172732)
> [RUN]    SYSCALL
> [OK]    Args after SIGUSR1 are correct (ax = -514)
> [OK]    Child got SIGUSR1
> [RUN]    Step again
> [OK]    pause(2) restarted correctly

Bisected to commit 0b085e68f407 ("x86/entry: Consolidate 32/64 bit
syscall entry").
It looks like it is because syscall_enter_from_user_mode() is called
before reading the 6th argument from the user stack.

--
Brian Gerst
