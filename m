Return-Path: <SRS0=dgGg=75=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C743C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 19:27:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4C8882080D
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 19:27:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="bU5YqNKQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730857AbgFPT16 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jun 2020 15:27:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730269AbgFPT15 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 15:27:57 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3EF5C061573;
        Tue, 16 Jun 2020 12:27:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=1/p6M4udphfZorluJv8PAtxh9mkG4Cd1rD6oV0dK7MY=; b=bU5YqNKQASuxGfFaC2YHt0Kk6o
        P4KjjAF4sgy1oQqQzcHyV6Pw88GWxBsSn6BdsJPXK2ciDyVslB33Zw0vgz61iS6OXwuBmrFg2aL2u
        L7+pTuOctqwSpXiZ8kj8UHA6H99XHzmy8g9hipIcsQLChh0/6X1AcqRZCsDBWudn2CAOB4Biu5sKG
        SRadq65iloF9GEk4GD/6Ge7eEQbkHxlH9DNktC++xVHZeV23+rFuvTJR/D7Kl07LpP7eoC9u2cfiW
        754l6A5XFvnAHgUoyMcsH3RzZZXtCguKJ70MkCCCpnnHV0qmrHLYPJUhp/EbXRmExmx1uEb8n00Ih
        xuT0trJA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jlHFP-00006X-O2; Tue, 16 Jun 2020 19:27:51 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 691323017B7;
        Tue, 16 Jun 2020 21:27:49 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 542182B6DCDEA; Tue, 16 Jun 2020 21:27:49 +0200 (CEST)
Date:   Tue, 16 Jun 2020 21:27:49 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     Josh Poimboeuf <jpoimboe@redhat.com>, x86 <x86@kernel.org>,
        linux-tip-commits@vger.kernel.org,
        Sami Tolvanen <samitolvanen@google.com>,
        Kristen Carlson Accardi <kristen@linux.intel.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [tip: objtool/core] objtool: Use sh_info to find the base for
 .rela sections
Message-ID: <20200616192749.GB2531@hirez.programming.kicks-ass.net>
References: <158759428485.28353.15005772572257518607.tip-bot2@tip-bot2>
 <202006161057.E6D5D84@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202006161057.E6D5D84@keescook>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 16, 2020 at 11:00:59AM -0700, Kees Cook wrote:
> On Wed, Apr 22, 2020 at 10:24:44PM -0000, tip-bot2 for Sami Tolvanen wrote:
> > The following commit has been merged into the objtool/core branch of tip:
> > 
> > Commit-ID:     e2ccbff8f02d6b140b8ee71108264686c19b1c78
> > Gitweb:        https://git.kernel.org/tip/e2ccbff8f02d6b140b8ee71108264686c19b1c78
> > Author:        Sami Tolvanen <samitolvanen@google.com>
> > AuthorDate:    Tue, 21 Apr 2020 11:25:01 -07:00
> > Committer:     Josh Poimboeuf <jpoimboe@redhat.com>
> > CommitterDate: Tue, 21 Apr 2020 18:49:15 -05:00
> > 
> > objtool: Use sh_info to find the base for .rela sections
> > 
> > ELF doesn't require .rela section names to match the base section. Use
> > the section index in sh_info to find the section instead of looking it
> > up by name.
> > 
> > LLD, for example, generates a .rela section that doesn't match the base
> > section name when we merge sections in a linker script for a binary
> > compiled with -ffunction-sections.
> > 
> > Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
> > Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
> > Reviewed-by: Kees Cook <keescook@chromium.org>
> 
> Hi!
> 
> Where did this commit end up? It seems to have vanished (404 on the
> Gitweb link) and isn't in -next nor Linus's tree.
> 
> This is needed for LTO, FGKASLR, and link speed improvements[1]. Is it
> possible to get this landed in -rc2 so all the things depending on it
> can rebase happily?

I can't remember why this happened, however I think this patch is in
josh's objtool tree that I was going to stick in objtool/core
tomorrow-ish.

Are those things you mentioned still slated for this release?
