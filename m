Return-Path: <SRS0=f73W=7K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B372BC433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 23:50:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9233B2075F
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 23:50:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437806AbgE1XuC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 May 2020 19:50:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:60262 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2437776AbgE1Xt2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 19:49:28 -0400
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C997C2075F;
        Thu, 28 May 2020 23:49:27 +0000 (UTC)
Date:   Thu, 28 May 2020 19:49:25 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Kaitao Cheng <pilgrimtao@gmail.com>
Cc:     mingo@kernel.org, linux-kernel@vger.kernel.org,
        songmuchun@bytedance.com
Subject: Re: [PATCH] trace/ftrace: fix maybe-uninitialized compiler warning
Message-ID: <20200528194925.6eec098c@oasis.local.home>
In-Reply-To: <20200523155304.29554-1-pilgrimtao@gmail.com>
References: <20200523155304.29554-1-pilgrimtao@gmail.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kaitao,

Sorry for the late response, I've been a bit swamped.

On Sat, 23 May 2020 23:53:04 +0800
Kaitao Cheng <pilgrimtao@gmail.com> wrote:

> During build compiler reports some 'false positive' warnings about
> variables {'seq_ops', 'filtered_pids', 'other_pids'} may be used
> uninitialized. This patch silences these warnings.
> Also delete some useless spaces
> 
> Signed-off-by: Kaitao Cheng <pilgrimtao@gmail.com>
> ---
>  kernel/trace/ftrace.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
> index 7d0ebd104706..01a61bdc4e63 100644
> --- a/kernel/trace/ftrace.c
> +++ b/kernel/trace/ftrace.c
> @@ -2260,7 +2260,7 @@ ftrace_find_tramp_ops_next(struct dyn_ftrace *rec,
>  
>  		if (hash_contains_ip(ip, op->func_hash))
>  			return op;
> -	} 
> +	}
>  
>  	return NULL;
>  }
> @@ -3599,7 +3599,7 @@ static int t_show(struct seq_file *m, void *v)
>  			if (direct)
>  				seq_printf(m, "\n\tdirect-->%pS", (void *)direct);
>  		}
> -	}	
> +	}
>  
>  	seq_putc(m, '\n');
>  
> @@ -7151,6 +7151,9 @@ static int pid_open(struct inode *inode, struct file *file, int type)
>  	case TRACE_NO_PIDS:
>  		seq_ops = &ftrace_no_pid_sops;
>  		break;
> +	default:
> +		trace_array_put(tr);
> +		return -EINVAL;
>  	}
>  
>  	ret = seq_open(file, seq_ops);
> @@ -7229,6 +7232,9 @@ pid_write(struct file *filp, const char __user *ubuf,
>  		other_pids = rcu_dereference_protected(tr->function_pids,
>  					     lockdep_is_held(&ftrace_lock));
>  		break;
> +	default:
> +		ret = -EINVAL;

As these are anomalies, and should never happen, we should probably add
a WARN_ON_ONCE(1); here as well.

Care to send a v2?

Thanks!

-- Steve


> +		goto out;
>  	}
>  
>  	ret = trace_pid_write(filtered_pids, &pid_list, ubuf, cnt);

