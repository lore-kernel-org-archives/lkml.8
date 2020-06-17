Return-Path: <SRS0=qsSF=76=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88C97C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 18:30:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 67F3F207DD
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 18:30:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ToCAXlwR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727088AbgFQSah (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jun 2020 14:30:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726926AbgFQSah (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 14:30:37 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07AB5C06174E
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jun 2020 11:30:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:To:From:Date:Sender:Reply-To:Cc:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=mWV/ehJBteo+neCD6z8R4hBaZQVGIg/ML84amSjhcfw=; b=ToCAXlwRDz315hQ8b0dVU9BCHN
        CqCjYBARwV46yxTn+BTDhVkZ7zBfzlmTDRki5atq+qOX8wbXF2siGD20pYQmXl/cjYxqSrUW0YS3v
        1qrUMpyPIlM3D1nVF6qzD3+iUwib6liHt6p6jLcgiP9EovYN1lmS2A4x4VLrjVRpAGRCzEqJkYGtt
        j4BEcmQqbCBnasAkxNkm4sDUzpgCKt88MlCqWZWFfhGmdb/Zq+kxq0+qvj2yzm/RfMoOaR+e8Nar+
        JJJPmW8VIL23qa918G5aUkLi/LG2NuBa3wFkpQQ2AiCKqBp/utep8E8Kvxq7GojCocZhHN5BY7dBG
        Ai+IJnVQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jlcpE-0004dy-5N; Wed, 17 Jun 2020 18:30:16 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 0B4DA300238;
        Wed, 17 Jun 2020 20:30:13 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id B904C2147B45E; Wed, 17 Jun 2020 20:30:13 +0200 (CEST)
Date:   Wed, 17 Jun 2020 20:30:13 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Matt Helsley <mhelsley@vmware.com>, linux-kernel@vger.kernel.org,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Julien Thierry <jthierry@redhat.com>,
        Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>
Subject: Re: [RFC][PATCH v4 18/32] objtool: mcount: Move nop_mcount()
Message-ID: <20200617183013.GD576905@hirez.programming.kicks-ass.net>
References: <cover.1591125127.git.mhelsley@vmware.com>
 <7109ceb239a88c2901eeb7f52c29f69cdb413cd3.1591125127.git.mhelsley@vmware.com>
 <20200612132656.GQ2531@hirez.programming.kicks-ass.net>
 <20200612160534.GD2554@hirez.programming.kicks-ass.net>
 <20200617173620.GA89648@rlwimi.vmware.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200617173620.GA89648@rlwimi.vmware.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 17, 2020 at 10:36:20AM -0700, Matt Helsley wrote:
> On Fri, Jun 12, 2020 at 06:05:34PM +0200, Peter Zijlstra wrote:

> > On top of that, I suppose we can do something like the below.
> > 
> > Then you can simply write:
> > 
> > 	if (reloc->sym->class == SYM_MCOUNT && ..)
> 
> This looks like a good way to move towards a "single pass" through the ELF data
> for mcount.
> 
> What order do you want to see this patch go in? Before this series (i.e. perhaps
> just a kcov SYM_ class to start)? Early or late in this series? After?
> 
> Right now I'm thinking of putting this on the end of my series because
> I'm focusing on converting recordmcount in the series and this isn't
> strictly necessary but is definitely nicer.

No particular thoughts about where, so at the end would be fine.


> > ---
> > 
> > diff --git a/kernel/locking/Makefile b/kernel/locking/Makefile
> > index 45452facff3b..94e4b8fcf9c1 100644
> > --- a/kernel/locking/Makefile
> > +++ b/kernel/locking/Makefile
> > @@ -1,7 +1,7 @@
> >  # SPDX-License-Identifier: GPL-2.0
> >  # Any varying coverage in these files is non-deterministic
> >  # and is generally not a function of system call inputs.
> > -KCOV_INSTRUMENT		:= n
> > +# KCOV_INSTRUMENT		:= n
> >  
> >  obj-y += mutex.o semaphore.o rwsem.o percpu-rwsem.o
> >  
> > diff --git a/tools/objtool/elf.c b/tools/objtool/elf.c
> > index 432417a83902..133c0c285be6 100644
> > --- a/tools/objtool/elf.c
> > +++ b/tools/objtool/elf.c
> > @@ -341,6 +341,24 @@ static int read_sections(struct elf *elf)
> >  	return 0;
> >  }
> >  
> > +static bool is_mcount_symbol(const char *name)
> > +{
> > +	if (name[0] == '.')
> > +		name++;
> > +
> > +	if (name[0] == '_')
> > +		name++;
> > +
> > +	return !strcmp(name, "mcount", 6) ||
> 
> Looks like you intended this to be a strncmp() but I don't see a reason to
> use strncmp(). Am I missing something?

typing hard :-)

> > +	       !strcmp(name, "_fentry__") ||
> > +	       !strcmp(name, "_gnu_mcount_nc");
> > +}
> 
> This mashes all of the arch-specific mcount name checks together. I
> don't see a problem with that because I doubt there will be a collision
> with other functions. 

This, I assumed it would just work.

> Just to be careful I looked through the Clang and
> GCC sources, though I only dug through the history of Clang's output --
> GCC's history with respect to mcount symbol names across architectures is
> much harder to trace so I only looked at the current sources.

Fair enough; thanks for the due-dilligence.

