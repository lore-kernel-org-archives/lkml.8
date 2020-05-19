Return-Path: <SRS0=IaiW=7B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E21F4C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 16:40:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B9E6B207C4
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 16:40:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qUFlJ/d8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729316AbgESQk5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 May 2020 12:40:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729053AbgESQk5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 12:40:57 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 412D4C08C5C0
        for <linux-kernel@vger.kernel.org>; Tue, 19 May 2020 09:40:57 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id y18so155495pfl.9
        for <linux-kernel@vger.kernel.org>; Tue, 19 May 2020 09:40:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=5lVC+y9qrofIhKyYVHhNqStVfPjx6c6mVisc11SZ+6g=;
        b=qUFlJ/d8B7IxlM5kkgpLO643/Gd3T+CLU/CLiO5/yckFzZ5AQcg/de9XwcNu2ghrxQ
         gxEjuXrUvHhqkKgOiGhIin1Zv2R1fkuI+X835miINTmIKoL443ZzDwX/6SslClvq40vP
         kVEpl/dZlQNrW3egoaD14Y4DqWMe1BbEAf1FOh4AIOAKu/d0h/Hjm7skpqhmkAvyJigS
         lyDlUp/qHaZ8F0taQXemNrHSttn5Jfs/dlYSQTwQ6ZFatek59/50Bgj3yKYcjMdfcIrR
         zfMoABuuqbmQ503eJsmNJTOs+/xVT336+x4GFcth1LAyALGFAoFFIL3ccqCZVFLfaYLr
         D+fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=5lVC+y9qrofIhKyYVHhNqStVfPjx6c6mVisc11SZ+6g=;
        b=FAACl177MA0jozVunwi1x4yc70JalYNMC2FuWR8zt5DfJBCAdqKEENp0aN+fVKZVtB
         5xFaKi0A/Mv4GwUMRHaxBnMva8kruJ57ddq0CHl0TAr339OWAo9RQQUVOYfaXKRvHkpX
         SNCNkNEEov01mqUVdG8EeBWaImM45blOSHz6an/2khSUFLxk6YlqAOAez8KUW+nGy8B4
         VmxO0mQ0i2HBToQE25Z3wJeJFKj3tth6wuiBj4mI3tNX0THfT0DBvWTJnkK4IyvilrvL
         +JUrj7bjvRs9TRFd2Y9RCzjxwQOgH/XXxP9JXzdqPyHSf8DR5c429fKW0+a5amyUc39u
         ErCA==
X-Gm-Message-State: AOAM531JV3uwl+U8ItDYdg9Y3hce1OoEuMIFWrZPn4J1lL1rWeuq3/oK
        LdkayBCOML7kc43BotEWWOM=
X-Google-Smtp-Source: ABdhPJyZFYWOpWGuvD+LD4P2lXQJgG+5HwUK8Jj9oxXp1NHVX1Y8ccaMuEdfZe/d81v2sJdj65Y/OA==
X-Received: by 2002:aa7:80cf:: with SMTP id a15mr14259pfn.124.1589906456808;
        Tue, 19 May 2020 09:40:56 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id n23sm98243pjq.18.2020.05.19.09.40.55
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 19 May 2020 09:40:56 -0700 (PDT)
Date:   Tue, 19 May 2020 09:40:55 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Mike Rapoport <rppt@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Ira Weiny <ira.weiny@intel.com>, Will Deacon <will@kernel.org>,
        linux-kernel@vger.kernel.org, elver@google.com, tglx@linutronix.de,
        paulmck@kernel.org, mingo@kernel.org, peterz@infradead.org,
        "David S. Miller" <davem@davemloft.net>
Subject: Re: [PATCH v5 04/18] sparc32: mm: Reduce allocation size for PMD and
 PTE tables
Message-ID: <20200519164055.GA23715@roeck-us.net>
References: <20200511204150.27858-1-will@kernel.org>
 <20200511204150.27858-5-will@kernel.org>
 <20200517000050.GA87467@roeck-us.net>
 <20200517000750.GA157503@roeck-us.net>
 <20200518083715.GA31383@willie-the-truck>
 <418aa44b-6fb3-c3d8-a920-1a26e5edec62@roeck-us.net>
 <20200518142310.GC1118872@kernel.org>
 <b171fbbd-f5b2-ac17-24e5-7188f6ce80f0@roeck-us.net>
 <20200518191511.GD1118872@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200518191511.GD1118872@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 18, 2020 at 10:15:11PM +0300, Mike Rapoport wrote:
> On Mon, May 18, 2020 at 11:09:46AM -0700, Guenter Roeck wrote:
> > On 5/18/20 7:23 AM, Mike Rapoport wrote:
> > 
> > Below is another set of bisect results, from next-20200518. It points to one
> > of your commits. This is for microblaze (big endian) boot failures.
> 
> The microblaze one was easy, as for sparc32 I still have no clue for the
> root cause :(
> 
> Andrew, can you please fold it into "mm: pgtable: add shortcuts for
> accessing kernel PMD and PTE"? 
> 
> From 167250de28aa526342641b2647294a755d234090 Mon Sep 17 00:00:00 2001
> From: Mike Rapoport <rppt@linux.ibm.com>
> Date: Mon, 18 May 2020 22:08:10 +0300
> Subject: [PATCH] microblaze: fix page table traversal in setup_rt_frame()
> 
> The replacement of long folded page table traversal with the direct access
> to PMD entry wrongly used the kernel page table in setup_rt_frame()
> function instead of the process (current->mm) page table.
> 
> Fix it.
> 
> Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>

Tested-by: Guenter Roeck <linux@roeck-us.net>

> ---
>  arch/microblaze/kernel/signal.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/microblaze/kernel/signal.c b/arch/microblaze/kernel/signal.c
> index 28b1ec4b4e79..bdd6d0c86e16 100644
> --- a/arch/microblaze/kernel/signal.c
> +++ b/arch/microblaze/kernel/signal.c
> @@ -194,7 +194,7 @@ static int setup_rt_frame(struct ksignal *ksig, sigset_t *set,
>  
>  	address = ((unsigned long)frame->tramp);
>  #ifdef CONFIG_MMU
> -	pmdp = pmd_off_k(address);
> +	pmdp = pmd_off(current->mm, address);
>  
>  	preempt_disable();
>  	ptep = pte_offset_map(pmdp, address);
> -- 
> 2.26.2
> 
> 
> > Guenter
> > 
> > ---
> 
> -- 
> Sincerely yours,
> Mike.
