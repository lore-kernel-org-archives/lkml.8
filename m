Return-Path: <SRS0=iZCi=CS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 832C6C43461
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 16:03:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3335E2067C
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 16:03:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qx/KDtIx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730824AbgIIQDB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Sep 2020 12:03:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730569AbgIIP5U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Sep 2020 11:57:20 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 510F9C0617B9
        for <linux-kernel@vger.kernel.org>; Wed,  9 Sep 2020 06:37:56 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id e16so3020750wrm.2
        for <linux-kernel@vger.kernel.org>; Wed, 09 Sep 2020 06:37:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=05cqLnvwurAG2nT9cn66pd3c6M1ZLUU9TcHpBge76Y0=;
        b=qx/KDtIxcASxVw6BmBwCFkswRfMEmntnHNylhIbTKyXIxmiihdUuq/sjUxVBYLQKWE
         tclmv23Xg6FYqvItYPbv/ZXJ8RHbNh6VssaL0zFUVFiDjHQZlOQ6qI9Qjn6LK/zpx652
         HeDWQzfyNDFxUAVNirHx0uFEGMyxl4O+X6OWeDmD2UJbEhvkbFq0AZzaR7sy0nWhHnp5
         kCbHrjXfVGMw85pls6rTNhXvbwD+XNZCKrV4UFC8+4FAjwBi1aWTn9NDYTZJ11elKI68
         0cnSIioQGtivTzQl3Nv63qH2DGjW5y4gkBmElrTr1aQ2KIiDWmhmMpzg81dLkuPv5DYK
         nGDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=05cqLnvwurAG2nT9cn66pd3c6M1ZLUU9TcHpBge76Y0=;
        b=pmrW8hPKneljTKbKU/nj3Yuh67zZMI5wfbN33jUKkKRBZ+wAnBh0jojOgs0PxJDOn2
         V6914blw+5wWPbbV3eBl3BF3e3AXrDmM1m+4q7ptO3jmlI8MVMPRM5T2eyFh4fBh8/tu
         DEaao3NvYShVnBiYk+RDPc/sPKMXUMiMyeJUAVCHefnCLumMWs+u9OCGhyMtmg/0D4Ng
         uDG7bapiRPh0OIcFMR+Yfo/evRjW6q0exgtq2cGiyl/I5oPFA6+h3IuwHHGpENWxS4VM
         cSPdDMgfIL4aJLN8VlcjO8fcnAHGiM9YVpIObh5bNKbsmRLqPum9GoAl4Gie1bGcyy4m
         IbVQ==
X-Gm-Message-State: AOAM531iYlQdk6dM863mfvjlixArHu8126tXeQYbsEqCA12YCij8k7dR
        26CS5QtiGjU5Tj9s1Zr0xROYRg==
X-Google-Smtp-Source: ABdhPJwR4yz+lrnFsWPaPfQx5cX9uEgPeV4TBu13brw8jj4FHCrPrszb3SZCmmL/t67uLrzIDirWbw==
X-Received: by 2002:adf:e4c9:: with SMTP id v9mr3809264wrm.375.1599658674956;
        Wed, 09 Sep 2020 06:37:54 -0700 (PDT)
Received: from holly.lan (cpc141214-aztw34-2-0-cust773.18-1.cable.virginm.net. [86.9.19.6])
        by smtp.gmail.com with ESMTPSA id w7sm4302641wrm.92.2020.09.09.06.37.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2020 06:37:54 -0700 (PDT)
Date:   Wed, 9 Sep 2020 14:37:52 +0100
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Davidlohr Bueso <dave@stgolabs.net>
Cc:     dianders@chromium.org, jason.wessel@windriver.com, oleg@redhat.com,
        kgdb-bugreport@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        Davidlohr Bueso <dbueso@suse.de>
Subject: Re: [PATCH v2] kdb: Use newer api for tasklist scanning
Message-ID: <20200909133752.t7zbnaupd3y22bzd@holly.lan>
References: <20200907134614.guc4tzj3knnihbe4@holly.lan>
 <20200907203206.21293-1-dave@stgolabs.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200907203206.21293-1-dave@stgolabs.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 07, 2020 at 01:32:06PM -0700, Davidlohr Bueso wrote:
> This kills using the do_each_thread/while_each_thread combo to
> iterate all threads and uses for_each_process_thread() instead,
> maintaining semantics. while_each_thread() is ultimately racy
> and deprecated;  although in this particular case there is no
> concurrency so it doesn't matter. Still lets trivially get rid
> of two more users.
> 
> Acked-by: Oleg Nesterov <oleg@redhat.com>
> Signed-off-by: Davidlohr Bueso <dbueso@suse.de>

