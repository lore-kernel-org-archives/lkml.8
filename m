Return-Path: <SRS0=kRID=5C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 366F0C10F29
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 16:00:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 078A920724
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 16:00:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UxEcJbE5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726908AbgCQQAx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Mar 2020 12:00:53 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:45597 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726019AbgCQQAx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Mar 2020 12:00:53 -0400
Received: by mail-wr1-f67.google.com with SMTP id t2so16340114wrx.12
        for <linux-kernel@vger.kernel.org>; Tue, 17 Mar 2020 09:00:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=eAhbBL0CBHwTEuoSCE5w0pXR4TY8wKBETG1SIbtR2Sc=;
        b=UxEcJbE5USWqkkP6abztBR0xn4UoB+3HaAmS+SR+DIlY9cmQmxOjfghKLVcS/MgD93
         B+XCDiVXBXMX9b9CkkhYZ+KpTEXpGyoP/ojxfia8bG7x1+vwExQwKqW6YVXY8Jl7k0R8
         Zcz8Q2+0ypoeyzHSOUXHWPHFeOkWYd99k3dVN4vuJcfzskzemmHst9Nlz+44lyETb4HD
         z9zB2P+Dj6smTjN3gNJDV+rd88DPnrtThNakEXkci3fYxvAMOiO9YcWlwnPmP3HBeMod
         R7d4lgn+WROybjInFFnQo9ov2H+TH0F5SxgcVPpXXcLIdvpZE7GLcIhuGbtOGGLEqZgr
         HATg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=eAhbBL0CBHwTEuoSCE5w0pXR4TY8wKBETG1SIbtR2Sc=;
        b=DFkw22+YGYHGgu5Yv+uz3n13AJZbno3Ay0Qvi1BS1/y6vaf8MYPgBAQyfeNwr++DaJ
         tKOR0taiywB8RIrXbuiXGJDYY8UE2dkjWjlzQ/bZwO4o6v9QAftkZreTgCCYr5scXNRv
         X+hU4OQqLf2TwhxXMAjrnptHxVn0R5l7oEcl79qs8pKMzroyLCLRT/MuqNEsLZ/2bMav
         F9NXImmnIqBEEuevL32ABux0A3w9Hds8zlZUSN3hTJ0oP6Q7hq/gHw3ssPsgqxpxFVdb
         k/MMAYUpXnfJZFCBdg72P8iDmnpUuv5urOH5YcGh98Z1LbF44SRuEC9iFEgJVjRoWS29
         RkFA==
X-Gm-Message-State: ANhLgQ2+n+/rj3pdALFlr/8Hlv58IR8802bDvMg51bJcQObY2PNtNvZI
        JDnSxVQjrVIzJXakxyBBSGy1DA==
X-Google-Smtp-Source: ADFU+vuSGY1rxMfHc3NrftXxtpVnp2ezWprgxCqud+GfK3PjqX6VcALoQ37M7N3wtgxUqDljjFptUA==
X-Received: by 2002:adf:b245:: with SMTP id y5mr6492408wra.136.1584460851735;
        Tue, 17 Mar 2020 09:00:51 -0700 (PDT)
Received: from holly.lan (cpc141214-aztw34-2-0-cust773.18-1.cable.virginm.net. [86.9.19.6])
        by smtp.gmail.com with ESMTPSA id x17sm4434916wmi.28.2020.03.17.09.00.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Mar 2020 09:00:50 -0700 (PDT)
Date:   Tue, 17 Mar 2020 16:00:49 +0000
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Dmitry Safonov <dima@arista.com>
Cc:     linux-kernel@vger.kernel.org,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ingo Molnar <mingo@kernel.org>, Jiri Slaby <jslaby@suse.com>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Douglas Anderson <dianders@chromium.org>,
        Jason Wessel <jason.wessel@windriver.com>,
        kgdb-bugreport@lists.sourceforge.net
Subject: Re: [PATCHv2 47/50] kdb: Don't play with console_loglevel
Message-ID: <20200317160049.b2t52oaqifhmcv23@holly.lan>
References: <20200316143916.195608-1-dima@arista.com>
 <20200316143916.195608-48-dima@arista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200316143916.195608-48-dima@arista.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 16, 2020 at 02:39:13PM +0000, Dmitry Safonov wrote:
> Print the stack trace with KERN_EMERG - it should be always visible.
> 
> Playing with console_loglevel is a bad idea as there may be more
> messages printed than wanted. Also the stack trace might be not printed
> at all if printk() was deferred and console_loglevel was raised back
> before the trace got flushed.
> 
> Unfortunately, after rebasing on commit 2277b492582d ("kdb: Fix stack
> crawling on 'running' CPUs that aren't the master"), kdb_show_stack()
> uses now kdb_dump_stack_on_cpu(), which for now won't be converted as it
> uses dump_stack() instead of show_stack().
> 
> Convert for now the branch that uses show_stack() and remove
> console_loglevel exercise from that case.
> 
> Cc: Daniel Thompson <daniel.thompson@linaro.org>
> Cc: Douglas Anderson <dianders@chromium.org>
> Cc: Jason Wessel <jason.wessel@windriver.com>
> Cc: kgdb-bugreport@lists.sourceforge.net
> Signed-off-by: Dmitry Safonov <dima@arista.com>

Acked-by: Daniel Thompson <daniel.thompson@linaro.org>


> ---
>  kernel/debug/kdb/kdb_bt.c | 15 ++++++++-------
>  1 file changed, 8 insertions(+), 7 deletions(-)
> 
> diff --git a/kernel/debug/kdb/kdb_bt.c b/kernel/debug/kdb/kdb_bt.c
> index 3de0cc780c16..43f5dcd2b9ac 100644
> --- a/kernel/debug/kdb/kdb_bt.c
> +++ b/kernel/debug/kdb/kdb_bt.c
> @@ -21,17 +21,18 @@
>  
>  static void kdb_show_stack(struct task_struct *p, void *addr)
>  {
> -	int old_lvl = console_loglevel;
> -
> -	console_loglevel = CONSOLE_LOGLEVEL_MOTORMOUTH;
>  	kdb_trap_printk++;
>  
> -	if (!addr && kdb_task_has_cpu(p))
> +	if (!addr && kdb_task_has_cpu(p)) {
> +		int old_lvl = console_loglevel;
> +
> +		console_loglevel = CONSOLE_LOGLEVEL_MOTORMOUTH;
>  		kdb_dump_stack_on_cpu(kdb_process_cpu(p));
> -	else
> -		show_stack(p, addr);
> +		console_loglevel = old_lvl;
> +	} else {
> +		show_stack_loglvl(p, addr, KERN_EMERG);
> +	}
>  
> -	console_loglevel = old_lvl;
>  	kdb_trap_printk--;
>  }
>  
> -- 
> 2.25.1
> 
