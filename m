Return-Path: <SRS0=52rg=4G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93FE9C34047
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 20:30:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F3432173E
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 20:30:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="LScU3Yx/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726736AbgBRUad (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Feb 2020 15:30:33 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:40132 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726401AbgBRUad (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Feb 2020 15:30:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=qtG6LFofrwuOgNcj1PU4O1gDuyqOVA6yV6Cv/BdIm3g=; b=LScU3Yx/LItS7jt6xqnd2waP3V
        e9LBYb3ekaMpqvJnVXmisDs5LB+42a8HuLVBjedJI3zau1bTFZGhrfZ2iYyC0rZGDWUQ294ZcecQd
        m28rb00yZH0o5QwPg3SOqx+5LSVP/psaYhWiIgG5AzZRiFwdP9p9fSoiy/NFLBfPPiMoMQEJKhlnP
        D+gk26OLxBok17maFQ7jQMC0cxpJszarfxFvEJz3f+LdgsefXOSvD7MhkbSa3dZQChg2jMmXON1yN
        DwUw2l4lfRSjjZcXmUcAKThOJRVPPIvdQbkqGE0a8lLO0/x6tXnbPjFh2I11bvlaet7V0u9QFcdOD
        Dw20wwDw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j49Vg-0005Yw-JQ; Tue, 18 Feb 2020 20:30:24 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id B7944980E56; Tue, 18 Feb 2020 21:30:22 +0100 (CET)
Date:   Tue, 18 Feb 2020 21:30:22 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Borislav Petkov <bp@alien8.de>, Andy Lutomirski <luto@kernel.org>,
        Tony Luck <tony.luck@intel.com>, x86-ml <x86@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] #MC mess
Message-ID: <20200218203022.GH11457@worktop.programming.kicks-ass.net>
References: <20200218173150.GK14449@zn.tnic>
 <20200218131158.693eeefc@gandalf.local.home>
 <20200218195035.GN14449@zn.tnic>
 <20200218150850.224d9b8e@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200218150850.224d9b8e@gandalf.local.home>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 18, 2020 at 03:08:50PM -0500, Steven Rostedt wrote:
> Now, is jump labels bad in these cases (note, it is possible to trigger
> a breakpoint in them, does an iret disable the MC as well, which means
> we could get nested MC handlers corrupting the IST stack?).

That is what I expect, and would be consistent with the whole NMI
situation.
