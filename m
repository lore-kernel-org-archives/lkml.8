Return-Path: <SRS0=4xmc=56=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8D28C2BB1D
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 20:09:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BC75F2064A
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 20:09:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2505494AbgDNUJL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Apr 2020 16:09:11 -0400
Received: from ex13-edg-ou-001.vmware.com ([208.91.0.189]:14482 "EHLO
        EX13-EDG-OU-001.vmware.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2505445AbgDNUJL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 16:09:11 -0400
Received: from sc9-mailhost3.vmware.com (10.113.161.73) by
 EX13-EDG-OU-001.vmware.com (10.113.208.155) with Microsoft SMTP Server id
 15.0.1156.6; Tue, 14 Apr 2020 13:09:08 -0700
Received: from localhost (unknown [10.129.220.242])
        by sc9-mailhost3.vmware.com (Postfix) with ESMTP id 8678C40733;
        Tue, 14 Apr 2020 13:09:10 -0700 (PDT)
Date:   Tue, 14 Apr 2020 13:09:10 -0700
From:   Matt Helsley <mhelsley@vmware.com>
To:     Steven Rostedt <rostedt@goodmis.org>
CC:     Julien Thierry <jthierry@redhat.com>,
        <linux-kernel@vger.kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Miroslav Benes <mbenes@suse.cz>
Subject: Re: [RFC][PATCH 00/36] objtool: Make recordmcount a subcommand
Message-ID: <20200414200910.GB118458@rlwimi.vmware.com>
Mail-Followup-To: Matt Helsley <mhelsley@vmware.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Julien Thierry <jthierry@redhat.com>, linux-kernel@vger.kernel.org,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Miroslav Benes <mbenes@suse.cz>
References: <cover.1586468801.git.mhelsley@vmware.com>
 <3a3f70df-07b0-91d9-33e1-e997e72b0c5c@redhat.com>
 <20200414093506.7b91bbbb@gandalf.local.home>
 <064f41bd-0dfe-e875-df7c-214184c29fa7@redhat.com>
 <20200414115458.093e221b@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20200414115458.093e221b@gandalf.local.home>
Received-SPF: None (EX13-EDG-OU-001.vmware.com: mhelsley@vmware.com does not
 designate permitted sender hosts)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 14, 2020 at 11:54:58AM -0400, Steven Rostedt wrote:
> On Tue, 14 Apr 2020 15:17:39 +0100
> Julien Thierry <jthierry@redhat.com> wrote:
> 
> > > I was hoping to have objtool handle all the operations needed that required
> > > reading elf headers.
> > >   
> > 
> > That makes sense, however, having each operation as an objtool 
> > subcommand doesn't solve that issue, right? Each invocation of objtool 
> > will re-read the elf object.
> > 
> > I guess having all the relevant code in objtool as subcommand would be a 
> > first step towards that goal.
> 
> Exactly. I believe the goal (it's been a while since we discussed this),
> was that we could "batch" the sub commands into a single command. That way,
> the executable will be executed once per object file, load all the elf
> headers, than iterate over all the sub commands that we set on the command
> line.

Yup. The idea is it's somewhat like a pipe but instead of reloading the file
and re-creating the linked data structures each time, each sub command would
simply hand off the ELF section/symbol/relocation structures to the next tool.

If we look in scripts/Makefile.build for example we can see the rule_cc_o_c
definition, after producing the initial .o with the compiler, does:

	$(call cmd,gen_ksymdeps)
        $(call cmd,checkdoc)
        $(call cmd,objtool)
        $(call cmd,modversions_c)
        $(call cmd,record_mcount)

The latter 3 all deal with loading and walking the ELF file output
from the previous step. If we could merge that into a single "call" to
objtool then we can avoid the extra write-close-open-read cycles. I also
wonder if we could move "checkdoc" because then 4 tools in a row could
be relevant to convert (genksyms makes simple use of nm).

I also noticed that, for example, sorttable uses the same ELF code /
patterns as recordmcount -- like the double-include trick. Of course
it operates on a larger scale than per-object-file and so there might
only be code maintenance savings there...

Also, the follow-on is definitely more speculative -- these patches show
that things like recordmcount can be converted to share the same ELF code
as objtool. The benefits of chaining commands together, how easy/hard
that would be, etc. haven't been fully fleshed out. For instance, I was
only looking at "check" and "mcount" chained together.

But even aside from those changes, having all of the tools use the same
ELF code and keeping that ELF code in one place rather than copy-paste
it seems like it would be useful for maintenance.

Cheers,
    -Matt
