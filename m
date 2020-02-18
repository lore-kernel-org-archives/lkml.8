Return-Path: <SRS0=52rg=4G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A359FC34026
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 09:39:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74725206E2
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 09:39:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KI/aHslK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726464AbgBRJjy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Feb 2020 04:39:54 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:41089 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726193AbgBRJjx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Feb 2020 04:39:53 -0500
Received: by mail-ed1-f68.google.com with SMTP id c26so24046463eds.8
        for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2020 01:39:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ri50rwS+DwKS+xdiT/P+5HE1fXClWtkp9WTD/LVC98k=;
        b=KI/aHslK/e7VD/qZEsqk3jaN/3BOu1yhytDSreqQtdWbJRTqjVSjc3qM6Tzuh2zz5i
         R0fsIro52A0NGmibGj/wVghzgz+NwLLd0gALlAjAbYQyCiuK2d7msEHAJ1X2oH8k3yVt
         hqbO0jgTLMFp5c0SjbWvorIk/GMYAFoFN96yxpqkblV70wtKw/JLy+beQnJAti3FCimP
         FQiop4PsagBP/+xGrTI7n7O87WubWDGxR0VZKa2C+jYUYXpjlq7DLCeLZiyW+ncm1Zjc
         7DIEK47AM4nw4BMDt0ynD4NJjvrOnzfoe6h+gQPROuNdcbx5BSJiOlpnTx2ozKfE4Oq9
         x8GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ri50rwS+DwKS+xdiT/P+5HE1fXClWtkp9WTD/LVC98k=;
        b=SQPgZ5DRauBf7BJ2DNx7vPZaa/RaoW+wfx5u/2+wgXmZu7Kq9kR32mgG2B2ss00hai
         0tuQykZOFG0TOtn/R7zeaps1b8kZQbFUC+kP7FyOr90TbVpXKcQdW829jFQtckfDEqP4
         yowMcyfz5NAP3+3VZ1FnmKyP15AGPW6BanKknRfKbkM0+DXfhkYDe/d4DsGcHB49pxB6
         yHquj+GnHvuVubBGyp1uPyVFosQmOq2nDfJSa5szt/eSERQPKFChaGTLh7RXGpRuz4hJ
         1oLYK2f4N3kLAQL26hzLbTfB/tWFR3REPLaPhjbp4nlPJakL7MHoISWOzGm3LC507nCt
         igJQ==
X-Gm-Message-State: APjAAAXG9BYedrGvhaLv1nEQ7gxBPiXbaSFF3M2mGYSV75hSA+ToDJGX
        HS7Ie5CH3lFCIp7TKrbgAwq/xwV9Xd1EKaoZk2O45A==
X-Google-Smtp-Source: APXvYqwPmrjtbUt3H2+QDBo0aopxeSgvwYExYKpjl0BM4dpOEKo5xW+lYJ2BY7xMzI3AGGcvU+8a7WhntIWppVfJuzU=
X-Received: by 2002:aa7:c2cb:: with SMTP id m11mr18480901edp.89.1582018791471;
 Tue, 18 Feb 2020 01:39:51 -0800 (PST)
MIME-Version: 1.0
References: <20200218005659.91318-1-lrizzo@google.com> <20200218165529.39e761c4be828285cc060279@kernel.org>
In-Reply-To: <20200218165529.39e761c4be828285cc060279@kernel.org>
From:   Luigi Rizzo <lrizzo@google.com>
Date:   Tue, 18 Feb 2020 01:39:40 -0800
Message-ID: <CAMOZA0L14CjA97UHj7V1tPuOtesrUykYPj3_vgbF3JQWS3bcaw@mail.gmail.com>
Subject: Re: [PATCH v3] kretprobe: percpu support
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     linux-kernel@vger.kernel.org, naveen.n.rao@linux.ibm.com,
        anil.s.keshavamurthy@intel.com, David Miller <davem@davemloft.net>,
        gregkh@linuxfoundation.org, Ingo Molnar <mingo@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 17, 2020 at 11:55 PM Masami Hiramatsu <mhiramat@kernel.org> wrote:
>
> Hi Luigi,
>
> On Mon, 17 Feb 2020 16:56:59 -0800
> Luigi Rizzo <lrizzo@google.com> wrote:
>
> > kretprobe uses a list protected by a single lock to allocate a
> > kretprobe_instance in pre_handler_kretprobe(). This works poorly with
> > concurrent calls.
>
> Yes, there are several potential performance issue and the recycle
> instance is one of them. However, I think this spinlock is not so racy,
> but noisy (especially on many core machine) right?

correct, it is especially painful on 2+ sockets and many-core systems
when attaching kretprobes on otherwise uncontended paths.

>
> Racy lock is the kretprobe_hash_lock(), I would like to replace it
> with ftrace's per-task shadow stack. But that will be available
> only if CONFIG_FUNCTION_GRAPH_TRACER=y (and instance has no own
> payload).
>
> > This patch offers a simplified fix: the percpu_instance flag indicates
> > that we allocate one instance per CPU, and the allocation is contention
> > free, but we allow only have one pending entry per CPU (this could be
> > extended to a small constant number without much trouble).
>
> OK, the percpu instance idea is good to me, and I think it should be
> default option. Unless user specifies the number of instances, it should
> choose percpu instance by default.

That was my initial implementation, which would not even need the
percpu_instance
flag in struct kretprobe. However, I felt that changing the default
would have subtle
side effects (e.g., only one outstanding call per CPU) so I thought it
would be better
to leave the default unchanged and make the flag explicit.

> Moreover, this makes things a bit complicated, can you add per-cpu
> instance array? If it is there, we can remove the old recycle rp insn
> code.

Can you clarify what you mean by "per-cpu instance array" ?
Do you mean allowing multiple outstanding entries per cpu?

I will address your code comments in an updated patch.

thanks
luigi
