Return-Path: <SRS0=F/Af=7W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06CC5C433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 18:12:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E009F20691
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 18:12:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388723AbgFISMi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jun 2020 14:12:38 -0400
Received: from ex13-edg-ou-002.vmware.com ([208.91.0.190]:2277 "EHLO
        EX13-EDG-OU-002.vmware.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731293AbgFISMd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jun 2020 14:12:33 -0400
Received: from sc9-mailhost2.vmware.com (10.113.161.72) by
 EX13-EDG-OU-002.vmware.com (10.113.208.156) with Microsoft SMTP Server id
 15.0.1156.6; Tue, 9 Jun 2020 11:12:30 -0700
Received: from localhost (unknown [10.166.65.245])
        by sc9-mailhost2.vmware.com (Postfix) with ESMTP id 3F6ABB273C;
        Tue,  9 Jun 2020 14:12:32 -0400 (EDT)
Date:   Tue, 9 Jun 2020 11:12:31 -0700
From:   Matt Helsley <mhelsley@vmware.com>
To:     Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>
CC:     <linux-kernel@vger.kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Julien Thierry <jthierry@redhat.com>
Subject: Re: [RFC][PATCH v4 27/32] objtool: mcount: Generic location and
 relocation table types
Message-ID: <20200609181231.GD1284251@rlwimi.vmware.com>
Mail-Followup-To: Matt Helsley <mhelsley@vmware.com>,
        Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>,
        linux-kernel@vger.kernel.org, Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Julien Thierry <jthierry@redhat.com>
References: <cover.1591125127.git.mhelsley@vmware.com>
 <311ccd169cec877d0c1993772818f0e5cdf11dc4.1591125127.git.mhelsley@vmware.com>
 <79552506-b994-63ce-d3d9-8053dcbc02db@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <79552506-b994-63ce-d3d9-8053dcbc02db@linux.vnet.ibm.com>
Received-SPF: None (EX13-EDG-OU-002.vmware.com: mhelsley@vmware.com does not
 designate permitted sender hosts)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 09, 2020 at 12:11:55PM +0530, Kamalesh Babulal wrote:
> On 6/3/20 1:20 AM, Matt Helsley wrote:
> > Rather than building the exact ELF section data we need and
> > avoiding libelf's conversion step, use more GElf types
> > and then libelf's elfxx_xlatetof() functions to convert
> > the mcount locations (GElf_Addr) and associated relocations.
> > 
> > This converts sift_rel_mcount() so that it doesn't use the
> > recordmcount wrapper. The next patch will move it out of the
> > wrapper.
> > 
> > Signed-off-by: Matt Helsley <mhelsley@vmware.com>
> > ---
> >  tools/objtool/recordmcount.c |  44 +++----------
> >  tools/objtool/recordmcount.h | 120 ++++++++++++++---------------------
> >  2 files changed, 59 insertions(+), 105 deletions(-)
> > 
> > diff --git a/tools/objtool/recordmcount.c b/tools/objtool/recordmcount.c
> > index 06a8f8ddefa7..ef3c360a3db9 100644
> > --- a/tools/objtool/recordmcount.c
> > +++ b/tools/objtool/recordmcount.c
> 
> [...]
> 
> > -static uint_t *sift_rel_mcount(uint_t *mlocp,
> > -			       unsigned const offbase,
> > -			       Elf_Rel **const mrelpp,
> > +static void sift_rel_mcount(GElf_Addr **mlocpp,
> > +			       GElf_Sxword *r_offsetp,
> > +			       void **const mrelpp,
> >  			       const struct section * const rels,
> >  			       unsigned const recsym_index,
> >  			       unsigned long const recval,
> > -			       unsigned const reltype)
> > +			       unsigned const reltype,
> > +			       bool is_rela)
> >  {
> > -	uint_t *const mloc0 = mlocp;
> > -	Elf_Rel *mrelp = *mrelpp;
> > -	unsigned int rel_entsize = rels->sh.sh_entsize;
> > -	unsigned mcountsym = 0;
> > +	GElf_Rel *mrelp = *mrelpp;
> > +	GElf_Rela *mrelap = *mrelpp;
> > +	unsigned int mcount_sym_info = 0;
> >  	struct reloc *reloc;
> > 
> >  	list_for_each_entry(reloc, &rels->reloc_list, list) {
> > -		if (!mcountsym)
> > -			mcountsym = get_mcountsym(reloc);
> > -
> > -		if (mcountsym == GELF_R_INFO(reloc->sym->idx, reloc->type) && !is_fake_mcount(reloc)) {
> > -			uint_t const addend =
> > -				_w(reloc->offset - recval + mcount_adjust);
> > -			mrelp->r_offset = _w(offbase
> > -				+ ((void *)mlocp - (void *)mloc0));
> > -			Elf_r_info(mrelp, recsym_index, reltype);
> > -			if (rel_entsize == sizeof(Elf_Rela)) {
> > -				((Elf_Rela *)mrelp)->r_addend = addend;
> > -				*mlocp++ = 0;
> > -			} else
> > -				*mlocp++ = addend;
> > -
> > -			mrelp = (Elf_Rel *)(rel_entsize + (void *)mrelp);
> > +		unsigned long addend;
> > +
> > +		if (!mcount_sym_info)
> > +			mcount_sym_info = get_mcount_sym_info(reloc);
> > +
> > +		if (mcount_sym_info != GELF_R_INFO(reloc->sym->idx, reloc->type) || is_fake_mcount(reloc))
> > +			continue;
> 
> Hi Matt,
> 
> I was trying out the patch series on ppc64le and found that __mcount_loc
> and .rela__mcount_loc section pairs do not get generated. 
> 
> # readelf -S fs/proc/cmdline.o|grep mcount
> #
> 
> Debugged the cause to get_mcountsym()'s return type.  It returns reloc
> type from GELF_R_INFO() and expects Elf64_Xword a.k.a unsigned long
> to be the return type but get_mcountsym() returns unsigned int on 64-bit.
> 
> On power the _mcount is of relocation type R_PPC64_REL24 (info 0x170000000a),
> using unsigned int truncates the value to 0xa and fails the above check.
> Using below fix, that converts mcount_sym_info to use unsigned long, generates
> the __mcount_loc section pairs.
> 
> --- a/tools/objtool/mcount.c
> +++ b/tools/objtool/mcount.c
> @@ -163,7 +163,7 @@ static int is_mcounted_section_name(char const *const txtname)
>                 strcmp(".cpuidle.text", txtname) == 0;
>  }
>  
> -static unsigned int get_mcount_sym_info(struct reloc *reloc)
> +static unsigned long get_mcount_sym_info(struct reloc *reloc)
>  {
>         struct symbol *sym = reloc->sym;
>         char const *symname = sym->name;
> @@ -274,7 +274,7 @@ static int nop_mcount(struct section * const rels,
>  {
>         struct reloc *reloc;
>         struct section *txts = find_section_by_index(lf, rels->sh.sh_info);
> -       unsigned int mcount_sym_info = 0;
> +       unsigned long mcount_sym_info = 0;
>         int once = 0;
>  
>         list_for_each_entry(reloc, &rels->reloc_list, list) {
> @@ -363,7 +363,7 @@ static void sift_rel_mcount(GElf_Addr **mlocpp,
>  {
>         GElf_Rel *mrelp = *mrelpp;
>         GElf_Rela *mrelap = *mrelpp;
> -       unsigned int mcount_sym_info = 0;
> +       unsigned long mcount_sym_info = 0;
>         struct reloc *reloc;
>  
>         list_for_each_entry(reloc, &rels->reloc_list, list) {
> 
> # readelf -S fs/proc/cmdline.o|grep mcount
>   [31] __mcount_loc      PROGBITS         0000000000000000  00022f10
>   [32] .rela__mcount_loc RELA             0000000000000000  00022f20

Fixed for next posting.

I've essentially added this as another patch before it moves into
recordmcount.c, gets renamed to get_mcount_sym_info(), etc. I did it
this way because it only becomes necessary to change the type before
moving the function (and eventually its callers) out of the wrapper.

I feel I should credit you as author or at least co-author of the added
patch since it's basically a "backported" version of the changes you
suggested. I reviewed the process in submitting-patches.rst and propose
the commit message:
	
	objtool: mcount: Extend mcountsym size
	    
	Before we can move this function out of the wrapper and into
	wordsize-independent code we need to explicitly size the
	type returned from get_mcountsym() to preserve the symbol info.

	Reported-by: Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>
	Signed-off-by: Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>
	Signed-off-by: Matt Helsley <mhelsley@vmware.com>

Is that OK with you or do you have another preference?

> 
> 
> > +
> > +		addend = reloc->offset - recval + mcount_adjust;
> > +		if (is_rela) {
> > +			mrelap->r_offset = *r_offsetp;
> > +			mrelap->r_info = GELF_R_INFO(recsym_index, reltype);
> > +			mrelap->r_addend = addend;
> > +			mrelap++;
> > +			**mlocpp = 0;
> > +		} else {
> > +			mrelp->r_offset = *r_offsetp;
> > +			mrelp->r_info = GELF_R_INFO(recsym_index, reltype);
> > +			mrelp++;
> > +			**mlocpp = addend;
> >  		}
> > +		(*mlocpp)++;
> > +		r_offsetp += loc_size;
> 
> the offsets generated for rela__mcount_loc section are incorrect:
> 
> # readelf -rW fs/proc/meminfo.o
> [...]
> Relocation section '.rela__mcount_loc' at offset 0x59a48 contains 4 entries:
>     Offset             Info             Type               Symbol's Value  Symbol's Name + Addend
> 0000000000000000  0000000200000026 R_PPC64_ADDR64         0000000000000000 .text + c
> 00000a059c401f38  0000000200000026 R_PPC64_ADDR64         0000000000000000 .text + 64
> 0000000000000000  0000000200000026 R_PPC64_ADDR64         0000000000000000 .text + 7c
> 0000000000000000  0000000600000026 R_PPC64_ADDR64         0000000000000000 .init.text + c
> 
> changing the above line to *r_offsetp += loc_size and initializing
> r_offset=0 in do_mcount() generates the correct offset:
> 
> # readelf -rW fs/proc/meminfo.o
> [...]
> Relocation section '.rela__mcount_loc' at offset 0x59a48 contains 4 entries:
>     Offset             Info             Type               Symbol's Value  Symbol's Name + Addend
> 0000000000000000  0000000200000026 R_PPC64_ADDR64         0000000000000000 .text + c
> 0000000000000008  0000000200000026 R_PPC64_ADDR64         0000000000000000 .text + 64
> 0000000000000010  0000000200000026 R_PPC64_ADDR64         0000000000000000 .text + 7c
> 0000000000000018  0000000600000026 R_PPC64_ADDR64         0000000000000000 .init.text + c

Fixed for next posting.

Thank you for testing these out and the fixes!

Cheers,
	-Matt Helsley
