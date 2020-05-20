Return-Path: <SRS0=sqqi=7C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFCF0C433E3
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 16:41:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A501F2072C
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 16:41:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726846AbgETQlD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 May 2020 12:41:03 -0400
Received: from ex13-edg-ou-001.vmware.com ([208.91.0.189]:48081 "EHLO
        EX13-EDG-OU-001.vmware.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726545AbgETQlC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 May 2020 12:41:02 -0400
Received: from sc9-mailhost3.vmware.com (10.113.161.73) by
 EX13-EDG-OU-001.vmware.com (10.113.208.155) with Microsoft SMTP Server id
 15.0.1156.6; Wed, 20 May 2020 09:40:59 -0700
Received: from localhost (unknown [10.200.192.41])
        by sc9-mailhost3.vmware.com (Postfix) with ESMTP id 1862D40448;
        Wed, 20 May 2020 09:41:02 -0700 (PDT)
Date:   Wed, 20 May 2020 09:41:01 -0700
From:   Matt Helsley <mhelsley@vmware.com>
To:     Julien Thierry <jthierry@redhat.com>
CC:     <linux-kernel@vger.kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Miroslav Benes <mbenes@suse.cz>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH 3/3] objtool: Enable compilation of objtool for all
 architectures
Message-ID: <20200520164101.GU9040@rlwimi.vmware.com>
Mail-Followup-To: Matt Helsley <mhelsley@vmware.com>,
        Julien Thierry <jthierry@redhat.com>, linux-kernel@vger.kernel.org,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Miroslav Benes <mbenes@suse.cz>,
        Steven Rostedt <rostedt@goodmis.org>
References: <cover.1589913349.git.mhelsley@vmware.com>
 <96252a8eee50710f4fe115ca516f0e6058b9f66b.1589913349.git.mhelsley@vmware.com>
 <b27ee658-2886-107c-a367-632467ec6929@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <b27ee658-2886-107c-a367-632467ec6929@redhat.com>
Received-SPF: None (EX13-EDG-OU-001.vmware.com: mhelsley@vmware.com does not
 designate permitted sender hosts)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 20, 2020 at 09:31:46AM +0100, Julien Thierry wrote:
> 
> 
> On 5/19/20 9:55 PM, Matt Helsley wrote:
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
> > We define "missing" weak definitions for subcommand entry functions
> > and other weak definitions for shared functions critical to
> > building existing subcommands. These return 127 when the command is
> > missing which signify tools that do not exist on all architectures.
> > In this case the "check" and "orc" tools do not exist on all
> > architectures so we only add them for x86. Future changes adding
> > support for "check", to arm64 for example, can then modify the
> > SUBCMD_CHECK variable when building for arm64.
> > 
> > objtool is not currently wired in to KConfig to be built for other
> > architectures because it's not needed for those architectures and
> > there are no commands it supports other than those for x86. As more
> > command support is enabled on various architectures the necessary
> > KConfig changes can be made (e.g. adding "STACK_VALIDATION") to
> > trigger building objtool.
> > 
> > Signed-off-by: Matt Helsley <mhelsley@vmware.com>
> > Cc: Julien Thierry <jthierry@redhat.com>
> > ---
> >   tools/objtool/Build           | 13 +++++++++----
> >   tools/objtool/Makefile        | 11 ++++++++++-
> >   tools/objtool/arch.h          |  4 +++-
> >   tools/objtool/builtin-check.c |  2 +-
> >   tools/objtool/builtin-orc.c   |  3 +--
> >   tools/objtool/check.c         |  4 ++--
> >   tools/objtool/check.h         |  4 ----
> >   tools/objtool/objtool.h       | 14 ++++++++++++++
> >   tools/objtool/orc.h           | 18 ------------------
> >   tools/objtool/orc_dump.c      |  3 ++-
> >   tools/objtool/orc_gen.c       |  1 -
> >   tools/objtool/weak.c          | 35 +++++++++++++++++++++++++++++++++++
> >   12 files changed, 77 insertions(+), 35 deletions(-)
> >   delete mode 100644 tools/objtool/orc.h
> >   create mode 100644 tools/objtool/weak.c
> > 
> > diff --git a/tools/objtool/Build b/tools/objtool/Build
> > index 66f44f5cd2a6..b7222d5cc7bc 100644
> > --- a/tools/objtool/Build
> > +++ b/tools/objtool/Build
> > @@ -1,11 +1,16 @@
> >   objtool-y += arch/$(SRCARCH)/
> > +
> > +objtool-y += weak.o
> > +
> > +objtool-$(SUBCMD_CHECK) += check.o
> > +objtool-$(SUBCMD_CHECK) += special.o
> > +objtool-$(SUBCMD_ORC) += check.o
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
> >   objtool-y += objtool.o
> >   objtool-y += libstring.o
> > diff --git a/tools/objtool/Makefile b/tools/objtool/Makefile
> > index 6b91388aecbb..12686e2f1a56 100644
> > --- a/tools/objtool/Makefile
> > +++ b/tools/objtool/Makefile
> > @@ -46,7 +46,16 @@ elfshdr := $(shell echo '$(pound)include <libelf.h>' | $(CC) $(CFLAGS) -x c -E -
> >   CFLAGS += $(if $(elfshdr),,-DLIBELF_USE_DEPRECATED)
> >   AWK = awk
> > -export srctree OUTPUT CFLAGS SRCARCH AWK
> > +
> > +SUBCMD_CHECK := n
> > +SUBCMD_ORC := n
> > +
> > +ifeq ($(SRCARCH),x86)
> > +	SUBCMD_CHECK := y
> > +	SUBCMD_ORC := y
> > +endif
> > +
> > +export srctree OUTPUT CFLAGS SRCARCH AWK SUBCMD_CHECK SUBCMD_ORC
> 
> Nit: I was thinking, since the list of SUBCMD_* is only going to grow
> maybe it would be nicer to have a single export line for the SUBCMD_*
> variables and leave the export line of [srctree..AWK] untouched.

That's a really good idea actually. Glad to see Josh included it in the
changed patch.

> 
> Just a suggestion, and only in case you respin this taking into account
> Josh's comment.
> 
> Otherwise things look good to me.

Thanks for all the reviews and good ideas!

Cheers,
    -Matt Helsley
