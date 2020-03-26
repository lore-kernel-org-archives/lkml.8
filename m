Return-Path: <SRS0=aGSP=5L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40F25C43331
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 19:39:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1333520719
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 19:39:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ae4waGDS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728629AbgCZTj0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Mar 2020 15:39:26 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:54103 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728236AbgCZTjZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Mar 2020 15:39:25 -0400
Received: by mail-wm1-f66.google.com with SMTP id b12so8019395wmj.3
        for <linux-kernel@vger.kernel.org>; Thu, 26 Mar 2020 12:39:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=krcVqiMkQPdhe4hMOEoqIQl0MN9jc0hPZ4AdMO9emGc=;
        b=ae4waGDSfrW9e13opPTyj3EkP01ZIr9H99lNvLUCbfhdmjAkVIUtf8myeSBASMioQ6
         5sCM+aSj8GGGtOOkAKA2sF1svVbQ++wWd19/SurEr9i3eRmKckpaJhNNdJcmhr+X+2S/
         4ey4IIauUMub88gCWUR3ECmD1rDjjStPObuGw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=krcVqiMkQPdhe4hMOEoqIQl0MN9jc0hPZ4AdMO9emGc=;
        b=Lj/1CLkbrMc+pWjDq+pdd+51JB3rCGDBeCJ6WcbllF1iQKXXRQN5s11woP+JpAGey6
         wDJsRPG0Hoz6G6AEJcdfFd+Tw2kRmUa1rnUHkpr4I6x+l4ta2obqt4qb5DyiS5ZjjiFp
         Dhfe0csExvmZSqq0nPC8PgPKbVpKk36X+hL1WcvDdDVeS3Sel/j2Mor1AOzH9PMlZpHh
         rn7Z0AE5RxcaGFR8h7j6ruBV22DXI6+V4/t9KB9ny33T274sxhJE4FN/o5zM3TonbHfe
         jCrkkPCVDYZWywGW34sFFN7l0aui8paTjOWApXktt788Uq69tTuBty2jXMB5mlBHb3Go
         RWzA==
X-Gm-Message-State: ANhLgQ2/JmCr28EClr08aXXuiGG/e5CiIMfpy1V8RxJYVZ27HstJpKZn
        Z2kjtkNDHiiSkBa5dZv6s42bL/LDzrI=
X-Google-Smtp-Source: ADFU+vuZM/wrLQkZhph4tN0p0oWmZhN1XoQuxypzKDgxWIL5L41sJf8NBc/Sk7/A4MmAvbLnE6Xgqw==
X-Received: by 2002:a1c:5604:: with SMTP id k4mr1483516wmb.57.1585251564109;
        Thu, 26 Mar 2020 12:39:24 -0700 (PDT)
Received: from chromium.org (77-56-209-237.dclient.hispeed.ch. [77.56.209.237])
        by smtp.gmail.com with ESMTPSA id w7sm4886527wrr.60.2020.03.26.12.39.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Mar 2020 12:39:23 -0700 (PDT)
From:   KP Singh <kpsingh@chromium.org>
X-Google-Original-From: KP Singh <kpsingh>
Date:   Thu, 26 Mar 2020 20:39:21 +0100
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     open list <linux-kernel@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>, linux-security-module@vger.kernel.org,
        Brendan Jackman <jackmanb@google.com>,
        Florent Revest <revest@google.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        James Morris <jmorris@namei.org>,
        Kees Cook <keescook@chromium.org>,
        Paul Turner <pjt@google.com>, Jann Horn <jannh@google.com>,
        Florent Revest <revest@chromium.org>,
        Brendan Jackman <jackmanb@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH bpf-next v7 4/8] bpf: lsm: Implement attach, detach and
 execution
Message-ID: <20200326193921.GA15273@chromium.org>
References: <20200326142823.26277-1-kpsingh@chromium.org>
 <20200326142823.26277-5-kpsingh@chromium.org>
 <CAEf4BzaS8xLLrbaWgWbWSEVfc3YBPURQhZxe=zR06B021jH5BA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEf4BzaS8xLLrbaWgWbWSEVfc3YBPURQhZxe=zR06B021jH5BA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26-Mär 12:12, Andrii Nakryiko wrote:
> On Thu, Mar 26, 2020 at 7:29 AM KP Singh <kpsingh@chromium.org> wrote:
> >
> > From: KP Singh <kpsingh@google.com>
> >
> > JITed BPF programs are dynamically attached to the LSM hooks
> > using BPF trampolines. The trampoline prologue generates code to handle
> > conversion of the signature of the hook to the appropriate BPF context.
> >
> > The allocated trampoline programs are attached to the nop functions
> > initialized as LSM hooks.
> >
> > BPF_PROG_TYPE_LSM programs must have a GPL compatible license and
> > and need CAP_SYS_ADMIN (required for loading eBPF programs).
> >
> > Upon attachment:
> >
> > * A BPF fexit trampoline is used for LSM hooks with a void return type.
> > * A BPF fmod_ret trampoline is used for LSM hooks which return an
> >   int. The attached programs can override the return value of the
> >   bpf LSM hook to indicate a MAC Policy decision.
> >
> > Signed-off-by: KP Singh <kpsingh@google.com>
> > Reviewed-by: Brendan Jackman <jackmanb@google.com>
> > Reviewed-by: Florent Revest <revest@google.com>
> > ---
> 
> Acked-by: Andrii Nakryiko <andriin@fb.com>
> 
> 
> >  include/linux/bpf_lsm.h | 11 ++++++++
> >  kernel/bpf/bpf_lsm.c    | 28 ++++++++++++++++++++
> >  kernel/bpf/btf.c        |  9 ++++++-
> >  kernel/bpf/syscall.c    | 57 ++++++++++++++++++++++++++++-------------
> >  kernel/bpf/trampoline.c | 17 +++++++++---
> >  kernel/bpf/verifier.c   | 19 +++++++++++---
> >  6 files changed, 114 insertions(+), 27 deletions(-)
> >
> 
> [...]
> 
> > @@ -2479,6 +2496,10 @@ static int bpf_raw_tracepoint_open(const union bpf_attr *attr)
> >                 }
> >                 buf[sizeof(buf) - 1] = 0;
> >                 tp_name = buf;
> > +               break;
> > +       default:
> > +                       err = -EINVAL;
> > +                       goto out_put_prog;
> >         }
> 
> is indentation off here or it's my email client?

You're mail client is fine :) It's me.

- KP

> 
> [...]
