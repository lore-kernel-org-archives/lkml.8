Return-Path: <SRS0=SbvM=AM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2D2DC433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 15:48:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BE5CA207D0
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 15:48:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oQSWsOf/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732087AbgGAPsH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jul 2020 11:48:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727941AbgGAPsG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 11:48:06 -0400
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 955C2C08C5C1
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jul 2020 08:48:06 -0700 (PDT)
Received: by mail-qt1-x843.google.com with SMTP id i16so18761580qtr.7
        for <linux-kernel@vger.kernel.org>; Wed, 01 Jul 2020 08:48:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Y3UG6n4VQTWs/fVAEC23K75oC0/jZOs6aLjdj63Uxno=;
        b=oQSWsOf/T5UzRtiIn/lNWCaW/KhRq8xjHwk59ePKewTKUhZMfgmTNF6njX74f4hMvz
         USb8L0oFLPxSDDndo9bhrVIwZo1ofBIPHN+XjdErSdY8WalNPpdMOXg+bQFq7wIe2xPD
         WpImlaSDJ41rpEMTktvIyoUCWwS5HcPoGZIptMIHIhNAKYIp02UkL4p3FGMPHbeERdRP
         H35Qz1qaT6pQGx4ukxf0fTtUhiqIvTtwYjwUZeR+lULBEL72Q8IETWV/1UO/lK1HE2Tv
         trC5gSzDDY7LmJGXHiuujrvjrDQir2AABWRJFkCa+bUO1rm7tcPLbIj5Agt+KBRrldCl
         PhLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Y3UG6n4VQTWs/fVAEC23K75oC0/jZOs6aLjdj63Uxno=;
        b=UhqbE6S6TGv+0IHCew/7yVrY7Gefr++kpOhJ298HQXj6mit/VaTcs6WqRQ7i/vZlaC
         kZfPzD2QPcNIxcwvTvv360JRb7GQj9LRbu2OYsX0C7rRnl/l6p7SlGRm+9s8OqAScwin
         D4LXpjGdJ2EWebt6Am74bpxKuhRLwk40OysRHPmoU1WJjZT0APsDrNMIgfufS76n+pTl
         E9uvqu8SWERplAlGE901xwdkXc6NF5qiEoCtXquDr+SWGHx5gl3PMBZjJy0s95tjV1Er
         Q01wV0BWBi6blfZZS6SV/nLQixjh60prRceROs8T1pMJoD8+UtM8CyFaZgvJzPS/xuKn
         UKOQ==
X-Gm-Message-State: AOAM532+K4/NjwD/gK26/9rGbplk+43wMhpyAPPudHvI8TzbwDLunKqb
        RUEeiqnSy9h17sH4m0ctkKSHZBUQq5sTywyaYIs=
X-Google-Smtp-Source: ABdhPJzG+NgpLm234JldFRSOkVa1TeVz2nuMLMoKwcltaNvy5eWEqgwv82PYelA3uGPLvgzV66TTdA6WYUCpBI6knNA=
X-Received: by 2002:ac8:4b5b:: with SMTP id e27mr25036652qts.96.1593618485897;
 Wed, 01 Jul 2020 08:48:05 -0700 (PDT)
MIME-Version: 1.0
References: <20200701151645.GA26223@lilong>
In-Reply-To: <20200701151645.GA26223@lilong>
From:   Pekka Enberg <penberg@gmail.com>
Date:   Wed, 1 Jul 2020 18:47:49 +0300
Message-ID: <CAOJsxLGST_hgA3OPOdxQpZH_fX5m--WE2Wf8DfTLd557NUD5hQ@mail.gmail.com>
Subject: Re: [PATCH v3] mm, slab: Check GFP_SLAB_BUG_MASK before alloc_pages
 in kmalloc_order
To:     Long Li <lonuxli.64@gmail.com>
Cc:     willy@infradead.org, Christoph Lameter <cl@linux.com>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 1, 2020 at 6:19 PM Long Li <lonuxli.64@gmail.com> wrote:
>
> kmalloc cannot allocate memory from HIGHMEM.  Allocating large amounts
> of memory currently bypasses the check and will simply leak the memory
> when page_address() returns NULL.  To fix this, factor the
> GFP_SLAB_BUG_MASK check out of slab & slub, and call it from
> kmalloc_order() as well. In order to make the code clear, the warning
> message is put in one place.
>
> Signed-off-by: Long Li <lonuxli.64@gmail.com>

Reviewed-by: Pekka Enberg <penberg@kernel.org>
