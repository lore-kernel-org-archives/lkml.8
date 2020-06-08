Return-Path: <SRS0=Cjtw=7V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D426C433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 10:27:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2F84B2076C
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 10:27:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aHUeX5oL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729349AbgFHK1T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jun 2020 06:27:19 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:46118 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726202AbgFHK1P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jun 2020 06:27:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1591612034;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=w+c1C658Gra3tBGi4uA5u9GLmyX+PqWKbAoT/9hWlFg=;
        b=aHUeX5oLreaUxcGwLYfecFSmvoFe702Zhg2PhHadZRmx/kRWHmoD7lDSaNuq8m/vsy0uVk
        hat5Dnzca8Gg2ZtS7/VnIukzLJC0DrQhXN50mE19zvNBvF9ZrtOAsh9VaCaz542rrXjYFW
        6jhcyWp+Qwlu8/T909oOkDlDSduol+o=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-236-EMW1EwiiPbG2i18i_iC5iw-1; Mon, 08 Jun 2020 06:27:10 -0400
X-MC-Unique: EMW1EwiiPbG2i18i_iC5iw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 17449EC1A1;
        Mon,  8 Jun 2020 10:27:09 +0000 (UTC)
Received: from localhost (unknown [10.36.110.3])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 4487F5C1BD;
        Mon,  8 Jun 2020 10:27:07 +0000 (UTC)
Date:   Mon, 8 Jun 2020 12:27:02 +0200
From:   Stefano Brivio <sbrivio@redhat.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Yury Norov <yury.norov@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] lib: Add test for bitmap_cut()
Message-ID: <20200608122702.034c8c80@redhat.com>
In-Reply-To: <20200608101214.GE2428291@smile.fi.intel.com>
References: <cover.1591606281.git.sbrivio@redhat.com>
        <3e3ab7a4756df2ecf8fb012f16c375d4cd714552.1591606281.git.sbrivio@redhat.com>
        <20200608101214.GE2428291@smile.fi.intel.com>
Organization: Red Hat
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 8 Jun 2020 13:12:14 +0300
Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> On Mon, Jun 08, 2020 at 11:13:29AM +0200, Stefano Brivio wrote:
> > Based on an original patch by Yury Norov: introduce a test for
> > bitmap_cut() that also makes sure functionality is as described for
> > partially overlapping src and dst.  
> 
> > Co-authored-by: Yury Norov <yury.norov@gmail.com>  
> 
> Co-developed-by (and it requires Yury's SoB as well).

Oops, sorry, I didn't remember this part from submitting-patches.rst
correctly. Thanks for pointing this out.

Yury, let me know if I should re-post with both Co-authored-by: and
Signed-off-by: you -- otherwise I'll repost without both.

> > Signed-off-by: Stefano Brivio <sbrivio@redhat.com>  
> 
> ...
> 
> > +static struct test_bitmap_cut test_cut[] = {
> > +	{  0,  0,  8, { 0x0000000aUL, }, { 0x0000000aUL, }, },
> > +	{  0,  0, 32, { 0xdadadeadUL, }, { 0xdadadeadUL, }, },
> > +	{  0,  3,  8, { 0x000000aaUL, }, { 0x00000015UL, }, },
> > +	{  3,  3,  8, { 0x000000aaUL, }, { 0x00000012UL, }, },
> > +	{  0,  1, 32, { 0xa5a5a5a5UL, }, { 0x52d2d2d2UL, }, },
> > +	{  0,  8, 32, { 0xdeadc0deUL, }, { 0x00deadc0UL, }, },
> > +	{  1,  1, 32, { 0x5a5a5a5aUL, }, { 0x2d2d2d2cUL, }, },
> > +	{  0, 15, 32, { 0xa5a5a5a5UL, }, { 0x00014b4bUL, }, },
> > +	{  0, 16, 32, { 0xa5a5a5a5UL, }, { 0x0000a5a5UL, }, },
> > +	{ 15, 15, 32, { 0xa5a5a5a5UL, }, { 0x000125a5UL, }, },
> > +	{ 15, 16, 32, { 0xa5a5a5a5UL, }, { 0x0000a5a5UL, }, },
> > +	{ 16, 15, 32, { 0xa5a5a5a5UL, }, { 0x0001a5a5UL, }, },
> > +
> > +	{ BITS_PER_LONG, BITS_PER_LONG, BITS_PER_LONG,
> > +		{ 0xa5a5a5a5UL, 0xa5a5a5a5UL, },
> > +		{ 0xa5a5a5a5UL, 0xa5a5a5a5UL, },
> > +	},
> > +	{ 1, BITS_PER_LONG - 1, BITS_PER_LONG,
> > +		{ 0xa5a5a5a5UL, 0xa5a5a5a5UL, },
> > +		{ 0x00000001UL, 0x00000001UL, },
> > +	},
> > +
> > +	{ 0, BITS_PER_LONG * 2, BITS_PER_LONG * 2 + 1,
> > +		{ 0xa5a5a5a5UL, 0x00000001UL, 0x00000001UL, 0x00000001UL },  
> 
> Perhaps leave comma as well?

I have a full explicit initialiser for this one, hence the "missing"
comma, I find it clearer. Any specific reason why I should add it?

> 
> > +		{ 0x00000001UL, },
> > +	},
> > +	{ 16, BITS_PER_LONG * 2 + 1, BITS_PER_LONG * 2 + 1 + 16,  
> 
> > +		{ 0x0000ffffUL, 0x5a5a5a5aUL, 0x5a5a5a5aUL, 0x5a5a5a5aUL },  
> 
> Ditto.
> 
> > +		{ 0x2d2dffffUL, },
> > +	},
> > +};
> > +
> > +static void __init test_bitmap_cut(void)
> > +{
> > +	unsigned long b[4], *in = &b[1], *out = &b[0];	/* Partial overlap */
> > +	int i;
> > +
> > +	for (i = 0; i < ARRAY_SIZE(test_cut); i++) {
> > +		struct test_bitmap_cut *t = &test_cut[i];
> > +
> > +		memcpy(in, t->in, sizeof(t->in));
> > +
> > +		bitmap_cut(out, in, t->first, t->cut, t->nbits);  
> 
> > +		if (!bitmap_equal(out, t->expected, t->nbits)) {
> > +			pr_err("bitmap_cut failed: expected %*pb, got %*pb\n",
> > +			       t->nbits, t->expected, t->nbits, out);
> > +		}  
> 
> Perhaps
> 
> 	if (bitmap_equal(...))
> 		continue;
> 
> 	...
> 
> ?

That's five lines instead of four (I can't get pr_err() on one line
anyway) and it looks less straightforward: "if it doesn't match we have
an error" vs. "if it matches go to next case. We have an error". Any
specific reason I'm missing?

-- 
Stefano

