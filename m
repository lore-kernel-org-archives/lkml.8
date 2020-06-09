Return-Path: <SRS0=F/Af=7W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE3ADC433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 18:39:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9FCE120691
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 18:39:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730049AbgFISjx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jun 2020 14:39:53 -0400
Received: from ex13-edg-ou-002.vmware.com ([208.91.0.190]:56545 "EHLO
        EX13-EDG-OU-002.vmware.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728470AbgFISjw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jun 2020 14:39:52 -0400
Received: from sc9-mailhost2.vmware.com (10.113.161.72) by
 EX13-EDG-OU-002.vmware.com (10.113.208.156) with Microsoft SMTP Server id
 15.0.1156.6; Tue, 9 Jun 2020 11:39:49 -0700
Received: from localhost (unknown [10.166.65.245])
        by sc9-mailhost2.vmware.com (Postfix) with ESMTP id BC1DDB2985;
        Tue,  9 Jun 2020 14:39:51 -0400 (EDT)
Date:   Tue, 9 Jun 2020 11:39:51 -0700
From:   Matt Helsley <mhelsley@vmware.com>
To:     Julien Thierry <jthierry@redhat.com>
CC:     <linux-kernel@vger.kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>
Subject: Re: [RFC][PATCH v4 02/32] objtool: Make recordmcount into mcount
 subcmd
Message-ID: <20200609183951.GE1284251@rlwimi.vmware.com>
Mail-Followup-To: Matt Helsley <mhelsley@vmware.com>,
        Julien Thierry <jthierry@redhat.com>, linux-kernel@vger.kernel.org,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>
References: <cover.1591125127.git.mhelsley@vmware.com>
 <0d44e0b1b8ebce4af8b90f73e351a003ef016005.1591125127.git.mhelsley@vmware.com>
 <fe3e0e4e-4f13-5193-c684-f995c8310e54@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <fe3e0e4e-4f13-5193-c684-f995c8310e54@redhat.com>
Received-SPF: None (EX13-EDG-OU-002.vmware.com: mhelsley@vmware.com does not
 designate permitted sender hosts)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 09, 2020 at 10:00:59AM +0100, Julien Thierry wrote:
> Hi Matt,
> 
> On 6/2/20 8:49 PM, Matt Helsley wrote:
> > Rather than a standalone executable merge recordmcount as a sub command
> > of objtool. This is a small step towards cleaning up recordmcount and
> > eventually sharing  ELF code with objtool.
> > 
> > For the initial step all that's required is a bit of Makefile changes
> > and invoking the former main() function from recordmcount.c because the
> > subcommand code uses similar function arguments as main when dispatching.
> > 
> > objtool ignores some object files that tracing does not, specifically
> > those with OBJECT_FILES_NON_STANDARD Makefile variables. For this reason
> > we keep the recordmcount_dep separate from the objtool_dep. When using
> > objtool mcount we can also, like the other objtool invocations, just
> > depend on the binary rather than the source the binary is built from.
> > 
> > Subsequent patches will gradually convert recordmcount to use
> > more and more of libelf/objtool's ELF accessor code. This will both
> > clean up recordmcount to be more easily readable and remove
> > recordmcount's crude accessor wrapping code.
> > 
> > Signed-off-by: Matt Helsley <mhelsley@vmware.com>
> > ---
...
> > diff --git a/kernel/trace/Kconfig b/kernel/trace/Kconfig
> > index 743647005f64..ae74647b06fa 100644
> > --- a/kernel/trace/Kconfig
> > +++ b/kernel/trace/Kconfig
> > @@ -59,7 +59,7 @@ config HAVE_NOP_MCOUNT
> >   config HAVE_C_RECORDMCOUNT
> >   	bool
> >   	help
> > -	  C version of recordmcount available?
> > +	  C version of objtool mcount available?
> 
> The "C version" doesn't make much sense here. "Objtool mcount available?" or
> "mcount subcommand of objtool available?" perhaps?

Agreed, "C version" is nonsense at this point.

Looking at the other HAVE_* help messages in that Kconfig suggests:

	Arch supports objtool mcount subcommand

So I've changed it to that.

> > diff --git a/tools/objtool/Makefile b/tools/objtool/Makefile
> > index 285474a77fe9..ffef73f7f47e 100644
> > --- a/tools/objtool/Makefile
> > +++ b/tools/objtool/Makefile
> > @@ -31,12 +31,6 @@ OBJTOOL_IN := $(OBJTOOL)-in.o
> >   LIBELF_FLAGS := $(shell pkg-config libelf --cflags 2>/dev/null)
> >   LIBELF_LIBS  := $(shell pkg-config libelf --libs 2>/dev/null || echo -lelf)
> > -RECORDMCOUNT := $(OUTPUT)recordmcount
> > -RECORDMCOUNT_IN := $(RECORDMCOUNT)-in.o
> > -ifeq ($(BUILD_C_RECORDMCOUNT),y)
> > -all:  $(RECORDMCOUNT)
> > -endif
> > -
> >   all: $(OBJTOOL)
> >   INCLUDES := -I$(srctree)/tools/include \
> > @@ -55,13 +49,47 @@ AWK = awk
> >   SUBCMD_CHECK := n
> >   SUBCMD_ORC := n
> > +SUBCMD_MCOUNT := n
> >   ifeq ($(SRCARCH),x86)
> >   	SUBCMD_CHECK := y
> >   	SUBCMD_ORC := y
> > +	SUBCMD_MCOUNT := y
> > +endif
> > +
> > +ifeq ($(SRCARCH),arm)
> > +	SUBCMD_MCOUNT := y
> > +endif
> > +
> > +ifeq ($(SRCARCH),arm64)
> > +	SUBCMD_MCOUNT := y
> > +endif
> > +
> > +ifeq ($(SRCARCH),ia64)
> > +	SUBCMD_MCOUNT := y
> > +endif
> > +
> > +ifeq ($(SRCARCH),mips)
> > +	SUBCMD_MCOUNT := y
> > +endif
> > +
> > +ifeq ($(SRCARCH),powerpc)
> > +	SUBCMD_MCOUNT := y
> > +endif
> > +
> > +ifeq ($(SRCARCH),s390)
> > +	SUBCMD_MCOUNT := y
> > +endif
> > +
> > +ifeq ($(SRCARCH),sh)
> > +	SUBCMD_MCOUNT := y
> > +endif
> > +
> > +ifeq ($(SRCARCH),sparc)
> > +	SUBCMD_MCOUNT := y
> 
> Is there some arch for which MCOUNT is not supported? If not you could just
> have MCOUNT default to 'y' and avoid adding all those tests (or maybe reduce
> the numbers and set to 'n' only for arches not supporting it).

Yes, there are some which it does not support. For those architectures
we keep recordmcount.pl around.

It occured to me that with your suggestion to use more CONFIG_ variables
we could eliminate this pattern and replace it with these pseudo-patches:

+++ b/kernel/trace/Kconfig

+config OBJTOOL_SUBCMD_MCOUNT
+	bool
+	depends on HAVE_C_RECORDMCOUNT
+	select OBJTOOL_SUBCMDS
+	help
+	  Record mcount call locations using objtool

and then change the Makefiles to use the CONFIG_ variables
rather than have one ifeq block per arch:

+++ b/tools/objtool/Makefile

+SUBCMD_MCOUNT := $(CONFIG_OBJTOOL_SUBCMD_MCOUNT)

Does this seem like a good use of CONFIG_ variables or is it going too
far?

I haven't changed to this pattern just yet -- I'm hoping you and Josh
or Peter might weigh in with your preferences.

> 
> >   endif
> > -export SUBCMD_CHECK SUBCMD_ORC
> > +export SUBCMD_CHECK SUBCMD_ORC SUBCMD_MCOUNT

...

> > diff --git a/tools/objtool/builtin.h b/tools/objtool/builtin.h
> > index 85c979caa367..9c7331592fa7 100644
> > --- a/tools/objtool/builtin.h
> > +++ b/tools/objtool/builtin.h
> > @@ -12,5 +12,7 @@ extern bool no_fp, no_unreachable, retpoline, module, backtrace, uaccess, stats,
> >   extern int cmd_check(int argc, const char **argv);
> >   extern int cmd_orc(int argc, const char **argv);
> > +extern bool is_cmd_mcount_available(void);
> 
> This appears to be unused.

Indeed, removed.

Thanks!

Cheers,
	-Matt Helsley
