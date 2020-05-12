Return-Path: <SRS0=0vny=62=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2697CA90AF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 18:07:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D332C20673
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 18:07:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730802AbgELSHx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 May 2020 14:07:53 -0400
Received: from ex13-edg-ou-001.vmware.com ([208.91.0.189]:48506 "EHLO
        EX13-EDG-OU-001.vmware.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726890AbgELSHw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 May 2020 14:07:52 -0400
Received: from sc9-mailhost3.vmware.com (10.113.161.73) by
 EX13-EDG-OU-001.vmware.com (10.113.208.155) with Microsoft SMTP Server id
 15.0.1156.6; Tue, 12 May 2020 11:07:50 -0700
Received: from localhost (unknown [10.200.192.41])
        by sc9-mailhost3.vmware.com (Postfix) with ESMTP id 6ECB0405FB;
        Tue, 12 May 2020 11:07:52 -0700 (PDT)
Date:   Tue, 12 May 2020 11:07:52 -0700
From:   Matt Helsley <mhelsley@vmware.com>
To:     Julien Thierry <jthierry@redhat.com>
CC:     <linux-kernel@vger.kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Miroslav Benes <mbenes@suse.cz>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [RFC][PATCH 2/5] objtool: Move struct objtool_file into
 arch-independent header
Message-ID: <20200512180752.GH9040@rlwimi.vmware.com>
Mail-Followup-To: Matt Helsley <mhelsley@vmware.com>,
        Julien Thierry <jthierry@redhat.com>, linux-kernel@vger.kernel.org,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Miroslav Benes <mbenes@suse.cz>,
        Steven Rostedt <rostedt@goodmis.org>
References: <cover.1588888003.git.mhelsley@vmware.com>
 <dfa8c8aaf75493d739ef4f8feabf99bbb3f5d195.1588888003.git.mhelsley@vmware.com>
 <f7e08aba-03cc-b57a-6122-3801091b1387@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <f7e08aba-03cc-b57a-6122-3801091b1387@redhat.com>
Received-SPF: None (EX13-EDG-OU-001.vmware.com: mhelsley@vmware.com does not
 designate permitted sender hosts)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 12, 2020 at 06:04:43PM +0100, Julien Thierry wrote:
> Hi Matt,
> 
> On 5/11/20 6:35 PM, Matt Helsley wrote:
> > The objtool_file structure describing the files objtool works on is
> > not architecture dependent -- it's not x86 only -- and it will be useful
> > for any future commands that might not be part of the check / orc
> > tooling. So we move it from the check.h header  into the objtool.h header.
> > 
> 
> The change itself looks alright to me, however I'd say the justification is
> more about the fact the more subcommands dealing with object files are going
> to be added to objtool, and all those subcommand will likely use the
> objtool_file representation.
> 
> I think it doesn't have much to do with arch specificity. (But this is
> really about the commit message, otherwise the changes make sense)

Good point. Here's a rewrite of the commit message:

	The objtool_file structure describes the files objtool works on,
	is used by the check subcommand, and the check.h header is included
	by the orc subcommands so it's presently used by all subcommands.

	Since the structure will be useful in all subcommands besides check, 
	and some subcommands may not want to include check.h to get the
	definition, split the structure out into a new header meant for use
	by all objtool subcommands.

Thanks!

Cheers,
     -Matt Helsley

> 
> > Signed-off-by: Matt Helsley <mhelsley@vmware.com>
> > ---
> >   tools/objtool/check.h   | 10 +---------
> >   tools/objtool/objtool.h | 20 ++++++++++++++++++++
> >   2 files changed, 21 insertions(+), 9 deletions(-)
> >   create mode 100644 tools/objtool/objtool.h
> > 
> > diff --git a/tools/objtool/check.h b/tools/objtool/check.h
> > index f0ce8ffe7135..ec6ff7f0970c 100644
> > --- a/tools/objtool/check.h
> > +++ b/tools/objtool/check.h
> > @@ -7,11 +7,10 @@
> >   #define _CHECK_H
> >   #include <stdbool.h>
> > -#include "elf.h"
> > +#include "objtool.h"
> >   #include "cfi.h"
> >   #include "arch.h"
> >   #include "orc.h"
> > -#include <linux/hashtable.h>
> >   struct insn_state {
> >   	struct cfi_reg cfa;
> > @@ -47,13 +46,6 @@ struct instruction {
> >   	struct orc_entry orc;
> >   };
> > -struct objtool_file {
> > -	struct elf *elf;
> > -	struct list_head insn_list;
> > -	DECLARE_HASHTABLE(insn_hash, 20);
> > -	bool ignore_unreachables, c_file, hints, rodata;
> > -};
> > -
> >   int check(const char *objname, bool orc);
> >   struct instruction *find_insn(struct objtool_file *file,
> > diff --git a/tools/objtool/objtool.h b/tools/objtool/objtool.h
> > new file mode 100644
> > index 000000000000..afa52fe6f644
> > --- /dev/null
> > +++ b/tools/objtool/objtool.h
> > @@ -0,0 +1,20 @@
> > +/* SPDX-License-Identifier: GPL-2.0-or-later */
> > +/*
> > + * Copyright (C) 2020 Matt Helsley <mhelsley@vmware.com>
> > + */
> > +
> > +#ifndef _OBJTOOL_H
> > +#define _OBJTOOL_H
> > +#include <stdbool.h>
> > +#include <linux/list.h>
> > +#include <linux/hashtable.h>
> > +
> > +#include "elf.h"
> > +
> > +struct objtool_file {
> > +	struct elf *elf;
> > +	struct list_head insn_list;
> > +	DECLARE_HASHTABLE(insn_hash, 20);
> > +	bool ignore_unreachables, c_file, hints, rodata;
> > +};
> > +#endif
> > 
> 
> -- 
> Julien Thierry
> 
