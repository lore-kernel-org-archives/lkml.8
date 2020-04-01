Return-Path: <SRS0=sqB7=5R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7D00C43331
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 13:49:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BBA5420BED
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 13:49:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="1N0sD7iE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732772AbgDANtJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Apr 2020 09:49:09 -0400
Received: from merlin.infradead.org ([205.233.59.134]:57960 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732705AbgDANtJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Apr 2020 09:49:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=uBXzKkGsey9fK+eyH/zRzT6xXFGMrAtpFvULnjVXSbE=; b=1N0sD7iE9IrmP+bzXAevpPUmAY
        xzrLFIVkFsLnZ29dexYaSSUhX8YcW3ErPW1/+KQrcFwMoDo0B/69bYairKgL2Do0s9feDncpme+/l
        IjgPdAZ2PAv29g2towvp4rB7Wxrws4NHLEjPUD0674dVAKrN72UU+DeN8QPNfyxOwwVMBEbbd/eBB
        f3aGCBvTLzG1UPWqGP2tfoLqwlVTSdwqOMU3HYLvPAMC2lEATWqSvqkC6OnKouj1mviHyYpBa7coI
        9YHZSqOQD9S8mQeH5UAvO9cWmwABjYcUc2DXRIAgNWlMq6mR8tHjZ2Vq6vqLW03RY73XdgMYVmZAk
        GX9n8Y4A==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jJdji-00062j-OV; Wed, 01 Apr 2020 13:48:54 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 8915A3025C3;
        Wed,  1 Apr 2020 15:48:53 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 7905A29D86172; Wed,  1 Apr 2020 15:48:53 +0200 (CEST)
Date:   Wed, 1 Apr 2020 15:48:53 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Michel Lespinasse <walken@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Laurent Dufour <ldufour@linux.ibm.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Matthew Wilcox <willy@infradead.org>,
        Liam Howlett <Liam.Howlett@oracle.com>,
        Jerome Glisse <jglisse@redhat.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        David Rientjes <rientjes@google.com>,
        Hugh Dickins <hughd@google.com>, Ying Han <yinghan@google.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Markus Elfring <Markus.Elfring@web.de>
Subject: Re: [PATCH v3 10/10] mmap locking API: rename mmap_sem to mmap_lock
Message-ID: <20200401134853.GT20696@hirez.programming.kicks-ass.net>
References: <20200327225102.25061-1-walken@google.com>
 <20200327225102.25061-11-walken@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200327225102.25061-11-walken@google.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 27, 2020 at 03:51:02PM -0700, Michel Lespinasse wrote:
> Rename the mmap_sem field to mmap_lock. Any new uses of this lock
> should now go through the new mmap locking api. The mmap_lock is
> still implemented as a rwsem, though this could change in the future.

> diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
> index c28911c3afa8..a168d13b5c44 100644
> --- a/include/linux/mm_types.h
> +++ b/include/linux/mm_types.h
> @@ -431,7 +431,7 @@ struct mm_struct {
>  		spinlock_t page_table_lock; /* Protects page tables and some
>  					     * counters
>  					     */
> -		struct rw_semaphore mmap_sem;
> +		struct rw_semaphore mmap_lock;

It would be best if you change the type too.

>  
>  		struct list_head mmlist; /* List of maybe swapped mm's.	These
>  					  * are globally strung together off

