Return-Path: <SRS0=eifh=6G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C6AEC54FCB
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 17:00:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 609DE20776
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 17:00:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726604AbgDVRAt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Apr 2020 13:00:49 -0400
Received: from ex13-edg-ou-002.vmware.com ([208.91.0.190]:33771 "EHLO
        EX13-EDG-OU-002.vmware.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726381AbgDVRAt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Apr 2020 13:00:49 -0400
Received: from sc9-mailhost2.vmware.com (10.113.161.72) by
 EX13-EDG-OU-002.vmware.com (10.113.208.156) with Microsoft SMTP Server id
 15.0.1156.6; Wed, 22 Apr 2020 10:00:45 -0700
Received: from localhost (unknown [10.129.220.242])
        by sc9-mailhost2.vmware.com (Postfix) with ESMTP id 82C10B24B6;
        Wed, 22 Apr 2020 13:00:48 -0400 (EDT)
Date:   Wed, 22 Apr 2020 10:00:48 -0700
From:   Matt Helsley <mhelsley@vmware.com>
To:     Ingo Molnar <mingo@kernel.org>
CC:     Peter Zijlstra <peterz@infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Sami Tolvanen <samitolvanen@google.com>,
        Borislav Petkov <bp@alien8.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 2/3] objtool: Rename elf_read() to elf_open_read()
Message-ID: <20200422170048.GA9040@rlwimi.vmware.com>
Mail-Followup-To: Matt Helsley <mhelsley@vmware.com>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Sami Tolvanen <samitolvanen@google.com>,
        Borislav Petkov <bp@alien8.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>
References: <20200422103205.61900-1-mingo@kernel.org>
 <20200422103205.61900-3-mingo@kernel.org>
 <20200422114342.GD20730@hirez.programming.kicks-ass.net>
 <20200422142235.GA2840@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20200422142235.GA2840@gmail.com>
Received-SPF: None (EX13-EDG-OU-002.vmware.com: mhelsley@vmware.com does not
 designate permitted sender hosts)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 22, 2020 at 04:22:35PM +0200, Ingo Molnar wrote:
> 
> * Peter Zijlstra <peterz@infradead.org> wrote:
> 
> > On Wed, Apr 22, 2020 at 12:32:04PM +0200, Ingo Molnar wrote:
> > > 'struct elf *' handling is an open/close paradigm, make sure the naming
> > > matches that:
> > > 
> > >    elf_open_read()
> > >    elf_write()
> > >    elf_close()
> > 
> > 
> > > diff --git a/tools/objtool/check.c b/tools/objtool/check.c
> > > index f2a84271e807..12e2aea42bb2 100644
> > > --- a/tools/objtool/check.c
> > > +++ b/tools/objtool/check.c
> > > @@ -2614,7 +2614,7 @@ int check(const char *_objname, bool orc)
> > >  
> > >  	objname = _objname;
> > >  
> > > -	file.elf = elf_read(objname, orc ? O_RDWR : O_RDONLY);
> > > +	file.elf = elf_open_read(objname, orc ? O_RDWR : O_RDONLY);
> > 
> > Note that I have a patch pending that makes that unconditionally O_RDWR,
> > which sort of seems to suggest elf_open() might be the better name.
> 
> Ok, done!

It might be a better name but there could be a problem with it --
see 8e144797f1a67c52e386161863da4614a23ad913
"objtool: Rename elf_open() to prevent conflict with libelf from elftoolchain"

Unless I'm forgetting something I think that'd still be an issue.

Cheers,
	-Matt
