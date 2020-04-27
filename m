Return-Path: <SRS0=jv8X=6L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F98EC54FD0
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 12:38:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EF6BF20575
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 12:38:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="YEifZSnG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727769AbgD0MiV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Apr 2020 08:38:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726390AbgD0MiU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Apr 2020 08:38:20 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0759C0610D5
        for <linux-kernel@vger.kernel.org>; Mon, 27 Apr 2020 05:38:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=EuRhLbbvYOXOrh6HVR76MSxpSBl6WWX0ew76Qupr1wM=; b=YEifZSnG2+vxDAj47M85s2A2UR
        wP+on33fQ5OgOXw3OvJt8BOjyWWxlewDkHuZv4F+6Dl9sWC+JNEGU+VGPcpKH6+t5VclSucHVCJJ+
        WbqfnobcX+KTb30eCnaiMawJpq0UXwJdLpLQOpueAK7m/Z1eQCqY3ZSJaDdkVKrXMeeboWSgNede3
        WqIz5nCs68IPEjR4b5U8vjeQcDtYB/Wosolpf7/uVZep5pY+FH0CJ0erY/y1wa4zX+jc1n7XKxg/p
        Ym2yTCQxt8gWaPWSmE+X9R7RojyOSvdG57mXbD4YiSGmYurV7MgNnwkvjEPHcgX2p4kVBnlThmKiZ
        pH5u1TGA==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jT31b-0001jt-14; Mon, 27 Apr 2020 12:38:15 +0000
Date:   Mon, 27 Apr 2020 05:38:14 -0700
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
Message-ID: <20200427123814.GE29705@bombadil.infradead.org>
References: <20200427020212.5222-1-longman@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200427020212.5222-1-longman@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 26, 2020 at 10:02:12PM -0400, Waiman Long wrote:
> In a couple of places in the slub memory allocator, the code uses
> "s->offset" as a check to see if the free pointer is put right after the
> object. That check is no longer true with commit 3202fa62fb43 ("slub:
> relocate freelist pointer to middle of object").
> 
> As a result, echoing "1" into the validate sysfs file, e.g. of dentry,
> may cause a bunch of "Freepointer corrupt" error reports to appear with
> the system in panic afterwards.
> 
> To fix it, use the check "s->offset == s->inuse" instead.

I think a little refactoring would make this more clear.

unsigned int track_offset(const struct kmem_cache *s)
{
	return s->inuse + (s->offset == s->inuse) ? sizeof(void *) : 0;
}

> @@ -556,10 +556,8 @@ static struct track *get_track(struct kmem_cache *s, void *object,
>  {
>  	struct track *p;
>  
> -	if (s->offset)
> -		p = object + s->offset + sizeof(void *);
> -	else
> -		p = object + s->inuse;
> +	p = object + s->inuse +
> +	    ((s->offset == s->inuse) ? sizeof(void *) : 0);

	p = object + track_offset(s);

>  	return p + alloc;
>  }
> @@ -693,10 +691,8 @@ static void print_trailer(struct kmem_cache *s, struct page *page, u8 *p)
>  		print_section(KERN_ERR, "Redzone ", p + s->object_size,
>  			s->inuse - s->object_size);
>  
> -	if (s->offset)
> -		off = s->offset + sizeof(void *);
> -	else
> -		off = s->inuse;
> +	off = s->inuse +
> +	      ((s->offset == s->inuse) ? sizeof(void *) : 0);

	off = track_offset(s);

> @@ -826,7 +822,7 @@ static int check_pad_bytes(struct kmem_cache *s, struct page *page, u8 *p)
>  {
>  	unsigned long off = s->inuse;	/* The end of info */
>  
> -	if (s->offset)
> +	if (s->offset == s->inuse)
>  		/* Freepointer is placed after the object. */
>  		off += sizeof(void *);

	unsigned long off = track_offset(s);

