Return-Path: <SRS0=4xmc=56=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBB4FC2BB1D
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 21:18:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A6147206A2
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 21:18:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="bRi229pe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2633742AbgDNVSW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Apr 2020 17:18:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2633733AbgDNVST (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 17:18:19 -0400
Received: from merlin.infradead.org (unknown [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DE57C061A0C
        for <linux-kernel@vger.kernel.org>; Tue, 14 Apr 2020 14:18:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=jd5NnoCRPKRbj7j9kaV2Dy+/l09qTYOAoHfPAeydajY=; b=bRi229peuIXEO3ETCcWXUuiece
        6pq+zYPGE2Fr/fJICxDfN62y85yyYIiduK2HnTlDvkM4EiMXPvmtjIWov808F0+gPmQONW8FzKl4j
        xPZJRMzx857RRk2Kq3/VHUeZf9OLPDFlg5siCt9QVf/dak24TYa2tayxXpRrjbG+e92B0gDf46tG9
        45M5YXGjijBR9CGusJp/0wfUbNXkn1b3Cpqj4lzPJ3RkLMAJmjDbOpd19JQ4lcxIW4NcLZ/IOr3Os
        x6xWFMqilojZEEWCbV79W9VhLohceUvP3/lC5SK9qdmX4c9N9t8aJComza0wC2O6Xaz2spwPe44s0
        MEMGlmyA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jOSwP-0006aR-B0; Tue, 14 Apr 2020 21:17:57 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id EE3C9981086; Tue, 14 Apr 2020 23:17:54 +0200 (CEST)
Date:   Tue, 14 Apr 2020 23:17:54 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Matt Helsley <mhelsley@vmware.com>,
        Julien Thierry <jthierry@redhat.com>,
        linux-kernel@vger.kernel.org, Josh Poimboeuf <jpoimboe@redhat.com>,
        Ingo Molnar <mingo@redhat.com>, Miroslav Benes <mbenes@suse.cz>
Subject: Re: [RFC][PATCH 00/36] objtool: Make recordmcount a subcommand
Message-ID: <20200414211754.GK2483@worktop.programming.kicks-ass.net>
References: <cover.1586468801.git.mhelsley@vmware.com>
 <3a3f70df-07b0-91d9-33e1-e997e72b0c5c@redhat.com>
 <20200414093506.7b91bbbb@gandalf.local.home>
 <064f41bd-0dfe-e875-df7c-214184c29fa7@redhat.com>
 <20200414115458.093e221b@gandalf.local.home>
 <20200414200910.GB118458@rlwimi.vmware.com>
 <20200414204729.GJ2483@worktop.programming.kicks-ass.net>
 <20200414170520.4d347caa@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200414170520.4d347caa@gandalf.local.home>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 14, 2020 at 05:05:20PM -0400, Steven Rostedt wrote:
> On Tue, 14 Apr 2020 22:47:29 +0200
> Peter Zijlstra <peterz@infradead.org> wrote:
> 
> > On Tue, Apr 14, 2020 at 01:09:10PM -0700, Matt Helsley wrote:
> > > I also noticed that, for example, sorttable uses the same ELF code /
> > > patterns as recordmcount -- like the double-include trick. Of course
> > > it operates on a larger scale than per-object-file and so there might
> > > only be code maintenance savings there...  
> > 
> > I'm >< close to having objtool run on vmlinux in the link stage too :-)
> 
> Do we want that? Matters how long that takes.

We do want that, however it is conditional on CONFIG_DEBUG_ENTRY and
does some rather specific validation. On a defconfig based kernel it
takes ~2.5 seconds, significantly more an an allyesconfig.

