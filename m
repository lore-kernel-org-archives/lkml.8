Return-Path: <SRS0=g10L=63=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9168DC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 16:26:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D59262054F
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 16:26:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389618AbgEMQ0t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 May 2020 12:26:49 -0400
Received: from ex13-edg-ou-002.vmware.com ([208.91.0.190]:9840 "EHLO
        EX13-EDG-OU-002.vmware.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730831AbgEMQ0t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 May 2020 12:26:49 -0400
Received: from sc9-mailhost3.vmware.com (10.113.161.73) by
 EX13-EDG-OU-002.vmware.com (10.113.208.156) with Microsoft SMTP Server id
 15.0.1156.6; Wed, 13 May 2020 09:26:46 -0700
Received: from localhost (unknown [10.166.66.23])
        by sc9-mailhost3.vmware.com (Postfix) with ESMTP id DC08740E40;
        Wed, 13 May 2020 09:26:48 -0700 (PDT)
Date:   Wed, 13 May 2020 09:26:48 -0700
From:   Matt Helsley <mhelsley@vmware.com>
To:     Julien Thierry <jthierry@redhat.com>
CC:     <linux-kernel@vger.kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Miroslav Benes <mbenes@suse.cz>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [RFC][PATCH 3/5] objtool: Add support for relocations without
 addends
Message-ID: <20200513162648.GJ9040@rlwimi.vmware.com>
Mail-Followup-To: Matt Helsley <mhelsley@vmware.com>,
        Julien Thierry <jthierry@redhat.com>, linux-kernel@vger.kernel.org,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Miroslav Benes <mbenes@suse.cz>,
        Steven Rostedt <rostedt@goodmis.org>
References: <cover.1588888003.git.mhelsley@vmware.com>
 <17ee3f6f2a246008aaae70f92df24ae92fa0e21e.1588888003.git.mhelsley@vmware.com>
 <f79a3872-b9ad-a966-71fb-4451e0901281@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <f79a3872-b9ad-a966-71fb-4451e0901281@redhat.com>
Received-SPF: None (EX13-EDG-OU-002.vmware.com: mhelsley@vmware.com does not
 designate permitted sender hosts)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 12, 2020 at 06:04:50PM +0100, Julien Thierry wrote:
> Hi Matt,
> 
> On 5/11/20 6:35 PM, Matt Helsley wrote:
> > Currently objtool only collects information about relocations with
> > addends. In recordmcount, which we are about to merge into objtool,
> > some supported architectures do not use rela relocations. Since
> > object files use one or the other the list can be reused.
> > 
> > Signed-off-by: Matt Helsley <mhelsley@vmware.com>
> > ---
> >   tools/objtool/elf.c | 55 ++++++++++++++++++++++++++++++++++++---------
> >   tools/objtool/elf.h |  5 ++++-
> >   2 files changed, 49 insertions(+), 11 deletions(-)
> > 
> > diff --git a/tools/objtool/elf.c b/tools/objtool/elf.c
> > index c4857fa3f1d1..cd841e3df87d 100644
> > --- a/tools/objtool/elf.c
> > +++ b/tools/objtool/elf.c
> > @@ -465,12 +465,14 @@ static int read_relas(struct elf *elf)
> >   	unsigned long nr_rela, max_rela = 0, tot_rela = 0;
> >   	list_for_each_entry(sec, &elf->sections, list) {
> > -		if (sec->sh.sh_type != SHT_RELA)
> > +		if ((sec->sh.sh_type != SHT_RELA) &&
> > +		     (sec->sh.sh_type != SHT_REL))
> >   			continue;
> > -		sec->base = find_section_by_name(elf, sec->name + 5);
> > +		sec->base = find_section_by_name(elf, sec->name +
> > +				((sec->sh.sh_type != SHT_REL) ? 5 : 4));
> >   		if (!sec->base) {
> > -			WARN("can't find base section for rela section %s",
> > +			WARN("can't find base section for relocation section %s",
> >   			     sec->name);
> >   			return -1;
> >   		}
> > @@ -486,13 +488,26 @@ static int read_relas(struct elf *elf)
> >   			}
> >   			memset(rela, 0, sizeof(*rela));
> > -			if (!gelf_getrela(sec->data, i, &rela->rela)) {
> > -				WARN_ELF("gelf_getrela");
> > -				return -1;
> > +			switch(sec->sh.sh_type) {
> > +			case SHT_REL:
> > +				if (!gelf_getrel(sec->data, i, &rela->rel)) {
> > +					WARN_ELF("gelf_getrel");
> > +					return -1;
> > +				}
> > +				rela->addend = 0;
> > +				break;
> > +			case SHT_RELA:
> > +				if (!gelf_getrela(sec->data, i, &rela->rela)) {
> > +					WARN_ELF("gelf_getrela");
> > +					return -1;
> > +				}
> > +				rela->addend = rela->rela.r_addend;
> > +				break;
> > +			default:
> > +				break;
> >   			}
> >   			rela->type = GELF_R_TYPE(rela->rela.r_info);
> > -			rela->addend = rela->rela.r_addend;
> >   			rela->offset = rela->rela.r_offset;
> >   			symndx = GELF_R_SYM(rela->rela.r_info);
> >   			rela->sym = find_symbol_by_index(elf, symndx);
> > @@ -717,17 +732,27 @@ int elf_rebuild_rela_section(struct section *sec)
> >   	struct rela *rela;
> >   	int nr, idx = 0, size;
> >   	GElf_Rela *relas;
> > +	GElf_Rel *rels;
> >   	nr = 0;
> >   	list_for_each_entry(rela, &sec->rela_list, list)
> >   		nr++;
> > +	/*
> > +	 * Allocate a buffer for relocations with addends but also use
> > +	 * it for other relocations too. The section type determines
> > +	 * the size of the section, the buffer used, and the entries.
> > +	 */
> >   	size = nr * sizeof(*relas);
> >   	relas = malloc(size);
> >   	if (!relas) {
> >   		perror("malloc");
> >   		return -1;
> >   	}
> > +	rels = (void *)relas;
> > +	if (sec->sh.sh_type == SHT_REL) {
> > +		size = nr * sizeof(*rels);
> > +	}
> 
> This looks a bit error prone to me.
> 
> What about having:
> 
>     void *rel_buf;
>     [...]
>     size = nr * (sec->sh.sh_type == SHT_REL ? sizeof(GElf_Rel) :
> sizeof(GElf_Rela));

I like reducing to a single size expression but I'm not a fan of hard-coding
the GElf_Rel[a] types here -- I prefer sizeof(*relas) and sizeof(*rels)
since that makes it clear the sizes will match the types of the pointers
that will be used to access them. So I've changed it to:

	size = nr * ((sec->sh.sh_type == SHT_REL) ? sizeof(*rels) : sizeof(*relas));

>     rel_buf = malloc(size);
>     [...]
> 
> And then casting rel_buf to the correct pointer type in the fitting switch
> cases?

I'm thinking it's simpler with fewer variables. I don't think
moving the cast into the switch cases makes it any clearer. It's also
odd because we'll keep re-initializing relas or rels to rel_buf each loop
iteration. Finally, this approach has the advantage that, when reviewing
the patch, it's clear that the original code handling RELA relocation entries
isn't changing -- you can see it's just shifting into one of the cases
(below).

Do you still prefer introducing rel_buf?

> 
> >   	sec->data->d_buf = relas;
> >   	sec->data->d_size = size;
> > @@ -736,9 +761,19 @@ int elf_rebuild_rela_section(struct section *sec)
> >   	idx = 0;
> >   	list_for_each_entry(rela, &sec->rela_list, list) {
> > -		relas[idx].r_offset = rela->offset;
> > -		relas[idx].r_addend = rela->addend;
> > -		relas[idx].r_info = GELF_R_INFO(rela->sym->idx, rela->type);
> > +		switch(sec->sh.sh_type) {
> > +		case SHT_REL:
> > +			rels[idx].r_offset = rela->offset;
> > +			rels[idx].r_info = GELF_R_INFO(rela->sym->idx, rela->type);
> > +			break;
> > +		case SHT_RELA:
> > +			relas[idx].r_addend = rela->addend;
> > +			relas[idx].r_offset = rela->offset;
> > +			relas[idx].r_info = GELF_R_INFO(rela->sym->idx, rela->type);
> > +			break;
> > +		default:
> > +			break;
> > +		}
> >   		idx++;
> >   	}

Cheers,
     -Matt Helsley
