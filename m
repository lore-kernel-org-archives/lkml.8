Return-Path: <SRS0=KEJG=BY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 623E8C433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Aug 2020 19:37:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3051F20771
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Aug 2020 19:37:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vFrh/C5e"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728475AbgHNThy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Aug 2020 15:37:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726241AbgHNThy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Aug 2020 15:37:54 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE142C061385
        for <linux-kernel@vger.kernel.org>; Fri, 14 Aug 2020 12:37:53 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id h19so11094656ljg.13
        for <linux-kernel@vger.kernel.org>; Fri, 14 Aug 2020 12:37:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=KXusau7VZcU3aLFn1WVMoyYR8TRjaEwEMNs3RQBmuXA=;
        b=vFrh/C5edE330BBrRC0tVOD3NNghE2TTrwxk0arYkURNGG/glEbBFR+NlxmqlrLGkD
         VyxKjvjww11isvlnRMBu+Txbv2+N22vLPxwy4mfAOP37dOefIcpqtfqdH8So4zgf9obn
         cVJwEvaCcghwschihMn6qn/u8vVRrPVzrDv7kNJzXdSkCMrmNjLKqdq8w3uO/hDkPqj5
         LddCl+3T/Hs+MD1kiBaeanlHmxaBGoxGvuEc/nc0R+xpntHVWM8z/F8eBN3wh0QBAf+a
         OFpYxcR9Egn9D5FwdJLIGP3bXZziuFBgjGLi4FhGjLHW+hLbpHLekQ5AH/ripDg+ytB9
         +qsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=KXusau7VZcU3aLFn1WVMoyYR8TRjaEwEMNs3RQBmuXA=;
        b=NktwYjyQ6wL1IeWySevWhcwkx8RtE9ASIOYRIjUoSe9RMP2/sN7YS27MlV7cnQ/uku
         rTyz8nXPrHs6rYjkwswBjg9huzfgfTI8pZhTrKuzCbGq6OHGs/F82I7sozadbzEpMAFn
         4bBHMQne8WIn2U6M4WI/wiL8OEPwlGQugjLM0AQno7u9XWeyNqRs1PKAx8d/B8kOdhI7
         HepXeda3I4J/kWUxTIOsuSFMdFpMXUkvjyLRub1qSHYxACT17K2H31/e0BbYkD6z66nD
         8CpiWFcjjBKWbqeXPpyC3GJwFbbSfOob6UPH/o/oqg1GSyoOLhS342JYOr0qhUC5yDae
         huMw==
X-Gm-Message-State: AOAM5302qbANsR7uv7nKstQ6pN0oJhn8hns2mDzhZDVdD/8XHHHQDLPz
        KGSeYEdcLnEY3dTia+Tvjp3QtUYoVUZC4lpHMQ8b/MmioIeFrA==
X-Google-Smtp-Source: ABdhPJxbRinHselwRuysNPw5XnzuKozqW9Rxu8Z+lj1cYY40KDZyEYrWjXlbS8tJC8vXEC6NTAzJhPewcmSVmlVQ1sQ=
X-Received: by 2002:a2e:95cc:: with SMTP id y12mr1831577ljh.138.1597433870737;
 Fri, 14 Aug 2020 12:37:50 -0700 (PDT)
MIME-Version: 1.0
References: <20200814181617.442787-1-edumazet@google.com> <784A8221-8E96-4C81-B218-4BC4960AA34A@amacapital.net>
In-Reply-To: <784A8221-8E96-4C81-B218-4BC4960AA34A@amacapital.net>
From:   Jann Horn <jannh@google.com>
Date:   Fri, 14 Aug 2020 21:37:24 +0200
Message-ID: <CAG48ez3m9muZVPbxKUiGhUs8CM+i7C19UwwAqGwcpyxWXoqW+A@mail.gmail.com>
Subject: Re: [PATCH] x86/fsgsbase/64: Fix NULL deref in 86_fsgsbase_read_task
To:     Andy Lutomirski <luto@amacapital.net>
Cc:     Eric Dumazet <edumazet@google.com>, Ingo Molnar <mingo@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Eric Dumazet <eric.dumazet@gmail.com>,
        syzbot <syzkaller@googlegroups.com>,
        Andy Lutomirski <luto@kernel.org>,
        "Chang S . Bae" <chang.seok.bae@intel.com>,
        Borislav Petkov <bp@alien8.de>,
        Brian Gerst <brgerst@gmail.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Denys Vlasenko <dvlasenk@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Markus T Metzger <markus.t.metzger@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ravi Shankar <ravi.v.shankar@intel.com>,
        Rik van Riel <riel@surriel.com>,
        Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 14, 2020 at 9:03 PM Andy Lutomirski <luto@amacapital.net> wrote=
:
> > On Aug 14, 2020, at 11:16 AM, Eric Dumazet <edumazet@google.com> wrote:
> >
> > =EF=BB=BFsyzbot found its way in 86_fsgsbase_read_task() [1]
> >
> > Fix is to make sure ldt pointer is not NULL
>
> Acked-by: Andy Lutomirski <luto@kernel.org>
>
> Maybe add something like this to the changelog:
>
> This can happen if ptrace() or sigreturn() pokes an LDT selector into FS =
or GS for a task with no LDT and something tries to read the base before a =
return to usermode notices the bad selector and fixes it.
>
> I=E2=80=99ll see if I can whip up a test case too.

This is the reproducer I used to test this on 4.20.17:

#include <stdio.h>
#include <unistd.h>
#include <err.h>
#include <sys/wait.h>
#include <sys/ptrace.h>
#include <sys/user.h>
#include <sys/prctl.h>
#include <signal.h>
#include <stddef.h>
#include <errno.h>

#define SEL_LDT 0x4
#define USER_RPL 0x3
#define LDT_SELECTOR(idx) (((idx)<<3) | SEL_LDT | USER_RPL)

int main(void) {
  pid_t child =3D fork();
  if (child =3D=3D -1) err(1, "fork");
  if (child =3D=3D 0) {
    prctl(PR_SET_PDEATHSIG, SIGKILL);
    while (1) pause();
  }
  if (ptrace(PTRACE_ATTACH, child, NULL, NULL)) err(1, "PTRACE_ATTACH");
  int status;
  if (waitpid(child, &status, __WALL) !=3D child) err(1, "waitpid");
  if (ptrace( PTRACE_POKEUSER, child, (void*)offsetof(struct
user_regs_struct, fs), (void*)LDT_SELECTOR(0) ))
    err(1, "PTRACE_POKEUSER");
  errno =3D 0;
  unsigned long val =3D ptrace( PTRACE_PEEKUSER, child,
(void*)offsetof(struct user_regs_struct, fs_base), NULL );
  printf("PTRACE_PEEKUSER returns user_regs_struct.fs_base =3D 0x%lx
(%m)\n", val);
}
