Return-Path: <SRS0=dmjt=BL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28E6CC433E0
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Aug 2020 01:28:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 018BA20838
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Aug 2020 01:28:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MGWdNGvG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728047AbgHAB2K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jul 2020 21:28:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727095AbgHAB2J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jul 2020 21:28:09 -0400
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C20A8C06174A
        for <linux-kernel@vger.kernel.org>; Fri, 31 Jul 2020 18:28:09 -0700 (PDT)
Received: by mail-qt1-x843.google.com with SMTP id s23so24429671qtq.12
        for <linux-kernel@vger.kernel.org>; Fri, 31 Jul 2020 18:28:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=R7S9crGkSS+zqKV+6akgjVw/AncewqiAu9qufG43ZRg=;
        b=MGWdNGvG/aOp4sfcJNv9ej1bqPcyavBaerB+JRyI7t8uLrCovVqmRKcPD1uuesEusk
         0j9Wt+msOoIvdm+dldTktOMUtsoXcShCNG5wp+MuOynQPyVqRxWu1ylr0X65BnRUQxDZ
         TDvNAjWeAuF2K3ewYReTC1YgwUXRqZXuMKotqLSja/lQePnureOJtpItKp4KOF52f2R+
         46EU23VbTQWiRZL+CBCOA89oZRlwoPWkIBjs22I9NzI/6dRX+ugZBjscqdF29ftmz1rF
         td4N2M2Vn+bNwNwzCHEjGkmu1RaPZtTUjwUUU7HxZ7qeOvdM1zVg1nCejSXouGJAWQo8
         7DBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=R7S9crGkSS+zqKV+6akgjVw/AncewqiAu9qufG43ZRg=;
        b=TP76Kc8LLs9E+rPGPZDypBlqggkD2FVtV9A5AIULj7vfm3TeRsxkuEiy/x40QLvh1i
         5i14+QdSa1GtauOpjKGW42vJ6KojdgAb21KVwRUnU1V1XyiNHzyxhkDcXwpkvBG+a4U2
         +HD+TIVDEf0Qr87vMYuM7feyYn5b3Lef4g6Ingb9xy9/deYcTJ0iiuyGHnPgX/ehwDV8
         xtj6oJsTysdKNNh2dmWMN50ZoQNE3tdNC6Gc7c1cZy3T9TYQj+cFR9rDNHxVe2q2rkp+
         eGdurhAAiAhvR2dmhyec5lZeE1AVnTC5EPLxl5bvq3dOErEjZMuwpgifU4ZH/Bu8bUfi
         G4SQ==
X-Gm-Message-State: AOAM5339HbkpRukgTQAW29L/v3ZVZLRCSQhcloQkcft7gpkPl4FvOP6q
        uTO1ZeQzlAihldj7RGHDV6oZSd0=
X-Google-Smtp-Source: ABdhPJzHkgeXS0w0cpyOPKzY+6am7auQymCChpQrw8/7uitwJAiROxAIfoTnmyhkUUcR2IRCfBQDxA==
X-Received: by 2002:ac8:65cd:: with SMTP id t13mr6681148qto.368.1596245288751;
        Fri, 31 Jul 2020 18:28:08 -0700 (PDT)
Received: from PWN (146-115-88-66.s3894.c3-0.sbo-ubr1.sbo.ma.cable.rcncustomer.com. [146.115.88.66])
        by smtp.gmail.com with ESMTPSA id r6sm8484023qkc.43.2020.07.31.18.28.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jul 2020 18:28:08 -0700 (PDT)
Date:   Fri, 31 Jul 2020 21:28:04 -0400
From:   Peilin Ye <yepeilin.cs@gmail.com>
To:     "Dmitry V. Levin" <ldv@altlinux.org>
Cc:     Elvira Khabirova <lineprinter@altlinux.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [Linux-kernel-mentees] [PATCH] ptrace: Prevent kernel-infoleak
 in ptrace_get_syscall_info()
Message-ID: <20200801012804.GA220239@PWN>
References: <20200727213644.328662-1-yepeilin.cs@gmail.com>
 <20200801002142.GA27762@altlinux.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200801002142.GA27762@altlinux.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 01, 2020 at 03:21:42AM +0300, Dmitry V. Levin wrote:
> On Mon, Jul 27, 2020 at 05:36:44PM -0400, Peilin Ye wrote:
> > ptrace_get_syscall_info() is copying uninitialized stack memory to
> > userspace due to the compiler not initializing holes in statically
> > allocated structures. Fix it by initializing `info` with memset().
> > 
> > Cc: stable@vger.kernel.org
> > Fixes: 201766a20e30 ("ptrace: add PTRACE_GET_SYSCALL_INFO request")
> > Suggested-by: Dan Carpenter <dan.carpenter@oracle.com>
> > Signed-off-by: Peilin Ye <yepeilin.cs@gmail.com>
> > ---
> >  kernel/ptrace.c | 14 ++++++++------
> >  1 file changed, 8 insertions(+), 6 deletions(-)
> > 
> > diff --git a/kernel/ptrace.c b/kernel/ptrace.c
> > index 43d6179508d6..e48d05b765b5 100644
> > --- a/kernel/ptrace.c
> > +++ b/kernel/ptrace.c
> > @@ -960,15 +960,17 @@ ptrace_get_syscall_info(struct task_struct *child, unsigned long user_size,
> >  			void __user *datavp)
> >  {
> >  	struct pt_regs *regs = task_pt_regs(child);
> > -	struct ptrace_syscall_info info = {
> > -		.op = PTRACE_SYSCALL_INFO_NONE,
> > -		.arch = syscall_get_arch(child),
> > -		.instruction_pointer = instruction_pointer(regs),
> > -		.stack_pointer = user_stack_pointer(regs),
> > -	};
> > +	struct ptrace_syscall_info info;
> >  	unsigned long actual_size = offsetof(struct ptrace_syscall_info, entry);
> >  	unsigned long write_size;
> >  
> > +	memset(&info, 0, sizeof(info));
> > +
> > +	info.op	= PTRACE_SYSCALL_INFO_NONE;
> > +	info.arch = syscall_get_arch(child);
> > +	info.instruction_pointer = instruction_pointer(regs);
> > +	info.stack_pointer = user_stack_pointer(regs);
> > +
> 
> No, please don't do it this way.  If there is a hole in the structure that
> the compiler is unable to initialize properly (and there is a 3-byte hole
> in the beginning indeed), please plug the hole by turning it into
> something that the compiler is capable of initializing.

I see. I will do that and send a v2.

> Also, please do not forget to Cc authors of the commit you are fixing.

Sorry, I forgot about that. Thank you for pointing it out!

Peilin Ye
