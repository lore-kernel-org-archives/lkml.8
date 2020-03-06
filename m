Return-Path: <SRS0=glOU=4X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 052B5C10DCE
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 23:19:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9964120658
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 23:19:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XXC4UXFo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726382AbgCFXTj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Mar 2020 18:19:39 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:39933 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726245AbgCFXTi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Mar 2020 18:19:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1583536777;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AaegcihBLJQJfoRSt4gkmOzXxDMBePppoosaSAJRCnQ=;
        b=XXC4UXFoCltRpQBJ/xS63l1fxxsGNENnAbYAEXH8Xiyrxx3m1n++/ofx468MYP1xCvwwEY
        ohEh/PhLdCtvRjeU8HQOLY3zeW5IKervB8LrzFVEMTqbb3X6I7waowsJd007baa8qw+gKZ
        KJB2xjnIK5em3HPxd+iQyE19FVawqbI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-376-AVQ0icusOou5JCw94mAnoA-1; Fri, 06 Mar 2020 18:19:33 -0500
X-MC-Unique: AVQ0icusOou5JCw94mAnoA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 710D0DB22;
        Fri,  6 Mar 2020 23:19:32 +0000 (UTC)
Received: from elisabeth (ovpn-200-26.brq.redhat.com [10.40.200.26])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id BCCAC5D9CD;
        Fri,  6 Mar 2020 23:19:24 +0000 (UTC)
Date:   Sat, 7 Mar 2020 00:18:56 +0100
From:   Stefano Brivio <sbrivio@redhat.com>
To:     Yury Norov <yury.norov@gmail.com>
Cc:     Pablo Neira Ayuso <pablo@netfilter.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] lib/bitmap: rework bitmap_cut()
Message-ID: <20200307001856.5181eda7@elisabeth>
In-Reply-To: <20200306221423.18631-1-yury.norov@gmail.com>
References: <20200306221423.18631-1-yury.norov@gmail.com>
Organization: Red Hat
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Yuri,

I haven't reviewed the new implementation yet, just a few comments so
far:

On Fri,  6 Mar 2020 14:14:23 -0800
Yury Norov <yury.norov@gmail.com> wrote:

> bitmap_cut() refers src after memmove(). If dst and src overlap,
> it may cause buggy behaviour because src may become inconsistent.

I don't see how: src is always on the opposite side of the cut compared
to dst, and bits are copied one by one.

Also note that I originally designed this function for the single usage
it has, that is, with src being the same as dst, and this is the only
way it is used, so this case is rather well tested. Do you have any
specific case in mind?

> The function complexity is of O(nbits * cut_bits), which can be
> improved to O(nbits).

Nice, indeed.

> We can also rely on bitmap_shift_right() to do most of the work.

Also nice.

> I don't like interface of bitmap_cut(). The idea of copying of a
> whole bitmap inside the function from src to dst doesn't look
> useful in practice. The function is introduced a few weeks ago and
> was most probably inspired by bitmap_shift_*. Looking at the code,
> it's easy to see that bitmap_shift_* is usually passed with
> dst == src. bitmap_cut() has a single user so far, and it also
> calls it with dst == src.

I'm not fond of it either, but this wasn't just "inspired" by
bitmap_shift_*: I wanted to maintain a consistent interface with those,
and all the other functions of this kind taking separate dst and src.

For the current usage, performance isn't exceedingly relevant. If you
have another use case in mind where it's relevant, by all means, I
think it makes sense to change the interface.

Otherwise, I would still have a slight preference towards keeping the
interface consistent.

By the way, I don't think it's possible to do that keeping the
memmove(), and at the same time implement the rest of this change,
because then we might very well hit some unexpected behaviour, using
bitmap_shift_right() later.

All in all, I don't have a strong preference against this -- but I'm
not too convinced it makes sense either.

-- 
Stefano

