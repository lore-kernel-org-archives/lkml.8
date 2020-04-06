Return-Path: <SRS0=Zj89=5W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94FA9C2BA17
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 17:24:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69A3B2087E
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 17:24:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="O+aZuVVc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729034AbgDFRYx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Apr 2020 13:24:53 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:35562 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726637AbgDFRYx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Apr 2020 13:24:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=CbTeDSEPwtaCzw6yjO0kB3OJ1K9g71GqZ7e8uE+/IlU=; b=O+aZuVVcCdlpNcA+sNO1Ued0KP
        ZR9UWZ6reaACpuBx+ucTaAQB5/U2W7yy+goHjJgwttK8J/DLJSqnYFVsOjAW4RRrdvNon8mbwzrQc
        EJ+T175Hofiqqon9aClUvjZUm3DVtg42OMmNCNqD5z1a4HlulRC/n8CM//KdMw3nQgIGepO8nzsbq
        KNNX1HIiagz2ZmxeiIZlHFnkJUaAQoQUy3SU6IGdSRP2nN/hXgQZU/F6YlGV96vNPdXbCMcG1t+zk
        MYbM9yFD2OF5z1QZ4GKZoH+dop45A6A9E/bGA202PNAxfWvQNfxfQfzKpEy9oXtuJ52DcfcjOPgeI
        5lKHaKXg==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jLVUK-0003Az-2X; Mon, 06 Apr 2020 17:24:44 +0000
Date:   Mon, 6 Apr 2020 10:24:44 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Joe Perches <joe@perches.com>
Cc:     David Howells <dhowells@redhat.com>,
        Waiman Long <longman@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>, linux-mm@kvack.org,
        keyrings@vger.kernel.org, linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] mm: Add kvfree_sensitive() for freeing sensitive data
 objects
Message-ID: <20200406172444.GG21484@bombadil.infradead.org>
References: <d509771b7e08fff0d18654b746e413e93ed62fe8.camel@perches.com>
 <a291cce3ff1ba978e7ad231a8e1b7d82f6164e86.camel@perches.com>
 <20200406023700.1367-1-longman@redhat.com>
 <319765.1586188840@warthog.procyon.org.uk>
 <334933.1586190389@warthog.procyon.org.uk>
 <dbfcbbd55c63fc87bfb31af3cae1b15e04d8a821.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dbfcbbd55c63fc87bfb31af3cae1b15e04d8a821.camel@perches.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 06, 2020 at 10:10:20AM -0700, Joe Perches wrote:
> On Mon, 2020-04-06 at 17:26 +0100, David Howells wrote:
> > Joe Perches <joe@perches.com> wrote:
> > 
> > > While I agree with Linus about the __ prefix,
> > > the z is pretty common and symmetric to all
> > > the <foo>zalloc uses.
> > > 
> > > And if _sensitive is actually used, it'd be
> > > good to do a s/kzfree/kfree_sensitive/ one day
> > > sooner than later.
> > 
> > How much overhead would it be to always use kvfree_sensitive() and never have
> > a kfree_sensitive()?
> 
> Another possibility:
> 
> Add yet another alloc flag like __GFP_SENSITIVE
> and have kfree operate on that and not have a
> kfree_sensitive at all.

kfree() doesn't take GFP flags.
