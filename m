Return-Path: <SRS0=PJcK=74=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA367C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 08:43:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A9AB72067B
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 08:43:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729310AbgFOInZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jun 2020 04:43:25 -0400
Received: from sym2.noone.org ([178.63.92.236]:60434 "EHLO sym2.noone.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728852AbgFOInW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 04:43:22 -0400
Received: by sym2.noone.org (Postfix, from userid 1002)
        id 49llGX11CLzvjc1; Mon, 15 Jun 2020 10:43:15 +0200 (CEST)
Date:   Mon, 15 Jun 2020 10:43:15 +0200
From:   Tobias Klauser <tklauser@distanz.ch>
To:     Guo Ren <guoren@kernel.org>
Cc:     Mao Han <han_mao@c-sky.com>, linux-csky@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] csky: remove unusued thread_saved_pc and *_segments
 functions/macros
Message-ID: <20200615084314.rwabrkyy7wwgwdxc@distanz.ch>
References: <20200610153935.13794-1-tklauser@distanz.ch>
 <CAJF2gTRGVQcn5Hu+kaHfzhEpyXuMkQQYyfHkuxREYci4QJ0SoQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJF2gTRGVQcn5Hu+kaHfzhEpyXuMkQQYyfHkuxREYci4QJ0SoQ@mail.gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-06-13 at 10:42:07 +0200, Guo Ren <guoren@kernel.org> wrote:
> Acked-by: Guo Ren <guoren@kernel.org>

Thanks for the Ack. Are you taking this patch through your own tree or
should I directly submit to someone else?

> On Wed, Jun 10, 2020 at 11:45 PM Tobias Klauser <tklauser@distanz.ch> wrote:
> >
> > These are used nowhere in the tree (except for some architectures which
> > define them for their own use) and were already removed for other
> > architectures in:
> >
> > commit 6474924e2b5d ("arch: remove unused macro/function thread_saved_pc()")
> > commit c17c02040bf0 ("arch: remove unused *_segments() macros/functions")
> >
> > Remove them from arch/csky as well.
> >
> > Signed-off-by: Tobias Klauser <tklauser@distanz.ch>
> > ---
> >  arch/csky/include/asm/processor.h |  6 ------
> >  arch/csky/kernel/process.c        | 10 ----------
> >  2 files changed, 16 deletions(-)
> >
> > diff --git a/arch/csky/include/asm/processor.h b/arch/csky/include/asm/processor.h
> > index 24442d8e86f9..4800f6563abb 100644
> > --- a/arch/csky/include/asm/processor.h
> > +++ b/arch/csky/include/asm/processor.h
> > @@ -82,12 +82,6 @@ static inline void release_thread(struct task_struct *dead_task)
> >
> >  extern int kernel_thread(int (*fn)(void *), void *arg, unsigned long flags);
> >
> > -#define copy_segments(tsk, mm)         do { } while (0)
> > -#define release_segments(mm)           do { } while (0)
> > -#define forget_segments()              do { } while (0)
> > -
> > -extern unsigned long thread_saved_pc(struct task_struct *tsk);
> > -
> >  unsigned long get_wchan(struct task_struct *p);
> >
> >  #define KSTK_EIP(tsk)          (task_pt_regs(tsk)->pc)
> > diff --git a/arch/csky/kernel/process.c b/arch/csky/kernel/process.c
> > index 8b3fad062ab2..3da63cf0bfde 100644
> > --- a/arch/csky/kernel/process.c
> > +++ b/arch/csky/kernel/process.c
> > @@ -30,16 +30,6 @@ asmlinkage void ret_from_kernel_thread(void);
> >   */
> >  void flush_thread(void){}
> >
> > -/*
> > - * Return saved PC from a blocked thread
> > - */
> > -unsigned long thread_saved_pc(struct task_struct *tsk)
> > -{
> > -       struct switch_stack *sw = (struct switch_stack *)tsk->thread.sp;
> > -
> > -       return sw->r15;
> > -}
> > -
> >  int copy_thread_tls(unsigned long clone_flags,
> >                 unsigned long usp,
> >                 unsigned long kthread_arg,
> > --
> > 2.27.0
> >
> 
> 
> -- 
> Best Regards
>  Guo Ren
> 
> ML: https://lore.kernel.org/linux-csky/
> 