Applied. Thanks!


Daniel.


> ---
>  kernel/debug/gdbstub.c         | 4 ++--
>  kernel/debug/kdb/kdb_bt.c      | 4 ++--
>  kernel/debug/kdb/kdb_main.c    | 8 ++++----
>  kernel/debug/kdb/kdb_private.h | 4 ----
>  4 files changed, 8 insertions(+), 12 deletions(-)
> 
> diff --git a/kernel/debug/gdbstub.c b/kernel/debug/gdbstub.c
> index cc3c43dfec44..b52ebff09ac8 100644
> --- a/kernel/debug/gdbstub.c
> +++ b/kernel/debug/gdbstub.c
> @@ -725,7 +725,7 @@ static void gdb_cmd_query(struct kgdb_state *ks)
>  			}
>  		}
>  
> -		do_each_thread(g, p) {
> +		for_each_process_thread(g, p) {
>  			if (i >= ks->thr_query && !finished) {
>  				int_to_threadref(thref, p->pid);
>  				ptr = pack_threadid(ptr, thref);
> @@ -735,7 +735,7 @@ static void gdb_cmd_query(struct kgdb_state *ks)
>  					finished = 1;
>  			}
>  			i++;
> -		} while_each_thread(g, p);
> +		}
>  
>  		*(--ptr) = '\0';
>  		break;
> diff --git a/kernel/debug/kdb/kdb_bt.c b/kernel/debug/kdb/kdb_bt.c
> index 18e03aba2cfc..1f9f0e47aeda 100644
> --- a/kernel/debug/kdb/kdb_bt.c
> +++ b/kernel/debug/kdb/kdb_bt.c
> @@ -149,14 +149,14 @@ kdb_bt(int argc, const char **argv)
>  				return 0;
>  		}
>  		/* Now the inactive tasks */
> -		kdb_do_each_thread(g, p) {
> +		for_each_process_thread(g, p) {
>  			if (KDB_FLAG(CMD_INTERRUPT))
>  				return 0;
>  			if (task_curr(p))
>  				continue;
>  			if (kdb_bt1(p, mask, btaprompt))
>  				return 0;
> -		} kdb_while_each_thread(g, p);
> +		}
>  	} else if (strcmp(argv[0], "btp") == 0) {
>  		struct task_struct *p;
>  		unsigned long pid;
> diff --git a/kernel/debug/kdb/kdb_main.c b/kernel/debug/kdb/kdb_main.c
> index 5c7949061671..930ac1b25ec7 100644
> --- a/kernel/debug/kdb/kdb_main.c
> +++ b/kernel/debug/kdb/kdb_main.c
> @@ -2299,10 +2299,10 @@ void kdb_ps_suppressed(void)
>  		if (kdb_task_state(p, mask_I))
>  			++idle;
>  	}
> -	kdb_do_each_thread(g, p) {
> +	for_each_process_thread(g, p) {
>  		if (kdb_task_state(p, mask_M))
>  			++daemon;
> -	} kdb_while_each_thread(g, p);
> +	}
>  	if (idle || daemon) {
>  		if (idle)
>  			kdb_printf("%d idle process%s (state I)%s\n",
> @@ -2370,12 +2370,12 @@ static int kdb_ps(int argc, const char **argv)
>  	}
>  	kdb_printf("\n");
>  	/* Now the real tasks */
> -	kdb_do_each_thread(g, p) {
> +	for_each_process_thread(g, p) {
>  		if (KDB_FLAG(CMD_INTERRUPT))
>  			return 0;
>  		if (kdb_task_state(p, mask))
>  			kdb_ps1(p);
> -	} kdb_while_each_thread(g, p);
> +	}
>  
>  	return 0;
>  }
> diff --git a/kernel/debug/kdb/kdb_private.h b/kernel/debug/kdb/kdb_private.h
> index 2e296e4a234c..a4281fb99299 100644
> --- a/kernel/debug/kdb/kdb_private.h
> +++ b/kernel/debug/kdb/kdb_private.h
> @@ -230,10 +230,6 @@ extern struct task_struct *kdb_curr_task(int);
>  
>  #define kdb_task_has_cpu(p) (task_curr(p))
>  
> -/* Simplify coexistence with NPTL */
> -#define	kdb_do_each_thread(g, p) do_each_thread(g, p)
> -#define	kdb_while_each_thread(g, p) while_each_thread(g, p)
> -
>  #define GFP_KDB (in_interrupt() ? GFP_ATOMIC : GFP_KERNEL)
>  
>  extern void *debug_kmalloc(size_t size, gfp_t flags);
> -- 
> 2.26.2
