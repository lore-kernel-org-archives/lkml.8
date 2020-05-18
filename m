Return-Path: <SRS0=RE5T=7A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F1D7C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 19:14:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E636D2081A
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 19:14:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727034AbgERTOd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 May 2020 15:14:33 -0400
Received: from ex13-edg-ou-001.vmware.com ([208.91.0.189]:43503 "EHLO
        EX13-EDG-OU-001.vmware.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726640AbgERTOc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 15:14:32 -0400
Received: from sc9-mailhost3.vmware.com (10.113.161.73) by
 EX13-EDG-OU-001.vmware.com (10.113.208.155) with Microsoft SMTP Server id
 15.0.1156.6; Mon, 18 May 2020 12:14:31 -0700
Received: from localhost (unknown [10.200.192.41])
        by sc9-mailhost3.vmware.com (Postfix) with ESMTP id 4946440BF5;
        Mon, 18 May 2020 12:14:32 -0700 (PDT)
Date:   Mon, 18 May 2020 12:14:31 -0700
From:   Matt Helsley <mhelsley@vmware.com>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
CC:     <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Julien Thierry <jthierry@redhat.com>,
        Miroslav Benes <mbenes@suse.cz>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [RFC][PATCH 3/5] objtool: Add support for relocations without
 addends
Message-ID: <20200518191431.GO9040@rlwimi.vmware.com>
Mail-Followup-To: Matt Helsley <mhelsley@vmware.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>, linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Julien Thierry <jthierry@redhat.com>,
        Miroslav Benes <mbenes@suse.cz>,
        Steven Rostedt <rostedt@goodmis.org>
References: <cover.1588888003.git.mhelsley@vmware.com>
 <17ee3f6f2a246008aaae70f92df24ae92fa0e21e.1588888003.git.mhelsley@vmware.com>
 <20200515203338.ehdgnvh7nqcczj4t@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20200515203338.ehdgnvh7nqcczj4t@treble>
Received-SPF: None (EX13-EDG-OU-001.vmware.com: mhelsley@vmware.com does not
 designate permitted sender hosts)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 15, 2020 at 03:33:38PM -0500, Josh Poimboeuf wrote:
> On Mon, May 11, 2020 at 10:35:11AM -0700, Matt Helsley wrote:
> > Currently objtool only collects information about relocations with
> > addends. In recordmcount, which we are about to merge into objtool,
> > some supported architectures do not use rela relocations. Since
> > object files use one or the other the list can be reused.
> > 
> > Signed-off-by: Matt Helsley <mhelsley@vmware.com>
> > ---
> >  tools/objtool/elf.c | 55 ++++++++++++++++++++++++++++++++++++---------
> >  tools/objtool/elf.h |  5 ++++-
> >  2 files changed, 49 insertions(+), 11 deletions(-)
> > 
> > diff --git a/tools/objtool/elf.c b/tools/objtool/elf.c
> > index c4857fa3f1d1..cd841e3df87d 100644
> > --- a/tools/objtool/elf.c
> > +++ b/tools/objtool/elf.c
> > @@ -465,12 +465,14 @@ static int read_relas(struct elf *elf)
> 
> This should probably be called read_relocs() now.
> 
> And 'struct rela' should probably be 'struct reloc'.  And I hate to say
> it but all the 'rela' based variable/function names should also probably
> be changed...
> 
> All the renaming might be disruptive for backports, but still I think it
> would be a good idea.  It probably belongs in its own commit.  If it can
> be done programmatically with 'sed -i' or so, with the exact command in
> the commit log, even better :-)
> 
> >  	unsigned long nr_rela, max_rela = 0, tot_rela = 0;
> >  
> >  	list_for_each_entry(sec, &elf->sections, list) {
> > -		if (sec->sh.sh_type != SHT_RELA)
> > +		if ((sec->sh.sh_type != SHT_RELA) &&
> > +		     (sec->sh.sh_type != SHT_REL))
> >  			continue;
> 
> The alignment is slightly off, should be:
> 
> 		if ((sec->sh.sh_type != SHT_RELA) &&
> 		    (sec->sh.sh_type != SHT_REL))
> 			continue;
>

Ack'd.

> >  
> > -		sec->base = find_section_by_name(elf, sec->name + 5);
> > +		sec->base = find_section_by_name(elf, sec->name +
> > +				((sec->sh.sh_type != SHT_REL) ? 5 : 4));
> 
> I think there's actually a cleaner way to do this, which we probably
> should have been doing in the first place:
> 
> 		sec->base = find_section_by_index(elf, sec->sh.sh_info);
> 
> (completely not tested, btw)
> 

I can split that out as a separate patch so it's easy to test/drop.

> > @@ -486,13 +488,26 @@ static int read_relas(struct elf *elf)
> >  			}
> >  			memset(rela, 0, sizeof(*rela));
> >  
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
> 
> The default should never happen, but might as well return -1 for extra
> robustness.
> 

Ack'd. See below...

> > @@ -717,17 +732,27 @@ int elf_rebuild_rela_section(struct section *sec)
> >  	struct rela *rela;
> >  	int nr, idx = 0, size;
> >  	GElf_Rela *relas;
> > +	GElf_Rel *rels;
> >  
> >  	nr = 0;
> >  	list_for_each_entry(rela, &sec->rela_list, list)
> >  		nr++;
> >  
> > +	/*
> > +	 * Allocate a buffer for relocations with addends but also use
> > +	 * it for other relocations too. The section type determines
> > +	 * the size of the section, the buffer used, and the entries.
> > +	 */
> >  	size = nr * sizeof(*relas);
> >  	relas = malloc(size);
> >  	if (!relas) {
> >  		perror("malloc");
> >  		return -1;
> >  	}
> > +	rels = (void *)relas;
> > +	if (sec->sh.sh_type == SHT_REL) {
> > +		size = nr * sizeof(*rels);
> > +	}
> >  
> >  	sec->data->d_buf = relas;
> >  	sec->data->d_size = size;
> > @@ -736,9 +761,19 @@ int elf_rebuild_rela_section(struct section *sec)
> >  
> >  	idx = 0;
> >  	list_for_each_entry(rela, &sec->rela_list, list) {
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
> >  		idx++;
> 
> There's a lot of trickiness going on here, in a valiant attempt to share
> code, but really most of the code ends up not being shared anyway.
> 
> I think it would be a lot cleaner to just create a new "rel" version of
> this function.
> 
> Then there could be a top-level
> 
> 	elf_rebuild_reloc_section()
> 
> which calls the appropriate "rel" or "rela" variant.

OK, that all makes sense to me.

This can go after the multi-arch bits -- at the moment only recordmcount
will use this, though it might be useful for other archs if check or other
subcommands are made suitable for new archs before then.

So I'll move all of that work to a follow-on set rather than include it
in this multi-arch set. The next posting of this series will include all of
the other changes discussed and rebase on tip/master (to get Peter's changes).

The follow-on set after multi-arch support can:

1) Split the sec->base change into a separate patch
	(since it's untested)

2) Rename patch (roughly starting with: sed -i 's/\brela\b/reloc/g')

3) Rebase this patch on top of that, making a new "reloc" version of
	this function (rather than introduce something that needs
	to be renamed)

Cheers,
	-Matt Helsley
