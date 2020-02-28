Return-Path: <SRS0=RI2K=4Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26B20C3F2CD
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 16:10:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E462D2072A
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 16:10:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FZxR9CFN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726063AbgB1QKt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Feb 2020 11:10:49 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:45868 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725827AbgB1QKt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Feb 2020 11:10:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1582906248;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=TJIuVNRW5GZyI5ESRQqaE219pUI93KEK2zERenrB4AE=;
        b=FZxR9CFN4a0F2DDMdCkkx6M7/r2wJmilmrTGjl3IDTfFXZMoQy4A43JCEgNQYjjB937G71
        NFpHemGf7fOKxfFe6vGQuJT59+yDuveA9tizRyhbY8TGOZS6zpED+JR6hC9zqOolFTgHKt
        ktTQnIbrfSzrEiE3G4oIr3TEhK3ny58=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-123-W0Pkfu7KMp2rwgHvaJxNmQ-1; Fri, 28 Feb 2020 11:10:46 -0500
X-MC-Unique: W0Pkfu7KMp2rwgHvaJxNmQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A884C100550E;
        Fri, 28 Feb 2020 16:10:44 +0000 (UTC)
Received: from treble (ovpn-121-128.rdu2.redhat.com [10.10.121.128])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id D20735DA2C;
        Fri, 28 Feb 2020 16:10:43 +0000 (UTC)
Date:   Fri, 28 Feb 2020 10:10:41 -0600
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Chris Wilson <chris@chris-wilson.co.uk>
Cc:     linux-kernel@vger.kernel.org, Randy Dunlap <rdunlap@infradead.org>,
        Peter Zijlstra <peterz@infradead.org>,
        intel-gfx@lists.freedesktop.org
Subject: Re: [PATCH] drm/i915: Minimize uaccess exposure in
 i915_gem_execbuffer2_ioctl()
Message-ID: <20200228161041.ov7d5ox7myrnr4gi@treble>
References: <ed52cfb852d2772bf20f48614d75f1d1b1451995.1582841072.git.jpoimboe@redhat.com>
 <158284236096.19174.6917853940060252533@skylake-alporthouse-com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <158284236096.19174.6917853940060252533@skylake-alporthouse-com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 27, 2020 at 10:26:00PM +0000, Chris Wilson wrote:
> > --- a/drivers/gpu/drm/i915/gem/i915_gem_execbuffer.c
> > +++ b/drivers/gpu/drm/i915/gem/i915_gem_execbuffer.c
> > @@ -2947,6 +2947,13 @@ i915_gem_execbuffer2_ioctl(struct drm_device *dev, void *data,
> >                         u64_to_user_ptr(args->buffers_ptr);
> >                 unsigned int i;
> >  
> > +               /*
> > +                * Do the call to gen8_canonical_addr() outside the
> > +                * uaccess-enabled region to minimize uaccess exposure.
> > +                */
> > +               for (i = 0; i < args->buffer_count; i++)
> > +                       exec2_list[i].offset = gen8_canonical_addr(exec2_list[i].offset);
> 
> 
> Another loop over all the objects, where we intentionally try and skip
> unmodified entries? To save 2 instructions from inside the second loop?
> 
> Colour me skeptical.

So are you're saying these arrays can be large and that you have
performance concerns?

-- 
Josh

