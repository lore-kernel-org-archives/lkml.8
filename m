Return-Path: <SRS0=fZJt=4U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A706C3F2D1
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 23:52:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA9AC2067C
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 23:52:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728103AbgCCXwj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Mar 2020 18:52:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:36672 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727725AbgCCXwj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Mar 2020 18:52:39 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E62792067C;
        Tue,  3 Mar 2020 23:52:37 +0000 (UTC)
Date:   Tue, 3 Mar 2020 18:52:36 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Anders Roxell <anders.roxell@linaro.org>, paulmck@kernel.org,
        joel@joelfernandes.org,
        "Naveen N . Rao" <naveen.n.rao@linux.ibm.com>,
        Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
        David Miller <davem@davemloft.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH -tip V4 3/4] kprobes: Fix to protect
 kick_kprobe_optimizer() by kprobe_mutex
Message-ID: <20200303185236.23db2ebc@gandalf.local.home>
In-Reply-To: <158270759113.18966.8938334321921933993.stgit@devnote2>
References: <158270755997.18966.3544449431956918068.stgit@devnote2>
        <158270759113.18966.8938334321921933993.stgit@devnote2>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 26 Feb 2020 17:59:51 +0900
Masami Hiramatsu <mhiramat@kernel.org> wrote:

> In kprobe_optimizer() kick_kprobe_optimizer() is called
> without kprobe_mutex, but this can race with other caller
> which is protected by kprobe_mutex.
> 
> To fix that, expand kprobe_mutex protected area to protect
> kick_kprobe_optimizer() call.
> 

Should we add

 Cc: stable@vger.kernel.org
 Fixes: cd7ebe2298ff ("kprobes: Use text_poke_smp_batch for optimizing")

tags?

-- Steve

> Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
> ---
>  kernel/kprobes.c |    3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/kprobes.c b/kernel/kprobes.c
> index 38d9a5d7c8a4..6d76a6e3e1a5 100644
> --- a/kernel/kprobes.c
> +++ b/kernel/kprobes.c
> @@ -592,11 +592,12 @@ static void kprobe_optimizer(struct work_struct *work)
>  	mutex_unlock(&module_mutex);
>  	mutex_unlock(&text_mutex);
>  	cpus_read_unlock();
> -	mutex_unlock(&kprobe_mutex);
>  
>  	/* Step 5: Kick optimizer again if needed */
>  	if (!list_empty(&optimizing_list) || !list_empty(&unoptimizing_list))
>  		kick_kprobe_optimizer();
> +
> +	mutex_unlock(&kprobe_mutex);
>  }
>  
>  /* Wait for completing optimization and unoptimization */

