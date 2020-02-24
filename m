Return-Path: <SRS0=7TUr=4M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64D82C38BE2
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 20:47:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 356CC218AC
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 20:47:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LjAGpPe2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727619AbgBXUrH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Feb 2020 15:47:07 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:48155 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726722AbgBXUrG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Feb 2020 15:47:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1582577225;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=IFb+JCg9fvYWv5+TRl87E0pCWdLFykFOxMEyimKBu0o=;
        b=LjAGpPe2iUW9s22G7Kz69Xx0kykV3W/C5QrOgBdyDRGKuuKPOGDCX4Z+oNmBiZfL5J2zEr
        4VsjQd2dECITwQufh3yKTL62cbXsPcPu+naIaZcTFYNfa+11UFysQhF/o+WKn8ZDVfCz3K
        D6JsBLWSyXUD53ugGFSPaWCt1CF0wZQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-146-qc6Bg33hOUu4BiiD38JGXQ-1; Mon, 24 Feb 2020 15:47:01 -0500
X-MC-Unique: qc6Bg33hOUu4BiiD38JGXQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0D917802562;
        Mon, 24 Feb 2020 20:47:00 +0000 (UTC)
Received: from krava (ovpn-204-48.brq.redhat.com [10.40.204.48])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id C93C560BF3;
        Mon, 24 Feb 2020 20:46:57 +0000 (UTC)
Date:   Mon, 24 Feb 2020 21:46:55 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     "Jin, Yao" <yao.jin@linux.intel.com>
Cc:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com,
        Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com
Subject: Re: [PATCH v3 2/2] Support interactive annotation of code without
 symbols
Message-ID: <20200224204655.GB100468@krava>
References: <20200224022225.30264-1-yao.jin@linux.intel.com>
 <20200224022225.30264-3-yao.jin@linux.intel.com>
 <20200224123526.GF16664@krava>
 <ed9fea55-1568-ab55-cf4a-52fef7c429bf@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ed9fea55-1568-ab55-cf4a-52fef7c429bf@linux.intel.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 24, 2020 at 11:39:43PM +0800, Jin, Yao wrote:

SNIP

> > > +	sym = symbol__new(addr, ANNOTATION_DUMMY_LEN, 0, 0, name);
> > > +	if (sym) {
> > > +		src = symbol__hists(sym, 1);
> > > +		if (!src) {
> > > +			symbol__delete(sym);
> > > +			return NULL;
> > > +		}
> > 
> > hi,
> > I like the patchset:
> > 
> > Acked-by: Jiri Olsa <jolsa@redhat.com>
> > 
> > could you please also check if we can do this earlier,
> > so the dummy symbol is actualy collecting all the hits?
> > 
> > like within the symbol__inc_addr_samples function,
> > but I mght be missing something..
> > 
> > thanks,
> > jirka
> > 
> 
> Thanks so much for like and ack this patchset!
> 
> For your suggestion, I had thought about the similar idea before. Maybe we
> can, but we need to process some cases.
> 
> Say the first address is 0x1000 and the dummy symbol size is 256. We create
> a new dummy symbol for this address (start address is 0x1000 and end address
> is 0x1100).
> 
> If the second address is 0x1010, we can't create a new dummy symbol for this
> address directly. On the contrary, we need to search the dummy symbol list
> by the address first. If the dummy symbol is found then reuse this symbol.
> 
> This idea is a bit more complicated than current patchset in implementation
> but it can collect the hits for the dummy symbols, that's the advantage. The
> advantage of current patchset is it's very simple. :)

ah right, we dont know the symbol's size.. perhaps we could hold
histogram of unresolved addresses and use it later on when displaying
the annotation for the particular unresolved address.. but then
how to bucket the counts for accounting.. yep, it seems tricky ;-)

> 
> Accept current patchset or rewrite for the new idea, both OK for me. :)

I think you it can be build on top of this

thanks,
jirka

