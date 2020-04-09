Return-Path: <SRS0=n+Ub=5Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C558BC2BA2B
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 11:22:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A335120B1F
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 11:22:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726626AbgDILWa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Apr 2020 07:22:30 -0400
Received: from mx2.suse.de ([195.135.220.15]:33002 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725987AbgDILW3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Apr 2020 07:22:29 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 9634EAE24;
        Thu,  9 Apr 2020 11:22:27 +0000 (UTC)
Date:   Thu, 9 Apr 2020 13:22:26 +0200
From:   Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>
To:     Christophe Leroy <christophe.leroy@c-s.fr>
Cc:     linuxppc-dev@lists.ozlabs.org, Nicholas Piggin <npiggin@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] powerpcs: perf: consolidate perf_callchain_user_64 and
 perf_callchain_user_32
Message-ID: <20200409112226.GT25468@kitsune.suse.cz>
References: <1585896170.ohti800w9v.astroid@bobo.none>
 <20200406210022.32265-1-msuchanek@suse.de>
 <8786906b-edd5-e4a3-8286-33a05f39668c@c-s.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8786906b-edd5-e4a3-8286-33a05f39668c@c-s.fr>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 07, 2020 at 07:21:06AM +0200, Christophe Leroy wrote:
> 
> 
> Le 06/04/2020 à 23:00, Michal Suchanek a écrit :
> > perf_callchain_user_64 and perf_callchain_user_32 are nearly identical.
> > Consolidate into one function with thin wrappers.
> > 
> > Suggested-by: Nicholas Piggin <npiggin@gmail.com>
> > Signed-off-by: Michal Suchanek <msuchanek@suse.de>
> > ---
> >   arch/powerpc/perf/callchain.h    | 24 +++++++++++++++++++++++-
> >   arch/powerpc/perf/callchain_32.c | 21 ++-------------------
> >   arch/powerpc/perf/callchain_64.c | 14 ++++----------
> >   3 files changed, 29 insertions(+), 30 deletions(-)
> > 
> > diff --git a/arch/powerpc/perf/callchain.h b/arch/powerpc/perf/callchain.h
> > index 7a2cb9e1181a..7540bb71cb60 100644
> > --- a/arch/powerpc/perf/callchain.h
> > +++ b/arch/powerpc/perf/callchain.h
> > @@ -2,7 +2,7 @@
> >   #ifndef _POWERPC_PERF_CALLCHAIN_H
> >   #define _POWERPC_PERF_CALLCHAIN_H
> > -int read_user_stack_slow(void __user *ptr, void *buf, int nb);
> > +int read_user_stack_slow(const void __user *ptr, void *buf, int nb);
> 
> Does the constification of ptr has to be in this patch ?
It was in the original patch. The code is touched anyway.
> Wouldn't it be better to have it as a separate patch ?
Don't care much either way. Can resend it as separate patches.
> 
> >   void perf_callchain_user_64(struct perf_callchain_entry_ctx *entry,
> >   			    struct pt_regs *regs);
> >   void perf_callchain_user_32(struct perf_callchain_entry_ctx *entry,
> > @@ -16,4 +16,26 @@ static inline bool invalid_user_sp(unsigned long sp)
> >   	return (!sp || (sp & mask) || (sp > top));
> >   }
> > +/*
> > + * On 32-bit we just access the address and let hash_page create a
> > + * HPTE if necessary, so there is no need to fall back to reading
> > + * the page tables.  Since this is called at interrupt level,
> > + * do_page_fault() won't treat a DSI as a page fault.
> > + */
> > +static inline int __read_user_stack(const void __user *ptr, void *ret,
> > +				    size_t size)
> > +{
> > +	int rc;
> > +
> > +	if ((unsigned long)ptr > TASK_SIZE - size ||
> > +			((unsigned long)ptr & (size - 1)))
> > +		return -EFAULT;
> > +	rc = probe_user_read(ret, ptr, size);
> > +
> > +	if (rc && IS_ENABLED(CONFIG_PPC64))
> 
> gcc is probably smart enough to deal with it efficiently, but it would
> be more correct to test rc after checking CONFIG_PPC64.
IS_ENABLED(CONFIG_PPC64) is constant so that part of the check should be
compiled out in any case.

Thanks

Michal
