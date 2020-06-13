Return-Path: <SRS0=WLRa=72=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB76BC433DF
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Jun 2020 19:49:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9A94E20789
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Jun 2020 19:49:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726588AbgFMTtR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Jun 2020 15:49:17 -0400
Received: from ex13-edg-ou-002.vmware.com ([208.91.0.190]:25967 "EHLO
        EX13-EDG-OU-002.vmware.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726102AbgFMTtN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Jun 2020 15:49:13 -0400
Received: from sc9-mailhost2.vmware.com (10.113.161.72) by
 EX13-EDG-OU-002.vmware.com (10.113.208.156) with Microsoft SMTP Server id
 15.0.1156.6; Sat, 13 Jun 2020 12:49:07 -0700
Received: from localhost (unknown [10.200.193.92])
        by sc9-mailhost2.vmware.com (Postfix) with ESMTP id 3DD1DB13F0;
        Sat, 13 Jun 2020 15:49:13 -0400 (EDT)
Date:   Sat, 13 Jun 2020 12:49:12 -0700
From:   Matt Helsley <mhelsley@vmware.com>
To:     Peter Zijlstra <peterz@infradead.org>
CC:     <linux-kernel@vger.kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Julien Thierry <jthierry@redhat.com>,
        Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>
Subject: Re: [RFC][PATCH v4 18/32] objtool: mcount: Move nop_mcount()
Message-ID: <20200613194912.GB25598@rlwimi.vmware.com>
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
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20200612132656.GQ2531@hirez.programming.kicks-ass.net>
Received-SPF: None (EX13-EDG-OU-002.vmware.com: mhelsley@vmware.com does not
 designate permitted sender hosts)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 12, 2020 at 03:26:56PM +0200, Peter Zijlstra wrote:
> On Tue, Jun 02, 2020 at 12:50:11PM -0700, Matt Helsley wrote:
> > +static int nop_mcount(struct section * const rels,
> > +		      const char *const txtname)
> > +{
> > +	struct reloc *reloc;
> > +	struct section *txts = find_section_by_index(lf, rels->sh.sh_info);
> > +	unsigned mcountsym = 0;
> > +	int once = 0;
> > +
> > +	list_for_each_entry(reloc, &rels->reloc_list, list) {
> > +		int ret = -1;
> > +
> > +		if (!mcountsym)
> > +			mcountsym = get_mcountsym(reloc);
> > +
> > +		if (mcountsym == GELF_R_INFO(reloc->sym->idx, reloc->type) && !is_fake_mcount(reloc)) {
> 
> This makes no sense to me; why not have mcountsym be a 'struct symbol
> *' and have get_mcountsym() return one of those.
> 
> 	if (reloc->sym == mcountsym && ... )
> 
> is much nicer, no?

Indeed! I'll change it from returning an unsigned long to struct symbol * before I
move it out of the wrapper code.

> 
> > +			if (make_nop) {
> > +				ret = make_nop(txts, reloc->offset);
> > +				if (ret < 0)
> > +					return -1;
> > +			}
> > +			if (warn_on_notrace_sect && !once) {
> > +				printf("Section %s has mcount callers being ignored\n",
> > +				       txtname);
> > +				once = 1;
> > +				/* just warn? */
> > +				if (!make_nop)
> > +					return 0;
> > +			}
> > +		}
> > +
> > +		/*
> > +		 * If we successfully removed the mcount, mark the relocation
> > +		 * as a nop (don't do anything with it).
> > +		 */
> > +		if (!ret) {
> > +			reloc->type = rel_type_nop;
> > +			rels->changed = true;
> 
> I have an elf_write_rela(), I'll make sure to Cc you.

Thanks! I might also make use of your patch to rewrite instructions. We
need a way to turn certain prologue instructions into nops. Would it be
more widely useful to move that functionality out of mcount and into
the objtool ELF/per-arch code or do you think it's better inside the
mcount subcommand code?

Cheers,
     -Matt
