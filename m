Return-Path: <SRS0=F/Af=7W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41F76C433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 15:42:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 23E2C207C3
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 15:42:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730900AbgFIPmY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jun 2020 11:42:24 -0400
Received: from ex13-edg-ou-001.vmware.com ([208.91.0.189]:31243 "EHLO
        EX13-EDG-OU-001.vmware.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730838AbgFIPmW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jun 2020 11:42:22 -0400
Received: from sc9-mailhost3.vmware.com (10.113.161.73) by
 EX13-EDG-OU-001.vmware.com (10.113.208.155) with Microsoft SMTP Server id
 15.0.1156.6; Tue, 9 Jun 2020 08:42:19 -0700
Received: from localhost (unknown [10.166.65.245])
        by sc9-mailhost3.vmware.com (Postfix) with ESMTP id 721A940884;
        Tue,  9 Jun 2020 08:42:21 -0700 (PDT)
Date:   Tue, 9 Jun 2020 08:42:21 -0700
From:   Matt Helsley <mhelsley@vmware.com>
To:     Julien Thierry <jthierry@redhat.com>
CC:     <linux-kernel@vger.kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>
Subject: Re: [RFC][PATCH v4 01/32] objtool: Prepare to merge recordmcount
Message-ID: <20200609154221.GC1284251@rlwimi.vmware.com>
Mail-Followup-To: Matt Helsley <mhelsley@vmware.com>,
        Julien Thierry <jthierry@redhat.com>, linux-kernel@vger.kernel.org,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>
References: <cover.1591125127.git.mhelsley@vmware.com>
 <4a71852d8ca0a245588159a6bbdc064619de91d9.1591125127.git.mhelsley@vmware.com>
 <1e2783f2-6b52-d750-ecc5-4e3d6d7dba4f@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1e2783f2-6b52-d750-ecc5-4e3d6d7dba4f@redhat.com>
Received-SPF: None (EX13-EDG-OU-001.vmware.com: mhelsley@vmware.com does not
 designate permitted sender hosts)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 09, 2020 at 09:54:33AM +0100, Julien Thierry wrote:
> Hi Matt,
> 
> On 6/2/20 8:49 PM, Matt Helsley wrote:
> > Move recordmcount into the objtool directory. We keep this step separate
> > so changes which turn recordmcount into a subcommand of objtool don't
> > get obscured.
> > 
> > Signed-off-by: Matt Helsley <mhelsley@vmware.com>

<snip>

> > diff --git a/Makefile b/Makefile
> > index 04f5662ae61a..d353a0a65a71 100644
> > --- a/Makefile
> > +++ b/Makefile
> > @@ -844,6 +844,7 @@ ifdef CONFIG_DYNAMIC_FTRACE
> >   	ifdef CONFIG_HAVE_C_RECORDMCOUNT
> >   		BUILD_C_RECORDMCOUNT := y
> >   		export BUILD_C_RECORDMCOUNT
> > +		objtool_target := tools/objtool FORCE
> >   	endif
> >   endif
> >   endif
> > @@ -1023,10 +1024,10 @@ endif
> >   export mod_sign_cmd
> >   HOST_LIBELF_LIBS = $(shell pkg-config libelf --libs 2>/dev/null || echo -lelf)
> > +has_libelf := $(call try-run,\
> > +		echo "int main() {}" | $(HOSTCC) -xc -o /dev/null $(HOST_LIBELF_LIBS) -,1,0)
> 
> Maybe there could be some build dependency, e.g. CONFIG_OBJTOOL_SUBCMDS that
> sets the "objtool_target" and "has_libelf" when selected.
> 
> Then the CONFIG_UNWINDER_ORC, RECORD_MCOUNT and STACK_VALIDATION would just
> had to select that config option.

That might save a good amount of control flow in the Makefiles.

We could take it one step further and have specific CONFIG_OBJTOOL_<subcmd>
which might help us remove the per-architecture control-flow in
the multi-arch subcmd support found in tools/objtool/Makefile.

What do folks think of that -- too far?

> 
> >   ifdef CONFIG_STACK_VALIDATION
> > -  has_libelf := $(call try-run,\
> > -		echo "int main() {}" | $(HOSTCC) -xc -o /dev/null $(HOST_LIBELF_LIBS) -,1,0)
> >     ifeq ($(has_libelf),1)
> >       objtool_target := tools/objtool FORCE
> >     else
> > @@ -1163,13 +1164,15 @@ uapi-asm-generic:
> >   PHONY += prepare-objtool
> >   prepare-objtool: $(objtool_target)
> > -ifeq ($(SKIP_STACK_VALIDATION),1)
> > -ifdef CONFIG_UNWINDER_ORC
> > +ifneq ($(has_libelf),1)
> > +  ifdef CONFIG_UNWINDER_ORC
> >   	@echo "error: Cannot generate ORC metadata for CONFIG_UNWINDER_ORC=y, please install libelf-dev, libelf-devel or elfutils-libelf-devel" >&2
> >   	@false
> > -else
> > +  else
> > +    ifeq ($(SKIP_STACK_VALIDATION),1)
> >   	@echo "warning: Cannot use CONFIG_STACK_VALIDATION=y, please install libelf-dev, libelf-devel or elfutils-libelf-devel" >&2
> 
> 
> I think this would be more readable without the else branch:
> 
> 	ifneq ($(has_libelf),1)
> 		ifdef <some objtool command config>
> 			<warn about unavailability>

Note: error not warn

> 		endif
> 		ifdef <another objtool command config>
> 			<warn ...>
> 		endif
> 		<...>
> 	endif

I think the next patch, which makes recordmcount a subcmd, makes it a
little clearer what the pattern is because it adds another ifdef block
in the way you suggest.

As for the else around the SKIP_STACK_VALIDATION check -- it is special
in a couple ways -- at least as best I can tell.

It's not a CONFIG_* -- it actually breaks the normal pattern with
CONFIG_* in that..

It's about a judgement call that it's OK to merely warn and skip the
stack validation rather than produce an error. The other, CONFIG_*
blocks produce errors.

These two reasons are why I think it makes sense to keep the logic
distinct with the "else".

Cheers,
	-Matt Helsley
