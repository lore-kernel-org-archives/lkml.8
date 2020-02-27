Return-Path: <SRS0=BMk7=4P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C1E4C4BA24
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 13:16:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 413902469F
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 13:16:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZT/8Y8Pk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729154AbgB0NQZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 08:16:25 -0500
Received: from mail-pj1-f66.google.com ([209.85.216.66]:53598 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729080AbgB0NQY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 08:16:24 -0500
Received: by mail-pj1-f66.google.com with SMTP id n96so1129572pjc.3
        for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2020 05:16:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=NF9T8IeFNBwXfV4fQWs170IOL2X98pDMbcHSLSgXH20=;
        b=ZT/8Y8PkFGeau+lVJL+67Aqls/Ql90yHrcfGQoye6rNnhOFAxb+bMTM598j35r2fZ1
         y2OrA1o5B5oH7WDXsJVRT1zNYfNZeeGno7BwRODYlTlJurVeCFCuajtKuS1+lzLO7Dd2
         NlaDs/29xH4NRk6/XanKad0bU1Vs73PUsAOmIQQvUIAx0e6TNjTnCyuei9P4qxfItvBr
         AQfgVtO0cSh4IqjXOGio7YPmRHmXSpRo373jQ7jk1uqmxpDdLFFRpjpBq86nUeUhAoYN
         h9Hzjyizzzsthh8ktb21z0dr4lr+Atp8vKncmDdBX3Xe0/YDWtoua36QcEvMY0jL47/3
         EBMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=NF9T8IeFNBwXfV4fQWs170IOL2X98pDMbcHSLSgXH20=;
        b=FyD6uqdpqfWOvWQfcI3tg63Hc1XhUkb7RRCUneOrLxUl1byid4blrUvJxglTOBYiCI
         bal2drdmdlpg/Y0raZQr2B3ehTmfCTLnbXOZrbRCX6VRhQ6BXVP6bnyjqjIAeD+aNm0Y
         G7s7wmIrZg3uWxTS4MLnv/8QxwsIj7xBfeu9rMNYJQqlaXtIWxSpJG0qLaM0lkWJkTs/
         Nyf00qi3wuZ9Tcty1yweqAXKTHPIeCrHOKuet7Zp3fnb77mFhSyjfL9HcmKh6nIh6tFv
         zxCxF+uyEqrUg3ItjfUQ54ebeWf3QU2FiFqcPc8tB5lnZ37zBVDSHZsgPB3jS3a0NlcB
         xa7w==
X-Gm-Message-State: APjAAAXToNsd7U2+RgO0OmiPPiWeqGTf7rFQJPErpUZhc+C+yShuxKcp
        u8Y9gulgl63TxcHoHhxhh5A=
X-Google-Smtp-Source: APXvYqwqpd6DvEp/v1FvwdsoRPvv73ubByBVSD4mvHFcF6+1p2pSRRrgM9Yq6fUjhQhyD4/3iqfO0w==
X-Received: by 2002:a17:90a:c691:: with SMTP id n17mr4865839pjt.41.1582809383686;
        Thu, 27 Feb 2020 05:16:23 -0800 (PST)
Received: from localhost (g183.222-224-185.ppp.wakwak.ne.jp. [222.224.185.183])
        by smtp.gmail.com with ESMTPSA id 72sm7365104pfw.7.2020.02.27.05.16.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2020 05:16:22 -0800 (PST)
Date:   Thu, 27 Feb 2020 22:16:20 +0900
From:   Stafford Horne <shorne@gmail.com>
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Openrisc <openrisc@lists.librecores.org>,
        Jonas Bonn <jonas@southpole.se>,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        Christian Brauner <christian@brauner.io>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Allison Randal <allison@lohutok.net>
Subject: Re: [PATCH 1/3] openrisc: Convert copy_thread to copy_thread_tls
Message-ID: <20200227131620.GG7926@lianli.shorne-pla.net>
References: <20200226225625.28935-1-shorne@gmail.com>
 <20200226225625.28935-2-shorne@gmail.com>
 <20200227121952.hywkuydswvdn3myc@wittgenstein>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200227121952.hywkuydswvdn3myc@wittgenstein>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 27, 2020 at 01:19:52PM +0100, Christian Brauner wrote:
> On Thu, Feb 27, 2020 at 07:56:23AM +0900, Stafford Horne wrote:
> > This is required for clone3 which passes the TLS value through a
> > struct rather than a register.
> > 
> > Signed-off-by: Stafford Horne <shorne@gmail.com>
> > ---
> >  arch/openrisc/Kconfig          |  1 +
> >  arch/openrisc/kernel/process.c | 15 +++++----------
> >  2 files changed, 6 insertions(+), 10 deletions(-)
> > 
> > diff --git a/arch/openrisc/Kconfig b/arch/openrisc/Kconfig
> > index 1928e061ff96..5debdbe6fc35 100644
> > --- a/arch/openrisc/Kconfig
> > +++ b/arch/openrisc/Kconfig
> > @@ -14,6 +14,7 @@ config OPENRISC
> >  	select HANDLE_DOMAIN_IRQ
> >  	select GPIOLIB
> >  	select HAVE_ARCH_TRACEHOOK
> > +	select HAVE_COPY_THREAD_TLS
> >  	select SPARSE_IRQ
> >  	select GENERIC_IRQ_CHIP
> >  	select GENERIC_IRQ_PROBE
> > diff --git a/arch/openrisc/kernel/process.c b/arch/openrisc/kernel/process.c
> > index b06f84f6676f..6695f167e126 100644
> > --- a/arch/openrisc/kernel/process.c
> > +++ b/arch/openrisc/kernel/process.c
> > @@ -117,12 +117,13 @@ void release_thread(struct task_struct *dead_task)
> >  extern asmlinkage void ret_from_fork(void);
> >  
> >  /*
> > - * copy_thread
> > + * copy_thread_tls
> >   * @clone_flags: flags
> >   * @usp: user stack pointer or fn for kernel thread
> >   * @arg: arg to fn for kernel thread; always NULL for userspace thread
> >   * @p: the newly created task
> >   * @regs: CPU context to copy for userspace thread; always NULL for kthread
> > + * @tls: the Thread Local Storate pointer for the new process
> >   *
> >   * At the top of a newly initialized kernel stack are two stacked pt_reg
> >   * structures.  The first (topmost) is the userspace context of the thread.
> > @@ -148,8 +149,8 @@ extern asmlinkage void ret_from_fork(void);
> >   */
> >  
> >  int
> > -copy_thread(unsigned long clone_flags, unsigned long usp,
> > -	    unsigned long arg, struct task_struct *p)
> > +copy_thread_tls(unsigned long clone_flags, unsigned long usp,
> > +		unsigned long arg, struct task_struct *p, unsigned long tls)
> >  {
> >  	struct pt_regs *userregs;
> >  	struct pt_regs *kregs;
> > @@ -180,15 +181,9 @@ copy_thread(unsigned long clone_flags, unsigned long usp,
> >  
> >  		/*
> >  		 * For CLONE_SETTLS set "tp" (r10) to the TLS pointer passed to sys_clone.
> 
> Maybe reword this to:
> 
> For CLONE_SETTLS set "tp" (r10) to the TLS pointer. We probably
> shouldn't mention clone() explicitly anymore, since we now have
> clone3() and therefore two callers that pass in tls arguments.

Sure, I updated it in the 'docs' commit, but as you mention I can just remove
the mention of clone* all together.  I will just remove that here and it won't
have to be touched in the 'docs' commit.
