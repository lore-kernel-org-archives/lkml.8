Return-Path: <SRS0=y5Sx=A3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CEF5C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 08:35:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 58DB02067D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 08:35:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594888517;
	bh=/2fmB+sFh0shSq61uQ/Rpq1CbOycGEJZe+jTmwn25lk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=d3cPiFUtmBTu8xyfheJQ2J48X8PQPGEau2Em7uAc7vOYEA39rfe15nAwflMLDPIGc
	 KUDjP1BQqF61USIyAFKVkS0m4rwY2HmcfqbSI0faJp0PLTflAL8FUqg4x4+SVBFOej
	 RtXA3dsQYPRQkF6CnYdSUMfuWOqYO404qlzG/cAE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727025AbgGPIfQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jul 2020 04:35:16 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:54114 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725831AbgGPIfP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jul 2020 04:35:15 -0400
Received: by mail-wm1-f66.google.com with SMTP id j18so9396390wmi.3
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jul 2020 01:35:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=SCfJrST46qsDSMEeSPURbguLv5Ok1Ae63n1bRqdpvEU=;
        b=LMTbvmHlE71V4G6DDnO4hzqIeC/GAW9XsGTzKjoTp0VUN4UFH/azz0SmN0fv3ub6JN
         JP07+DdZxCznVtful4waRgo/Bo/4/4IVETsc1AMZmEot36I3ajKgQp9tbqFq4xZJgOvj
         Wo9IYruquhUCtu2518/Zx2w0jCEd6D9/UeZo7Mk+t6XCE5jJ9CAild9QgTE/mSJI9vcQ
         vnYMVuroH1KTKDp5z3ep7iNwZxtxsOk4cdMVtd5lBRYhMONX3eBz7IrQZh4buOEsHlvn
         cxuuhdPEY3/xag+dInAEqjssFcJlATZG4elvwDIodl9Av5/8CrOphfG9c+fLmgF/B8SE
         eIjQ==
X-Gm-Message-State: AOAM531hs1/HUzdvo7YvAf7VJ/yeifpBTHO6AUI5k4Ckq5pVgEK+1HFy
        F7HkvAAdJqx34uKOAZ5dUtA=
X-Google-Smtp-Source: ABdhPJykcwCVuCzDa+1jzmfvr7sUJBVtZnozf/QJbmRYAEOA1BdDzHjM4ShBya82D//FX2ojusDXsg==
X-Received: by 2002:a1c:f60d:: with SMTP id w13mr3460331wmc.51.1594888513277;
        Thu, 16 Jul 2020 01:35:13 -0700 (PDT)
Received: from localhost (ip-37-188-169-187.eurotel.cz. [37.188.169.187])
        by smtp.gmail.com with ESMTPSA id j24sm8302028wrd.43.2020.07.16.01.35.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2020 01:35:12 -0700 (PDT)
Date:   Thu, 16 Jul 2020 10:35:06 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arve Hjonnevag <arve@android.com>,
        Todd Kjos <tkjos@android.com>,
        Martijn Coenen <maco@android.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Christian Brauner <christian@brauner.io>,
        syzbot <syzbot+e5344baa319c9a96edec@syzkaller.appspotmail.com>,
        acme@kernel.org, alexander.shishkin@linux.intel.com,
        jolsa@redhat.com, linux-kernel@vger.kernel.org,
        mark.rutland@arm.com, mingo@redhat.com, namhyung@kernel.org,
        peterz@infradead.org, syzkaller-bugs@googlegroups.com,
        "open list:ANDROID DRIVERS" <devel@driverdev.osuosl.org>,
        linux-mm <linux-mm@kvack.org>
Subject: Re: [PATCH] binder: Don't use mmput() from shrinker function.
Message-ID: <20200716083506.GA20915@dhcp22.suse.cz>
References: <0000000000001fbbb605aa805c9b@google.com>
 <5ce3ee90-333e-638d-ac8c-cd6d7ab7aa3b@I-love.SAKURA.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5ce3ee90-333e-638d-ac8c-cd6d7ab7aa3b@I-love.SAKURA.ne.jp>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 16-07-20 08:36:52, Tetsuo Handa wrote:
> syzbot is reporting that mmput() from shrinker function has a risk of
> deadlock [1]. Don't start synchronous teardown of mm when called from
> shrinker function.

Please add the actual lock dependency to the changelog.

Anyway is this deadlock real? Mayve I have missed some details but the
call graph points to these two paths.
uprobe_mmap					do_shrink_slab	
  uprobes_mmap_hash #lock
  install_breakpoint				  binder_shrink_scan
    set_swbp					    binder_alloc_free_page
      uprobe_write_opcode			      __mmput
	update_ref_ctr				        uprobe_clear_state
    	  mutex_lock(&delayed_uprobe_lock)	          mutex_lock(&delayed_uprobe_lock);
	    allocation -> reclaim

But in order for this to happen the shrinker would have to do the last
put on the mm. But mm cannot go away from under uprobe_mmap so those two
paths cannot race with each other.

Unless I am missing something this is a false positive. I do not mind
using mmput_async from the shrinker as a workaround but the changelog
should be explicit about the fact.

> [1] https://syzkaller.appspot.com/bug?id=bc9e7303f537c41b2b0cc2dfcea3fc42964c2d45
> 
> Reported-by: syzbot <syzbot+1068f09c44d151250c33@syzkaller.appspotmail.com>
> Reported-by: syzbot <syzbot+e5344baa319c9a96edec@syzkaller.appspotmail.com>
> Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
> ---
>  drivers/android/binder_alloc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/android/binder_alloc.c b/drivers/android/binder_alloc.c
> index 42c672f1584e..cbe6aa77d50d 100644
> --- a/drivers/android/binder_alloc.c
> +++ b/drivers/android/binder_alloc.c
> @@ -947,7 +947,7 @@ enum lru_status binder_alloc_free_page(struct list_head *item,
>  		trace_binder_unmap_user_end(alloc, index);
>  	}
>  	mmap_read_unlock(mm);
> -	mmput(mm);
> +	mmput_async(mm);
>  
>  	trace_binder_unmap_kernel_start(alloc, index);
>  
> -- 
> 2.18.4
> 

-- 
Michal Hocko
SUSE Labs
