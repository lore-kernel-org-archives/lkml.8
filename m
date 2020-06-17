Return-Path: <SRS0=qsSF=76=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EC1AC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 16:26:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4E7B8218AC
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 16:26:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="PC3gjrTD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727793AbgFQQ0t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jun 2020 12:26:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727069AbgFQQ0r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 12:26:47 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB6E0C06174E
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jun 2020 09:26:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=VQvAKQ+aQCqnrbW97QIaAzwZ2mOsoMkKAcRjI526Ur4=; b=PC3gjrTDx1j9O7ps1TBIkgkLeX
        7JwW2jYkxTqxWC3do0eGCliJ0TAR1X7zYfNyQ7StUS+sAQGYYSWKrGg+VItWpR3T8OLa7KA2ET6hm
        4/Xf+pc1sZt0TBbAKIge7DkoDwJ8eKL7+OdjSIXBc+89PQwgdsJj9NfbtRunnwohfcrh9pSGaeVh/
        icb4rn0i76IOyTaOxcwdo8ADtMnhKx2txHyYip7dzAxzkypnDIUHkL4CzqH0d5xo4R4OZ2ap+CsjA
        Mgt2q1r0FcKTSmoc31E9jin4jnk/ppUtpGYWag6oYDd7zcnKUybiV6o5pejU75CTWerUIlRCIkIjK
        htFmszZA==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jlatf-00008G-Cp; Wed, 17 Jun 2020 16:26:43 +0000
Date:   Wed, 17 Jun 2020 09:26:43 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Christopher Lameter <cl@linux.com>
Cc:     William Kucharski <william.kucharski@oracle.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] mm: ksize() should silently accept a NULL pointer
Message-ID: <20200617162643.GK8681@bombadil.infradead.org>
References: <20200616225409.4670-1-william.kucharski@oracle.com>
 <alpine.DEB.2.22.394.2006171621140.1574@www.lameter.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.22.394.2006171621140.1574@www.lameter.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 17, 2020 at 04:23:04PM +0000, Christopher Lameter wrote:
> On Tue, 16 Jun 2020, William Kucharski wrote:
> 
> > Other mm routines such as kfree() and kzfree() silently do the right
> > thing if passed a NULL pointer, so ksize() should do the same.
> 
> Ok so the size of an no object pointer is zero? Ignoring the freeing
> of a nonexisting object makes sense. But determining it size?

ksize() is misnamed.  It's not the size of the object, it's the number
of bytes allocated for that object.

A NULL pointer represents a freed object, or one that was never
allocated in the first place.  Clearly that's 0 bytes.  What other
answer would make sense?

