Return-Path: <SRS0=iZC5=5S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AB77C43331
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 02:35:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A92C2072E
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 02:35:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="A6wogXWb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387436AbgDBCfW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Apr 2020 22:35:22 -0400
Received: from mail-lj1-f170.google.com ([209.85.208.170]:34201 "EHLO
        mail-lj1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732664AbgDBCfV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Apr 2020 22:35:21 -0400
Received: by mail-lj1-f170.google.com with SMTP id p10so1644178ljn.1
        for <linux-kernel@vger.kernel.org>; Wed, 01 Apr 2020 19:35:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=ce4+jt1QnAedyVF+O0B43RTY85VjYC1oRuPq2H/Wy7k=;
        b=A6wogXWb5tIgKQaMIGu+zexhgOwdF6lvWAZm6SmTGOJJnskmH/gBZkeLs280lc9mCO
         76K5tHRHF4bNPBFY1Vw3xv/9kq5Dr5z498LI8cgExeQLhvzQx1m2F7QHYF4+dItfiqPC
         ECRlkqxZn7xuEYE0nqIxocSu12YOryDxx7NKkYYfx5xOoD2qPQsMG09WDVc0TQHDFAwe
         FoOp3yCdSi2sIKf8B95fjPdXWjsMhNsoPcv2TnpUkB9dote+qhBOl3SM4hrV0s3OsqhX
         gqlCnOtXyW93zxJkpnd1o7QcfHXxxDy3zwD2Doa4MmUyJV1LZeCgrJFBmMpEXVg0B+Fo
         5HVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=ce4+jt1QnAedyVF+O0B43RTY85VjYC1oRuPq2H/Wy7k=;
        b=WsFGOOzYrNRNO+Prixq+lSG4k5BQhRBkaDzGRPkUu8RvLFdPvuC2QVfyI1jFUPoa97
         VvrtSJ5a+EGqXfnxdifiBDiJJEPqg2J1B3GdwSPm2s8P89D6vLViOM295m1CHrdlmUSy
         vXIhC1/XoVFfLHNK6L/6v+sNCOZ2cMzNxrjN987R604N6G1LkFUHXJTAXd5H9u/vZ43Y
         o0wSMt4Ys0+92YdWSrwb4+q1Za7+2zK75xoJVaWM5cXV7N0hoZZ49hoPz2s/X1Qvj75K
         IaEI7rR77Xu326A+B5hxoNtdM4uTndhd4Dyz9iSSDUjU0Wk9dBkvMC42OHuQtD2IU46o
         p8Jw==
X-Gm-Message-State: AGi0PuZX+WuEgnuHvVMwuMRAgTKfIDtADZ4hG6ULGm7UI1vZP9YuBpse
        U0Fc9lqCFq602cglDwCI1ImyqDpN4oxIIdt1UztW/A==
X-Google-Smtp-Source: APiQypJpsCcfgA88Rqg61SjKw/yEVQICGOjzMNwDc7ZgAnbArwj2jd/Vav3GV4epq4pobOo308nYOYZ95TdiDSNZSBI=
X-Received: by 2002:a2e:9247:: with SMTP id v7mr575345ljg.215.1585794918859;
 Wed, 01 Apr 2020 19:35:18 -0700 (PDT)
MIME-Version: 1.0
From:   Jann Horn <jannh@google.com>
Date:   Thu, 2 Apr 2020 04:34:52 +0200
Message-ID: <CAG48ez2Sx4ELkM94aD_h_J7K7KBOeuGmvZLKRkg3n_f2WoZ_cg@mail.gmail.com>
Subject: AMD DC graphics display code enables -mhard-float, -msse, -msse2
 without any visible FPU state protection
To:     Harry Wentland <harry.wentland@amd.com>,
        Leo Li <sunpeng.li@amd.com>, amd-gfx@lists.freedesktop.org,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        "David (ChunMing) Zhou" <David1.Zhou@amd.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Andy Lutomirski <luto@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[x86 folks in CC so that they can chime in on the precise rules for this stuff]

Hi!

I noticed that several makefiles under drivers/gpu/drm/amd/display/dc/
turn on floating-point instructions in the compiler flags
(-mhard-float, -msse and -msse2) in order to make the "float" and
"double" types usable from C code without requiring helper functions.

However, as far as I know, code running in normal kernel context isn't
allowed to use floating-point registers without special protection
using helpers like kernel_fpu_begin() and kernel_fpu_end() (which also
require that the protected code never blocks). If you violate that
rule, that can lead to various issues - among other things, I think
the kernel will clobber userspace FPU register state, and I think the
kernel code can blow up if a context switch happens at the wrong time,
since in-kernel task switches don't preserve FPU state.

Is there some hidden trick I'm missing that makes it okay to use FPU
registers here?

I would try testing this, but unfortunately none of the AMD devices I
have here have the appropriate graphics hardware...
