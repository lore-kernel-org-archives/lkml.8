Return-Path: <SRS0=2JZx=64=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCE2AC433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 21:09:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B375E20734
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 21:09:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728237AbgENVJv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 May 2020 17:09:51 -0400
Received: from ex13-edg-ou-002.vmware.com ([208.91.0.190]:44741 "EHLO
        EX13-EDG-OU-002.vmware.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728073AbgENVJo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 May 2020 17:09:44 -0400
Received: from sc9-mailhost2.vmware.com (10.113.161.72) by
 EX13-EDG-OU-002.vmware.com (10.113.208.156) with Microsoft SMTP Server id
 15.0.1156.6; Thu, 14 May 2020 14:09:39 -0700
Received: from localhost (unknown [10.200.192.41])
        by sc9-mailhost2.vmware.com (Postfix) with ESMTP id 3BC9EB23CF;
        Thu, 14 May 2020 17:09:43 -0400 (EDT)
Date:   Thu, 14 May 2020 14:09:42 -0700
From:   Matt Helsley <mhelsley@vmware.com>
To:     Julien Thierry <jthierry@redhat.com>
CC:     <linux-kernel@vger.kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Miroslav Benes <mbenes@suse.cz>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [RFC][PATCH 3/5] objtool: Add support for relocations without
 addends
Message-ID: <20200514210942.GK9040@rlwimi.vmware.com>
Mail-Followup-To: Matt Helsley <mhelsley@vmware.com>,
        Julien Thierry <jthierry@redhat.com>, linux-kernel@vger.kernel.org,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Miroslav Benes <mbenes@suse.cz>,
        Steven Rostedt <rostedt@goodmis.org>
References: <cover.1588888003.git.mhelsley@vmware.com>
 <17ee3f6f2a246008aaae70f92df24ae92fa0e21e.1588888003.git.mhelsley@vmware.com>
 <f79a3872-b9ad-a966-71fb-4451e0901281@redhat.com>
 <20200513162648.GJ9040@rlwimi.vmware.com>
 <61c35ce2-47b3-1f62-d4ec-da9984289c5d@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <61c35ce2-47b3-1f62-d4ec-da9984289c5d@redhat.com>
Received-SPF: None (EX13-EDG-OU-002.vmware.com: mhelsley@vmware.com does not
 designate permitted sender hosts)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 13, 2020 at 05:55:21PM +0100, Julien Thierry wrote:
> 
> 
> On 5/13/20 5:26 PM, Matt Helsley wrote:
> > On Tue, May 12, 2020 at 06:04:50PM +0100, Julien Thierry wrote:
> > > Hi Matt,
> > > 
> > > On 5/11/20 6:35 PM, Matt Helsley wrote:
> > > > Currently objtool only collects information about relocations with
> > > > addends. In recordmcount, which we are about to merge into objtool,
> > > > some supported architectures do not use rela relocations. Since
> > > > object files use one or the other the list can be reused.
> > > > 
> > > > Signed-off-by: Matt Helsley <mhelsley@vmware.com>
> > > > ---
> > > >    tools/objtool/elf.c | 55 ++++++++++++++++++++++++++++++++++++---------
> > > >    tools/objtool/elf.h |  5 ++++-

<snip>

> > I'm thinking it's simpler with fewer variables. I don't think
> > moving the cast into the switch cases makes it any clearer. It's also
> > odd because we'll keep re-initializing relas or rels to rel_buf each loop
> > iteration. Finally, this approach has the advantage that, when reviewing
> > the patch, it's clear that the original code handling RELA relocation entries
> > isn't changing -- you can see it's just shifting into one of the cases
> > (below).
> > 
> > Do you still prefer introducing rel_buf?
> 
> On a completely personal taste, yes. I do not like having two local
> variables in the same scope pointing at the same data but with an implied
> "you should only use one or the other under the right circumstances".
> 
> But my main concern was having an allocation of a certain size and then
> modifying the size (might have been valid if sizeof(GElf_Rel) <=
> sizeof(GElf_Rela), but I must admit I did not bother to check). Since you've
> addressed that issue, the rest is just a matter of taste so better left to
> the maintainers.

OK. As a sort of tie-breaker I tried to quickly find an analogous piece of code
in objtool which I could use as a guide on maintainer preference. The
only place I see void pointers being used is as keys for comparison
functions. So my guess and preference is to not use a void pointer here.

Cheers,
	-Matt Helsley
