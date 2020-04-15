Return-Path: <SRS0=pNjS=57=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8845C2BA19
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 18:08:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7FCE4206D5
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 18:08:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DzHggght"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2411698AbgDOSIQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Apr 2020 14:08:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2405877AbgDOSIK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 14:08:10 -0400
Received: from mail-oi1-x242.google.com (mail-oi1-x242.google.com [IPv6:2607:f8b0:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66089C061A0E
        for <linux-kernel@vger.kernel.org>; Wed, 15 Apr 2020 11:08:10 -0700 (PDT)
Received: by mail-oi1-x242.google.com with SMTP id r25so4416670oij.4
        for <linux-kernel@vger.kernel.org>; Wed, 15 Apr 2020 11:08:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Hj+w2b8MlzXiZplgu3jb4eTtjZmFrNnBBz27RkzElPo=;
        b=DzHggghtb9lsQ0Q5rBTqUiusLkpGRDErRwTCQaNB7sZoQf5TAYp0xUiSksirx/4JsR
         m7Apwvq72YGO9sUcFLt6/dyDGwdBmW2m2599IIObTzfKOD0FDWT6kbJ+ekPD6sXSG2xf
         AVP4hGdSZeM5wQ4RHQ5dfxMHkcYaboDyrJO1L8M3CiVBb4n12/jlgzn+zg4tuVPI8vZt
         eyDJmgSj0sCige7YQ6ntjy35dEfEh5FsmqVl0Miqj7owZ49B+kREg/rLwtz/zlj80g++
         glY+vLySWV0GRC0blaC7+OKeq+DDghUZ4SYNDZlxXkMNvRyrbBHg10WQPxiR8JKOmgbF
         bJeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Hj+w2b8MlzXiZplgu3jb4eTtjZmFrNnBBz27RkzElPo=;
        b=n/jNne4KxGkL6T/F41zX4kQSpnaO7SCIKga8ee9fRzQZKRyx7PZphhzeqqoeVtf5g/
         r7WmNUXOPUckuh1jj+ZcGdkYFG8VKrb+p8LloX+0i5WzoI+58M+zjU1tc+kGG3Hf2LBP
         Km8oQY8D2quWjVYhitz3nZT5WeGCD15oS903GfdllTzFhnwX03imj7bakrMdXTTx9joj
         fsaGcpT36lO8kAnj/EDsA3VyZXKHp5DCdTu2KuzSADU/rHb/RK+hOnBNKHzqYPljrlKc
         ZrHgyc5KbSzVamqL/W9tc1MDrYY3nWPqtgjJm7wGhMoL3B1tEQ98b8hb6Hc39mHE29Tn
         P9QA==
X-Gm-Message-State: AGi0PuarF9dgyn/lH48BFXi0rD1jdldSU4AqECuZw1vILgba8MYHYsFu
        v2PrVgqPl72Rx2npTeXDzJJWQOEFmSvmENKdJp5khg==
X-Google-Smtp-Source: APiQypLxNn+xKlz0LPCMbXE2SC11pDSOPtYcU6PNJY5ioAXG6B9257iqvNLz+mr50JDvbTk8i5s8S9BNWoZ5hgkfMHo=
X-Received: by 2002:a05:6808:4e:: with SMTP id v14mr385130oic.70.1586974089086;
 Wed, 15 Apr 2020 11:08:09 -0700 (PDT)
MIME-Version: 1.0
References: <202004151054.BD695840@keescook>
In-Reply-To: <202004151054.BD695840@keescook>
From:   Marco Elver <elver@google.com>
Date:   Wed, 15 Apr 2020 20:07:57 +0200
Message-ID: <CANpmjNPORrwPkqByhtKgVoh5=KHkpYHM0zRv6O1RgONmx3ZqOg@mail.gmail.com>
Subject: Re: [PATCH] slub: Avoid redzone when choosing freepointer location
To:     Kees Cook <keescook@chromium.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 15 Apr 2020 at 19:55, Kees Cook <keescook@chromium.org> wrote:
>
> Marco Elver reported system crashes when booting with "slub_debug=Z".
> The freepointer location (s->offset) was not taking into account that
> the "inuse" size that includes the redzone area should not be used by
> the freelist pointer. Change the calculation to save the area of the
> object that an inline freepointer may be written into.
>
> Reported-by: Marco Elver <elver@google.com>
> Link: https://lore.kernel.org/linux-mm/20200415164726.GA234932@google.com
> Fixes: 3202fa62fb43 ("slub: relocate freelist pointer to middle of object")
> Signed-off-by: Kees Cook <keescook@chromium.org>

Works for me, thank you!

Tested-by: Marco Elver <elver@google.com>

> ---
>  mm/slub.c | 12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)
>
> diff --git a/mm/slub.c b/mm/slub.c
> index 332d4b459a90..9bf44955c4f1 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -3533,6 +3533,7 @@ static int calculate_sizes(struct kmem_cache *s, int forced_order)
>  {
>         slab_flags_t flags = s->flags;
>         unsigned int size = s->object_size;
> +       unsigned int freepointer_area;
>         unsigned int order;
>
>         /*
> @@ -3541,6 +3542,13 @@ static int calculate_sizes(struct kmem_cache *s, int forced_order)
>          * the possible location of the free pointer.
>          */
>         size = ALIGN(size, sizeof(void *));
> +       /*
> +        * This is the area of the object where a freepointer can be
> +        * safely written. If redzoning adds more to the inuse size, we
> +        * can't use that portion for writing the freepointer, so
> +        * s->offset must be limited within this for the general case.
> +        */
> +       freepointer_area = size;
>
>  #ifdef CONFIG_SLUB_DEBUG
>         /*
> @@ -3582,13 +3590,13 @@ static int calculate_sizes(struct kmem_cache *s, int forced_order)
>                  */
>                 s->offset = size;
>                 size += sizeof(void *);
> -       } else if (size > sizeof(void *)) {
> +       } else if (freepointer_area > sizeof(void *)) {
>                 /*
>                  * Store freelist pointer near middle of object to keep
>                  * it away from the edges of the object to avoid small
>                  * sized over/underflows from neighboring allocations.
>                  */
> -               s->offset = ALIGN(size / 2, sizeof(void *));
> +               s->offset = ALIGN(freepointer_area / 2, sizeof(void *));
>         }
>
>  #ifdef CONFIG_SLUB_DEBUG
> --
> 2.20.1
>
>
> --
> Kees Cook
