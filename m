Return-Path: <SRS0=qsSF=76=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4458FC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 06:54:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1F8E8208C3
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 06:54:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592376896;
	bh=Q+i1liwJyGwsrJ2eZGcJyopPeA/WKtoMmwsV0guZ5Vk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=2q9pvHq4YL+j2KLhCyBxXU/CoznibDCrGaNCi7ISEw5zbpkABZ914lPdlnYRkvNNh
	 kyDxPS4CDdwKhY1wf2jkOcv0uB7dYUzkD/jlTYBge5JLVAXhZ3ucPnrz0NHe98Kw23
	 roceQJR5NzxGkjWdNQzPH05FSXUN1h6z66M/y5ao=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726541AbgFQGyy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jun 2020 02:54:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:54164 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725554AbgFQGyx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 02:54:53 -0400
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5BDB52080D;
        Wed, 17 Jun 2020 06:54:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592376892;
        bh=Q+i1liwJyGwsrJ2eZGcJyopPeA/WKtoMmwsV0guZ5Vk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=h3vQE7ED+NmicrWYNJ2GGVekPeVM27s+Ue5MeVmVowIspYddvu9hxfwgV9nRVXwq+
         CirT9FkG/gIJXURFJm8AtNidfPKLepV5v/XFfCGCPCVrV+GJ98rsqe5RiOm4nYwP3f
         ivyALTaiyDqnAlK+krOmVfn3ufhQuTkWeKgtjzgQ=
Received: by mail-lj1-f173.google.com with SMTP id z9so1454325ljh.13;
        Tue, 16 Jun 2020 23:54:52 -0700 (PDT)
X-Gm-Message-State: AOAM533/Wer+/eIKkhLZoG8onOqyWjboY5VNjkb43Rmt+8c3koTsij86
        6a0cnbuU/SFH1S+PYdAiLUIZMlV1zrlRkqbSN1g=
X-Google-Smtp-Source: ABdhPJyO11FSqisTPkeFyw40gIqgChMNuMwv2aIbCIUMR6SwMn35EL9cz/68sHFvFGRUk6vQVXTDw92d3VCfbRv2g9Y=
X-Received: by 2002:a2e:7105:: with SMTP id m5mr2986615ljc.79.1592376890702;
 Tue, 16 Jun 2020 23:54:50 -0700 (PDT)
MIME-Version: 1.0
References: <20200610153935.13794-1-tklauser@distanz.ch> <CAJF2gTRGVQcn5Hu+kaHfzhEpyXuMkQQYyfHkuxREYci4QJ0SoQ@mail.gmail.com>
 <20200615084314.rwabrkyy7wwgwdxc@distanz.ch>
In-Reply-To: <20200615084314.rwabrkyy7wwgwdxc@distanz.ch>
From:   Guo Ren <guoren@kernel.org>
Date:   Wed, 17 Jun 2020 14:54:39 +0800
X-Gmail-Original-Message-ID: <CAJF2gTQ63LkMOOJFrFuv2iZOyRxwz07SPyOk7ywocjsaDOKPsA@mail.gmail.com>
Message-ID: <CAJF2gTQ63LkMOOJFrFuv2iZOyRxwz07SPyOk7ywocjsaDOKPsA@mail.gmail.com>
Subject: Re: [PATCH] csky: remove unusued thread_saved_pc and *_segments functions/macros
To:     Tobias Klauser <tklauser@distanz.ch>
Cc:     Mao Han <han_mao@c-sky.com>, linux-csky@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I can do it.

On Mon, Jun 15, 2020 at 4:43 PM Tobias Klauser <tklauser@distanz.ch> wrote:
>
> On 2020-06-13 at 10:42:07 +0200, Guo Ren <guoren@kernel.org> wrote:
> > Acked-by: Guo Ren <guoren@kernel.org>
>
> Thanks for the Ack. Are you taking this patch through your own tree or
> should I directly submit to someone else?
>
> > On Wed, Jun 10, 2020 at 11:45 PM Tobias Klauser <tklauser@distanz.ch> wrote:
> > >
> > > These are used nowhere in the tree (except for some architectures which
> > > define them for their own use) and were already removed for other
> > > architectures in:
> > >
> > > commit 6474924e2b5d ("arch: remove unused macro/function thread_saved_pc()")
> > > commit c17c02040bf0 ("arch: remove unused *_segments() macros/functions")
> > >
> > > Remove them from arch/csky as well.
> > >
> > > Signed-off-by: Tobias Klauser <tklauser@distanz.ch>
> > > ---
> > >  arch/csky/include/asm/processor.h |  6 ------
> > >  arch/csky/kernel/process.c        | 10 ----------
> > >  2 files changed, 16 deletions(-)
> > >
> > > diff --git a/arch/csky/include/asm/processor.h b/arch/csky/include/asm/processor.h
> > > index 24442d8e86f9..4800f6563abb 100644
> > > --- a/arch/csky/include/asm/processor.h
> > > +++ b/arch/csky/include/asm/processor.h
> > > @@ -82,12 +82,6 @@ static inline void release_thread(struct task_struct *dead_task)
> > >
> > >  extern int kernel_thread(int (*fn)(void *), void *arg, unsigned long flags);
> > >
> > > -#define copy_segments(tsk, mm)         do { } while (0)
> > > -#define release_segments(mm)           do { } while (0)
> > > -#define forget_segments()              do { } while (0)
> > > -
> > > -extern unsigned long thread_saved_pc(struct task_struct *tsk);
> > > -
> > >  unsigned long get_wchan(struct task_struct *p);
> > >
> > >  #define KSTK_EIP(tsk)          (task_pt_regs(tsk)->pc)
> > > diff --git a/arch/csky/kernel/process.c b/arch/csky/kernel/process.c
> > > index 8b3fad062ab2..3da63cf0bfde 100644
> > > --- a/arch/csky/kernel/process.c
> > > +++ b/arch/csky/kernel/process.c
> > > @@ -30,16 +30,6 @@ asmlinkage void ret_from_kernel_thread(void);
> > >   */
> > >  void flush_thread(void){}
> > >
> > > -/*
> > > - * Return saved PC from a blocked thread
> > > - */
> > > -unsigned long thread_saved_pc(struct task_struct *tsk)
> > > -{
> > > -       struct switch_stack *sw = (struct switch_stack *)tsk->thread.sp;
> > > -
> > > -       return sw->r15;
> > > -}
> > > -
> > >  int copy_thread_tls(unsigned long clone_flags,
> > >                 unsigned long usp,
> > >                 unsigned long kthread_arg,
> > > --
> > > 2.27.0
> > >
> >
> >
> > --
> > Best Regards
> >  Guo Ren
> >
> > ML: https://lore.kernel.org/linux-csky/
> >



-- 
Best Regards
 Guo Ren

ML: https://lore.kernel.org/linux-csky/
