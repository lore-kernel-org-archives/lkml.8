Return-Path: <SRS0=kRID=5C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E34FEC5ACD6
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 19:16:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C046C20714
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 19:16:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="JTCUiqIu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726789AbgCQTQy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Mar 2020 15:16:54 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:57678 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726638AbgCQTQy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Mar 2020 15:16:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=8gmkMPc55PnhvAe6dxsKKiOFnfmTOzZAgDVOqMBrgvU=; b=JTCUiqIu5SjTnZG3KLQhp9zeWX
        +tnBTHqGT5I1ZuJ9+9PUptXzSMcZCokGxQqBWgJ5Y3j3EXo9dD9ANmAKv+ZTpFvEYgtpSSlZDjepA
        6IG5N8Xnmwsv1aeaweukC0Je0dhgQP+9RFLk91ckuNYpDAk787YEaO1jsxZOXPEhuSPSR3q6NWBMH
        SAuWMtFt+41YEWzHWxdu3kZJ9biPX3t38ZKQMJjTPo+Jzz51eMzafE+ehQmOiPwf3liAgn/fWbQ6g
        aDV8Z2npPiJLWVH2eJc5iW8WvYZl/s+ouQ0FQSLdIpE5QHDIw6lCI8UA5ZpokUgp4mjxjUfWHkiMj
        7wGTrbmQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jEHhp-0007iO-5x; Tue, 17 Mar 2020 19:16:49 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 5753830110E;
        Tue, 17 Mar 2020 20:16:47 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 49399284D7DE8; Tue, 17 Mar 2020 20:16:47 +0100 (CET)
Date:   Tue, 17 Mar 2020 20:16:47 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Darren Hart <dvhart@infradead.org>
Subject: Re: [PATCH 04/17] kernel: futex.c: get rid of a docs build warning
Message-ID: <20200317191647.GC20713@hirez.programming.kicks-ass.net>
References: <cover.1584456635.git.mchehab+huawei@kernel.org>
 <aab1052263e340a3eada5522f32be318890314a1.1584456635.git.mchehab+huawei@kernel.org>
 <20200317165805.GA20713@hirez.programming.kicks-ass.net>
 <20200317113633.32078328@lwn.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200317113633.32078328@lwn.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 17, 2020 at 11:36:33AM -0600, Jonathan Corbet wrote:
> On Tue, 17 Mar 2020 17:58:05 +0100
> Peter Zijlstra <peterz@infradead.org> wrote:
> 
> > On Tue, Mar 17, 2020 at 03:54:13PM +0100, Mauro Carvalho Chehab wrote:
> > > Adjust whitespaces and blank lines in order to get rid of this:
> > > 
> > > 	./kernel/futex.c:491: WARNING: Definition list ends without a blank line; unexpected unindent.
> > > 
> > > Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> > > ---
> > >  kernel/futex.c | 3 ++-
> > >  1 file changed, 2 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/kernel/futex.c b/kernel/futex.c
> > > index 67f004133061..dda6ddbc2e7d 100644
> > > --- a/kernel/futex.c
> > > +++ b/kernel/futex.c
> > > @@ -486,7 +486,8 @@ static u64 get_inode_sequence_number(struct inode *inode)
> > >   * The key words are stored in @key on success.
> > >   *
> > >   * For shared mappings (when @fshared), the key is:
> > > - *   ( inode->i_sequence, page->index, offset_within_page )
> > > + * ( inode->i_sequence, page->index, offset_within_page )
> > > + *  
> > 
> > WTH, that's less readable.
> 
> It won't render well in the build either; that should be a literal block.

it renders perfectly in an ASCII text editor, which is by far the most
important interface for all this.
