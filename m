Return-Path: <SRS0=RE5T=7A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6112CC433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 18:26:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 424B020657
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 18:26:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387874AbgERS0m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 May 2020 14:26:42 -0400
Received: from ex13-edg-ou-002.vmware.com ([208.91.0.190]:20732 "EHLO
        EX13-EDG-OU-002.vmware.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730445AbgERS0e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 14:26:34 -0400
Received: from sc9-mailhost2.vmware.com (10.113.161.72) by
 EX13-EDG-OU-002.vmware.com (10.113.208.156) with Microsoft SMTP Server id
 15.0.1156.6; Mon, 18 May 2020 11:26:32 -0700
Received: from localhost (unknown [10.200.192.41])
        by sc9-mailhost2.vmware.com (Postfix) with ESMTP id 8500FB2C85;
        Mon, 18 May 2020 14:26:33 -0400 (EDT)
Date:   Mon, 18 May 2020 11:26:33 -0700
From:   Matt Helsley <mhelsley@vmware.com>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
CC:     Julien Thierry <jthierry@redhat.com>,
        <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Miroslav Benes <mbenes@suse.cz>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [RFC][PATCH 4/5] objtool: Enable compilation of objtool for all
 architectures
Message-ID: <20200518182633.GL9040@rlwimi.vmware.com>
Mail-Followup-To: Matt Helsley <mhelsley@vmware.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Julien Thierry <jthierry@redhat.com>, linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Miroslav Benes <mbenes@suse.cz>,
        Steven Rostedt <rostedt@goodmis.org>
References: <cover.1588888003.git.mhelsley@vmware.com>
 <9f709ea2ae66cc03b3ff3329baa8f670ccd0e368.1588888003.git.mhelsley@vmware.com>
 <f9eedb02-54fe-fb96-fbcc-5f40f41e571a@redhat.com>
 <20200513155948.GI9040@rlwimi.vmware.com>
 <e369f0a9-30fc-5754-8cff-bf238ab0b716@redhat.com>
 <20200515205135.5pknexlld53oicu5@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20200515205135.5pknexlld53oicu5@treble>
Received-SPF: None (EX13-EDG-OU-002.vmware.com: mhelsley@vmware.com does not
 designate permitted sender hosts)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 15, 2020 at 03:51:35PM -0500, Josh Poimboeuf wrote:
> On Wed, May 13, 2020 at 05:55:31PM +0100, Julien Thierry wrote:
> > > > Since the stuff under arch/missing is only weak symbols to make up for
> > > > missing subcmd implementations, can we put everything in a file
> > > > subcmd_defaults.c (name up for debate!) that would be always be compiled an
> > > > linked. And some SUBCMD_XXX is set to "y", the corresponding object file
> > > > gets compiled and overrides the weak symbols from subcmd_defaults.c .
> > > 
> > > Hmm, I like keeping them separated along similar lines to the other
> > > code because it makes it easier to see the intended correspondence and
> > > likely will keep the files more readable / smaller. I could
> > > just move them out of arch/missing and into missing_check.c and so forth.
> > > 
> > > What do you think of that?
> > > 
> > 
> > I do prefer that to the introduction of an arch/missing.
> > 
> > Still, I'm not sure I see much benefit in splitting those small
> > implementations in separate files, but it's not a problem either. This seems
> > more a matter of taste rather than one approach working better than the
> > other. So it's more up to what the maintainer prefer! :)
> 
> For now I'd prefer getting rid of the 'missing' arch and just having a
> single top-level weak.c which has all the weak functions in it.  Keeps
> the clutter down :-)
> 
> Down the road, if the number of weak functions got out of hand then we
> could look at splitting them up into multiple files.

OK, I'll merge them all into weak.c

Thanks!

Cheers,
    -Matt Helsley
