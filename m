Return-Path: <SRS0=8uoY=6F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6E03C55183
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 02:35:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7D44F2078C
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 02:35:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="PU2/E+cI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726998AbgDUCfu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Apr 2020 22:35:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725829AbgDUCfu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 22:35:50 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC500C061A0E
        for <linux-kernel@vger.kernel.org>; Mon, 20 Apr 2020 19:35:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=TKDjp2jOs2JqxeWg+YIbR4CsvuwDTxuXsoyCbcQwBSU=; b=PU2/E+cIalL/iK8yL7LXJBBAzB
        Ek37d+gwqTWnTvrOoRdzOfWls0HEWGAkEKaLGKMwH/nRtRM9HT5pK2P2cG6oqebUBAjOoWRftT+mB
        4tG92qGwMNms2rAO8ipnXB+iDXxqMu3awrABI2LHrhF2Fn2CLGcXliGV164QR8TuPcVSjo8eHTBUQ
        jSmvul7HCfrbynCf1Rxz/p3QFTtGLp1oYLtq+oBhaUQlqjhaAdLXCehtGlY0hRljEjP5GUOl6itI0
        PlZeTRkm81zpBom672Gd9ZYzOwgd8J44uK2Nj8gxyT/yquDjT99xeB790Eg0qqUW8a7luMAtmFjIZ
        mAFq7X+Q==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jQilC-0002ij-5G; Tue, 21 Apr 2020 02:35:42 +0000
Date:   Mon, 20 Apr 2020 19:35:42 -0700
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
        Hugh Dickins <hughd@google.com>, Ying Han <yinghan@google.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Daniel Jordan <daniel.m.jordan@oracle.com>
Subject: Re: [PATCH v4 09/10] mmap locking API: use lockdep_assert_held
Message-ID: <20200421023542.GJ5820@bombadil.infradead.org>
References: <20200415004353.130248-1-walken@google.com>
 <20200415004353.130248-10-walken@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200415004353.130248-10-walken@google.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 14, 2020 at 05:43:52PM -0700, Michel Lespinasse wrote:
> Use lockdep_assert_held when asserting that mmap_sem is held.
> 
> Using this instead of rwsem_is_locked makes the assertions more
> tolerant of future changes to the lock type.

Somebody pointed out on an earlier iteration of this patch set that
rwsem_is_locked() is enabled on all rwsems whereas lockdep_assert_held()
is only enabled when lockdep is enabled, which is not production setups.

How about this?

static inline void mm_assert_locked(struct mm_struct *mm)
{
	if (IS_ENABLED(CONFIG_LOCKDEP) && debug_locks)
		VM_BUG_ON_MM(!lockdep_is_held(&mm->mmap_sem), mm);
	else
		VM_BUG_ON_MM(!rwsem_is_locked(&mm->mmap_sem), mm);
}

