Return-Path: <SRS0=kRID=5C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13B31C5ACD6
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 17:36:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D746F20724
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 17:36:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726780AbgCQRgf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Mar 2020 13:36:35 -0400
Received: from ms.lwn.net ([45.79.88.28]:33612 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726655AbgCQRge (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Mar 2020 13:36:34 -0400
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 23EAD891;
        Tue, 17 Mar 2020 17:36:34 +0000 (UTC)
Date:   Tue, 17 Mar 2020 11:36:33 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Darren Hart <dvhart@infradead.org>
Subject: Re: [PATCH 04/17] kernel: futex.c: get rid of a docs build warning
Message-ID: <20200317113633.32078328@lwn.net>
In-Reply-To: <20200317165805.GA20713@hirez.programming.kicks-ass.net>
References: <cover.1584456635.git.mchehab+huawei@kernel.org>
        <aab1052263e340a3eada5522f32be318890314a1.1584456635.git.mchehab+huawei@kernel.org>
        <20200317165805.GA20713@hirez.programming.kicks-ass.net>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 17 Mar 2020 17:58:05 +0100
Peter Zijlstra <peterz@infradead.org> wrote:

> On Tue, Mar 17, 2020 at 03:54:13PM +0100, Mauro Carvalho Chehab wrote:
> > Adjust whitespaces and blank lines in order to get rid of this:
> > 
> > 	./kernel/futex.c:491: WARNING: Definition list ends without a blank line; unexpected unindent.
> > 
> > Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> > ---
> >  kernel/futex.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> > 
> > diff --git a/kernel/futex.c b/kernel/futex.c
> > index 67f004133061..dda6ddbc2e7d 100644
> > --- a/kernel/futex.c
> > +++ b/kernel/futex.c
> > @@ -486,7 +486,8 @@ static u64 get_inode_sequence_number(struct inode *inode)
> >   * The key words are stored in @key on success.
> >   *
> >   * For shared mappings (when @fshared), the key is:
> > - *   ( inode->i_sequence, page->index, offset_within_page )
> > + * ( inode->i_sequence, page->index, offset_within_page )
> > + *  
> 
> WTH, that's less readable.

It won't render well in the build either; that should be a literal block.

jon
