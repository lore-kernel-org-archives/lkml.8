Return-Path: <SRS0=Zj89=5W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0896CC2BA19
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 11:27:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0ABA2076C
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 11:27:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="HQjQ1j+l"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727447AbgDFL1k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Apr 2020 07:27:40 -0400
Received: from merlin.infradead.org ([205.233.59.134]:43900 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726858AbgDFL1k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Apr 2020 07:27:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=stqKhpJAxSNxUDl9LKX3RMiIfMaXKlbdboYYc+aM/is=; b=HQjQ1j+lvcPQt8YqSWvgUdjt4F
        EayFlz03dhGyAGys48clP571u+KGrhYPvxeAK2myijPA6fn6zcWSLUIKUeJFVugYlKGRxPBy8W4zG
        /IsEzazIG0U/7TbCB+87SJo2s5ZGMAmHhfpgZfiticpIgRosw2u8UJ3voaz/+haWZywezIKC+Gfnc
        ssz/m9cdPYEZp2trb+duF2Hd9XFqbDeMGttL9Vh8wAQ2sdOY2vrBHfMupPhYIKNGxHyBvQFuw6eVK
        U5yIa1DA6kbFnAwcBwPhCkQgMsIMRfDdao7OoeDiWrLMuVBL7gcsiDjdEWOp1yKJVpvwO7a0khzn8
        yfD16lzg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jLPug-0002N0-EB; Mon, 06 Apr 2020 11:27:34 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 011E6300478;
        Mon,  6 Apr 2020 13:27:32 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id D3DC42B1362DC; Mon,  6 Apr 2020 13:27:32 +0200 (CEST)
Date:   Mon, 6 Apr 2020 13:27:32 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Jessica Yu <jeyu@kernel.org>
Cc:     Miroslav Benes <mbenes@suse.cz>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        keescook@chromium.org
Subject: Re: [PATCH] module: Harden STRICT_MODULE_RWX
Message-ID: <20200406112732.GK20730@hirez.programming.kicks-ass.net>
References: <20200403163716.GV20730@hirez.programming.kicks-ass.net>
 <20200403165631.hrxxm3pnzqa4vxln@treble>
 <alpine.LSU.2.21.2004061146590.26870@pobox.suse.cz>
 <20200406104615.GA9629@linux-8ccs>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200406104615.GA9629@linux-8ccs>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 06, 2020 at 12:46:17PM +0200, Jessica Yu wrote:
> +++ Miroslav Benes [06/04/20 11:55 +0200]:
> > On Fri, 3 Apr 2020, Josh Poimboeuf wrote:
> > 
> > > On Fri, Apr 03, 2020 at 06:37:16PM +0200, Peter Zijlstra wrote:
> > > > +{
> > > > +	int i;
> > > > +
> > > > +	for (i = 0; i < hdr->e_shnum; i++) {
> > > > +		if (sechdrs[i].sh_flags & (SHF_EXECINSTR|SHF_WRITE))
> > > > +			return -ENOEXEC;
> > > 
> > > I think you only want the error when both are set?
> > > 
> > > 		if (sechdrs[i].sh_flags & (SHF_EXECINSTR|SHF_WRITE) == (SHF_EXECINSTR|SHF_WRITE))
> > 
> > A section with SHF_EXECINSTR and SHF_WRITE but without SHF_ALLOC would be
> > strange though, no? It wouldn't be copied to the final module later
> > anyway.
> 
> That's right - move_module() ignores !SHF_ALLOC sections and does not
> copy them over to their final location. So I think we want to look for
> SHF_EXECINSTR|SHF_WRITE|SHF_ALLOC here..

So I did notice that !SHF_ALLOC sections get ignored, but since this
check is about W^X we don't strictly care about SHF_ALLOC. What we care
about it never allowing a writable and executable map.

Adding ALLOC to the test only allows for future mistakes and doesn't
make the check any better.

