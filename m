Return-Path: <SRS0=4xmc=56=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1255DC2BB1D
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 22:25:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D28882064A
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 22:25:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="f1arLuVk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391936AbgDNWZv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Apr 2020 18:25:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2391879AbgDNWZo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 18:25:44 -0400
Received: from merlin.infradead.org (unknown [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B866C061A0C
        for <linux-kernel@vger.kernel.org>; Tue, 14 Apr 2020 15:25:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=RGZB7ae/M0io69TXtZXpt/WVolg10zvCmI4RiKooIhY=; b=f1arLuVkBWrOzrndQG4SYz2zdt
        FxURcJ1jbpOYqhr+OGRKYG3NNk/UM91ZkH+aY0HTSEUBP+sfL3afkLyu/Rcp2tdbP0CWWzdtnN86R
        ejX+ieyK4FQD6VB2EklKVnN+5bYPUci+n66z6ngnRwi6YIAtYUleDs/Tjfrj86/V1i4wSVFICQZHO
        Fixfv0eSBKQ4XTO0vHVOiJc3RwMf4U6hPeSxRCdFWuk7Osx6qBsIcbbnMxOHD58zUUgkZ+lbKtUQh
        xHVqKstD+n7tqjJR3AgN9HBghgrppm7g5vH/az2IzMqN4maTV7ahUdMt+XidI0BcInmkAyKEvhc0q
        ffC0Mq/Q==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jOTzX-0008BR-OJ; Tue, 14 Apr 2020 22:25:15 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 069BA305F3F;
        Wed, 15 Apr 2020 00:25:12 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id B042D2BB08C26; Wed, 15 Apr 2020 00:25:12 +0200 (CEST)
Date:   Wed, 15 Apr 2020 00:25:12 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Matt Helsley <mhelsley@vmware.com>,
        Julien Thierry <jthierry@redhat.com>,
        linux-kernel@vger.kernel.org, Josh Poimboeuf <jpoimboe@redhat.com>,
        Ingo Molnar <mingo@redhat.com>, Miroslav Benes <mbenes@suse.cz>
Subject: Re: [RFC][PATCH 00/36] objtool: Make recordmcount a subcommand
Message-ID: <20200414222512.GX20730@hirez.programming.kicks-ass.net>
References: <cover.1586468801.git.mhelsley@vmware.com>
 <3a3f70df-07b0-91d9-33e1-e997e72b0c5c@redhat.com>
 <20200414093506.7b91bbbb@gandalf.local.home>
 <064f41bd-0dfe-e875-df7c-214184c29fa7@redhat.com>
 <20200414115458.093e221b@gandalf.local.home>
 <20200414200910.GB118458@rlwimi.vmware.com>
 <20200414204729.GJ2483@worktop.programming.kicks-ass.net>
 <20200414170520.4d347caa@gandalf.local.home>
 <20200414211754.GK2483@worktop.programming.kicks-ass.net>
 <20200414174702.1d540e24@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200414174702.1d540e24@gandalf.local.home>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 14, 2020 at 05:47:02PM -0400, Steven Rostedt wrote:
> On Tue, 14 Apr 2020 23:17:54 +0200
> Peter Zijlstra <peterz@infradead.org> wrote:
> 
> > > Do we want that? Matters how long that takes.  
> > 
> > We do want that, however it is conditional on CONFIG_DEBUG_ENTRY and
> > does some rather specific validation. On a defconfig based kernel it
> > takes ~2.5 seconds, significantly more an an allyesconfig.
> 
> Is that timed on your laptop, or on the monster machine you normally do your
> builds on?
> 
> 2.5 seconds for you may be 2.5 minutes for others! ;-)

Final link pass, and objtool, is single threaded, the ~2.5s were on an
old-ish 2.8GHz part, ie, most laptops are faster today.

The machine has a few more cores than laptops have, so total build time
is still managable, unlike laptops. Also, it being a server part, it
suffers less thermal issues.
