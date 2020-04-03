Return-Path: <SRS0=4r1w=5T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E906C2BA16
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 18:18:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F150C20737
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 18:18:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GYSv3okM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390961AbgDCSS3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Apr 2020 14:18:29 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:41454 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728424AbgDCSS3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Apr 2020 14:18:29 -0400
Received: by mail-lj1-f193.google.com with SMTP id n17so7916671lji.8
        for <linux-kernel@vger.kernel.org>; Fri, 03 Apr 2020 11:18:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=8w2DZREDGtv4u783aIEwSYFiP7LUWQnaQXmT8Zgv0No=;
        b=GYSv3okMFKQstt5b0sUydEEQWFlqxI1B9B/kGugDsF3QEuULIMbHv/WWwB2JEjtT7R
         XQ5QOWXmOTvzdoYcxmCtnUSpTHHps8ROagnfQklUeIAkoNDpT0sgWVWVs4aibzeed6q9
         QYKZuuPA7RunRaRsd2alE/ukJz3WQJbn600xW0uQm0jwB6N6OkZNlm5s6kEChdSeBOKq
         1xAAaG71g73aM67UXDF77Wy5SH9GqjT7SYjg0wQraoWVorcVhoFtiqce8/64ocGkRnZz
         P0xhV53nrf15qM9avJXZjSJLji6Yc/xoReMrXYfnAVvKn7pkX5bRc+8t9GPso0TC220a
         vaMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=8w2DZREDGtv4u783aIEwSYFiP7LUWQnaQXmT8Zgv0No=;
        b=BJ+2EOLnDbK3H3WqNVCm0ft7KJuVTTlG6xHk7v3sad/MI9GKIRexFJRBKYzNvjBxzx
         0XBp8uzkhgS/bWPouCQ83A2uu8av44rV1WtwgbKuOEBf7zb+26p8vsfv17tgBOW28cHW
         11zeioT7KylFhupNoI0YwMPcC76pa3I+7PDLokeAjtgz4+3wqPhsdhWlX2ooxIWsO5HX
         73jstoYkCUmTwh9f05Ax69KUb0dIBpDy22TIaGw2EXq49gSvQrzJavmFazZSQ+F/ptF1
         kRjusvFwONBmyHxlTQF7/b4JzJrbesdZnZ5vW+JbDuGRYkyr1V1/XAnQxa4jEelqg8QN
         2w4g==
X-Gm-Message-State: AGi0PuZbnxxGeousA9Oc3JWtwLboJvuwJCi9Qo7UoWja6E1a9uy3obNd
        M6RVdHUMFg9xoNh8zb6Iq4c=
X-Google-Smtp-Source: APiQypKLE9bDigNrm1TkyiBTBx41I7lWdIZY8TUFAxEtzo7WfV7MdkiCAvj43xdheZynjqbkmNvB+A==
X-Received: by 2002:a2e:3a16:: with SMTP id h22mr5207330lja.81.1585937906962;
        Fri, 03 Apr 2020 11:18:26 -0700 (PDT)
Received: from pc636 (h5ef52e31.seluork.dyn.perspektivbredband.net. [94.245.46.49])
        by smtp.gmail.com with ESMTPSA id e20sm5602045ljn.107.2020.04.03.11.18.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Apr 2020 11:18:26 -0700 (PDT)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date:   Fri, 3 Apr 2020 20:18:18 +0200
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org, jroedel@suse.de,
        vbabka@suse.cz, urezki@gmail.com,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] mm/vmalloc: Sanitize __get_vm_area() arguments
Message-ID: <20200403181818.GA5538@pc636>
References: <20200403163253.GU20730@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200403163253.GU20730@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 03, 2020 at 06:32:53PM +0200, Peter Zijlstra wrote:
> 
> __get_vm_area() is an exported symbol, make sure the callers stay in
> the expected memory range. When calling this function with memory
> ranges outside of the VMALLOC range *bad* things can happen.
> 
> (I noticed this when I managed to corrupt the kernel text by accident)
> 
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> ---
>  mm/vmalloc.c |    7 +++++++
>  1 file changed, 7 insertions(+)
> 
> --- a/mm/vmalloc.c
> +++ b/mm/vmalloc.c
> @@ -2130,6 +2130,13 @@ static struct vm_struct *__get_vm_area_n
>  struct vm_struct *__get_vm_area(unsigned long size, unsigned long flags,
>  				unsigned long start, unsigned long end)
>  {
> +	/*
> +	 * Ensure callers stay in the vmalloc range.
> +	 */
> +	if (WARN_ON(start < VMALLOC_START || start > VMALLOC_END ||
> +		    end < VMALLOC_START || end > VMALLOC_END))
> +		return NULL;
> +
>  	return __get_vm_area_node(size, 1, flags, start, end, NUMA_NO_NODE,
>  				  GFP_KERNEL, __builtin_return_address(0));
>  }
Peter, could you please clarify what kind of issues you had and how you
tested?

__get_vm_area() is not limited by allocating only with vmalloc space,
it can use whole virtual address space/range, i.e. 1 - ULONG_MAX.

Though, i am not sure if there are users(who uses __get_vm_area())
which allocate outside of vmalloc address space.

--
Vlad Rezki
