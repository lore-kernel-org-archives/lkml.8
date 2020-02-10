Return-Path: <SRS0=Vo5z=36=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54EADC352A4
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 23:09:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 33D0920733
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 23:09:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727518AbgBJXJj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Feb 2020 18:09:39 -0500
Received: from smtprelay0246.hostedemail.com ([216.40.44.246]:47410 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727435AbgBJXJj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 18:09:39 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay02.hostedemail.com (Postfix) with ESMTP id E5A4B4995E6;
        Mon, 10 Feb 2020 23:09:37 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: list10_19c1c018fc60e
X-Filterd-Recvd-Size: 2767
Received: from XPS-9350.home (unknown [47.151.143.254])
        (Authenticated sender: joe@perches.com)
        by omf09.hostedemail.com (Postfix) with ESMTPA;
        Mon, 10 Feb 2020 23:09:36 +0000 (UTC)
Message-ID: <dcd8b6f57578f6ec0250b68206f0930b4aa64864.camel@perches.com>
Subject: Re: [PATCH] checkpatch: Remove email address comment from email
 address comparisons
From:   Joe Perches <joe@perches.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Andy Whitcroft <apw@canonical.com>,
        LKML <linux-kernel@vger.kernel.org>
Date:   Mon, 10 Feb 2020 15:08:21 -0800
In-Reply-To: <20200210142532.432a0900bbacd6087349efe4@linux-foundation.org>
References: <20200131124531.623136425@infradead.org>
         <20200131125403.882175409@infradead.org>
         <CAMuHMdWa8R=3fHLV7W_ni8An_1CwOoJxErnnDA3t4rq2XN+QzA@mail.gmail.com>
         <20200207113417.GG14914@hirez.programming.kicks-ass.net>
         <CAMuHMdW8hWpSsf31P0hC=b23GCx4oFwfaVYKQ1qrZfwFCPK5-Q@mail.gmail.com>
         <20200207123035.GI14914@hirez.programming.kicks-ass.net>
         <20200207123334.GT14946@hirez.programming.kicks-ass.net>
         <ebaa2f7c8f94e25520981945cddcc1982e70e072.camel@perches.com>
         <20200210142532.432a0900bbacd6087349efe4@linux-foundation.org>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2020-02-10 at 14:25 -0800, Andrew Morton wrote:
> On Mon, 10 Feb 2020 10:52:16 -0800 Joe Perches <joe@perches.com> wrote:
> 
> > About 2% of the last 100K commits have email addresses that include an
> > RFC2822 compliant comment like:
> > 
> > 	Peter Zijlstra (Intel) <peterz@infradead.org>
> > 
> > checkpatch currently does a comparison of the complete name and address
> > to the submitted author to determine if the author has signed-off and
> > emits a warning if the exact email names and addresses do not match.
> 
> Yes, I've seen this a few times.
> 
> > Unfortunately, the author email address can be written without the comment
> > like:
> > 
> > 	Peter Zijlstra <peterz@infradead.org>
> > 
> > Add logic to compare the comment stripped email addresses to avoid this
> > warning.
> 
> Where "stripped" means "after removing stuff in parentheses"?

Basically, yes.

> Why do we consider the display name at all?  It's the
> "peterz@infradead.org" part which matters for comparison purposes?

True, but if people are going to author a patch with
one name and sign it with a different one, then some
warning should probably be emitted.

btw:

This code is case sensitive and probably should not be.

I'll probably send a new patch, but the generic use of
'fc' is not supported for older perl versions and so it'll
likely use 'lc' instead.



