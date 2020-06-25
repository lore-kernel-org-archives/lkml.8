Return-Path: <SRS0=lrRa=AG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1D73C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 08:25:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9E5A8207E8
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 08:25:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rk2maCO/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390597AbgFYIZp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jun 2020 04:25:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389522AbgFYIZo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jun 2020 04:25:44 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58032C061573
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jun 2020 01:25:44 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id 35so2510165ple.0
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jun 2020 01:25:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=8shbGUz09vnq5gNf7icF354v58ok08URPqfuPWDFRzQ=;
        b=Rk2maCO/OrlFxHe6vAWk3QLXAgquWZmsSBnIxOP9FJ+AVXIQwa6pF04oh8jTQ7cVl/
         6lX97Y/0y7ushSZ4yOtSup4hfmM3DYEafqBuYWsGZFBh7mvBI4aC/80p0yqkTpKWBXx4
         UjJfZt7bM8LR/4d4qRp5G5HalUZKUwaFnb/5dknQJd5OpgqxJBuckmzjf/PLfD7ggjlj
         ldOJFoVB1AUFL3IGwSROD6+2hXNJMClG3JOm08cFGZgfK8lu6SI6RS5mqbjr2dlxvmaT
         e+CXrqyjpgIdj0FEeEa53o/0POuPMmA5nzxDcS9LLa0NO4EupAvnbBEhTkN0Wypd7ASK
         QhFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=8shbGUz09vnq5gNf7icF354v58ok08URPqfuPWDFRzQ=;
        b=l+JX9oFysr+hAtJmyntKJuRSlA5RK07kuRqhc6pAJf7P3cmQBvK9ST9NpNLcHLfTkn
         yQ/OCCf3Nc1x+YqpNP52UxiKZu0MIiRiQ9YlHH61LaXqnkj6PqtH6jcmWDgCKCnxu7DV
         FYRUYiSHpxkMc33/OcZCQ2jEavDjuBkaST6aDF6FXtCeN5kOCPLSVqht/TsjqhpQ/sl+
         1/FDralObfEqpEEDnuROGHG54Pt7W9kuyeDgnAjANzhmeFa7kvnIXQhcMaPo6h1wnsfA
         +yx8qTiqPZGkFX0OBPF4DqaxsNXKiBXTHHeom+XE8iDAD2m8heYWoxfQMF7l8DkhWXwG
         hOtw==
X-Gm-Message-State: AOAM530hgkmq2qMKIJuuYUoMP0TV5Wlj2bhthgzxMskAUlBrVLcfuBvA
        tf9V74qOqkcVWZEKstuwcQg=
X-Google-Smtp-Source: ABdhPJw+RA8/j3gtWBVkEMpdmHNLD1QgL6L1iOEQXi0gn686S/8LW5mVCLCRc96o4pWcSQ1ytK5Hkw==
X-Received: by 2002:a17:90a:a116:: with SMTP id s22mr2001065pjp.202.1593073543656;
        Thu, 25 Jun 2020 01:25:43 -0700 (PDT)
Received: from gmail.com ([2601:600:9b7f:872e:a655:30fb:7373:c762])
        by smtp.gmail.com with ESMTPSA id o20sm7359290pjw.19.2020.06.25.01.25.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jun 2020 01:25:43 -0700 (PDT)
Date:   Thu, 25 Jun 2020 01:25:41 -0700
From:   Andrei Vagin <avagin@gmail.com>
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Dmitry Safonov <dima@arista.com>
Subject: Re: [PATCH 2/6] arm64/vdso: Zap vvar pages when switching to a time
 namespace
Message-ID: <20200625082541.GA151695@gmail.com>
References: <20200624083321.144975-1-avagin@gmail.com>
 <20200624083321.144975-3-avagin@gmail.com>
 <20200624151801.y27a5joml3mxeo4o@wittgenstein>
MIME-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <20200624151801.y27a5joml3mxeo4o@wittgenstein>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 24, 2020 at 05:18:01PM +0200, Christian Brauner wrote:
> On Wed, Jun 24, 2020 at 01:33:17AM -0700, Andrei Vagin wrote:
> > The order of vvar pages depends on whether a task belongs to the root
> > time namespace or not. In the root time namespace, a task doesn't have a
> > per-namespace page. In a non-root namespace, the VVAR page which contains
> > the system-wide VDSO data is replaced with a namespace specific page
> > that contains clock offsets.
> > 
> > Whenever a task changes its namespace, the VVAR page tables are cleared
> > and then they will be re-faulted with a corresponding layout.
> > 
> > A task can switch its time namespace only if its ->mm isn't shared with
> > another task.
> > 
> > Reviewed-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
> > Reviewed-by: Dmitry Safonov <dima@arista.com>
> > Signed-off-by: Andrei Vagin <avagin@gmail.com>
> > ---
> >  arch/arm64/kernel/vdso.c | 31 +++++++++++++++++++++++++++++++
> >  1 file changed, 31 insertions(+)
> > 
> > diff --git a/arch/arm64/kernel/vdso.c b/arch/arm64/kernel/vdso.c
> > index 7c4620451fa5..bdf492a17dff 100644
> > --- a/arch/arm64/kernel/vdso.c
> > +++ b/arch/arm64/kernel/vdso.c
> > @@ -124,6 +124,37 @@ static int __vdso_init(enum vdso_abi abi)
> >  	return 0;
> >  }
> >  
> > +#ifdef CONFIG_TIME_NS
> > +/*
> > + * The vvar mapping contains data for a specific time namespace, so when a task
> > + * changes namespace we must unmap its vvar data for the old namespace.
> > + * Subsequent faults will map in data for the new namespace.
> > + *
> > + * For more details see timens_setup_vdso_data().
> > + */
> > +int vdso_join_timens(struct task_struct *task, struct time_namespace *ns)
> > +{
> > +	struct mm_struct *mm = task->mm;
> > +	struct vm_area_struct *vma;
> > +
> > +	mmap_read_lock(mm);
> 
> Perfect, thanks! I'll adapt my patches so that my change and this change
> don't conflict and can go in together. Once they're landed we can simply
> turn int vdso_join_timens() into void vdso_join_timens() everywhere.

Yep. Let's do it this way. Thanks!

> 
> Reviewed-by: Christian Brauner <christian.brauner@ubuntu.com>
> 
> Thanks!
> Christian
