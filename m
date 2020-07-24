Return-Path: <SRS0=4orP=BD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEDF1C433E8
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 15:24:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BAF04206E3
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 15:24:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="W3P+ta/1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726667AbgGXPYi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jul 2020 11:24:38 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:50294 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726317AbgGXPYh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jul 2020 11:24:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1595604273;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5S4LFFufUCLzyfla7YE3yrAMSl5PTYaLTnMam8y5Ck0=;
        b=W3P+ta/1Pqr+oEObZKHjCT08TOCQ5SLfej4isBqBkj0lgdRR82dVeL0XLt28nOixcHvI0j
        jPMbfdPYq6dHFMdNME6GuraeRWASRmDnkq4ie3zxfwtSBYvTbevuIy3PheKonKEiBbfMK1
        VQgCkbkVaVoKQVo7INpIVLY3w0dJSVI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-499-NSHLOZ7cNXi5LB6e4jUxbQ-1; Fri, 24 Jul 2020 11:24:29 -0400
X-MC-Unique: NSHLOZ7cNXi5LB6e4jUxbQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4BE2919057A1;
        Fri, 24 Jul 2020 15:24:28 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.40.192.121])
        by smtp.corp.redhat.com (Postfix) with SMTP id 3F0242DE7F;
        Fri, 24 Jul 2020 15:24:26 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Fri, 24 Jul 2020 17:24:27 +0200 (CEST)
Date:   Fri, 24 Jul 2020 17:24:25 +0200
From:   Oleg Nesterov <oleg@redhat.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Hugh Dickins <hughd@google.com>, Michal Hocko <mhocko@kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Michal Hocko <mhocko@suse.com>
Subject: Re: [RFC PATCH] mm: silence soft lockups from unlock_page
Message-ID: <20200724152424.GC17209@redhat.com>
References: <CAHk-=whewL14RgwLZTXcNAnrDPt0H+sRJS6iDq0oGb6zwaBMxg@mail.gmail.com>
 <CAHk-=whb0=rjc1WR+F_r_syw5Ld4=ebuNJmmpaPEzfjZRD5Y-w@mail.gmail.com>
 <alpine.LSU.2.11.2007221359450.1017@eggly.anvils>
 <CAHk-=wi=vuc6sdu0m9nYd3gb8x5Xgnc6=TH=DTOy7qU96rZ9nw@mail.gmail.com>
 <CAHk-=whEjnsANEhTA3aqpNLZ3vv7huP7QAmcAEd-GUxm2YMo-Q@mail.gmail.com>
 <20200723124749.GA7428@redhat.com>
 <CAHk-=wgyc7en4=HddEYiz_RKJXfqe1JYv3BzHc=+_wYq9ti+LQ@mail.gmail.com>
 <CAHk-=whQK3OGwExTzCrwwvuuVaQAgs8KsR-Yv8m1BmXoNZZ=jQ@mail.gmail.com>
 <alpine.LSU.2.11.2007231549540.1016@eggly.anvils>
 <CAHk-=wgvGOnMF0ePU4xS236bOsP8jouj3rps+ysCaGXvCjh2Dg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wgvGOnMF0ePU4xS236bOsP8jouj3rps+ysCaGXvCjh2Dg@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/23, Linus Torvalds wrote:
>
> But I'll walk over my patch mentally one more time. Here's the current
> version, anyway.

Both patches look correct to me, feel free to add

Reviewed-by: Oleg Nesterov <oleg@redhat.com>

> @@ -1013,18 +1014,40 @@ static int wake_page_function(wait_queue_entry_t *wait, unsigned mode, int sync,
>  	if (wait_page->bit_nr != key->bit_nr)
>  		return 0;
>
> +	/* Stop walking if it's locked */
> +	if (wait->flags & WQ_FLAG_EXCLUSIVE) {
> +		if (test_and_set_bit(key->bit_nr, &key->page->flags))
> +			return -1;
> +	} else {
> +		if (test_bit(key->bit_nr, &key->page->flags))
> +			return -1;
> +	}

not sure this makes any sense, but this looks like another user of
trylock_page_bit_common(), see the patch below on top of 1/2.

Oleg.

--- mm/filemap.c~	2020-07-24 17:09:34.728133846 +0200
+++ mm/filemap.c	2020-07-24 17:23:52.279185374 +0200
@@ -1000,6 +1000,14 @@
 	wait_queue_entry_t wait;
 };
 
+static int trylock_page_bit_common(struct page *page, int bit_nr,
+					struct wait_queue_entry *wait)
+{
+	return wait->flags & WQ_FLAG_EXCLUSIVE ?
+		!test_and_set_bit(bit_nr, &page->flags) :
+		!test_bit(bit_nr, &page->flags);
+}
+
 static int wake_page_function(wait_queue_entry_t *wait, unsigned mode, int sync, void *arg)
 {
 	int ret;
@@ -1015,13 +1023,8 @@
 		return 0;
 
 	/* Stop walking if it's locked */
-	if (wait->flags & WQ_FLAG_EXCLUSIVE) {
-		if (test_and_set_bit(key->bit_nr, &key->page->flags))
-			return -1;
-	} else {
-		if (test_bit(key->bit_nr, &key->page->flags))
-			return -1;
-	}
+	if (!trylock_page_bit_common(key->page, key->bit_nr, wait))
+		return -1;
 
 	/*
 	 * Let the waiter know we have done the page flag
@@ -1126,14 +1129,6 @@
 			 */
 };
 
-static inline int trylock_page_bit_common(struct page *page, int bit_nr,
-	enum behavior behavior)
-{
-	return behavior == EXCLUSIVE ?
-		!test_and_set_bit(bit_nr, &page->flags) :
-		!test_bit(bit_nr, &page->flags);
-}
-
 static inline int wait_on_page_bit_common(wait_queue_head_t *q,
 	struct page *page, int bit_nr, int state, enum behavior behavior)
 {
@@ -1170,7 +1165,7 @@
 	 */
 	spin_lock_irq(&q->lock);
 	SetPageWaiters(page);
-	if (!trylock_page_bit_common(page, bit_nr, behavior))
+	if (!trylock_page_bit_common(page, bit_nr, wait))
 		__add_wait_queue_entry_tail(q, wait);
 	spin_unlock_irq(&q->lock);
 

