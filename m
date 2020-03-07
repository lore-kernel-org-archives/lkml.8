Return-Path: <SRS0=IBMW=4Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 763D4C10F00
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Mar 2020 13:33:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F47020674
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Mar 2020 13:33:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CrndxEdi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726193AbgCGNc5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 7 Mar 2020 08:32:57 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:27703 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726109AbgCGNc4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Mar 2020 08:32:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1583587975;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wE+8D6wqrnHL9Mq/JhFBCUv1aIjop/eLPpNsmTusecY=;
        b=CrndxEdiQDNpQWhTAqvln3GnSL80Rcp7VkZ4MSZ8ys0zE0f0bAtYCWj+hK34UePCgE3Mo6
        qawIqj9AIdGRde7nBQzwnJNpLvUE0AXW0D8ceWJOmVLOfFu0kNOFAWLQAXrm4v3MJiPCrw
        lwh+gnWeAPZV4Bll9pveK1ZnFmTJ4wM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-39-jUT8g7WYMCec7kGLFhCrcQ-1; Sat, 07 Mar 2020 08:32:54 -0500
X-MC-Unique: jUT8g7WYMCec7kGLFhCrcQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A6B2E107ACC4;
        Sat,  7 Mar 2020 13:32:51 +0000 (UTC)
Received: from elisabeth (ovpn-200-26.brq.redhat.com [10.40.200.26])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 050C290A03;
        Sat,  7 Mar 2020 13:32:48 +0000 (UTC)
Date:   Sat, 7 Mar 2020 14:32:43 +0100
From:   Stefano Brivio <sbrivio@redhat.com>
To:     Yury Norov <yury.norov@gmail.com>
Cc:     Pablo Neira Ayuso <pablo@netfilter.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] lib/bitmap: rework bitmap_cut()
Message-ID: <20200307143243.0ec974da@elisabeth>
In-Reply-To: <20200307081208.GA21695@yury-thinkpad>
References: <20200306221423.18631-1-yury.norov@gmail.com>
        <20200307001856.5181eda7@elisabeth>
        <20200307081208.GA21695@yury-thinkpad>
Organization: Red Hat
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 7 Mar 2020 00:12:08 -0800
Yury Norov <yury.norov@gmail.com> wrote:

> On Sat, Mar 07, 2020 at 12:18:56AM +0100, Stefano Brivio wrote:
> > Hi Yuri,
> > 
> > I haven't reviewed the new implementation yet, just a few comments so
> > far:
> > 
> > On Fri,  6 Mar 2020 14:14:23 -0800
> > Yury Norov <yury.norov@gmail.com> wrote:
> >   
> > > bitmap_cut() refers src after memmove(). If dst and src overlap,
> > > it may cause buggy behaviour because src may become inconsistent.  
> > 
> > I don't see how: src is always on the opposite side of the cut compared
> > to dst, and bits are copied one by one.  
> 
> Consider this example:
> int main()
> {
> 	char str[] = "Xabcde";
> 	char *s = str+1;
> 	char *d = str; // overlap
> 
> 	memmove(d, s, 5);
> 	printf("%s\n", s);
> 	printf("%s\n", d);
> }
> 
> yury:linux$ ./a.out
> bcdee
> abcdee
> 
> After memmove(), s[0] == 'b', which is wrong.
> 
> In current version src is used after memmove() to set 'keep', which
> may cause similar problem

Ah, yes, good point. This doesn't happen on a complete overlap (current
usage), but I see what you meant now.

Actually, to fix this, it would be enough to move the assignment of
'keep' before the memmove(), or assign 'keep' from 'dst'.

> > Also note that I originally designed this function for the single usage
> > it has, that is, with src being the same as dst, and this is the only
> > way it is used, so this case is rather well tested. Do you have any
> > specific case in mind?  
> 
> No. Do you have in mind a dst != src usecase?

I don't, I was just wondering about the reason behind your patch.

> > > The function complexity is of O(nbits * cut_bits), which can be
> > > improved to O(nbits).  
> > 
> > Nice, indeed.
> >   
> > > We can also rely on bitmap_shift_right() to do most of the work.  
> > 
> > Also nice.
> >   
> > > I don't like interface of bitmap_cut(). The idea of copying of a
> > > whole bitmap inside the function from src to dst doesn't look
> > > useful in practice. The function is introduced a few weeks ago and
> > > was most probably inspired by bitmap_shift_*. Looking at the code,
> > > it's easy to see that bitmap_shift_* is usually passed with
> > > dst == src. bitmap_cut() has a single user so far, and it also
> > > calls it with dst == src.  
> > 
> > I'm not fond of it either, but this wasn't just "inspired" by
> > bitmap_shift_*: I wanted to maintain a consistent interface with those,
> > and all the other functions of this kind taking separate dst and src.
> > 
> > For the current usage, performance isn't exceedingly relevant. If you
> > have another use case in mind where it's relevant, by all means, I
> > think it makes sense to change the interface.
> > 
> > Otherwise, I would still have a slight preference towards keeping the
> > interface consistent.  
> 
> There is no consistent interface. Bitmap_{set,clear) uses one
> notaton, bitmap_{and,or,shift) - another. I think that 'unary'
> operations should not copy the whole bitmap. If user wants, he
> can easily do it. In practice, nobody wants.

bitmap_set() and bitmap_clear() are conceptually in another class, I
think.

In any case, I agree that (map-wise) unary operations should naturally
not copy bitmaps, but I'm still not convinced that "fixing" this just
for bitmap_cut() is a good idea -- because of the inconsistency it adds.

How bad would it be to also adjust all usages of bitmap_{and,or,shift}
to behave in the same way?

> > By the way, I don't think it's possible to do that keeping the
> > memmove(), and at the same time implement the rest of this change,
> > because then we might very well hit some unexpected behaviour, using
> > bitmap_shift_right() later.  
> 
> I think it should work. Can you elaborate?

If you keep the memmove(), then use bitmap_shift_right() on dst, some
excess bits will be affected, unless you copy them back from src...
which at that point, you don't have anymore.

-- 
Stefano

