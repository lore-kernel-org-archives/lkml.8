Return-Path: <SRS0=N8G3=3G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49712C33CB6
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 11:08:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 226A52082F
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 11:08:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726864AbgAQLIc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jan 2020 06:08:32 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:41620 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726343AbgAQLIc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jan 2020 06:08:32 -0500
Received: from ip5f5bd679.dynamic.kabel-deutschland.de ([95.91.214.121] helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1isPUL-00072P-GF; Fri, 17 Jan 2020 11:08:29 +0000
Date:   Fri, 17 Jan 2020 12:08:28 +0100
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     linux-kernel@vger.kernel.org, Jann Horn <jannh@google.com>,
        Oleg Nesterov <oleg@redhat.com>, stable@vger.kernel.org,
        Serge Hallyn <serge@hallyn.com>, Eric Paris <eparis@redhat.com>
Subject: Re: [REVIEW PATCH v2] ptrace: reintroduce usage of subjective
 credentials in ptrace_has_cap()
Message-ID: <20200117110827.g7n42assgyvcfzaz@wittgenstein>
References: <20200116224518.30598-1-christian.brauner@ubuntu.com>
 <202001161753.27427AD@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <202001161753.27427AD@keescook>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 16, 2020 at 06:29:26PM -0800, Kees Cook wrote:
> On Thu, Jan 16, 2020 at 11:45:18PM +0100, Christian Brauner wrote:
> > As one example where this might be particularly problematic, Jann pointed
> > out that in combination with the upcoming IORING_OP_OPENAT feature, this
> > bug might allow unprivileged users to bypass the capability checks while
> > asynchronously opening files like /proc/*/mem, because the capability
> > checks for this would be performed against kernel credentials.

To follow up on this part of your mail. No, afaict, it's not
aboutwinning a race. It's way simpler...
When io uring creates a new kernel context it records the subjective
credentials of the caller:

	ctx = io_ring_ctx_alloc(p);
	if (!ctx) {
		if (account_mem)
			io_unaccount_mem(user, ring_pages(p->sq_entries,
								p->cq_entries));
		free_uid(user);
		return -ENOMEM;
	}
	ctx->compat = in_compat_syscall();
	ctx->account_mem = account_mem;
	ctx->user = user;
------> ctx->creds = get_current_cred(); <------

Later on, when it starts to do work it creates a kernel thread:

			ctx->sqo_thread = kthread_create_on_cpu(io_sq_thread,
							ctx, cpu,
							"io_uring-sq");
		} else {
			ctx->sqo_thread = kthread_create(io_sq_thread, ctx,
							"io_uring-sq");
		}

and registers io_sq_thread as "callback". The callback io_sq_thread()
runs __with kernel creds__. To prevent this from becoming an issue
io_sq_thread() will override the __subjective credentials__ with the
callers credentials:

	old_cred = override_creds(ctx->creds);

But ptrace_has_cap() currently looks at __task_cred(current) aka
__real_cred__. This means once IORING_OP_OPENAT and IORING_OP_OPENAT2
lands in v5.5-rc6 it is more or less trivial for an unprivileged user to
bypass ptrace_may_access().

Christian
