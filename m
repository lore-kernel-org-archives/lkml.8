Return-Path: <SRS0=4xmc=56=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71653C2BB85
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 20:56:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4A2C020644
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 20:56:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2633466AbgDNU41 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Apr 2020 16:56:27 -0400
Received: from ex13-edg-ou-002.vmware.com ([208.91.0.190]:36396 "EHLO
        EX13-EDG-OU-002.vmware.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2633447AbgDNU4J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 16:56:09 -0400
Received: from sc9-mailhost2.vmware.com (10.113.161.72) by
 EX13-EDG-OU-002.vmware.com (10.113.208.156) with Microsoft SMTP Server id
 15.0.1156.6; Tue, 14 Apr 2020 13:56:06 -0700
Received: from localhost (unknown [10.129.220.242])
        by sc9-mailhost2.vmware.com (Postfix) with ESMTP id 8C6ECB27C7;
        Tue, 14 Apr 2020 16:56:08 -0400 (EDT)
Date:   Tue, 14 Apr 2020 13:56:03 -0700
From:   Matt Helsley <mhelsley@vmware.com>
To:     Julien Thierry <jthierry@redhat.com>
CC:     <linux-kernel@vger.kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Miroslav Benes <mbenes@suse.cz>
Subject: Re: [RFC][PATCH 03/36] objtool: Enable compilation of objtool for
 all architectures
Message-ID: <20200414205603.GC118458@rlwimi.vmware.com>
Mail-Followup-To: Matt Helsley <mhelsley@vmware.com>,
        Julien Thierry <jthierry@redhat.com>, linux-kernel@vger.kernel.org,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Miroslav Benes <mbenes@suse.cz>
References: <cover.1586468801.git.mhelsley@vmware.com>
 <a96d42818c7e8f2a8bd2e151b8c220193f4ae986.1586468801.git.mhelsley@vmware.com>
 <e8a52162-dd38-6092-7217-cc5c088abadc@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <e8a52162-dd38-6092-7217-cc5c088abadc@redhat.com>
Received-SPF: None (EX13-EDG-OU-002.vmware.com: mhelsley@vmware.com does not
 designate permitted sender hosts)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 14, 2020 at 08:39:23AM +0100, Julien Thierry wrote:
> Hi Matt,
> 
> On 4/10/20 8:35 PM, Matt Helsley wrote:
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
> > This uses the weak, no-op definitions of the "check" and "orc"
> > commands for the newly-supported architecture. Presently these
> > exit with 127 to indicate that the subcommands are missing.
> > Subsequent patches can then be made to determine if the weak
> > definitions are used and explicitly report a missing command,
> > and even to list which subcommands are supported (perhaps if
> > no subcommand is specified it can list the supported subcommands).
> > 
> > objtool is not currently wired in to KConfig to be built for other
> > architectures because it's not needed for those architectures and
> > there are no commands it supports other than those for x86.
> > 
> > This commit allows us to demonstrate the pattern of adding
> > architecture support and isolates moving the various files from
> > adding support for more objtool subcommands.
> > 
> > Signed-off-by: Matt Helsley <mhelsley@vmware.com>
> > ---
> >   tools/objtool/Build                     |  4 ---
> >   tools/objtool/arch/missing/Build        |  3 ++
> >   tools/objtool/arch/missing/check.c      | 14 +++++++++
> >   tools/objtool/arch/missing/orc_dump.c   | 11 +++++++
> >   tools/objtool/arch/missing/orc_gen.c    | 16 ++++++++++
> >   tools/objtool/arch/x86/Build            |  4 +++
> >   tools/objtool/{ => arch/x86}/arch.h     | 42 ++++++++++++++++++++++++-
> >   tools/objtool/{ => arch/x86}/cfi.h      |  0
> >   tools/objtool/{ => arch/x86}/check.c    | 11 ++++---
> >   tools/objtool/arch/x86/decode.c         |  2 +-
> >   tools/objtool/{ => arch/x86}/orc_dump.c |  5 +--
> >   tools/objtool/{ => arch/x86}/orc_gen.c  |  9 ++++--
> >   tools/objtool/{ => arch/x86}/special.c  |  4 +--
> >   tools/objtool/{ => arch/x86}/special.h  |  2 +-
> >   tools/objtool/builtin-orc.c             |  2 +-
> >   tools/objtool/check.h                   | 37 ----------------------
> >   tools/objtool/objtool.h                 |  2 +-
> >   tools/objtool/orc.h                     |  2 --
> >   18 files changed, 110 insertions(+), 60 deletions(-)
> >   create mode 100644 tools/objtool/arch/missing/Build
> >   create mode 100644 tools/objtool/arch/missing/check.c
> >   create mode 100644 tools/objtool/arch/missing/orc_dump.c
> >   create mode 100644 tools/objtool/arch/missing/orc_gen.c
> >   rename tools/objtool/{ => arch/x86}/arch.h (59%)
> >   rename tools/objtool/{ => arch/x86}/cfi.h (100%)
> >   rename tools/objtool/{ => arch/x86}/check.c (99%)
> >   rename tools/objtool/{ => arch/x86}/orc_dump.c (98%)
> >   rename tools/objtool/{ => arch/x86}/orc_gen.c (96%)
> >   rename tools/objtool/{ => arch/x86}/special.c (98%)
> >   rename tools/objtool/{ => arch/x86}/special.h (95%)
> > 
> 
> My concern with this it that most of the structures and code in arch.h and
> check.c can/should be reused across architectures. So, when providing
> support for a new architecutre, the first thing that will be needed is to
> move those back under tools/objtool whithout disturbing the arches that
> don't yet provide support for "check" subcommand.

Agreed. I tried to note this in my cover letter but perhaps I could have
written it better.

I still included it because I think the check.c portion of this RFC shows
what it would look like to add a hypothetical objtool subcommand implemented
for only one architecture (which "check" is, currently, an example of). I
don't think this RFC shows what should happen to check.c in particular.
You folks have been working on that here and I don't wish to disturb your
work.

> 
> So, if it is decided that recordmcount should be an objtool subcommand, the
> code itself should probably stay under tools/objtool and then have different
> compilation configurations for objtool depending on the architecture (e.g.
> HAVE_OBJTOOL_CHECK, HAVE_OBJTOOL_ORC) or something of the sort.

Yeah. HAVE_C_RECORDMCOUNT is used in the Makefiles to select building
an running objtool mcount versus recordmcount.pl (which is another piece
that needs some attention -- my preference is to slowly move arch
support from there into recordmcount.c. So far it looks like s390 and mips
are the ones needing a little special attention there..)

My recollection is Josh wanted to avoid a bunch of architecture/config
checks in the code if I recall. It leaks into the code that implements the
subcommand tables, for example, and that's why I chose to use weak symbols --
we can unconditionally add the table entries and we don't need to play
linker script + macro games to build the array.

As for managing minor architectural variations in a single subcommand, either
those can use more weak symbols via arch/foo/subcmd.[ch] files or via explicit
checks in the code (see the arch, endian, and class switches in recordmcount.c
for the latter). If folks are OK with using weak symbols I'm curious what
preferences are on choosing when to use which method -- the RFC reflects
mine of course but I want to know what makes it more maintainable for
other folks.

Cheers,
     -Matt Helsley
