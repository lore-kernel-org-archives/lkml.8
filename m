Return-Path: <SRS0=Fjb+=5D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B623EC5ACD6
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 09:03:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7AFC620771
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 09:03:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="XB9nx06C"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727519AbgCRJDQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Mar 2020 05:03:16 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:35932 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726523AbgCRJDP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Mar 2020 05:03:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=rqHuFXYHG+0M6MgARbEa/w5Vs+vN7XFOaRX7Vm8ilXk=; b=XB9nx06CTV5SxYAZuoaTTUX8pP
        ytgSNwTJZlEUABVFJyr7mAe9GBpQDuwg0VDdOpMDpoklqYBTyh4Ck6T2scTpOK9kLlcMJGEU97V13
        Ab7MmTT1mnNkI+BHLLAxMCkG7VIgAZ+v7Z4SeWFkCI2kgouKuPIT92f8V0uludoKZyHXPafsn/a0K
        6bMQRjUs6homzAZWR682zanDSf7c2yKdHTfgTXGKuFonL2etqRGk27qQp9v7Q7S2qzpHDPlAJs6BG
        g2axSVuYPu1BR1qhPbL7S83cQbv4Pex/fmHNu1mP2Ilx37eGZyiDPnhOtqEj1kTvoTEIAlKrIkjj6
        ZW9uRX2w==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jEUbY-00048g-In; Wed, 18 Mar 2020 09:03:12 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 8C12A3010C2;
        Wed, 18 Mar 2020 10:03:09 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 789BC28563D6F; Wed, 18 Mar 2020 10:03:09 +0100 (CET)
Date:   Wed, 18 Mar 2020 10:03:09 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     tglx@linutronix.de, linux-kernel@vger.kernel.org, x86@kernel.org,
        mhiramat@kernel.org, mbenes@suse.cz, brgerst@gmail.com
Subject: Re: [PATCH v2 16/19] objtool: Implement noinstr validation
Message-ID: <20200318090309.GC20730@hirez.programming.kicks-ass.net>
References: <20200317170234.897520633@infradead.org>
 <20200317170910.730949374@infradead.org>
 <20200317210008.bda4c542b5lu7juf@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200317210008.bda4c542b5lu7juf@treble>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 17, 2020 at 04:00:08PM -0500, Josh Poimboeuf wrote:
> On Tue, Mar 17, 2020 at 06:02:50PM +0100, Peter Zijlstra wrote:
> > Validate that any call out of .noinstr.text is in between
> > instr_begin() and instr_end() annotations.
> > 
> > This annotation is useful to ensure correct behaviour wrt tracing
> > sensitive code like entry/exit and idle code. When we run code in a
> > sensitive context we want a guarantee no unknown code is ran.
> > 
> > Since this validation relies on knowing the section of call
> > destination symbols, we must run it on vmlinux.o instead of on
> > individual object files.
> > 
> > Add two options:
> > 
> >  -d/--duplicate "duplicate validation for vmlinux"
> >  -l/--vmlinux "vmlinux.o validation"
> 
> I'm not sure I see the point of the --vmlinux option, when it will be
> autodetected anyway?

Ah, I sometimes do stuff like:

 cp vmlinux.o vmlinux.o.orig
 quilt push; make -j$lots
 cp vmlinux.o vmlinux.o.1
 quilt push; make -j$lots
 ...

And then it is nice to force the mode.

> > @@ -46,5 +49,9 @@ int cmd_check(int argc, const char **arg
> >  
> >  	objname = argv[0];
> >  
> > +	s = strstr(objname, "vmlinux.o");
> > +	if (s && !s[9])
> > +		vmlinux = true;
> > +
> 
> I think this would be slightly cleaner:
> 
> 	if (!strcmp(basename(objname), "vmlinux.o"))
> 		vmlinux = true;

Ah, indeed. I totally forgot userspace coding it seems..
