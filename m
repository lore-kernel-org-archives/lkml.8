Return-Path: <SRS0=z/zp=5X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3150C2BB54
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 22:24:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7779620747
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 22:24:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="BBZlsBLP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726692AbgDGWYU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Apr 2020 18:24:20 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:52206 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726421AbgDGWYR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Apr 2020 18:24:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ilWPxxADWa3Mhatef/EKw7rS7FCyC/3gxiDqFnp+HLE=; b=BBZlsBLPC3Z7Ym7P4pCyL1Km26
        xO+SsFOTryXTlbDB71tkCxYVEjbXDJJ0n534EO5JJxADwCKc65ekQsrica4ogN2t5qYlsPP3clZcP
        ER5Putst3MeTijN9yhRletEkRPQqm96I6AM/PWFsLHSfZSn5+kYYymH9CfizhshKlxxYzUHXHWvFl
        trx7Z2YsT/VBmtmD5GzSukdKaD8S68A9c7n24Fx51B9Co3SkpTAYotIf5jA/P3iQ5bynWCqgCNk0V
        lUHsqJjoCXVEz/mXHh6NZ83c/OHmH1xQLSRNiHpE5250zTCFBo7GoCLiDmAmKitnkVi1GWIufMqSu
        8q8KZ6vg==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jLwdf-0002jz-SO; Tue, 07 Apr 2020 22:24:11 +0000
Date:   Tue, 7 Apr 2020 15:24:11 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     David Howells <dhowells@redhat.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Joe Perches <joe@perches.com>,
        Waiman Long <longman@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Linux-MM <linux-mm@kvack.org>, keyrings@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        David Rientjes <rientjes@google.com>
Subject: Re: [PATCH v2] mm: Add kvfree_sensitive() for freeing sensitive data
 objects
Message-ID: <20200407222411.GN21484@bombadil.infradead.org>
References: <CAHk-=wg2Vsb0JETo24=Tc-T2drwMopMRfKnc__r5SZ6tEnbwcA@mail.gmail.com>
 <20200406185827.22249-1-longman@redhat.com>
 <c2c8adf48be7cb18bbdf0aef7d21e2defe3d2183.camel@perches.com>
 <CAHk-=wg_mkSc-pH8ntGHR=no9DOLRQyxdtU20p55DrM1su6QzA@mail.gmail.com>
 <699292.1586294051@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <699292.1586294051@warthog.procyon.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 07, 2020 at 10:14:11PM +0100, David Howells wrote:
> Linus Torvalds <torvalds@linux-foundation.org> wrote:
> 
> > So the _real_ prototype for 'free()'-like operations should be something like
> > 
> >     void free(const volatile killed void *ptr);
> > 
> > where that "killed" also tells the compiler that the pointer lifetime
> > is dead, so that using it afterwards is invalid. So that the compiler
> > could warn us about some of the most trivial use-after-free cases.
> 
> It might be worth asking the compiler folks to give us an __attribute__ for
> that - even if they don't do anything with it immediately.  So we might have
> something like:
> 
> 	void free(const volatile void *ptr) __attribute__((free(1)));
> 
> There are some for allocation functions, some of which we use, though I'm not
> sure we do so as consistently as we should (should inline functions like
> kcalloc() have them, for example?).

GCC recognises free() as being a __builtin.  I don't know if there's
an __attribute__ for it.

gcc/builtins.def:DEF_LIB_BUILTIN        (BUILT_IN_FREE, "free", BT_FN_VOID_PTR, ATTR_NOTHROW_LEAF_LIST)

It looks like the only two things this really does is warn you if you
try to free a pointer that gcc can prove isn't in the heap, and elide
the call if gcc can prove it's definitely NULL.  Which are both things
that a compiler should do, but aren't all that valuable.
