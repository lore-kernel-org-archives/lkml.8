Return-Path: <SRS0=1210=4J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FAKE_REPLY_C,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 488A8C35669
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 23:09:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 155A8206EF
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 23:09:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="D/ui6mhf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726044AbgBUXJj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Feb 2020 18:09:39 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:53542 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727273AbgBUXJi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Feb 2020 18:09:38 -0500
Received: by mail-wm1-f65.google.com with SMTP id s10so3399462wmh.3
        for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2020 15:09:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:date:to:cc:subject:message-id:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=ErSLOhP8cH6/i4WEty75XIcQhtj43iqEl60JDrRHWwc=;
        b=D/ui6mhfoNsquR4JxpneqHDBHp5E4D7oJClgkV6ieDV9xFohEYJ4LOwBmt/V4R0YJZ
         qN46W4dnwOMYVnXt4HPMicTv2PLivH5Rk5xbtc1qp3wawYwYoyhzPmGgjYJ57mY+/3WY
         GCCsThB+itDJ/0CbtGSi4GvbSQNcT8+FleCIg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=ErSLOhP8cH6/i4WEty75XIcQhtj43iqEl60JDrRHWwc=;
        b=rggc9wM793FfGkzU/7gVdAA8Sx68D7nqSkbCJtA5iK7FxbdDFSr5uOA1DNZvZMTErn
         D7jLR8OwqhmZVleGQPmnBp9vYccclFGtUUbp50k3+78OJBlMtNQYaMcwcDA6CAZm+wW1
         1G26UBUbstL3hcK4bIYVuP0ZIcSvANhATnV0BZojKYeuW+hthLTH5E6hUzXZYSiU0ARE
         Bnp9UmVv0og2ejbPmyTTGvvQh6zxnH7nDL6T8LUxI2QmyeHbpfEL0ZMg9GkD6WP5jtmV
         V5Wynq1FkSVrOHLuxxvwcrumLBKdLnagLZf2UPfDgkc4AwQxv7JfRN+NpMto8qS0TGXN
         VQWA==
X-Gm-Message-State: APjAAAX4ftQ4DdN8giUlcdKA+49AF9giNU5mw8FY5Etaw8PFUUiGlijR
        TDUNnRMNPNvLyN/x6iynLonViQ==
X-Google-Smtp-Source: APXvYqz/ZGDWmsdrZBhy/dLmKc4u/bAxInlKpGlPlpNVMwQ+tujBaJPyW0zkhJ4UDXdOZkDerm3PDQ==
X-Received: by 2002:a1c:b603:: with SMTP id g3mr5985561wmf.130.1582326575877;
        Fri, 21 Feb 2020 15:09:35 -0800 (PST)
Received: from chromium.org (77-56-209-237.dclient.hispeed.ch. [77.56.209.237])
        by smtp.gmail.com with ESMTPSA id q9sm5895723wrx.18.2020.02.21.15.09.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Feb 2020 15:09:35 -0800 (PST)
From:   KP Singh <kpsingh@chromium.org>
X-Google-Original-From: KP Singh <kpsingh>
Date:   Sat, 22 Feb 2020 00:09:33 +0100
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     Linux Security Module list 
        <linux-security-module@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
        James Morris <jmorris@namei.org>,
        Kees Cook <keescook@chromium.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Subject: Re: [PATCH bpf-next v4 0/8] MAC and Audit policy using eBPF (KRSI)
Message-ID: <20200221230933.GA23663@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8a2a2d59-ec4b-80d1-2710-c2ead588e638@schaufler-ca.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks Casey,

I appreciate your quick responses!

On 21-Feb 14:31, Casey Schaufler wrote:
> On 2/21/2020 11:41 AM, KP Singh wrote:
> > On 21-Feb 11:19, Casey Schaufler wrote:
> >> On 2/20/2020 9:52 AM, KP Singh wrote:
> >>> From: KP Singh <kpsingh@google.com>
> >> Again, apologies for the CC list trimming.
> >>
> >>> # v3 -> v4
> >>>
> >>>   https://lkml.org/lkml/2020/1/23/515
> >>>
> >>> * Moved away from allocating a separate security_hook_heads and adding a
> >>>   new special case for arch_prepare_bpf_trampoline to using BPF fexit
> >>>   trampolines called from the right place in the LSM hook and toggled by
> >>>   static keys based on the discussion in:
> >>>
> >>>     https://lore.kernel.org/bpf/CAG48ez25mW+_oCxgCtbiGMX07g_ph79UOJa07h=o_6B6+Q-u5g@mail.gmail.com/
> >>>
> >>> * Since the code does not deal with security_hook_heads anymore, it goes
> >>>   from "being a BPF LSM" to "BPF program attachment to LSM hooks".

[...]

> >> likely harmful.
> > We will be happy to document each of the macros in detail. Do note a
> > few things here:
> >
> > * There is really nothing magical about them though,
> 
> 
> +#define LSM_HOOK_void(NAME, ...) \
> +	noinline void bpf_lsm_##NAME(__VA_ARGS__) {}
> +
> +#include <linux/lsm_hook_names.h>
> +#undef LSM_HOOK
> 
> I haven't seen anything this ... novel ... in a very long time.

This is not "novel", it's a fairly common pattern followed in tracing:

For example, the TRACE_INCLUDE macro which is used for tracepoints:

  include/trace/define_trace.h

and used in:

  * include/trace/bpf_probe.h

    https://github.com/torvalds/linux/blob/master/include/trace/bpf_probe.h#L110

  * include/trace/perf.h

    https://github.com/torvalds/linux/blob/master/include/trace/perf.h#L90

  * include/trace/trace_events.h

    https://github.com/torvalds/linux/blob/master/include/trace/trace_events.h#L402

> I see why you want to do this, but you're tying the two sets
> of code together unnaturally. When (not if) the two sets diverge
> you're going to be introducing another clever way to deal with

I don't fully understand what "two sets diverge means" here. All the
BPF headers need is the name, return type and the args. This is the
same information which is needed by the call_{int, void}_hooks and the
LSM declarataions (i.e. security_hook_heads and
security_list_options).

> the special case.
> 
> It's not that I don't understand what you're doing. It's that
> I don't like what you're doing. Explanation doesn't make me like
> it better.

As I have previously said, we will be happy to (and have already)
updated our approach based on the consensus we arrive at here. The
best outcome would be to not sacrifice performance as the LSM hooks
are called from various performance critical code-paths.

It would be great to know the maintainers' (BPF and Security)
perspective on this as well.

- KP

> 
> >  the LSM hooks are
> >   collectively declared in lsm_hook_names.h and are used to delcare
> >   the security_list_options and security_hook_heads for the LSM
> >   framework (this was previously maitained in two different places):
> >
> >   For BPF, they declare:
> >
> >     * bpf_lsm_<name> attachment points and their prototypes.
> >     * A static key (bpf_lsm_key_<name>) to enable and disable these
> >        hooks with a function to set its value i.e.
> >        (bpf_lsm_<name>_set_enabled).
> >
> > * We have kept the BPF related macros out of security/.
> > * All the BPF calls in the LSM infrastructure are guarded by
> >   CONFIG_BPF_LSM (there are only two main calls though, i.e.
> >   call_int_hook, call_void_hook).
> >
> > Honestly, the macros aren't any more complicated than
> > call_int_progs/call_void_progs.
> >
> > - KP
> >
> >> Would you please drop the excessive optimization? I understand
> >> that there's been a lot of discussion and debate about it,
> >> but this implementation is out of control, disruptive, and
> >> dangerous to the code around it.
> >>
> >>
> 
