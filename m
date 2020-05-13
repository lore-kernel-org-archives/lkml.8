Return-Path: <SRS0=g10L=63=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5669EC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 15:59:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 89C43205ED
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 15:59:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731509AbgEMP7t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 May 2020 11:59:49 -0400
Received: from ex13-edg-ou-001.vmware.com ([208.91.0.189]:21411 "EHLO
        EX13-EDG-OU-001.vmware.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729179AbgEMP7t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 May 2020 11:59:49 -0400
Received: from sc9-mailhost2.vmware.com (10.113.161.72) by
 EX13-EDG-OU-001.vmware.com (10.113.208.155) with Microsoft SMTP Server id
 15.0.1156.6; Wed, 13 May 2020 08:59:46 -0700
Received: from localhost (unknown [10.166.66.23])
        by sc9-mailhost2.vmware.com (Postfix) with ESMTP id 886901B8084;
        Wed, 13 May 2020 11:59:48 -0400 (EDT)
Date:   Wed, 13 May 2020 08:59:48 -0700
From:   Matt Helsley <mhelsley@vmware.com>
To:     Julien Thierry <jthierry@redhat.com>
CC:     <linux-kernel@vger.kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Miroslav Benes <mbenes@suse.cz>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [RFC][PATCH 4/5] objtool: Enable compilation of objtool for all
 architectures
Message-ID: <20200513155948.GI9040@rlwimi.vmware.com>
Mail-Followup-To: Matt Helsley <mhelsley@vmware.com>,
        Julien Thierry <jthierry@redhat.com>, linux-kernel@vger.kernel.org,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Miroslav Benes <mbenes@suse.cz>,
        Steven Rostedt <rostedt@goodmis.org>
References: <cover.1588888003.git.mhelsley@vmware.com>
 <9f709ea2ae66cc03b3ff3329baa8f670ccd0e368.1588888003.git.mhelsley@vmware.com>
 <f9eedb02-54fe-fb96-fbcc-5f40f41e571a@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <f9eedb02-54fe-fb96-fbcc-5f40f41e571a@redhat.com>
Received-SPF: None (EX13-EDG-OU-001.vmware.com: mhelsley@vmware.com does not
 designate permitted sender hosts)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 12, 2020 at 06:04:56PM +0100, Julien Thierry wrote:
> Hi Matt,
> 
> On 5/11/20 6:35 PM, Matt Helsley wrote:
> > objtool currently only compiles for x86 architectures. This is
> > fine as it presently does not support tooling for other
> > architectures. However, we would like to be able to convert other
> > kernel tools to run as objtool sub commands because they too
> > process ELF object files. This will allow us to convert tools
> > such as recordmcount to use objtool's ELF code.
> > 
> > Since much of recordmcount's ELF code is copy-paste code to/from
> > a variety of other kernel tools (look at modpost for example) this
> > means that if we can convert recordmcount we can convert more.
> > 
> > We define a "missing" architecture which contains weak definitions
> > for tools that do not exist on all architectures. In this case the
> > "check" and "orc" tools do not exist on all architectures.
> > 
> > To test building for other architectures ($arch below):
> > 
> > 	cd tools/objtool/arch
> > 	ln -s missing $arch
> > 	make O=build-$arch ARCH=$arch tools/objtool
> > 
> 
> Since the stuff under arch/missing is only weak symbols to make up for
> missing subcmd implementations, can we put everything in a file
> subcmd_defaults.c (name up for debate!) that would be always be compiled an
> linked. And some SUBCMD_XXX is set to "y", the corresponding object file
> gets compiled and overrides the weak symbols from subcmd_defaults.c .

Hmm, I like keeping them separated along similar lines to the other
code because it makes it easier to see the intended correspondence and
likely will keep the files more readable / smaller. I could
just move them out of arch/missing and into missing_check.c and so forth.

What do you think of that?

> > diff --git a/tools/objtool/Build b/tools/objtool/Build
> > index 66f44f5cd2a6..fb6e6faf6f10 100644
> > --- a/tools/objtool/Build
> > +++ b/tools/objtool/Build
> > @@ -1,11 +1,12 @@
> >   objtool-y += arch/$(SRCARCH)/
> > +
> > +objtool-$(SUBCMD_CHECK) += check.o
> > +objtool-$(SUBCMD_ORC) += orc_gen.o
> > +objtool-$(SUBCMD_ORC) += orc_dump.o
> > +
> >   objtool-y += builtin-check.o
> >   objtool-y += builtin-orc.o
> > -objtool-y += check.o
> > -objtool-y += orc_gen.o
> > -objtool-y += orc_dump.o
> >   objtool-y += elf.o
> > -objtool-y += special.o
> 
> I'm not convinced by the moving of special under arch/x86 and I didn't
> understand it at first.
> 
> I guess you did it because it is only used by the check subcmd, which is
> currently only implemented by x86. Is that the reason?

Yeah, that was the original reasoning and this is an artifact of the
previous patch set.
 
> I feel that the proper way to do it would be to leave special.c/h where they
> are and have "objtool-$(SUBCMD_CHECK) += special.o". Unless there was some
> other motivation for it.

This makes sense. I'll incorporate that in the next posting.

> >   objtool-y += objtool.o
> >   objtool-y += libstring.o
> > diff --git a/tools/objtool/Makefile b/tools/objtool/Makefile
> > index f591c4d1b6fe..8aac9e133188 100644
> > --- a/tools/objtool/Makefile
> > +++ b/tools/objtool/Makefile
> > @@ -45,7 +45,16 @@ elfshdr := $(shell echo '$(pound)include <libelf.h>' | $(CC) $(CFLAGS) -x c -E -
> >   CFLAGS += $(if $(elfshdr),,-DLIBELF_USE_DEPRECATED)
> >   AWK = awk
> > -export srctree OUTPUT CFLAGS SRCARCH AWK
> > +
> > +ifeq ($(SRCARCH),x86)
> > +	SUBCMD_CHECK := y
> > +	SUBCMD_ORC := y
> > +else
> > +	SUBCMD_CHECK := n
> > +	SUBCMD_ORC := n
> > +endif
> > +
> 
> Nit: Can we default all SUBCMD_* variables to 'n' outside a branch and then
> individual arches override the relevant variables to 'y' in their "ifeq
> ($SRCARCH, <arch>)" branch?

Definitely -- I'll set them all to n above then we can just have one
ifeq block per arch.

Thanks for the Review!

Cheers,
	-Matt Helsley
