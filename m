Return-Path: <SRS0=+GcV=BG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26956C433EA
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 12:05:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 025A420663
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 12:05:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728292AbgG0MFb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jul 2020 08:05:31 -0400
Received: from foss.arm.com ([217.140.110.172]:42832 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727978AbgG0MFa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 08:05:30 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2DDB230E;
        Mon, 27 Jul 2020 05:05:30 -0700 (PDT)
Received: from e120877-lin.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 112FF3F66E;
        Mon, 27 Jul 2020 05:05:28 -0700 (PDT)
Date:   Mon, 27 Jul 2020 13:05:21 +0100
From:   Vincent Donnefort <vincent.donnefort@arm.com>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     mingo@redhat.com, peterz@infradead.org, vincent.guittot@linaro.org,
        linux-kernel@vger.kernel.org, dietmar.eggemann@arm.com,
        lukasz.luba@arm.com, valentin.schneider@arm.com
Subject: Re: [PATCH] sched/fair: provide u64 read for 32-bits arch helper
Message-ID: <20200727120520.GA257620@e120877-lin.cambridge.arm.com>
References: <1595847564-239957-1-git-send-email-vincent.donnefort@arm.com>
 <20200727112454.GB55660@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200727112454.GB55660@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Jul 27, 2020 at 01:24:54PM +0200, Ingo Molnar wrote:
> 
> * vincent.donnefort@arm.com <vincent.donnefort@arm.com> wrote:
> 
> > From: Vincent Donnefort <vincent.donnefort@arm.com>
> > 
> > Introducing two macro helpers u64_32read() and u64_32read_set_copy() to
> > factorize the u64 vminruntime and last_update_time read on a 32-bits
> > architecture. Those new helpers encapsulate smp_rmb() and smp_wmb()
> > synchronization and therefore, have a small penalty in set_task_rq_fair()
> > and init_cfs_rq().
> > 
> > The choice of using a macro over an inline function is driven by the
> > conditional u64 variable copy declarations.
> 
> Could you please explain how "conditional u64 variable copy 
> declarations" prevents us to use an inline function for this

I meant, as the "copy" variable [vminruntime|last_update_time]_copy, is
declared only in the !CONFIG_64BIT case, a function call would fail when
CONFIG_64BIT is set.

   u64_32read(cfs_rq->min_vruntime, cfs_rq->min_vruntime_copy); 
						^
					  not declared

I could rephrase this part to something more understandable ?

> 
> > +/*
> > + * u64_32read() / u64_32read_set_copy()
> > + *
> > + * Use the copied u64 value to protect against data race. This is only
> > + * applicable for 32-bits architectures.
> > + */
> > +#if !defined(CONFIG_64BIT) && defined(CONFIG_SMP)
> > +# define u64_32read(val, copy)						\
> > +({									\
> > +	u64 _val;							\
> > +	u64 _val_copy;							\
> > +									\
> > +	do {								\
> > +		_val_copy = copy;					\
> > +		/*							\
> > +		 * paired with u64_32read_set_copy, ordering access	\
> > +		 * to val and copy.					\
> > +		 */							\
> > +		smp_rmb();						\
> > +		_val = val;						\
> > +	} while (_val != _val_copy);					\
> > +									\
> > +	_val;								\
> > +})
> > +# define u64_32read_set_copy(val, copy)					\
> > +do {									\
> > +	/* paired with u64_32read, ordering access to val and copy */	\
> > +	smp_wmb();							\
> > +	copy = val;							\
> > +} while (0)
> > +#else
> > +# define u64_32read(val, copy) (val)
> > +# define u64_32read_set_copy(val, copy) do { } while (0)
> > +#endif
> > +
> 
> Thanks,
> 
> 	Ingo

-- 
Vincent
