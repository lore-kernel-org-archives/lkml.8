Return-Path: <SRS0=BMk7=4P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12BA7C3F2C2
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 22:26:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E64A924697
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 22:26:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730196AbgB0W0a convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 17:26:30 -0500
Received: from mail.fireflyinternet.com ([109.228.58.192]:52637 "EHLO
        fireflyinternet.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729718AbgB0W0a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 17:26:30 -0500
X-Default-Received-SPF: pass (skip=forwardok (res=PASS)) x-ip-name=78.156.65.138;
Received: from localhost (unverified [78.156.65.138]) 
        by fireflyinternet.com (Firefly Internet (M1)) with ESMTP (TLS) id 20377596-1500050 
        for multiple; Thu, 27 Feb 2020 22:26:02 +0000
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
To:     Josh Poimboeuf <jpoimboe@redhat.com>
From:   Chris Wilson <chris@chris-wilson.co.uk>
In-Reply-To: <ed52cfb852d2772bf20f48614d75f1d1b1451995.1582841072.git.jpoimboe@redhat.com>
Cc:     linux-kernel@vger.kernel.org, Randy Dunlap <rdunlap@infradead.org>,
        Peter Zijlstra <peterz@infradead.org>,
        intel-gfx@lists.freedesktop.org
References: <ed52cfb852d2772bf20f48614d75f1d1b1451995.1582841072.git.jpoimboe@redhat.com>
Message-ID: <158284236096.19174.6917853940060252533@skylake-alporthouse-com>
User-Agent: alot/0.6
Subject: Re: [PATCH] drm/i915: Minimize uaccess exposure in
 i915_gem_execbuffer2_ioctl()
Date:   Thu, 27 Feb 2020 22:26:00 +0000
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Josh Poimboeuf (2020-02-27 22:08:26)
> With CONFIG_CC_OPTIMIZE_FOR_SIZE, objtool reports:
> 
>   drivers/gpu/drm/i915/gem/i915_gem_execbuffer.o: warning: objtool: i915_gem_execbuffer2_ioctl()+0x5b7: call to gen8_canonical_addr() with UACCESS enabled
> 
> This means i915_gem_execbuffer2_ioctl() is calling gen8_canonical_addr()
> -- and indirectly, sign_extend64() -- from the user_access_begin/end
> critical region (i.e, with SMAP disabled).
> 
> While it's probably harmless in this case, in general we like to avoid
> extra function calls in SMAP-disabled regions because it can open up
> inadvertent security holes.
> 
> Fix it by moving the gen8_canonical_addr() conversion to a separate loop
> before user_access_begin() is called.
> 
> Note that gen8_canonical_addr() is now called *before* masking off the
> PIN_OFFSET_MASK bits.  That should be ok because it just does a sign
> extension and ignores the masked lower bits anyway.
> 
> Reported-by: Randy Dunlap <rdunlap@infradead.org>
> Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
> ---
>  drivers/gpu/drm/i915/gem/i915_gem_execbuffer.c | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/i915/gem/i915_gem_execbuffer.c b/drivers/gpu/drm/i915/gem/i915_gem_execbuffer.c
> index d5a0f5ae4a8b..183cab13e028 100644
> --- a/drivers/gpu/drm/i915/gem/i915_gem_execbuffer.c
> +++ b/drivers/gpu/drm/i915/gem/i915_gem_execbuffer.c
> @@ -2947,6 +2947,13 @@ i915_gem_execbuffer2_ioctl(struct drm_device *dev, void *data,
>                         u64_to_user_ptr(args->buffers_ptr);
>                 unsigned int i;
>  
> +               /*
> +                * Do the call to gen8_canonical_addr() outside the
> +                * uaccess-enabled region to minimize uaccess exposure.
> +                */
> +               for (i = 0; i < args->buffer_count; i++)
> +                       exec2_list[i].offset = gen8_canonical_addr(exec2_list[i].offset);


Another loop over all the objects, where we intentionally try and skip
unmodified entries? To save 2 instructions from inside the second loop?

Colour me skeptical.
-Chris
