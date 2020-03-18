Return-Path: <SRS0=Fjb+=5D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE050C10DCE
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 10:06:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9783020768
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 10:06:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="PmkRSXY6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727451AbgCRKGJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Mar 2020 06:06:09 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:53082 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726310AbgCRKGJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Mar 2020 06:06:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Transfer-Encoding
        :Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=oeX/U7LNtTyv34aedyCBCFenLXcS/Ck0VLdrkWlIrOc=; b=PmkRSXY61j+9pWhknleICVd7mB
        OjIOnzdjoJP+CTsBkAwM/caLiAMTRw6ye2t6+rQVNvuT5M6rifUc3hxf1+SkGhxWKkZ7mfDFlGCiK
        Ced1mI8ebnQ0fIQbHZ8k3aRcR/LSRaZyfIhLgIsnrDsnpzIqW4bZQgEi+WWKfcE1166GDK8CeWehc
        nyEmniz5Lb4gx6WfeKbgVs9Mqd47GYFBlAZ2sI5CFMAV3Xywk20d0hlXPSyiHtlaGu4LR6pnIlLWC
        309c3bFhFSAOCZx/ZuNKgrfFUmf1/dxlWxoqcjReoIojC2FQQna54F8ImaB9vuJgFAEwh+VlZYACx
        4zV6SIXA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jEVaN-0002aO-89; Wed, 18 Mar 2020 10:06:03 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 9765030047A;
        Wed, 18 Mar 2020 11:06:00 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 811FC20C4A223; Wed, 18 Mar 2020 11:06:00 +0100 (CET)
Date:   Wed, 18 Mar 2020 11:06:00 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     tglx@linutronix.de, linux-kernel@vger.kernel.org, x86@kernel.org,
        mhiramat@kernel.org, mbenes@suse.cz, brgerst@gmail.com
Subject: Re: [PATCH v2 16/19] objtool: Implement noinstr validation
Message-ID: <20200318100600.GD20730@hirez.programming.kicks-ass.net>
References: <20200317170234.897520633@infradead.org>
 <20200317170910.730949374@infradead.org>
 <20200317210008.bda4c542b5lu7juf@treble>
 <20200318090309.GC20730@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200318090309.GC20730@hirez.programming.kicks-ass.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 18, 2020 at 10:03:09AM +0100, Peter Zijlstra wrote:
> On Tue, Mar 17, 2020 at 04:00:08PM -0500, Josh Poimboeuf wrote:
> > On Tue, Mar 17, 2020 at 06:02:50PM +0100, Peter Zijlstra wrote:

> > > @@ -46,5 +49,9 @@ int cmd_check(int argc, const char **arg
> > >  
> > >  	objname = argv[0];
> > >  
> > > +	s = strstr(objname, "vmlinux.o");
> > > +	if (s && !s[9])
> > > +		vmlinux = true;
> > > +
> > 
> > I think this would be slightly cleaner:
> > 
> > 	if (!strcmp(basename(objname), "vmlinux.o"))
> > 		vmlinux = true;
> 
> Ah, indeed. I totally forgot userspace coding it seems..

Of course that doesn't compile... someone went overboard with const.

For some obscure reason, the stupid thing even thinks that:

  note: expected ‘const char **’ but argument is of type ‘char **’

is a warning and then -Werror's on it. That's bloody insane.


