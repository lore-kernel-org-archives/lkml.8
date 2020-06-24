Return-Path: <SRS0=sD2I=AF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFA10C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 14:07:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BE6E320823
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 14:07:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QICUtErs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391116AbgFXOHi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jun 2020 10:07:38 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:37633 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2388395AbgFXOHi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 10:07:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1593007657;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=fb1hGmmynErPFt50plAm995F3DUgaKJEUj59Ai0NXUQ=;
        b=QICUtErsSX9efb0eLEoA5Xfb1QKABt+ZbTZ2R6RcHFM9Px9L4Uf1Jk9mBjxKmLxDcuH4o6
        ibqrO3uIQTkjFkAOtL/l74GOJ6Ta8eWugMi6Eq+fG6ttr3TZhuNNen7aHh6mffGffpOrr4
        6HwZ00AZyKvk7tcS8OmNqVkYhI9VcS4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-42--oXbM6TfPw2uTZkuhV0dJA-1; Wed, 24 Jun 2020 10:07:33 -0400
X-MC-Unique: -oXbM6TfPw2uTZkuhV0dJA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 69ADC107ACCD;
        Wed, 24 Jun 2020 14:07:32 +0000 (UTC)
Received: from optiplex-lnx (unknown [10.3.128.9])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 5C16A619B1;
        Wed, 24 Jun 2020 14:07:30 +0000 (UTC)
Date:   Wed, 24 Jun 2020 10:07:27 -0400
From:   Rafael Aquini <aquini@redhat.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Joel Savitz <jsavitz@redhat.com>, linux-kernel@vger.kernel.org,
        Vlastimil Babka <vbabka@suse.cz>,
        John Hubbard <jhubbard@nvidia.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org
Subject: Re: [PATCH] mm/page_alloc: fix documentation error and remove magic
 numbers
Message-ID: <20200624140727.GA1987277@optiplex-lnx>
References: <20200624032712.23263-1-jsavitz@redhat.com>
 <20200624111255.GL21350@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200624111255.GL21350@casper.infradead.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 24, 2020 at 12:12:55PM +0100, Matthew Wilcox wrote:
> On Tue, Jun 23, 2020 at 11:27:12PM -0400, Joel Savitz wrote:
> > In addition, this patch replaces the magic number bounds with symbolic
> > constants to clarify the logic.
> 
> Why do people think this kind of thing makes the code easier to read?
> It actually makes it harder.  Unless the constants are used in more
> than one place, just leave the numbers where they are.
> 
> > @@ -7852,6 +7852,9 @@ void setup_per_zone_wmarks(void)
> >   * 8192MB:	11584k
> >   * 16384MB:	16384k
> >   */
> > +static const int MIN_FREE_KBYTES_LOWER_BOUND = 1 << 7;
> > +static const int MIN_FREE_KBYTES_UPPER_BOUND = 1 << 18;
> > +

I think these constants would look better if declared as an enum.

> >  int __meminit init_per_zone_wmark_min(void)
> >  {
> >  	unsigned long lowmem_kbytes;
> > @@ -7862,10 +7865,10 @@ int __meminit init_per_zone_wmark_min(void)
> >  
> >  	if (new_min_free_kbytes > user_min_free_kbytes) {
> >  		min_free_kbytes = new_min_free_kbytes;
> > -		if (min_free_kbytes < 128)
> > -			min_free_kbytes = 128;
> > -		if (min_free_kbytes > 262144)
> > -			min_free_kbytes = 262144;
> > +		if (min_free_kbytes < MIN_FREE_KBYTES_LOWER_BOUND)
> > +			min_free_kbytes = MIN_FREE_KBYTES_LOWER_BOUND;
> > +		if (min_free_kbytes > MIN_FREE_KBYTES_UPPER_BOUND)
> > +			min_free_kbytes = MIN_FREE_KBYTES_UPPER_BOUND;
> 
> The only thing I'd consider changing there is replacing 262144 with 256
> * 1024.  1 << 18 is not clearer!


> 

