Return-Path: <SRS0=jv8X=6L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29610C55199
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 13:38:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EC14D206B9
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 13:38:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="B1EBJRVP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727794AbgD0NiT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Apr 2020 09:38:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726539AbgD0NiS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Apr 2020 09:38:18 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1A40C0610D5
        for <linux-kernel@vger.kernel.org>; Mon, 27 Apr 2020 06:38:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Transfer-Encoding
        :Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=9UoMgYzM3h0SmuuYcAun6uUW+gxC7pfA5UN/YTDR2z0=; b=B1EBJRVP47y3yK5GB9pE1YLIzA
        ZJfigSMb5ZIUbxD8wk8m4Tssv8e7CKWZlK+bsX8y2NjDvoZWh7QeDkVQi+8uP1EK5dlxn8nL430UY
        kbGvuGxH+7vnwXEufD71CqacdleCXtwxAI9CMCNEnUEErVPYgIHWTqJHjHgb2354bFjd3xJCMYrY/
        EzntOhjQUJsP8bKXiGGhfJDL/3Tp9FYvGFIFN2LeMu8RjGZCEvMbGlZxIRoXQByzsEDnIN1x5NtBA
        cKjHm7afLk4Ikb4hxknV+evmvpufJ+mbC2tpgm5Ou++L+TNGH1SIHwcnLj9cvwCoiE/6YVwsu504F
        3DH3+E9A==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jT3xY-0000sU-2P; Mon, 27 Apr 2020 13:38:08 +0000
Date:   Mon, 27 Apr 2020 06:38:07 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Waiman Long <longman@redhat.com>
Cc:     Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Changbin Du <changbin.du@gmail.com>
Subject: Re: [PATCH] mm/slub: Fix incorrect checkings of s->offset
Message-ID: <20200427133807.GF29705@bombadil.infradead.org>
References: <20200427020212.5222-1-longman@redhat.com>
 <20200427123814.GE29705@bombadil.infradead.org>
 <891a7635-9074-d320-9571-74f584401f01@redhat.com>
 <b4d05ff7-0fe2-67d8-f2a7-6d0c2ab19408@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b4d05ff7-0fe2-67d8-f2a7-6d0c2ab19408@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 27, 2020 at 09:29:41AM -0400, Waiman Long wrote:
> On 4/27/20 9:18 AM, Waiman Long wrote:
> > On 4/27/20 8:38 AM, Matthew Wilcox wrote:
> > > On Sun, Apr 26, 2020 at 10:02:12PM -0400, Waiman Long wrote:
> > > > In a couple of places in the slub memory allocator, the code uses
> > > > "s->offset" as a check to see if the free pointer is put right
> > > > after the
> > > > object. That check is no longer true with commit 3202fa62fb43 ("slub:
> > > > relocate freelist pointer to middle of object").
> > > > 
> > > > As a result, echoing "1" into the validate sysfs file, e.g. of dentry,
> > > > may cause a bunch of "Freepointer corrupt" error reports to appear with
> > > > the system in panic afterwards.
> > > > 
> > > > To fix it, use the check "s->offset == s->inuse" instead.
> > > I think a little refactoring would make this more clear.
> > > 
> > > unsigned int track_offset(const struct kmem_cache *s)
> > > {
> > >     return s->inuse + (s->offset == s->inuse) ? sizeof(void *) : 0;
> > > }
> > 
> > Yes, that was what I am thinking of doing in v2.
> 
> BTW, "+" has a higher priority than "?:". So we need a parenthesis around
> "?:".

That seems like a good reason to not use ?:

unsigned int track_offset(const struct kmem_cache *s)
{
	if (s->offset != s->inuse)
		return s->inuse;
	return s->inuse + sizeof(void *);
}

Also this needs a comment about why we're doing this ... something about
the freelist pointer, I think?
