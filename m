Return-Path: <SRS0=7RkH=3E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79C87C33CB1
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 08:43:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4DD902077B
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 08:43:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579077820;
	bh=vwpx7jmy/UsNz4oukcDm0Up8DtcbyNZm+J/hXoV3gb4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=wXBwAn/gPoI2rwmntvHvMXc1IpWgs1PVAFeLEXPNpULNdS4U/xwLV07HkFmKVWX2l
	 QeLL5kIwH/RWRoX1uBgexloSD1cAvWsOFjblAoRuxSnGjblzfdMjeNapf3OOf1Gt/K
	 dJQagVMVfvunma8xhAozbEjezABmlz9Z3bWZCQhk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729081AbgAOInj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jan 2020 03:43:39 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:36263 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726472AbgAOInj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jan 2020 03:43:39 -0500
Received: by mail-wr1-f65.google.com with SMTP id z3so14872847wru.3
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jan 2020 00:43:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=S/PNDUAlVVVtYjvRnMN304qOmVqAvWD8J5Xrr48hgz4=;
        b=ZR7bqr2lzCWXVFanap+oLk7W9SrOEm1sfsRPZq9dvLTHUHtUMQZbojiTUK5yo0I7vq
         qv+ycjJIM8g9ZyriLul+qpwPKny4ixXJq22RXkd3b6X7n1uXHAmQtAvQ4pkB4qlF2STb
         0WjKvpnMGMbraSuLunoV1AcOII2Ej+HtUYFYwbfbk1rnVGLUue5zwjEsC5lSNfjzo0iK
         vmwY7r/+pV5q4/okh4gwDps6XzCApCiE/HF1dZw0mv/VR37xKdprRGejYiRQpXsHYJvC
         Pxe+bZcNwEr7wjMG60MBHFsyjdbgDXqT1JpjKnx91+SFPwsg47U8JjMCdDnxy16aAD1w
         OjVw==
X-Gm-Message-State: APjAAAX0FGMklDhUv5LeTGd/dFd/yIhYmddVkSXJsi2QrfYXWeSBxglr
        NGZGNn/XEwVRN8M4UO4ODAQ=
X-Google-Smtp-Source: APXvYqwGLRWTLB0nzAWAVz8G3S+ZGQ2cWW5Hfuwg70alRK5byH//hBg1tHkuoYxkj7wUIgg9q1sI3g==
X-Received: by 2002:adf:d4ca:: with SMTP id w10mr28545870wrk.53.1579077817600;
        Wed, 15 Jan 2020 00:43:37 -0800 (PST)
Received: from localhost (prg-ext-pat.suse.com. [213.151.95.130])
        by smtp.gmail.com with ESMTPSA id t8sm23840123wrp.69.2020.01.15.00.43.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jan 2020 00:43:36 -0800 (PST)
Date:   Wed, 15 Jan 2020 09:43:36 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     David Rientjes <rientjes@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [patch] mm, oom: dump stack of victim when reaping failed
Message-ID: <20200115084336.GW19428@dhcp22.suse.cz>
References: <alpine.DEB.2.21.2001141519280.200484@chino.kir.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.2001141519280.200484@chino.kir.corp.google.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 14-01-20 15:20:04, David Rientjes wrote:
> When a process cannot be oom reaped, for whatever reason, currently the
> list of locks that are held is currently dumped to the kernel log.
> 
> Much more interesting is the stack trace of the victim that cannot be
> reaped.  If the stack trace is dumped, we have the ability to find
> related occurrences in the same kernel code and hopefully solve the
> issue that is making it wedged.
> 
> Dump the stack trace when a process fails to be oom reaped.

Yes, this is really helpful.

> Signed-off-by: David Rientjes <rientjes@google.com>

Acked-by: Michal Hocko <mhocko@suse.com>

Thanks!

> ---
>  mm/oom_kill.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/mm/oom_kill.c b/mm/oom_kill.c
> --- a/mm/oom_kill.c
> +++ b/mm/oom_kill.c
> @@ -26,6 +26,7 @@
>  #include <linux/sched/mm.h>
>  #include <linux/sched/coredump.h>
>  #include <linux/sched/task.h>
> +#include <linux/sched/debug.h>
>  #include <linux/swap.h>
>  #include <linux/timex.h>
>  #include <linux/jiffies.h>
> @@ -620,6 +621,7 @@ static void oom_reap_task(struct task_struct *tsk)
>  
>  	pr_info("oom_reaper: unable to reap pid:%d (%s)\n",
>  		task_pid_nr(tsk), tsk->comm);
> +	sched_show_task(tsk);
>  	debug_show_all_locks();
>  
>  done:

-- 
Michal Hocko
SUSE Labs
