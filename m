Return-Path: <SRS0=3CHW=6C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E5CDC2BB1D
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Apr 2020 01:12:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D5D462223C
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Apr 2020 01:12:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587172344;
	bh=UT2kVX8P6Z5wAoCriq1S4SxzRtFl5D3xnEgjUEsn4qY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=WZwfW2DMh20LpaVrjISNx12FpoCla4KxfbV8QBrwqIwnY9kHhgvVAOdbfDWnSqapQ
	 QuiR5yV/zWsyTAKYercuBQCHSWXovpHvkVtRFjzHVO+1D3t19RvXE01a/HbHw5/l3S
	 pW5+EpXjf2HuGbsxcvV085fGkpYA3GKwrKHweOLA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725862AbgDRBMY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Apr 2020 21:12:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:33322 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725298AbgDRBMX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Apr 2020 21:12:23 -0400
Received: from localhost.localdomain (c-73-231-172-41.hsd1.ca.comcast.net [73.231.172.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4CB4920771;
        Sat, 18 Apr 2020 01:12:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587172342;
        bh=UT2kVX8P6Z5wAoCriq1S4SxzRtFl5D3xnEgjUEsn4qY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=OcTgQhzfTOzYYRDDUQR48PZkWijpnM5ylDuJrh5wZD6eohiUaUiDzOPnb3h0QVhrU
         KgR+af7gs1/pnoLnCOejc9pYTwjWevdJeObG7BGPAb7q5qwnyst3sycwp8p9tz0iKT
         f+YFtQ3jCGGijFRIKv2Of2BTt+NiDrJqPJEjlfyg=
Date:   Fri, 17 Apr 2020 18:12:19 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Dongli Zhang <dongli.zhang@oracle.com>
Cc:     linux-mm@kvack.org, cl@linux.com, penberg@kernel.org,
        rientjes@google.com, iamjoonsoo.kim@lge.com,
        linux-kernel@vger.kernel.org, joe.jin@oracle.com
Subject: Re: [PATCH 1/1] mm: slub: fix corrupted freechain in
 deactivate_slab()
Message-Id: <20200417181219.bef9b2f9ade92bf3798e3622@linux-foundation.org>
In-Reply-To: <20200331031450.12182-1-dongli.zhang@oracle.com>
References: <20200331031450.12182-1-dongli.zhang@oracle.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 30 Mar 2020 20:14:50 -0700 Dongli Zhang <dongli.zhang@oracle.com> wrote:

> The slub_debug is able to fix the corrupted slab freelist/page. However,
> alloc_debug_processing() only checks the validity of current and next
> freepointer during allocation path. As a result, once some objects have
> their freepointers corrupted, deactivate_slab() may lead to page fault.
> 
> Below is from a test kernel module when
> 'slub_debug=PUF,kmalloc-128 slub_nomerge'. The test kernel corrupts the
> freepointer of one free object on purpose. Unfortunately, deactivate_slab()
> does not detect it when iterating the freechain.
> 
> ...
>
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -2082,6 +2082,20 @@ static void deactivate_slab(struct kmem_cache *s, struct page *page,
>  		void *prior;
>  		unsigned long counters;
>  
> +		if ((s->flags & SLAB_CONSISTENCY_CHECKS) &&
> +		    !check_valid_pointer(s, page, nextfree)) {
> +			/*
> +			 * If 'nextfree' is invalid, it is possible that
> +			 * the object at 'freelist' is already corrupted.
> +			 * Therefore, all objects starting at 'freelist'
> +			 * are isolated.
> +			 */
> +			object_err(s, page, freelist, "Freechain corrupt");
> +			freelist = NULL;
> +			slab_fix(s, "Isolate corrupted freechain");
> +			break;
> +		}
> +
>  		do {
>  			prior = page->freelist;
>  			counters = page->counters;

We could do it this way:

--- a/mm/slub.c~mm-slub-fix-corrupted-freechain-in-deactivate_slab-fix
+++ a/mm/slub.c
@@ -2083,6 +2083,7 @@ static void deactivate_slab(struct kmem_
 		void *prior;
 		unsigned long counters;
 
+#ifdef CONFIG_SLAB_DEBUG
 		if ((s->flags & SLAB_CONSISTENCY_CHECKS) &&
 		    !check_valid_pointer(s, page, nextfree)) {
 			/*
@@ -2096,6 +2097,7 @@ static void deactivate_slab(struct kmem_
 			slab_fix(s, "Isolate corrupted freechain");
 			break;
 		}
+#endif
 
 		do {
 			prior = page->freelist;

But it's a bit ugly.  How about this?

--- a/mm/slub.c~mm-slub-fix-corrupted-freechain-in-deactivate_slab-fix
+++ a/mm/slub.c
@@ -650,6 +650,20 @@ static void slab_bug(struct kmem_cache *
 	va_end(args);
 }
 
+static bool freelist_corrupted(struct kmem_cache *s, struct page *page,
+			       void *freelist, void *nextfree)
+{
+	if ((s->flags & SLAB_CONSISTENCY_CHECKS) &&
+	    !check_valid_pointer(s, page, nextfree)) {
+		object_err(s, page, freelist, "Freechain corrupt");
+		freelist = NULL;
+		slab_fix(s, "Isolate corrupted freechain");
+		return true;
+	}
+
+	return false;
+}
+
 static void slab_fix(struct kmem_cache *s, char *fmt, ...)
 {
 	struct va_format vaf;
@@ -1400,6 +1414,11 @@ static inline void inc_slabs_node(struct
 static inline void dec_slabs_node(struct kmem_cache *s, int node,
 							int objects) {}
 
+static bool freelist_corrupted(struct kmem_cache *s, struct page *page,
+			       void *freelist, void *nextfree)
+{
+	return false;
+}
 #endif /* CONFIG_SLUB_DEBUG */
 
 /*
@@ -2083,19 +2102,13 @@ static void deactivate_slab(struct kmem_
 		void *prior;
 		unsigned long counters;
 
-		if ((s->flags & SLAB_CONSISTENCY_CHECKS) &&
-		    !check_valid_pointer(s, page, nextfree)) {
-			/*
-			 * If 'nextfree' is invalid, it is possible that
-			 * the object at 'freelist' is already corrupted.
-			 * Therefore, all objects starting at 'freelist'
-			 * are isolated.
-			 */
-			object_err(s, page, freelist, "Freechain corrupt");
-			freelist = NULL;
-			slab_fix(s, "Isolate corrupted freechain");
+		/*
+		 * If 'nextfree' is invalid, it is possible that the object at
+		 * 'freelist' is already corrupted.  So isolate all objects
+		 * starting at 'freelist'.
+		 */
+		if (freelist_corrupted(s, page, freelist, nextfree))
 			break;
-		}
 
 		do {
 			prior = page->freelist;
_

