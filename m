Return-Path: <SRS0=n+Ub=5Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB291C2D0EA
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 07:38:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85C55206F7
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 07:38:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="h2xEZTM+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726620AbgDIHiN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Apr 2020 03:38:13 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:51534 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726052AbgDIHiN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Apr 2020 03:38:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Transfer-Encoding
        :Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=AxwlbcczrcM66tOFAkUbIV/4R2+T4MO0y8ZxODcBdHg=; b=h2xEZTM+wm/Zf1JF6RjIgKxjm2
        5+jEIrh8KclhNSP9G9R81bUDbiO+vbXWmZIm0iQYWee6KN8oUT/lh9YzqIKGVJKvqYe6Tk72sRq2f
        E5jtRQSym6zJBrb7AKVEKA1m90e+SKHcWgpSdgjDQ1xRdag5XZC9MCFHxEgE6AciYb/GGUBoLM3Ce
        BgfPpHaC/GDrSUPp6ux4paNHx5ZrKvlSTGS0T5MyrEoG1846Hfc9EGaMxKEQ7HzhPBk7zhEo+4laq
        cptEhbO3Uk0wmWTRq1OlFA5JXUjmn16o6tEXlA+Kj66ZPSXFNVHpde2TLbKI2P+hIDkJB4aKl+jKX
        06Jg+/mQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jMRlK-0005UW-Ed; Thu, 09 Apr 2020 07:38:12 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id A16B19810C0; Thu,  9 Apr 2020 09:38:07 +0200 (CEST)
Date:   Thu, 9 Apr 2020 09:38:07 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     youling 257 <youling257@gmail.com>
Cc:     viro@zeniv.linux.org.uk, jpoimboe@redhat.com,
        linux-kernel@vger.kernel.org
Subject: Re: Merge branch 'core-objtool-for-linus' of
 git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip
Message-ID: <20200409073807.GA2483@worktop.programming.kicks-ass.net>
References: <CAOzgRdbWsKY7mXgiTx3um_gdJvgPN1O2p1vxmWv9eApQAy9UzQ@mail.gmail.com>
 <CAOzgRdYkJMiQM9M-UHv5Z-6CLzaV0P8YTK5Ft-CmT5-JqCnYSA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOzgRdYkJMiQM9M-UHv5Z-6CLzaV0P8YTK5Ft-CmT5-JqCnYSA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 09, 2020 at 10:00:53AM +0800, youling 257 wrote:
> d937a6dfc9428f470c3ce4d459c390944ddef538 caused 64bit kernel build
> failed on 32bit userspace.
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=d937a6dfc9428f470c3ce4d459c390944ddef538
> 
> 2020-04-08 16:13 GMT+08:00, youling 257 <youling257@gmail.com>:
> > after this merge branch, build 64bit kernel failed on 32bit userspace.
> >
> >
> >   CC       tools/objtool/builtin-check.o
> >   CC       tools/objtool/builtin-orc.o
> > In file included from check.h:10,
> >                  from builtin-check.c:18:
> > elf.h: In function ‘sec_offset_hash’:
> > elf.h:102:14: error: right shift count >= width of type
> > [-Werror=shift-count-overflow]
> >   102 |  oh = offset >> 32;
> >       |              ^~

Oh right; I figured it wouldn't matter since we don't do objtool for
32bit kernels, but I suppose you're cross building a 64bit kernel on a
32bit host or something daft like that?

I'll go fix it.
