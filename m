Return-Path: <SRS0=RE5T=7A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FFBFC433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 19:20:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2545920756
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 19:20:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727917AbgERTUQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 May 2020 15:20:16 -0400
Received: from ex13-edg-ou-001.vmware.com ([208.91.0.189]:19760 "EHLO
        EX13-EDG-OU-001.vmware.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727066AbgERTUO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 15:20:14 -0400
Received: from sc9-mailhost3.vmware.com (10.113.161.73) by
 EX13-EDG-OU-001.vmware.com (10.113.208.155) with Microsoft SMTP Server id
 15.0.1156.6; Mon, 18 May 2020 12:20:13 -0700
Received: from localhost (unknown [10.200.192.41])
        by sc9-mailhost3.vmware.com (Postfix) with ESMTP id 2D0C9404BC;
        Mon, 18 May 2020 12:20:14 -0700 (PDT)
Date:   Mon, 18 May 2020 12:20:13 -0700
From:   Matt Helsley <mhelsley@vmware.com>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
CC:     <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Julien Thierry <jthierry@redhat.com>,
        Miroslav Benes <mbenes@suse.cz>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [RFC][PATCH 4/5] objtool: Enable compilation of objtool for all
 architectures
Message-ID: <20200518192013.GP9040@rlwimi.vmware.com>
Mail-Followup-To: Matt Helsley <mhelsley@vmware.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>, linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Julien Thierry <jthierry@redhat.com>,
        Miroslav Benes <mbenes@suse.cz>,
        Steven Rostedt <rostedt@goodmis.org>
References: <cover.1588888003.git.mhelsley@vmware.com>
 <9f709ea2ae66cc03b3ff3329baa8f670ccd0e368.1588888003.git.mhelsley@vmware.com>
 <20200515205610.fmdimt7wbafypuqc@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20200515205610.fmdimt7wbafypuqc@treble>
Received-SPF: None (EX13-EDG-OU-001.vmware.com: mhelsley@vmware.com does not
 designate permitted sender hosts)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 15, 2020 at 03:56:10PM -0500, Josh Poimboeuf wrote:
> On Mon, May 11, 2020 at 10:35:12AM -0700, Matt Helsley wrote:
> > +struct insn_state {
> > +	struct cfi_reg cfa;
> > +	struct cfi_reg regs[CFI_NUM_REGS];
> > +	int stack_size;
> > +	unsigned char type;
> > +	bool bp_scratch;
> > +	bool drap, end, uaccess, df;
> > +	bool noinstr;
> > +	s8 instr;
> > +	unsigned int uaccess_stack;
> > +	int drap_reg, drap_offset;
> > +	struct cfi_reg vals[CFI_NUM_REGS];
> > +};
> > +
> > +struct instruction {
> > +	struct list_head list;
> > +	struct hlist_node hash;
> > +	struct section *sec;
> > +	unsigned long offset;
> > +	unsigned int len;
> > +	enum insn_type type;
> > +	unsigned long immediate;
> > +	bool alt_group, dead_end, ignore, hint, save, restore, ignore_alts;
> > +	bool retpoline_safe;
> > +	s8 instr;
> > +	u8 visited;
> > +	struct symbol *call_dest;
> > +	struct instruction *jump_dest;
> > +	struct instruction *first_jump_src;
> > +	struct rela *jump_table;
> > +	struct list_head alts;
> > +	struct symbol *func;
> > +	struct stack_op stack_op;
> > +	struct insn_state state;
> > +	struct orc_entry orc;
> > +};
> 
> Why were these moved to arch.h?  They're not necessarily arch-specific,
> but rather "check"-specific, so I think they still belong in check.h, if
> possible.

Hmm, good question. I thought it had something to do with the CFI_NUM_REGS
definition but even if that's the case I think you're right that it should
stay in "check" -- I can verify and if that's the case just just define it
to some dummy value (1?) when it's missing.

Cheers,
	-Matt Helsley
