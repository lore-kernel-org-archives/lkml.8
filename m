Return-Path: <SRS0=/EmK=CQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E323BC43461
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 14:03:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 908B82064B
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 14:03:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sDvpzil3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729754AbgIGODX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Sep 2020 10:03:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729731AbgIGN56 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Sep 2020 09:57:58 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED9E8C061575
        for <linux-kernel@vger.kernel.org>; Mon,  7 Sep 2020 06:46:18 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id z4so15891450wrr.4
        for <linux-kernel@vger.kernel.org>; Mon, 07 Sep 2020 06:46:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=QqRdXLbNsyiLC26IMPUlFbXwycGvbHh7pYgLoGLtyg4=;
        b=sDvpzil3Gf7CH1I3z9v3YFEFyUo9UV34Ykm8/kSd127pXJnk1nBa2qMLorc9yEpNic
         rTe56xsIpMN/+Rnuf95br7T9aB1cPAxXhfICjV4uBKEbxoPE9Svpqge9nT2aEqxZ8ADM
         QT2UIoMDiNahSLGChc3utN8GNOBUWdl9Yijza4/+/KTjoI2Pve3k3KVnMREi+EcmEkxy
         m4XULLtYAZQ4vRh+ZUsp1ts4XBE1sq4tN1hzJpEZ5ep4Pj9P9awfxsj3t71v8pAjnw+6
         1aeaiA2YbMgH1kp7mHwYBwEZ3SIo7Cn/jmEWaZLtrwojKkZAdyrW0dH9GngyWN4p1e5j
         bl/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=QqRdXLbNsyiLC26IMPUlFbXwycGvbHh7pYgLoGLtyg4=;
        b=ZDrbLYF1XmFEqfm+I9a8QthD2bEIkrwjN5BwdmSKhk6W48lhE2tVbVaHwH12VOTBuo
         ermgjcse+9TMy5ShwkgEmKeja2QyeItmkeQd0ms4TIALd+0o1YgVrxJ7JyzZb+WerQa6
         qVBoMxHyQm60IN/oguFPIJ7t93YAjM74JPagWuUAANdML3PP4qCuxE/HTfH8W6r9y80v
         hWP/ba0zorTBkvqC//7M6BnMjaiFr30NazZTiQV6GhT788Pka4VlJr8aolIFvYjPoLdV
         2kGmmtOxTegjHeoXCJkSYmOvja7MYu1BvYGvBzkVYW4YJTTnqDK0u+u1DqKDGikRCGZl
         i0fQ==
X-Gm-Message-State: AOAM5334IVIAndH4CjRxxwn7wSLrYVIRzod+hbZt6wWkKfZFidHAYW+f
        plciuLZi9XKkFBKKjTezpxxmHw==
X-Google-Smtp-Source: ABdhPJz2iMdjK+R9m77aJniknbmvs6Ce2El/pj/PY4PWLuc+p8JZFWdzfM1Vy3/KUkXx422UrxG1oA==
X-Received: by 2002:adf:ec47:: with SMTP id w7mr2796302wrn.175.1599486376968;
        Mon, 07 Sep 2020 06:46:16 -0700 (PDT)
Received: from holly.lan (cpc141214-aztw34-2-0-cust773.18-1.cable.virginm.net. [86.9.19.6])
        by smtp.gmail.com with ESMTPSA id l8sm28893288wrx.22.2020.09.07.06.46.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Sep 2020 06:46:16 -0700 (PDT)
Date:   Mon, 7 Sep 2020 14:46:14 +0100
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Davidlohr Bueso <dave@stgolabs.net>
Cc:     jason.wessel@windriver.com, dianders@chromium.org, oleg@redhat.com,
        kgdb-bugreport@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        Davidlohr Bueso <dbueso@suse.de>
Subject: Re: [PATCH -next] kdb: Use newer api for tasklist scanning
Message-ID: <20200907134614.guc4tzj3knnihbe4@holly.lan>
References: <20200831193435.22141-1-dave@stgolabs.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200831193435.22141-1-dave@stgolabs.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 31, 2020 at 12:34:35PM -0700, Davidlohr Bueso wrote:
> This kills the custom kdb_do_each_thread/kdb_while_each_thread
> calls used in kdb to iterate through all tasks. It is obsolete
> and racy to use tsk->thread_group, although in this particular

No objections to the change but kdb doesn't use tsk->thread_group,
it uses do_each_thread/while_each_thread. Can we change this to
say that is osbsolete and racy to use while_each_thread() (that's
pretty much what the description of the patch that introduced
for_each_thread said)?

Additionally the debug_core uses do_each_thread/while_each_thread.
Presumably that would like to be changed as well?


Daniel.



> case there is no concurrency so it doesn't matter. Still, lets
> trivially replace it for the newer one, maintaining semantics,
> of course.
> 
> Signed-off-by: Davidlohr Bueso <dbueso@suse.de>
> ---
>  kernel/debug/kdb/kdb_bt.c      | 4 ++--
>  kernel/debug/kdb/kdb_main.c    | 8 ++++----
>  kernel/debug/kdb/kdb_private.h | 4 ----
>  3 files changed, 6 insertions(+), 10 deletions(-)
> 
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
