Return-Path: <SRS0=w5GM=A4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6748CC433E4
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 00:20:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 44425207DD
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 00:20:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594945218;
	bh=dynZiMT160fFV318XcHN8vJ1LFq3IdJmZE81Qj67JHY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=fVznowvvfJuGFFQjaT1h+lZDUMWBbT7FnI3JgbJVUDmgiBqITN6mOXwfRWrnPuuHY
	 8IyYPrr4KClm4YqQ8qPIWgv3DlEw1TxYg9o8GrIfRqSloCoBaE06AlYrLlx/z3nkU9
	 GmPL88xhyny0UJ29swElPdGY+hd9wFjibmV622uQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726393AbgGQAUQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jul 2020 20:20:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:43720 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726125AbgGQAUQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jul 2020 20:20:16 -0400
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 58A72207EA
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jul 2020 00:20:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594945215;
        bh=dynZiMT160fFV318XcHN8vJ1LFq3IdJmZE81Qj67JHY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=BXz3QKqi5cKE5fh3RKhpo+RLAtmQYAk5eW485twQ4Cvsc8Kzi0ysV+OPGw4+KH5zJ
         ltvZJtC16tfj6Wse9+LLFHiaYZNJh550ZYV89+HfejCZ2PYSi+p0c9Aog9mOQOMq+Y
         JUc+qCzzvaADEOiiSFb5qJG3qaTvS0TS+wqCxoHs=
Received: by mail-wr1-f47.google.com with SMTP id j4so9076049wrp.10
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jul 2020 17:20:15 -0700 (PDT)
X-Gm-Message-State: AOAM5334qQnkICC419YZOe46CUQ0hNiyuCHy4LGl9h9HmqdrUaIC7kDw
        xL/gxZj1bOYzwFYesWcA/2GWMGLMXO086DpLFoyJ8g==
X-Google-Smtp-Source: ABdhPJyFwQ9TS/dW0gUFTXF5Hg6RwZdmG8iOGVpkOopW3ph3siXASHwq1e23sAvzryIIoeiFZKhOnjnIRg9xnOzP4dE=
X-Received: by 2002:adf:f707:: with SMTP id r7mr7398196wrp.70.1594945213901;
 Thu, 16 Jul 2020 17:20:13 -0700 (PDT)
MIME-Version: 1.0
References: <20200716193141.4068476-1-krisman@collabora.com> <20200716193141.4068476-2-krisman@collabora.com>
In-Reply-To: <20200716193141.4068476-2-krisman@collabora.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Thu, 16 Jul 2020 17:20:02 -0700
X-Gmail-Original-Message-ID: <CALCETrWdCN5KsRUkrb8VoYGRBhy71P-MAHGWhuJ5y4Z3vByyvg@mail.gmail.com>
Message-ID: <CALCETrWdCN5KsRUkrb8VoYGRBhy71P-MAHGWhuJ5y4Z3vByyvg@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] kernel: Implement selective syscall userspace redirection
To:     Gabriel Krisman Bertazi <krisman@collabora.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>, kernel@collabora.com,
        Matthew Wilcox <willy@infradead.org>,
        Andrew Lutomirski <luto@kernel.org>,
        Paul Gofman <gofmanp@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>, Shuah Khan <shuah@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 16, 2020 at 12:31 PM Gabriel Krisman Bertazi
<krisman@collabora.com> wrote:
>

This is quite nice.  I have a few comments, though:

You mentioned rt_sigreturn().  Should this automatically exempt the
kernel-provided signal restorer on architectures (e.g. x86_32) that
provide one?

The amount of syscall entry wiring that arches need to do is IMO
already a bit out of hand.  Should we instead rename TIF_SECCOMP to
TIF_SYSCALL_INTERCEPTION and have one generic callback that handles
seccomp and this new thing?

> +int do_syscall_user_dispatch(struct pt_regs *regs)
> +{
> +       struct syscall_user_dispatch *sd = &current->syscall_dispatch;
> +       unsigned long ip = instruction_pointer(regs);
> +       char state;
> +
> +       if (likely(ip >= sd->dispatcher_start && ip <= sd->dispatcher_end))
> +               return 0;
> +
> +       if (likely(sd->selector)) {
> +               if (unlikely(__get_user(state, sd->selector)))
> +                       do_exit(SIGSEGV);
> +
> +               if (likely(state == 0))
> +                       return 0;
> +
> +               if (state != 1)
> +                       do_exit(SIGSEGV);

This seems a bit extreme and hard to debug if it ever happens.
