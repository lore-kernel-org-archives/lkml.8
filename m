Return-Path: <SRS0=52rg=4G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAD2CC34036
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 11:31:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A21CB21D56
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 11:31:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582025469;
	bh=ILx5E6KaiDlIDlIAneKu3bTzpNsCYVGZo4yrnNV92tE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=SCpIpK6sOFKjHcjxo1MTAGLeUCsJXkKhyGOo2wb7IK2QBQ9U86subjIZ8Wn6m/6ma
	 fDnYdlvw8OD0urn0dOnxTGEuzsIUCZkv3kQo79fn9VLbXhr0LpVNM+4BTi46PyU4o/
	 SWqv848MErRp2iBCRXtyBTy7LBnmaEDRvMl41bxM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726492AbgBRLbI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Feb 2020 06:31:08 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:40260 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726338AbgBRLbI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Feb 2020 06:31:08 -0500
Received: by mail-wr1-f65.google.com with SMTP id t3so23474438wru.7
        for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2020 03:31:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ZnoR/TIx7fKj96R5zmBvT3nyCVKnUxPHKYaYVRB0FaU=;
        b=tuAsaKpiH5UKtLepT9+DL63MHiEmUbjiP2P7isX25GVvOuxZBY8d3y0NJjwZoVstKI
         VDG/5UiQAOkrxQ0fckMk7xk0pdowr0lWSqF58sBWJhLMYu4VPJrz4KFtK7g2NiBITer7
         0mloyJkLaRe6v6JqYAvPxmNxD44wSpJMZ3ujKQXBFa+R4fFLCkccnjHQ4zFAiHnRLFMd
         XNfHJ5HBr3rxZ7YS3Mipq/Ic1fdoBTUYTsH6/CDMNrRK0dF4FPbufC+ODJDWpoMngVhw
         xRvq6wU8ZV43/tB1GCUQovyLCH8vb5F7+Ys19MLklL33C1PTJNSTZpRNVSvLO9tpwIUE
         nCfQ==
X-Gm-Message-State: APjAAAULrz5PjVUXWYi02rAxNvGzsCZQA160vafvT0+XUlOr0uz+e3wV
        aRanoHsPCAy8GPBLNgP80Tk=
X-Google-Smtp-Source: APXvYqx87NFgrpW3Y1vBrUUCZftoRQVXXG7WEdLVovV2FtSe62x/EMmLQIe+n9wpkKP19tQQdaXYkA==
X-Received: by 2002:adf:f401:: with SMTP id g1mr27996186wro.129.1582025464604;
        Tue, 18 Feb 2020 03:31:04 -0800 (PST)
Received: from localhost (prg-ext-pat.suse.com. [213.151.95.130])
        by smtp.gmail.com with ESMTPSA id b18sm5697555wru.50.2020.02.18.03.31.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Feb 2020 03:31:03 -0800 (PST)
Date:   Tue, 18 Feb 2020 12:31:03 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Andrea Arcangeli <aarcange@redhat.com>
Cc:     Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Jon Masters <jcm@jonmasters.org>,
        Rafael Aquini <aquini@redhat.com>,
        Mark Salter <msalter@redhat.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 1/2] mm: use_mm: fix for arches checking mm_users to
 optimize TLB flushes
Message-ID: <20200218113103.GB4151@dhcp22.suse.cz>
References: <20200203201745.29986-1-aarcange@redhat.com>
 <20200203201745.29986-2-aarcange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200203201745.29986-2-aarcange@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 03-02-20 15:17:44, Andrea Arcangeli wrote:
> alpha, ia64, mips, powerpc, sh, sparc are relying on a check on
> mm->mm_users to know if they can skip some remote TLB flushes for
> single threaded processes.
> 
> Most callers of use_mm() tend to invoke mmget_not_zero() or
> get_task_mm() before use_mm() to ensure the mm will remain alive in
> between use_mm() and unuse_mm().
> 
> Some callers however don't increase mm_users and they instead rely on
> serialization in __mmput() to ensure the mm will remain alive in
> between use_mm() and unuse_mm(). Not increasing mm_users during
> use_mm() is however unsafe for aforementioned arch TLB flushes
> optimizations. So either mmget()/mmput() should be added to the
> problematic callers of use_mm()/unuse_mm() or we can embed them in
> use_mm()/unuse_mm() which is more robust.

I would prefer we do not do that because then the real owner of the mm
cannot really tear down the address space and the life time of it is
bound to a kernel thread doing the use_mm. This is undesirable I would
really prefer if the existing few users would use mmget only when they
really need to access mm.

> Signed-off-by: Andrea Arcangeli <aarcange@redhat.com>
> ---
>  mm/mmu_context.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/mm/mmu_context.c b/mm/mmu_context.c
> index 3e612ae748e9..ced0e1218c0f 100644
> --- a/mm/mmu_context.c
> +++ b/mm/mmu_context.c
> @@ -30,6 +30,7 @@ void use_mm(struct mm_struct *mm)
>  		mmgrab(mm);
>  		tsk->active_mm = mm;
>  	}
> +	mmget(mm);
>  	tsk->mm = mm;
>  	switch_mm(active_mm, mm, tsk);
>  	task_unlock(tsk);
> @@ -57,6 +58,7 @@ void unuse_mm(struct mm_struct *mm)
>  	task_lock(tsk);
>  	sync_mm_rss(mm);
>  	tsk->mm = NULL;
> +	mmput(mm);
>  	/* active_mm is still 'mm' */
>  	enter_lazy_tlb(mm, tsk);
>  	task_unlock(tsk);
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

-- 
Michal Hocko
SUSE Labs
