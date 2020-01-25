Return-Path: <SRS0=aedO=3O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F8A2C2D0CE
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Jan 2020 02:23:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 25AC22073B
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Jan 2020 02:23:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579918986;
	bh=aXF9h2u0IVG3AMeK/xiBH+gwvZuHauq2rn1H24VHNrk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=Y2Wwk8m8XLYVrfRc9feFXXsLkwzBcFmfXmUHSquhPy8+gx5Gg0xZX82oXCN2J8Wf7
	 Z0USwszG6qqhmg1WhBnz+hUKFmRSMRR1SSF4jW/xIsSpEBtdDRlEcfeaW1nveqLYEA
	 Hr34Yehz84gv+u9Wd43+1PzRFlKRKPArjrlK8QC8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387721AbgAYCXF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jan 2020 21:23:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:60502 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387542AbgAYCXF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jan 2020 21:23:05 -0500
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 302B720718;
        Sat, 25 Jan 2020 02:23:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579918984;
        bh=aXF9h2u0IVG3AMeK/xiBH+gwvZuHauq2rn1H24VHNrk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=F0WZwfXQd/GPg5PAw8lYleL2UiAwhc70o7cEyY2SnfkF47KModMcUpRiJBHUvMBXC
         5OANQr7FJ2d0XFPc20Xq8bhPkA/xo8uh/3Dr9/IhT7/zD6SbM0/Of3rjOpsklaIzwo
         SBldtFVuNY80VxeQM9ZIhfV59OqQDrudeihi7vVE=
Date:   Sat, 25 Jan 2020 11:23:00 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Divya Indi <divya.indi@oracle.com>
Subject: Re: [PATCH] tracing: Decrement trace_array when bootconfig creates
 an instance
Message-Id: <20200125112300.220f1728f6e47f45717ec564@kernel.org>
In-Reply-To: <20200124205927.76128804@rorschach.local.home>
References: <20200124205927.76128804@rorschach.local.home>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 24 Jan 2020 20:59:27 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> 
> From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>
> 
> The trace_array_get_by_name() creates a ftrace instance and
> trace_array_put() is used to remove the reference. Even though the
> trace_array_get_by_name() creates the instance, it also adds a reference
> count to it, that prevents user space from removing it.
> 
> As the bootconfig just creates the instance on boot up, it should still be
> used where it can be deleted by user space after boot. A trace_array_put()
> is required to let that happen. Otherwise, the created instance can not
> be removed.
> 
> Also, change the documentation on trace_array_get_by_name() to make this not
> be so confusing.

Good catch! I misunderstood trace_array_put() would remove the instance.

Acked-by: Masami Hiramatsu <mhiramat@kernel.org>

Thank you!

> 
> Fixes: 4f712a4d04a4e ("tracing/boot: Add instance node support")
> Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
> ---
>  kernel/trace/trace.c      | 4 ++++
>  kernel/trace/trace_boot.c | 1 +
>  2 files changed, 5 insertions(+)
> 
> diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
> index 6fed9b0a8d58..0a5569b1cace 100644
> --- a/kernel/trace/trace.c
> +++ b/kernel/trace/trace.c
> @@ -8602,6 +8602,10 @@ static int instance_mkdir(const char *name)
>   * NOTE: This function increments the reference counter associated with the
>   * trace array returned. This makes sure it cannot be freed while in use.
>   * Use trace_array_put() once the trace array is no longer needed.
> + * If the trace_array is to be freed, trace_array_destroy() needs to
> + * be called after the trace_array_put(), or simply let user space delete
> + * it from the tracefs instances directory. But until the
> + * trace_array_put() is called, user space can not delete it.
>   *
>   */
>  struct trace_array *trace_array_get_by_name(const char *name)
> diff --git a/kernel/trace/trace_boot.c b/kernel/trace/trace_boot.c
> index cd541ac1cbc1..2f616cd926b0 100644
> --- a/kernel/trace/trace_boot.c
> +++ b/kernel/trace/trace_boot.c
> @@ -327,6 +327,7 @@ trace_boot_init_instances(struct xbc_node *node)
>  			continue;
>  		}
>  		trace_boot_init_one_instance(tr, inode);
> +		trace_array_put(tr);
>  	}
>  }
>  
> -- 
> 2.20.1
> 


-- 
Masami Hiramatsu <mhiramat@kernel.org>
