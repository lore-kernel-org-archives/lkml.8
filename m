Return-Path: <SRS0=Oudi=B7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F838C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 00:26:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 07D372078D
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 00:26:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="ZXTvN+Ad"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726938AbgHUA0B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 20:26:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725834AbgHUAZ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 20:25:59 -0400
Received: from mail-qv1-xf44.google.com (mail-qv1-xf44.google.com [IPv6:2607:f8b0:4864:20::f44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2A9AC061385
        for <linux-kernel@vger.kernel.org>; Thu, 20 Aug 2020 17:25:58 -0700 (PDT)
Received: by mail-qv1-xf44.google.com with SMTP id x6so29286qvr.8
        for <linux-kernel@vger.kernel.org>; Thu, 20 Aug 2020 17:25:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=1Jw+Cdk9MfRlVtpErJSkzPdykdAR8J99YeYAL5fDmXY=;
        b=ZXTvN+AdD/Xc4+E53azq1Z+Sin9ZwOE25dkjzCOI4ySw4IoDIc2MR9kKuv0YEkm/Cl
         Qr+JOpUj3soPeeqsofZLfxhLDXJS7mTznNEwV7bUP2MDuyFgGYwm99ubxd8QX/ZPciMh
         dH4t1o8fvvuQA3N+Cikg6xbXuTmJIQgGwqGYleYbmvCBnLF0Hp+XsXtxZOSfh0uKdW6Q
         sTBE57tNVR5lato0L5OI7Vc4DuGYSuC7/+2nipEV5Sp0B+ACQPWYMWQMRORmkqtKuKjn
         IRAXcu5FbxsEVUTOguRe7eecFIST/zlOpXogIUZn1RTNKtXHXIdmBJtNykHXeqww79a4
         ltLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=1Jw+Cdk9MfRlVtpErJSkzPdykdAR8J99YeYAL5fDmXY=;
        b=hI9Ns1gZVL2WmAe1ISpSIT+eDadFfSoVx/8UBQC1m+210uFP2tvaWF2i0L53dG+1Rm
         40K1JTiM7l+fR8TN5+RF8LgZPYzSslBntLiN9sjb16sJbax0ZtLgUZ5rcJSFiybQ1cD6
         18jfXLPaOjEVZaRUPSRZajl0LuxQCFhMkSwnlUKyVk3faYL5xMlnHxA9vZt5n6TMticT
         cXZRLQh/rkn/gW3ifsBXyHWAMdwfy6P7SIkHIIjriPMg1jgBj6/AgI9TTrZUpdXdM5Ev
         FnH3PskV/MvaHKZzS+mSxfNyYqhBY2YopuimP/0GPE2fXwvYZ1r6ihq7PbKpsgp7xzdL
         /TCg==
X-Gm-Message-State: AOAM531pdaTeRWre2g67n4oW3ff85eTSNtVK/DQrAoMS3AwMJhMRKHxM
        WBBmFyCTP3UyS6niomeRXqZkMkXk01kRMg==
X-Google-Smtp-Source: ABdhPJx/06R+afR/wZQarlnuBNgbGhN7UPE92LHqX/7DKMOiyMcAyKb3rUIeF2vivT+tEX4n73npgg==
X-Received: by 2002:ad4:5349:: with SMTP id v9mr316429qvs.160.1597969558110;
        Thu, 20 Aug 2020 17:25:58 -0700 (PDT)
Received: from lca.pw (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id w18sm309816qtk.1.2020.08.20.17.25.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Aug 2020 17:25:57 -0700 (PDT)
Date:   Thu, 20 Aug 2020 20:25:55 -0400
From:   Qian Cai <cai@lca.pw>
To:     Davidlohr Bueso <dave@stgolabs.net>
Cc:     akpm@linux-foundation.org, catalin.marinas@arm.com,
        oleg@redhat.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Davidlohr Bueso <dbueso@suse.de>
Subject: Re: [PATCH] mm/kmemleak: rely on rcu for task stack scanning
Message-ID: <20200821002554.GB4622@lca.pw>
References: <20200820203902.11308-1-dave@stgolabs.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200820203902.11308-1-dave@stgolabs.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 20, 2020 at 01:39:02PM -0700, Davidlohr Bueso wrote:
> kmemleak_scan() currently relies on the big tasklist_lock
> hammer to stabilize iterating through the tasklist. Instead,
> this patch proposes simply using rcu along with the rcu-safe
> for_each_process_thread flavor (without changing scan semantics),
> which doesn't make use of next_thread/p->thread_group and thus
> cannot race with exit. Furthermore, any races with fork()
> and not seeing the new child should be benign as it's not
> running yet and can also be detected by the next scan.

It is not entirely clear to me what problem the patch is trying to solve. If
this is about performance, we will probably need some number.

> 
> Signed-off-by: Davidlohr Bueso <dbueso@suse.de>
> ---
>  mm/kmemleak.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/mm/kmemleak.c b/mm/kmemleak.c
> index 5e252d91eb14..c0014d3b91c1 100644
> --- a/mm/kmemleak.c
> +++ b/mm/kmemleak.c
> @@ -1471,15 +1471,15 @@ static void kmemleak_scan(void)
>  	if (kmemleak_stack_scan) {
>  		struct task_struct *p, *g;
>  
> -		read_lock(&tasklist_lock);
> -		do_each_thread(g, p) {
> +		rcu_read_lock();
> +		for_each_process_thread(g, p) {
>  			void *stack = try_get_task_stack(p);
>  			if (stack) {
>  				scan_block(stack, stack + THREAD_SIZE, NULL);
>  				put_task_stack(p);
>  			}
> -		} while_each_thread(g, p);
> -		read_unlock(&tasklist_lock);
> +		}
> +		rcu_read_unlock();
>  	}
>  
>  	/*
> -- 
> 2.26.2
