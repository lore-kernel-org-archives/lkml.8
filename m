Return-Path: <SRS0=vy7l=5K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF1D4C54FCF
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 16:50:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B7EEC20740
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 16:50:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="adSrmU5E"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727794AbgCYQu6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Mar 2020 12:50:58 -0400
Received: from merlin.infradead.org ([205.233.59.134]:53548 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727357AbgCYQu6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Mar 2020 12:50:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=s7ImFkVNzd0EVebzyqYWogl6KMDAeW152fkisQem/34=; b=adSrmU5EieOTos2teFmSTYPrUe
        dVFksML2LS5o4ZTBtjE83p4dvcmSydcNY12P8B7YU7+eNqX3aDHgxPac23YFQzKTNK296nnp3zGY2
        nwrtCCZ5EFLotBZfWPX0GMinEfBfD/GqNBWFO5bUAiB3ACQTmmR5fMs8P8+8IHDUMd12TniM258TO
        A8d9+7ZIIeTf6/VmYHnMv5L0ncvOR14S0djRM2Lsg7NzvaaJC93aD4toMDqVejyTkA5mFYXr5mxvX
        UuuFBo848h7U90EFUopT3XTEgeL+dKF9Q0MFIv5OxuMeSpj6GSM2qfCQmjhh19phRZWwfwUKQCnaR
        p5GJa82w==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jH9Ey-0002hx-Tk; Wed, 25 Mar 2020 16:50:53 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 3A1373011DE;
        Wed, 25 Mar 2020 17:50:50 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 2481529A7FAFE; Wed, 25 Mar 2020 17:50:50 +0100 (CET)
Date:   Wed, 25 Mar 2020 17:50:50 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     tglx@linutronix.de, linux-kernel@vger.kernel.org, x86@kernel.org,
        mhiramat@kernel.org, mbenes@suse.cz, brgerst@gmail.com,
        jthierry@redhat.com
Subject: Re: [PATCH v3 26/26] objtool: Add STT_NOTYPE noinstr validation
Message-ID: <20200325165050.GC20696@hirez.programming.kicks-ass.net>
References: <20200324153113.098167666@infradead.org>
 <20200324160925.470421121@infradead.org>
 <20200324221616.2tdljgyay37aiw2t@treble>
 <20200324223455.GV2452@worktop.programming.kicks-ass.net>
 <20200325144211.irnwnly37fyhapvx@treble>
 <20200325155348.GA20696@hirez.programming.kicks-ass.net>
 <20200325164046.p2oxemcjnj2tnxbz@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200325164046.p2oxemcjnj2tnxbz@treble>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 25, 2020 at 11:40:46AM -0500, Josh Poimboeuf wrote:
> On Wed, Mar 25, 2020 at 04:53:48PM +0100, Peter Zijlstra wrote:
> > On Wed, Mar 25, 2020 at 09:42:11AM -0500, Josh Poimboeuf wrote:
> > > Sure, but couldn't validate_unwind_hints() and
> > > validate_reachable_instructions() be changed to *only* run on
> > > .noinstr.text, for the vmlinux case?  That might help converge the
> > > vmlinux and !vmlinux paths.
> > 
> > You're thinking something like so then?
> 
> Not exactly.  But I don't want to keep churning this patch set.  I can
> add more patches later, so don't worry about it.
> 
> But I was thinking it would eventually be good to have the top-level
> check() be like
> 
> 	sec = NULL;
> 	if (!validate_all)
> 		sec = find_section_by_name(file->elf, ".noinstr.text");
> 
> 	ret = validate_functions(&file, sec);
> 	if (ret < 0)
> 		goto out;
> 	warnings += ret;
> 
> 	ret = validate_unwind_hints(&file, sec);
> 	if (ret < 0)
> 		goto out;
> 	warnings += ret;
> 
> 	if (!warnings) {
> 		ret = validate_reachable_instructions(&file, sec);
> 		if (ret < 0)
> 			goto out;
> 		warnings += ret;
> 	}
> 
> 	if (!validate_all)
> 		goto out;
> 
> 	ret = validate_retpoline(&file);
> 	....
> 
> that way the general flow is the same regardless...

Ah,... I see what you mean, there's two little wrinkles with that:

 - validate_reachable_instructions() is strictly superluous, it does no
   additional validation between the !vmlinux and vmlinux mode, so I'd
   put that if (!validate_all) goto out, one up.

 - tglx has a patch adding .entry.text to be considered as noinstr as a
   whole, which has:


@@ -2636,11 +2637,16 @@ static int validate_vmlinux_functions(st
 	int warnings = 0;
 
 	sec = find_section_by_name(file->elf, ".noinstr.text");
-	if (!sec)
-		return 0;
+	if (sec) {
+		warnings += validate_section(file, sec);
+		warnings += validate_unwind_hints(file, sec);
+	}
 
-	warnings += validate_section(file, sec);
-	warnings += validate_unwind_hints(file, sec);
+	sec = find_section_by_name(file->elf, ".entry.text");
+	if (sec) {
+		warnings += validate_section(file, sec);
+		warnings += validate_unwind_hints(file, sec);
+	}
 
 	return warnings;
 }

Anyway, yes, we can do this on top.

I was going to commit the first 17 patches to tip/core/objtool and
repost the remaining 13 once more. And then see how much pain I did to
Julien's patches :-)
