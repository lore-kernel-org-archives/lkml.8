Return-Path: <SRS0=RI2K=4Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8E93C3F2C6
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 01:03:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD241246A6
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 01:03:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CgQFtkvj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730389AbgB1BDy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 20:03:54 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:34142 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729984AbgB1BDy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 20:03:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1582851831;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=hRN8eHua6qZxJSEBJTd7eqSNMS3wRQFEAkDzQ0pIXII=;
        b=CgQFtkvjAN7yJSlF6N6YGFFYto3ErZgp6bU8v/tKbSGRLcrmdIUIXdM5NAY/jkZqF89FAy
        da6uFRlTrZIGfnlW2+14egQH34K6BLaWU5k+HWiWG8mgy8G3Qcl6J7E+Xq/CZGjcavlswE
        DqQTdQtydexWw7+9mhDZHxH6ZT6Lbl8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-26-CaWvg9btMe-Ck7SyAYdSsw-1; Thu, 27 Feb 2020 20:03:47 -0500
X-MC-Unique: CaWvg9btMe-Ck7SyAYdSsw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id ECF09107ACC7;
        Fri, 28 Feb 2020 01:03:45 +0000 (UTC)
Received: from treble (ovpn-121-128.rdu2.redhat.com [10.10.121.128])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id DCABD60C18;
        Fri, 28 Feb 2020 01:03:44 +0000 (UTC)
Date:   Thu, 27 Feb 2020 19:03:42 -0600
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Chris Wilson <chris@chris-wilson.co.uk>,
        linux-kernel@vger.kernel.org, Randy Dunlap <rdunlap@infradead.org>,
        Peter Zijlstra <peterz@infradead.org>,
        intel-gfx@lists.freedesktop.org
Subject: Re: [PATCH] drm/i915: Minimize uaccess exposure in
 i915_gem_execbuffer2_ioctl()
Message-ID: <20200228010342.3j3awgvvgvitif7z@treble>
References: <ed52cfb852d2772bf20f48614d75f1d1b1451995.1582841072.git.jpoimboe@redhat.com>
 <20200227223542.GE23230@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200227223542.GE23230@ZenIV.linux.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 27, 2020 at 10:35:42PM +0000, Al Viro wrote:
> On Thu, Feb 27, 2020 at 04:08:26PM -0600, Josh Poimboeuf wrote:
> > With CONFIG_CC_OPTIMIZE_FOR_SIZE, objtool reports:
> > 
> >   drivers/gpu/drm/i915/gem/i915_gem_execbuffer.o: warning: objtool: i915_gem_execbuffer2_ioctl()+0x5b7: call to gen8_canonical_addr() with UACCESS enabled
> > 
> > This means i915_gem_execbuffer2_ioctl() is calling gen8_canonical_addr()
> > -- and indirectly, sign_extend64() -- from the user_access_begin/end
> > critical region (i.e, with SMAP disabled).
> > 
> > While it's probably harmless in this case, in general we like to avoid
> > extra function calls in SMAP-disabled regions because it can open up
> > inadvertent security holes.
> > 
> > Fix it by moving the gen8_canonical_addr() conversion to a separate loop
> > before user_access_begin() is called.
> > 
> > Note that gen8_canonical_addr() is now called *before* masking off the
> > PIN_OFFSET_MASK bits.  That should be ok because it just does a sign
> > extension and ignores the masked lower bits anyway.
> 
> How painful would it be to inline the damn thing?
> <looks>
> static inline u64 gen8_canonical_addr(u64 address)
> {
>         return sign_extend64(address, GEN8_HIGH_ADDRESS_BIT);
> }
> static inline __s64 sign_extend64(__u64 value, int index)
> {
>         __u8 shift = 63 - index;
>         return (__s64)(value << shift) >> shift;
> }
> 
> What the hell?  Josh, what kind of .config do you have that these are
> _not_ inlined?

I think this was seen with CONFIG_CC_OPTIMIZE_FOR_SIZE, which tends to
ignore inline.

> And why not mark gen8_canonical_addr() __always_inline?

Right, marking those two functions as __always_inline is the other
option.  The problem is, if you keep doing it, eventually you end up
with __always_inline-itis spreading all over the place.  And it affects
all the other callers, at least in the CONFIG_CC_OPTIMIZE_FOR_SIZE case.
At least this fix is localized.

But I agree my patch isn't ideal either.

-- 
Josh

