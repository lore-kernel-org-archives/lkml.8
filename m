Return-Path: <SRS0=52rg=4G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47642C34047
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 20:34:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1ED8B2067D
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 20:34:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="abGp84Ch"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727216AbgBRUeK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Feb 2020 15:34:10 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:42376 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726283AbgBRUeK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Feb 2020 15:34:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=rrgE1QmBht6appaFA2bTRzgOgoL6Gn0NcwciZG8klY4=; b=abGp84Ch0KgWucvvwcavQzPQNv
        fP0B8sExkdZUqIZxOYXb/eWvUJKK89l2HNvreGyDbqCd0nx/lfhGn8DZjVcXoagy86sONTn+AmctG
        bjKzWF5P3LoxwmTNb9vXstPPyid+q3KLm1XG9HFwHKq4awKY/XZYt9rUK3jUxHG+wiQh2+FEtkMak
        oyLPGKTC7yQYorrIRz+P2vBGk9lHlBUioiHgLVxsM3wVyALVhd89lZKfQRDGEWa1qjC6rwPId9yrz
        ygv7ummzal2sB6SK1qL/kU5tJ2qtohr47Lw8zUXQIHnG605NwyCrg/CU6SOr4+IsRztxdYp2kLYKp
        7ZSnwYzw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j49ZH-0006MM-0O; Tue, 18 Feb 2020 20:34:07 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 12FFC980E56; Tue, 18 Feb 2020 21:34:05 +0100 (CET)
Date:   Tue, 18 Feb 2020 21:34:04 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Luck, Tony" <tony.luck@intel.com>
Cc:     Borislav Petkov <bp@alien8.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Andy Lutomirski <luto@kernel.org>, x86-ml <x86@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] #MC mess
Message-ID: <20200218203404.GI11457@worktop.programming.kicks-ass.net>
References: <20200218173150.GK14449@zn.tnic>
 <3908561D78D1C84285E8C5FCA982C28F7F57B937@ORSMSX115.amr.corp.intel.com>
 <20200218200200.GE11457@worktop.programming.kicks-ass.net>
 <3908561D78D1C84285E8C5FCA982C28F7F57BDFB@ORSMSX115.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3908561D78D1C84285E8C5FCA982C28F7F57BDFB@ORSMSX115.amr.corp.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 18, 2020 at 08:11:10PM +0000, Luck, Tony wrote:
> > Then please rewrite the #MC entry code to deal with nested exceptions
> > unmasking the MCE, very similr to NMI.
> 
> #MC doesn't work like NMI.  It isn't enabled by IRET.  Nested #MC cause an
> immediate reset.  Detection of nested case is by IA32_MCG_STATUS.MCIP.
> We don't clear MCG_STATUS until we are ready to return from the machine
> check handler.

Ooh, excellent! That saves a whole heap of problems.

Then I suppose we should work at getting in_nmi() set. Let me have
another look at things.
