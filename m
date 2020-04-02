Return-Path: <SRS0=iZC5=5S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6703C2BA12
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 16:06:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A12D2063A
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 16:06:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585843604;
	bh=xSsdZWuObiTte5CmMGzvGsoiDQWVSe05KNqntCHcpt4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=IT9s0b0hoGC9yEPxoRnPEr1/NXWmaP3IrKB7hI3U6oNgrU8OjNjyBpK48LBPbEslP
	 YK7epbwKufpuq0kAG3e+5Fhu5K5zoQG0/KHG9D5nz0NxY8TSV/O8iAtfC9G1WbjCmd
	 /0Mc72mBOTdhdkqDzOdD/3c1GJCGt6YfsIilhcUA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389742AbgDBQGn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Apr 2020 12:06:43 -0400
Received: from mail-pj1-f66.google.com ([209.85.216.66]:40500 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388972AbgDBQGm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Apr 2020 12:06:42 -0400
Received: by mail-pj1-f66.google.com with SMTP id kx8so1673020pjb.5;
        Thu, 02 Apr 2020 09:06:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=r75wMwNGptMAzk8X/bJWo9FUoo8EnDcMGX++kdUmEis=;
        b=YX4MPT62Mf/TmR53AjPvdSQKGOFKIgERLOg0ABQgFewgnlRpT1GFi2HPlqaj1cPN3P
         e8aVdu2txq19LPpBC7+fp95+rOS2vvK6NakWlnPOTeo/Hp6D7r+X2DTL/uhX5O33uJg1
         HEC+3zD8wTkA4J0jJcNQ5Kw8GspgSjRUam8nkWZpBzhbX8nxaRcrx/vf+8PNXRGYxMYT
         q5/UIxp6JD+HWk91p6ZgFl+p+2604d129pR0OhDeERzRBqDPsuufORiZs+nn1UA7aQ6a
         Mi5ifs86YqKvoOenFsfrXg088AUZJ18855vKaufRolt5HEsRfUltXPxbsJoO0DlQdc8b
         NKBA==
X-Gm-Message-State: AGi0PubyNUXVTLjVhAQy6qAYLIqIw8xe26tbfipP9jG3sUsFH1QdJg0W
        s0iXelZ2EEBRbhScoqD93ug=
X-Google-Smtp-Source: APiQypLleY/jOTwizAE6QGIXoXkF/cCKIUqYh6iyvYNrdfBff+zV58SaRx5SkGnHL0N2WUnE9lSJ+w==
X-Received: by 2002:a17:90a:b282:: with SMTP id c2mr4676001pjr.6.1585843601072;
        Thu, 02 Apr 2020 09:06:41 -0700 (PDT)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
        by smtp.gmail.com with ESMTPSA id 185sm3983235pfz.119.2020.04.02.09.06.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Apr 2020 09:06:39 -0700 (PDT)
Received: by 42.do-not-panic.com (Postfix, from userid 1000)
        id 90DAF40254; Thu,  2 Apr 2020 16:06:38 +0000 (UTC)
Date:   Thu, 2 Apr 2020 16:06:38 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Jules Irenge <jbi.octave@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, boqun.feng@gmail.com,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        "open list:PROC SYSCTL" <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH 4/7] sysctl: Add missing annotation for
 start_unregistering()
Message-ID: <20200402160638.GB11244@42.do-not-panic.com>
References: <0/7>
 <20200331204643.11262-1-jbi.octave@gmail.com>
 <20200331204643.11262-5-jbi.octave@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200331204643.11262-5-jbi.octave@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 31, 2020 at 09:46:40PM +0100, Jules Irenge wrote:
> Sparse reports a warning at start_unregistering()
> 
> warning: context imbalance in start_unregistering()
> 	- unexpected unlock
> 
> The root cause is the missing annotation at start_unregistering()
> Add the missing __must_hold(&sysctl_lock) annotation.
> 
> Signed-off-by: Jules Irenge <jbi.octave@gmail.com>

Acked-by: Luis Chamberlain <mcgrof@kernel.org>

  Luis
> ---
>  fs/proc/proc_sysctl.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/fs/proc/proc_sysctl.c b/fs/proc/proc_sysctl.c
> index c75bb4632ed1..d1b5e2b35564 100644
> --- a/fs/proc/proc_sysctl.c
> +++ b/fs/proc/proc_sysctl.c
> @@ -307,6 +307,7 @@ static void proc_sys_prune_dcache(struct ctl_table_header *head)
>  
>  /* called under sysctl_lock, will reacquire if has to wait */
>  static void start_unregistering(struct ctl_table_header *p)
> +	__must_hold(&sysctl_lock)
>  {
>  	/*
>  	 * if p->used is 0, nobody will ever touch that entry again;
> -- 
> 2.24.1
> 
