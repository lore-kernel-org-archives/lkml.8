Return-Path: <SRS0=qsSF=76=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 983D6C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 17:36:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 79258212CC
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 17:36:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726912AbgFQRgX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jun 2020 13:36:23 -0400
Received: from ex13-edg-ou-001.vmware.com ([208.91.0.189]:30648 "EHLO
        EX13-EDG-OU-001.vmware.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726511AbgFQRgX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 13:36:23 -0400
Received: from sc9-mailhost3.vmware.com (10.113.161.73) by
 EX13-EDG-OU-001.vmware.com (10.113.208.155) with Microsoft SMTP Server id
 15.0.1156.6; Wed, 17 Jun 2020 10:36:18 -0700
Received: from localhost (unknown [10.200.193.92])
        by sc9-mailhost3.vmware.com (Postfix) with ESMTP id A5EDE4006D;
        Wed, 17 Jun 2020 10:36:20 -0700 (PDT)
Date:   Wed, 17 Jun 2020 10:36:20 -0700
From:   Matt Helsley <mhelsley@vmware.com>
To:     Peter Zijlstra <peterz@infradead.org>
CC:     <linux-kernel@vger.kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Julien Thierry <jthierry@redhat.com>,
        Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>
Subject: Re: [RFC][PATCH v4 18/32] objtool: mcount: Move nop_mcount()
Message-ID: <20200617173620.GA89648@rlwimi.vmware.com>
Mail-Followup-To: Matt Helsley <mhelsley@vmware.com>,
        Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Julien Thierry <jthierry@redhat.com>,
        Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>
References: <cover.1591125127.git.mhelsley@vmware.com>
 <7109ceb239a88c2901eeb7f52c29f69cdb413cd3.1591125127.git.mhelsley@vmware.com>
 <20200612132656.GQ2531@hirez.programming.kicks-ass.net>
 <20200612160534.GD2554@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20200612160534.GD2554@hirez.programming.kicks-ass.net>
Received-SPF: None (EX13-EDG-OU-001.vmware.com: mhelsley@vmware.com does not
 designate permitted sender hosts)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 12, 2020 at 06:05:34PM +0200, Peter Zijlstra wrote:
> On Fri, Jun 12, 2020 at 03:26:57PM +0200, Peter Zijlstra wrote:
> > On Tue, Jun 02, 2020 at 12:50:11PM -0700, Matt Helsley wrote:
> > > +static int nop_mcount(struct section * const rels,
> > > +		      const char *const txtname)
> > > +{
> > > +	struct reloc *reloc;
> > > +	struct section *txts = find_section_by_index(lf, rels->sh.sh_info);
> > > +	unsigned mcountsym = 0;
> > > +	int once = 0;
> > > +
> > > +	list_for_each_entry(reloc, &rels->reloc_list, list) {
> > > +		int ret = -1;
> > > +
> > > +		if (!mcountsym)
> > > +			mcountsym = get_mcountsym(reloc);
> > > +
> > > +		if (mcountsym == GELF_R_INFO(reloc->sym->idx, reloc->type) && !is_fake_mcount(reloc)) {
> > 
> > This makes no sense to me; why not have mcountsym be a 'struct symbol
> > *' and have get_mcountsym() return one of those.
> > 
> > 	if (reloc->sym == mcountsym && ... )
> > 
> > is much nicer, no?

(this is already incorporated in my unposted revisions but...)

> 
> On top of that, I suppose we can do something like the below.
> 
> Then you can simply write:
> 
> 	if (reloc->sym->class == SYM_MCOUNT && ..)

This looks like a good way to move towards a "single pass" through the ELF data
for mcount.

What order do you want to see this patch go in? Before this series (i.e. perhaps
just a kcov SYM_ class to start)? Early or late in this series? After?

Right now I'm thinking of putting this on the end of my series because
I'm focusing on converting recordmcount in the series and this isn't
strictly necessary but is definitely nicer.

> 
> ---
> 
> diff --git a/kernel/locking/Makefile b/kernel/locking/Makefile
> index 45452facff3b..94e4b8fcf9c1 100644
> --- a/kernel/locking/Makefile
> +++ b/kernel/locking/Makefile
> @@ -1,7 +1,7 @@
>  # SPDX-License-Identifier: GPL-2.0
>  # Any varying coverage in these files is non-deterministic
>  # and is generally not a function of system call inputs.
> -KCOV_INSTRUMENT		:= n
> +# KCOV_INSTRUMENT		:= n
>  
>  obj-y += mutex.o semaphore.o rwsem.o percpu-rwsem.o
>  
> diff --git a/tools/objtool/elf.c b/tools/objtool/elf.c
> index 432417a83902..133c0c285be6 100644
> --- a/tools/objtool/elf.c
> +++ b/tools/objtool/elf.c
> @@ -341,6 +341,24 @@ static int read_sections(struct elf *elf)
>  	return 0;
>  }
>  
> +static bool is_mcount_symbol(const char *name)
> +{
> +	if (name[0] == '.')
> +		name++;
> +
> +	if (name[0] == '_')
> +		name++;
> +
> +	return !strcmp(name, "mcount", 6) ||

Looks like you intended this to be a strncmp() but I don't see a reason to
use strncmp(). Am I missing something?

> +	       !strcmp(name, "_fentry__") ||
> +	       !strcmp(name, "_gnu_mcount_nc");
> +}

This mashes all of the arch-specific mcount name checks together. I
don't see a problem with that because I doubt there will be a collision
with other functions. Just to be careful I looked through the Clang and
GCC sources, though I only dug through the history of Clang's output --
GCC's history with respect to mcount symbol names across architectures is
much harder to trace so I only looked at the current sources.

<snip> (the rest looks good)

Cheers,
    -Matt Helsley
