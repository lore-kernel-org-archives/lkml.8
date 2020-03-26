Return-Path: <SRS0=aGSP=5L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79E63C43331
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 12:09:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4AF122076A
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 12:09:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="d7wm7zg6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728192AbgCZMJg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Mar 2020 08:09:36 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:34598 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727994AbgCZMJf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Mar 2020 08:09:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=FeHFmR2HFOSLpZwF6PvR5+pvj6qF67mmDLhfwwnJn8I=; b=d7wm7zg6MAykTct18NooO5kWgE
        nRf1+5VD9LzKZVbAPBqJOoYNwXL7mu5UlhjKHF+1zMJKx4cPOlWKsEI9GC82ZUru+pFfsjERvvtTB
        3b6HyOVU92eyqXauUdu2HuLo3+qeh1ZF56obpzkaQMBQf1hZFkdcIc6jC6deWVlGuXjj3pekpPtg4
        YELDXRgJUlGnPLKgX9hjkbBEALSmEx2KNFx9V/22wE3BZ8C/1y8D7Liw0Y5d5m8SbBsO6HKJwC5Mx
        jPmFv97W+YRhgCCBy49DCxhKrAzzqYmyB18QPfsPyRBhpsjrZN6acliqHqRFkkSF7Uby8jy+qfKPs
        a/NDbODA==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jHRKF-0001tv-58; Thu, 26 Mar 2020 12:09:31 +0000
Date:   Thu, 26 Mar 2020 05:09:31 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Michel Lespinasse <walken@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
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
Subject: Re: [PATCH 5/8] mmap locking API: convert nested write lock sites
Message-ID: <20200326120931.GF22483@bombadil.infradead.org>
References: <20200326070236.235835-1-walken@google.com>
 <20200326070236.235835-6-walken@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200326070236.235835-6-walken@google.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 26, 2020 at 12:02:33AM -0700, Michel Lespinasse wrote:
> @@ -47,9 +48,9 @@ static inline void activate_mm(struct mm_struct *old, struct mm_struct *new)
>  	 * when the new ->mm is used for the first time.
>  	 */
>  	__switch_mm(&new->context.id);
> -	down_write_nested(&new->mmap_sem, 1);
> +	mmap_write_lock_nested(new, 1);
>  	uml_setup_stubs(new);
> -	mmap_write_unlock(new);
> +	mmap_write_unlock_nested(new);

This is a bit of an oddity.  We don't usually have an unlock_nested()
variant (a quick grep finds only something complicated in reiserfs).
That's because it's legitimate to release locks in a different order from
the one they were acquired in (eg lock A, lock B, unlock A, unlock B), and
it's not clear whether "nested" would follow the lock (ie unlock_nested B)
or whether it would follow the code (ie unlock_nested A).

Does your future API require knowing the nested nature at the unlock
point?  And if so, does it require it for A or B in the above scenario?
And how does it mix with lock A or B being of a different type (eg a
plain mutex or a spinlock)?
