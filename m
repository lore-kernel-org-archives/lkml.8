Return-Path: <SRS0=5pK+=BB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLACK,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1141DC433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 13:19:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CEC2D20729
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 13:19:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="cGBEQdDH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732164AbgGVNTJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jul 2020 09:19:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731961AbgGVNTI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jul 2020 09:19:08 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC581C0619DC
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jul 2020 06:19:07 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id e13so1876741qkg.5
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jul 2020 06:19:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=byEVFSP4CT7W7MtcKspNSe1RgWMqN+t1NFIfNH6NJm0=;
        b=cGBEQdDHCfXw1h4nBaqzmkLEcoq2zpGg1Kl3yorKAbZDw75xpcH55jnkaUtI4cKHWU
         u+1xefBv+y6mDKeCnppHzQw5MFKdX+wNHdBS6Z9HRCBKQDV5/bRL/xmHVcbtWyRTyN6s
         fBMPHv4w+Pxta8ziJxp46rJ8il8vbtnftyP2euj+JwXdh9T5CTNZobwAtVKfeM0stHy9
         hVOdToEUDjbO0Ka+8mv9n0jdBtngD5Y9quOWxqXSWQosmYMjeL1IyS5Y1HQLnHB8mIGC
         k7riWpUTWr1dsMFziqCiZGBO4N5LFaFV6ICQl7j0OOfjVG+Apbv8TbnBtmIWWvUzWpKY
         IqsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=byEVFSP4CT7W7MtcKspNSe1RgWMqN+t1NFIfNH6NJm0=;
        b=r/6UOa5boN2jh48p/HL/UcG8Q/nrkI+oUh9OghFo5P5gjzsjYksI9njPv9aol0nUjD
         hpqTBBgvqDOM5+08H9Y4oslPLZ+1gXQFIOev7EUBapQzgxGE7hXin8krX74J+AxOq5Ff
         cI+oAatj9WLQ4blJDpX2UllOGS/w3OBeRNqv8wIBQdSVFXhQFy2fWxRlUb5KyxCExU1L
         vAha8mYE7cHkusM5N3WUmezFkR6luVfwosTgcSbvavAGkH5ONZUsCRiKtrNZEHpkEbD3
         gNsfKqSj2vM4G5LuJXMiJNiTbNqIou8b5XA9cJADBkNQEKiAo0iYVe7IMGvkl8togVaq
         nlpw==
X-Gm-Message-State: AOAM530FqeRVaGY0P9TEz4dyv7nXAlhszTCrL/aecksotUpLyL3G25vO
        j57cMK/EeUag924CfmFWtM2pZzBok3cpDA==
X-Google-Smtp-Source: ABdhPJy2Nv4Ey4vc5wBEtJqo/c+9GXzngRiPdzyEACMIWxlf2n14RsdenMCvvWzshYJl7acEgXLM3g==
X-Received: by 2002:a37:91c1:: with SMTP id t184mr29713737qkd.241.1595423947004;
        Wed, 22 Jul 2020 06:19:07 -0700 (PDT)
Received: from lca.pw (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id m203sm1096575qke.114.2020.07.22.06.19.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jul 2020 06:19:06 -0700 (PDT)
Date:   Wed, 22 Jul 2020 09:19:00 -0400
From:   Qian Cai <cai@lca.pw>
To:     peterz@infradead.org
Cc:     mark.rutland@arm.com, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] fork: silence a false postive warning in __mmdrop
Message-ID: <20200722131900.GA4041@lca.pw>
References: <20200604150344.1796-1-cai@lca.pw>
 <20200722100637.GR119549@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200722100637.GR119549@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 22, 2020 at 12:06:37PM +0200, peterz@infradead.org wrote:
> On Thu, Jun 04, 2020 at 11:03:44AM -0400, Qian Cai wrote:
> > The linux-next commit bf2c59fce407 ("sched/core: Fix illegal RCU from
> > offline CPUs") delayed,
> > 
> > idle->active_mm = &init_mm;
> > 
> > into finish_cpu() instead of idle_task_exit() which results in a false
> > positive warning that was originally designed in the commit 3eda69c92d47
> > ("kernel/fork.c: detect early free of a live mm").
> > 
> >  WARNING: CPU: 127 PID: 72976 at kernel/fork.c:697
> >  __mmdrop+0x230/0x2c0
> >  do_exit+0x424/0xfa0
> >  Call Trace:
> >  do_exit+0x424/0xfa0
> >  do_group_exit+0x64/0xd0
> >  sys_exit_group+0x24/0x30
> >  system_call_exception+0x108/0x1d0
> >  system_call_common+0xf0/0x278
> 
> Please explain; because afaict this is a use-after-free.
> 
> The thing is __mmdrop() is going to actually free the mm, so then what
> is finish_cpu()'s mmdrop() going to do?
> 
> ->active_mm() should have a refcount on the mm.

Well, the refcount issue you mentioned then happens all before bf2c59fce407 was
introduced as well, but then it looks harmless because mmdrop() in finish_cpu()
will do,

	if (unlikely(atomic_dec_and_test(&mm->mm_count)))
		__mmdrop(mm);

where that atomic_dec_and_test() see the negative refcount and will not involve
__mmdrop() again. It is not clear to me that once the CPU is offline if it
needs to care about its idle thread mm_count at all. Even if this refcount
issue is finally addressed, it could hit this warning in finish_cpu() without
this patch.

On the other hand, if you look at the commit 3eda69c92d47, it is clearly that
the assumption of,

   WARN_ON_ONCE(mm == current->active_mm);

is totally gone due to bf2c59fce407. Thus, the patch is to fix that discrepancy
first and then I'll look at that the imbalance mmdrop()/mmgrab() elsewhere.

> 
> > Fixes: bf2c59fce407 ("sched/core: Fix illegal RCU from offline CPUs")
> > Signed-off-by: Qian Cai <cai@lca.pw>
> > ---
> >  kernel/fork.c | 1 -
> >  1 file changed, 1 deletion(-)
> > 
> > diff --git a/kernel/fork.c b/kernel/fork.c
> > index 142b23645d82..5334efd2a680 100644
> > --- a/kernel/fork.c
> > +++ b/kernel/fork.c
> > @@ -694,7 +694,6 @@ void __mmdrop(struct mm_struct *mm)
> >  {
> >  	BUG_ON(mm == &init_mm);
> >  	WARN_ON_ONCE(mm == current->mm);
> > -	WARN_ON_ONCE(mm == current->active_mm);
> >  	mm_free_pgd(mm);
> >  	destroy_context(mm);
> >  	mmu_notifier_subscriptions_destroy(mm);
> > -- 
> > 2.21.0 (Apple Git-122.2)
> > 
