Return-Path: <SRS0=M7MX=5I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C834C54FCE
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 19:44:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E222C2070A
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 19:44:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="NIcVqOL8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727032AbgCWTog (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Mar 2020 15:44:36 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:36907 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725816AbgCWTof (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Mar 2020 15:44:35 -0400
Received: by mail-wm1-f67.google.com with SMTP id d1so914089wmb.2
        for <linux-kernel@vger.kernel.org>; Mon, 23 Mar 2020 12:44:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=VPTbVbHjbimek43chtj4q4jGy4zz4Aerrx5erMEH+Rc=;
        b=NIcVqOL8Hcu2/424YGZ28OCTXzD6TkjF7KtL6DTv9OThUdUUPcvGtXPZx0xQXrJTko
         DfhPLmC9cc39I2qXIOUrPhKv/OZqHmTgXzCGJpYpkZMIB/5ui0f21hAhliaxKRjZSMyD
         lYZxc8FEriRy0PRfvXgwgMiiYg0lamphqkKI0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=VPTbVbHjbimek43chtj4q4jGy4zz4Aerrx5erMEH+Rc=;
        b=PB2nFjxA9prg9SXhE+4X3dZ8y8fD1hZwSjlaoyfHqzQuT6klV+4hlxiN/4y1raxlW/
         PtmZ9EoYYm7870K+03rWDnar+c87i9i+kjoKgvtk7fSpnaMmLVE6k2RQKKIsorgovVwT
         7X1U+c/yUMRjECKPabrKIRRBCPvlo3oAAAxQHztYwjrhCbfEq4nlSjtD2zHdZ/BTKEWv
         H7kNYJNKEuYk7PymUXj4duWjOv0IOXxBiwWqJDnYzTvWjknn5bMUAgJNOuU/ZNFIto6s
         B6ItPb+EW9LYxw/q/o6T4Jdf/VUOHFV2K9limJ28z+cVLG8Vt+l5cjf9VaXYZSqIzOGD
         /ZWA==
X-Gm-Message-State: ANhLgQ2Ti6WpP/9bHSYqhnWLLh3vCGb3zyXBZ2zDAA8tgIF530vBPf+Y
        oPxy9T5kOt/437OH0AD7rh7+xw==
X-Google-Smtp-Source: ADFU+vs0W77BgudWAo43sPvL/3hpAylqPUXPngvJ+ANhsZ5iZMRtBHNZg0r9qVu1TnQp5Xk7K39mnQ==
X-Received: by 2002:a05:600c:2146:: with SMTP id v6mr1092762wml.155.1584992672996;
        Mon, 23 Mar 2020 12:44:32 -0700 (PDT)
Received: from chromium.org (77-56-209-237.dclient.hispeed.ch. [77.56.209.237])
        by smtp.gmail.com with ESMTPSA id w204sm910043wma.1.2020.03.23.12.44.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2020 12:44:32 -0700 (PDT)
From:   KP Singh <kpsingh@chromium.org>
X-Google-Original-From: KP Singh <kpsingh>
Date:   Mon, 23 Mar 2020 20:44:30 +0100
To:     Yonghong Song <yhs@fb.com>
Cc:     linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
        linux-security-module@vger.kernel.org,
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
Subject: Re: [PATCH bpf-next v5 4/7] bpf: lsm: Implement attach, detach and
 execution
Message-ID: <20200323194430.GA18787@chromium.org>
References: <20200323164415.12943-1-kpsingh@chromium.org>
 <20200323164415.12943-5-kpsingh@chromium.org>
 <3455719d-1359-cdba-431e-e7d06e5b398b@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3455719d-1359-cdba-431e-e7d06e5b398b@fb.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23-Mär 12:16, Yonghong Song wrote:
> 
> 
> On 3/23/20 9:44 AM, KP Singh wrote:
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
> >    int. The attached programs can override the return value of the
> >    bpf LSM hook to indicate a MAC Policy decision.
> > 
> > Signed-off-by: KP Singh <kpsingh@google.com>
> > Reviewed-by: Brendan Jackman <jackmanb@google.com>
> > Reviewed-by: Florent Revest <revest@google.com>
> > ---
> >   include/linux/bpf.h     |  4 ++++
> >   include/linux/bpf_lsm.h | 11 +++++++++++
> >   kernel/bpf/bpf_lsm.c    | 29 +++++++++++++++++++++++++++++
> >   kernel/bpf/btf.c        |  9 ++++++++-
> >   kernel/bpf/syscall.c    | 26 ++++++++++++++++++++++----
> >   kernel/bpf/trampoline.c | 17 +++++++++++++----
> >   kernel/bpf/verifier.c   | 19 +++++++++++++++----
> >   7 files changed, 102 insertions(+), 13 deletions(-)
> > 
> > diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> > index af81ec7b783c..adf2e5a6de4b 100644
> > --- a/include/linux/bpf.h
> > +++ b/include/linux/bpf.h
> > @@ -433,6 +433,10 @@ struct btf_func_model {
> >    * programs only. Should not be used with normal calls and indirect calls.
> >    */
> >   #define BPF_TRAMP_F_SKIP_FRAME		BIT(2)
> > +/* Override the return value of the original function. This flag only makes
> > + * sense for fexit trampolines.
> > + */
> > +#define BPF_TRAMP_F_OVERRIDE_RETURN     BIT(3)
> 
> Whether the return value is overridable is determined by hook return type as
> below. Do we still need this flag?

Apologies, this is a relic and should not have been there, will send a
new revision with this removed.

- KP

> 
> >   /* Each call __bpf_prog_enter + call bpf_func + call __bpf_prog_exit is ~50
> >    * bytes on x86.  Pick a number to fit into BPF_IMAGE_SIZE / 2
> [...]
