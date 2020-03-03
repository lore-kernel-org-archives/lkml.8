Return-Path: <SRS0=fZJt=4U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A95F3C3F2D7
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 22:25:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E41620728
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 22:25:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="k4b8wlNW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727727AbgCCWZv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Mar 2020 17:25:51 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:40691 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726766AbgCCWZv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Mar 2020 17:25:51 -0500
Received: by mail-wr1-f68.google.com with SMTP id r17so6491140wrj.7
        for <linux-kernel@vger.kernel.org>; Tue, 03 Mar 2020 14:25:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=gvAxgZ/6W5bHeK8l8B5LmkTF734H/cPgrewZ41WzMkc=;
        b=k4b8wlNWPojtXCMpFiS5KbV5zlyci+qf48lnJA1vBqcTxUWZCsgg00p4o+pICG5jpO
         tyU/foUtvQ7+agLbpxyypl2czslVNrxX/3Z9JKGNJlRHP08hjLWhWQwTWwc0EO4+ti1k
         I5lRxtvZuUHgTy8zqHmU63CoH8bm8+YITh5/Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=gvAxgZ/6W5bHeK8l8B5LmkTF734H/cPgrewZ41WzMkc=;
        b=mxRpg1bMQmkN1PY0dd4VFo2MvlEAQFQaWsgtdlRVWtIHsPnl2R1jssL69lkxsBN7+u
         DIa/hTxcDsLKXmTjbUZjesWJp3LWgZKyu09dxqRsP9dIEz3ZY9GTptxGAZkTIG9AUQeo
         7mYVfINQKVOiOiqsnRqFQyv1hzx+FyWFiPX7qMPnoGMQsan3QokvFdvJqxDlRQTHVbcf
         U5cbDt+iSHQsL1SbRZp1I5tW5MjkqhQhWgeLPnpL8eKmDly2dIu6RDli6hRCl/4A6YMW
         R7+C1AnFi7ZpBxPMwwBSdG4fx3kl9ekEITaL/1euztZz7/KLC6MMWiJX3RWyNTwE1sCF
         DpfA==
X-Gm-Message-State: ANhLgQ0pUVSTyKz6I5jj/0o6FeY/TxHOS2iZLTasD9xknk/2XMiZGLlj
        /cQIga7re6XAbyrlbnKa+cHayA==
X-Google-Smtp-Source: ADFU+vv2TJ9FcPkQkdag3Z1Df0H/CDA2sb5SwJJWT2VDsOjP5odYh+TSewkESskLrzLfwwBE/5jpSQ==
X-Received: by 2002:a5d:62c9:: with SMTP id o9mr83887wrv.2.1583274347840;
        Tue, 03 Mar 2020 14:25:47 -0800 (PST)
Received: from chromium.org (77-56-209-237.dclient.hispeed.ch. [77.56.209.237])
        by smtp.gmail.com with ESMTPSA id a7sm37190726wrm.29.2020.03.03.14.25.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Mar 2020 14:25:47 -0800 (PST)
From:   KP Singh <kpsingh@chromium.org>
X-Google-Original-From: KP Singh <kpsingh>
Date:   Tue, 3 Mar 2020 23:25:45 +0100
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     open list <linux-kernel@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Paul Turner <pjt@google.com>,
        Florent Revest <revest@chromium.org>,
        Brendan Jackman <jackmanb@chromium.org>
Subject: Re: [PATCH bpf-next 0/7] Introduce BPF_MODIFY_RET tracing progs.
Message-ID: <20200303222545.GB3272@chromium.org>
References: <20200303140950.6355-1-kpsingh@chromium.org>
 <CAEf4BzZkkbf0a-pCcmxq6+=XdJH6H7pPwbzq=UiMKRpWnJceyA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEf4BzZkkbf0a-pCcmxq6+=XdJH6H7pPwbzq=UiMKRpWnJceyA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03-Mär 14:12, Andrii Nakryiko wrote:
> On Tue, Mar 3, 2020 at 6:12 AM KP Singh <kpsingh@chromium.org> wrote:
> >
> > From: KP Singh <kpsingh@google.com>
> >
> > This was brought up in the KRSI v4 discussion and found to be useful
> > both for security and tracing programs.
> >
> >   https://lore.kernel.org/bpf/20200225193108.GB22391@chromium.org/
> >
> > The modify_return programs are allowed for security hooks (with an
> > extra CAP_MAC_ADMIN check) and functions whitelisted for error
> > injection (ALLOW_ERROR_INJECTION).
> >
> > The "security_" check is expected to be cleaned up with the KRSI patch
> > series.
> >
> > Here is an example of how a fmod_ret program behaves:
> >
> > int func_to_be_attached(int a, int b)
> > {  <--- do_fentry
> >
> > do_fmod_ret:
> >    <update ret by calling fmod_ret>
> >    if (ret != 0)
> >         goto do_fexit;
> >
> > original_function:
> >
> >     <side_effects_happen_here>
> >
> > }  <--- do_fexit
> >
> > ALLOW_ERROR_INJECTION(func_to_be_attached, ERRNO)
> >
> > The fmod_ret program attached to this function can be defined as:
> >
> > SEC("fmod_ret/func_to_be_attached")
> > BPF_PROG(func_name, int a, int b, int ret)
> 
> nit: int BPF_PROG(...)

Noted. Thanks!

- KP

> 
> 
> > {
> >         // This will skip the original function logic.
> >         return -1;
> > }
> >
> > KP Singh (7):
> >   bpf: Refactor trampoline update code
> >   bpf: JIT helpers for fmod_ret progs
> >   bpf: Introduce BPF_MODIFY_RETURN
> >   bpf: Attachment verification for BPF_MODIFY_RETURN
> >   tools/libbpf: Add support for BPF_MODIFY_RETURN
> >   bpf: Add test ops for BPF_PROG_TYPE_TRACING
> >   bpf: Add selftests for BPF_MODIFY_RETURN
> >
> >  arch/x86/net/bpf_jit_comp.c                   | 261 +++++++++++++-----
> >  include/linux/bpf.h                           |  24 +-
> >  include/uapi/linux/bpf.h                      |   1 +
> >  kernel/bpf/bpf_struct_ops.c                   |  13 +-
> >  kernel/bpf/btf.c                              |  27 +-
> >  kernel/bpf/syscall.c                          |   1 +
> >  kernel/bpf/trampoline.c                       |  66 +++--
> >  kernel/bpf/verifier.c                         |  32 +++
> >  kernel/trace/bpf_trace.c                      |   1 +
> >  net/bpf/test_run.c                            |  57 +++-
> >  tools/include/uapi/linux/bpf.h                |   1 +
> >  tools/lib/bpf/libbpf.c                        |   4 +
> >  .../selftests/bpf/prog_tests/fentry_fexit.c   |  12 +-
> >  .../selftests/bpf/prog_tests/fentry_test.c    |  14 +-
> >  .../selftests/bpf/prog_tests/fexit_test.c     |  69 ++---
> >  .../selftests/bpf/prog_tests/modify_return.c  |  65 +++++
> >  .../selftests/bpf/progs/modify_return.c       |  49 ++++
> >  17 files changed, 509 insertions(+), 188 deletions(-)
> >  create mode 100644 tools/testing/selftests/bpf/prog_tests/modify_return.c
> >  create mode 100644 tools/testing/selftests/bpf/progs/modify_return.c
> >
> > --
> > 2.20.1
> >
