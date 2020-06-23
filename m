Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CCF3C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 07:33:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1726A2072E
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 07:33:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GokMgupy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731559AbgFWHdJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 03:33:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730951AbgFWHdI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 03:33:08 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B503C061573
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jun 2020 00:33:08 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id h22so1171081pjf.1
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jun 2020 00:33:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=hmnGdRkcCBJHx7icUGiLsxvipE4DNE7KOianpI8JtUE=;
        b=GokMgupyqmILvpJkMTNFvJL0a3QYbDgIuhbFNjvl15UmmRToEompdqZMWDOEDfrI+y
         QLPOJrLaU06aoaGMWHsHlOR+QY8cnDX17CKbGMExG/d5XclO/HAfObt52IwT4nT3tSL4
         FSpN7cunf+qLQnqUuyHnQNDC2yu2gDL/179PvoqRVlDZvz0Z9ZdCUc58oXVcYHJRYKQ8
         Fy9xo0YuvPGgzkhDYx/k9lMRCeIPDbX5HL979NKauTSYWx1HQRwR3qNhCKL9tPL/1n+C
         6ZpJRjxkOkhfeMq56temVi4y2pJ5sg1J6QMKOVDBkQ7IqiDACpMOcxXRUSPesYEklkDF
         hJqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=hmnGdRkcCBJHx7icUGiLsxvipE4DNE7KOianpI8JtUE=;
        b=W8RSPp0QuJ3jlH5zdRm81u7b3HRcJ7RSMs1l2P9lpZidTIHj2MI9jV5ImpuxyOxYyR
         QsI2yo2T2RAaLQyCFPxSQ3DEVZyXGod+lmAdW8H4Y1Q4Knx/tUK9Y7msLaZ4l40m2p3c
         GpvJuE52vCaohLARj/5GtKJCxCYJdKGex9zeFpspMrtdQvxUsTTKdLCyvVDevAdp+LEp
         bD8VIGcbru0w7HPKs//FGAOzj8pnvCzunVZwDzHDCsDpipI/V4iZiq4vDbAbrScse9ob
         jEngMflz9syB6Ily1pqgdxc1Ym+4js1EASseDLaRJgGwsXY1Tikd9EwzbeU038vvUtMZ
         kWGg==
X-Gm-Message-State: AOAM533u9tOkkGWLzhk2GgV6bwqbjjRaeERJcjm2aq4AA2IYP9iS70lU
        3bVDXQBqEhQwUp5BH9HwroQk826H
X-Google-Smtp-Source: ABdhPJwLe/FF7iw53pgC9zzByLUV2m/+A/ER6YrzXN3sgDidfAYp2d8KCbHB1Jx5HoqqKyLv3JFLMQ==
X-Received: by 2002:a17:902:8681:: with SMTP id g1mr22252607plo.161.1592897587534;
        Tue, 23 Jun 2020 00:33:07 -0700 (PDT)
Received: from gmail.com ([2601:600:9b7f:872e:a655:30fb:7373:c762])
        by smtp.gmail.com with ESMTPSA id y7sm1581592pjy.21.2020.06.23.00.33.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jun 2020 00:33:06 -0700 (PDT)
Date:   Tue, 23 Jun 2020 00:33:05 -0700
From:   Andrei Vagin <avagin@gmail.com>
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Dmitry Safonov <dima@arista.com>
Subject: Re: [PATCH 2/6] arm64/vdso: Zap vvar pages when switching to a time
 namespace
Message-ID: <20200623073305.GA23557@gmail.com>
References: <20200616075545.312684-1-avagin@gmail.com>
 <20200616075545.312684-3-avagin@gmail.com>
 <20200619153812.2d6anaynb4p37qv2@wittgenstein>
MIME-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <20200619153812.2d6anaynb4p37qv2@wittgenstein>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 19, 2020 at 05:38:12PM +0200, Christian Brauner wrote:
> On Tue, Jun 16, 2020 at 12:55:41AM -0700, Andrei Vagin wrote:
> > The VVAR page layout depends on whether a task belongs to the root or
> > non-root time namespace. Whenever a task changes its namespace, the VVAR
> > page tables are cleared and then they will be re-faulted with a
> > corresponding layout.
> > 
> > Reviewed-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
> > Reviewed-by: Dmitry Safonov <dima@arista.com>
> > Signed-off-by: Andrei Vagin <avagin@gmail.com>
> > ---
> >  arch/arm64/kernel/vdso.c | 32 ++++++++++++++++++++++++++++++++
> >  1 file changed, 32 insertions(+)
> > 
> > diff --git a/arch/arm64/kernel/vdso.c b/arch/arm64/kernel/vdso.c
> > index b0aec4e8c9b4..df4bb736d28a 100644
> > --- a/arch/arm64/kernel/vdso.c
> > +++ b/arch/arm64/kernel/vdso.c
> > @@ -125,6 +125,38 @@ static int __vdso_init(enum vdso_abi abi)
> >  	return 0;
> >  }
> >  
> > +#ifdef CONFIG_TIME_NS
> > +/*
> > + * The vvar page layout depends on whether a task belongs to the root or
> > + * non-root time namespace. Whenever a task changes its namespace, the VVAR
> > + * page tables are cleared and then they will re-faulted with a
> > + * corresponding layout.
> > + * See also the comment near timens_setup_vdso_data() for details.
> > + */
> > +int vdso_join_timens(struct task_struct *task, struct time_namespace *ns)
> > +{
> > +	struct mm_struct *mm = task->mm;
> > +	struct vm_area_struct *vma;
> > +
> > +	if (mmap_write_lock_killable(mm))
> > +		return -EINTR;
> 
> Hey,
> 
> Just a heads-up I'm about to plumb CLONE_NEWTIME support into setns()

Hmm. I am not sure that I unserstand what you mean. I think setns(nsfd,
CLONE_NEWTIME) works now. For example, we use it in
tools/testing/selftests/timens/timens.c. Do you mean setns(pidfd,
CLONE_NEWTIME | CLONE_something)?

> which would mean that vdso_join_timens() ould not be allowed to fail
> anymore to make it easy to switch to multiple namespaces atomically. So
> this would probably need to be changed to mmap_write_lock() which I've
> already brought up upstream:
> https://lore.kernel.org/lkml/20200611110221.pgd3r5qkjrjmfqa2@wittgenstein/
> (Assuming that people agree. I just sent the series and most people here
> are Cced.)
> 
> Thanks!
> Christian
