Return-Path: <SRS0=8+oI=7O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66A52C433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 19:46:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 487112074B
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 19:46:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728336AbgFATqu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jun 2020 15:46:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:37772 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728118AbgFATqu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 15:46:50 -0400
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CA00C206E2;
        Mon,  1 Jun 2020 19:46:48 +0000 (UTC)
Date:   Mon, 1 Jun 2020 15:46:47 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Jules Irenge <jbi.octave@gmail.com>
Cc:     linux-kernel@vger.kernel.org, tglx@linutronix.de,
        paulmck@kernel.org, mingo@redhat.com, boqun.feng@gmail.com,
        Borislav Petkov <bp@alien8.de>,
        x86@kernel.org (maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)),
        "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH 4/5] x86/ftrace: Add annotations for
 ftrace_arch_code_modify_prepare() and
 ftrace_arch_code_modify_post_process()
Message-ID: <20200601154647.581fa345@oasis.local.home>
In-Reply-To: <20200601184552.23128-5-jbi.octave@gmail.com>
References: <20200601184552.23128-1-jbi.octave@gmail.com>
        <20200601184552.23128-5-jbi.octave@gmail.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon,  1 Jun 2020 19:45:51 +0100
Jules Irenge <jbi.octave@gmail.com> wrote:

> Sparse reports warnings
> 
> warning: context imbalance in ftrace_arch_code_modify_prepare()
> 	- wrong count at exit
> warning: context imbalance in ftrace_arch_code_modify_post_process()
> 	- wrong count at exit
> 
> The root cause is that even if
>  the annotations on the function are correct,
> mutex do not support annotation
> This makes Sparse to complain.
> To fix this,
> __acquire(&text_mutex) and
>  __release(&text_mutex) annotations are added
> inside ftrace_arch_code_modify_prepare()
> and ftrace_arch_code_modify_post_process()
> respectively.

Wait what? This looks like either a bug in sparse, or we just remove the
annotations. This just makes the code ugly, and looks silly.

Nack!

-- Steve


> 
> Signed-off-by: Jules Irenge <jbi.octave@gmail.com>
> ---
>  arch/x86/kernel/ftrace.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/arch/x86/kernel/ftrace.c b/arch/x86/kernel/ftrace.c
> index 37a0aeaf89e7..737c07ab2e07 100644
> --- a/arch/x86/kernel/ftrace.c
> +++ b/arch/x86/kernel/ftrace.c
> @@ -46,6 +46,7 @@ int ftrace_arch_code_modify_prepare(void)
>  	 * ftrace has it set to "read/write".
>  	 */
>  	mutex_lock(&text_mutex);
> +	__acquire(&text_mutex);
>  	ftrace_poke_late = 1;
>  	return 0;
>  }
> @@ -61,6 +62,7 @@ int ftrace_arch_code_modify_post_process(void)
>  	text_poke_finish();
>  	ftrace_poke_late = 0;
>  	mutex_unlock(&text_mutex);
> +	__release(&text_mutex);
>  	return 0;
>  }
>  

