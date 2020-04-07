Return-Path: <SRS0=z/zp=5X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E308C2BA16
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 07:43:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 31610206F5
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 07:43:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726937AbgDGHnU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Apr 2020 03:43:20 -0400
Received: from mx2.suse.de ([195.135.220.15]:57148 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726591AbgDGHnU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Apr 2020 03:43:20 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 5D265AC2C;
        Tue,  7 Apr 2020 07:43:18 +0000 (UTC)
Date:   Tue, 7 Apr 2020 09:43:17 +0200 (CEST)
From:   Miroslav Benes <mbenes@suse.cz>
To:     Peter Zijlstra <peterz@infradead.org>
cc:     Jessica Yu <jeyu@kernel.org>, Josh Poimboeuf <jpoimboe@redhat.com>,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        keescook@chromium.org
Subject: Re: [PATCH] module: Harden STRICT_MODULE_RWX
In-Reply-To: <20200406112732.GK20730@hirez.programming.kicks-ass.net>
Message-ID: <alpine.LSU.2.21.2004070939041.1817@pobox.suse.cz>
References: <20200403163716.GV20730@hirez.programming.kicks-ass.net> <20200403165631.hrxxm3pnzqa4vxln@treble> <alpine.LSU.2.21.2004061146590.26870@pobox.suse.cz> <20200406104615.GA9629@linux-8ccs> <20200406112732.GK20730@hirez.programming.kicks-ass.net>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 6 Apr 2020, Peter Zijlstra wrote:

> On Mon, Apr 06, 2020 at 12:46:17PM +0200, Jessica Yu wrote:
> > +++ Miroslav Benes [06/04/20 11:55 +0200]:
> > > On Fri, 3 Apr 2020, Josh Poimboeuf wrote:
> > > 
> > > > On Fri, Apr 03, 2020 at 06:37:16PM +0200, Peter Zijlstra wrote:
> > > > > +{
> > > > > +	int i;
> > > > > +
> > > > > +	for (i = 0; i < hdr->e_shnum; i++) {
> > > > > +		if (sechdrs[i].sh_flags & (SHF_EXECINSTR|SHF_WRITE))
> > > > > +			return -ENOEXEC;
> > > > 
> > > > I think you only want the error when both are set?
> > > > 
> > > > 		if (sechdrs[i].sh_flags & (SHF_EXECINSTR|SHF_WRITE) == (SHF_EXECINSTR|SHF_WRITE))
> > > 
> > > A section with SHF_EXECINSTR and SHF_WRITE but without SHF_ALLOC would be
> > > strange though, no? It wouldn't be copied to the final module later
> > > anyway.
> > 
> > That's right - move_module() ignores !SHF_ALLOC sections and does not
> > copy them over to their final location. So I think we want to look for
> > SHF_EXECINSTR|SHF_WRITE|SHF_ALLOC here..
> 
> So I did notice that !SHF_ALLOC sections get ignored, but since this
> check is about W^X we don't strictly care about SHF_ALLOC. What we care
> about it never allowing a writable and executable map.
> 
> Adding ALLOC to the test only allows for future mistakes and doesn't
> make the check any better.

Ok, fair enough.

I am still wondering if there are modules out there with sections flags 
combination which would cause the same problem with layout_sections() and 
move_module() logic I described earlier. But that it is a separate issue.

Thanks
Miroslav
