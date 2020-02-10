Return-Path: <SRS0=Vo5z=36=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 151CDC352A4
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 17:13:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EBF2320715
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 17:13:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727911AbgBJRNV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Feb 2020 12:13:21 -0500
Received: from smtprelay0064.hostedemail.com ([216.40.44.64]:38163 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727598AbgBJRNU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 12:13:20 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay04.hostedemail.com (Postfix) with ESMTP id 12440180A9558;
        Mon, 10 Feb 2020 17:13:19 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: cough69_7412b12c76328
X-Filterd-Recvd-Size: 2585
Received: from XPS-9350.home (unknown [47.151.143.254])
        (Authenticated sender: joe@perches.com)
        by omf08.hostedemail.com (Postfix) with ESMTPA;
        Mon, 10 Feb 2020 17:13:17 +0000 (UTC)
Message-ID: <f666487838350308d2470c30d34a33eb7922e720.camel@perches.com>
Subject: Re: Checkpatch being daft, Was: [PATCH -v2 08/10] m68k,mm: Extend
 table allocator for multiple sizes
From:   Joe Perches <joe@perches.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Will Deacon <will@kernel.org>,
        Michael Schmitz <schmitzmic@gmail.com>,
        Greg Ungerer <gerg@linux-m68k.org>,
        sean.j.christopherson@intel.com
Date:   Mon, 10 Feb 2020 09:12:02 -0800
In-Reply-To: <20200210163843.GL14897@hirez.programming.kicks-ass.net>
References: <20200131124531.623136425@infradead.org>
         <20200131125403.882175409@infradead.org>
         <CAMuHMdWa8R=3fHLV7W_ni8An_1CwOoJxErnnDA3t4rq2XN+QzA@mail.gmail.com>
         <20200207113417.GG14914@hirez.programming.kicks-ass.net>
         <CAMuHMdW8hWpSsf31P0hC=b23GCx4oFwfaVYKQ1qrZfwFCPK5-Q@mail.gmail.com>
         <20200207123035.GI14914@hirez.programming.kicks-ass.net>
         <20200207123334.GT14946@hirez.programming.kicks-ass.net>
         <3f8a8a2f89bfd2d4cca9ac176ef41abf3a0ed4ab.camel@perches.com>
         <20200210163843.GL14897@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2020-02-10 at 17:38 +0100, Peter Zijlstra wrote:
> On Sun, Feb 09, 2020 at 10:24:15AM -0800, Joe Perches wrote:
> > Maybe this?
> 
> This isn't anywhere near RFC compliant,

Nothing really is.

https://metacpan.org/pod/Email::Address

doesn't really do a perfect job either, but I suppose
it'd be possible to use it one day instead.

> Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
[]
>  one little nit below..
[]
> > +sub same_email_addresses {
> > +	my ($email1, $email2) = @_;
> > +
> > +	my ($email1_name, $name1_comment, $email1_address, $comment1) = parse_email($email1);
> > +	my ($email2_name, $name2_comment, $email2_address, $comment2) = parse_email($email2);
> > +
> > +	return $email1_name eq $email2_name &&
> > +	       $email1_address eq $email2_address;
> 
> strictly speaking only _address needs be the same for the whole thing to
> arrive at the same inbox, but I suppose that for sanity's sake, this
> comparison makes sense.

I know, and I believe that's true too.


