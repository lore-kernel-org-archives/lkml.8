Return-Path: <SRS0=8uoY=6F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AAEAC54FC9
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 14:36:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E9BAF20656
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 14:36:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="uJ7surby"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729020AbgDUOgT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Apr 2020 10:36:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726780AbgDUOgS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Apr 2020 10:36:18 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADA40C061A10
        for <linux-kernel@vger.kernel.org>; Tue, 21 Apr 2020 07:36:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Transfer-Encoding
        :Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=zVp/6Iwlp51D7w2qi9slWnmoKigDIMLGJ/B49YP5gsI=; b=uJ7surbye+bGQdio6RgN+YbBgF
        TMGGpWImp8g5VjI4hQ68YYOFDSa8ru+V9kHISN8XytZoTh6t0/AZrwFvMwLsXGW26OGgva4bTmJ4k
        kQiqJ6KkTFUIpDu8YtlfW5KEy0vC4LI8FWWSLI4cDJkrFN7O5Fr8ZC7h+ub9k878w03+DtPEHP+oO
        I56VYD+Fp0oX8uzyBuc1ksLPyrLwdSMHXIzSeZIZtzD2lMBqyaWXtbMm4x+HT0HA/wy++0XJhcHul
        lq4dv/7IMNq2BcJV6D2ubORG6y/7ICjWvWHPThwvHbfCEvE8nnqh2AWvuk+WAIhT+V4hlyJKl8i6K
        vS2vcBeg==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jQu0P-0004Tu-Mu; Tue, 21 Apr 2020 14:36:09 +0000
Date:   Tue, 21 Apr 2020 07:36:09 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     =?utf-8?B?6LW15Yab5aWO?= <bernard@vivo.com>
Cc:     Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, opensource.kernel@vivo.com
Subject: Re: Re: [PATCH V2] kmalloc_index optimization(code size & runtime
 stable)
Message-ID: <20200421143609.GM5820@bombadil.infradead.org>
References: <20200421111849.GL5820@bombadil.infradead.org>
 <AGEAdwClCFexXOQCGFZtCqqi.3.1587470103606.Hmail.bernard@vivo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <AGEAdwClCFexXOQCGFZtCqqi.3.1587470103606.Hmail.bernard@vivo.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 21, 2020 at 07:55:03PM +0800, 赵军奎 wrote:
> Sure, i just received some kbuild compiler error mails and prompt me to do something? 
> I don`t know why this happened, so i update the patch again.

Don't.  The patch has been NACKed, so there's no need to post a v2.

If you want to do something useful, how about looking at the effect
of adding different slab sizes?  There's a fairly common pattern of
allocating things which are a power of two + a header.  So it may make
sense to have kmalloc caches of 320 (256 + 64), 576 (512 + 64) and 1088
(1024 + 64).  I use 64 here as that's the size of a cacheline, so we
won't get false sharing between users.

This could save a fair quantity of memory; today if you allocate 512 +
8 bytes, it will round up to 1024.  So we'll get 4 allocations per 4kB
page, but with a 576-byte slab, we'd get 7 allocations per 4kB page.
Of course, if there aren't a lot of users which allocate memory in this
range, then it'll be a waste of memory.  On my laptop, it seems like
there might be a decent amount of allocations in the right range:

kmalloc-2k          3881   4384   2048   16    8 : tunables    0    0    0 : sla
bdata    274    274      0
kmalloc-1k          6488   7056   1024   16    4 : tunables    0    0    0 : slabdata    441    441      0
kmalloc-512         7700   8256    512   16    2 : tunables    0    0    0 : slabdata    516    516      0

Now, maybe 576 isn't quite the right size.  Need to try it on a variety
of configurations and find out.  Want to investigate this?
