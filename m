Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CFF3C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 08:40:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5AE4120720
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 08:40:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731867AbgFWIkq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 04:40:46 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:41656 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731744AbgFWIkp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 04:40:45 -0400
Received: from ip5f5af08c.dynamic.kabel-deutschland.de ([95.90.240.140] helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1jneTt-00035w-7Y; Tue, 23 Jun 2020 08:40:37 +0000
Date:   Tue, 23 Jun 2020 10:40:36 +0200
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Andrei Vagin <avagin@gmail.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Dmitry Safonov <dima@arista.com>
Subject: Re: [PATCH 2/6] arm64/vdso: Zap vvar pages when switching to a time
 namespace
Message-ID: <20200623084036.enigighejqw2vdkt@wittgenstein>
References: <20200616075545.312684-1-avagin@gmail.com>
 <20200616075545.312684-3-avagin@gmail.com>
 <20200619153812.2d6anaynb4p37qv2@wittgenstein>
 <20200623073305.GA23557@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200623073305.GA23557@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 23, 2020 at 12:33:05AM -0700, Andrei Vagin wrote:
> On Fri, Jun 19, 2020 at 05:38:12PM +0200, Christian Brauner wrote:
> > On Tue, Jun 16, 2020 at 12:55:41AM -0700, Andrei Vagin wrote:
> > > The VVAR page layout depends on whether a task belongs to the root or
> > > non-root time namespace. Whenever a task changes its namespace, the VVAR
> > > page tables are cleared and then they will be re-faulted with a
> > > corresponding layout.
> > > 
> > > Reviewed-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
> > > Reviewed-by: Dmitry Safonov <dima@arista.com>
> > > Signed-off-by: Andrei Vagin <avagin@gmail.com>
> > > ---
> > >  arch/arm64/kernel/vdso.c | 32 ++++++++++++++++++++++++++++++++
> > >  1 file changed, 32 insertions(+)
> > > 
> > > diff --git a/arch/arm64/kernel/vdso.c b/arch/arm64/kernel/vdso.c
> > > index b0aec4e8c9b4..df4bb736d28a 100644
> > > --- a/arch/arm64/kernel/vdso.c
> > > +++ b/arch/arm64/kernel/vdso.c
> > > @@ -125,6 +125,38 @@ static int __vdso_init(enum vdso_abi abi)
> > >  	return 0;
> > >  }
> > >  
> > > +#ifdef CONFIG_TIME_NS
> > > +/*
> > > + * The vvar page layout depends on whether a task belongs to the root or
> > > + * non-root time namespace. Whenever a task changes its namespace, the VVAR
> > > + * page tables are cleared and then they will re-faulted with a
> > > + * corresponding layout.
> > > + * See also the comment near timens_setup_vdso_data() for details.
> > > + */
> > > +int vdso_join_timens(struct task_struct *task, struct time_namespace *ns)
> > > +{
> > > +	struct mm_struct *mm = task->mm;
> > > +	struct vm_area_struct *vma;
> > > +
> > > +	if (mmap_write_lock_killable(mm))
> > > +		return -EINTR;
> > 
> > Hey,
> > 
> > Just a heads-up I'm about to plumb CLONE_NEWTIME support into setns()
> 
> Hmm. I am not sure that I unserstand what you mean. I think setns(nsfd,
> CLONE_NEWTIME) works now. For example, we use it in
> tools/testing/selftests/timens/timens.c. Do you mean setns(pidfd,
> CLONE_NEWTIME | CLONE_something)?

Indeed, I'm talking about setns(pidfd, CLONE_NEWUSER | CLONE_NEWNS |
CLONE_NEWTIME). But also in general, the setns infrastructure has been
reworked and ideally all namespaces only perform permissions checks and
install the namespace into the passed in new struct nsset (which was
introduced this cycle) in their install handler (e.g. timens_install())
and don't make any task-visible changes yet but instead provide an
install routine that does not fail which is then called from 
static void commit_nsset(struct nsset *nsset)
in kernel/nsproxy.c.

> 
> > which would mean that vdso_join_timens() ould not be allowed to fail
> > anymore to make it easy to switch to multiple namespaces atomically. So
> > this would probably need to be changed to mmap_write_lock() which I've
> > already brought up upstream:
> > https://lore.kernel.org/lkml/20200611110221.pgd3r5qkjrjmfqa2@wittgenstein/
> > (Assuming that people agree. I just sent the series and most people here
> > are Cced.)
> > 
> > Thanks!
> > Christian
