Return-Path: <SRS0=aGSP=5L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1D4FC43331
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 18:06:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD34020714
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 18:06:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="YzrTb7u2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727495AbgCZSG3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Mar 2020 14:06:29 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:50262 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726163AbgCZSG3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Mar 2020 14:06:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=jWvaBwWkbMEQ4pOifwTyi245yqOSXFFRMPeorwgbLa8=; b=YzrTb7u2hy2HmIhqziABJTejXL
        +uLSVaAprNfSOijep16uInHeDnwFj95KZiWAYicQCGd0OTt16VpgXpjiCFCjZttimcqvGCBYfbPCY
        nV9WaoqBo5pqSQMD1TN/XYo1Al7aFUKqh8uwNyZzpQdkROmwmylAU2Zv1WrSqoafnoPYQkuU8+ZTe
        4McrZg5OHeJexK3F3MPHN35gdfCszH+StKSnEt+T7pt4zIWtlVWiv+Y3FnwXHdKwU2DEp4zmHdKd9
        NkGGvAh/gQX580/s5GPsIiaq3108sNATAVKShJtkAbb6H/63UqP8JthamgibP4AvMIcRP0BEBfIgL
        sLvGJK1A==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jHWtZ-0006VX-Ep; Thu, 26 Mar 2020 18:06:21 +0000
Date:   Thu, 26 Mar 2020 11:06:21 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Michel Lespinasse <walken@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Laurent Dufour <ldufour@linux.ibm.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Liam Howlett <Liam.Howlett@oracle.com>,
        Jerome Glisse <jglisse@redhat.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        David Rientjes <rientjes@google.com>,
        Hugh Dickins <hughd@google.com>, Ying Han <yinghan@google.com>
Subject: Re: [PATCH 1/8] mmap locking API: initial implementation as rwsem
 wrappers
Message-ID: <20200326180621.GK22483@bombadil.infradead.org>
References: <20200326070236.235835-1-walken@google.com>
 <20200326070236.235835-2-walken@google.com>
 <20200326175644.GN20941@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200326175644.GN20941@ziepe.ca>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 26, 2020 at 02:56:44PM -0300, Jason Gunthorpe wrote:
> On Thu, Mar 26, 2020 at 12:02:29AM -0700, Michel Lespinasse wrote:
> 
> > +static inline bool mmap_is_locked(struct mm_struct *mm)
> > +{
> > +	return rwsem_is_locked(&mm->mmap_sem) != 0;
> > +}
> 
> I've been wondering if the various VM_BUG(rwsem_is_locked()) would be
> better as lockdep expressions? Certainly when lockdep is enabled it
> should be preferred, IMHO.
> 
> So, I think if inlines are to be introduced this should be something
> similar to netdev's ASSERT_RTNL which seems to have worked well.
> 
> Maybe ASSERT_MMAP_SEM_READ/WRITE/HELD() and do the VM_BUG or
> lockdep_is_held as appropriate?

I'd rather see lockdep_assert_held() used directly rather than have
a wrapper.  This API includes options to check for it beind explicitly
held for read/write/any, which should be useful.
