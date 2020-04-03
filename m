Return-Path: <SRS0=4r1w=5T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 332BDC43331
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 08:29:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0642B20721
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 08:29:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="AePlV6cv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390157AbgDCI3G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Apr 2020 04:29:06 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:44830 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727835AbgDCI3F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Apr 2020 04:29:05 -0400
Received: by mail-ot1-f67.google.com with SMTP id a49so6412122otc.11
        for <linux-kernel@vger.kernel.org>; Fri, 03 Apr 2020 01:29:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=02Izn5NIEOgQ17Wwu9B2nDjWYnskhkbWYrLbCws9cys=;
        b=AePlV6cvRFaia2Flr22OaglBCSan4Fn1fu1TjdH+PdqjokxAikNigzQZUfp4HAtll6
         YGMdl+BcQ1Graq9IqqFvdG6d375dVL46YFsYvHdO39lzISMurfDlqYGtDvDCsUlXkMqv
         sssHVyogZ9QM32uJngkP6RMbY0sg1Hsp8mtmI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=02Izn5NIEOgQ17Wwu9B2nDjWYnskhkbWYrLbCws9cys=;
        b=LiLYsy3Zf3xBtg1qZeuZxXRKNF7QdS+P0JnEIj+/XjvLGmlSLAUfVzKG2KI6ZCZkMo
         uCAkmgS0ilWbRIyvu+2KYVxnZ13YFpqKqQzQTgaWbmZgUA834Jax6mJx5c6HEazXVL9v
         B9iS2VjiAtmeUR5S4UGqHXiQcSPWT1t2p5MWN+eSXXKHi6fmwqSz2m+rGMoCVqIgqv+u
         PxJnBcvPMoyTjaDHF6LQz6oGHGdrgdWdwmC8z+STUuHVKuZs6oCcEp5qpz23NRk75by/
         heaYFUKrxNElV+uX5NvB8dCbH4vhIRB+6Mb5te013lTMKeF1V8Vzu4ceCsRbgbPU02Vs
         OjUg==
X-Gm-Message-State: AGi0PuYxkznrXsnxZCyYtiQRs/28dSPEFRtE4wLE0vTBpMqrcRsFcSBF
        48f3+XH6C46sZ13AQheLsj5M+cBh16JdtxRQpLXCzw==
X-Google-Smtp-Source: APiQypJyeKCFnlQPk1pGtIlyDJ5aPoiQwEGi4t/hFFgGBNvUJhvcbzE54yJz9hoZgKP2mj2jINCfs30xT8u1zpxIb0w=
X-Received: by 2002:a4a:c819:: with SMTP id s25mr5852558ooq.6.1585902543776;
 Fri, 03 Apr 2020 01:29:03 -0700 (PDT)
MIME-Version: 1.0
References: <20200402203317.GA34560@ubuntu-m2-xlarge-x86> <20200402215926.30714-1-chris@chris-wilson.co.uk>
 <20200403013420.GA11516@ubuntu-m2-xlarge-x86>
In-Reply-To: <20200403013420.GA11516@ubuntu-m2-xlarge-x86>
From:   Daniel Vetter <daniel@ffwll.ch>
Date:   Fri, 3 Apr 2020 10:28:52 +0200
Message-ID: <CAKMK7uE9pv23edViQBC=Jy5fQV=-NQTNdk1qi91Z8shpeuL7FA@mail.gmail.com>
Subject: Re: [PATCH] drm/legacy: Fix type for drm_local_map.offset
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     Chris Wilson <chris@chris-wilson.co.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 3, 2020 at 8:54 AM Nathan Chancellor
<natechancellor@gmail.com> wrote:
>
> On Thu, Apr 02, 2020 at 10:59:26PM +0100, Chris Wilson wrote:
> > drm_local_map.offset is not only used for resource_size_t but also
> > dma_addr_t which may be of different sizes.
> >
> > Reported-by: Nathan Chancellor <natechancellor@gmail.com>
> > Fixes: 8e4ff9b56957 ("drm: Remove the dma_alloc_coherent wrapper for internal usage")
> > Signed-off-by: Chris Wilson <chris@chris-wilson.co.uk>
> > Cc: Dave Airlie <airlied@gmail.com>
> > Cc: Nathan Chancellor <natechancellor@gmail.com>
> > Cc: Linus Torvalds <torvalds@linux-foundation.org>
> > ---
> >  include/drm/drm_legacy.h | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/include/drm/drm_legacy.h b/include/drm/drm_legacy.h
> > index dcef3598f49e..aed382c17b26 100644
> > --- a/include/drm/drm_legacy.h
> > +++ b/include/drm/drm_legacy.h
> > @@ -136,7 +136,7 @@ struct drm_sg_mem {
> >   * Kernel side of a mapping
> >   */
> >  struct drm_local_map {
> > -     resource_size_t offset;  /**< Requested physical address (0 for SAREA)*/
> > +     dma_addr_t offset;       /**< Requested physical address (0 for SAREA)*/
> >       unsigned long size;      /**< Requested physical size (bytes) */
> >       enum drm_map_type type;  /**< Type of memory to map */
> >       enum drm_map_flags flags;        /**< Flags */
> > --
> > 2.20.1
> >
>
> Thanks for the quick fix!
>
> I ran it through my set of build tests and nothing else seems to have
> broken (at least not any more than it already is...).
>
> Tested-by: Nathan Chancellor <natechancellor@gmail.com> # build

This works too, missed it when replying to Linus

Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>

Linux I guess this one is better, but like I explained it really
doesn't matter what we do with drm legacy code, it's a horror show
that should be disabled on all modern distros anyway. We just keep it
because of "never break old uapi". Maybe in a few years more ...
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
+41 (0) 79 365 57 48 - http://blog.ffwll.ch
